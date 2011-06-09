--[[--------------------------------------------------------------------
	PhanxConfig-Checkbox
	Simple checkbox widget generator.
	Based on tekKonfig-Checkbox by Tekkub.
	Requires LibStub.

	This library is not intended for use by other authors. Absolutely no
	support of any kind will be provided for other authors using it, and
	its internals may change at any time without notice.
----------------------------------------------------------------------]]

local MINOR_VERSION = tonumber(("$Revision: 72 $"):match("%d+"))

local lib, oldminor = LibStub:NewLibrary("PhanxConfig-Checkbox", MINOR_VERSION)
if not lib then return end

local function OnEnter(self)
	if self.desc then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText(self.desc, nil, nil, nil, nil, true)
	end
end

local function OnLeave()
	GameTooltip:Hide()
end

local function OnClick(self)
	local checked = self:GetChecked() == 1
	PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
	if self.OnClick then
		self.OnClick(self, checked)
	end
end

local function OnDisable(self)
	if self.disabled then return end
	local r, g, b = self.label:GetTextColor()
	self.label:SetTextColor(r/2, g/2, b/2)
	self.disabled = true
end

local function OnEnable(self)
	if not self.disabled then return end
	local r, g, b = self.label:GetTextColor()
	self.label:SetTextColor(r*2, g*2, b*2)
	self.disabled = nil
end

function lib.CreateCheckbox(parent, text, desc)
	assert( type(parent) == "table" and parent.CreateFontString, "PhanxConfig-Checkbox: Parent is not a valid frame!" )
	if type(name) ~= "string" then name = nil end
	if type(desc) ~= "string" then desc = nil end

	local check = CreateFrame("CheckButton", nil, parent)
	check:SetWidth(26)
	check:SetHeight(26)

	check:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up")
	check:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down")
	check:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight")
	check:SetDisabledCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
	check:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")

	check:SetScript("OnDisable", OnDisable)
	check:SetScript("OnEnable", OnEnable)

	check:SetScript("OnEnter", OnEnter)
	check:SetScript("OnLeave", OnLeave)
	check:SetScript("OnClick", OnClick)

	local label = check:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	label:SetPoint("LEFT", check, "RIGHT", 0, 1)
	label:SetText(text)
	check.label = label

	check:SetHitRectInsets(0, -1 * math.min( 186, math.max( label:GetStringWidth(), 100 ) ), 0, 0)

	check.desc = desc

	return check
end