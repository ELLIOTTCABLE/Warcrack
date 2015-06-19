----------------------------------------------------------
-- Dungeons & Raids - Lich King Raid - The Ruby Sanctum --
----------------------------------------------------------

local AchieveIt = AchieveIt;

-- Locale
local L = LibStub("AceLocale-3.0"):GetLocale("AchieveIt");

-- The achievement category ID
local categoryId = 14922;

---------------------------
-- Ruby Sanctum Category --
---------------------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(609));

---------------------------
-- Ruby Sanctum / 10 Man --
---------------------------

category:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- The Twilight Destroyer (10 player)
	4817,
	-- Heroic: The Twilight Destroyer (10 player)
	4818
}).locate = function()

	-- in raid
	-- and 10 player
	return GetCurrentMapAreaID() == 609 and
			AchieveIt.difficulty.is10PlayerRaid();

end;

---------------------------
-- Ruby Sanctum / 25 Man --
---------------------------

category:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- The Twilight Destroyer (25 player)
	4815,
	-- Heroic: The Twilight Destroyer (25 player)
	4816
}).locate = function()

	-- in raid
	-- and 25 player
	return GetCurrentMapAreaID() == 609 and
			AchieveIt.difficulty.is25PlayerRaid();

end;

category:inheritAchievements();