-- local zone = "Tempest Keep"
-- AKA, "The Eye"
local zoneid = 782
-- Note: updated spell IDs as of WoD 6.1 3/7/2015

-- Check Compatibility
if GridStatusRD_OldRaids.rd_version < 502 then
	return
end

--zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

--Trash
-- Crystalcore Mechanic
GridStatusRaidDebuff:DebuffId(zoneid, 37123, 1, 3, 3) --Saw Blade (dot)

-- Tempest-Smith
GridStatusRaidDebuff:DebuffId(zoneid, 37120, 1, 3, 3) --Fragmentation Bomb
GridStatusRaidDebuff:DebuffId(zoneid, 37118, 1, 2, 2, true) --Shell Shock (stun)

-- Crimson Hand Blood Knight, Bloodwarder Vindicator, Bloodwarder Squire
GridStatusRaidDebuff:DebuffId(zoneid, 39077, 1, 4, 4, true) --Hammer of Justice Shock (stun, magic)

-- Crimson Hand Battle Mage
GridStatusRaidDebuff:DebuffId(zoneid, 39087, 1, 1, 1, true) -- Frost Attack (slow)
GridStatusRaidDebuff:DebuffId(zoneid, 37262, 1, 2, 2, true) -- Frostbolt Volley (slow, magic)

-- Crimson Hand Inquisitor
GridStatusRaidDebuff:DebuffId(zoneid, 37275, 1, 4, 4, true) --Shadow Word: Pain (dot, magic)

-- Star Scryer, Nether Scryer
GridStatusRaidDebuff:DebuffId(zoneid, 37122, 1, 4, 4, true) --Domination (charm)

-- Apprentice Star Scryer
GridStatusRaidDebuff:DebuffId(zoneid, 37132, 1, 4, 4, true) --Arcane Shock (dot, magic)

-- Novice Astromancer
GridStatusRaidDebuff:DebuffId(zoneid, 37279, 1, 3, 3) --Rain of Fire (dot)

-- Tempest Falconer
GridStatusRaidDebuff:DebuffId(zoneid, 37155, 1, 3, 3, true) --Immolation (dot)

-- Void Reaver
GridStatusRaidDebuff:BossNameId(zoneid, 10, "Void Reaver")

-- Al'ar
GridStatusRaidDebuff:BossNameId(zoneid, 20, "Al'ar")
GridStatusRaidDebuff:DebuffId(zoneid, 34121, 21, 2, 2, true, true) --Flame Buffet
GridStatusRaidDebuff:DebuffId(zoneid, 35410, 22, 3, 3, true) --Melt Armor

--Solarian
GridStatusRaidDebuff:BossNameId(zoneid, 30, "High Astromancer Solarian")
GridStatusRaidDebuff:DebuffId(zoneid, 42783, 31, 5, 5, true) --Wrath of the Astromancer
GridStatusRaidDebuff:DebuffId(zoneid, 34322, 32, 5, 5, true) --Psychic Scream (fear, magic)

--Kaeltahas
GridStatusRaidDebuff:BossNameId(zoneid, 40, "Kael'thas Sunstrider")
GridStatusRaidDebuff:DebuffId(zoneid, 36798, 41, 5, 5) --Mind Control
GridStatusRaidDebuff:DebuffId(zoneid, 36834, 42, 5, 5, true) --Arcane Disruption (disorient)
-- Thaladred the Darkener
GridStatusRaidDebuff:DebuffId(zoneid, 36965, 43, 3, 3, true) --Rend (dot)
GridStatusRaidDebuff:DebuffId(zoneid, 30225, 44, 1, 1, true) --Silence
-- Load Sanguinar
GridStatusRaidDebuff:DebuffId(zoneid, 44863, 45, 2, 2, true) --Bellowing Roar (fear)
-- Grand Astromancer Capernian
GridStatusRaidDebuff:DebuffId(zoneid, 37018, 46, 3, 3, true) --Conflagration (dot)
GridStatusRaidDebuff:DebuffId(zoneid, 36970, 47, 1, 1, true) --Arane Burst (movement)
-- Master Engineer Telonicus
GridStatusRaidDebuff:DebuffId(zoneid, 37027, 48, 2, 2) --Remote Toy (periodic stun)

