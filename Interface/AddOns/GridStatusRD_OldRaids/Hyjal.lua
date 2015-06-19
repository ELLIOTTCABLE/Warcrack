-- local zone = "Hyjal Summit"
local zoneid = 775

-- Check Compatibility
if GridStatusRD_OldRaids.rd_version < 502 then
	return
end

--zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

--Winterchill
GridStatusRaidDebuff:BossNameId(zoneid, 10, "Rage Winterchill")
GridStatusRaidDebuff:DebuffId(zoneid, 31249, 11, 5, 5, true) --Ice Bolt

--Aneteron
GridStatusRaidDebuff:BossNameId(zoneid, 20, "Anetheron")
GridStatusRaidDebuff:DebuffId(zoneid, 31306, 21, 5, 5) --Carrion Swarm
GridStatusRaidDebuff:DebuffId(zoneid, 31298, 22, 5, 5, true) --Sleep

--Azgalor
GridStatusRaidDebuff:BossNameId(zoneid, 30, "Azgalor")
GridStatusRaidDebuff:DebuffId(zoneid, 31347, 31, 5, 5, true) --Doom
GridStatusRaidDebuff:DebuffId(zoneid, 31341, 32, 5, 5, true) --Unquenchable Flames
GridStatusRaidDebuff:DebuffId(zoneid, 31344, 33, 5, 5, true) --Howl of Azgalor

--Achimonde
GridStatusRaidDebuff:BossNameId(zoneid, 40, "Archimonde")
GridStatusRaidDebuff:DebuffId(zoneid, 31944, 41, 5, 5, true) --Doomfire
GridStatusRaidDebuff:DebuffId(zoneid, 31972, 42, 5, 5) --Grip

