--[[--------------------------------------------------------------------
	PhanxConfig-Dropdown
	Simple color picker widget generator.
	Based on tekKonfig-Dropdown by Tekkub.
	Requires LibStub.

	This library is not intended for use by other authors. Absolutely no
	support of any kind will be provided for other authors using it, and
	its internals may change at any time without notice.
----------------------------------------------------------------------]]

local MINOR_VERSION = tonumber(("$Revision: 79 $"):match("%d+"))

local lib, oldminor = LibStub:NewLibrary("PhanxConfig-Dropdown", MINOR_VERSION)
if not lib then return end

local function Frame_OnEnter(self)
	if self.desc then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText(self.desc, nil, nil, nil, nil, true)
	end
end

local function Button_OnEnter(self)
	return Frame_OnEnter(self:GetParent():GetParent())
end

local function OnLeave()
	GameTooltip:Hide()
end

local function OnClick(self)
	PlaySound("igMainMenuOptionCheckBoxOn")
	ToggleDropDownMenu(nil, nil, self:GetParent(), nil, 12, 22)
end

local function OnHide()
	CloseDropDownMenus()
end

local function GetValue(self)
	return UIDropDownMenu_GetSelectedValue(self.dropdown) or self.valueText:GetText()
end

local function SetValue(self, value, text)
	UIDropDownMenu_SetSelectedValue(self.dropdown, value or "UNKNOWN")
	self.valueText:SetText(text or value)
end

local i = 0
function lib.CreateDropdown(parent, name, init, desc)
	assert( type(parent) == "table" and parent.CreateFontString, "PhanxConfig-Button: Parent is not a valid frame!" )
	if type(name) ~= "string" then name = nil end
	if type(desc) ~= "string" then desc = nil end

	i = i + 1

	local frame = CreateFrame("Frame", nil, parent)
	frame:SetWidth(186)
	frame:SetHeight(42)
	frame:EnableMouse(true)
	frame:SetScript("OnEnter", Frame_OnEnter)
	frame:SetScript("OnLeave", OnLeave)
	frame:SetScript("OnHide", OnHide)

	frame.bg = frame:CreateTexture(nil, "BACKGROUND")
	frame.bg:SetAllPoints(true)
	frame.bg:SetTexture(0, 0, 0, 0)

	frame.desc = desc

	local dropdown = CreateFrame("Frame", "PhanxConfigDropdown" .. i, frame)
	dropdown:SetPoint("BOTTOMLEFT", -16, -4)
	dropdown:SetPoint("BOTTOMRIGHT", 15, -4)
	dropdown:SetHeight(32)
	frame.dropdown = dropdown

	local ltex = dropdown:CreateTexture(dropdown:GetName() .. "Left", "ARTWORK")
	ltex:SetTexture("Interface\\Glues\\CharacterCreate\\CharacterCreate-LabelFrame")
	ltex:SetTexCoord(0, 0.1953125, 0, 1)
	ltex:SetPoint("TOPLEFT", dropdown, 0, 17)
	ltex:SetWidth(25)
	ltex:SetHeight(64)

	local rtex = dropdown:CreateTexture(nil, "BORDER")
	rtex:SetTexture("Interface\\Glues\\CharacterCreate\\CharacterCreate-LabelFrame")
	rtex:SetTexCoord(0.8046875, 1, 0, 1)
	rtex:SetPoint("TOPRIGHT", dropdown, 0, 17)
	rtex:SetWidth(25)
	rtex:SetHeight(64)

	local mtex = dropdown:CreateTexture(nil, "BORDER")
	mtex:SetTexture("Interface\\Glues\\CharacterCreate\\CharacterCreate-LabelFrame")
	mtex:SetTexCoord(0.1953125, 0.8046875, 0, 1)
	mtex:SetPoint("LEFT", ltex, "RIGHT")
	mtex:SetPoint("RIGHT", rtex, "LEFT")
	mtex:SetHeight(64)

	local icon = dropdown:CreateTexture(dropdown:GetName() .. "Icon", "OVERLAY")
	frame.icon = icon

	local label = dropdown:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	label:SetPoint("TOPLEFT", frame, 5, 0)
	label:SetPoint("TOPRIGHT", frame, -5, 0)
	label:SetJustifyH("LEFT")
	label:SetText(name)
	frame.labelText = label

	local value = dropdown:CreateFontString(dropdown:GetName() .. "Text", "OVERLAY", "GameFontHighlightSmall")
	value:SetPoint("LEFT", ltex, 26, 0)
	value:SetPoint("RIGHT", rtex, -43, 0)
	value:SetJustifyH("LEFT")
	value:SetHeight(10)
	frame.valueText = value

	local button = CreateFrame("Button", nil, dropdown)
	button:SetPoint("TOPRIGHT", rtex, -16, -18)
	button:SetWidth(24)
	button:SetHeight(24)
	button:SetScript("OnEnter", Button_OnEnter)
	button:SetScript("OnLeave", OnLeave)
	button:SetScript("OnClick", OnClick)
	frame.button = button

	button:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up")
	button:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down")
	button:SetDisabledTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Disabled")
	button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
	button:GetHighlightTexture():SetBlendMode("ADD")

	frame.GetValue = GetValue
	frame.SetValue = SetValue

	if type(init) == "function" then
		UIDropDownMenu_Initialize(dropdown, init)
	end

	return frame
end