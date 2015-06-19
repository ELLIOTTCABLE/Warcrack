-- zone = "Trial of the Crusader"
local zoneid = 543

-- Check Compatibility
if GridStatusRD_OldRaids.rd_version < 502 then
	return
end

--zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

--<< Beast of Northrend >>
--Gormok the Impaler
GridStatusRaidDebuff:BossNameId(zoneid, 10, "Gormok the Impaler")
GridStatusRaidDebuff:DebuffId(zoneid, 66331, 11, 5, 5, true, true) --Impale
GridStatusRaidDebuff:DebuffId(zoneid, 67475, 13, 5, 5, true) --Fire Bomb
GridStatusRaidDebuff:DebuffId(zoneid, 66406, 14, 5, 5) --Snowbolled!

--Acidmaw --Dreadscale
GridStatusRaidDebuff:BossNameId(zoneid, 20, "Jormungar Behemoth")
GridStatusRaidDebuff:DebuffId(zoneid, 67618, 23, 5, 5, true) --Paralytic Toxin
GridStatusRaidDebuff:DebuffId(zoneid, 66869, 24, 5, 5, true) --Burning Bile

--Icehowl
GridStatusRaidDebuff:BossNameId(zoneid, 30, "Icehowl")
GridStatusRaidDebuff:DebuffId(zoneid, 67654, 31, 5, 5, true) --Ferocious Butt
GridStatusRaidDebuff:DebuffId(zoneid, 66689, 32, 5, 5) --Arctic Breathe
GridStatusRaidDebuff:DebuffId(zoneid, 66683, 33, 5, 5) --Massive Crash

--Lord Jaraxxus
GridStatusRaidDebuff:BossNameId(zoneid, 40, "Lord Jaraxxus")
GridStatusRaidDebuff:DebuffId(zoneid, 66532, 41, 5, 5) --Fel Fireball
GridStatusRaidDebuff:DebuffId(zoneid, 66237, 42, 8, 10, true, false, {r=1, g=0, b=0}) --Incinerate Flesh
GridStatusRaidDebuff:DebuffId(zoneid, 66242, 43, 7, 5, true) --Burning Inferno
GridStatusRaidDebuff:DebuffId(zoneid, 66197, 44, 5, 5) --Legion Flame
GridStatusRaidDebuff:DebuffId(zoneid, 66283, 45, 9, 5, true) --Spinning Pain Spike
GridStatusRaidDebuff:DebuffId(zoneid, 66209, 46, 5, 5, true) --Touch of Jaraxxus(hard)
GridStatusRaidDebuff:DebuffId(zoneid, 66211, 47, 5, 5, true) --Curse of the Nether(hard)
GridStatusRaidDebuff:DebuffId(zoneid, 67906, 48, 5, 5) --Mistress's Kiss 10H

--Faction Champions
GridStatusRaidDebuff:BossNameId(zoneid, 50, "Faction Champions")
GridStatusRaidDebuff:DebuffId(zoneid, 65812, 51, 10, 10, true, false, {r=1, g=0, b=0}) --Unstable Affliction
GridStatusRaidDebuff:DebuffId(zoneid, 65960, 52, 5, 5, true) --Blind
GridStatusRaidDebuff:DebuffId(zoneid, 65801, 53, 5, 7) --Polymorph
GridStatusRaidDebuff:DebuffId(zoneid, 65543, 54, 5, 7) --Psychic Scream
GridStatusRaidDebuff:DebuffId(zoneid, 66054, 55, 5, 7) --Hex
GridStatusRaidDebuff:DebuffId(zoneid, 65809, 56, 5, 7) --Fear

--The Twin Val'kyr
GridStatusRaidDebuff:BossNameId(zoneid, 60, "The Twin Val'kyr")
GridStatusRaidDebuff:DebuffId(zoneid, 67176, 61, 5, 10, false, false, {r=1, g=0, b=0}, true) --Dark Essence
GridStatusRaidDebuff:DebuffId(zoneid, 67222, 62, 5, 10, false, false, {r=0, g=0, b=1}, true) --Light Essence
GridStatusRaidDebuff:DebuffId(zoneid, 67283, 63, 7, 5, true) --Dark Touch
GridStatusRaidDebuff:DebuffId(zoneid, 67298, 64, 7, 5, true) --Ligth Touch
GridStatusRaidDebuff:DebuffId(zoneid, 67309, 65, 5, 5, false, true) --Twin Spike

--Anub'arak
GridStatusRaidDebuff:BossNameId(zoneid, 70, "Anub'arak")
GridStatusRaidDebuff:DebuffId(zoneid, 67574, 71, 10, 10) --Pursued by Anub'arak
GridStatusRaidDebuff:DebuffId(zoneid, 66013, 72, 7, 10, true, false, {r=1, g=0, b=0}) --Penetrating Cold (10?)
GridStatusRaidDebuff:DebuffId(zoneid, 67847, 73, 5, 5, false, true) --Expose Weakness
GridStatusRaidDebuff:DebuffId(zoneid, 66012, 74, 5, 5) --Freezing Slash
GridStatusRaidDebuff:DebuffId(zoneid, 67863, 75, 8, 5, false, true) --Acid-Drenched Mandibles(25H)

