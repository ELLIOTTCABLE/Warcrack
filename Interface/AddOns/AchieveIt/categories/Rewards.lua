----------------------
-- Rewards Category --
----------------------

local AchieveIt = AchieveIt;

-- Locale
local L = LibStub("AceLocale-3.0"):GetLocale("AchieveIt");

-- The achievement category ID - top level achievement
local categoryId = false;

-- titles
local titleAchievements	= {
    -- 60 Exalted Reputations
    6742,
    -- 3000 Quests Completed
    978,
    -- 100000 Honorable Kills
    870,
    -- 250000 Honorable Kills
    5363,
    -- Accomplished Angler
    1516,
    -- Ambassador of the Alliance
    { id = 948, faction = AchieveIt.Factions.ALLIANCE },
    -- Ambassador of the Horde
    { id = 762, faction = AchieveIt.Factions.HORDE },
    -- Avengers of Hyjal
    5827,
    -- Bane of the Fallen King
    4583,
    -- Battlemaster
    { id = 230, faction = AchieveIt.Factions.ALLIANCE },
    -- Battlemaster
    { id = 1175, faction = AchieveIt.Factions.HORDE },
    -- Blood Guard
    { id = 5351, faction = AchieveIt.Factions.HORDE },
    -- Brawlin' and Shot Callin'
    { id = 9170, faction = AchieveIt.Factions.ALLIANCE },
    -- Brawlin' and Shot Callin'
    { id = 9174, faction = AchieveIt.Factions.HORDE },
    -- Brewmaster
    1683,
    -- Centurion
    { id = 5338, faction = AchieveIt.Factions.HORDE },
    -- Challenge Warlord: Bronze
    8897,
    -- Champion
    { id = 5353, faction = AchieveIt.Factions.HORDE },
    -- Champion of the Frozen Wastes
    1658,
    -- Choppin' Even More Logs
    { id = 9078, faction = AchieveIt.Factions.ALLIANCE },
    -- Choppin' Even More Logs
    { id = 9080, faction = AchieveIt.Factions.HORDE },
    -- Choppin' Some More Logs
    9077,
    -- Commander
    { id = 5340, faction = AchieveIt.Factions.ALLIANCE },
    -- Conqueror of Orgrimmar
    { id = 8679, faction = AchieveIt.Factions.ALLIANCE },
    -- Corporal
    { id = 5331, faction = AchieveIt.Factions.ALLIANCE },
    -- Crazy for Cats
    8397,
    -- Deadly Pet Brawler
    8301,
    -- Defender of a Shattered World
    5506,
    -- Destroyer's End
    6177,
    -- Draenor Master
    9464,
    -- Exalted Argent Champion of the Alliance
    { id = 2817, faction = AchieveIt.Factions.ALLIANCE },
    -- Exalted Argent Champion of the Horde
    { id = 2816, faction = AchieveIt.Factions.HORDE },
    -- Exalted Champion of Darnassus
    { id = 2760, faction = AchieveIt.Factions.ALLIANCE },
    -- Exalted Champion of Gnomeregan
    { id = 2762, faction = AchieveIt.Factions.ALLIANCE },
    -- Exalted Champion of Ironforge
    { id = 2763, faction = AchieveIt.Factions.ALLIANCE },
    -- Exalted Champion of Orgrimmar
    { id = 2765, faction = AchieveIt.Factions.HORDE },
    -- Exalted Champion of Sen'jin
    { id = 2766, faction = AchieveIt.Factions.HORDE },
    -- Exalted Champion of Silvermoon City
    { id = 2767, faction = AchieveIt.Factions.HORDE },
    -- Exalted Champion of Stormwind
    { id = 2764, faction = AchieveIt.Factions.ALLIANCE },
    -- Exalted Champion of the Exodar
    { id = 2761, faction = AchieveIt.Factions.ALLIANCE },
    -- Exalted Champion of the Undercity
    { id = 2769, faction = AchieveIt.Factions.HORDE },
    -- Exalted Champion of Thunder Bluff
    { id = 2768, faction = AchieveIt.Factions.HORDE },
    -- Field Marshal
    { id = 5357, faction = AchieveIt.Factions.ALLIANCE },
    -- Fire-Watcher
    8721,
    -- First Sergeant
    { id = 5349, faction = AchieveIt.Factions.HORDE },
    -- Fool For Love
    1693,
    -- For the Children
    1793,
    -- Garrison Architect
    9094,
    -- General
    { id = 5355, faction = AchieveIt.Factions.HORDE },
    -- Grand Marshal
    { id = 5343, faction = AchieveIt.Factions.ALLIANCE },
    -- Grunt
    { id = 5346, faction = AchieveIt.Factions.HORDE },
    -- Guardian of Cenarius
    953,
    -- Hail to the Chef
    1563,
    -- Hallowed Be Thy Name
    1656,
    -- Hero of the Alliance
    { id = 6942, faction = AchieveIt.Factions.ALLIANCE },
    -- Hero of the Horde
    { id = 6941, faction = AchieveIt.Factions.HORDE },
    -- Heroic: Al'Akir
    5123,
    -- Heroic: Lei Shen
    8067,
    -- Heroic: Madness of Deathwing
    6116,
    -- Heroic: Nefarian
    5116,
    -- Heroic: Ragnaros
    5803,
    -- Heroic: Sha of Fear
    6734,
    -- Heroic: Sinestra
    5121,
    -- Heroic: Will of the Emperor
    6724,
    -- High Warlord
    { id = 5356, faction = AchieveIt.Factions.HORDE },
    -- I Had It in My Hand
    4854,
    -- Is Another Man's Treasure
    7284,
    -- It Belongs in a Museum!
    4856,
    -- Khan
    { id = 8052, faction = AchieveIt.Factions.ALLIANCE },
    -- Khan
    { id = 8055, faction = AchieveIt.Factions.HORDE },
    -- Knight
    { id = 5335, faction = AchieveIt.Factions.ALLIANCE },
    -- Knight-Captain
    { id = 5337, faction = AchieveIt.Factions.ALLIANCE },
    -- Knight-Champion
    { id = 5359, faction = AchieveIt.Factions.ALLIANCE },
    -- Knight-Lieutenant
    { id = 5336, faction = AchieveIt.Factions.ALLIANCE },
    -- Leeeeeeeeeeeeeroy...?
    9058,
    -- Legionnaire
    { id = 5352, faction = AchieveIt.Factions.HORDE },
    -- Liberator of Orgrimmar
    { id = 8680, faction = AchieveIt.Factions.HORDE },
    -- Lieutenant Commander
    { id = 5339, faction = AchieveIt.Factions.ALLIANCE },
    -- Lieutenant General
    { id = 5354, faction = AchieveIt.Factions.HORDE },
    -- Looking For Many
    4477,
    -- Mantle of the Talon King
    9072,
    -- Marshal
    { id = 5341, faction = AchieveIt.Factions.ALLIANCE },
    -- Master of Deepwind Gorge
    8360,
    -- Master of Pandaren Cooking
    7306,
    -- Master Sergeant
    { id = 5333, faction = AchieveIt.Factions.ALLIANCE },
    -- Merrymaker
    1691,
    -- Mythic: Blackhand's Crucible
    8973,
    -- Mythic: Garrosh Hellscream
    8482,
    -- Mythic: Imperator's Fall
    8965,
    -- Nemesis: Death Stalker
    { id = 9517, faction = AchieveIt.Factions.ALLIANCE },
    -- Nemesis: Draenei Destroyer
    { id = 9509, faction = AchieveIt.Factions.HORDE },
    -- Nemesis: Dwarfstalker
    { id = 9510, faction = AchieveIt.Factions.HORDE },
    -- Nemesis: Gnomebane
    { id = 9511, faction = AchieveIt.Factions.HORDE },
    -- Nemesis: Huojin's Fall
    { id = 9520, faction = AchieveIt.Factions.ALLIANCE },
    -- Nemesis: Killer of Kezan
    { id = 9518, faction = AchieveIt.Factions.ALLIANCE },
    -- Nemesis: Manslayer
    { id = 9512, faction = AchieveIt.Factions.HORDE },
    -- Nemesis: Orcslayer
    { id = 9519, faction = AchieveIt.Factions.ALLIANCE },
    -- Nemesis: Scourge of the Kaldorei
    { id = 9513, faction = AchieveIt.Factions.HORDE },
    -- Nemesis: Slayer of Sin'dorei
    { id = 9516, faction = AchieveIt.Factions.ALLIANCE },
    -- Nemesis: Terror of the Tushui
    { id = 9514, faction = AchieveIt.Factions.HORDE },
    -- Nemesis: The Butcher
    { id = 9521, faction = AchieveIt.Factions.ALLIANCE },
    -- Nemesis: Troll Hunter
    { id = 9522, faction = AchieveIt.Factions.ALLIANCE },
    -- Nemesis: Worgen Hunter
    { id = 9515, faction = AchieveIt.Factions.HORDE },
    -- Noble Gardener
    2798,
    -- Observed (10 player)
    3036,
    -- Observed (25 player)
    3037,
    -- Pilgrim
    3478,
    -- Private
    { id = 5330, faction = AchieveIt.Factions.ALLIANCE },
    -- Proving Yourself: Endless Damage (Wave 30)
    9577,
    -- Proving Yourself: Endless Healer (Wave 30)
    9589,
    -- Proving Yourself: Endless Tank (Wave 30)
    9583,
    -- Savage Hero
    9619,
    -- Scenaturday
    { id = 6874, faction = AchieveIt.Factions.ALLIANCE },
    -- Scenaturday
    { id = 7509, faction = AchieveIt.Factions.HORDE },
    -- Scout
    { id = 5345, faction = AchieveIt.Factions.HORDE },
    -- Senior Sergeant
    { id = 5348, faction = AchieveIt.Factions.HORDE },
    -- Sergeant
    { id = 5332, faction = AchieveIt.Factions.ALLIANCE },
    -- Sergeant
    { id = 5347, faction = AchieveIt.Factions.HORDE },
    -- Sergeant Major
    { id = 5334, faction = AchieveIt.Factions.ALLIANCE },
    -- Stone Guard
    { id = 5350, faction = AchieveIt.Factions.HORDE },
    -- Stormbreaker
    8121,
    -- Taming Azeroth
    6607,
    -- The Arena Master
    1174,
    -- The Argent Champion
    945,
    -- The Ashen Verdict
    4598,
    -- The Conqueror
    { id = 714, faction = AchieveIt.Factions.HORDE },
    -- The Diplomat
    { id = 942, faction = AchieveIt.Factions.ALLIANCE },
    -- The Diplomat
    { id = 943, faction = AchieveIt.Factions.HORDE },
    -- The Flame Keeper
    { id = 1039, faction = AchieveIt.Factions.HORDE },
    -- The Flame Warden
    { id = 1038, faction = AchieveIt.Factions.ALLIANCE },
    -- The Frozen Throne (10 player)
    4530,
    -- The Frozen Throne (25 player)
    4597,
    -- The Justicar
    { id = 907, faction = AchieveIt.Factions.ALLIANCE },
    -- The Light of Dawn
    4584,
    -- The Loremaster
    7520,
    -- The Seat of Knowledge
    7612,
    -- The Shado-Master
    7479,
    -- The Stable Master
    { id = 9540, faction = AchieveIt.Factions.ALLIANCE },
    -- The Stable Master
    { id = 9706, faction = AchieveIt.Factions.HORDE },
    -- The Twilight Zone (10 player)
    2051,
    -- The Twilight Zone (25 player)
    2054,
    -- To Honor One's Elders
    913,
    -- Tranquil Master
    6926,
    -- Veteran of the Alliance
    { id = 5328, faction = AchieveIt.Factions.ALLIANCE },
    -- Veteran of the Horde
    { id = 5325, faction = AchieveIt.Factions.HORDE },
    -- Veteran of the Molten Front
    5879,
    -- Wakener
    8023,
    -- Warbound Veteran of the Alliance
    { id = 5329, faction = AchieveIt.Factions.ALLIANCE },
    -- Warbringer of the Horde
    { id = 5326, faction = AchieveIt.Factions.HORDE },
    -- Warlord
    { id = 5342, faction = AchieveIt.Factions.HORDE },
    -- Warlord of Draenor
    { id = 9738, faction = AchieveIt.Factions.ALLIANCE },
    -- Warlord of Draenor
    { id = 9508, faction = AchieveIt.Factions.HORDE },
    -- What was Briefly Yours is Now Mine
    4855,
    -- World Explorer
    46,
    -- World Safari
    6590
};

-- mounts
local mountAchievements		= {
    -- Awake the Drakes
    9713,
    -- Challenge Warlord: Silver
    8898,
    -- For The Alliance!
    { id = 614, faction = AchieveIt.Factions.ALLIANCE },
    -- For The Horde!
    { id = 619, faction = AchieveIt.Factions.HORDE },
    -- Gladiator
    2091,
    -- Glory of the Cataclysm Hero
    4845,
    -- Glory of the Cataclysm Raider
    4853,
    -- Glory of the Draenor Hero
    9396,
    -- Glory of the Draenor Raider
    8985,
    -- Glory of the Dragon Soul Raider
    6169,
    -- Glory of the Firelands Raider
    5828,
    -- Glory of the Hero
    2136,
    -- Glory of the Icecrown Raider (10 player)
    4602,
    -- Glory of the Icecrown Raider (25 player)
    4603,
    -- Glory of the Orgrimmar Raider
    8454,
    -- Glory of the Pandaria Hero
    6927,
    -- Glory of the Pandaria Raider
    6932,
    -- Glory of the Thundering Raider
    8124,
    -- Glory of the Ulduar Raider (10 player)
    2957,
    -- Glory of the Ulduar Raider (25 player)
    2958,
    -- Leading the Cavalry
    2143,
    -- Mount Parade
    { id = 8304, faction = AchieveIt.Factions.ALLIANCE },
    -- Mount Parade
    { id = 8302, faction = AchieveIt.Factions.HORDE },
    -- Mountacular
    { id = 9598, faction = AchieveIt.Factions.ALLIANCE },
    -- Mountacular
    { id = 9599, faction = AchieveIt.Factions.HORDE },
    -- Mountain o' Mounts
    { id = 2536, faction = AchieveIt.Factions.ALLIANCE },
    -- Mountain o' Mounts
    { id = 2537, faction = AchieveIt.Factions.HORDE },
    -- Pandaren Ambassador
    { id = 6828, faction = AchieveIt.Factions.ALLIANCE },
    -- Pandaren Ambassador
    { id = 6827, faction = AchieveIt.Factions.HORDE },
    -- Primal Combatant
    { id = 9238, faction = AchieveIt.Factions.ALLIANCE },
    -- Primal Combatant
    { id = 9236, faction = AchieveIt.Factions.HORDE },
    -- The Molten Front Offensive
    5866,
    -- Veteran of the Alliance
    { id = 5328, faction = AchieveIt.Factions.ALLIANCE },
    -- Veteran of the Alliance II
    { id = 5823, faction = AchieveIt.Factions.ALLIANCE },
    -- Veteran of the Horde
    { id = 5325, faction = AchieveIt.Factions.HORDE },
    -- Veteran of the Horde II
    { id = 5824, faction = AchieveIt.Factions.HORDE },
    -- Warbound Veteran of the Alliance
    { id = 5329, faction = AchieveIt.Factions.ALLIANCE },
    -- Warbringer of the Horde
    { id = 5326, faction = AchieveIt.Factions.HORDE },
    -- We're Going to Need More Saddles
    { id = 7860, faction = AchieveIt.Factions.ALLIANCE },
    -- We're Going to Need More Saddles
    { id = 7862, faction = AchieveIt.Factions.HORDE },
    -- What a Long, Strange Trip It's Been
    2144
};

-- companion pets
local petAchievements	= {
    -- An Awfully Big Adventure
    9069,
    -- Brutal Pet Brawler
    8300,
    -- Draenor Safari
    9685,
    -- Going to Need More Leashes
    7500,
    -- Higher Learning
    1956,
    -- Lil' Game Hunter
    2516,
    -- Ling-Ting's Herbal Journey
    6402,
    -- Littlest Pet Shop
    5875,
    -- Looking For Multitudes
    4478,
    -- Menagerie
    5877,
    -- Petting Zoo
    5876,
    -- Pilgrim
    3478,
    -- Pro Pet Mob
    6582,
    -- Raiding with Leashes
    7934,
    -- Raiding with Leashes II: Attunement Edition
    8293,
    -- Rock Lover
    5449,
    -- Shop Smart, Shop Pet...Smart
    1250,
    -- So. Many. Pets.
    9643,
    -- That's a Lot of Pet Food
    7501,
    -- The 'Unbeatable?' Pterodactyl: BEATEN.
    5860,
    -- Time to Open a Pet Store
    7521
};

-- items
local itemAchievements = {
    -- Challenge Warlord: Gold
    8899,
    -- Deck Your Collection
        { id = 9176, faction = AchieveIt.Factions.ALLIANCE },
    -- Deck Your Collection
        { id = 9177, faction = AchieveIt.Factions.HORDE },
    -- Going to Need More Traps
    6556,
    -- Higher Learning
    1956,
    -- I Choose You
    7908,
    -- Just a Pup
    6566,
    -- Legacy of Leyara
    5859,
    -- Newbie
    7433,
    -- Pro Pet Crew
    6581,
    -- Pub Crawl
    7385,
    -- Taming the World
    7499,
    -- The Coin Master
    2096,
    -- The Longest Day
    8348,
    -- The Second Rule of Brawler's Guild
        { id = 9169, faction = AchieveIt.Factions.ALLIANCE },
    -- The Second Rule of Brawler's Guild
        { id = 9173, faction = AchieveIt.Factions.HORDE },
    -- The Toymaster
    9673
};

-- tabards
local tabardAchievements = {
    -- Brutally Dedicated
    876,
    -- Explore Northrend
    45,
    -- Master of Isle of Conquest
    { id = 3857, faction = AchieveIt.Factions.ALLIANCE },
    -- Master of Isle of Conquest
    { id = 3957, faction = AchieveIt.Factions.HORDE },
    -- The Loremaster
    7520,
    -- Twenty-Five Tabards
    1021
};

-- quests
local questAchievements = {
    -- A Silver Confidant
    { id = 3676, faction = AchieveIt.Factions.ALLIANCE },
    -- Fabled Pandaren Tamer
    8080,
    -- Pandaren Spirit Tamer
    7936,
    -- Taming Cataclysm
    7525,
    -- Taming Eastern Kingdoms
    { id = 6603, faction = AchieveIt.Factions.ALLIANCE },
    -- Taming Kalimdor
    { id = 6602, faction = AchieveIt.Factions.HORDE },
    -- Taming Northrend
    6605,
    -- Taming Outland
    6604,
    -- Taming Pandaria
    6606,
    -- The Sunreavers
    { id = 3677, faction = AchieveIt.Factions.HORDE }
};

-- teleports
local teleportAchievements = {
    -- Auchindoun: Gold
    8882,
    -- Bloodmaul Slag Mines: Gold
    8878,
    -- Grimrail Depot: Gold
    8890,
    -- Iron Docks: Gold
    9000,
    -- Shadowmoon Burial Grounds: Gold
    8886,
    -- Skyreach: Gold
    8874,
    -- The Everbloom: Gold
    9004,
    -- Upper Blackrock Spire: Gold
    8894
};

local blueprintAchievements = {
    -- Draenic Pet Battler
    9463,
    -- Draenic Seed Collector
    9454,
    -- Draenic Stone Collector
    9453,
    -- Draenor Angler
    9462,
    -- Filling the Ranks
    9129,
    -- Finding Your Waystones
    9497,
    -- Got My Mind On My Draenor Money
    9487,
    -- Master of Mounts
    9526,
    -- Master Trapper
    9565,
    -- Patrolling Draenor
    9523,
    -- Salvaging Pays Off
    9468,
    -- Savage Friends
    { id = 9478, faction = AchieveIt.Factions.ALLIANCE },
    -- Savage Friends
    { id = 9477, faction = AchieveIt.Factions.HORDE },
    -- Stay Awhile and Listen
    9703,
    -- Terrific Technology
    9527,
    -- The Bone Collector
    9495,
    -- Upgrading the Mill
    9429,
    -- Working More Orders
    9406
};

local monumentAchievements = {
    -- Defender of Draenor
    { id = 9630, faction = AchieveIt.Factions.ALLIANCE },
    -- Defender of Draenor
    { id = 9248, faction = AchieveIt.Factions.HORDE },
    -- Draenor Pet Brawler
    9264,
    -- Master Draenor Crafter
    9246,
    -- Master of Apexis
    9265,
    -- Mythic Draenor Raider
    { id = 9631, faction = AchieveIt.Factions.ALLIANCE },
    -- Mythic Draenor Raider
    { id = 9255, faction = AchieveIt.Factions.HORDE }
};

-- Add category
local category = AchieveIt.Categories:addCategory(categoryId, _G["REWARDS"]);

-- add children
category:addChild(_G["UNIT_NAME_PLAYER_TITLE"], titleAchievements);
category:addChild(_G["MOUNTS"], mountAchievements);
category:addChild(_G["PETS"], petAchievements);
category:addChild(L["Tabards"], tabardAchievements);
category:addChild(_G["ITEMS"], itemAchievements);
category:addChild(_G["QUESTS_LABEL"], questAchievements);
category:addChild(L["Teleports"], teleportAchievements);
category:addChild(L["Blueprints"], blueprintAchievements);
category:addChild(_G["GARRISON_MONUMENTS_TITLE"], monumentAchievements);

category:inheritAchievements();