local _G = _G

-- addon name and namespace
local ADDON, NS = ...

local Addon = LibStub("AceAddon-3.0"):GetAddon(ADDON)

-- the DataBroker module
local DataBroker = Addon:NewModule("DataBroker")

-- local functions
local pairs   = pairs
local tinsert = table.insert

-- aux variables
local _

-- setup libs
local LibStub   = LibStub
local LDB       = LibStub:GetLibrary("LibDataBroker-1.1")

-- translations
local L = LibStub:GetLibrary("AceLocale-3.0"):GetLocale(ADDON)

-- module data
local moduleData = {
	-- the data broker object
	ldbObj    = nil,
}

-- module handling
function DataBroker:OnInitialize()	
	-- create the minimap button
	self:Create()
end

function DataBroker:OnEnable()
	-- empty
end

function DataBroker:OnDisable()
	-- empty
end

function DataBroker:Create()
	moduleData.ldbObj = LDB:NewDataObject(ADDON, {
		type		= "data source",
		icon		= Addon:GetIcon(),
		iconCoords	= {0, 0, 0, 1, 1, 0, 1, 1},
		label		= Addon.MODNAME,
		text		= Addon.SHORTNAME,
		OnClick 	= function(clickedframe, button) 
			Addon:OnClick(button) 
		end,
		OnEnter 	= function(self)
			Addon:CreateTooltip(self)
		end,
		OnLeave 	= function()
			-- Addon:RemoveTooltip()
			return
		end,
	})
end

function DataBroker:SetIcon(icon)
	icon = type("string") and icon or ""

	if icon ~= moduleData.ldbObj.icon then
		moduleData.ldbObj.icon = icon
	end
end

function DataBroker:GetIcon()
	return moduleData.ldbObj.icon
end

function DataBroker:SetIconTexCoord(xUL, yUL, xLL, yLL, xUR, yUR, xLR, yLR)
	moduleData.ldbObj.iconCoords = {xUL, yUL, xLL, yLL, xUR, yUR, xLR, yLR}
end

function DataBroker:GetIconTexCoord()
	return unpack(moduleData.ldbObj.iconCoords)
end

function DataBroker:SetText(text)
	text = type("string") and text or ""

	if text ~= moduleData.ldbObj.text then
		moduleData.ldbObj.text = text
	end
end

function DataBroker:GetText()
	return moduleData.ldbObj.text
end

function DataBroker:SetValue(key, value)
	moduleData.ldbObj[key] = value
end

function DataBroker:GetValue(key)
	return moduleData.ldbObj[key]
end

-- test
function DataBroker:Debug(msg)
	Addon:Debug("(DataBroker) " .. msg)
end
