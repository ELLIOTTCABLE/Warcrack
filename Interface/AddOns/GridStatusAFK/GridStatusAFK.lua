local _, ns = ...

--[[
if GetLocale() == "enUS" then ns.L = {
	["AFK"] = true,
	["<AFK>"] = true,
	["AFK alert"] = true,
} end
--]]

if GetLocale() == "deDE" then ns.L = {
	["AFK"] = "AFK",
	["<AFK>"] = "<AFK>",
	["AFK alert"] = "AFK Alarm",
} end

if GetLocale() == "koKR" then ns.L = {
	["AFK"] = "자리비움",
	["<AFK>"] = "<자리비움>",
	["AFK alert"] = "자리비움 경고",
} end

if GetLocale() == "zhTW" then ns.L = {
	["AFK"] = "暫離",
	["<AFK>"] = "<暫離>",
	["AFK alert"] = "暫離警告",
} end

if GetLocale() == "zhCN" then ns.L = {
	["AFK"] = "暂离",
	["<AFK>"] = "<暂离>",
	["AFK alert"] = "暂离警告",
} end

if not ns.L then ns.L = {} end
local L = setmetatable(ns.L, {
	__index = function(t, k)
		t[k] = k
		return k
	end
})

local GridRoster = Grid:GetModule("GridRoster")

local GridStatusAFK = Grid:GetModule("GridStatus"):NewModule("GridStatusAFK", "AceTimer-3.0")
GridStatusAFK.menuName = L["AFK"]
GridStatusAFK.options = false

GridStatusAFK.defaultDB = {
	debug = false,
	alert_afk = {
		text = L["<AFK>"],
		enable = false,
		color = { r = 0.5, g = 0.5, b = 0.5, a = 0.5 },
		priority = 20,
		range = false,
	},
}

local UnitIsAFK, UnitGUID = UnitIsAFK, UnitGUID

local afkers={}

function GridStatusAFK:OnInitialize()
	self.super.OnInitialize(self)

	self:RegisterStatus("alert_afk", L["AFK alert"], nil, true)
end

function GridStatusAFK:OnEnable()
	self.debugging = self.db.profile.debug
	self:Debug("OnEnable")

	self.super.OnEnable(self)
end

function GridStatusAFK:Reset()
	self.super.Reset(self)
	afkers={}

	self.core:SendStatusLostAllUnits("alert_afk")
	self:UnregisterStatus("alert_afk")
	self:RegisterStatus("alert_afk", L["AFK alert"], nil, true)

	self:UpdateAllUnits()
end


function GridStatusAFK:OnStatusEnable(status)
	self:RegisterEvent("PLAYER_FLAGS_CHANGED", "OnUnitEvent")	-- Immediately tells us about changes to units <100 yds from us
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "UpdateAllUnits")	-- Happens when we e.g. zone into an instance
	self:RegisterEvent("READY_CHECK", "UpdateAllUnits")
	self:RegisterEvent("READY_CHECK_FINISHED", "UpdateAllUnits")
	self:RegisterMessage("Grid_UnitJoined")
	self:RegisterMessage("Grid_UnitOffline")
	self.UpdateAllUnitsTimer = self:ScheduleRepeatingTimer("UpdateAllUnits", 5.07)	-- Once in a while, poll everyone to catch changes to units outside our range (yes, oddball interval to keep it from overlapping with everyone else's 1s timers all the time)
	self:UpdateAllUnits()
end

function GridStatusAFK:OnStatusDisable(status)
	self.core:SendStatusLostAllUnits(status)
	self:UnregisterAllEvents()
	self:UnregisterMessage("Grid_UnitJoined")
	self:UnregisterMessage("Grid_UnitOffline")
	self:CancelTimer(self.UpdateAllUnitsTimer, true)
	afkers={}
end


local function setStatus(guid, afk)
	if afk then
		afkers[guid]=true
		local settings = GridStatusAFK.db.profile.alert_afk
		GridStatusAFK.core:SendStatusGained(guid, "alert_afk",
						settings.priority,
						(settings.range and 40),
						settings.color,
						settings.text
		)
	else
		afkers[guid]=nil
		GridStatusAFK.core:SendStatusLost(guid, "alert_afk")
	end
end

function GridStatusAFK:UpdateAllUnits()
	for guid, unitid in GridRoster:IterateRoster() do
		local afk = UnitIsAFK(unitid)
		if (not not afk) ~= (not not afkers[guid]) then
			setStatus(guid, afk)
		end
	end
end

function GridStatusAFK:OnUnitEvent(event, unitid)
	local guid = UnitGUID(unitid)
	if (not GridRoster:IsGUIDInRaid(guid)) then
		return
	end
	setStatus(guid,UnitIsAFK(unitid))
end

function GridStatusAFK:Grid_UnitJoined(event, guid, unitid)
	setStatus(guid, UnitIsAFK(unitid)) 
end

function GridStatusAFK:Grid_UnitOffline(event, guid)
	setStatus(guid, false)
end
