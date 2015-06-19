----------------------------------------------------------
-- Dungeons & Raids - Lich King Raid - Obsidian Sanctum --
----------------------------------------------------------

local AchieveIt = AchieveIt;

-- Locale
local L = LibStub("AceLocale-3.0"):GetLocale("AchieveIt");

-- The achievement category ID
local categoryId = 14922;

-------------------------------
-- Obsidian Sanctum Category --
-------------------------------

local obsidianSanctumCategory = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(531));

--------------------------------
-- Obsidian Sanctum / 10 Man --
--------------------------------

obsidianSanctumCategory:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- Besting the Black Dragonflight
	1876,
	-- Gonna Go When the Volcano Blows
	2047,
	-- Less Is More
	624,
	-- Twilight Assist
	2049,
	-- Twilight Duo
	2050,
	-- The Twilight Zone
	2051
}).locate = function()

	-- in raid
	-- and 10 player
	return GetCurrentMapAreaID() == 531 and
			AchieveIt.difficulty.is10PlayerRaid();

end;

--------------------------------
-- Obsidian Sanctum / 25 Man --
--------------------------------

obsidianSanctumCategory:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- Besting the Black Dragonflight
	625,
	-- Gonna Go When the Volcano Blows
	2048,
	-- Less Is More
	1877,
	-- Twilight Assist
	2052,
	-- Twilight Duo
	2053,
	-- The Twilight Zone
	2054
}).locate = function()

	-- in raid
	-- and 25 player
	return GetCurrentMapAreaID() == 531 and
			AchieveIt.difficulty.is25PlayerRaid();

end;

obsidianSanctumCategory:inheritAchievements();