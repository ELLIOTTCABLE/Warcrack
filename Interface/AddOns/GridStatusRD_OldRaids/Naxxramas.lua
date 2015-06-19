-- local zone = "Naxxramas"
local zoneid = 535

-- Check Compatibility
if GridStatusRD_OldRaids.rd_version < 502 then
	return
end

--zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

--Trash
GridStatusRaidDebuff:DebuffId(zoneid, 55314, 1, 5, 5) --Strangulate

--Anub'Rekhan
GridStatusRaidDebuff:BossNameId(zoneid, 10, "Anub'Rekhan")
GridStatusRaidDebuff:DebuffId(zoneid, 28786, 11, 5, 5, true, true) --Locust Swarm


--Grand Widow Faerlina
GridStatusRaidDebuff:BossNameId(zoneid, 20, "Grand Widow Faerlina")
GridStatusRaidDebuff:DebuffId(zoneid, 28796, 21, 5, 5, false, true) --Poison Bolt Volley
GridStatusRaidDebuff:DebuffId(zoneid, 28794, 22, 5, 5) --Rain of Fire


--Maexxna
GridStatusRaidDebuff:BossNameId(zoneid, 25, "Maexxna")
GridStatusRaidDebuff:DebuffId(zoneid, 28622, 26, 5, 5) --Web Wrap
GridStatusRaidDebuff:DebuffId(zoneid, 54121, 27, 5, 5) --Necrotic Poison


--Noth the Plaguebringer
GridStatusRaidDebuff:BossNameId(zoneid, 30, "Noth the Plaguebringer")
GridStatusRaidDebuff:DebuffId(zoneid, 29213, 31, 5, 5, true) --Curse of the Plaguebringer
GridStatusRaidDebuff:DebuffId(zoneid, 29214, 32, 5, 5, true) --Wrath of the Plaguebringer
GridStatusRaidDebuff:DebuffId(zoneid, 29212, 33, 5, 5) --Cripple

--Heigan the Unclean
GridStatusRaidDebuff:BossNameId(zoneid, 40, "Heigan the Unclean")
GridStatusRaidDebuff:DebuffId(zoneid, 29998, 41, 5, 5) --Decrepit Fever
GridStatusRaidDebuff:DebuffId(zoneid, 29310, 42, 5, 5, false, false, nil, true) --Spell Disruption

--Grobbulus
GridStatusRaidDebuff:BossNameId(zoneid, 50, "Grobbulus")
GridStatusRaidDebuff:DebuffId(zoneid, 28169, 51, 5, 5, true) --Mutating Injection

--Gluth
GridStatusRaidDebuff:BossNameId(zoneid, 60, "Gluth")
GridStatusRaidDebuff:DebuffId(zoneid, 54378, 61, 5, 5, true) --Mortal Wound
GridStatusRaidDebuff:DebuffId(zoneid, 29306, 62, 5, 5) --Infected Wound

--Thaddius
GridStatusRaidDebuff:BossNameId(zoneid, 65, "Thaddius")
GridStatusRaidDebuff:DebuffId(zoneid, 28084, 66, 5, 5, false, false, {r = 1, g = 0, b = 0}, true) --Negative Charge
GridStatusRaidDebuff:DebuffId(zoneid, 28059, 67, 5, 5, false, false, {r = 0, g = 0, b = 1}, true) --Positive Charge


--Instructor Razuvious
GridStatusRaidDebuff:BossNameId(zoneid, 70, "Instructor Razuvious")
GridStatusRaidDebuff:DebuffId(zoneid, 55550, 71, 5, 5, true) --Jagged Knife

--Sapphiron
GridStatusRaidDebuff:BossNameId(zoneid, 80, "Sapphiron")
GridStatusRaidDebuff:DebuffId(zoneid, 28522, 81, 5, 5) --Icebolt
GridStatusRaidDebuff:DebuffId(zoneid, 28542, 82, 5, 5) --Life Drain

--Kel'Thuzad
GridStatusRaidDebuff:BossNameId(zoneid, 100, "Kel'Thuzad")
GridStatusRaidDebuff:DebuffId(zoneid, 28410, 101, 5, 5, true) --Chains of Kel'Thuzad
GridStatusRaidDebuff:DebuffId(zoneid, 27819, 102, 5, 5) --Detonate Mana
GridStatusRaidDebuff:DebuffId(zoneid, 27808, 103, 5, 5) --Frost Blast

