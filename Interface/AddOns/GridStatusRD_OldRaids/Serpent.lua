-- local zone = "Serpentshrine Cavern"
local zoneid = 780

-- Check Compatibility
if GridStatusRD_OldRaids.rd_version < 502 then
	return
end

--zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

--Trash
GridStatusRaidDebuff:DebuffId(zoneid, 39042, 1, 5, 5) --Rampent Infection
GridStatusRaidDebuff:DebuffId(zoneid, 39044, 2, 5, 5, true) --Serpentshrine Parasite

--Hydross
GridStatusRaidDebuff:BossNameId(zoneid, 10, "Hydross the Unstable")
GridStatusRaidDebuff:DebuffId(zoneid, 38235, 11, 5, 5, true) --Water Tomb
GridStatusRaidDebuff:DebuffId(zoneid, 38246, 12, 5, 5) --Vile Sludge

--Morogrim
GridStatusRaidDebuff:BossNameId(zoneid, 20, "Morogrim Tidewalker")
GridStatusRaidDebuff:DebuffId(zoneid, 37850, 21, 5, 5, true) --Watery Grave

--Leotheras
GridStatusRaidDebuff:BossNameId(zoneid, 30, "Leotheras the Blind")
GridStatusRaidDebuff:DebuffId(zoneid, 37676, 31, 5, 5) --insidious whisper
GridStatusRaidDebuff:DebuffId(zoneid, 37641, 32, 5, 5, true) --Whirl wind
GridStatusRaidDebuff:DebuffId(zoneid, 37749, 33, 5, 5) --Madness

--Vashj
GridStatusRaidDebuff:BossNameId(zoneid, 40, "Lady Vashj")
GridStatusRaidDebuff:DebuffId(zoneid, 38280, 34, 5, 5, true) --Static Charge

