local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local templates = addon.templates

local band = bit.band
local CombatLog_Object_IsA = CombatLog_Object_IsA
local IsSpellKnown = IsSpellKnown
local UnitAura = UnitAura

local COMBATLOG_FILTER_ME = COMBATLOG_FILTER_ME

-- mobs whose received hits won't be tracked due to various vulnerabilities
local specialMobs = {
	[12460] = true,	-- Death Talon Wyrmguard
	[12461] = true,	-- Death Talon Overseer
	[14020] = true,	-- Chromaggus
	[15339] = true,	-- Ossirian the Unscarred
	[15928] = true,	-- Thaddius
	[16803] = true, -- Death Knight Understudy
	[22841] = true,	-- Shade of Akama
	[33329] = true, -- Heart of the Deconstructor
	[33670] = true, -- Aerial Command Unit
	[34496] = true, -- Eydis Darkbane
	[34497] = true, -- Fjola Lightbane
	[38567] = true, -- Phantom Hallucination
	[42347] = true, -- Exposed Head of Magmaw ?
	[42803] = true, -- Drakeadon Mongrel
	[46083] = true, -- Drakeadon Mongrel
	[46273] = true, -- Debilitated Apexar
	[48270] = true, -- Exposed Head of Magmaw
	[52155] = true, -- High Priest Venoxis
}

-- auras that when gained will suppress record tracking
local specialAuras = {
	[18173] = true,	-- Burning Adrenaline (Vaelastrasz the Corrupt)
	[24378] = true, -- Berserking (battlegrounds)
	[41337] = true,	-- Aura of Anger (Reliquary of Souls)
	[41350] = true,	-- Aura of Desire (Reliquary of Souls)
	[44335] = true,	-- Energy Feedback (Vexallus)
	[44406] = true,	-- Energy Infusion (Vexallus)
	[53642] = true,	-- Might of Mograine (Light's Hope Chapel)
	[55849] = true,	-- Power Spark (Malygos)
	[56330] = true,	-- Iron's Bane (Storm Peaks quest)
	[56648] = true,	-- Potent Fungus (Amanitar)
	[57524] = true, -- Metanoia (Valkyrion Aspirant)
	[58026] = true,	-- Blessing of the Crusade (Icecrown quest)
	[58361] = true,	-- Might of Mograine (Patchwerk)
	[58549] = true,	-- Tenacity (Lake Wintergrasp)
	[59641] = true,	-- Warchief's Blessing (The Battle For The Undercity)
	[60964] = true,	-- Strength of Wrynn (The Battle For The Undercity)
	[61888] = true, -- Overwhelming Power (Assembly of Iron 25)
	[62243] = true, -- Unstable Sun Beam (Elder Brightleaf)
	[62650] = true, -- Fortitude of Frost (Yogg-Saron)
	[62670] = true, -- Resilience of Nature (Yogg-Saron)
	[62671] = true, -- Speed of Invention (Yogg-Saron)
	[62702] = true, -- Fury of the Storm (Yogg-Saron)
	[63277] = true, -- Shadow Crash (General Vezax)
	[63711] = true, -- Storm Power (Hodir 10)
	[64320] = true, -- Rune of Power (Assembly of Iron)
	[64321] = true, -- Potent Pheromones (Freya)
	[64637] = true, -- Overwhelming Power (Assembly of Iron 10)
	[65134] = true, -- Storm Power (Hodir 25)
	[70867] = true, -- Essence of the Blood Queen (Blood Queen Lana'thel)
	[70879] = true, -- Essence of the Blood Queen (Blood Queen Lana'thel, bitten by a player)
	[72219] = true, -- Gastric Bloat (Festergut)
	[73822] = true, -- Hellscream's Warsong (Icecrown Citadel)
	[73828] = true, -- Strength of Wrynn (Icecrown Citadel) 
	[76133] = true, -- Tidal Surge (Neptulon)
	[76155] = true, -- Tidal Surge (Neptulon)
	[76159] = true, -- Pyrogenics (Sun-Touched Spriteling)
	[76355] = true, -- Blessing of the Sun (Rajh)
	[76693] = true, -- Empowering Twilight (Crimsonborne Warlord)
	[79624] = true, -- Power Generator (Arcanotron) ?
	[79629] = true, -- Power Generator (Arcanotron 10)
	[81096] = true, -- Red Mist (Red Mist)
	[82170] = true, -- Corruption: Absolute (Cho'gall)
	[86622] = true, -- Engulfing Magic (Theralion) ?
	[86872] = true, -- Frothing Rage (Thundermar Ale)
	[89879] = true, -- Blessing of the Sun (Rajh heroic)
	[90932] = true, -- Ragezone (Defias Blood Wizard)
	[90933] = true, -- Ragezone (Defias Blood Wizard heroic)
	[91871] = true, -- Lightning Charge (Siamat)
	[91555] = true, -- Power Generator (Arcanotron 25)
	[93777] = true, -- Invocation of Flame (Skullcrusher the Mountain)
	[95639] = true, -- Engulfing Magic (Theralion) ?
	[95640] = true, -- Engulfing Magic (Theralion) ?
	[95641] = true, -- Engulfing Magic (Theralion) ?
	[96493] = true, -- Spirit's Vengeance (Bloodlord Mandokir)
}

-- these are auras that increases the target's damage or healing received
local targetAuras = {
	[64436] = true, -- Magnetic Core (Aerial Command Unit) ?
	[65280] = true, -- Singed (Hodir)
	[66758] = true, -- Staggered Daze (Icehowl) ?
	[75664] = true, -- Shadow Gale (Erudax) ?
	[75846] = true, -- Superheated Quicksilver Armor (Karsh Steelbender) ?
	[76015] = true, -- Superheated Quicksilver Armor (Karsh Steelbender) ?
	[76232] = true, -- Storm's Fury (Ragnaros - Mount Hyjal) ?
	[77615] = true, -- Debilitating Slime (Maloriak)
	[77717] = true, -- Vertigo (Atramedes 10)
	[80164] = true, -- Chemical Cloud (Toxitron)
	[87683] = true, -- Dragon's Vengeance (Halfus Wyrmbreaker)
	[87904] = true, -- Feedback (Al'Akir)
	[91086] = true, -- Shadow Gale (Erudax heroic)
	[91478] = true, -- Chemical Cloud (Toxitron 25) ?
	[92389] = true, -- Vertigo (Atramedes 25) ?
	[92390] = true, -- Vertigo (Atramedes) ?
	[92910] = true, -- Debilitating Slime (Maloriak) ?
	[93567] = true, -- Superheated Quicksilver Armor (Karsh Steelbender) ?
	[95723] = true, -- Storm's Fury (Ragnaros - Mount Hyjal) ?
	[97320] = true, -- Sunder Rift (Jin'do the Godbreaker)
}

-- these heals are treated as periodic, but has no aura associated with them, or is associated to an aura with a different name, need to add exceptions for them to filter properly
local directHoTs = {
	[54172] = true, -- Divine Storm
	-- [63106] = "Corruption", -- Siphon Life
}

local activeAuras = {
	player = {},
	pet = {},
}
local corruptSpells = {
	player = {},
	pet = {},
}
local corruptTargets = {}

-- amount of buttons in the spell, mob and aura filter scroll lists
local NUMSPELLBUTTONS = 8
local SPELLBUTTONHEIGHT = 22
local NUMFILTERBUTTONS = 10
local FILTERBUTTONHEIGHT = 16


local filters = templates:CreateConfigFrame(FILTERS, addonName, true)
filters:SetScript("OnEvent", function(self, event, ...)
	return self[event] and self[event](self, ...)
end)
addon.filters = filters


local function filterButtonOnClick(self)
	local module = self.module
	local scrollFrame = module.scrollFrame
	local offset = FauxScrollFrame_GetOffset(scrollFrame)
	local id = self:GetID()
	
	local selection = scrollFrame.selected
	if selection then
		if selection - offset == id then
			-- clicking the selected button, clear selection
			self:UnlockHighlight()
			selection = nil
		else
			-- clear selection if visible, and set new selection
			local prevHilite = scrollFrame.buttons[selection - offset]
			if prevHilite then
				prevHilite:UnlockHighlight()
			end
			self:LockHighlight()
			selection = id + offset
		end
	else
		-- no previous selection, just set new and lock highlight
		self:LockHighlight()
		selection = id + offset
	end
	
	-- enable/disable "Delete" button depending on if selection exists
	if selection then
		module.delete:Enable()
	else
		module.delete:Disable()
	end
	scrollFrame.selected = selection
end

-- template function for mob filter buttons
local function createFilterButton(parent)
	local btn = CreateFrame("Button", nil, parent)
	btn:SetHeight(FILTERBUTTONHEIGHT)
	btn:SetPoint("LEFT")
	btn:SetPoint("RIGHT")
	btn:SetNormalFontObject("GameFontNormal")
	btn:SetHighlightFontObject("GameFontHighlight")
	btn:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
	btn:SetPushedTextOffset(0, 0)
	btn:SetScript("OnClick", filterButtonOnClick)
	return btn
end

local function createFilterButtons(parent, onEnter)
	local buttons = {}
	for i = 1, NUMFILTERBUTTONS do
		local btn = createFilterButton(parent)
		if i == 1 then
			btn:SetPoint("TOP")
		else
			btn:SetPoint("TOP", buttons[i - 1], "BOTTOM")
		end
		btn:SetID(i)
		if onEnter then
			btn:SetScript("OnEnter", onEnter)
			btn:SetScript("OnLeave", GameTooltip_Hide)
		end
		btn.module = parent
		buttons[i] = btn
	end
	parent.scrollFrame.buttons = buttons
end

local function resetScroll(self)
	FauxScrollFrame_SetOffset(self, 0)
	self.scrollBar:SetValue(0)
	self:Update()
end

local function onVerticalScroll(self, offset)
	FauxScrollFrame_OnVerticalScroll(self, offset, self.buttonHeight, self.Update)
end

local function filterFrameOnShow(self)
	local scrollFrame = self.scrollFrame
	if scrollFrame.selected then
		local prevHilite = scrollFrame.buttons[scrollFrame.selected - FauxScrollFrame_GetOffset(scrollFrame)]
		if prevHilite then
			prevHilite:UnlockHighlight()
		end
		scrollFrame.selected = nil
		self.delete:Disable()
	end
end

local function addButtonOnClick(self)
	StaticPopup_Show(self.popup)
end

local function deleteButtonOnClick(self)
	local scrollFrame = self.scrollFrame
	local filterName = scrollFrame.filter
	local selection = scrollFrame.selected
	if selection then
		local filter = filters.db.global[filterName]
		local selectedEntry = filter[selection]
		tremove(filter, selection)
		local prevHighlight = scrollFrame.buttons[selection - FauxScrollFrame_GetOffset(scrollFrame)]
		if prevHighlight then
			prevHighlight:UnlockHighlight()
		end
		scrollFrame.selected = nil
		scrollFrame:Update()
		self:Disable()
		addon:Message(self.msg:format(GetSpellInfo(selectedEntry) or selectedEntry))
		if self.func then
			self.func(selectedEntry)
		end
	end
end

local function createFilterFrame(name, parent, numButtons, buttonHeight)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetHeight(numButtons * buttonHeight)
	parent[name] = frame

	local scrollName = "CritlineFilters"..name.."ScrollFrame"
	local scrollFrame = CreateFrame("ScrollFrame", scrollName, frame, "FauxScrollFrameTemplate")
	scrollFrame:SetAllPoints()
	scrollFrame:SetScript("OnShow", resetScroll)
	scrollFrame:SetScript("OnVerticalScroll", onVerticalScroll)
	scrollFrame.scrollBar = _G[scrollName.."ScrollBar"]
	scrollFrame.buttons = frame.buttons
	scrollFrame.numButtons = numButtons
	scrollFrame.buttonHeight = buttonHeight
	scrollFrame.filter = name
	frame.scrollFrame = scrollFrame
	
	if name ~= "spell" then
		frame:SetScript("OnShow", filterFrameOnShow)

		local add = templates:CreateButton(frame)
		add:SetScript("OnClick", addButtonOnClick)
		frame.add = add

		local delete = templates:CreateButton(frame)
		delete:Disable()
		delete:SetScript("OnClick", deleteButtonOnClick)
		delete.scrollFrame = scrollFrame
		frame.delete = delete
	end
	
	return frame
end


do
	local options = {}
	filters.options = options

	local checkButtons = {
		{
			text = L["Filter new spells"],
			tooltipText = L["Enable to filter out new spell entries by default."],
			setting = "filterNew",
		},
		{
			text = L["Ignore mob filter"],
			tooltipText = L["Enable to ignore integrated mob filter."],
			setting = "ignoreMobFilter",
		},
		{
			text = L["Ignore aura filter"],
			tooltipText = L["Enable to ignore integrated aura filter."],
			setting = "ignoreAuraFilter",
		},
		{
			text = L["Only known spells"],
			tooltipText = L["Enable to ignore spells that are not in your (or your pet's) spell book."],
			setting = "onlyKnown",
		},
		{
			text = L["Suppress mind control"],
			tooltipText = L["Suppress all records while mind controlled."],
			setting = "suppressMC",
			newColumn = true,
		},
		{
			text = L["Don't filter magic"],
			tooltipText = L["Enable to let magical damage ignore the level filter."],
			setting = "dontFilterMagic",
		},
	}

	options.checkButtons = checkButtons
	
	local columnEnd = #checkButtons

	for i, v in ipairs(checkButtons) do
		local btn = templates:CreateCheckButton(filters, v)
		if i == 1 then
			btn:SetPoint("TOPLEFT", filters.title, "BOTTOMLEFT", -2, -16)
		elseif btn.newColumn then
			btn:SetPoint("TOPLEFT", filters.title, "BOTTOM", 0, -16)
			columnEnd = i - 1
		else
			btn:SetPoint("TOP", checkButtons[i - 1], "BOTTOM", 0, -8)
		end
		btn.module = filters
		checkButtons[i] = btn
	end
	
	local slider = templates:CreateSlider(filters, {
		text = L["Level filter"],
		tooltipText = L["If level difference between you and the target is greater than this setting, records will not be registered."],
		minValue = -1,
		maxValue = 10,
		valueStep = 1,
		minText = OFF,
		maxText = 10,
		func = function(self)
			local value = self:GetValue()
			self.value:SetText(value == -1 and OFF or value)
			filters.profile.levelFilter = value
		end,
	})
	slider:SetPoint("TOPLEFT", checkButtons[#checkButtons], "BOTTOMLEFT", 4, -24)
	options.slider = slider
	
	local filterTypes = {}

	-- spell filter frame
	local spellFilter = createFilterFrame("spell", filters, NUMSPELLBUTTONS, SPELLBUTTONHEIGHT)
	spellFilter:SetPoint("TOP", checkButtons[columnEnd], "BOTTOM", 0, -48)
	spellFilter:SetPoint("LEFT", 48, 0)
	spellFilter:SetPoint("RIGHT", -48, 0)
	filterTypes.spell = spellFilter
	
	do	-- spell filter buttons
		local function spellButtonOnClick(self)
			local checked = self:GetChecked() == 1
			PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
			filters:FilterSpell(not checked, filters.spell.tree:GetSelectedValue(), self.data)
		end
		
		local function spellButtonOnEnter(self)
			-- prevent records being added twice
			GameTooltip.Critline = true
			GameTooltip:SetOwner(self, "ANCHOR_LEFT")
			GameTooltip:SetSpellByID(self.data.spellID)
			GameTooltip:AddLine(" ")
			addon:AddTooltipLine(self.data)
			GameTooltip:Show()
		end
		
		local buttons = {}
		for i = 1, NUMSPELLBUTTONS do
			local btn = templates:CreateCheckButton(spellFilter)
			if i == 1 then
				btn:SetPoint("TOPLEFT")
			else
				btn:SetPoint("TOP", buttons[i - 1], "BOTTOM", 0, 4)
			end
			btn:SetScript("OnClick", spellButtonOnClick)
			btn:SetScript("OnEnter", spellButtonOnEnter)
			buttons[i] = btn
		end
		spellFilter.scrollFrame.buttons = buttons
	end
	
	-- spell filter scroll frame
	local spellScrollFrame = spellFilter.scrollFrame

	-- spell filter tree dropdown
	local menu = {
		{text = L["Damage"],	value = "dmg"},
		{text = L["Healing"],	value = "heal"},
		{text = L["Pet"],		value = "pet"},
	}

	local spellFilterTree = templates:CreateDropDownMenu("CritlineSpellFilterTree", spellFilter, menu)
	spellFilterTree:SetFrameWidth(120)
	spellFilterTree:SetPoint("BOTTOMRIGHT", spellFilter, "TOPRIGHT", 16, 0)
	spellFilterTree:SetSelectedValue("dmg")
	spellFilterTree.onClick = function(self)
		self.owner:SetSelectedValue(self.value)
		FauxScrollFrame_SetOffset(spellScrollFrame, 0)
		spellScrollFrame.scrollBar:SetValue(0)
		spellScrollFrame:Update()
	end
	spellFilter.tree = spellFilterTree
	spellScrollFrame.tree = spellFilter.tree
	
	do	-- mob filter frame
		local mobFilter = createFilterFrame("mobs", filters, NUMFILTERBUTTONS, FILTERBUTTONHEIGHT)
		mobFilter:SetPoint("TOP", spellFilter)
		mobFilter:SetPoint("LEFT", spellFilter)
		mobFilter:SetPoint("RIGHT", spellFilter)
		mobFilter:Hide()
		filterTypes.mobs = mobFilter
		
		createFilterButtons(mobFilter)
		
		local addTarget = templates:CreateButton(mobFilter)
		addTarget:SetSize(96, 22)
		addTarget:SetPoint("TOPLEFT", mobFilter, "BOTTOMLEFT", 0, -8)
		addTarget:SetText(L["Add target"])
		addTarget:SetScript("OnClick", function()
			local targetName = UnitName("target")
			if targetName then
				-- we don't want to add PCs to the filter
				if UnitIsPlayer("target") then
					addon:Message(L["Cannot add players to mob filter."])
				else
					filters:AddMob(targetName)
				end
			else
				addon:Message(L["No target selected."])
			end
		end)
		
		local add = mobFilter.add
		add:SetSize(96, 22)
		add:SetPoint("TOP", mobFilter, "BOTTOM", 0, -8)
		add:SetText(L["Add by name"])
		add.popup = "CRITLINE_ADD_MOB_BY_NAME"
		
		local delete = mobFilter.delete
		delete:SetSize(96, 22)
		delete:SetPoint("TOPRIGHT", mobFilter, "BOTTOMRIGHT", 0, -8)
		delete:SetText(L["Delete mob"])
		delete.msg = L["%s removed from mob filter."]
	end
	
	do	-- aura filter frame
		local auraFilter = createFilterFrame("auras", filters, NUMFILTERBUTTONS, FILTERBUTTONHEIGHT)
		auraFilter:SetPoint("TOP", spellFilter)
		auraFilter:SetPoint("LEFT", spellFilter)
		auraFilter:SetPoint("RIGHT", spellFilter)
		auraFilter:Hide()
		filterTypes.auras = auraFilter

		createFilterButtons(auraFilter, function(self)
			GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
			GameTooltip:SetHyperlink("spell:"..self.spellID)
		end)
		
		local add = auraFilter.add
		add:SetSize(128, 22)
		add:SetPoint("TOPLEFT", auraFilter, "BOTTOMLEFT", 0, -8)
		add:SetText(L["Add by spell ID"])
		add.popup = "CRITLINE_ADD_AURA_BY_ID"
		
		-- local addAura = templates:CreateButton(auraFilter)
		-- addAura:SetSize(48, 22)
		-- addAura:SetPoint("TOP", auraFilter, "BOTTOM")
		-- addAura:SetText("Add")
		-- addAura:SetScript("OnClick", function() if auraList:IsShown() then auraList:Hide() else auraList:Show() end end)

		local delete = auraFilter.delete
		delete:SetSize(128, 22)
		delete:SetPoint("TOPRIGHT", auraFilter, "BOTTOMRIGHT", 0, -8)
		delete:SetText(L["Delete aura"])
		delete.msg = L["%s removed from aura filter."]
		delete.func = function(spellID)
			activeAuras.player[spellID] = nil
			activeAuras.pet[spellID] = nil
			if not filters:IsEmpowered("player") then
				addon:Debug("No filtered aura detected on player. Resuming record tracking.")
			end
			if not filters:IsEmpowered("pet") then
				addon:Debug("No filtered aura detected on pet. Resuming record tracking.")
			end
		end
	end
	
	do	-- filter tree dropdown
		local menu = {
			{
				text = L["Spell filter"],
				value = "spell",
			},
			{
				text = L["Mob filter"],
				value = "mobs",
			},
			{
				text = L["Aura filter"],
				value = "auras",
			},
		}
		
		local filterType = templates:CreateDropDownMenu("CritlineFilterType", filters, menu)
		filterType:SetPoint("BOTTOMLEFT", spellFilter, "TOPLEFT", -16, 0)
		filterType:SetFrameWidth(120)
		filterType:SetSelectedValue("spell")
		filterType.onClick = function(self)
			self.owner:SetSelectedValue(self.value)
			for k, v in pairs(filterTypes) do
				if k == self.value then
					v:Show()
				else
					v:Hide()
				end
			end
		end
		filters.type = filterType
	end
end


StaticPopupDialogs["CRITLINE_ADD_MOB_BY_NAME"] = {
	text = L["Enter mob name:"],
	button1 = OKAY,
	button2 = CANCEL,
	hasEditBox = true,
	OnAccept = function(self)
		local name = self.editBox:GetText():trim()
		if not name:match("%S+") then
			addon:Message(L["Invalid mob name."])
			return
		end
		filters:AddMob(name)
	end,
	EditBoxOnEnterPressed = function(self)
		local name = self:GetText():trim()
		if not name:match("%S+") then
			addon:Message(L["Invalid mob name."])
			return
		end
		filters:AddMob(name)
		self:GetParent():Hide()
	end,
	EditBoxOnEscapePressed = function(self)
		self:GetParent():Hide()
	end,
	OnShow = function(self)
		self.editBox:SetFocus()
	end,
	whileDead = true,
	timeout = 0,
}

StaticPopupDialogs["CRITLINE_ADD_AURA_BY_ID"] = {
	text = L["Enter spell ID:"],
	button1 = OKAY,
	button2 = CANCEL,
	hasEditBox = true,
	OnAccept = function(self)
		local id = tonumber(self.editBox:GetText())
		if not id then
			addon:Message(L["Invalid input. Please enter a spell ID."])
			return
		elseif not GetSpellInfo(id) then
			addon:Message(L["Invalid spell ID. No such spell."])
			return
		end
		filters:AddAura(id)
	end,
	EditBoxOnEnterPressed = function(self)
		local id = tonumber(self:GetText())
		if not id then
			addon:Message(L["Invalid input. Please enter a spell ID."])
			return
		elseif not GetSpellInfo(id) then
			addon:Message(L["Invalid spell ID. No such spell exists."])
			return
		end
		filters:AddAura(id)
		self:GetParent():Hide()
	end,
	EditBoxOnEscapePressed = function(self)
		self:GetParent():Hide()
	end,
	OnShow = function(self)
		self.editBox:SetFocus()
	end,
	whileDead = true,
	timeout = 0,
}


local function updateSpellFilter(self)
	local selectedTree = self.tree:GetSelectedValue()
	local spells = addon:GetSpellArray(selectedTree)
	local size = #spells
	
	FauxScrollFrame_Update(self, size, self.numButtons, self.buttonHeight)
	
	local offset = FauxScrollFrame_GetOffset(self)
	local buttons = self.buttons
	for line = 1, NUMSPELLBUTTONS do
		local button = buttons[line]
		local lineplusoffset = line + offset
		if lineplusoffset <= size then
			local data = spells[lineplusoffset]
			button.data = data
			button:SetText(addon:GetFullSpellName(data.spellID, data.periodic))
			button:SetChecked(not data.filtered)
			button:Show()
		else
			button:Hide()
		end
	end
end

local function updateFilter(self)
	local filter = filters.db.global[self.filter]
	local size = #filter
	
	FauxScrollFrame_Update(self, size, self.numButtons, self.buttonHeight)
	
	local offset = FauxScrollFrame_GetOffset(self)
	local buttons = self.buttons
	for line = 1, self.numButtons do
		local button = buttons[line]
		local lineplusoffset = line + offset
		if lineplusoffset <= size then
			if self.selected then
				if self.selected - offset == line then
					button:LockHighlight()
				else
					button:UnlockHighlight()
				end
			end
			local entry = filter[lineplusoffset]
			button.spellID = entry
			button:SetText(type(entry) == "number" and GetSpellInfo(entry) or entry)
			button:Show()
		else
			button:Hide()
		end
	end
end


local defaults = {
	profile = {
		filterNew = false,
		onlyKnown = false,
		ignoreMobFilter = false,
		ignoreAuraFilter = false,
		suppressMC = true,
		dontFilterMagic = false,
		levelFilter = -1,
	},
	global = {
		mobs = {},
		auras = {},
	},
}

function filters:AddonLoaded()
	self.db = addon.db:RegisterNamespace("filters", defaults)
	addon.RegisterCallback(self, "SettingsLoaded", "LoadSettings")
	addon.RegisterCallback(self, "PerCharSettingsLoaded", "UpdateSpellFilter")
	addon.RegisterCallback(self, "SpellsChanged", "UpdateSpellFilter")
	
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	self:RegisterEvent("PLAYER_LOGIN")
	self:RegisterEvent("UNIT_NAME_UPDATE")
	self:RegisterEvent("PLAYER_CONTROL_LOST")
	self:RegisterEvent("PLAYER_CONTROL_GAINED")
	
	-- mix in scroll frame update functions
	self.spell.scrollFrame.Update = updateSpellFilter
	self.mobs.scrollFrame.Update = updateFilter
	self.auras.scrollFrame.Update = updateFilter
end

addon.RegisterCallback(filters, "AddonLoaded")


function filters:COMBAT_LOG_EVENT_UNFILTERED(timestamp, eventType, hideCaster, sourceGUID, sourceName, sourceFlags, sourceFlags2, destGUID, destName, destFlags, destFlags2, spellID, spellName)
	if eventType == "SPELL_AURA_APPLIED" or eventType == "SPELL_AURA_REFRESH" then
		-- if this is one of the damage-taken-increased auras, we flag this target - along with the aura in question - as rotten
		if targetAuras[spellID] then
			corruptTargets[destGUID] = corruptTargets[destGUID] or {}
			corruptTargets[destGUID][spellID] = true
			addon:Debug(format("Target (%s) gained filtered aura. (%s) Ignore received damage.", destName, spellName))
		end
		
		local destUnit = self:GetUnit(destFlags, destGUID)
		if destUnit and self:IsFilteredAura(spellID) then
			-- if we gain any aura in the filter we can just stop tracking records
			if not (self:IsEmpowered(destUnit) or self.profile.ignoreAuraFilter) then
				addon:Debug(format("%s gained filtered aura. (%s) Disabling combat log tracking.", destUnit:gsub(".", string.upper, 1), spellName))
			end
			activeAuras[destUnit][spellID] = true
		end
		
		local sourceUnit = self:GetUnit(sourceFlags, sourceGUID)
		if sourceUnit then
			local corruptSpell = corruptSpells[sourceUnit][spellID] or {}
			corruptSpell[destGUID] = self:IsEmpowered(sourceUnit) or self:IsVulnerableTarget(destGUID)
			corruptSpells[sourceUnit][spellID] = corruptSpell
		end
	elseif (eventType == "SPELL_AURA_REMOVED" or eventType == "SPELL_AURA_BROKEN" or eventType == "SPELL_AURA_BROKEN_SPELL" or eventType == "SPELL_AURA_STOLEN") then
		if targetAuras[spellID] then
			corruptTargets[destGUID] = corruptTargets[destGUID] or {}
			corruptTargets[destGUID][spellID] = nil
			addon:Debug(format("Filtered aura (%s) faded from %s.", spellName, destName))
		end
		
		if self:IsFilteredAura(spellID) then
			local unit = self:GetUnit(destFlags, destGUID)
			if unit then
				addon:Debug(format("Filtered aura (%s) faded from %s.", spellName, unit))
				-- if we lost a special aura we have to check if any other filtered auras remain
				activeAuras[unit][spellID] = nil
				if not filters:IsEmpowered(unit) then
					addon:Debug(format("No filtered aura detected on %s. Resuming record tracking.", unit))
				end
			end
		end
	end
end


function filters:PLAYER_LOGIN()
	self:ScanAuras()
end


function filters:UNIT_NAME_UPDATE()
	self:ScanAuras()
	self:UnregisterEvent("UNIT_NAME_UPDATE")
end


function filters:PLAYER_CONTROL_LOST()
	self.inControl = false
	addon:Debug("Lost control. Disabling combat log tracking.")
end


function filters:PLAYER_CONTROL_GAINED()
	self.inControl = true
	addon:Debug("Regained control. Resuming combat log tracking.")
end


function filters:LoadSettings()
	self.profile = self.db.profile
	
	for i, v in ipairs(self.options.checkButtons) do
		v:LoadSetting()
	end
	
	self.options.slider:SetValue(self.profile.levelFilter)
end


local auraTypes = {
	BUFF = "HELPFUL",
	DEBUFF = "HARMFUL",
}

function filters:ScanAuras()
	local auras = {}
	for auraType, filter in pairs(auraTypes) do
		for i = 1, 40 do
			local spellName, _, _, _, _, _, _, source, _, _, spellID = UnitAura("player", i, filter)
			if not spellID then break end
			auras[spellID] = true
			if specialAuras[spellID] then
				activeAuras[spellID] = true
			end
		end
	end
	if next(auras) then
		self:UnregisterEvent("UNIT_NAME_UPDATE")
	end
	for i, v in ipairs(self.db.global.auras) do
		activeAuras[v] = auras[v]
	end
	if next(activeAuras) then
		addon:Debug("Filtered aura detected. Disabling combat log tracking.")
	end
	self.inControl = HasFullControl()
	if not self.inControl then
		addon:Debug("Lost control. Disabling combat log tracking.")
	end
end


function filters:UpdateSpellFilter()
	self.spell.scrollFrame:Update()
end


function filters:UpdateFilter()
	self[self.type:GetSelectedValue()].scrollFrame:Update()
end


function filters:FilterSpell(filter, tree, data)
	data.filtered = filter
	addon:GetSpellInfo(tree, data.spellID, data.periodic).filtered = filter
	addon:UpdateTopRecords(tree)
	addon:UpdateRecords(tree)
end


-- adds a mob to the mob filter
function filters:AddMob(name)
	if self:IsFilteredTarget(name) then
		addon:Message(L["%s is already in mob filter."]:format(name))
	else
		tinsert(self.db.global.mobs, name)
		self:UpdateFilter()
		addon:Message(L["%s added to mob filter."]:format(name))
	end
end


-- adds an aura to the aura filter
function filters:AddAura(spellID)
	local spellName = GetSpellInfo(spellID)
	if self:IsFilteredAura(spellID) then
		addon:Message(L["%s is already in aura filter."]:format(spellName))
	else
		tinsert(self.db.global.auras, spellID)
		-- after we add an aura to the filter; check if we have it
		for i = 1, 40 do
			local buffID = select(11, UnitBuff("player", i))
			local debuffID = select(11, UnitDebuff("player", i))
			if not (buffID or debuffID) then
				break
			else
				for _, v in ipairs(self.db.global.auras) do
					if v == buffID then
						activeAuras[buffID] = true
						break
					elseif v == debuffID then
						activeAuras[debuffID] = true
						break
					end
				end
			end
		end
		self:UpdateFilter()
		addon:Message(L["%s added to aura filter."]:format(spellName))
	end
end


-- check if a spell passes the filter settings
function filters:SpellPassesFilters(tree, spellName, spellID, isPeriodic, destGUID, destName, school, targetLevel)
	local isPet = tree == "pet"
	if spellID and not IsSpellKnown(spellID, isPet) and self.profile.onlyKnown then
		addon:Debug(format("%s is not in your%s spell book. Return.", spellName, isPet and " pet's" or ""))
		return
	end
	
	local unit = isPet and "pet" or "player"
	if ((corruptSpells[unit][spellID] and corruptSpells[unit][spellID][destGUID]) or (self:IsEmpowered(unit) and (not isPeriodic or directHoTs[spellID]))) and not self.profile.ignoreAuraFilter then
		addon:Debug(format("Spell (%s) was cast under the influence of a filtered aura. Return.", spellName))
		return
	end
	
	if self:IsVulnerableTarget(destGUID) and not isPeriodic and not self.profile.ignoreAuraFilter then
		addon:Debug("Target is vulnerable. Return.")
		return
	end
	
	local levelDiff = 0
	if (targetLevel > 0) and (targetLevel < UnitLevel("player")) then
		levelDiff = (UnitLevel("player") - targetLevel)
	end
	
	-- ignore level adjustment if magic damage and the setting is enabled
	if not isHeal and (self.profile.levelFilter >= 0) and (self.profile.levelFilter < levelDiff) and (school == 1 or not self.profile.dontFilterMagic) then
		-- target level is too low to pass level filter
		addon:Debug(format("Target (%s) level too low (%d) and damage school is filtered. Return.", destName, targetLevel))
		return
	end
	
	local filteredTarget = self:IsFilteredTarget(destName, destGUID)
	if filteredTarget then
		addon:Debug(format("Target (%s) is in %s target filter.", destName, filteredTarget))
		return
	end
	
	return true, self:IsFilteredSpell(tree, spellID, isPeriodic and 2 or 1), targetLevel
end


-- check if a spell will be filtered out
function filters:IsFilteredSpell(tree, spellID, periodic)
	local spell = addon:GetSpellInfo(tree, spellID, periodic)
	return (not spell and self.db.profile.filterNew) or (spell and spell.filtered)
end


-- scan for filtered auras from the specialAuras table
function filters:IsEmpowered(unit)
	if next(activeAuras[unit]) or (unit == "player" and not self.inControl) then
		return true
	end
end


-- checks if a target is affected by any vulnerability auras
function filters:IsVulnerableTarget(guid)
	local corruptTarget = corruptTargets[guid]
	if corruptTarget and next(corruptTarget) then
		return true
	end
end


function filters:IsFilteredTarget(targetName, guid)
	-- GUID is provided if the function was called from the combat event handler
	if guid and not self.profile.ignoreMobFilter and specialMobs[tonumber(guid:sub(7, 10), 16)] then
		return "default"
	end
	for _, v in ipairs(self.db.global.mobs) do
		if v:lower() == targetName:lower() then
			return "custom"
		end
	end
end


function filters:IsFilteredAura(spellID)
	if specialAuras[spellID] then
		return true
	end
	for _, v in ipairs(self.db.global.auras) do
		if v == spellID then
			return true
		end
	end
end


function filters:GetUnit(unitFlags, unitGUID)
	if CombatLog_Object_IsA(unitFlags, COMBATLOG_FILTER_ME) then
		return "player"
	elseif addon:IsMyPet(unitFlags, unitGUID) then
		return "pet"
	end
end