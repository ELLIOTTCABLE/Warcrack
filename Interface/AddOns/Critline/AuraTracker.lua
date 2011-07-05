local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local templates = addon.templates

local band = bit.band
local CombatLog_Object_IsA = CombatLog_Object_IsA
local IsSpellKnown = IsSpellKnown
local UnitAura = UnitAura
local UnitName = UnitName
local UnitGUID = UnitGUID
local IsInInstance = IsInInstance

local COMBATLOG_FILTER_ME = COMBATLOG_FILTER_ME
local COMBATLOG_OBJECT_REACTION_FRIENDLY = COMBATLOG_OBJECT_REACTION_FRIENDLY

local playerAuras = {
	session = {},
	instance = {},
	lastFight = {},
}
local enemyAuras = {
	session = {},
	instance = {},
	lastFight = {},
}

-- name of current instance
local currentInstance = L["n/a"]


local auraTracker = CreateFrame("Frame", nil, UIParent)
auraTracker:SetFrameStrata("DIALOG")
auraTracker:EnableMouse(true)
auraTracker:SetSize(320, 360)
auraTracker:SetPoint("CENTER")

auraTracker:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
auraTracker:RegisterEvent("PLAYER_LOGIN")
auraTracker:RegisterEvent("UNIT_NAME_UPDATE")
auraTracker:RegisterEvent("PLAYER_REGEN_DISABLED")
auraTracker:RegisterEvent("PLAYER_ENTERING_WORLD")
auraTracker:SetScript("OnEvent", function(self, event, ...)
	self[event](self, ...)
end)

auraTracker:SetBackdrop({
	bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
	edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
	edgeSize = 16,
	insets = {left = 4, right = 4, top = 4, bottom = 4},
})
auraTracker:SetBackdropColor(0, 0, 0)
auraTracker:SetBackdropBorderColor(0.5, 0.5, 0.5)
auraTracker:Hide()

local closeButton = CreateFrame("Button", nil, auraTracker, "UIPanelCloseButton")
closeButton:SetPoint("TOPRIGHT")

addon.SlashCmdHandlers["aura"] = function() auraTracker:Show() end

local currentFilter = playerAuras.session

local function auraSort(a, b)
	return currentFilter[a].spellName < currentFilter[b].spellName
end

local function sourceSort(a, b)
	a, b = currentFilter[a], currentFilter[b]
	if a.source == b.source then
		return a.spellName < b.spellName
	else
		return a.source < b.source
	end
end

local filters = {
	BUFF = true,
	DEBUFF = true,
	targetAffiliation = playerAuras,
	sourceType = "npc",
	sort = auraSort,
}

local function onClick(self, text)
	self.owner:SetSelectedValue(self.value)
	self.owner:SetText(text)
	currentFilter = filters.targetAffiliation[self.value]
	CritlineAuraTrackerScrollFrame:Update()
end

local menuList = {
	{
		text = L["Current fight"],
		value = "lastFight",
	},
	{
		text = L["Current instance (%s)"],
		value = "instance",
	},
	{
		text = L["Current session"],
		value = "session",
	},
}

local auraTrackerScope = templates:CreateDropDownMenu("CritlineAuraTrackerScope", auraTracker)
auraTrackerScope:SetPoint("TOP", 0, -16)
auraTrackerScope:SetFrameWidth(220)
auraTrackerScope:JustifyText("LEFT")
auraTrackerScope:SetSelectedValue("session")
auraTrackerScope:SetText(L["Current session"])
auraTrackerScope.initialize = function(self)
	for i, v in ipairs(menuList) do
		local info = UIDropDownMenu_CreateInfo()
		info.text = format(v.text, currentInstance)
		info.value = v.value
		info.func = onClick
		info.owner = self
		info.arg1 = info.text
		UIDropDownMenu_AddButton(info)
	end
end

local auraTrackerAuraType = templates:CreateDropDownMenu("CritlineAuraTrackerAuraType", auraTracker)
auraTrackerAuraType:SetPoint("TOPLEFT", auraTrackerScope, "BOTTOMLEFT")
auraTrackerAuraType:SetFrameWidth(96)
auraTrackerAuraType:JustifyText("LEFT")
auraTrackerAuraType:SetText(L["Aura type"])

do
	local function onClick(self)
		filters[self.value] = self.checked
		CritlineAuraTrackerScrollFrame:Update()
	end

	local menuList = {
		{
			text = L["Buffs"],
			value = "BUFF",
		},
		{
			text = L["Debuffs"],
			value = "DEBUFF",
		},
	}
	
	auraTrackerAuraType.initialize = function(self)
		for i, v in ipairs(menuList) do
			local info = UIDropDownMenu_CreateInfo()
			info.text = v.text
			info.value = v.value
			info.func = onClick
			info.checked = filters[v.value]
			info.isNotRadio = true
			info.keepShownOnClick = true
			UIDropDownMenu_AddButton(info)
		end
	end
end

local filterOptions = templates:CreateDropDownMenu("CritlineAuraTrackerFilterOptions", auraTracker)
filterOptions:SetPoint("TOPRIGHT", auraTrackerScope, "BOTTOMRIGHT")
filterOptions:SetFrameWidth(96)
filterOptions:JustifyText("LEFT")
filterOptions:SetText(FILTERS)

do
	local function onClick(self, key)
		filters[key] = self.value
		self.owner:Refresh()
		self.owner:SetText(FILTERS)
		currentFilter = filters.targetAffiliation[auraTrackerScope:GetSelectedValue()]
		CritlineAuraTrackerScrollFrame:Update()
	end

	local function checked(self)
		return filters[self.arg1] == self.value
	end

	local menuList = {
		{
			text = L["Show auras cast on me"],
			value = playerAuras,
			arg1 = "targetAffiliation",
		},
		{
			text = L["Show auras cast on hostile NPCs"],
			value = enemyAuras,
			arg1 = "targetAffiliation",
		},
		{
			text = L["Show auras cast by NPCs"],
			value = "npc",
			arg1 = "sourceType",
		},
		{
			text = L["Show auras cast by players"],
			value = "pvp",
			arg1 = "sourceType",
		},
		{
			text = L["Sort by aura name"],
			value = auraSort,
			arg1 = "sort",
		},
		{
			text = L["Sort by source name"],
			value = sourceSort,
			arg1 = "sort",
		},
	}
	
	filterOptions.initialize = function(self)
		for i, v in ipairs(menuList) do
			local info = UIDropDownMenu_CreateInfo()
			info.text = v.text
			info.value = v.value
			info.func = onClick
			info.checked = checked
			info.owner = self
			info.keepShownOnClick = true
			info.arg1 = v.arg1
			UIDropDownMenu_AddButton(info)
		end
	end
end

local search = templates:CreateEditBox(auraTracker)
search:SetPoint("TOPLEFT", auraTrackerAuraType, "BOTTOMLEFT", 18, -8)
search:SetPoint("TOPRIGHT", filterOptions, "BOTTOMRIGHT", -18, -8)
search:SetWidth(192)
search:SetScript("OnTextChanged", function() CritlineAuraTrackerScrollFrame:Update() end)
search:SetScript("OnEscapePressed", search.ClearFocus)

local label = search:CreateFontString(nil, nil, "GameFontNormalSmall")
label:SetPoint("BOTTOMLEFT", search, "TOPLEFT")
label:SetText(L["Text filter"])

local NUM_BUTTONS = 6
local BUTTON_HEIGHT = 36

local scrollFrame = CreateFrame("ScrollFrame", "CritlineAuraTrackerScrollFrame", auraTracker, "FauxScrollFrameTemplate")
scrollFrame:SetHeight(NUM_BUTTONS * BUTTON_HEIGHT)
scrollFrame:SetPoint("TOP", search, "BOTTOM", 0, -8)
scrollFrame:SetPoint("LEFT", 32, 0)
scrollFrame:SetPoint("RIGHT", -32, 0)
scrollFrame:SetScript("OnVerticalScroll", function(self, offset) FauxScrollFrame_OnVerticalScroll(self, offset, BUTTON_HEIGHT, self.Update) end)

local sortedAuras = {}

function scrollFrame:Update()
	if not auraTracker:IsShown() then
		self.doUpdate = true
		return
	end
	
	self.doUpdate = nil
	
	wipe(sortedAuras)
	
	local n = 0
	local search = search:GetText():lower()
	for spellID, v in pairs(currentFilter) do
		if filters[v.type] and (v.sourceType == filters.sourceType or not v.sourceType) and (v.spellName:lower():find(search, nil, true) or v.sourceName:lower():find(search, nil, true)) then
			n = n + 1
			sortedAuras[n] = spellID
		end
	end
	
	sort(sortedAuras, filters.sort)
	
	FauxScrollFrame_Update(self, n, NUM_BUTTONS, BUTTON_HEIGHT)
	
	local offset = FauxScrollFrame_GetOffset(self)
	local buttons = self.buttons
	for line = 1, NUM_BUTTONS do
		local button = buttons[line]
		local lineplusoffset = line + offset
		if lineplusoffset <= n then
			local spellID = sortedAuras[lineplusoffset]
			button:SetFormattedText("%s (%d)", currentFilter[spellID].spellName, spellID)
			button.source:SetText(currentFilter[spellID].source)
			button.icon:SetTexture(addon:GetSpellTexture(spellID))
			button.spellID = spellID
			-- local disabled = filters:IsFilteredAura(spellID)
			-- button.icon:SetDesaturated(disabled)
			-- button.text:SetFontObject(disabled and "GameFontDisable" or "GameFontNormal")
			button:Show()
		else
			button:Hide()
		end
	end
end

auraTracker:SetScript("OnShow", function(self)
	if scrollFrame.doUpdate then
		scrollFrame:Update()
	end
end)

local auraTrackerButtons = {}
scrollFrame.buttons = auraTrackerButtons

-- local function onClick(self)
	-- local disabled = filters:IsFilteredAura(self.spellID)
	-- if disabled then
		-- if specialAuras[self.spellID] then
			-- addon:Message("Cannot delete integrated auras.")
			-- return
		-- else
			-- local t = filters.db.global.auras
			-- for i = 1, #t do
				-- if t[i] == self.spellID then
					-- tremove(t, i)
					-- addon:Message(format("Removed aura (%s) from filter.", GetSpellInfo(self.spellID)))
					-- break
				-- end
			-- end
		-- end
	-- else
		-- filters:AddAura(self.spellID)
	-- end
	-- disabled = not disabled
	-- self.icon:SetDesaturated(disabled)
	-- self.text:SetFontObject(disabled and "GameFontDisable" or "GameFontNormal")
-- end

local function onEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	GameTooltip:SetSpellByID(self.spellID)
	GameTooltip:AddLine(" ")
	GameTooltip:AddLine(format(L["Spell ID: |cffffffff%d|r"], self.spellID))
	GameTooltip:Show()
end

for i = 1, NUM_BUTTONS do
	local btn = CreateFrame("Button", nil, auraTracker)
	btn:SetHeight(BUTTON_HEIGHT)
	if i == 1 then
		btn:SetPoint("TOP", scrollFrame)
	else
		btn:SetPoint("TOP", auraTrackerButtons[i - 1], "BOTTOM")
	end
	btn:SetPoint("LEFT", scrollFrame)
	btn:SetPoint("RIGHT", scrollFrame)
	btn:SetPushedTextOffset(0, 0)
	-- btn:SetScript("OnClick", onClick)
	btn:SetScript("OnEnter", onEnter)
	btn:SetScript("OnLeave", GameTooltip_Hide)
	
	if i % 2 == 0 then
		local bg = btn:CreateTexture(nil, "BACKGROUND")
		bg:SetAllPoints()
		bg:SetTexture(1, 1, 1, 0.1)
	end
	
	local icon = btn:CreateTexture()
	icon:SetSize(32, 32)
	icon:SetPoint("LEFT")
	btn.icon = icon
	
	local text = btn:CreateFontString(nil, nil, "GameFontNormal")
	text:SetPoint("TOPLEFT", icon, "TOPRIGHT", 4, -4)
	text:SetPoint("RIGHT")
	text:SetJustifyH("LEFT")
	btn:SetFontString(text)
	btn.text = text
	
	local source = btn:CreateFontString(nil, nil, "GameFontHighlightSmall")
	source:SetPoint("BOTTOMLEFT", icon, "BOTTOMRIGHT", 4, 4)
	source:SetPoint("RIGHT")
	source:SetJustifyH("LEFT")
	btn.source = source
	
	auraTrackerButtons[i] = btn
end


function auraTracker:COMBAT_LOG_EVENT_UNFILTERED(timestamp, eventType, hideCaster, sourceGUID, sourceName, sourceFlags, sourceFlags2, destGUID, destName, destFlags, destFlags2, spellID, spellName, spellSchool, auraType)
	if eventType == "SPELL_AURA_APPLIED" or eventType == "SPELL_AURA_REFRESH" then
		local auraTable
		if CombatLog_Object_IsA(destFlags, COMBATLOG_FILTER_ME) or addon:IsMyPet(destFlags, destGUID) then
			-- register our own and our pet's auras
			auraTable = playerAuras
		elseif not self:IsPvPTarget(destGUID) and band(destFlags, COMBATLOG_OBJECT_REACTION_FRIENDLY) == 0 then
			-- and also those of non friendly NPCs
			auraTable = enemyAuras
		end
		
		if auraTable then
			self:RegisterAura(auraTable, sourceName, sourceGUID, spellID, spellName, auraType)
		end
	end
end


function auraTracker:PLAYER_LOGIN()
	self:ScanAuras()
end


function auraTracker:UNIT_NAME_UPDATE()
	self:ScanAuras()
	self:UnregisterEvent("UNIT_NAME_UPDATE")
end


-- reset current fight auras upon entering combat
function auraTracker:PLAYER_REGEN_DISABLED()
	wipe(playerAuras.lastFight)
	wipe(enemyAuras.lastFight)
	scrollFrame:Update()
end


function auraTracker:PLAYER_ENTERING_WORLD()
	-- wipe instance buff data when entering a new instance
	local instanceName = GetInstanceInfo()
	if IsInInstance() and instanceName ~= currentInstance then
		wipe(playerAuras.instance)
		wipe(enemyAuras.instance)
		currentInstance = instanceName
		if auraTrackerScope:GetSelectedValue() == "instance" then
			auraTrackerScope:SetText(format(L["Current instance (%s)"], currentInstance))
		end
		scrollFrame:Update()
	end
end


local auraTypes = {
	BUFF = "HELPFUL",
	DEBUFF = "HARMFUL",
}

function auraTracker:ScanAuras()
	local auras = {}
	for auraType, filter in pairs(auraTypes) do
		for i = 1, 40 do
			local spellName, _, _, _, _, _, _, source, _, _, spellID = UnitAura("player", i, filter)
			if not spellID then break end
			self:RegisterAura(playerAuras, source and UnitName(source), source and UnitGUID(source), spellID, spellName, auraType)
		end
	end
	scrollFrame:Update()
end


function auraTracker:RegisterAura(auraTable, sourceName, sourceGUID, spellID, spellName, auraType)
	local session = auraTable.session
	if session[spellID] or IsSpellKnown(spellID) then
		return 
	end

	local source = L["n/a"]
	local sourceType
	
	if sourceGUID then
		if self:IsPvPTarget(sourceGUID) then
			-- this is a player or a player's permanent pet
			source = PVP
			sourceType = "pvp"
		else
			source = tonumber(sourceGUID:sub(7, 10), 16)
			sourceType = "npc"
		end
	end
	
	local aura = {
		source = sourceName and format("%s (%s)", sourceName, source) or source,
		sourceName = sourceName or "",
		spellName = spellName,
		sourceType = sourceType,
		type = auraType,
	}
	auraTable.lastFight[spellID] = aura
	if IsInInstance() then
		auraTable.instance[spellID] = aura
	end
	session[spellID] = aura
	scrollFrame:Update()
end


function auraTracker:IsPvPTarget(guid)
	local unitType = band(guid:sub(1, 5), 0x007)
	return unitType == 0 or unitType == 4
end