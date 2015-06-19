----------------------
-- Rewards Category --
----------------------

local AchieveIt = AchieveIt;

-- Locale
local L = LibStub("AceLocale-3.0"):GetLocale("AchieveIt");

-- The achievement category ID - top level achievement
local categoryId = false;

-- Add category
local category = AchieveIt.GuildCategories:addCategory(categoryId, _G["REWARDS"]);

-----------
-- Items --
-----------

local itemsCategory = category:addChild(_G["ITEMS"], itemAchievements);

------------------------------
-- Items / Battle Standards --
------------------------------

itemsCategory:addChild(L["Battle Standards"], {	
	-- A Daily Routine
	5422,
	-- Guild Cataclysm Dungeon Hero
	5143,
	-- Working as a Team
	4860,
    -- Guild Draenor Dungeon Hero
    9388
});

--------------------
-- Items / Cloaks --
--------------------

itemsCategory:addChild(L["Cloaks"], {		
	-- A Class Act
	4989,
	-- Master Crafter
	5035,
	-- Master Pandaria Crafter
	6702
});

-----------------------
-- Items / Heirlooms --
-----------------------

itemsCategory:addChild(L["Heirlooms"], {
	-- Working Better as a Team
	6626
});

---------------------------
-- Items / Bank Vouchers --
---------------------------

itemsCategory:addChild(L["Bank Vouchers"], {

	-- Stay Classy
	{
		id = 5152,
		faction = AchieveIt.Factions.ALLIANCE
	},
	-- Stay Classy
	{
		id = 5158,
		faction = AchieveIt.Factions.HORDE
	}
});

--------------------
-- Items / Shirts --
--------------------

itemsCategory:addChild(L["Shirts"], {
	-- Guild Pandaria Dungeon Hero
	6681,
	-- Pandaren Embassy
	{
		id = 6644,
		faction = AchieveIt.Factions.ALLIANCE
	},	
	-- Pandaren Embassy
	{
		id = 6664,
		faction = AchieveIt.Factions.HORDE
	},	
	-- Scenario Roundup
	{
		id = 7448,
		faction = AchieveIt.Factions.ALLIANCE
	},
	-- Scenario Roundup
	{
		id = 7449,
		faction = AchieveIt.Factions.HORDE
	}
});

itemsCategory:inheritAchievements();

------------
-- Mounts --
------------

category:addChild(_G["MOUNTS"], {
	-- Guild Glory of the Cataclysm Raider
	4988,
	-- Guild Glory of the Pandaria Raider
	6682,
    -- Guild Glory of the Draenor Raider
    9669
});

----------
-- Pets --
----------

category:addChild(_G["PETS"], {	
	-- Alliance Slayer
	{
		id = 5179,
		faction = AchieveIt.Factions.HORDE
	},
	-- Challenge Warlords: Gold - Guild Edition
    9651,
	-- Critter Kill Squad
	5144,
	-- Dragonwrath, Tarecgosa's Rest - Guild Edition
	5840,
	-- Horde Slayer
	{
		id = 5031,
		faction = AchieveIt.Factions.ALLIANCE
	},
	-- Profit Sharing
	5201,
	-- United Nations
	{
		id = 5812,
		faction = AchieveIt.Factions.ALLIANCE
	},
	-- United Nations
	{
		id = 5892,
		faction = AchieveIt.Factions.HORDE
	}
});

-------------
-- Recipes --
-------------

category:addChild(_G["TRADESKILL_SERVICE_LEARN"], {
	-- Better Leveling Through Chemistry
	5024,
	-- Mix Master
	5465,
	-- Set the Oven to "Cataclysmic"
	5467,
	-- That's a Lot of Bait
	5036
});

category:inheritAchievements();