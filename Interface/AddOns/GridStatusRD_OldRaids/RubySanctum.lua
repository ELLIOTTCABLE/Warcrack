-- local zone = "The Ruby Sanctum"
local zoneid = 609

-- Check Compatibility
if GridStatusRD_OldRaids.rd_version < 502 then
	return
end

--zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

--Trash
GridStatusRaidDebuff:DebuffId(zoneid, 13737, 1, 5, 5, true) --Mortal Strike
GridStatusRaidDebuff:DebuffId(zoneid, 15621, 2, 5, 5) --Skull Crack
GridStatusRaidDebuff:DebuffId(zoneid, 75413, 3, 5, 5, true) --Flame Wave
GridStatusRaidDebuff:DebuffId(zoneid, 75418, 4, 5, 5) --Shockwave

--Saviana Ragefire
GridStatusRaidDebuff:BossNameId(zoneid, 10, "Saviana Ragefire")
GridStatusRaidDebuff:DebuffId(zoneid, 74453, 11, 5, 5, true) --Flame Beacon
GridStatusRaidDebuff:DebuffId(zoneid, 74456, 12, 5, 5, true) --Conflagration

--Baltharus the Warborn
GridStatusRaidDebuff:BossNameId(zoneid, 15, "Baltharus the Warborn")
GridStatusRaidDebuff:DebuffId(zoneid, 74505, 16, 5, 5, false, true) --Enervating Brand
GridStatusRaidDebuff:DebuffId(zoneid, 74509, 17, 5, 5) --Repelling Wave

--General Zarithrian
GridStatusRaidDebuff:BossNameId(zoneid, 20, "General Zarithrian")
GridStatusRaidDebuff:DebuffId(zoneid, 74384, 21, 5, 5, true) --Intimidating Roar
GridStatusRaidDebuff:DebuffId(zoneid, 74367, 22, 5, 5, false, true) --Cleave Armor

--Halion
GridStatusRaidDebuff:BossNameId(zoneid, 30, "Halion")
GridStatusRaidDebuff:DebuffId(zoneid, 74567, 31, 5, 5, true, true) --Mark of Combustion
GridStatusRaidDebuff:DebuffId(zoneid, 74795, 32, 5, 5, true, true) --Mark of Consumption

