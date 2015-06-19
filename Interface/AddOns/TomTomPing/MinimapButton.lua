local _G = _G

-- addon name and namespace
local ADDON, NS = ...

local Addon = LibStub("AceAddon-3.0"):GetAddon(ADDON)

-- the MinimapButton module
local MinimapButton = Addon:NewModule("MinimapButton")

-- local functions
local pairs   = pairs
local tinsert = table.insert

local GetCursorPosition = _G.GetCursorPosition
local IsShiftKeyDown    = _G.IsShiftKeyDown
local IsControlKeyDown  = _G.IsControlKeyDown

-- aux variables
local _

-- translations
local L = LibStub:GetLibrary("AceLocale-3.0"):GetLocale(ADDON)

local function MoveButton(self)
	if MinimapButton.dragMode == "free" then
		local centerX, centerY = Minimap:GetCenter()
		local x, y = GetCursorPosition()
		x, y = x / self:GetEffectiveScale() - centerX, y / self:GetEffectiveScale() - centerY
		self:ClearAllPoints()
		self:SetPoint("CENTER", x, y)
	else
		local centerX, centerY = Minimap:GetCenter()
		local x, y = GetCursorPosition()
		x, y = x / self:GetEffectiveScale() - centerX, y / self:GetEffectiveScale() - centerY
		centerX, centerY = abs(x), abs(y)
		centerX, centerY = (centerX / sqrt(centerX^2 + centerY^2)) * 80, (centerY / sqrt(centerX^2 + centerY^2)) * 80
		centerX = x < 0 and -centerX or centerX
		centerY = y < 0 and -centerY or centerY
		self:ClearAllPoints()
		self:SetPoint("CENTER", centerX, centerY)
	end
end

-- module data
local moduleData = {
	-- settings
	show     = false,
	icon     = nil,
	
	-- button
	button   = nil,
	dragMode = nil,
}

-- module handling
function MinimapButton:OnInitialize()	
	-- create the minimap button
	self:Create()
end

function MinimapButton:OnEnable()
	self:Refresh()
end

function MinimapButton:OnDisable()
	self:Refresh()
end

function MinimapButton:Create()
	local button = CreateFrame("Button", ADDON .. "_MinimapButton", Minimap)
	button:SetHeight(32)
	button:SetWidth(32)
	button:SetFrameStrata("HIGH")
	button:SetPoint("CENTER", -77.44, -20.06)
	button:SetMovable(true)
	button:SetUserPlaced(true)
	button:EnableMouse(true)
	button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	button:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
	
	local icon = button:CreateTexture(button:GetName() .. "Icon", "HIGH")
	icon:SetTexture(Addon:GetIcon(false))
	icon:SetTexCoord(0, 1, 0, 1)
	icon:SetWidth(16)
	icon:SetHeight(16)
	icon:SetPoint("CENTER", button, "CENTER", 0, 0)
	
	button.icon = icon
	
	local overlay = button:CreateTexture(button:GetName() .. "Overlay", "OVERLAY")
	overlay:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
	overlay:SetWidth(53)
	overlay:SetHeight(53)
	overlay:SetPoint("TOPLEFT", button, "TOPLEFT")
	
	button:SetScript("OnClick", function(self, mousebutton)
		Addon:OnClick(mousebutton)
	end)
	
	button:SetScript("OnMouseDown", function(self, mousebutton)
		if IsShiftKeyDown() and IsControlKeyDown() then
			moduleData.dragMode = "free"
			self:SetScript("OnUpdate", MoveButton)
		elseif IsShiftKeyDown() then
			moduleData.dragMode = nil
			self:SetScript("OnUpdate", MoveButton)
		end
	end)
	
	button:SetScript("OnMouseUp", function(self)
		self:SetScript("OnUpdate", nil)
	end)

	button:SetScript("OnEnter", function(self)
		Addon:CreateTooltip(self)
	end)
	
	button:SetScript("OnLeave", function(self)
		Addon:RemoveTooltip()
	end)
	
	button:Hide()
	
	moduleData.button = button
end

function MinimapButton:SetIcon(icon)
	icon = type("string") and icon or ""

	if icon ~= moduleData.icon then
		moduleData.icon = icon
		moduleData.button.icon:SetTexture(icon)
	end
end

function MinimapButton:GetIcon()
	return moduleData.icon
end

function MinimapButton:SetIconTexCoord(xUL, yUL, xLL, yLL, xUR, yUR, xLR, yLR)
	if moduleData.button.icon then
		moduleData.button.icon:SetTexCoord(xUL, yUL, xLL, yLL, xUR, yUR, xLR, yLR)
	end
end

function MinimapButton:GetIconTexCoord()
	if moduleData.button.icon then
		moduleData.button.icon:GetTexCoord()
	end
end

function MinimapButton:SetShow(show)
	show = show and true or false

	if show ~= moduleData.show then
		moduleData.show = show
		
		self:Refresh()
	end
end

function MinimapButton:GetShow()
	return moduleData.show
end

function MinimapButton:Refresh()
	if moduleData.show and self:IsEnabled() then
		moduleData.button:Show()
	else
		moduleData.button:Hide()
	end
end

function MinimapButton:IsShown()
	return moduleData.button:IsShown()
end

-- test
function MinimapButton:Debug(msg)
	Addon:Debug("(MinimapButton) " .. msg)
end
