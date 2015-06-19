--------------------------------------
-- Dungeons & Raids - Pandaria Raid --
--------------------------------------

local AchieveIt = AchieveIt;

-- Locale
local L = LibStub("AceLocale-3.0"):GetLocale("AchieveIt");

-- The achievement category ID
local categoryId = 15107;

---------------------------
-- World Bosses Category --
---------------------------

local category = AchieveIt.Categories:addCategory(categoryId, L["World Bosses"], {
	-- Settle Down, Bro
	6480,
	-- Extinction Event
	6517,
	-- Praise the Sun!
	AchieveIt.TOC_VERSION > 50100 and 8028 or nil,
	-- Millions of Years of Evolution vs. My Fist
	AchieveIt.TOC_VERSION > 50100 and 8123 or nil,
	-- Celestial Challenge
	AchieveIt.TOC_VERSION >= 50400 and 8535,
	-- Ordos
	AchieveIt.TOC_VERSION >= 50400 and 8533
});

-------------------------------
-- Mogu'shan Vaults Category --
-------------------------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(896));

category.locate = function()

	-- in raid
	return 896 == GetCurrentMapAreaID();

end;

-------------------------------
-- Mogu'shan Vaults / Bosses --
-------------------------------

category:addChild(L["Progress"], {
	-- Guardians of Mogu'shan
	6458,
	-- The Vault of Mysteries
	6844,
	-- Heroic: Stone Guard
	6719,
	-- Heroic: Feng the Accursed
	6720,
	-- Heroic: Gara'jal the Spiritbinder
	6721,
	-- Heroic: Four Kings
	6722,
	-- Heroic: Elegon
	6723,
	-- Heroic: Will of the Emperor
	6724
});

----------------------------------------
-- Mogu'shan Vaults / The Stone Guard --
----------------------------------------

category:addChild(L["The Stone Guard"], {
	-- Heroic: Stone Guard
	6719,
	-- Must Love Dogs
	6823
}).locate = function()

	-- in raid
	-- not raid finder
	-- on level 1
	-- and in box
	return 896 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder() and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.Box:containsPlayer(41, 67, 54, 75);

end;

------------------------------------------
-- Mogu'shan Vaults / Feng the Accursed --
------------------------------------------

category:addChild(L["Feng the Accursed"], {
	-- Heroic: Feng the Accursed
	6720,
	-- Anything You Can Do, I Can Do Better...
	6674
}).locate = function()

	-- in raid
	-- not raid finder
	-- on level 1
	-- and in box
	return 896 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder() and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.Box:containsPlayer(24, 39, 20, 44);

end;

--------------------------------------------------
-- Mogu'shan Vaults / Gara'jal the Spiritbinder --
--------------------------------------------------

category:addChild(L["Gara'jal the Spiritbinder"], {
	-- Heroic: Gara'jal the Spiritbinder
	6721,
	-- Sorry, Were You Looking for This?
	7056
}).locate = function()

	-- in raid
	-- not raid finder
	-- on level 2
	-- and in box
	return 896 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder() and
			GetCurrentMapDungeonLevel() == 2 and
			AchieveIt.Box:containsPlayer(62, 90, 15, 56);

end;

-----------------------------------------
-- Mogu'shan Vaults / The Spirit Kings --
-----------------------------------------

category:addChild(L["The Spirit Kings"], {
	-- Heroic: Four Kings
	6722,
	-- Getting Hot In Here
	6687
}).locate = function()

	-- in raid
	-- not raid finder
	-- on level 2
	-- and in box
	return 896 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder() and
			GetCurrentMapDungeonLevel() == 2 and
			AchieveIt.Box:containsPlayer(5, 44, 21, 76);

end;

-------------------------------
-- Mogu'shan Vaults / Elegon --
-------------------------------

category:addChild(L["Elegon"], {
	-- Heroic: Elegon
	6723,
	-- Straight Six
	6686
}).locate = function()

	-- in raid
	-- not raid finder
	-- on level 3
	-- and in box
	return 896 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder() and
			GetCurrentMapDungeonLevel() == 3 and
			AchieveIt.Box:containsPlayer(8, 44, 31, 70);

end;

--------------------------------------------
-- Mogu'shan Vaults / Will of the Emperor --
--------------------------------------------

category:addChild(L["Will of the Emperor"], {
	-- Heroic: Will of the Emperor
	6724,
	-- Show Me Your Moves!
	6455
}).locate = function()

	-- in raid
	-- not raid finder
	-- on level 3
	-- and in box
	return 896 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder() and
			GetCurrentMapDungeonLevel() == 3 and
			AchieveIt.Box:containsPlayer(53, 85, 52, 95);

end;


category:inheritAchievements();


----------------------------
-- Heart of Fear Category --
----------------------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(897));

category.locate = function()

	-- in raid
	return 897 == GetCurrentMapAreaID();

end;

----------------------------
-- Heart of Fear / Bosses --
----------------------------

category:addChild(L["Progress"], {
	-- The Dread Approach
	6718,
	-- Nightmare of Shek'zeer
	6845,
	-- Heroic: Imperial Vizier Zor'lok
	6725,
	-- Heroic: Blade Lord Ta'yak
	6726,
	-- Heroic: Garalon
	6727,
	-- Heroic: Wind Lord Mel'jarak
	6728,
	-- Heroic: Amber-Shaper Un'sok
	6729,
	-- Heroic: Grand Empress Shek'zeer
	6730	
});

---------------------------------------------
-- Heart of Fear / Imperial Vizier Zor'lok --
---------------------------------------------

category:addChild(L["Imperial Vizier Zor'lok"], {
	-- Heroic: Imperial Vizier Zor'lok
	6725,
	-- Overzealous
	6937
}).locate = function()

	-- in raid
	-- not raid finder
	-- on level 1
	-- and in box
	return 897 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder() and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.Box:containsPlayer(50, 77, 48, 86);

end;

---------------------------------------
-- Heart of Fear / Blade Lord Ta'yak --
---------------------------------------

category:addChild(L["Blade Lord Ta'yak"], {
	-- Heroic: Blade Lord Ta'yak
	6726,
	-- Candle in the Wind
	6936	
}).locate = function()

	-- in raid
	-- not raid finder
	-- on level 1
	-- and in box
	return 897 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder() and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.Box:containsPlayer(42, 78, 11, 48);

end;

-----------------------------
-- Heart of Fear / Garalon --
-----------------------------

category:addChild(L["Garalon"], {
	-- Heroic: Garalon
	6727,
	-- Like an Arrow to the Face
	6553	
}).locate = function()

	-- in raid
	-- not raid finder
	-- on level 2
	-- and in box
	return 897 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder() and
			GetCurrentMapDungeonLevel() == 2 and
			AchieveIt.Box:containsPlayer(59, 72, 6, 23);

end;

-----------------------------------------
-- Heart of Fear / Wind Lord Mel'jarak --
-----------------------------------------

category:addChild(L["Wind Lord Mel'jarak"], {
	-- Heroic: Wind Lord Mel'jarak
	6728,
	-- Less Than Three
	6683	
}).locate = function()

	-- in raid
	-- not raid finder
	-- on level 2
	-- and in box
	return 897 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder() and
			GetCurrentMapDungeonLevel() == 2 and
			AchieveIt.Box:containsPlayer(59, 73, 24, 44);

end;

-----------------------------------------
-- Heart of Fear / Amber-Shaper Un'sok --
-----------------------------------------

category:addChild(L["Amber-Shaper Un'sok"], {
	-- Heroic: Amber-Shaper Un'sok
	6729,
	-- I Heard You Like Amber...
	6518	
}).locate = function()

	-- in raid
	-- not raid finder
	-- on level 2
	-- and in box
	return 897 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder() and
			GetCurrentMapDungeonLevel() == 2 and
			AchieveIt.Box:containsPlayer(41, 59, 60, 88);

end;

---------------------------------------------
-- Heart of Fear / Grand Empress Shek'zeer --
---------------------------------------------

category:addChild(L["Grand Empress Shek'zeer"], {
	-- Heroic: Grand Empress Shek'zeer
	6730,
	-- Timing is Everything
	6922	
}).locate = function()

	-- in raid
	-- not raid finder
	-- on level 2
	-- and in box
	return 897 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder() and
			GetCurrentMapDungeonLevel() == 2 and
			AchieveIt.Box:containsPlayer(17, 40, 52, 95);

end;

category:inheritAchievements();


----------------------------------------
-- Terrace of Endless Spring Category --
----------------------------------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(886));

category.locate = function()

	-- in raid
	return 886 == GetCurrentMapAreaID();

end;

----------------------------------------
-- Terrace of Endless Spring / Bosses --
----------------------------------------

category:addChild(L["Progress"], {
	-- Terrace of Endless Spring
	6689,
	-- Heroic: Protectors of the Endless
	6731,
	-- Heroic: Tsulong
	6732,
	-- Heroic: Lei Shi
	6733,
	-- Heroic: Sha of Fear
	6734
});

-----------------------------------------------------------
-- Terrace of Endless Spring / Protectors of the Endless --
-----------------------------------------------------------

category:addChild(L["Protectors of the Endless"], {
	-- Heroic: Protectors of the Endless
	6731,
	-- Power Overwhelming
	6717
}).locate = function()

	-- in raid
	-- not raid finder
	if (
		886 == GetCurrentMapAreaID() and
		not AchieveIt.difficulty.isRaidFinder()
	) then

		-- get instance lock
		local lockTimeleft, isPreviousInstance, encountersTotal, encountersComplete = GetInstanceLockTimeRemaining();

		-- boss not yet killed
		return encountersComplete == 0;

	end

end;

-----------------------------------------
-- Terrace of Endless Spring / Tsulong --
-----------------------------------------

category:addChild(L["Tsulong"], {
	-- Heroic: Tsulong
	6732,
	-- Who's Got Two Green Thumbs?
	6933
}).locate = function()

	-- in raid
	-- not raid finder
	if (
		886 == GetCurrentMapAreaID() and
		not AchieveIt.difficulty.isRaidFinder()
	) then

		-- get instance lock
		local lockTimeleft, isPreviousInstance, encountersTotal, encountersComplete = GetInstanceLockTimeRemaining();

		-- boss not yet killed
		return encountersComplete == 1;

	end

end;

-----------------------------------------
-- Terrace of Endless Spring / Lei Shi --
-----------------------------------------

category:addChild(L["Lei Shi"], {
	-- Heroic: Lei Shi
	6733,
	-- Face Clutchers
	6824
}).locate = function()

	-- in raid
	-- not raid finder
	if (
		886 == GetCurrentMapAreaID() and
		not AchieveIt.difficulty.isRaidFinder()
	) then

		-- get instance lock
		local lockTimeleft, isPreviousInstance, encountersTotal, encountersComplete = GetInstanceLockTimeRemaining();

		-- boss not yet killed
		return encountersComplete == 2;

	end

end;

---------------------------------------------
-- Terrace of Endless Spring / Sha of Fear --
---------------------------------------------

category:addChild(L["Sha of Fear"], {
	-- Heroic: Sha of Fear
	6734,
	-- The Mind-Killer
	6825
}).locate = function()

	-- in raid
	-- not raid finder
	if (
		886 == GetCurrentMapAreaID() and
		not AchieveIt.difficulty.isRaidFinder()
	) then

		-- get instance lock
		local lockTimeleft, isPreviousInstance, encountersTotal, encountersComplete = GetInstanceLockTimeRemaining();

		-- boss not yet killed
		return encountersComplete == 3;

	end

end;

category:inheritAchievements();

if (AchieveIt.TOC_VERSION >= 50200) then

--------------------------------
-- Throne of Thunder Category --
--------------------------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(930));

category.locate = function()
	
	-- in raid
	return 930 == GetCurrentMapAreaID();

end;

--------------------------------
-- Throne of Thunder / Bosses --
--------------------------------

category:addChild(L["Progress"], {
	-- Last Stand of the Zandalari
	8069,
	-- Forgotten Depths
	8070,
	-- Halls of Flesh-Shaping
	8071,
	-- Pinnacle of Storms
	8072,
	-- Glory of the Orgrimmar Raider
	8454,
	-- Heroic: Jin'rokh the Breaker
	8056,
	-- Heroic: Horridon
	8057,
	-- Heroic: Council of Elders
	8058,
	-- Heroic: Tortos
	8059,
	-- Heroic: Megaera
	8060,
	-- Heroic: Ji-Kun
	8061,
	-- Heroic: Durumu the Forgotten
	8062,
	-- Heroic: Primordius
	8063,
	-- Heroic: Dark Animus
	8064,
	-- Heroic: Iron Qon
	8065,
	-- Heroic: Twin Consorts
	8066,
	-- Heroic: Lei Shen
	8067,
	-- Heroic: Ra-den
	8068
});

----------------------------------------------
-- Throne of Thunder / Jin'rokh the Breaker --
----------------------------------------------

category:addChild(L["Jin'rokh the Breaker"], {
	-- Heroic: Jin'rokh the Breaker
	8056,
	-- Lightning Overload
	8094
}).locate = function()

	-- in raid
	-- not raid finder
	-- on level 1
	-- and in box
	return 930 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder() and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.Box:containsPlayer(49, 67, 13, 35);

end;

----------------------------------
-- Throne of Thunder / Horridon --
----------------------------------

category:addChild(L["Horridon"], {
	-- Heroic: Horridon
	8057,
	-- Cretaceous Collector
	8038
}).locate = function()

	-- in raid
	-- not raid finder
	-- on level 2
	-- and in box
	return 930 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder() and
			GetCurrentMapDungeonLevel() == 2 and
			AchieveIt.Box:containsPlayer(13, 37, 64, 93);

end;

-------------------------------------------
-- Throne of Thunder / Council of Elders --
-------------------------------------------

category:addChild(L["Council of Elders"], {
	-- Heroic: Council of Elders
	8058,
	-- Cage Match
	8073
}).locate = function()

	-- in raid
	-- not raid finder
	-- on level 2
	-- and in box
	return 930 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder() and
			GetCurrentMapDungeonLevel() == 2 and
			AchieveIt.Box:containsPlayer(36, 55, 3, 33);

end;

--------------------------------
--------------------------------

category:addChild(L["Tortos"], {
	-- Heroic: Tortos
	8059,
	-- One-Up
	8077
}).locate = function()

	-- in raid
	-- not raid finder
	-- on level 3
	-- and in box
	return 930 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder() and
			GetCurrentMapDungeonLevel() == 3 and
			AchieveIt.Box:containsPlayer(20, 35, 73, 92);

end;

---------------------------------
-- Throne of Thunder / Megaera --
---------------------------------

category:addChild(L["Megaera"], {
	-- Heroic: Megaera
	8060,
	-- Head Case
	8082
}).locate = function()

	-- in raid
	-- not raid finder
	-- on level 3
	-- and in box
	return 930 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder() and
			GetCurrentMapDungeonLevel() == 3 and
			AchieveIt.Box:containsPlayer(53, 73, 21, 57);

end;

--------------------------------
-- Throne of Thunder / Ji-kun --
--------------------------------

category:addChild(L["Ji-kun"], {
	-- Heroic: Ji-Kun
	8061,
	-- Soft Hands
	8097
}).locate = function()

	-- in raid
	-- not raid finder
	-- on level 4
	return 930 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder() and
			GetCurrentMapDungeonLevel() == 4;

end;

----------------------------------------------
-- Throne of Thunder / Durumu the Forgotten --
----------------------------------------------

category:addChild(L["Durumu the Forgotten"], {
	-- Heroic: Durumu the Forgotten
	8062,
	-- You Said Crossing the Streams Was Bad
	8098
}).locate = function()

	-- in raid
	-- not raid finder
	-- on level 5
	-- and in box
	return 930 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder() and
			GetCurrentMapDungeonLevel() == 5 and
			AchieveIt.Box:containsPlayer(60, 81, 18, 48);

end;

------------------------------------
-- Throne of Thunder / Primordius --
------------------------------------

category:addChild(L["Primordius"], {
	-- Heroic: Primordius
	8063,
	-- Genetically Unmodified Organism
	8037
}).locate = function()

	-- in raid
	-- not raid finder
	-- on level 5
	-- and in box
	return 930 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder() and
			GetCurrentMapDungeonLevel() == 5 and
			AchieveIt.Box:containsPlayer(50, 66, 68, 91);

end;

-------------------------------------
-- Throne of Thunder / Dark Animus --
-------------------------------------

category:addChild(L["Dark Animus"], {
	-- Heroic: Dark Animus
	8064,
	-- Ritualist Who?
	8081
}).locate = function()

	-- in raid
	-- not raid finder
	-- on level 5
	-- and in box
	return 930 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder() and
			GetCurrentMapDungeonLevel() == 5 and
			AchieveIt.Box:containsPlayer(33, 49, 45, 67);

end;

----------------------------------
-- Throne of Thunder / Iron Qon --
----------------------------------

category:addChild(L["Iron Qon"], {
	-- Heroic: Iron Qon
	8065,
	-- Can't Touch This
	8087
}).locate = function()

	-- in raid
	-- not raid finder
	-- on level 6
	-- and in box
	return 930 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder() and
			GetCurrentMapDungeonLevel() == 6 and
			AchieveIt.Box:containsPlayer(3, 40, 39, 76);

end;

---------------------------------------
-- Throne of Thunder / Twin Consorts --
---------------------------------------

category:addChild(L["Twin Consorts"], {
	-- Heroic: Twin Consorts
	8066,
	-- From Dusk 'til Dawn
	8086
}).locate = function()

	-- in raid
	-- not raid finder
	-- on level 6
	-- and in box
	return 930 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder() and
			GetCurrentMapDungeonLevel() == 6 and
			AchieveIt.Box:containsPlayer(64, 90, 19, 54);

end;

----------------------------------
-- Throne of Thunder / Lei Shen --
----------------------------------

category:addChild(L["Lei Shen"], {
	-- Heroic: Lei Shen
	8067,
	-- A Complete Circuit
	8090
}).locate = function()

	-- in raid
	-- not raid finder
	-- on level 7
	return 930 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder() and
			GetCurrentMapDungeonLevel() == 7;

end;

--------------------------------
-- Throne of Thunder / Ra-den --
--------------------------------

category:addChild(L["Ra-den"], {
	-- Heroic: Ra-den
	8068
}).locate = function()

	-- in raid
	-- not raid finder
	-- on level 8
	return 930 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder() and
			GetCurrentMapDungeonLevel() == 8;

end;


category:inheritAchievements();

end

---------------------------------
-- Siege of Orgrimmar Category --
---------------------------------

if (AchieveIt.TOC_VERSION >= 50400) then

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(953));

category.locate = function()
	
	-- in raid
	return 953 == GetCurrentMapAreaID();

end;

---------------------------------
-- Siege of Orgrimmar / Bosses --
---------------------------------

category:addChild(L["Progress"], {
	-- Vale of Eternal Sorrows
	8458,
	-- Gates of Retribution
	8459,
	-- The Underhold
	8461,
	-- Downfall
	8462,
	-- Conqueror of Orgrimmar
	{
		id = 8679,
		faction = AchieveIt.Factions.ALLIANCE
	},
	-- Liberator of Orgrimmar
	{
		id = 8680,
		faction = AchieveIt.Factions.HORDE
	},
	-- Heroic: Immerseus
	8463,
	-- Heroic: Fallen Protectors
	8465,
	-- Heroic: Norushen
	8466,
	-- Heroic: Sha of Pride
	8467,
	-- Heroic: Galakras
	8468,
	-- Heroic: Iron Juggernaut
	8469,
	-- Heroic: Kor'kron Dark Shaman
	8470,
	-- Heroic: General Nazgrim
	8471,
	-- Heroic: Malkorok
	8472,
	-- Heroic: Spoils of Pandaria
	8478,
	-- Heroic: Thok the Bloodthirsty
	8479,
	-- Heroic: Siegecrafter Blackfuse
	8480,
	-- Heroic: Paragons of the Klaxxi
	8481,
	-- Heroic: Garrosh Hellscream
	8482
});

------------------------------------
-- Siege of Orgrimmar / Immerseus --
------------------------------------

category:addChild(L["Immerseus"], {
	-- No More Tears
	8536,
	-- Heroic: Immerseus
	8463
}).locate = function()

	-- in raid
	-- not raid finder
	return 953 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder();

end;

--------------------------------------------
-- Siege of Orgrimmar / Fallen Protectors --
--------------------------------------------

category:addChild(L["The Fallen Protectors"], {
	-- Go Long
	8528,
	-- Heroic: Fallen Protectors
	8465
}).locate = function()

	-- in raid
	-- not raid finder
	return 953 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder();

end;

-----------------------------------
-- Siege of Orgrimmar / Norushen --
-----------------------------------

category:addChild(L["Norushen"], {
	-- None Shall Pass
	8532,
	-- Heroic: Norushen
	8466
}).locate = function()

	-- in raid
	-- not raid finder
	return 953 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder();

end;

---------------------------------------
-- Siege of Orgrimmar / Sha of Pride --
---------------------------------------

category:addChild(L["Sha of Pride"], {
	-- Swallow Your Pride
	8521,
	-- Heroic: Sha of Pride
	8467
}).locate = function()

	-- in raid
	-- not raid finder
	return 953 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder();

end;

-----------------------------------
-- Siege of Orgrimmar / Galakras --
-----------------------------------

category:addChild(L["Galakras"], {
	-- The Immortal Vanguard
	8530,
	-- Heroic: Galakras
	8468
}).locate = function()

	-- in raid
	-- not raid finder
	return 953 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder();

end;

------------------------------------------
-- Siege of Orgrimmar / Iron Juggernaut --
------------------------------------------

category:addChild(L["Iron Juggernaut"], {
	-- Fire in the Hole!
	8520,
	-- Heroic: Iron Juggernaut
	8469
}).locate = function()

	-- in raid
	-- not raid finder
	return 953 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder();

end;

-----------------------------------------------
-- Siege of Orgrimmar / Kor'kron Dark Shaman --
-----------------------------------------------

category:addChild(L["Kor'kron Dark Shaman"], {
	-- Rescue Raiders
	8453,
	-- Heroic: Kor'kron Dark Shaman
	8470
}).locate = function()

	-- in raid
	-- not raid finder
	return 953 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder();

end;

------------------------------------------
-- Siege of Orgrimmar / General Nazgrim --
------------------------------------------

category:addChild(L["General Nazgrim"], {
	-- Gamon Will Save Us!
	8448,
	-- Heroic: General Nazgrim
	8471
}).locate = function()

	-- in raid
	-- not raid finder
	return 953 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder();

end;

-----------------------------------
-- Siege of Orgrimmar / Malkorok --
-----------------------------------

category:addChild(L["Malkorok"], {
	-- Unlimited Potential
	8538,
	-- Heroic: Malkorok
	8472
}).locate = function()

	-- in raid
	-- not raid finder
	return 953 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder();

end;

---------------------------------------------
-- Siege of Orgrimmar / Spoils of Pandaria --
---------------------------------------------

category:addChild(L["Spoils of Pandaria"], {
	-- Criss Cross
	8529,
	-- Heroic: Spoils of Pandaria
	8478
}).locate = function()

	-- in raid
	-- not raid finder
	return 953 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder();

end;

------------------------------------------------
-- Siege of Orgrimmar / Thok the Bloodthirsty --
------------------------------------------------

category:addChild(L["Thok the Bloodthirsty"], {
	-- Giant Dinosaur vs. Mega Snail
	8527,
	-- Heroic: Thok the Bloodthirsty
	8479
}).locate = function()

	-- in raid
	-- not raid finder
	return 953 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder();

end;

-------------------------------------------------
-- Siege of Orgrimmar / Siegecrafter Blackfuse --
-------------------------------------------------

category:addChild(L["Siegecrafter Blackfuse"], {
	-- Lasers and Magnets and Drills! Oh My!
	8543,
	-- Heroic: Siegecrafter Blackfuse
	8480
}).locate = function()

	-- in raid
	-- not raid finder
	return 953 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder();

end;

-------------------------------------------------
-- Siege of Orgrimmar / Paragons of the Klaxxi --
-------------------------------------------------

category:addChild(L["Paragons of the Klaxxi"], {
	-- Now We are the Paragon
	8531,
	-- Heroic: Paragons of the Klaxxi
	8481
}).locate = function()

	-- in raid
	-- not raid finder
	return 953 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder();

end;

---------------------------------------------
-- Siege of Orgrimmar / Garrosh Hellscream --
---------------------------------------------

category:addChild(L["Garrosh Hellscream"], {
	-- Strike!
	8537,	
	-- Conqueror of Orgrimmar
	{
		id = 8679,
		faction = AchieveIt.Factions.ALLIANCE
	},
	-- Liberator of Orgrimmar
	{
		id = 8680,
		faction = AchieveIt.Factions.HORDE
	},
	-- Heroic: Garrosh Hellscream
	8482
}).locate = function()

	-- in raid
	-- not raid finder
	return 953 == GetCurrentMapAreaID() and
			not AchieveIt.difficulty.isRaidFinder();

end;

category:inheritAchievements();

end