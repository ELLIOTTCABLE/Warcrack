
-----------------------
-- Quests / Pandaria --
-----------------------

local AchieveIt = AchieveIt;

-- Locale
local L = LibStub("AceLocale-3.0"):GetLocale("AchieveIt");

-- The achievement category ID
local categoryId = 15110;

--------------------
-- Zones Category --
--------------------

AchieveIt.Categories:addCategory(categoryId, L["Progress"], {
	-- Loremaster of Pandaria
	6541,
	-- Upjade Complete
	{
		id = 6300,
		faction = AchieveIt.Factions.ALLIANCE
	},
	-- Upjade Complete
	{
		id = 6534,
		faction = AchieveIt.Factions.HORDE
	},
	-- Rally the Valley
	6301,
	-- Mighty Roamin' Krasaranger
	{
		id = 6535,
		faction = AchieveIt.Factions.ALLIANCE
	},
	-- Mighty Roamin' Krasaranger
	{
		id = 6536,
		faction = AchieveIt.Factions.HORDE
	},
	-- Savior of Stoneplow
	7502,
	-- Dominance Offensive
	{
		id = 7929,
		faction = AchieveIt.Factions.HORDE
	},
	-- Operation: Shieldwall
	{
		id = 7928,
		faction = AchieveIt.Factions.ALLIANCE
	},
	-- Slum It in the Summit
	{
		id = 6537,
		faction = AchieveIt.Factions.ALLIANCE
	},
	-- Slum It in the Summit
	{
		id = 6538,
		faction = AchieveIt.Factions.HORDE
	},
	-- One Steppe Forward, Two Steppes Back
	6539,
	-- Dread Haste Makes Dread Waste
	6540,
	-- Eternally in the Vale
	7315,
	-- Every Day I'm Pand-a-ren
	7285
});


--------------------------------
-- August Celestials Category --
--------------------------------

local category = AchieveIt.Categories:addCategory(categoryId, L["The August Celestials"]);

-- August Celestials / Cradle of Chi-Ji
category:addChild(L["Cradle of Chi-Ji"], {
	-- Champion of Chi-Ji
	7287
});

-- August Celestials / Temple of the White Tiger
category:addChild(L["Temple of the White Tiger"], {
	-- Finish Them!
	7286
});

-- August Celestials / Niuzao Temple
category:addChild(L["Niuzao Temple"], {	
	-- Yak Attack
	7288
});

category:inheritAchievements();


---------------------------
-- Golden Lotus Category --
---------------------------

AchieveIt.Categories:addCategory(categoryId, L["Golden Lotus"], {
	-- A Taste of History
	7318,
	-- Collateral Damage
	7323,
	-- Dog Pile
	7320,
	-- One Many Army
	7317,
	-- One Step at a Time
	7324,
	-- Ready for Raiding III
	7319,
	-- Roll Club
	7322,
	-- Spreading the Warmth
	7321
});


---------------------
-- Klaxxi Category --
---------------------

AchieveIt.Categories:addCategory(categoryId, L["The Klaxxi"], {
	-- Amber is the Color of My Energy
	7312,	
	-- Over Their Heads
	7316,
	-- Stay Klaxxi
	7313,
	-- Test Drive
	7314
});


-----------------------------------------
-- Order of the Cloud Serpent Category --
-----------------------------------------

AchieveIt.Categories:addCategory(categoryId, L["Order of the Cloud Serpent"], {
	-- How To Strain Your Dragon
	7290,
	-- In a Trail of Smoke
	7291,
	-- Shadow Hopper
	7289	
});


------------------------
-- Shado-Pan Category --
------------------------

local category = AchieveIt.Categories:addCategory(categoryId, L["Shado-Pan"], {
	-- Defender of Gods
	7310,
	-- Getting Around with the Shado-Pan
	7298,
	-- Loner and a Rebel
	7299,
	-- Proven Strength
	7297
});

-- Shado-Pan / Wu Kao Assassins
category:addChild(L["Wu Kao Assassins"], {
	-- Silent Assassin
	7307	
});

-- Shado-Pan / Blackguard Defenders
category:addChild(L["Blackguard Defenders"], {
	-- Fire in the Yaung-hole!
	7309,
	-- Know Your Role
	7308
});

category:inheritAchievements();

----------------------
-- Tillers Category --
----------------------

AchieveIt.Categories:addCategory(categoryId, L["The Tillers"], {
	-- Green Acres
	7292,
	-- A Taste of Things to Come
	7294,
	-- Till the Break of Dawn
	7293,
	-- Listen to the Drunk Fish
	7295,
	-- Ain't Lost No More
	7296
});

-- Added in Patch 5.2
if (AchieveIt.TOC_VERSION > 50100) then

------------------------------
-- Isle of Thunder Category --
------------------------------

AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(928), {
	-- Stormbreaker
	8121,
	-- Isle of Thunder
	8099,
	-- Thunder Plunder
	8104,
	-- When in Ihgaluk, Do as the Skumblade Do
	8108,
	-- This Isn't Even My Final Form
	8111,
	-- Platform Hero
	8114,
	-- You Made Me Bleed My Own Blood
	8116,
	-- Boop
	8118,
	-- Direhorn in a China Shop
	8120,
	-- Pay to Slay
	8100,
	-- It Was Worth Every Ritual Stone
	8101,
	-- The Crumble Bundle
	8105,
	-- Ready for RAAAAIIIIDDD?!?ing
	8107,
	-- The Mogu Below-gu
	8109,
	-- These Mogu Have Gotta Go-gu
	8110,
	-- Blue Response
	8112,
	-- Speed Metal
	8115,
	-- For the Ward!
	8117,
	-- Our Powers Combined
	8119,
	-- Zandalari Library Card
	8212
}).locate = function()

	-- in zone
	return GetCurrentMapAreaID() == 928;

end;

end

-- Added in Patch 5.3 and moved to Feat of Strength in 5.4
if (AchieveIt.TOC_VERSION == 50300) then

---------------------------------
-- Darkspear Uprising Category --
---------------------------------

AchieveIt.Categories:addCategory(categoryId, L["Darkspear Uprising"], {
	-- Darkspear Revolutionary
	{
		id = 8307,
		faction = AchieveIt.Factions.HORDE
	},
	-- Hordebreaker
	{
		id = 8306,
		faction = AchieveIt.Factions.ALLIANCE
	}
});

end