------------------------------------------------------------
-- Dungeons & Raids - Lich King Raid  - Vault of Archavon --
------------------------------------------------------------

local AchieveIt = AchieveIt;

-- Locale
local L = LibStub("AceLocale-3.0"):GetLocale("AchieveIt");

-- The achievement category ID
local categoryId = 14922;

--------------------------------
-- Vault of Archavon Category --
--------------------------------

local vaultOfArchavonCategory = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(532));

--------------------------------
-- Vault of Archavon / 10 Man --
--------------------------------

vaultOfArchavonCategory:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- Archavon
	1722,
	-- Emalon
	3136,
	-- Koralon
	3836,
	-- Toravon
	4585,
	-- Earth, Wind & Fire
	4016
}).locate = function()

	-- in raid
	-- and 10 player
	return GetCurrentMapAreaID() == 532 and
			AchieveIt.difficulty.is10PlayerRaid();

end;

--------------------------------
-- Vault of Archavon / 25 Man --
--------------------------------

vaultOfArchavonCategory:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- Archavon
	1721,
	-- Emalon
	3137,
	-- Koralon
	3837,
	-- Toravon
	4586,
	-- Earth, Wind & Fire
	4017
}).locate = function()

	-- in raid
	-- and 25 player
	return GetCurrentMapAreaID() == 532 and
			AchieveIt.difficulty.is25PlayerRaid();

end;

vaultOfArchavonCategory:inheritAchievements();