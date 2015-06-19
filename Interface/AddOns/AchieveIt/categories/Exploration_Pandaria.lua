
----------------------------
-- Exploration / Pandaria --
----------------------------

-- Added in Patch 5.4
if (AchieveIt.TOC_VERSION >= 50400) then


local AchieveIt = AchieveIt;

-- Locale
local L = LibStub("AceLocale-3.0"):GetLocale("AchieveIt");

-- The achievement category ID
local categoryId = 15113;

---------------------------
-- Timless Isle Category --
---------------------------

AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(951), {
	-- Killing Time
	8712,
	-- Timeless Champion
	8714,
	-- Timeless Nutriment
	8722,
	-- Pilgrimage
	8724,
	-- Legend of the Past
	8723,
	-- Timeless Legends
	8784,
	-- Eyes On The Ground
	8725,
	-- Extreme Treasure Hunter
	8726,
	-- Where There's Pirates, There's Booty
	8727,
	-- Treasure, Treasure Everywhere
	8729,
	-- Rolo's Riddle
	8730,
	-- Zarhym Altogether
	8743
}).locate = function()

	return 951 == GetCurrentMapAreaID();

end;

end