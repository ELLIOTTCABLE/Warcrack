local _G = _G

-- addon name and namespace
local ADDON, NS = ...

local Addon = LibStub("AceAddon-3.0"):GetAddon(ADDON)

-- the Tooltip module
local Tooltip = Addon:NewModule("Tooltip")

-- get translations
local L = LibStub:GetLibrary("AceLocale-3.0"):GetLocale(ADDON)

-- tooltip library
local QT = LibStub:GetLibrary("LibQTip-1.0")

-- local functions
local pairs             = pairs
local next              = next
local floor             = floor

-- local variables
local _

local tooltip = nil

-- icons
local ICON_PLUS	 = [[|TInterface\BUTTONS\UI-PlusButton-Up:16:16|t]]
local ICON_MINUS = [[|TInterface\BUTTONS\UI-MinusButton-Up:16:16|t]]

-- callbacks
local function HandleToggleFoldClicked(cell, button)
	Tooltip:ToggleUnfoldType()
	Tooltip:Refresh()
end

local function HandleDestinationTypeClicked(cell, destination, button)
	local options = Addon:GetModule("Options")
	
	if options then
		options:SetSetting("Destination", destination)
		
		Tooltip:Refresh()
	end
end

-- module handling
function Tooltip:OnInitialize()
	self.typeUnfolded = false
end

function Tooltip:OnEnable()
	-- empty
end

function Tooltip:OnDisable()
	self:Remove()
end

function Tooltip:Create(obj)
	if not self:IsEnabled() then
		return
	end

	tooltip = QT:Acquire(ADDON.."TT", 3)
	
	tooltip:Hide()
	tooltip:Clear()
	tooltip:SetScale(1)
		
	self:Draw()

	tooltip:SetAutoHideDelay(.1, obj)
	tooltip:EnableMouse()
	tooltip:SmartAnchorTo(obj)
	tooltip:Show()
end

function Tooltip:Remove()
	if tooltip then
		tooltip:Hide()
		QT:Release(tooltip)
		tooltip = nil
	end
end

function Tooltip:Refresh()
	if not self:IsEnabled() then
		self:Remove()
		return
	end
	
	self:Draw()
	
	tooltip:Show()
end

function Tooltip:Draw()
	if not tooltip then
		return
	end

	tooltip:Hide()
	tooltip:Clear()

	local colcount = tooltip:GetColumnCount()	

	-- module header
	local lineNum = tooltip:AddHeader(" ")
	tooltip:SetCell(lineNum, 1, NS:Colorize("White", Addon.FULLNAME), "CENTER", tooltip:GetColumnCount())
	tooltip:AddLine(" ")
	
	local typeSetting = Addon:GetSetting("Destination")
	
	local destination = nil
	local distance    = "--"
	local target      = L[typeSetting]
	local ping        = "--"
	
	if Addon:GetSticky() then
		destination = Addon:ColorizeChar(Addon.destinationName)
		target = L["Sticky"] .. " (" .. target .. ")"
	elseif typeSetting == "waypoint" then
		if Addon:ValidCoords(Addon.waypoint) then
			destination = NS:PrecisionTxt(Addon.waypoint.x, 2) .. ", " .. NS:PrecisionTxt(Addon.waypoint.y, 2)
		end
	else -- if self.db.profile.Destination ~= "none" then
		if Addon.destinationName then
			destination = Addon:ColorizeChar(Addon.destinationName)
		end
	end
	
	if destination then
		local dist = Addon:GetDistanceToDestination()

		if dist then
			distance = NS:PrecisionTxt(dist, 2) .. " " .. L["yards"]
		end
	else	
		destination = "none"
	end
	
	if Addon.pingerName then
		ping = Addon:ColorizeChar(Addon.pingerName)
	end

	lineNum = tooltip:AddLine(" ")
	tooltip:SetCell(lineNum, 1, L["Destination"] .. ":", "LEFT" )
	tooltip:SetCell(lineNum, 2, destination,  "LEFT" )

	lineNum = tooltip:AddLine(" ")
	tooltip:SetCell(lineNum, 1, L["Type"] .. ":", "LEFT")
	
	local options = Addon:GetModule("Options")
	
	-- toggle type setting +/-
	local unfolded = self:GetUnfoldType()
	
	if options then
		tooltip:SetCell(lineNum, 3, unfolded and ICON_MINUS or ICON_PLUS, "RIGHT")
		tooltip:SetCellScript(lineNum, 3, "OnMouseDown", HandleToggleFoldClicked)
	end
	
	if unfolded and options then
		for destinationType in options:IterateDestinations() do
			if destinationType == typeSetting then
				tooltip:SetCell(lineNum, 2, L[destinationType],  "LEFT")
			else
				tooltip:SetCell(lineNum, 2, NS:Colorize("GrayOut", L[destinationType]),  "LEFT")
			end
			
			tooltip:SetCellScript(lineNum, 2, "OnMouseDown", HandleDestinationTypeClicked, destinationType)
			lineNum = tooltip:AddLine(" ")
		end
	else
		tooltip:SetCell(lineNum, 2, target,  "LEFT")
		lineNum = tooltip:AddLine(" ")
	end

	tooltip:SetCell(lineNum, 1, L["Distance"] .. ":", "LEFT")
	tooltip:SetCell(lineNum, 2, distance, "LEFT")
	
	tooltip:AddLine(" ")
	
	lineNum = tooltip:AddLine(" ")
	tooltip:SetCell(lineNum, 1, L["Last Ping"] .. ":", "LEFT")
	tooltip:SetCell(lineNum, 2, ping,  "LEFT")

	-- And a hint to show options
	if not Addon:GetSetting("HideHint") then
		tooltip:AddLine(" ")

		lineNum = tooltip:AddLine(" ")		
		tooltip:SetCell(lineNum, 1, NS:Colorize("Brownish", L["Left-Click"] .. ": "),        nil, "LEFT")
		tooltip:SetCell(lineNum, 2, NS:Colorize("Yellow",   L["Set target as destination"]), nil, "LEFT")

		lineNum = tooltip:AddLine(" ")
		tooltip:SetCell(lineNum, 1, NS:Colorize("Brownish", L["Right-Click"] .. ": "), nil, "LEFT")
		tooltip:SetCell(lineNum, 2, NS:Colorize("Yellow",   L["Open options menu"]),   nil, "LEFT")
 
		lineNum = tooltip:AddLine(" ")
		tooltip:SetCell(lineNum, 1, NS:Colorize("Brownish", L["Ctrl-Left-Click"] .. ": "),   nil, "LEFT")
		tooltip:SetCell(lineNum, 2, NS:Colorize("Yellow",   L["Stick/unstick destination"]), nil, "LEFT")

		lineNum = tooltip:AddLine(" ")
		tooltip:SetCell(lineNum, 1, NS:Colorize("Brownish", L["Ctrl-Right-Click"] .. ": "), nil, "LEFT")
		tooltip:SetCell(lineNum, 2, NS:Colorize("Yellow",   L["Release arrow"]),            nil, "LEFT")

		lineNum = tooltip:AddLine(" ")
		tooltip:SetCell(lineNum, 1, NS:Colorize("Brownish", L["Shift-Left-Click"] .. ": "), nil, "LEFT")
		tooltip:SetCell(lineNum, 2, NS:Colorize("Yellow",   L["Ping at current location"]), nil, "LEFT")

		lineNum = tooltip:AddLine(" ")
		tooltip:SetCell(lineNum, 1, NS:Colorize("Brownish", L["Alt-Left-Click"] .. ": "),           nil, "LEFT")
		tooltip:SetCell(lineNum, 2, NS:Colorize("Yellow",   L["Set waypoint at target location"]), nil, "LEFT")

		lineNum = tooltip:AddLine(" ")
		tooltip:SetCell(lineNum, 1, NS:Colorize("Brownish", L["Alt-Right-Click"] .. ": "), nil, "LEFT")
		tooltip:SetCell(lineNum, 2, NS:Colorize("Yellow",   L["Clear waypoint"]),          nil, "LEFT")
	end
end

-- folding
function Tooltip:GetUnfoldType()
	return self.typeUnfolded
end

function Tooltip:SetUnfoldType(unfold)
	self.typeUnfolded = unfold and true
end

function Tooltip:ToggleUnfoldType()
	self:SetUnfoldType(not self:GetUnfoldType())
end

-- test
function Tooltip:Debug(msg)
	Addon:Debug("(Tooltip) " .. msg)
end
