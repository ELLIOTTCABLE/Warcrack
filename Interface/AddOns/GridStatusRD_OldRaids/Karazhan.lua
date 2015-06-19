-- local zone = "Karazhan"
local zoneid = 799

-- Check Compatibility
if GridStatusRD_OldRaids.rd_version < 502 then
	return
end

--zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

--Moroes
GridStatusRaidDebuff:BossNameId(zoneid, 10, "Moroes")
GridStatusRaidDebuff:DebuffId(zoneid, 37066, 11, 5, 5) --Garrote

--Maiden
GridStatusRaidDebuff:BossNameId(zoneid, 20, "Maiden of Virtue")
GridStatusRaidDebuff:DebuffId(zoneid, 29522, 21, 5, 5) --Holy Fire
GridStatusRaidDebuff:DebuffId(zoneid, 29511, 22, 5, 5) --Repentance

--Opera : Bigbad wolf
GridStatusRaidDebuff:BossNameId(zoneid, 30, "The Big Bad Wolf")
GridStatusRaidDebuff:DebuffId(zoneid, 30753, 31, 5, 5, true) --Red riding hood

--Illhoof
GridStatusRaidDebuff:BossNameId(zoneid, 40, "Terestian Illhoof")
GridStatusRaidDebuff:DebuffId(zoneid, 30115, 41, 5, 5) --Sacrifice

--Malche
GridStatusRaidDebuff:BossNameId(zoneid, 50, "Prince Malchezaar")
GridStatusRaidDebuff:DebuffId(zoneid, 30843, 51, 5, 5) --Enfeeble

