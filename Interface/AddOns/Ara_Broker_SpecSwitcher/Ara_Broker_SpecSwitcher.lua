local	BUTTON_HEIGHT,	ICON_SIZE,	GAP,	TEXT_OFFSET,	FONT_SIZE =
	17,		14,		10,	5,		12

local f = CreateFrame("Frame", nil, UIParent)
local g = CreateFrame("Frame", nil, f) -- gear sets
local t = CreateFrame"Frame" -- timers

local highlight = f:CreateTexture()
highlight:SetTexture"Interface\\QuestFrame\\UI-QuestTitleHighlight"
highlight:SetBlendMode"ADD"
highlight:SetAlpha(0)

local backdrop =  {
	bgFile = "Interface\\Buttons\\WHITE8X8",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	edgeSize=16, tile = false, tileSize=0,
	insets = { left=3, right=3, top=3, bottom=3 } }

local ShowGears, specIndex, gears, popupData
local block, char, tip, tipshown, config
local DEFAULT_ICON = "Interface\\Icons\\Spell_Shadow_SacrificialShield"
local orgSetActiveTalentGroup = SetActiveTalentGroup
local POPUP_SET_ALIAS = "ABSS_SET_ALIAS"
local BLOCK, SPEC, GEAR = 0, 1, 2

local spam1 = ERR_LEARN_ABILITY_S:gsub("%.", "%."):gsub("%%s", "(.*)")
local spam2 = ERR_LEARN_SPELL_S:gsub("%.", "%."):gsub("%%s", "(.*)")
local spam3 = ERR_SPELL_UNLEARNED_S:gsub("%.", "%."):gsub("%%s", "(.*)")

local function SpamFilter(self, event, msg)
	if strfind(msg, spam1) or strfind(msg, spam2) or strfind(msg, spam3) then return true end
end


local function OnEquipmentSetChange(oldName, newName)
	for i=1, GetNumTalentGroups() do
		if char[i].set == oldName then char[i].set = newName end
	end
	f:PLAYER_TALENT_UPDATE()
end

hooksecurefunc("ModifyEquipmentSet", OnEquipmentSetChange)
hooksecurefunc("DeleteEquipmentSet", OnEquipmentSetChange)


local function WearSet(arg, isGearIndex) -- defaults to talent group index
	local set = type(arg) == "number" and (isGearIndex and GetEquipmentSetInfo(arg) or char[arg].set) or type(arg) == "string" and arg
	if set and GetEquipmentSetInfoByName(set) then UseEquipmentSet(set) end
end

local function DelayWearSet(self, elapsed)
	t:SetScript("OnUpdate",nil)
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_SYSTEM", SpamFilter)
	WearSet(GetActiveTalentGroup())
end

function SetActiveTalentGroup(...)
	f:RegisterEvent"UNIT_SPELLCAST_SUCCEEDED"
	f:RegisterEvent"UNIT_SPELLCAST_STOP"
	ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", SpamFilter)
	return orgSetActiveTalentGroup(...)
end

function f:UNIT_SPELLCAST_STOP(event, unit)
	if unit ~= "player" then return end
	f:UnregisterEvent"UNIT_SPELLCAST_SUCCEEDED"
	f:UnregisterEvent"UNIT_SPELLCAST_STOP"
	if event == "UNIT_SPELLCAST_SUCCEEDED" then return t:SetScript("OnUpdate", DelayWearSet) end
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_SYSTEM", SpamFilter)
end
f.UNIT_SPELLCAST_SUCCEEDED = f.UNIT_SPELLCAST_STOP


local function GetTalentText(group)
	local maxPoints, finalIcon, text = 0, DEFAULT_ICON
	for tab = 1, 3 do
		local icon, points = select( 4, GetTalentTabInfo(tab,nil,nil,group) )
		if points > maxPoints then
			maxPoints = points
			finalIcon = icon
		end
		text = ("%s%.2i"):format(text and text.."/" or "", points)
	end
	return text, finalIcon
end


local hints = {
	[BLOCK] =
[[|cffffd100Hints [|cffffffffBlock|r|cffffd100]|r
$Click|r to swap talent spec.
$Right-Click|r to open talent frame.
$Middle-Click|r to toggle hints.]],
	[SPEC] =
[[|cffffd100Hints|r
$Click|r to set an alias.
$Shift+Click|r to equip set.
$Middle-Click|r to toggle hints.
$MouseWheel|r to resize tooltip.]],
	[GEAR] =
[[|cffffd100Hints|r
$Click|r to associate set.
$Shift+Click|r to equip set.]],
}

local function UpdateHints(cat)
	if cat == BLOCK and (not f.onBlock or config.hideBlockHints) or cat ~= BLOCK and config.hideHints then return tip:Hide() end
	local showRight = f:GetCenter() > UIParent:GetWidth()/config.scale/2 and "LEFT" or "RIGHT"
	local showBelow = select(2, f:GetCenter()) > UIParent:GetHeight()/config.scale/2 and "TOP" or "BOTTOM"
	tip:SetOwner(f, "ANCHOR_NONE")
	tip:SetPoint(showBelow..showRight, f, (showBelow == "TOP" and "BOTTOM" or "TOP")..showRight )

	tip:AddLine(hints[cat]:gsub("%$","|cffff8020"), .2, 1, .2)
	tip:Show()
end


local function Gear_OnClick(button, click)
	if click == "LeftButton" and IsShiftKeyDown() then
		return button.index > 0 and WearSet(button.index, true)
	end
	local spec = char[specIndex]
	spec.set = button.index > 0 and button.gearName:GetText() or nil

	for i, b in next, gears do
		local gearName = b.gearName:GetText()
		if gearName == spec.set or not spec.set and gearName == NONE then b.check:Show() else b.check:Hide() end
	end
	f:PLAYER_TALENT_UPDATE()
end

local function Spec_OnClick(button, click)
	if click == "LeftButton" and IsShiftKeyDown() then
		return WearSet(button.index)
	elseif click == "MiddleButton" then
		config.hideHints = not config.hideHints
		return UpdateHints(SPEC)
	end

	local data = char[button.index]
	if StaticPopup_FindVisible( POPUP_SET_ALIAS, data ) then
		return StaticPopup_Hide( POPUP_SET_ALIAS, data )
	end

	local specName, specIcon = GetTalentText(button.index)
	if not StaticPopupDialogs[POPUP_SET_ALIAS] then
		local dialog = {
			text = "Set an alias for %s (spec %i).\nLeave blank to remove alias.",
			button3 = "Use gear set",
			OnAccept = function(self, spec)
				local input = self.editBox:GetText()
				spec[popupData] = input ~= "" and input or nil
				spec.aliasIsSetName = false
				f:PLAYER_TALENT_UPDATE()
			end,
			OnShow = function(self, spec)
				self.editBox:SetText(spec[popupData]or"")
				self.editBox:SetFocus()
			end,
			OnAlt = function(self, spec)
				spec.aliasIsSetName = true
				f:PLAYER_TALENT_UPDATE()
			end,
			EditBoxOnEnterPressed = function(self, spec)
				local p = self:GetParent()
				StaticPopupDialogs[POPUP_SET_ALIAS].OnAccept(p, spec)
				p:Hide()
			end,
			EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
			multiple = true,
		}
		for k, v in next, StaticPopupDialogs.RENAME_GUILD do
			if not dialog[k] then dialog[k] = v end
		end
		dialog.OnCancel, dialog.OnAlt = dialog.OnAlt, dialog.OnCancel
		dialog.button3, dialog.button2 = dialog.button2, dialog.button3
		StaticPopupDialogs[POPUP_SET_ALIAS] = dialog
	end

	local talentPlate = (" |T%s:17:17:0:0:25:25:2:23:2:23|t %s"):format( specIcon, button.specName:GetText() )
	popupData = specName
	StaticPopup_Show( POPUP_SET_ALIAS, talentPlate, button.index, data)
end


local function Gear_OnEnter(b)
	if not (b and b.index) then return end
	highlight:SetAllPoints(b)
	highlight:SetAlpha(1)
	UpdateHints(GEAR)
end

local function Gear_OnLeave(b)
	highlight:ClearAllPoints()
	tip:Hide()
	if b then highlight:SetAlpha(0) end
	if not (g:IsMouseOver() or f:IsMouseOver() or f.onBlock) then f:Hide() end
end

local function Menu_OnEnter(b)
	if not (b and b.index) then return end
	highlight:SetAllPoints(b)
	highlight:SetAlpha(1)
	UpdateHints(SPEC)
	ShowGears(b.index)
end

local function Menu_OnLeave(b)
	highlight:ClearAllPoints()
	tip:Hide()
	if b then highlight:SetAlpha(0) end
	if not (g:IsMouseOver() or f:IsMouseOver() or f.onBlock) then f:Hide() end
end

local function CreateTx(parent, ...)
	local tx = parent:CreateTexture()
	tx:SetSize( ICON_SIZE, ICON_SIZE )
	tx:SetTexCoord( 2/25, 23/25, 2/25, 23/25 )
	tx:SetPoint(...)
	return tx
end

local baseFont = GameFontNormal:GetFont()

local function CreateFS(parent, justify, ...)
	local fs = parent:CreateFontString( nil, "OVERLAY", "SystemFont_Shadow_Med1" )
	fs:SetJustifyH(justify)
	fs:SetFont(baseFont, FONT_SIZE)
	fs:SetPoint(...)
	return fs
end

gears = setmetatable( {}, { __index = function( table, key )
	local button = CreateFrame( "Button", nil, g )
	table[key] = button
	button.index = key
	button:RegisterForClicks"AnyUp"
	button:SetScript( "OnEnter", Gear_OnEnter )
	button:SetScript( "OnLeave", Gear_OnLeave )
	button:SetScript( "OnClick", Gear_OnClick )

	button:SetHeight(BUTTON_HEIGHT)
	button.check = CreateTx(button, "LEFT")
	button.check:SetTexture"Interface\\Buttons\\UI-CheckBox-Check"
	button.gearIcon = CreateTx(button, "LEFT", button.check, "RIGHT", TEXT_OFFSET, 0)
	button.gearName = CreateFS(button, "LEFT", "LEFT", button.gearIcon, "RIGHT", TEXT_OFFSET, 0)

	local y = -GAP - key*BUTTON_HEIGHT
	button:SetPoint("TOPLEFT", GAP, y)
	button:SetPoint("TOPRIGHT", -GAP, y)
	return button
end } )

local function SetGearData(index, checked, gearIcon, gearName)
	local button = gears[index]
	if checked then button.check:Show() else button.check:Hide() end
	button.gearIcon:SetTexture(gearIcon)
	button.gearName:SetText(gearName)
	return button, button.gearName:GetStringWidth()
end

local buttons = setmetatable( {}, { __index = function( table, key )
	local button = CreateFrame( "Button", nil, f )
	table[key] = button
	button.index = key
	button:RegisterForClicks"AnyUp"
	button:SetScript( "OnEnter", Menu_OnEnter )
	button:SetScript( "OnLeave", Menu_OnLeave )
	button:SetScript( "OnClick", Spec_OnClick)

	button:SetHeight(BUTTON_HEIGHT)
	button.specIcon = CreateTx(button, "LEFT")
	button.specName = CreateFS(button, "LEFT", "LEFT", ICON_SIZE + TEXT_OFFSET, 0)
	button.aliasText= CreateFS(button, "LEFT", "LEFT", button.specName, "RIGHT", GAP, 0)
	button.gearName = CreateFS(button, "LEFT", "RIGHT")
	button.gearName:SetTextColor(1,.82,0)
	button.gearIcon = CreateTx(button, "RIGHT", button.gearName, "LEFT", -TEXT_OFFSET, 0)

	local y = -GAP - (key-1)*BUTTON_HEIGHT
	button:SetPoint("TOPLEFT", GAP, y)
	button:SetPoint("TOPRIGHT", -GAP, y)
	return button
end } )


local function SetButtonData(index, active, specIcon, specName, alias, gearIcon, gearName)
	local button = buttons[index]
	button.specIcon:SetTexture(specIcon)
	button.specName:SetFormattedText("%s%s|r", active and "|cff19ff19" or "|cffff1919", specName)
	if alias then button.aliasText:SetFormattedText("|cffffffff%s",alias) else button.aliasText:SetText"" end
	button.gearIcon:SetTexture(gearIcon and "Interface\\Icons\\"..gearIcon or "")
	button.gearName:SetText(gearIcon and gearName or "")
	return	button,
		button.specName:GetStringWidth(),
		alias and button.aliasText:GetStringWidth() or 0,
		gearIcon and button.gearName:GetStringWidth() or 0
end


local function UpdateTablet()
	f:SetScale(config.scale)
	local talentGroup = GetActiveTalentGroup()
	local specC, aliasC, gearC = 0, 0, 0
	local hasAlias, hasGear
	local nbSpec = GetNumTalentGroups()
	for i = 1, nbSpec do
		local specName, specIcon = GetTalentText(i)
		local group = char[i]
		local alias, gearName, gearIcon = group[specName], group.set

		if gearName then
			hasGear = true
			gearIcon = GetEquipmentSetInfoByName(gearName or "")
		end

		if alias then
			hasAlias = true
		end

		local button, specW, aliasW, gearW =
			SetButtonData(i, i==talentGroup, specIcon, specName, alias, gearIcon, gearName)

		if specW > specC then specC = specW end
		if aliasW > aliasC then aliasC = aliasW end
		if gearW > gearC then gearC = gearW end
	end
	local maxWidth = ICON_SIZE + TEXT_OFFSET + specC + (hasAlias and GAP + aliasC or 0) + (hasGear and GAP + ICON_SIZE + TEXT_OFFSET + gearC or 0)
	for index, button in next, buttons do
		if hasAlias then button.specName:SetWidth(specC) end
		if hasGear then button.gearName:SetWidth(gearC) end
	end
	f:SetSize( GAP + maxWidth + GAP, GAP + nbSpec * BUTTON_HEIGHT + GAP )
	if not (f.onBlock or f:IsMouseOver() or g:IsMouseOver()) then f:Hide() end
end


ShowGears = function(_specIndex)
	specIndex = _specIndex
	local nbGear = GetNumEquipmentSets()
	if not nbGear or nbGear == 0 then return end
	g:Show()
	local currGear = char[specIndex].set
	local button, maxWidth = SetGearData(0, not currGear, "", NONE)
	for i=1, nbGear do
		local gearName, gearIcon = GetEquipmentSetInfo(i)
		local button, width = SetGearData(i, currGear == gearName, gearIcon, gearName)
		if width > maxWidth then maxWidth = width end
	end
	g:SetSize( (GAP + ICON_SIZE + TEXT_OFFSET)*2 + maxWidth, GAP + (nbGear+1) * BUTTON_HEIGHT + GAP )
	for k, v in next, gears do if k>nbGear then v:Hide() else v:Show() end end

	g:ClearAllPoints()
	local horiz = f:GetCenter() > UIParent:GetWidth()/config.scale/2 and "RIGHT" or "LEFT"
	local verti = (f:GetPoint()=="TOP"and f:GetTop() or f:GetBottom()) > UIParent:GetHeight()*.5 and "TOP" or "BOTTOM"
	g:SetPoint(verti..horiz, f, verti..(horiz=="LEFT"and"RIGHT"or"LEFT"), 0, (1-specIndex)*BUTTON_HEIGHT )
end


local tiptacBKG = { tile = false, insets = {} }
-- Setup Gradient Tip (from TipTac)
local function SetupGradientTip(tip,cfg)
	local g = tip.ttGradient;
	if not cfg.gradientTip then
		return g and g:Hide()
	elseif not g then
		g = tip:CreateTexture()
		g:SetTexture(1,1,1,1)
		tip.ttGradient = g
	end
	g:SetGradientAlpha("VERTICAL",0,0,0,0,unpack(cfg.gradientColor))
	g:SetPoint("TOPLEFT",cfg.backdropInsets,cfg.backdropInsets * -1)
	g:SetPoint("BOTTOMRIGHT",tip,"TOPRIGHT",cfg.backdropInsets * -1,-36)
	g:Show()
end


local function SetTabletBG(frame, cfg)
	if TipTac then
		frame:SetBackdrop(tiptacBKG)
		frame:SetBackdropColor(unpack(cfg.tipColor))
		frame:SetBackdropBorderColor(unpack(cfg.tipBorderColor))
		SetupGradientTip(frame,cfg)
	elseif Skinner then
		Skinner:applySkin(frame)
	else
		frame:SetBackdrop(backdrop)
		if frame.ttGradient then frame.ttGradient:Hide() end
		frame:SetBackdropColor(.1, .1, .1, .85)
		frame:SetBackdropBorderColor(.3, .3, .3, .9)
	end
end

local function AnchorTablet(frame)
	f:Show()
	f.isTop, f.onBlock = select(2, frame:GetCenter()) > UIParent:GetHeight() / 2, true
	f:ClearAllPoints()
	f:SetPoint(f.isTop and "TOP" or "BOTTOM", frame, f.isTop and "BOTTOM" or "TOP")
	local cfg
	if TipTac then
		cfg = TipTac_Config
		tiptacBKG.bgFile = cfg.tipBackdropBG
		tiptacBKG.edgeFile = cfg.tipBackdropEdge
		tiptacBKG.edgeSize = cfg.backdropEdgeSize
		tiptacBKG.insets.left = cfg.backdropInsets
		tiptacBKG.insets.right = cfg.backdropInsets
		tiptacBKG.insets.top = cfg.backdropInsets
		tiptacBKG.insets.bottom = cfg.backdropInsets
	end
	SetTabletBG(f, cfg)
	SetTabletBG(g, cfg)
	UpdateHints(BLOCK)
	UpdateTablet()
end


block = LibStub("LibDataBroker-1.1"):NewDataObject("|cFFFFB366Ara|r SpecSwitcher", {
	type = "data source",
	icon = DEFAULT_ICON,
	iconCoords = { .08, .92, .08, .92 },
	text = "00/00/00",

	OnEnter = AnchorTablet,

	OnLeave = function()
		f.onBlock = nil
		tip:Hide()
		if not f:IsMouseOver() then
			f:Hide()
		end
	end,

	OnClick = function(self, button)
		if button == "RightButton" then
			ToggleTalentFrame()
		elseif button == "MiddleButton" then
			config.hideBlockHints = not config.hideBlockHints
			UpdateHints(BLOCK)
		else
			SetActiveTalentGroup( 3 - GetActiveTalentGroup() )
		end
	end
})


function f:PLAYER_TALENT_UPDATE()
	local curr = char[GetActiveTalentGroup()]
	local spec, icon = GetTalentText()
	block.icon = curr.aliasIsSetName and GetEquipmentSetInfoByName(curr.set or "") and ("Interface\\Icons\\"..GetEquipmentSetInfoByName(curr.set or "")) or icon
	block.text = curr.aliasIsSetName and curr.set or curr[spec] or spec
	if f:IsVisible() then UpdateTablet() end
end

function f:ACTIVE_TALENT_GROUP_CHANGED()
	t:SetScript("OnUpdate", DelayWearSet)
end

function f:ADDON_LOADED(event, addon)
	if addon ~= "Ara_Broker_SpecSwitcher" then return end
	AraSpecSwitcherDBPC = AraSpecSwitcherDBPC or { {}, {} }
	char = AraSpecSwitcherDBPC
	AraSpecSwitcherDB = AraSpecSwitcherDB or { scale=1 }
	config = AraSpecSwitcherDB

	f:SetBackdrop(backdrop)
	f:SetFrameStrata"TOOLTIP"
	f:SetClampedToScreen(true)

	f:SetScript( "OnEnter", Menu_OnEnter )
	f:SetScript( "OnLeave", Menu_OnLeave )
	f:SetScript( "OnHide", function() g:Hide() end )
	f:SetScript( "OnMouseWheel", function(self, delta)
		config.scale = config.scale - delta * 0.05
		UpdateTablet()
	end)

	g:SetBackdrop(backdrop)
	g:SetFrameStrata"TOOLTIP"
	g:SetFrameLevel(0)
	g:SetScript( "OnEnter", Gear_OnEnter )
	g:SetScript( "OnLeave", Gear_OnLeave)

	t:SetScript( "OnUpdate", function() t:SetScript("OnUpdate", nil) f:PLAYER_TALENT_UPDATE() end )
	f:RegisterEvent"PLAYER_TALENT_UPDATE"
	f:RegisterEvent"ACTIVE_TALENT_GROUP_CHANGED"
	f:RegisterEvent"PLAYER_ENTERING_WORLD"
	f:RegisterEvent"PLAYER_LEAVING_WORLD"
	tip = GameTooltip

	f:UnregisterEvent(event)
	f.ADDON_LOADED = nil
end

function f:PLAYER_LEAVING_WORLD() f:UnregisterEvent"PLAYER_TALENT_UPDATE" end
function f:PLAYER_ENTERING_WORLD() f:RegisterEvent"PLAYER_TALENT_UPDATE" end

f:SetScript( "OnEvent", function(self, event, ...) return self[event](self, event, ...) end )
f:RegisterEvent"ADDON_LOADED"