--[[--------------------------------------------------------------------
	GridStatusHealingReduced
	Grid plugin to show debuffs which reduce or prevent healing received.
	Copyright (c) 2007-2015 Phanx <addons@phanx.net>. All rights reserved.
	http://www.wowinterface.com/downloads/info7364-GridStatusHealingReduced.html
	http://www.curse.com/addons/wow/gridstatushealingreduced
	https://github.com/Phanx/GridStatusHealingReduced
----------------------------------------------------------------------]]

local GSHR = Grid:GetModule("GridStatus"):NewModule("GridStatusHealingReduced")

------------------------------------------------------------------------

local L = setmetatable({}, { __index = function(t, k)
	local v = tostring(k)
	rawset(t, k, v)
	return v
end })

do
	local GAME_LOCALE = GetLocale()
	if GAME_LOCALE == "deDE" then
		L["Healing reduced"] = "Heilung verringert"
		L["Healing prevented"] = "Heilung verhindert"
	elseif GAME_LOCALE == "esES" or GAME_LOCALE == "esMX" then
		L["Healing reduced"] = "Sanación reducida"
		L["Healing prevented"] = "Sanación impedida"
	elseif GAME_LOCALE == "frFR" then
		L["Healing reduced"] = "Soins diminués"
		L["Healing prevented"] = "Soins empêché"
	elseif GAME_LOCALE == "itIT" then
		L["Healing reduced"] = "Cure ridotti"
		L["Healing prevented"] = "Cure impedito"
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

local _, ns = ...

local ReductionDebuffs = ns.ReductionDebuffs
local PreventionDebuffs = ns.PreventionDebuffs

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

GSHR.defaultDB = {
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

function GSHR:PostInitialize()
	self:Debug("PostInitialize")

	local RD, PD = {}, {}
	for _, id in ipairs(ReductionDebuffs) do
		local name = GetSpellInfo(id)
		if name then
			RD[id] = name
		else
			print("|cffff7f7fGridStatusHealingReduced:|r", id, "is not a valid spell ID, please report this!")
		end
	end
	for _, id in ipairs(PreventionDebuffs) do
		local name = GetSpellInfo(id)
		if name then
			PD[id] = name
		else
			print("|cffff7f7fGridStatusHealingReduced:|r", id, "is not a valid spell ID, please report this!")
		end
	end
	ReductionDebuffs, PreventionDebuffs = RD, PD

	self:RegisterStatus("alert_healingReduced", L["Healing reduced"], nil, true)
	self:RegisterStatus("alert_healingPrevented", L["Healing prevented"], nil, true)
end

function GSHR:OnStatusEnable(status)
	self:Debug("OnStatusEnable", status)

	if status ~= "alert_healingReduced" and status ~= "alert_healingPrevented" then return end

	enabled = enabled + 1
	if enabled == 0 then
		self:RegisterEvent("UNIT_AURA", "UpdateUnit")
	end
	self:UpdateAllUnits()
end

function GSHR:OnStatusDisable(status)
	self:Debug("OnStatusDisable", status)

	if status ~= "alert_healingReduced" and status ~= "alert_healingPrevented" then return end

	enabled = enabled - 1
	if enabled == 0 then
		self:UnregisterEvent("UNIT_AURA")
	end
	self.core:SendStatusLostAllUnits(status)
end

------------------------------------------------------------------------

function GSHR:UpdateUnit(event, unit)
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

function GSHR:UpdateAllUnits()
	self:Debug("UpdateAllUnits")
	if enabled > 0 then
		for guid, unitid in Grid:GetModule("GridRoster"):IterateRoster() do
			self:UpdateUnit("UpdateAllUnits", unitid)
		end
	end
end