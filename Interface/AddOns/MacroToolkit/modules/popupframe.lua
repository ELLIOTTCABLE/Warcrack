local MT = MacroToolkit
local mtpf
local GetSpellTabInfo, GetSpellBookItemTexture, GetSpellInfo, GetSpellTexture = GetSpellTabInfo, GetSpellBookItemTexture, GetSpellInfo, GetSpellTexture
local GetFlyoutInfo, GetFlyoutSlotInfo, GetSpellBookItemInfo = GetFlyoutInfo, GetFlyoutSlotInfo, GetSpellBookItemInfo
local string, tinsert, format = string, tinsert, format
local CreateFrame, PlaySound, PanelTemplates_GetSelectedTab = CreateFrame, PlaySound, PanelTemplates_GetSelectedTab
local EditMacro, CreateMacro, GetMacroInfo = EditMacro, CreateMacro, GetMacroInfo

MT.MACRO_ICON_FILENAMES = {}

local function doicongroups()
	MT:RefreshPlayerSpellIconInfo()
	local abilitytextures, achtextures, invtextures = {}, {}, {}
	local itemtextures, misctextures, spelltextures = {}, {}, {}
	local index = 1
	repeat
		local texture = MT:GetBlizzSpellorMacroIconInfo(index)
		local t = string.lower(texture or "")
		if string.find(t, "spell_") then tinsert(spelltextures, texture)
		elseif string.find(t, "ability_") then tinsert(abilitytextures, texture)
		elseif string.find(t, "achievement_") then tinsert(achtextures, texture)
		elseif string.find(t, "inv_") and t ~= "inv_misc_questionmark" then tinsert(invtextures, texture)
		elseif string.find(t, "item_") then tinsert(itemtextures, texture)
		elseif t ~= "" then tinsert(misctextures, texture) end
		index = index + 1
	until not texture
	MT.numabilityicons = #abilitytextures
	MT.numachicons = #achtextures
	MT.numinvicons = #invtextures
	MT.numitemicons = #itemtextures
	MT.nummiscicons = #misctextures
	MT.numspellicons = #spelltextures
	MT.abilityicons = {count = #abilitytextures, GetIconInfo = function(id) return id, "Ability", abilitytextures[id] end }
	MT.achicons = {count = #achtextures, GetIconInfo = function(id) return id, "Achievement", achtextures[id] end }
	MT.invicons = {count = #invtextures, GetIconInfo = function(id) return id, "Inventory", invtextures[id] end }
	MT.itemicons = {count = #itemtextures, GetIconInfo = function(id) return id, "Item", itemtextures[id] end }
	MT.miscicons = {count = #misctextures, GetIconInfo = function(id) return id, "Miscellaneous", misctextures[id] end }
	MT.spellicons = {count = #spelltextures, GetIconInfo = function(id) return id, "Spell", spelltextures[id] end }
end

function MT:CreateMTPopup()
	mtpf = CreateFrame("Frame", "MacroToolkitPopup", UIParent)
	mtpf:SetMovable(true)
	mtpf:EnableMouse(true)
	mtpf:SetScale(MT.db.profile.scale)
	mtpf:SetSize(297, 411)
	mtpf:SetPoint("TOPLEFT", MacroToolkitFrame, "TOPRIGHT", 0, 0)
	mtpf:Hide()

	local mtpftl = mtpf:CreateTexture("BACKGROUND")
	mtpftl:SetTexture("Interface\\MacroFrame\\MacroPopup-TopLeft")
	mtpftl:SetSize(256, 368)
	mtpftl:SetPoint("TOPLEFT")

	local mtpftr = mtpf:CreateTexture("BACKGROUND")
	mtpftr:SetTexture("Interface\\MacroFrame\\MacroPopup-TopRight")
	mtpftr:SetSize(64, 368)
	mtpftr:SetPoint("TOPLEFT", 256, 0)
	
	local mtpfbl = mtpf:CreateTexture("BACKGROUND")
	mtpfbl:SetTexture("Interface\\MacroFrame\\MacroPopup-BotLeft")
	mtpfbl:SetSize(256, 64)
	mtpfbl:SetPoint("TOPLEFT", 0, -368)
	
	local mtpfbr = mtpf:CreateTexture("BACKGROUND")
	mtpfbr:SetTexture("Interface\\MacroFrame\\MacroPopup-BotRight")
	mtpfbr:SetSize(64, 64)
	mtpfbr:SetPoint("TOPLEFT", 256, -368)
	
	local mtpftitle = mtpf:CreateFontString(nil, "BACKGROUND", "GameFontHighlightSmall")
	mtpftitle:SetText(_G.MACRO_POPUP_TEXT)
	mtpftitle:SetPoint("TOPLEFT", 24, -21)

	local mtpfcicon = mtpf:CreateFontString(nil, "BACKGROUND", "GameFontHighlightSmall")
	mtpfcicon:SetText(_G.MACRO_POPUP_CHOOSE_ICON)
	mtpfcicon:SetPoint("TOPLEFT", 24, -69)
	
	local mtpfavailable = mtpf:CreateFontString("MacroToolkitPopupAvailable", "BACKGROUND", "GameFontHighlightSmall")
	mtpfavailable:SetPoint("LEFT", mtpfcicon, "RIGHT", 20, 0)

	local mtpfedit = CreateFrame("EditBox", "MacroToolkitPopupEdit", mtpf)
	mtpfedit:SetMaxLetters(16)
	mtpfedit:SetSize(182, 20)
	mtpfedit:SetPoint("TOPLEFT", 29, -35)
	mtpfedit:SetFontObject("ChatFontNormal")
	
	local mtpfeditl = mtpfedit:CreateTexture("MacroToolkitFramePopupL", "BACKGROUND")
	mtpfeditl:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-FilterBorder")
	mtpfeditl:SetSize(12, 29)
	mtpfeditl:SetPoint("TOPLEFT", -11, 0)
	mtpfeditl:SetTexCoord(0, 0.09375, 0, 1)

	local mtpfeditm = mtpfedit:CreateTexture("MacroToolkitFramePopupM", "BACKGROUND")
	mtpfeditm:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-FilterBorder")
	mtpfeditm:SetSize(175, 29)
	mtpfeditm:SetPoint("LEFT", mtpfeditl, "RIGHT")
	mtpfeditm:SetTexCoord(0.09375, 0.90625, 0, 1)

	local mtpfeditr = mtpfedit:CreateTexture("MacroToolkitFramePopupR", "BACKGROUND")
	mtpfeditr:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-FilterBorder")
	mtpfeditr:SetSize(12, 29)
	mtpfeditr:SetPoint("LEFT", mtpfeditm, "RIGHT")
	mtpfeditr:SetTexCoord(0.90625, 1, 0, 1)

	mtpfedit:SetScript("OnTextChanged",
		function(this)
			local text = string.gsub(this:GetText(), "\"", "")
			MT:PopupOkayUpdate()
			MacroToolkitSelMacroName:SetText(text)
		end)
	
	mtpfedit:SetScript("OnEscapePressed", function() MT:CancelEdit() end)
	mtpfedit:SetScript("OnEnterPressed", function() if MacroToolkitPopupOk:IsEnabled() then MT:PopupOkayButtonOnClick() end end)

	doicongroups()
	local aisoptions = {
		contentInsets = {0, 0, 0, 0},
		sectionOrder = {"DynamicIcon", "SpellIcons", "AbilityIcons", "AchievementIcons", "InventoryIcons", "ItemIcons", "MiscellaneousIcons"},
		sections = {
			AbilityIcons = MT.abilityicons,
			AchievementIcons = MT.achicons,
			InventoryIcons = MT.invicons,
			SpellIcons = MT.spellicons,
			ItemIcons = MT.itemicons,
			MiscellaneousIcons = MT.miscicons,
		},
	}
	local aisframe = MT.AIS:CreateIconSelectorFrame("MacroToolkitPopupIcons", mtpf, aisoptions)
	aisframe:SetSize(296, 276)
	aisframe:SetPoint("TOPLEFT", 0, -85)
	aisframe.scrollFrame.ScrollBar:ClearAllPoints()
	aisframe.scrollFrame.ScrollBar:SetPoint("TOPLEFT", aisframe.scrollFrame, "TOPRIGHT", -10, -36)
	aisframe.scrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", aisframe.scrollFrame, "BOTTOMRIGHT", -10, 36)
	aisframe:SetScript("OnSelectedIconChanged", function(this) MT:SelectTexture(this:GetSelectedIcon()) end)

	local searchLabel = mtpf:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	searchLabel:SetText(format("%s:", _G.SEARCH))
	searchLabel:SetHeight(22)
	searchLabel:SetPoint("TOPLEFT", aisframe, "BOTTOMLEFT", 20, 15)

	local searchBox = CreateFrame("EditBox", "MacroToolkitSearchBox", mtpf, "InputBoxTemplate")
	searchBox:SetAutoFocus(false)
	searchBox:SetSize(150, 22)
	searchBox:SetPoint("LEFT", searchLabel, "RIGHT", 10, 0)
	searchBox:SetScript("OnTextChanged", function(editBox, userInput) if userInput then aisframe:SetSearchParameter(editBox:GetText()) end end)
	
	--[[
	local mtpfscroll = CreateFrame("ScrollFrame", "MacroToolkitPopupScroll", mtpf, "FauxScrollFrameTemplate")
	mtpfscroll:SetSize(296, 276)
	mtpfscroll:SetPoint("TOPRIGHT", -39, -98)
	mtpfscroll:SetScript("OnVerticalScroll", function(this, offset) FauxScrollFrame_OnVerticalScroll(this, offset, _G.MACRO_ICON_ROW_HEIGHT, function() MT:PopupUpdate(this) end) end)

	local sb = MacroToolkitPopupScrollScrollBar
	sb:ClearAllPoints()
	sb:SetPoint("TOPLEFT", mtpfscroll, "TOPRIGHT", 6, -22)
	sb:SetPoint("BOTTOMLEFT", mtpfscroll, "BOTTOMRIGHT", 6, 22)
	
	MacroToolkitPopupScrollScrollBarScrollUpButton:ClearAllPoints()
	MacroToolkitPopupScrollScrollBarScrollUpButton:SetPoint("BOTTOM", sb, "TOP", 0, 5)
	MacroToolkitPopupScrollScrollBarScrollDownButton:ClearAllPoints()
	MacroToolkitPopupScrollScrollBarScrollDownButton:SetPoint("TOP", sb, "BOTTOM", 0, -5)
	
	local sbt = mtpfscroll:CreateTexture("MacroToolkitFramePopupSBT", "BACKGROUND")
	sbt:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-ScrollBar")
	sbt:SetSize(30, 140)
	sbt:SetPoint("TOPLEFT", mtpfscroll, "TOPRIGHT", -3, 2)
	sbt:SetTexCoord(0, 0.46875, 0.0234375, 0.9609375)

	local sbb = mtpfscroll:CreateTexture("MacroToolkitFramePopupSBB", "BACKGROUND")
	sbb:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-ScrollBar")
	sbb:SetSize(30, 140)
	sbb:SetPoint("BOTTOMLEFT", mtpfscroll, "BOTTOMRIGHT", -3, -2)
	sbb:SetTexCoord(0.53125, 1, 0.03125, 1)

	for mpb = 1, 30 do
		local b = CreateFrame("CheckButton", "MacroToolkitPopupButton" .. mpb, mtpf, "MacroPopupButtonTemplate")
		if mpb == 1 then b:SetPoint("TOPLEFT", 24, -105)
		elseif mpb == 6 or mpb == 11 or mpb == 16 or mpb == 21 or mpb == 26 then b:SetPoint("TOPLEFT", _G["MacroToolkitPopupButton" .. (mpb - 5)], "BOTTOMLEFT", 0, -8)
		else b:SetPoint("LEFT", _G["MacroToolkitPopupButton" .. (mpb - 1)], "RIGHT", 10, 0) end
		b:SetID(mpb)
		b:SetScript("OnClick", function(this) MT:PopupButtonOnClick(this) end)
	end
]]--
	local mtpfcancel = CreateFrame("Button", "MacroToolkitPopupCancel", mtpf, "UIPanelButtonTemplate")
	mtpfcancel:SetText(_G.CANCEL)
	mtpfcancel:SetSize(78, 22)
	mtpfcancel:SetPoint("BOTTOMRIGHT", -11, 13)
	mtpfcancel:SetScript("OnClick",
		function()
			MT:CancelEdit()
			PlaySound("gsTitleOptionOK")
		end)

	local mtpfok = CreateFrame("Button", "MacroToolkitPopupOk", mtpf, "UIPanelButtonTemplate")
	mtpfok:SetText(_G.OKAY)
	mtpfok:SetSize(78, 22)
	mtpfok:SetPoint("RIGHT", mtpfcancel, "LEFT", -2, 0)
	mtpfok:SetScript("OnClick", function() MT:PopupOkayButtonOnClick() end)

	mtpf:SetScript("OnShow", 
		function(this)
			mtpfedit:SetFocus()
			PlaySound("igCharacterInfoOpen")
			--MT:RefreshPlayerSpellIconInfo()
			--MT:PopupUpdate(mtpf)
			--MT:PopupOkayUpdate()
			if this.mode == "new" then
				MacroToolkitText:Hide()
				MacroToolkitFauxText:Hide()
				MT:SelectTexture(1)
				mtpfedit:SetText("")		
			elseif this.mode == "edit" then
				if PanelTemplates_GetSelectedTab(MacroToolkitFrame) == 3 then
					mtpfedit:SetText(MT.db.global.extra[tostring(MacroToolkitFrame.selectedMacro)].name)
				else
					local name = GetMacroInfo(MacroToolkitFrame.selectedMacro)
					mtpfedit:SetText(name)
				end
			end
			MacroToolkitEdit:Disable()
			MacroToolkitDelete:Disable()
			MacroToolkitNew:Disable()
			MacroToolkitFrameTab1:Disable()
			MacroToolkitFrameTab2:Disable()
			MacroToolkitShorten:Disable()
			MacroToolkitExtend:Disable()
			MacroToolkitBackup:Disable()
			MacroToolkitRestore:Disable()
			MacroToolkitClear:Disable()
			MacroToolkitShare:Disable()
			MacroToolkitBind:Disable()
			MacroToolkitFlyout:Disable()
			MacroToolkitCustom:Disable()
			MacroToolkitConditions:Disable()
			aisframe:SetSectionVisibility("DynamicIcon", MT.db.profile.dynamicicon)
			aisframe:SetSectionVisibility("AbilityIcons", MT.db.profile.abilityicons)
			aisframe:SetSectionVisibility("AchievementIcons", MT.db.profile.achicons)
			aisframe:SetSectionVisibility("InventoryIcons", MT.db.profile.invicons)
			aisframe:SetSectionVisibility("ItemIcons", MT.db.profile.itemicons)
			aisframe:SetSectionVisibility("MiscellaneousIcons", MT.db.profile.miscicons)
			aisframe:SetSectionVisibility("SpellIcons", MT.db.profile.spellicons)
			MT:UpdateIconCount()
			MT:Skin(mtpf)
		end)

	mtpf:SetScript("OnHide", 
		function(this)
			if this.mode == "new" then
				MacroToolkitText:Show()
				MacroToolkitFauxText:Show()
				MacroToolkitText:SetFocus()
			end
			MacroToolkitEdit:Enable()
			MacroToolkitDelete:Enable()
			MacroToolkitShorten:Enable()
			MacroToolkitExtend:Enable()
			MacroToolkitBackup:Enable()
			MacroToolkitRestore:Enable()
			MacroToolkitClear:Enable()
			MacroToolkitShare:Enable()
			MacroToolkitBind:Enable()
			MacroToolkitConditions:Enable()
			if #MT.db.global.custom > 0 then MacroToolkitFlyout:Enable() end
			MacroToolkitCustom:Enable()
			PlaySound("igCharacterInfoClose")
			local numMacros
			local numAccountMacros, numCharacterMacros = GetNumMacros()
			numMacros = (MacroToolkitFrame.macroBase == 0) and numAccountMacros or numCharacterMacros
			if PanelTemplates_GetSelectedTab(MacroToolkitFrame) == 3 then numMacros = MT:CountExtra() end
			if numMacros < MacroToolkitFrame.macroMax then MacroToolkitNew:Enable() end
			PanelTemplates_UpdateTabs(MacroToolkitFrame)
			_G.MACRO_ICON_FILENAMES = nil
			collectgarbage()
		end)

	return mtpf
end

function MT:RefreshPlayerSpellIconInfo()
	MT.MACRO_ICON_FILENAMES = {}
	MT.MACRO_ICON_FILENAMES[1] = "INV_MISC_QUESTIONMARK"
	local index = 2
	local numFlyouts = 0

	for i = 1, GetNumSpellTabs() do
		local tab, tabTex, offset, numSpells, _ = GetSpellTabInfo(i)
		offset = offset + 1
		local tabEnd = offset + numSpells
		for j = offset, tabEnd - 1 do
			local spellType, ID = GetSpellBookItemInfo(j, "player")
			if spellType ~= "FUTURESPELL" then
				local spellTexture = string.upper(GetSpellBookItemTexture(j, "player"))
				local spellName = GetSpellInfo(ID)
				if not string.match(spellTexture, "INTERFACE\\BUTTONS\\") then
					MT.MACRO_ICON_FILENAMES[index] = string.gsub(spellTexture, "INTERFACE\\ICONS\\", "")
					index = index + 1
				end
			end
			if spellType == "FLYOUT" then
				local _, _, numSlots, isKnown = GetFlyoutInfo(ID)
				if isKnown and (numSlots > 0) then
					for k = 1, numSlots do 
						local spellID, overrideSpellID, isKnown = GetFlyoutSlotInfo(ID, k)
						if isKnown then
							MT.MACRO_ICON_FILENAMES[index] = string.gsub(string.upper(GetSpellTexture(spellID)), "INTERFACE\\ICONS\\", "")
							index = index + 1
						end
					end
				end
			end
		end
	end
	GetMacroIcons(MT.MACRO_ICON_FILENAMES)
	GetMacroItemIcons(MT.MACRO_ICON_FILENAMES)
end

function MT:GetSpellorMacroIconInfo(index)
	if not index then return end
	--MT:RefreshPlayerSpellIconInfo()
	--return MT.MACRO_ICON_FILENAMES[index]
	local id, kind, texture = MacroToolkitPopupIcons:GetIconInfo(index)
	return texture
end

local function getFilenameFromPath(path)
	local s, e = string.find(string.lower(path), "interface\\icons\\(.-)")
	return string.sub(path, e + 1)
end

function MT:GetBlizzSpellorMacroIconInfo(index)
	if not index then return end
	local info = MT.MACRO_ICON_FILENAMES[index]
	local texturename
	if type(info) == "number" then
		MacroToolkitFrame.nulltexture:SetToFileData(info)
		texturename = getFilenameFromPath(MacroToolkitFrame.nulltexture:GetTexture())
	else texturename = info end
	return texturename
end

function MT:PopupOkayUpdate()
	local text = MacroToolkitPopupEdit:GetText()
	text = string.gsub(text, "\"", "")
	if string.len(text) > 0 and mtpf.selectedIcon then MacroToolkitPopupOk:Enable()
	else MacroToolkitPopupOk:Disable() end
	if mtpf.mode == "edit" and string.len(text) > 0 then MacroToolkitPopupOk:Enable() end
end

function MT:SelectTexture(selectedIcon)
	mtpf.selectedIcon = selectedIcon
	mtpf.selectedIconTexture = nil
	MacroToolkitSelMacroButtonIcon:SetTexture(format("INTERFACE\\ICONS\\%s", MT:GetSpellorMacroIconInfo(mtpf.selectedIcon)))
	MT:PopupOkayUpdate()
	local mode = mtpf.mode
	mtpf.mode = nil
	mtpf.mode = mode
end

function MT:CancelEdit()
	mtpf:Hide()
	MT:MacroFrameUpdate()
	mtpf.selectedIcon = nil
end

function MT:PopupUpdate(this)
	this = this or mtpf
	local numMacroIcons = #MT.MACRO_ICON_FILENAMES
	local macroPopupIcon, macroPopupButton
	local macroPopupOffset = FauxScrollFrame_GetOffset(MacroToolkitPopupScroll)
	local index
	
	if this.mode == "new" then MacroToolkitPopupEdit:SetText("")
	elseif this.mode == "edit" then
		local name, _, body = GetMacroInfo(MacroToolkitFrame.selectedMacro)
		MacroToolkitPopupEdit:SetText(name)
	end

	local texture
	for i = 1, 30 do
		macroPopupIcon = _G[format("MacroToolkitPopupButton%dIcon", i)]
		macroPopupButton = _G[format("MacroToolkitPopupButton%d", i)]
		index = (macroPopupOffset * _G.NUM_ICONS_PER_ROW) + i
		texture = MT:GetSpellorMacroIconInfo(index)
		if index <= numMacroIcons and texture then
			macroPopupIcon:SetTexture(format("INTERFACE\\ICONS\\%s", texture))
			macroPopupButton:Show()
		else
			macroPopupIcon:SetTexture("")
			macroPopupButton:Hide()
		end
		if mtpf.selectedIcon and index == mtpf.selectedIcon then macroPopupButton:SetChecked(1)
		elseif mtpf.selectedIconTexture == texture then macroPopupButton:SetChecked(1)
		else macroPopupButton:SetChecked(nil) end
	end
	FauxScrollFrame_Update(MacroToolkitPopupScroll, ceil(numMacroIcons / _G.NUM_ICONS_PER_ROW) , 5, _G.MACRO_ICON_ROW_HEIGHT )
end


function MT:PopupButtonOnClick(this) MT:SelectTexture(this:GetID() + (FauxScrollFrame_GetOffset(MacroToolkitPopupScroll) * _G.NUM_ICONS_PER_ROW)) end

function MT:PopupOkayButtonOnClick()
	if InCombatLockdown() then
		MT:CombatMessage()
		MacroToolkitPopup:Hide()
	else
		local index = 1
		local iconTexture = MT:GetSpellorMacroIconInfo(MacroToolkitPopup.selectedIcon)
		local text = MacroToolkitPopupEdit:GetText()
		text = string.gsub(text, "\"", "")
		if MacroToolkitPopup.mode == "new" then
			if PanelTemplates_GetSelectedTab(MacroToolkitFrame) > 2 then
				index = MT:GetNextIndex()
				MT.db.global.extra[index] = {name = text, texture = iconTexture, body = ""}
			else
				index = CreateMacro(text, iconTexture, nil, (MacroToolkitFrame.macroBase > 0))
				MacroToolkitText.extended = nil
			end
		elseif MacroToolkitPopup.mode == "edit" then
			if PanelTemplates_GetSelectedTab(MacroToolkitFrame) == 3 then
				index = MacroToolkitFrame.selectedMacro
				MT.db.global.extra[tostring(index)].name = text
				MT.db.global.extra[tostring(index)].texture = iconTexture
			else index = EditMacro(MacroToolkitFrame.selectedMacro, text, iconTexture) end
		end
		MacroToolkitPopup:Hide()
		MacroToolkitFrame.selectedMacro = tonumber(index)
		MT:MacroFrameUpdate()
		PlaySound("gsTitleOptionOK")
	end
end
		
function MT:UpdateIconCount()
	local icframe = MacroToolkitPopupIcons
	local dy = icframe:GetSectionVisibility("DynamicIcon")
	local ab = icframe:GetSectionVisibility("AbilityIcons")
	local ac = icframe:GetSectionVisibility("AchievementIcons")
	local inv = icframe:GetSectionVisibility("InventoryIcons")
	local it = icframe:GetSectionVisibility("ItemIcons")
	local mi = icframe:GetSectionVisibility("MiscellaneousIcons")
	local sp = icframe:GetSectionVisibility("SpellIcons")
	local dyc, abc, acc, invc, itc, mic, spc = 1, MT.numabilityicons, MT.numachicons, MT.numinvicons, MT.numitemicons, MT.nummiscicons, MT.numspellicons
	local visicons = 0 + (dy and dyc or 0) + (ab and abc or 0) + (ac and acc or 0) + (inv and invc or 0) + (it and itc or 0) + (mi and mic or 0) + (sp and spc or 0)
	local filtered = (not dy) or (not ab) or (not ac) or (not inv) or (not it) or (not mi) or (not sp)
	if filtered then MacroToolkitPopupAvailable:SetFormattedText("%s: %d", _G.AVAILABLE, visicons)
	else MacroToolkitPopupAvailable:SetText("") end
end