---------------------------------------
-- Dungeons & Raids - Lich King Raid --
---------------------------------------

local AchieveIt = AchieveIt;

-- Locale
local L = LibStub("AceLocale-3.0"):GetLocale("AchieveIt");
local _G = _G;

-- The achievement category ID
local categoryId = 14922;

------------------------
-- Raids Sub Category --
------------------------

local raidsCategory = AchieveIt.Categories:addCategory(categoryId, _G["RAIDS"]);

-----------------------------
-- Raids / 10 Man Category --
-----------------------------

raidsCategory:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- Naxxramas 10 Player
	576,
	-- Eye of Eternity 10 Player
	622,
	-- Obsidium Sanctum 10 Player
	1876,
	-- Archavon 10 Player
	1722,
	-- Emalon 10 Player
	3136,
	-- Koralon 10 Player
	3836,
	-- Toravon 10 Player
	4585,
	-- Ulduar 10 Player
	2894,
	-- Trial of the Crusader 10 Player
	3917,
	-- Trial of the Grand Crusader 10 Player
	3918,
	-- Icecrown Citadel 10 Player
	4532,
	-- Icecrown Citadel Heroic 10 Player
	4636,
	-- Ruby Sanctum 10 Player
	4817,
	-- Ruby Sanctum Heroic 10 Player
	4818
});

-----------------------------
-- Raids / 25 Man Category --
-----------------------------

raidsCategory:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- Naxxramas 25 Player
	577,
	-- Eye of Eternity 25 Player
	623,
	-- Obsidium Sanctum 25 Player
	625,
	-- Archavon 25 Player
	1721,
	-- Emalon 25 Player
	3137,
	-- Koralon 25 Player
	3837,
	-- Toravon 25 Player
	4586,
	-- Ulduar 25 Player
	2895,
	-- Trial of the Crusader 25 Player
	3916,
	-- Trial of the Grand Crusader 25 Player
	3812,
	-- Icecrown Citadel 25 Player
	4608,
	-- Icecrown Citadel Heroic 25 Player
	4637,
	-- Ruby Sanctum 25 Player
	4815,
	-- Ruby Sanctum Heroic 25 Player
	4816
});

-- Add 10 / 25 man achievements to raids category
raidsCategory:inheritAchievements();