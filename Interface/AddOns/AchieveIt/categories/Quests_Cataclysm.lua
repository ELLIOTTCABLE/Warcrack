
------------------------
-- Quests / Cataclysm --
------------------------

local AchieveIt = AchieveIt;

-- Locale
local L = LibStub("AceLocale-3.0"):GetLocale("AchieveIt");

-- The achievement category ID
local categoryId = 15070;

--------------------------
-- Mount Hyjal Category --
--------------------------

AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(606), {
	-- Coming Down the Mountain
	4870,
	-- Beware of the 'Unbeatable?' Pterodactyl
	4959,
	-- Bounce
	5483,
	-- The 'Unbeatable?' Pterodactyl: BEATEN.
	5860	
});

-----------------------
-- Vashj'ir Category --
-----------------------

AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(613), {
	-- Sinking into Vashj'ir
	{
		id = 4869,
		faction = AchieveIt.Factions.ALLIANCE
	},
	-- Sinking into Vashj'ir
	{
		id = 4982,
		faction = AchieveIt.Factions.HORDE
	},
	-- 20,000 Leagues Under the Sea
	{
		id = 5318,
		faction = AchieveIt.Factions.ALLIANCE
	},
	-- 20,000 Leagues Under the Sea
	{
		id = 5319,
		faction = AchieveIt.Factions.HORDE
	},
	-- Visions of Vashj'ir Past
	5452	
});

-----------------------
-- Deepholm Category --
-----------------------

AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(640), {
	-- Deep into Deepholm
	4871,
	-- Fungal Frenzy
	5450,
	-- Fungalophobia
	5445,
	-- My Very Own Broodmother
	5447,
	-- Rock Lover
	5449,
	-- The Glop Family Line
	5446	
});

--------------------
-- Uldum Category --
--------------------

AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(720), {
	-- Unearthing Uldum
	4872,
	-- Help the Bombardier! I'm the Bombardier!
	5317,
	-- In a Thousand Years Even You Might be Worth Something
	4961	
});

---------------------------------
-- Twilight Highlands Category --
---------------------------------

AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(700), {
	-- Fading into Twilight
	{
		id = 4873,
		faction = AchieveIt.Factions.ALLIANCE
	},
	-- Fading into Twilight
	{
		id = 5501,
		faction = AchieveIt.Factions.HORDE
	},
	-- King of the Mountain
	{
		id = 5320,
		faction = AchieveIt.Factions.ALLIANCE
	},
	-- King of the Mountain
	{
		id = 5321,
		faction = AchieveIt.Factions.HORDE
	},
	-- Round Three. Fight!
	4960,	
	-- Consumed by Nightmare
	5451,
	-- Wildhammer Tour of Duty
	{
		id = 5481,
		faction = AchieveIt.Factions.ALLIANCE
	},
	-- Dragonmaw Tour of Duty
	{
		id = 5482,
		faction = AchieveIt.Factions.HORDE
	}	
});

------------------------
-- Tol Barad Category --
------------------------

AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(708), {
	-- Breaking Out of Tol Barad
	4874	
});

---------------------------
-- Molten Front Category --
---------------------------

AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(795), {
	-- Veteran of the Molten Front
	5879,
	-- And the Meek Shall Inherit Kalimdor
	5868,
	-- Death From Above
	5874,
	-- Fireside Chat
	5870,
	-- Flawless Victory
	5867,
	-- Gang War
	5864,
	-- Have... Have We Met?
	5865,
	-- Infernal Ambassadors
	5869,
	-- King of the Spider-Hill
	5872,
	-- Legacy of Leyara
	5859,
	-- Ludicrous Speed
	5862,
	-- Master of the Molten Flow
	5871,
	-- Ready for Raiding II
	5873,
	-- The Fiery Lords of Sethria's Roost
	5861,
	-- The Molten Front Offensive
	5866
}).locate = function()
	
	return 795 == GetCurrentMapAreaID();

end;