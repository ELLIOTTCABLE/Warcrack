-- local zone = "Tempest Keep"
local zoneid = 782

-- Check Compatibility
if GridStatusRD_OldRaids.rd_version < 502 then
	return
end

--zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

--Trash
GridStatusRaidDebuff:DebuffId(zoneid, 37123, 1, 5, 5) --Saw Blade
GridStatusRaidDebuff:DebuffId(zoneid, 37120, 2, 5, 5) --Fragmentation Bomb
GridStatusRaidDebuff:DebuffId(zoneid, 37118, 3, 5, 5) --Shell Shock

--Solarian
GridStatusRaidDebuff:BossNameId(zoneid, 30, "High Astromancer Solarian")
GridStatusRaidDebuff:DebuffId(zoneid, 42783, 31, 5, 5, true) --Wrath of the Astromancer

--Kaeltahas
GridStatusRaidDebuff:BossNameId(zoneid, 40, "Kael'thas Sunstrider")
GridStatusRaidDebuff:DebuffId(zoneid, 37027, 41, 5, 5) --Remote Toy
GridStatusRaidDebuff:DebuffId(zoneid, 36798, 42, 5, 5) --Mind Control

