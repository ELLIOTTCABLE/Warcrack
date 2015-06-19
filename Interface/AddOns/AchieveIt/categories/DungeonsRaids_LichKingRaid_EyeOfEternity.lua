---------------------------------------------------------
-- Dungeons & Raids - Lich King Raid - Eye of Eternity --
---------------------------------------------------------

local AchieveIt = AchieveIt;

-- Locale
local L = LibStub("AceLocale-3.0"):GetLocale("AchieveIt");

-- The achievement category ID
local categoryId = 14922;

------------------------------
-- Eye of Eternity Category --
------------------------------

local eyeCategory = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(527));

------------------------------
-- Eye of Eternity / 10 Man --
------------------------------

eyeCategory:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- The Spellweaver's Downfall
	622,
	-- A Poke in the Eye
	1869,
	-- Denyin' the Scion
	2148,
	-- You Don't Have an Eternity
	1874
}).locate = function()

	-- in raid
	-- and 10 player
	return GetCurrentMapAreaID() == 527 and
			AchieveIt.difficulty.is10PlayerRaid();

end;

------------------------------
-- Eye of Eternity / 25 Man --
------------------------------

eyeCategory:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- The Spellweaver's Downfall
	623,
	-- A Poke in the Eye
	1870,
	-- Denyin' the Scion
	2149,
	-- You Don't Have an Eternity
	1875
}).locate = function()

	-- in raid
	-- and 25 player
	return GetCurrentMapAreaID() == 527 and
			AchieveIt.difficulty.is25PlayerRaid();

end;

eyeCategory:inheritAchievements();