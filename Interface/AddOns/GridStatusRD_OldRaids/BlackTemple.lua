-- local zone = "Black Temple"
local zoneid = 796
-- Note: updated spell ids as of WoD 6.1 3/8/2015

-- Check Compatibility
if GridStatusRD_OldRaids.rd_version < 502 then
	return
end

--zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

--Trash
GridStatusRaidDebuff:DebuffId(zoneid, 34654, 1, 4, 4, true) --Blind (poison)

-- Illidari Defiler
GridStatusRaidDebuff:DebuffId(zoneid, 39674, 1, 4, 4, true) --Banish (magic)

-- Illidari Nightlord
GridStatusRaidDebuff:DebuffId(zoneid, 41150, 1, 4, 4, true) --Fear (magic)

-- Illidari Centurion
GridStatusRaidDebuff:DebuffId(zoneid, 41168, 1, 4, 4, true) --Sonic Strike (silence)

-- Illidari Battle-mage
GridStatusRaidDebuff:DebuffId(zoneid, 41382, 1, 3, 3) --Blizzard (mana drain)
-- This spell is listed under High Nethermancer Zerevor instead
-- GridStatusRaidDebuff:DebuffId(zoneid, 41379, 1, 1, 1) --Flamestrike
GridStatusRaidDebuff:DebuffId(zoneid, 41384, 1, 2, 2, true) -- Frostbolt (magic)

-- Illidari Heartseeker
GridStatusRaidDebuff:DebuffId(zoneid, 41171, 1, 3, 3, true) -- Skeleton Shot (dot)
GridStatusRaidDebuff:DebuffId(zoneid, 41170, 1, 4, 4, true) -- Curse of the Bleakheart (curse, stun)

-- Illidari Assassin
GridStatusRaidDebuff:DebuffId(zoneid, 3609, 1, 4, 4, true) --Paralyzing Poison (poison, stun)

-- Illidari Boneslicer
GridStatusRaidDebuff:DebuffId(zoneid, 24698, 1, 2, 2, true) --Gouge (stun)

-- Bonechewer Spectator
GridStatusRaidDebuff:DebuffId(zoneid, 25646, 1, 2, 2, true) --Mortal Wound (healing reduction)

-- Bonechewer Behemoth
GridStatusRaidDebuff:DebuffId(zoneid, 41274, 1, 2, 2, true) --Fel Stomp (stun)

-- Bonechewer Shield Disciple
GridStatusRaidDebuff:DebuffId(zoneid, 41197, 1, 2, 2, true) --Shield Bash (stun)

-- Temple Concubine
GridStatusRaidDebuff:DebuffId(zoneid, 41338, 1, 2, 2, true) --Love Tap (stun)

-- Priestess of Delight
GridStatusRaidDebuff:DebuffId(zoneid, 41351, 1, 4, 4, true) --Curse of Virtality (curse, dot)

-- Priestess of Dementia
GridStatusRaidDebuff:DebuffId(zoneid, 41404, 1, 2, 2, true) -- Dementia

-- Charming Courtesan
GridStatusRaidDebuff:DebuffId(zoneid, 41345, 1, 4, 4, true) --Infatuation (charm)

-- Mutant War Hound
GridStatusRaidDebuff:DebuffId(zoneid, 41193, 1, 3, 3, true) -- Cloud of Disease (dot)

-- Unknown trash
GridStatusRaidDebuff:DebuffId(zoneid, 41392, 1, 1, 1) --Riposte (disarm)
GridStatusRaidDebuff:DebuffId(zoneid, 41272, 1, 2, 2, true) --Behemoth Charge (stun)
GridStatusRaidDebuff:DebuffId(zoneid, 41397, 1, 2, 2, true) --Confusion (blind)
GridStatusRaidDebuff:DebuffId(zoneid, 41541, 1, 2, 2) --Consecration
GridStatusRaidDebuff:DebuffId(zoneid, 41389, 1, 2, 2, true) --Kidney shot (stun)

--Najentus
GridStatusRaidDebuff:BossNameId(zoneid, 10, "High Warlord Naj'entus")
GridStatusRaidDebuff:DebuffId(zoneid, 39837, 11, 5, 5) --Impaling Spine

--Terron
GridStatusRaidDebuff:BossNameId(zoneid, 20, "Teron Gorefiend")
GridStatusRaidDebuff:DebuffId(zoneid, 40239, 21, 5, 5, true) --Incinerate
GridStatusRaidDebuff:DebuffId(zoneid, 40251, 22, 5, 5, true) --Shadow of death
GridStatusRaidDebuff:DebuffId(zoneid, 40243, 23, 5, 5) --Crushing Shadows

--Gurtogg
GridStatusRaidDebuff:BossNameId(zoneid, 30, "Gurtogg Bloodboil")
GridStatusRaidDebuff:DebuffId(zoneid, 40604, 31, 5, 5, true) --Fel Rage
GridStatusRaidDebuff:DebuffId(zoneid, 40481, 32, 5, 5, true, true) --Acidic Wound
GridStatusRaidDebuff:DebuffId(zoneid, 40508, 33, 5, 5) --Fel-Acid Breath
GridStatusRaidDebuff:DebuffId(zoneid, 42005, 34, 5, 5, true, true) --Bloodboil

--ROS
GridStatusRaidDebuff:BossNameId(zoneid, 40, "Reliquary of Souls")
-- Essence of Suffering
GridStatusRaidDebuff:DebuffId(zoneid, 41303, 41, 5, 5) --Soul Drain
GridStatusRaidDebuff:DebuffId(zoneid, 41294, 42, 5, 5, true) --Fixate
GridStatusRaidDebuff:DebuffId(zoneid, 41292, 43, 1, 1) -- Aura of Suffering
-- Essence of Desire
GridStatusRaidDebuff:DebuffId(zoneid, 41410, 44, 5, 5, true) --Deaden
GridStatusRaidDebuff:DebuffId(zoneid, 41426, 45, 4, 4, true) --Spirit Shock (stun)
GridStatusRaidDebuff:DebuffId(zoneid, 41350, 46, 1, 1) --Aura of Desire
-- Essence of Anger
GridStatusRaidDebuff:DebuffId(zoneid, 41376, 47, 5, 5, true) --Spite
GridStatusRaidDebuff:DebuffId(zoneid, 41337, 48, 1, 1) --Aura of Anger

--Mother Shahraz
GridStatusRaidDebuff:BossNameId(zoneid, 50, "Mother Shahraz")
GridStatusRaidDebuff:DebuffId(zoneid, 40860, 51, 5, 5, true) --Vile Beam
GridStatusRaidDebuff:DebuffId(zoneid, 41001, 52, 5, 5) --Fatal Attraction
GridStatusRaidDebuff:DebuffId(zoneid, 40823, 53, 1, 1, true) --Silencing Shriek

--Council
GridStatusRaidDebuff:BossNameId(zoneid, 60, "The Illidari Council")
-- Veras Darkshadow
GridStatusRaidDebuff:DebuffId(zoneid, 41485, 61, 5, 5, true) --Deadly Poison
-- Lady Malande
GridStatusRaidDebuff:DebuffId(zoneid, 41472, 62, 5, 5, true) --Divine Wrath
-- Gathios the Shatterer
GridStatusRaidDebuff:DebuffId(zoneid, 13005, 63, 5, 5, true) --Hammer of Justice (stun)
-- High Nethermancer Zerevor
GridStatusRaidDebuff:DebuffId(zoneid, 41481, 64, 5, 5) --Flamestrike

--Illidan
GridStatusRaidDebuff:BossNameId(zoneid, 70, "Illidan Stormrage")
GridStatusRaidDebuff:DebuffId(zoneid, 41914, 71, 5, 5, true) --Parasitic Shadowfiend
GridStatusRaidDebuff:DebuffId(zoneid, 40585, 72, 5, 5, true) --Dark Barrage
GridStatusRaidDebuff:DebuffId(zoneid, 41032, 73, 4, 4) --Shear
GridStatusRaidDebuff:DebuffId(zoneid, 40932, 74, 5, 5, true) --Agonizing Flames
GridStatusRaidDebuff:DebuffId(zoneid, 41142, 75, 1, 1, true) --Aura of Dread
GridStatusRaidDebuff:DebuffId(zoneid, 40647, 76, 6, 6, true) --Shadow Prison

