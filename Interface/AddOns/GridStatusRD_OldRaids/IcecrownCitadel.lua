-- local zone = "Icecrown Citadel"
local zoneid = 604

-- Check Compatibility
if GridStatusRD_OldRaids.rd_version < 502 then
	return
end

--zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

--The Lower Spire
GridStatusRaidDebuff:DebuffId(zoneid, 70980, 1, 6, 5) --Web Wrap
GridStatusRaidDebuff:DebuffId(zoneid, 69483, 1, 6, 5, true) --Dark Reckoning
GridStatusRaidDebuff:DebuffId(zoneid, 69969, 1, 5, 5, true) --Curse of Doom

--The Plagueworks
GridStatusRaidDebuff:DebuffId(zoneid, 71089, 2, 5, 5, true) --Bubbling Pus
GridStatusRaidDebuff:DebuffId(zoneid, 71127, 2, 7, 5, true, true) --Mortal Wound
GridStatusRaidDebuff:DebuffId(zoneid, 71163, 2, 6, 5, true) --Devour Humanoid
GridStatusRaidDebuff:DebuffId(zoneid, 71103, 2, 6, 5) --Combobulating Spray
GridStatusRaidDebuff:DebuffId(zoneid, 71157, 2, 5, 5, false, true)--Infested Wound

--The Crimson Hall
GridStatusRaidDebuff:DebuffId(zoneid, 70645, 3, 9, 5, true, false, {r=1,g=0,b=0})  --Chains of Shadow
GridStatusRaidDebuff:DebuffId(zoneid, 70671, 3, 5, 5)-- Leeching Rot
GridStatusRaidDebuff:DebuffId(zoneid, 70432, 3, 6, 5, true) --Blood Sap
GridStatusRaidDebuff:DebuffId(zoneid, 70435, 3, 7, 5, true, true) --Rend Flesh

--Frostwing Hall
GridStatusRaidDebuff:DebuffId(zoneid, 71257, 4, 6, 5, true, true) --Barbaric Strike
GridStatusRaidDebuff:DebuffId(zoneid, 71252, 4, 5, 5, true) --Volley

GridStatusRaidDebuff:DebuffId(zoneid, 71327, 4, 6, 5) -- Web
GridStatusRaidDebuff:DebuffId(zoneid, 36922, 4, 5, 5, true) --Bellowing Roar

--Lord Marrowgar
GridStatusRaidDebuff:BossNameId(zoneid, 10, "Lord Marrowgar")
GridStatusRaidDebuff:DebuffId(zoneid, 70823, 11, 5, 5, true) --Coldflame
GridStatusRaidDebuff:DebuffId(zoneid, 69065, 12, 8, 5) --Impaled
GridStatusRaidDebuff:DebuffId(zoneid, 70835, 13, 5, 5) --Bone Storm

--Lady Deathwhisper
GridStatusRaidDebuff:BossNameId(zoneid, 20, "Lady Deathwhisper")
GridStatusRaidDebuff:DebuffId(zoneid, 72109, 21, 5, 5) --Death and Decay
GridStatusRaidDebuff:DebuffId(zoneid, 71289, 22, 9, 9, true) --Dominate Mind
GridStatusRaidDebuff:DebuffId(zoneid, 71204, 23, 4, 4, true, true) --Touch of Insignificance
GridStatusRaidDebuff:DebuffId(zoneid, 67934, 24, 5, 5, true) --Frost Fever
GridStatusRaidDebuff:DebuffId(zoneid, 71237, 25, 5, 5, true, false, nil, true) --Curse of Torpor
GridStatusRaidDebuff:DebuffId(zoneid, 72491, 26, 5, 5, true) --Necrotic Strike

--Gunship Battle
GridStatusRaidDebuff:BossNameId(zoneid, 30, "Icecrown Gunship Battle")
GridStatusRaidDebuff:DebuffId(zoneid, 69651, 31, 5, 5, true) --Wounding Strike

--Deathbringer Saurfang
GridStatusRaidDebuff:BossNameId(zoneid, 40, "Deathbringer Saurfang")
GridStatusRaidDebuff:DebuffId(zoneid, 72293, 41, 6, 8, false, false, {r=1,g=0,b=0}) --Mark of the Fallen Champion
GridStatusRaidDebuff:DebuffId(zoneid, 72442, 42, 8, 5, true) --Boiling Blood
GridStatusRaidDebuff:DebuffId(zoneid, 72449, 43, 5, 5, true) --Rune of Blood
GridStatusRaidDebuff:DebuffId(zoneid, 72769, 44, 5, 5, true) --Scent of Blood (heroic)

--Rotface
GridStatusRaidDebuff:BossNameId(zoneid, 50, "Rotface")
GridStatusRaidDebuff:DebuffId(zoneid, 71224, 51, 5, 7, true) --Mutated Infection
GridStatusRaidDebuff:DebuffId(zoneid, 71215, 52, 5, 5) --Ooze Flood
GridStatusRaidDebuff:DebuffId(zoneid, 69774, 53, 5, 5) --Sticky Ooze

--Festergut
GridStatusRaidDebuff:BossNameId(zoneid, 60, "Festergut")
GridStatusRaidDebuff:DebuffId(zoneid, 69279, 61, 5, 5, true) --Gas Spore
GridStatusRaidDebuff:DebuffId(zoneid, 71218, 62, 5, 5, true) --Vile Gas
GridStatusRaidDebuff:DebuffId(zoneid, 72219, 63, 5, 5, true, true) --Gastric Bloat

--Proffessor
GridStatusRaidDebuff:BossNameId(zoneid, 70, "Professor Putricide")
GridStatusRaidDebuff:DebuffId(zoneid, 70341, 71, 5, 5, true) --Slime Puddle
GridStatusRaidDebuff:DebuffId(zoneid, 72549, 72, 5, 5, true) --Malleable Goo
GridStatusRaidDebuff:DebuffId(zoneid, 71278, 73, 5, 5, true) --Choking Gas Bomb
GridStatusRaidDebuff:DebuffId(zoneid, 70215, 74, 5, 5, true) --Gaseous Bloat
GridStatusRaidDebuff:DebuffId(zoneid, 70447, 75, 5, 5, true) --Volatile Ooze Adhesive
GridStatusRaidDebuff:DebuffId(zoneid, 72454, 76, 5, 5, true, true) --Mutated Plague
GridStatusRaidDebuff:DebuffId(zoneid, 70405, 77, 5, 5, false, false, {r=1, g=0, b=0}) --Mutated Transformation
GridStatusRaidDebuff:DebuffId(zoneid, 72856, 78, 6, 4, true) --Unbound Plague
GridStatusRaidDebuff:DebuffId(zoneid, 70953, 79, 4, 6, true, true, {r=0, g=0, b=1}) --Plague Sickness
--Blood Princes
GridStatusRaidDebuff:BossNameId(zoneid, 80, "Blood Princes")
GridStatusRaidDebuff:DebuffId(zoneid, 72796, 81, 7, 5, true) --Glittering Sparks
GridStatusRaidDebuff:DebuffId(zoneid, 71822, 82, 5, 7) --Shadow Resonance

--Blood-Queen Lana'thel
GridStatusRaidDebuff:BossNameId(zoneid, 90, "Blood-Queen Lana'thel")
GridStatusRaidDebuff:DebuffId(zoneid, 70838, 91, 5, 5) --Blood Mirror
GridStatusRaidDebuff:DebuffId(zoneid, 72265, 92, 6, 5, true) --Delirious Slash
GridStatusRaidDebuff:DebuffId(zoneid, 71473, 93, 5, 7, true) --Essence of the Blood Queen
GridStatusRaidDebuff:DebuffId(zoneid, 71474, 94, 6, 5, true) --Frenzied Bloodthirst
GridStatusRaidDebuff:DebuffId(zoneid, 73070, 95, 5, 5, true) --Incite Terror
GridStatusRaidDebuff:DebuffId(zoneid, 71340, 96, 7, 5) --Pact of the Darkfallen
GridStatusRaidDebuff:DebuffId(zoneid, 71265, 97, 6, 5) --Swarming Shadows
GridStatusRaidDebuff:DebuffId(zoneid, 70923, 98, 10, 10) --Uncontrollable Frenzy

--Valithria Dreamwalker
GridStatusRaidDebuff:BossNameId(zoneid, 100, "Valithria Dreamwalker")
GridStatusRaidDebuff:DebuffId(zoneid, 70873, 101, 1, 5, true, true) --Emerald Vigor
GridStatusRaidDebuff:DebuffId(zoneid, 71746, 102, 5, 5) --Column of Frost
GridStatusRaidDebuff:DebuffId(zoneid, 71741, 103, 4, 5) --Mana Void
GridStatusRaidDebuff:DebuffId(zoneid, 71738, 104, 7, 5, true, true) --Corrosion
GridStatusRaidDebuff:DebuffId(zoneid, 71733, 105, 6, 5, true) --Acid Burst
GridStatusRaidDebuff:DebuffId(zoneid, 71283, 106, 6, 5, true) --Gut Spray
GridStatusRaidDebuff:DebuffId(zoneid, 71941, 107, 1, 5, true, true) --Twisted Nightmares

--Sindragosa
GridStatusRaidDebuff:BossNameId(zoneid, 110, "Sindragosa")
GridStatusRaidDebuff:DebuffId(zoneid, 69762, 111, 5, 5, true) --Unchained Magic
GridStatusRaidDebuff:DebuffId(zoneid, 70106, 112, 6, 5, true, true) --Chlled to the Bone
GridStatusRaidDebuff:DebuffId(zoneid, 69766, 113, 6, 5, true, true) --Instability
GridStatusRaidDebuff:DebuffId(zoneid, 70126, 114, 9, 5, true) --Frost Beacon
GridStatusRaidDebuff:DebuffId(zoneid, 70157, 115, 8, 5, true) --Ice Tomb
GridStatusRaidDebuff:DebuffId(zoneid, 70127, 116, 7, 5, false, true) --Mystic Buffet

--The Lich King
GridStatusRaidDebuff:BossNameId(zoneid, 120, "The Lich King")
GridStatusRaidDebuff:DebuffId(zoneid, 70337, 121, 8, 5, true, true) --Necrotic plague
GridStatusRaidDebuff:DebuffId(zoneid, 72149, 122, 5, 5, true) --Shockwave
GridStatusRaidDebuff:DebuffId(zoneid, 70541, 123, 7, 5) --Infest
GridStatusRaidDebuff:DebuffId(zoneid, 69242, 124, 5, 5, true) --Soul Shriek  -- 69200 Raging Spirit
GridStatusRaidDebuff:DebuffId(zoneid, 69409, 125, 9, 5, true) --Soul Reaper
GridStatusRaidDebuff:DebuffId(zoneid, 72762, 126, 5, 5) --Defile
GridStatusRaidDebuff:DebuffId(zoneid, 68980, 127, 8, 5) --Harvest Soul

