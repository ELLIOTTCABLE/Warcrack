--[[--------------------------------------------------------------------
	GridStatusFastHealth.lua
	GridStatus module for faster health update calls of the GridStatusHealth module.
	Created by Suicidal Katt.
----------------------------------------------------------------------]]

local Grid = _G.Grid
local L = Grid.L
local GridFrame = Grid:GetModule("GridFrame", true)
local GridStatus = Grid:GetModule("GridStatus", true)
local GridStatusHealth = GridStatus:GetModule("GridStatusHealth", true)

local GridStatusFastHealth = Grid:NewStatusModule("GridStatusFastHealth", "AceTimer-3.0")
GridStatusFastHealth.menuName = "Fast "..L["Unit Health"]

GridStatusFastHealth.defaultDB = {
	debug = false,
	fast_health = {
		enable = true,
		text = "Fast "..L["Unit Health"],
		color = { r = 0, g = 0, b = 0, a = 0 },
		priority = 80,
		frequency = 0.1,
		range = false,
	},
}

local extraOptions = {
	frequency = {
		name = "Health check frequency",
		desc = "Seconds between health checks",
		order = 20,
		width = "double",
		type = "range", min = 0.01, max = 0.5, step = 0.01,
		get = function()
			return GridStatusFastHealth.db.profile.fast_health.frequency
		end,
		set = function(_, v)
			GridStatusFastHealth.db.profile.fast_health.frequency = v
			GridStatusFastHealth:OnStatusDisable("fast_health")
			GridStatusFastHealth:OnStatusEnable("fast_health")
		end,
	},
	range = false,
}

function GridStatusFastHealth:PostInitialize()
	self:RegisterStatus('fast_health', "Fast Health (No value output)", extraOptions, true)
end

function GridStatusFastHealth:OnStatusEnable(status)
	self.timer = self:ScheduleRepeatingTimer("CheckHealth", self.db.profile.fast_health.frequency)
end

function GridStatusFastHealth:OnStatusDisable(status)
	self:CancelTimer(self.timer, true)
end

function GridStatusFastHealth:CheckHealth()
	if GridStatusHealth then
		GridStatusHealth:UpdateAllUnits()
	end
end