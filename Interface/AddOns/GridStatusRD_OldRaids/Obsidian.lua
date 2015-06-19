-- local zone = "The Obsidian Sanctum"
local zoneid = 531

-- Check Compatibility
if GridStatusRD_OldRaids.rd_version < 502 then
	return
end

--zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

--Trash
GridStatusRaidDebuff:DebuffId(zoneid, 39647, 1, 5, 5) --Curse of Mending
GridStatusRaidDebuff:DebuffId(zoneid, 58936, 2, 5, 5) --Rain of Fire

--Sartharion
GridStatusRaidDebuff:BossNameId(zoneid, 10, "Sartharion")
GridStatusRaidDebuff:DebuffId(zoneid, 60708, 11, 10, 5, false, true) --Fade Armor
GridStatusRaidDebuff:DebuffId(zoneid, 57491, 12, 5, 5, true, false) --Flame Tsunami

