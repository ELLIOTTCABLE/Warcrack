--[[--------------------------------------------------------------------
	GridStatusHealingReduced
	Grid plugin to show debuffs which reduce or prevent healing received.
	by Phanx <addons@phanx.net>
	Copyright © 2008–2012 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info7364-GridStatusHealingReduced.html
	http://www.curse.com/addons/wow/gridstatushealingreduced
----------------------------------------------------------------------]]

local GridStatusHealingReduced = Grid:GetModule("GridStatus"):NewModule("GridStatusHealingReduced")

------------------------------------------------------------------------

local L = setmetatable({ }, { __index = function(t, k)
	local v = tostring(k)
	rawset(t, k, v)
	return v
end })

do
	local GAME_LOCALE = GetLocale()
	if GAME_LOCALE == "deDE" then
		L["Healing reduced"] = "Heilung reduziert"
		L["Healing prevented"] = "Heilung verhindert"
	elseif GAME_LOCALE == "esES" or GAME_LOCALE == "esMX" then
		L["Healing reduced"] = "Sanación reducida"
		L["Healing prevented"] = "Sanación impedida"
	elseif GAME_LOCALE == "frFR" then
		L["Healing reduced"] = "Soins diminués"
		L["Healing prevented"] = "Soins empêché"
	elseif GAME_LOCALE == "ptBR" or GAME_LOCALE == "ptPT" then
		L["Healing reduced"] = "Cura reduzida"
		L["Healing prevented"] = "Cura impedida"
	elseif GAME_LOCALE == "ruRU" then
		L["Healing reduced"] = "Исцеление уменьшено"
		L["Healing prevented"] = "Препятствие исцелению"
	elseif GAME_LOCALE == "koKR" then
		L["Healing reduced"] = "치유량 감소"
		L["Healing prevented"] = "치유량 방해"
	elseif GAME_LOCALE == "zhCN" then
		L["Healing reduced"] = "治疗效果被降低"
		L["Healing prevented"] = "治疗无效果"
	elseif GAME_LOCALE == "zhTW" then
		L["Healing reduced"] = "治療效果被降低"
		L["Healing prevented"] = "治療無效果"
	end
end

------------------------------------------------------------------------

local ReductionDebuffs = {
	--[[ Classic ]]
	23169,13583,19716,22859,13737,24573,27580,25646,31464,17820,22687,
	78841,43410,19643,32736,
	--[[ The Burning Crusade ]]
	56112,36054,30213,48301,54680,12294,82654,13218,13583,19716,
	22859,13737,24573,27580,25646,31464,17820,22687,40599,41478,45347,
	36023,36917,37335,44268,30641,36814,30423,45885,35189,32858,38377,
	44534,34073,34366,32378,17547,38770,
	--[[ Wrath of the Lich King ]]
	48871,59243,65883,67977,67978,67979,63038,48291,59300,70671,70710,
	15708,16856,35054,57789,65926,67542,68782,68783,68784,71552,28467,
	48137,54378,59265,71127,69674,71224,73022,73023,28776,54121,59525,
	54525,59745,59746,32315,28440,53803,69633,69651,72569,72570,72571,
	54615,52645,44475,80390,60626,
	--[[ Cataclysm ]]
	76189,93956,83908,86157,86158,86159,76727,90526,91801,93675,93771,
	7068,23224,83926,52771,58830,75571,93452,99506,86816,100526,103002,
	--[[ Cataclysm Solo ]]
	83930,101340,
	--[[ Players ]]
	56112,30213,48301,54680,12294,82654,13218,
	--[[ Unknown ]]
	23230,95353,34625,95437,38572,39595,61042,29572,31911,40220,43441,
	95410,54715,54716,59454,59455,36693,46296,68391,60084,68881,24674,
	30984,36974,39665,43461,54074,65962,109388,110310,91099,99476,
}

local PreventionDebuffs = {
	--[[ The Burning Crusade ]]
	41292,42017,30843,
	--[[ Wrath of the Lich King ]]
	59513,55593,
	--[[ Cataclysm ]]
	76903,82170,92787,92981,92982,92983,82890,85576,93181,93182,93183,
	--[[ Cataclysm Solo ]]
	101497,
}

------------------------------------------------------------------------

local UnitDebuff = UnitDebuff
local UnitGUID = UnitGUID

local enabled = 0

local valid = { player = true, pet = true, vehicle = true }
for i = 1, MAX_PARTY_MEMBERS do
	valid["party" .. i] = true
	valid["partypet" .. i] = true
end
for i = 1, MAX_RAID_MEMBERS do
	valid["raid" .. i] = true
	valid["raidpet" .. i] = true
end

------------------------------------------------------------------------

GridStatusHealingReduced.defaultDB = {
	alert_healingReduced = {
		enable = true,
		color = { r = 0.8, g = 0.4, b = 0.8, a = 1 },
		priority = 90,
		range = false,
		text = "H-",
	},
	alert_healingPrevented = {
		enable = true,
		color = { r = 0.6, g = 0.2, b = 0.6, a = 1 },
		priority = 99,
		range = false,
		text = "Hx",
	},
}

------------------------------------------------------------------------

function GridStatusHealingReduced:PostInitialize()
	self:Debug("PostInitialize")

	local RD, PD = { }, { }
	for _, id in ipairs(ReductionDebuffs) do
		local name = GetSpellInfo(id)
		if name then
			RD[id] = name
		end
	end
	for _, id in ipairs(PreventionDebuffs) do
		local name = GetSpellInfo(id)
		if name then
			PD[id] = name
		end
	end
	ReductionDebuffs, PreventionDebuffs = RD, PD

	self:RegisterStatus("alert_healingReduced", L["Healing reduced"], nil, true)
	self:RegisterStatus("alert_healingPrevented", L["Healing prevented"], nil, true)
end

function GridStatusHealingReduced:OnStatusEnable(status)
	self:Debug("OnStatusEnable", status)

	if status ~= "alert_healingReduced" and status ~= "alert_healingPrevented" then return end

	enabled = enabled + 1
	if enabled == 0 then
		self:RegisterEvent("UNIT_AURA", "UpdateUnit")
	end
	self:UpdateAllUnits()
end

function GridStatusHealingReduced:OnStatusDisable(status)
	self:Debug("OnStatusDisable", status)

	if status ~= "alert_healingReduced" and status ~= "alert_healingPrevented" then return end

	enabled = enabled - 1
	if enabled == 0 then
		self:UnregisterEvent("UNIT_AURA")
	end
	self.core:SendStatusLostAllUnits(status)
end

------------------------------------------------------------------------

function GridStatusHealingReduced:UpdateUnit(event, unit)
	if not valid[unit] then return end
	--self:Debug("UpdateUnit", event, unit)

	local prevented, reduced, name, icon, count, duration, expiration, id, _
	for i = 1, 40 do
		name, _, icon, count, _, duration, expiration, _, _, _, id = UnitDebuff(unit, i)
		if not id then
			break
		end
		if duration then
			if PreventionDebuffs[id] then
				self:Debug("Found prevention debuff:", unit, id, name)
				prevented = true
				break
			elseif not reduced and ReductionDebuffs[id] then
				self:Debug("Found reduction debuff:", unit, id, name)
				reduced = true
			end
		end
	end

	local settings
	if prevented then
		reduced = false -- don't show both at once

		self:Debug("SendStatusGained alert_healingPrevented")
		settings = self.db.profile.alert_healingPrevented
		self.core:SendStatusGained(UnitGUID(unit), "alert_healingPrevented",
			settings.priority,
			(settings.range and 40),
			settings.color,
			settings.text,
			nil,
			nil,
			icon,
			expiration and (expiration - duration),
			count)
	else
		--self:Debug("SendStatusLost alert_healingPrevented")
		self.core:SendStatusLost(UnitGUID(unit), "alert_healingPrevented")
	end

	if reduced then
		self:Debug("SendStatusGained: alert_healingReduced")
		settings = self.db.profile.alert_healingReduced
		self.core:SendStatusGained(UnitGUID(unit), "alert_healingReduced",
			settings.priority,
			(settings.range and 40),
			settings.color,
			settings.text,
			nil,
			nil,
			icon,
			expiration and (expiration - duration),
			count)
	else
		--self:Debug("SendStatusGained: alert_healingReduced")
		self.core:SendStatusLost(UnitGUID(unit), "alert_healingReduced")
	end
end

function GridStatusHealingReduced:UpdateAllUnits()
	self:Debug("UpdateAllUnits")
	if enabled > 0 then
		for guid, unitid in Grid:GetModule("GridRoster"):IterateRoster() do
			self:UpdateUnit("UpdateAllUnits", unitid)
		end
	end
end