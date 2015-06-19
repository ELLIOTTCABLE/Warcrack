
------------
-- Legacy --
------------

local AchieveIt = AchieveIt;

-- Locale
local L = LibStub("AceLocale-3.0"):GetLocale("AchieveIt");

-- The achievement category ID
local categoryId = 15234;

----------------------------------
-- MoP Challenge Modes Category --
----------------------------------

local category = AchieveIt.Categories:addCategory(categoryId, L["MoP Challenge Modes"]);


------------------
-- All Category --
------------------

category:addChild(L["Progress"], {
	-- Challenge Conqueror
	6920,
	-- Challenge Conqueror: Bronze
	6374,
	-- Challenge Conqueror: Silver
	6375,
	-- Challenge Conqueror: Gold
	6378
});


---------------------------------
-- Stormstout Brewery Category --
---------------------------------

category:addChild(GetMapNameByID(876), {
	-- Stormstout Brewery Challenger
	6888,
	-- Stormstout Brewery: Bronze
	6889,
	-- Stormstout Brewery: Silver
	6890,
	-- Stormstout Brewery: Gold
	6891
}).locate = function()

	-- in dungeon
	-- is challenge mode
	return 876 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isChallengeMode();

end;


-----------------------------------------
-- Temple of the Jade Serpent Category --
-----------------------------------------

category:addChild(GetMapNameByID(867), {
	-- Temple of the Jade Serpent Challenger
	6884,
	-- Temple of the Jade Serpent: Bronze
	6885,
	-- Temple of the Jade Serpent: Silver
	6886,
	-- Temple of the Jade Serpent: Gold
	6887
}).locate = function()

	-- in dungeon
	-- is challenge mode
	return 867 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isChallengeMode();

end;


-------------------------------
-- Mogu'shan Palace Category --
-------------------------------

category:addChild(GetMapNameByID(885), {
	-- Mogu'shan Palace Challenger
	6892,
	-- Mogu'shan Palace: Bronze
	6899,
	-- Mogu'shan Palace: Silver
	6900,
	-- Mogu'shan Palace: Gold
	6901
}).locate = function()

	-- in dungeon
	-- is challenge mode
	return 885 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isChallengeMode();

end;


----------------------------------
-- Shado-Pan Monastery Category --
----------------------------------

category:addChild(GetMapNameByID(877), {
	-- Shado-Pan Monastery Challenger
	6893,
	-- Shado-Pan Monastery: Bronze
	6902,
	-- Shado-Pan Monastery: Silver
	6903,
	-- Shado-Pan Monastery: Gold
	6904
}).locate = function()

	-- in dungeon
	-- is challenge mode
	return 877 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isChallengeMode();

end;


--------------------------------------
-- Gate of the Setting Sun Category --
--------------------------------------

category:addChild(GetMapNameByID(875), {
	-- Gate of the Setting Sun Challenger
	6894,
	-- Gate of the Setting Sun: Bronze
	6905,
	-- Gate of the Setting Sun: Silver
	6906,
	-- Gate of the Setting Sun: Gold
	6907
}).locate = function()

	-- in dungeon
	-- is challenge mode
	return 875 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isChallengeMode();

end;


-------------------------------------
-- Siege of Niuzao Temple Category --
-------------------------------------

category:addChild(GetMapNameByID(887), {
	-- Siege of Niuzao Temple Challenger
	6898,
	-- Siege of Niuzao Temple: Bronze
	6917,
	-- Siege of Niuzao Temple: Silver
	6918,
	-- Siege of Niuzao Temple: Gold
	6919,
}).locate = function()

	-- in dungeon
	-- is challenge mode
	return 887 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isChallengeMode();

end;


----------------------------
-- Scarlet Halls Category --
----------------------------

category:addChild(GetMapNameByID(871), {
	-- Scarlet Halls Challenger
	6895,
	-- Scarlet Halls: Bronze
	6908,
	-- Scarlet Halls: Silver
	6909,
	-- Scarlet Halls: Gold
	6910
}).locate = function()

	-- in dungeon
	-- is challenge mode
	return 871 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isChallengeMode();

end;


--------------------------------
-- Scarlet Monastery Category --
--------------------------------

category:addChild(GetMapNameByID(874), {
	-- Scarlet Monastery Challenger
	6896,
	-- Scarlet Monastery: Bronze
	6911,
	-- Scarlet Monastery: Silver
	6912,
	-- Scarlet Monastery: Gold
	6913
}).locate = function()

	-- in dungeon
	-- is challenge mode
	return 874 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isChallengeMode();

end;


--------------------------
-- Scholomance Category --
--------------------------

category:addChild(GetMapNameByID(898), {
	-- Scholomance Challenger
	6897,
	-- Scholomance: Bronze
	6914,
	-- Scholomance: Silver
	6915,
	-- Scholomance: Gold
	6916
}).locate = function()

	-- in dungeon
	-- is challenge mode
	return 898 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isChallengeMode();

end;

category:inheritAchievements();