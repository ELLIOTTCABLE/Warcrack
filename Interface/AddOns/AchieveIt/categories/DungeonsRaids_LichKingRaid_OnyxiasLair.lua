-------------------------------------------------------
-- Dungeons & Raids - Lich King Raid - Onyxia's Lair --
-------------------------------------------------------

local AchieveIt = AchieveIt;

-- Locale
local L = LibStub("AceLocale-3.0"):GetLocale("AchieveIt");

-- The achievement category ID
local categoryId = 14922;

------------------------------
-- Onyxia's Lair Category --
------------------------------

local onyxiaCategory = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(718));

----------------------------
-- Onyxia's Lair / 10 Man --
----------------------------

onyxiaCategory:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- Onyxia's Lair
	4396,
	-- She Deep Breaths More
	4404,
	-- More Dots!
	4402,
	-- Many Whelps! Handle It!
	4403
}).locate = function()

	-- in raid
	-- and 10 player
	return GetCurrentMapAreaID() == 718 and
			AchieveIt.difficulty.is10PlayerRaid();

end;

----------------------------
-- Onyxia's Lair / 25 Man --
----------------------------

onyxiaCategory:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- Onyxia's Lair
	4397,
	-- She Deep Breaths More
	4407,
	-- More Dots!
	4405,
	-- Many Whelps! Handle It!
	4406
}).locate = function()

	-- in raid
	-- and 25 player
	return GetCurrentMapAreaID() == 718 and
			AchieveIt.difficulty.is25PlayerRaid();

end;

onyxiaCategory:inheritAchievements();