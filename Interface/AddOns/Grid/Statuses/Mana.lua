--[[--------------------------------------------------------------------
	Grid
	Compact party and raid unit frames.
	Copyright (c) 2006-2014 Kyle Smith (Pastamancer), Phanx
	All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info5747-Grid.html
	http://www.wowace.com/addons/grid/
	http://www.curse.com/addons/wow/grid
------------------------------------------------------------------------
	Mana.lua
	Grid status module for unit mana.
----------------------------------------------------------------------]]

local _, Grid = ...
local L = Grid.L

local GridRoster = Grid:GetModule("GridRoster")
local GridStatus = Grid:GetModule("GridStatus")

local GridStatusMana = GridStatus:NewModule("GridStatusMana")
GridStatusMana.menuName = L["Mana"]

GridStatusMana.defaultDB = {
	alert_lowMana = {
		text = L["Low Mana"],
		enable = true,
		color = { r = .5, g = .5, b = 1, a = 1 },
		priority = 40,
		threshold = 10,
		range = false,
	},
}

GridStatusMana.options = false

local low_manaOptions = {
	["threshold"] = {
		type = "range", width = "double",
		name = L["Mana threshold"],
		desc = L["Set the percentage for the low mana warning."],
		max = 100,
		min = 0,
		step = 1,
		get = function()
			return GridStatusMana.db.profile.alert_lowMana.threshold
		end,
		set = function(_, v)
			GridStatusMana.db.profile.alert_lowMana.threshold = v
		end,
	},
}

function GridStatusMana:PostInitialize()
	self:RegisterStatus("alert_lowMana", L["Low Mana warning"], low_manaOptions, true)
end

function GridStatusMana:OnStatusEnable(status)
	if status ~= "alert_lowMana" then return end

	self:RegisterMessage("Grid_UnitJoined")

	self:RegisterEvent("UNIT_POWER", "UpdateUnit")
	self:RegisterEvent("UNIT_MAXPOWER", "UpdateUnit")
	self:RegisterEvent("UNIT_DISPLAYPOWER", "UpdateUnit")

	self:UpdateAllUnits()
end

function GridStatusMana:OnStatusDisable(status)
	if status ~= "alert_lowMana" then return end

	self:UnregisterMessage("Grid_UnitJoined")

	self:UnregisterEvent("UNIT_POWER")
	self:UnregisterEvent("UNIT_MAXPOWER")
	self:UnregisterEvent("UNIT_DISPLAYPOWER")

	self.core:SendStatusLostAllUnits("alert_lowMana")
end

function GridStatusMana:Grid_UnitJoined(event, guid, unit)
	if unit then
		self:UpdateUnit(event, unit, guid)
	end
end

function GridStatusMana:UpdateAllUnits()
	for guid, unit in GridRoster:IterateRoster() do
		self:UpdateUnit("UpdateAllUnits", unit, guid)
	end
end

local UnitGUID, UnitIsDeadOrGhost, UnitIsVisible, UnitPower, UnitPowerMax, UnitPowerType
    = UnitGUID, UnitIsDeadOrGhost, UnitIsVisible, UnitPower, UnitPowerMax, UnitPowerType

function GridStatusMana:UpdateUnit(event, unit, guid)
	if not guid then guid = UnitGUID(unit) end
	if not GridRoster:IsGUIDInRaid(guid) then return end

	if UnitIsVisible(unit) and not UnitIsDeadOrGhost(unit) and UnitPowerType(unit) == 0 then
		-- mana user and is alive
		local cur = UnitPower(unit, 0)
		local max = UnitPowerMax(unit, 0)
		if max > 0 and self.db.profile.alert_lowMana.threshold > (cur / max * 100) then
			local settings = self.db.profile.alert_lowMana
			return GridStatus:SendStatusGained(guid, "alert_lowMana",
				settings.priority,
				settings.range,
				settings.color,
				settings.text,
				nil,
				nil,
				settings.icon)
		end
	end
	GridStatus:SendStatusLost(guid, "alert_lowMana")
end