
-------------------------------------------
-- Dungeons & Raids - Dungeon Challenges --
-------------------------------------------

local AchieveIt = AchieveIt;

-- Locale
local L = LibStub("AceLocale-3.0"):GetLocale("AchieveIt");

-- The achievement category ID
local categoryId = 15115;


------------------
-- All Category --
------------------

AchieveIt.Categories:addCategory(categoryId, L["Progress"], {
    -- Challenge Warlord
    8895,
    -- Challenge Warlord: Bronze
    8897,
    -- Challenge Warlord: Silver
    8898,
    -- Challenge Warlord: Gold
    8899
});


-----------------------------------
-- Bloodmaul Slag Mines Category --
-----------------------------------

AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(964), {
    -- Bloodmaul Slag Mines Challenger
    8875,
    -- Bloodmaul Slag Mines: Bronze
    8876,
    -- Bloodmaul Slag Mines: Silver
    8877,
    -- Bloodmaul Slag Mines: Gold
    8878
}).locate = function()

	-- in dungeon
	-- is challenge mode
	return 964 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isChallengeMode();

end;


-------------------------
-- Iron Docks Category --
-------------------------

AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(987), {
    -- Iron Docks Challenger
    8997,
    -- Iron Docks: Bronze
    8998,
    -- Iron Docks: Silver
    8999,
    -- Iron Docks: Gold
    9000
}).locate = function()

	-- in dungeon
	-- is challenge mode
	return 987 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isChallengeMode();

end;


-------------------------
-- Auchindoun Category --
-------------------------

AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(984), {
    -- Auchindoun Challenger
    8879,
    -- Auchindoun: Bronze
    8880,
    -- Auchindoun: Silver
    8881,
    -- Auchindoun: Gold
    8882
}).locate = function()

	-- in dungeon
	-- is challenge mode
	return 984 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isChallengeMode();

end;


-----------------------
-- Skyreach Category --
------------------------

AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(989), {
    -- Skyreach Challenger
    8871,
    -- Skyreach: Bronze
    8872,
    -- Skyreach: Silver
    8873,
    -- Skyreach: Gold
    8874
}).locate = function()

	-- in dungeon
	-- is challenge mode
	return 989 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isChallengeMode();

end;


----------------------------------------
-- Shadowmoon Burial Grounds Category --
----------------------------------------

AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(969), {
    -- Shadowmoon Burial Grounds Challenger
    8883,
    -- Shadowmoon Burial Grounds: Bronze
    8884,
    -- Shadowmoon Burial Grounds: Silver
    8885,
    -- Shadowmoon Burial Grounds: Gold
    8886
}).locate = function()

	-- in dungeon
	-- is challenge mode
	return 969 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isChallengeMode();

end;


-----------------------------
-- Grimrail Depot Category --
-----------------------------

AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(993), {
    -- Grimrail Depot Challenger
    8887,
    -- Grimrail Depot: Bronze
    8888,
    -- Grimrail Depot: Silver
    8889,
    -- Grimrail Depot: Gold
    8890
}).locate = function()

	-- in dungeon
	-- is challenge mode
	return 993 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isChallengeMode();

end;


----------------------------
-- The Everbloom Category --
----------------------------

AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(1008), {
    -- The Everbloom Challenger
    9001,
    -- The Everbloom: Bronze
    9002,
    -- The Everbloom: Silver
    9003,
    -- The Everbloom: Gold
    9004
}).locate = function()

	-- in dungeon
	-- is challenge mode
	return 1008 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isChallengeMode();

end;


------------------------------------
-- Upper Blackrock Spire Category --
------------------------------------

AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(995), {
    -- Upper Blackrock Spire Challenger
    8891,
    -- Upper Blackrock Spire: Bronze
    8892,
    -- Upper Blackrock Spire: Silver
    8893,
    -- Upper Blackrock Spire: Gold
    8894
}).locate = function()

	-- in dungeon
	-- is challenge mode
	return 995 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isChallengeMode();

end;