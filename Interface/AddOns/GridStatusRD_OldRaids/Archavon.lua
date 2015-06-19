-- local zone = "Vault of Archavon"
local zoneid = 532
-- Note: updated spell ids as of WoD 6.1 3/7/2015

-- Check Compatibility
if GridStatusRD_OldRaids.rd_version < 502 then
	return
end

--zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

-- Trash
-- Archavon Warder
GridStatusRaidDebuff:DebuffId(zoneid, 60919, 1, 1, 1) -- Rock Shower (dot)
GridStatusRaidDebuff:DebuffId(zoneid, 60897, 1, 2, 2) -- Shield Crush

-- Archavon the Stone Watcher
GridStatusRaidDebuff:BossNameId(zoneid, 10, "Archavon the Stone Watcher")
GridStatusRaidDebuff:DebuffId(zoneid, 58678, 11, 5, 5) -- Rock Shards
GridStatusRaidDebuff:DebuffId(zoneid, 61672, 12, 4, 4) -- Chocking Cloud
GridStatusRaidDebuff:DebuffId(zoneid, 60880, 13, 3, 3) -- Stomp (Stun)

-- Emalon
GridStatusRaidDebuff:BossNameId(zoneid, 20, "Emalon the Storm Watcher")
-- no debuffs

--Koralon
GridStatusRaidDebuff:BossNameId(zoneid, 30, "Koralon the Flame Watcher")
GridStatusRaidDebuff:DebuffId(zoneid, 66684, 31, 5, 5) -- Flaming Cinder

--Toravon
GridStatusRaidDebuff:BossNameId(zoneid, 40, "Toravon the Ice Watcher")
GridStatusRaidDebuff:DebuffId(zoneid, 71993, 41, 5, 5, true, true) --Frozen Mallet
GridStatusRaidDebuff:DebuffId(zoneid, 72004, 42, 5, 5, true, true) --Frostbite
GridStatusRaidDebuff:DebuffId(zoneid, 72090, 43, 5, 5) --Freezing Ground
GridStatusRaidDebuff:DebuffId(zoneid, 72090, 44, 1, 1) --Whiteout

