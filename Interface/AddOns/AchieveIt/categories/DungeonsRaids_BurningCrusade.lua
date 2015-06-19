-- Dungeons & Raids - The Burning Crusade

local AchieveIt = AchieveIt;

-- Locale
local L = LibStub("AceLocale-3.0"):GetLocale("AchieveIt");

-- The achievement category ID
local categoryId = 14805;

-----------------------
-- Dungeons Category --
-----------------------

local category = AchieveIt.Categories:addCategory(categoryId, _G["DUNGEONS"], {
	-- Hellfire Ramparts
	647,
	-- The Blood Furnace
	648,
	-- The Slave Pens
	649,
	-- Underbog
	650,
	-- Mana-Tombs
	651,
	-- Auchenai Crypts
	666,
	-- The Escape From Durnholde
	652,
	-- Sethekk Halls
	653,
	-- Shadow Labyrinth
	654,
	-- Opening of the Dark Portal
	655,
	-- The Steamvault
	656,
	-- The Shattered Halls
	657,
	-- The Mechanar
	658,
	-- The Botanica
	659,
	-- The Arcatraz
	660,
	-- Magister's Terrace
	661
});

category.locate = function()

	-- bc dungeon map ids
	local ids = {
		722, -- Auchenai Crypts
		797, -- Hellfire Ramparts
		798, -- Magisters' Terrace
		732, -- Mana-Tombs
		734, -- Old Hillsbrad Foothills
		723, -- Sethekk Halls
		724, -- Shadow Labyrinth
		731, -- The Arcatraz
		733, -- The Black Morass
		725, -- The Blood Furnace
		729, -- The Botanica
		730, -- The Mechanar
		710, -- The Shattered Halls
		728, -- The Slave Pens
		727, -- The Steamvault
		726  -- The Underbog
	};

	return AchieveIt:Contains(ids, GetCurrentMapAreaID()) -- user is in one of these dungeons
			and AchieveIt.difficulty.isDungeon(); -- and it is a normal version

end;

------------------------------
-- Heroic Dungeons Category --
------------------------------

local category = AchieveIt.Categories:addCategory(categoryId, L["Heroic Dungeons"], {
	-- Heroic: Hellfire Ramparts
	667,
	-- Heroic: The Blood Furnace
	668,
	-- Heroic: The Slave Pens
	669,
	-- Heroic: Underbog
	670,
	-- Heroic: Mana-Tombs
	671,
	-- Heroic: Auchenai Crypts
	672,
	-- Heroic: The Escape From Durnholde
	673,
	-- Heroic: Sethekk Halls
	674,
	-- Heroic: Shadow Labyrinth
	675,
	-- Heroic: Opening of the Dark Portal
	676,
	-- Heroic: The Steamvault
	677,
	-- Heroic: The Shattered Halls
	678,
	-- Heroic: The Mechanar
	679,
	-- Heroic: The Botanica
	680,
	-- Heroic: The Arcatraz
	681,
	-- Heroic: Magister's Terrace
	682
});

category.locate = function()

	-- bc dungeon map ids
	local ids = {
		722, -- Auchenai Crypts
		797, -- Hellfire Ramparts
		798, -- Magisters' Terrace
		732, -- Mana-Tombs
		734, -- Old Hillsbrad Foothills
		723, -- Sethekk Halls
		724, -- Shadow Labyrinth
		731, -- The Arcatraz
		733, -- The Black Morass
		725, -- The Blood Furnace
		729, -- The Botanica
		730, -- The Mechanar
		710, -- The Shattered Halls
		728, -- The Slave Pens
		727, -- The Steamvault
		726  -- The Underbog
	};

	return AchieveIt:Contains(ids, GetCurrentMapAreaID()) -- user is in one of these dungeons
			and AchieveIt.difficulty.isHeroicDungeon(); -- and it is a heroic version

end;

--------------------
-- Raids Category --
--------------------

local category = AchieveIt.Categories:addCategory(categoryId, _G["RAIDS"], {
	-- Karazhan
	690,
	-- Gruul's Lair
	692,
	-- Magtheridon's Lair
	693,
	-- Serpentshrine Cavern
	694,
	-- Tempest Keep
	696,
	-- The Battle for Mount Hyjal
	695,
	-- The Black Temple
	697,
	-- Sunwell Plateau
	698
});

category.locate = function()

	-- bc raid map ids
	local ids = {
		796, -- Black Temple
		776, -- Gruul's Lair
		775, -- Hyjal Summit
		799, -- Karazhan
		779, -- Magtheridon's Lair
		780, -- Serpentshrine Cavern
		789, -- Sunwell Plateau
		782  -- The Eye
	};

	return AchieveIt:Contains(ids, GetCurrentMapAreaID()); -- user is in one of these raids

end;