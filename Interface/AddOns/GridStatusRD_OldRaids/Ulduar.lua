-- local zone = "Ulduar"
local zoneid = 529

-- Check Compatibility
if GridStatusRD_OldRaids.rd_version < 502 then
	return
end

--zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

--Trash
GridStatusRaidDebuff:DebuffId(zoneid, 63612, 2, 5, 5, true, true) --Lightning Brand
GridStatusRaidDebuff:DebuffId(zoneid, 63615, 3, 10, 5, true, true) --Ravage Armor
GridStatusRaidDebuff:DebuffId(zoneid, 63169, 6, 5, 5, true, true) --Petrify Joints

--Razorscale
GridStatusRaidDebuff:BossNameId(zoneid, 10, "Razorscale")
GridStatusRaidDebuff:DebuffId(zoneid, 64771, 11, 5, 5, true) --Fuse Armor

--Ignis the Furnace Master
GridStatusRaidDebuff:BossNameId(zoneid, 15, "Ignis the Furnace Master")
GridStatusRaidDebuff:DebuffId(zoneid, 62548, 16, 5, 5, true) --Scorch
GridStatusRaidDebuff:DebuffId(zoneid, 62680, 17, 5, 5) --Flame Jet
GridStatusRaidDebuff:DebuffId(zoneid, 62717, 18, 6, 5, true) --Slag Pot

--XT-002
GridStatusRaidDebuff:BossNameId(zoneid, 20, "XT-002 Deconstructor")
GridStatusRaidDebuff:DebuffId(zoneid, 63024, 21, 5, 5, true) --Gravity Bomb
GridStatusRaidDebuff:DebuffId(zoneid, 63018, 22, 5, 5, true) --Light Bomb

--The Assembly of Iron
GridStatusRaidDebuff:BossNameId(zoneid, 30, "The Iron Council")
GridStatusRaidDebuff:DebuffId(zoneid, 61888, 31, 5, 5, true) --Overwhelming Power
GridStatusRaidDebuff:DebuffId(zoneid, 62269, 32, 6, 5) --Rune of Death
GridStatusRaidDebuff:DebuffId(zoneid, 61903, 33, 5, 5) --Fusion Punch
GridStatusRaidDebuff:DebuffId(zoneid, 61912, 34, 5, 5, true) --Static Disruption

--Kologarn
GridStatusRaidDebuff:BossNameId(zoneid, 40, "Kologarn")
GridStatusRaidDebuff:DebuffId(zoneid, 64290, 41, 5, 5, true) --Stone Grip
GridStatusRaidDebuff:DebuffId(zoneid, 63355, 42, 10, 5, true, true) --Crunch Armor
GridStatusRaidDebuff:DebuffId(zoneid, 62055, 43, 5, 5, false, true) --Brittle Skin

--Hodir
GridStatusRaidDebuff:BossNameId(zoneid, 50, "Hodir")
GridStatusRaidDebuff:DebuffId(zoneid, 62469, 51, 5, 5) --Freeze
GridStatusRaidDebuff:DebuffId(zoneid, 61969, 52, 10, 5) --Flash Freeze
GridStatusRaidDebuff:DebuffId(zoneid, 62188, 53, 5, 5, false, true, nil, true) --Biting Cold

--Thorim
GridStatusRaidDebuff:BossNameId(zoneid, 60, "Thorim")
GridStatusRaidDebuff:DebuffId(zoneid, 62042, 61, 5, 5) --Stormhammer
GridStatusRaidDebuff:DebuffId(zoneid, 62130, 62, 10, 5, true) --Unbalancing Strike
GridStatusRaidDebuff:DebuffId(zoneid, 62526, 63, 5, 5, true) --Rune Detonation
GridStatusRaidDebuff:DebuffId(zoneid, 62470, 64, 5, 5, false, false, nil, true) --Deafening Thunder
GridStatusRaidDebuff:DebuffId(zoneid, 62331, 65, 5, 5) --Impale

--Freya
GridStatusRaidDebuff:BossNameId(zoneid, 70, "Freya")
GridStatusRaidDebuff:DebuffId(zoneid, 62589, 71, 5, 5, true) --Nature's Fury
GridStatusRaidDebuff:DebuffId(zoneid, 62861, 73, 5, 5) --Iron Roots

--Mimiron
GridStatusRaidDebuff:BossNameId(zoneid, 80, "Mimiron")
GridStatusRaidDebuff:DebuffId(zoneid, 63666, 81, 5, 5, true) --Napalm Shell
GridStatusRaidDebuff:DebuffId(zoneid, 62997, 82, 5, 5, true) --Plasma Blast
GridStatusRaidDebuff:DebuffId(zoneid, 64668, 83, 5, 5) --Magnetic Field

--General Vezax
GridStatusRaidDebuff:BossNameId(zoneid, 90, "General Vezax")
GridStatusRaidDebuff:DebuffId(zoneid, 63276, 91, 10, 5, true) --Mark of the Faceless
GridStatusRaidDebuff:DebuffId(zoneid, 63322, 92, 5, 5, false, true) --Saronite Vapors

--Yogg-Saron
GridStatusRaidDebuff:BossNameId(zoneid, 100, "Yogg-Saron")
GridStatusRaidDebuff:DebuffId(zoneid, 63134, 101, 10, 5, true) --Sara's Bless
GridStatusRaidDebuff:DebuffId(zoneid, 63138, 102, 5, 10, true, false, {r=1,g=0,b=0}) --Sara's Fevor
GridStatusRaidDebuff:DebuffId(zoneid, 63830, 103, 5, 5, true) --Malady of the Mind
GridStatusRaidDebuff:DebuffId(zoneid, 63802, 104, 5, 5) --Brain Link(Heroic)
GridStatusRaidDebuff:DebuffId(zoneid, 63042, 105, 5, 5, true) --Dominate Mind
GridStatusRaidDebuff:DebuffId(zoneid, 64156, 106, 5, 7) --Apathy
GridStatusRaidDebuff:DebuffId(zoneid, 64153, 107, 5, 7) --Black Plague
GridStatusRaidDebuff:DebuffId(zoneid, 64157, 108, 5, 7) --Curse of Doom
GridStatusRaidDebuff:DebuffId(zoneid, 64152, 109, 5, 7) --Draining Poison (Heroic)
GridStatusRaidDebuff:DebuffId(zoneid, 64125, 110, 10, 5) --Squeeze
GridStatusRaidDebuff:DebuffId(zoneid, 63050, 111, 5, 5, false, false, nil, true) --Sanity

--Algalon
GridStatusRaidDebuff:BossNameId(zoneid, 120, "Algalon the Observer")
GridStatusRaidDebuff:DebuffId(zoneid, 64412, 121, 5, 5, true, true) --Phase Punch

