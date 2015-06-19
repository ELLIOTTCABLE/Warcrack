-- local zone = "Sunwell Plateau"
local zoneid = 789

-- Check Compatibility
if GridStatusRD_OldRaids.rd_version < 502 then
	return
end

--zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

--Trash
GridStatusRaidDebuff:DebuffId(zoneid, 46561, 1, 5, 5) --Fear
GridStatusRaidDebuff:DebuffId(zoneid, 46562, 2, 5, 5) --Mind Flay
GridStatusRaidDebuff:DebuffId(zoneid, 46266, 3, 5, 5) --Burn Mana
GridStatusRaidDebuff:DebuffId(zoneid, 46557, 4, 5, 5) --Slaying Shot
GridStatusRaidDebuff:DebuffId(zoneid, 46560, 5, 5, 5) --Shadow Word: Pain
GridStatusRaidDebuff:DebuffId(zoneid, 46543, 6, 5, 5) --Ignite Mana
GridStatusRaidDebuff:DebuffId(zoneid, 46427, 7, 5, 5) --Domination

--Kalecgos
GridStatusRaidDebuff:BossNameId(zoneid, 10, "Kalecgos")
GridStatusRaidDebuff:DebuffId(zoneid, 45032, 11, 5, 5, true) --Curse of Boundless Agony
GridStatusRaidDebuff:DebuffId(zoneid, 45018, 12, 5, 5) --Arcane Buffet

--Brutallus
GridStatusRaidDebuff:BossNameId(zoneid, 20, "Brutallus")
GridStatusRaidDebuff:DebuffId(zoneid, 46394, 21, 5, 5, true) --Burn
GridStatusRaidDebuff:DebuffId(zoneid, 45150, 22, 5, 5, false, true) --Meteor Slash

--Felmyst
GridStatusRaidDebuff:BossNameId(zoneid, 30, "Felmyst")
GridStatusRaidDebuff:DebuffId(zoneid, 45855, 31, 5, 5) --Gas Nova
GridStatusRaidDebuff:DebuffId(zoneid, 45662, 32, 5, 5, true) --Encapsulate(dosen't have Combat Log)
GridStatusRaidDebuff:DebuffId(zoneid, 45402, 33, 5, 5) --Demonic Vapor
GridStatusRaidDebuff:DebuffId(zoneid, 45717, 34, 5, 5) --Fog of Corruption*unit is hostile in comabtlog event)

--Twins
GridStatusRaidDebuff:BossNameId(zoneid, 40, "The Eredar Twins")
GridStatusRaidDebuff:DebuffId(zoneid, 45256, 41, 5, 5) --Confounding Blow
GridStatusRaidDebuff:DebuffId(zoneid, 45333, 42, 5, 5) --Conflagration
GridStatusRaidDebuff:DebuffId(zoneid, 46771, 43, 5, 5) --Flame Sear
GridStatusRaidDebuff:DebuffId(zoneid, 45270, 44, 5, 5) --Shadowfury
GridStatusRaidDebuff:DebuffId(zoneid, 45347, 45, 5, 5, false, false, {r = 1, g = 0, b = 0}, true) --Dark Touched
GridStatusRaidDebuff:DebuffId(zoneid, 45348, 46, 5, 5, false, false, {r = 0, g = 0, b = 1}, true) --Fire Touched

--Muru
GridStatusRaidDebuff:BossNameId(zoneid, 50, "M'uru")
GridStatusRaidDebuff:DebuffId(zoneid, 45996, 51, 5, 5) --Darkness

--Kiljaeden
GridStatusRaidDebuff:BossNameId(zoneid, 60, "Kil'jaeden")
GridStatusRaidDebuff:DebuffId(zoneid, 45442, 61, 5, 5) --Soul Flay
GridStatusRaidDebuff:DebuffId(zoneid, 45641, 62, 5, 5, true) --Fire Bloom
GridStatusRaidDebuff:DebuffId(zoneid, 45885, 63, 5, 5, true) --Shadow Spike
GridStatusRaidDebuff:DebuffId(zoneid, 45737, 64, 5, 5, true) --Flame Dart

