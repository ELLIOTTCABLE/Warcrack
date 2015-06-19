--------------------------------------------
-- Scenarios  / Mists of Pandari Category --
--------------------------------------------

local AchieveIt = AchieveIt;

-- Locale
local L = LibStub("AceLocale-3.0"):GetLocale("AchieveIt");

-- The achievement category ID
local categoryId = 15229;

---------
-- All --
---------

AchieveIt.Categories:addCategory(categoryId, L["Progress"], {
	-- Scenaturday
	{
		id = 6874,
		faction = AchieveIt.Factions.ALLIANCE
	},
	-- Scenaturday
	{
		id = 7509,
		faction = AchieveIt.Factions.HORDE
	},
	-- Pub Crawl
	7385
});

---------------------
-- A Brewing Storm --
---------------------

AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(878), {
	-- A Brewing Storm
	7252,
	-- Heroic: A Brewing Storm
	8310,
	-- Don't Shake the Keg
	7257,
	-- Party of Six
	7258,
	-- The Perfect Pour
	7261
}).locate = function()

	-- in scenario
	return 878 == GetCurrentMapAreaID();

end;

-----------------------
-- A Little Patience --
-----------------------

AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(912), {
	-- A Little Patience
	7988,
	-- Bubbletrapped!
	7989,
	-- Cannonballer
	7990,
	-- I Used To Love Them
	7992,
	-- We've Been Dancin'
	7993,
	-- Which Came First?
	7991
}).locate = function()

	-- in scenario
	return 912 == GetCurrentMapAreaID();

end;

---------------------------
-- Arena of Annihilation --
---------------------------

AchieveIt.Categories:addCategory(categoryId, L["Arena of Annihilation"], {
	-- Arena of Annihilation
	7271,
	-- Beat the Heat
	7273,
	-- In the Eye of the Tiger
	7272
}).locate = function()

	-- in scenario
	return 899 == GetCurrentMapAreaID();

end;

-------------------------
-- Assault on Zan'vess --
-------------------------

AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(883), {
	-- Assault on Zan'vess
	8016,
	-- For the Swarm
	8017
}).locate = function()

	-- in scenario
	return 883 == GetCurrentMapAreaID();

end;

-----------------------
-- Brewmoon Festival --
-----------------------

AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(884), {
	-- Brewmoon Festival
	6923,
	-- Binan Village All-Star
	6931,
	-- Yaungolian Barbecue
	6930
}).locate = function()

	-- in scenario
	return 884 == GetCurrentMapAreaID();

end;

------------------------------
-- Crypt of Forgotten Kings --
------------------------------

AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(900), {
	-- Crypt of Forgotten Kings
	7522,
	-- Heroic: Crypt of Forgotten Kings
	8311,
	-- Fancy Footwork
	7276,
	-- Fight Anger with Anger
	8368,
	-- It's a Trap!
	7275
}).locate = function()

	-- in scenario
	return 900 == GetCurrentMapAreaID();

end;

------------------------
-- Dagger in the Dark --
------------------------


AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(914), {
	-- Dagger in the Dark
	8009,
	-- No Egg Left Behind
	7987,
	-- Watery Grave
	7984,
	-- You Mean That Wasn't a Void Zone?
	7986
}).locate = function()

	-- in scenario
	return 914 == GetCurrentMapAreaID();

end;

----------------------
-- Domination Point --
----------------------

if (AchieveIt.FACTION == "Horde") then

	AchieveIt.Categories:addCategory(categoryId, L["Domination Point"], {
		-- Domination Point
		{
			id = 8013,
			faction = AchieveIt.Factions.HORDE
		},
		-- Number Five Is Alive
		{
			id = 8014,
			faction = AchieveIt.Factions.HORDE
		},
		-- Waste Not, Want Not
		{
			id = 8015,
			faction = AchieveIt.Factions.HORDE
		}
	}).locate = function()

		-- in scenario
		return 920 == GetCurrentMapAreaID();

	end;

end

------------------------
-- Greenstone Village --
------------------------

AchieveIt.Categories:addCategory(categoryId, L["Greenstone Village"], {
	-- Greenstone Village
	7265,
	-- Perfect Delivery
	7267,
	-- Save it for Later
	7266
}).locate = function()

	-- in scenario
	return 880 == GetCurrentMapAreaID();

end;

--------------------
-- Lion's Landing --
--------------------

if (AchieveIt.FACTION == "Alliance") then

	AchieveIt.Categories:addCategory(categoryId, L["Lion's Landing"], {
		-- Lion's Landing
		{
			id = 8010,
			faction = AchieveIt.Factions.ALLIANCE
		},
		-- Number Five Is Alive
		{
			id = 8011,
			faction = AchieveIt.Factions.ALLIANCE
		},
		-- Waste Not, Want Not
		{
			id = 8012,
			faction = AchieveIt.Factions.ALLIANCE
		}
	}).locate = function()

		-- in scenario
		return 911 == GetCurrentMapAreaID();

	end;

end

----------------------
-- Theramore's Fall --
----------------------

AchieveIt.Categories:addCategory(categoryId, L["Theramore's Fall"], {
	-- Theramore's Fall
	{
		id = 7523,
		faction = AchieveIt.Factions.ALLIANCE
	},
	-- Theramore's Fall
	{
		id = 7524,
		faction = AchieveIt.Factions.HORDE
	},
	-- Kite Fight
	{
		id = 7526,
		faction = AchieveIt.Factions.ALLIANCE
	},
	-- Kite Fight
	{
		id = 7529,
		faction = AchieveIt.Factions.HORDE
	},
	-- No Tank You
	{
		id = 7527,
		faction = AchieveIt.Factions.ALLIANCE
	},
	-- No Tank You
	{
		id = 7530,
		faction = AchieveIt.Factions.HORDE
	}
}).locate = function()

	-- in scenario
	return 906 == GetCurrentMapAreaID() or
			851 == GetCurrentMapAreaID();

end;

----------------
-- Unga Ingoo --
----------------

AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(882), {
	-- Unga Ingoo
	7249,
	-- Monkey See, Monkey Kill
	7248,
	-- Monkey in the Middle
	7239,
	-- Spill No Evil
	7231,
	-- The Keg Runner
	7232
}).locate = function()

	-- in scenario
	return 882 == GetCurrentMapAreaID();

end;

-- Added in Patch 5.3
if (AchieveIt.TOC_VERSION > 50200) then

-----------------------------
-- Battle on the High Seas --
-----------------------------

AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(940), {
	-- Battle on the High Seas
	{
		id = 8314,
		faction = AchieveIt.Factions.ALLIANCE
	},
	-- Battle on the High Seas
	{
		id = 8315,
		faction = AchieveIt.Factions.HORDE
	},
	-- Heroic: Battle on the High Seas
	{
		id = 8364,
		faction = AchieveIt.Factions.ALLIANCE
	},
	-- Heroic: Battle on the High Seas
	{
		id = 8366,
		faction = AchieveIt.Factions.HORDE
	},
	-- Keep those Bombs Away! from me...
	8347
}).locate = function()

	-- in scenario
	return 940 == GetCurrentMapAreaID();

end;

-----------------------
-- Blood in the Snow --
-----------------------

AchieveIt.Categories:addCategory(categoryId, L["Blood in the Snow"], {
	-- Blood in the Snow
	8316,
	-- Heroic: Blood in the Snow
	8312,
	-- Heed the Weed
	8329,
	-- Hekima's Heal-Halter
	8330
}).locate = function()

	-- in scenario
	return 939 == GetCurrentMapAreaID();

end;

----------------------------
-- Dark Heart of Pandaria --
----------------------------

AchieveIt.Categories:addCategory(categoryId, L["Dark Heart of Pandaria"], {
	-- Dark Heart of Pandaria
	8317,
	-- Heroic: Dark Heart of Pandaria
	8318,
	-- Accelerated Archaeology
	8319
}).locate = function()

	-- in scenario
	return 937 == GetCurrentMapAreaID();

end;

-----------------------------
-- The Secrets of Ragefire --
-----------------------------

AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(938), {
	-- The Secrets of Ragefire
	8294,
	-- Heroic: The Secrets of Ragefire
	8327,
	-- The Few, the Proud, the Gob Squad
	8295
}).locate = function()

	-- in scenario
	return 938 == GetCurrentMapAreaID();

end;



end