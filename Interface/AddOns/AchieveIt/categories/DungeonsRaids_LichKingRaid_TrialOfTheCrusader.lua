---------------------------------------------------------------
-- Dungeons & Raids - Lich King Raid - Trial of the Crusader --
---------------------------------------------------------------

local AchieveIt = AchieveIt;

-- Locale
local L = LibStub("AceLocale-3.0"):GetLocale("AchieveIt");

-- The achievement category ID
local categoryId = 14922;

------------------------------------
-- Trial of the Crusader Category --
------------------------------------

local trialCategory = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(543));

trialCategory.locate = function()
	
	return GetCurrentMapAreaID() == 543;

end;

------------------------------------
-- Trial of the Crusader / Bosses --
------------------------------------

local bossCategory = trialCategory:addChild(L["Progress"]);

------------------------------------------------
-- Trial of the Crusader / Bosses / 10 Player --
------------------------------------------------

bossCategory:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- Call of the Crusade (10 Player)
	3917,
	-- Call of the Grand Crusade (10 player)
	3918
});

------------------------------------------------
-- Trial of the Crusader / Bosses / 25 Player --
------------------------------------------------

bossCategory:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- Call of the Crusade (25 player)
	3916,
	-- Call of the Grand Crusade (25 player)
	3812
});

bossCategory:inheritAchievements();

----------------------------------------------
-- Trial of the Crusader / Northrend Beasts --
----------------------------------------------

local beastsCategory = trialCategory:addChild(L["The Beasts of Northrend"]);

----------------------------------------------------------
-- Trial of the Crusader / Northrend Beasts / 10 Player --
----------------------------------------------------------

beastsCategory:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- Not One, But Two Jormungars
	3936,
	-- Upper Back Pain
	3797
}).locate = function()

	-- in raid
	-- on floor 1
	-- and 10 player
	if (
		GetCurrentMapAreaID() == 543 and
		GetCurrentMapDungeonLevel() == 1 and
		AchieveIt.difficulty.is10PlayerRaid()
	) then

		-- get instance lock
		local lockTimeleft, isPreviousInstance, encountersTotal, encountersComplete = GetInstanceLockTimeRemaining();

		-- first boss not yet killed
		return encountersComplete == 0;

	end

	return false;

end;

----------------------------------------------------------
-- Trial of the Crusader / Northrend Beasts / 25 Player --
----------------------------------------------------------

beastsCategory:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- Not One, But Two Jormungars
	3937,
	-- Upper Back Pain
	3813
}).locate = function()

	-- in raid
	-- on floor 1
	-- and 25 player
	if (
		GetCurrentMapAreaID() == 543 and
		GetCurrentMapDungeonLevel() == 1 and
		AchieveIt.difficulty.is25PlayerRaid()
	) then

		-- get instance lock
		local lockTimeleft, isPreviousInstance, encountersTotal, encountersComplete = GetInstanceLockTimeRemaining();

		-- first boss not yet killed
		return encountersComplete == 0;

	end

	return false;

end;

beastsCategory:inheritAchievements();

-------------------------------------------
-- Trial of the Crusader / Lord Jaraxxus --
-------------------------------------------

local jaraxxusCategory = trialCategory:addChild(L["Lord Jaraxxus"]);

-------------------------------------------------------
-- Trial of the Crusader / Lord Jaraxxus / 10 Player --
-------------------------------------------------------

jaraxxusCategory:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- Three Sixty Pain Spike
	3996
}).locate = function()

	-- in raid
	-- on floor 1
	-- and 10 player
	if (
		GetCurrentMapAreaID() == 543 and
		GetCurrentMapDungeonLevel() == 1 and
		AchieveIt.difficulty.is10PlayerRaid()
	) then

		-- get instance lock
		local lockTimeleft, isPreviousInstance, encountersTotal, encountersComplete = GetInstanceLockTimeRemaining();

		-- this boss not yet killed
		return encountersComplete == 1;

	end

	return false;

end;

-------------------------------------------------------
-- Trial of the Crusader / Lord Jaraxxus / 25 Player --
-------------------------------------------------------

jaraxxusCategory:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- Three Sixty Pain Spike
	3997
}).locate = function()

	-- in raid
	-- on floor 1
	-- and 25 player
	if (
		GetCurrentMapAreaID() == 543 and
		GetCurrentMapDungeonLevel() == 1 and
		AchieveIt.difficulty.is25PlayerRaid()
	) then

		-- get instance lock
		local lockTimeleft, isPreviousInstance, encountersTotal, encountersComplete = GetInstanceLockTimeRemaining();

		-- this boss not yet killed
		return encountersComplete == 1;

	end

	return false;

end;

jaraxxusCategory:inheritAchievements();

-----------------------------------------------
-- Trial of the Crusader / Faction Champions --
-----------------------------------------------

local factionChampionsCategory = trialCategory:addChild(L["Faction Champions"]);

-------------------------------------------------------
-- Trial of the Crusader / Faction Champions / 10 Player --
-------------------------------------------------------

factionChampionsCategory:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- Resilience Will Fix It
	3798
}).locate = function()

	-- in raid
	-- on floor 1
	-- and 10 player
	if (
		GetCurrentMapAreaID() == 543 and
		GetCurrentMapDungeonLevel() == 1 and
		AchieveIt.difficulty.is10PlayerRaid()
	) then

		-- get instance lock
		local lockTimeleft, isPreviousInstance, encountersTotal, encountersComplete = GetInstanceLockTimeRemaining();

		-- this boss not yet killed
		return encountersComplete == 2;

	end

	return false;

end;

factionChampionsCategory:inheritAchievements();

-------------------------------------------
-- Trial of the Crusader / Twin Val'kyr --
-------------------------------------------

local twinValkyrCategory = trialCategory:addChild(L["The Twin Val'kyr"]);

-------------------------------------------------------
-- Trial of the Crusader / Twin Val'kyr / 10 Player --
-------------------------------------------------------

twinValkyrCategory:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- Salt and Pepper
	3799
}).locate = function()

	-- in raid
	-- on floor 1
	-- and 10 player
	if (
		GetCurrentMapAreaID() == 543 and
		GetCurrentMapDungeonLevel() == 1 and
		AchieveIt.difficulty.is10PlayerRaid()
	) then

		-- get instance lock
		local lockTimeleft, isPreviousInstance, encountersTotal, encountersComplete = GetInstanceLockTimeRemaining();

		-- this boss not yet killed
		return encountersComplete == 3;

	end

	return false;

end;

-------------------------------------------------------
-- Trial of the Crusader / Twin Val'kyr / 25 Player --
-------------------------------------------------------

twinValkyrCategory:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- Salt and Pepper
	3815
}).locate = function()

	-- in raid
	-- on floor 1
	-- and 25 player
	if (
		GetCurrentMapAreaID() == 543 and
		GetCurrentMapDungeonLevel() == 1 and
		AchieveIt.difficulty.is25PlayerRaid()
	) then

		-- get instance lock
		local lockTimeleft, isPreviousInstance, encountersTotal, encountersComplete = GetInstanceLockTimeRemaining();

		-- this boss not yet killed
		return encountersComplete == 3;

	end

	return false;

end;

twinValkyrCategory:inheritAchievements();

---------------------------------------
-- Trial of the Crusader / Anub'arak --
---------------------------------------

local anubarakCategory = trialCategory:addChild(L["Anub'arak"]);

---------------------------------------------------
-- Trial of the Crusader / Anub'arak / 10 Player --
---------------------------------------------------

anubarakCategory:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- The Traitor King
	3800
}).locate = function()

	-- in raid
	-- on floor 2
	-- and 10 player
	return GetCurrentMapAreaID() == 543 and
			GetCurrentMapDungeonLevel() == 2 and
			AchieveIt.difficulty.is10PlayerRaid();

end;

---------------------------------------------------
-- Trial of the Crusader / Anub'arak / 25 Player --
---------------------------------------------------

anubarakCategory:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- The Traitor King
	3816
}).locate = function()

	-- in raid
	-- on floor 2
	-- and 25 player
	return GetCurrentMapAreaID() == 543 and
			GetCurrentMapDungeonLevel() == 2 and
			AchieveIt.difficulty.is25PlayerRaid();

end;

anubarakCategory:inheritAchievements();


trialCategory:inheritAchievements();