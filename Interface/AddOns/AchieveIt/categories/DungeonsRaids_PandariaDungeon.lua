-----------------------------------------
-- Dungeons & Raids - Pandaria Dungeon --
-----------------------------------------

local AchieveIt = AchieveIt;

-- Locale
local L = LibStub("AceLocale-3.0"):GetLocale("AchieveIt");

-- The achievement category ID
local categoryId = 15106;

-----------------------
-- Dungeons Category --
-----------------------

AchieveIt.Categories:addCategory(categoryId, _G["DUNGEONS"], {
	-- Stormstout Brewery
	6457,
	-- Temple of the Jade Serpent
	6757,
	-- Mogu'shan Palace
	6755,
	-- Shado-Pan Monastery
	6469
}).locate = function()

	-- classic dungeon map ids
	local ids = {
		876, -- Stormstout Brewery
		867, -- Temple of the Jade Serpent
		885, -- Mogu'shan Palace
		877  -- Shado-Pan Monastery
	};

	return AchieveIt:Contains(ids, GetCurrentMapAreaID()) -- user is in one of these dungeons
			and AchieveIt.difficulty.isDungeon(); -- and it is a normal version

end;

------------------------------
-- Heroic Dungeons Category --
------------------------------

AchieveIt.Categories:addCategory(categoryId, L["Heroic Dungeons"], {
	-- Heroic: Stormstout Brewery
	6456,
	-- Heroic: Temple of the Jade Serpent
	6758,
	-- Heroic: Mogu'shan Palace
	6756,
	-- Heroic: Shado-Pan Monastery
	6470,
	-- Heroic: Gate of the Setting Sun
	6759,	
	-- Heroic: Siege of Niuzao Temple
	6763,
	-- Heroic: Scarlet Halls
	6760,
	-- Heroic: Scarlet Monastery
	6761,
	-- Heroic: Scholomance
	6762
});

---------------------------------
-- Stormstout Brewery Category --
---------------------------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(876), {
	-- Stormstout Brewery
	6457,
	-- Heroic: Stormstout Brewery
	6456,
	-- How Did He Get Up There?
	6400,
	-- Ling-Ting's Herbal Journey
	6402
});

category.locate = function()

	-- in dungeon
	-- and heroic version
	return 876 == GetCurrentMapAreaID()
			and AchieveIt.difficulty.isHeroicDungeon();

end;

----------------------------------
-- Stormstout Brewery / Ook-Ook --
----------------------------------

category:addChild(L["Ook-Ook"], {
	-- Keep Rollin' Rollin' Rollin'
	6089
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- on level 2
	return 876 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 2;

end;

------------------------------------
-- Stormstout Brewery / Hoptallus --
------------------------------------

category:addChild(L["Hoptallus"], {
	-- Hopocalypse Now!
	6420
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- on level 3
	-- and in box
	return 876 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 3 and
			AchieveIt.Box:containsPlayer(27, 48, 32, 57);

end;

-----------------------------------------------
-- Stormstout Brewery / Yan-Zhu the Uncasked --
-----------------------------------------------

category:addChild(L["Yan-Zhu the Uncasked"], {
	-- Polyformic Acid Science
	6715
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- on level 4
	return 876 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 4;

end;

category:inheritAchievements();


-----------------------------------------
-- Temple of the Jade Serpent Category --
-----------------------------------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(867), {
	-- Temple of the Jade Serpent
	6757,
	-- Heroic: Temple of the Jade Serpent
	6758
});

category.locate = function()

	-- in dungeon
	-- and heroic version
	return 867 == GetCurrentMapAreaID()
			and AchieveIt.difficulty.isHeroicDungeon();

end;

--------------------------------------------
-- Temple of the Jade Serpent / Wise Mari --
--------------------------------------------

category:addChild(L["Wise Mari"], {
	-- Hydrophobia
	6460
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- on level 1
	-- and in box
	return 867 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.Box:containsPlayer(34, 50, 3, 29);

end;

-------------------------------------------------
-- Temple of the Jade Serpent / Liu Flameheart --
-------------------------------------------------

category:addChild(L["Liu Flameheart"], {
	-- Polyformic Acid Science
	6715
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- on level 1
	-- and in box
	return 867 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.Box:containsPlayer(39, 52, 39, 64);

end;

-----------------------------------------------
-- Temple of the Jade Serpent / Sha of Doubt --
-----------------------------------------------

category:addChild(L["Sha of Doubt"], {
	-- Cleaning Up
	6475,
	-- Seeds of Doubt
	6671
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- on level 1
	-- and in box
	return 867 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.Box:containsPlayer(53, 67, 45, 77);

end;

category:inheritAchievements();


-------------------------------
-- Mogu'shan Palace Category --
-------------------------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(885), {
	-- Mogu'shan Palace
	6755,
	-- Heroic: Mogu'shan Palace
	6756,
	-- Quarrelsome Quilen Quintet
	6713
});

category.locate = function()

	-- in dungeon
	-- and heroic version
	return 885 == GetCurrentMapAreaID()
			and AchieveIt.difficulty.isHeroicDungeon();

end;

------------------------------------------
-- Mogu'shan Palace / Trial of the King --
------------------------------------------

category:addChild(L["Trial of the King"], {
	-- Polyformic Acid Science
	6715
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- on level 1
	-- and in box
	return 885 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.Box:containsPlayer(30, 54, 47, 89);

end;

-------------------------------
-- Mogu'shan Palace / Gekkan --
-------------------------------

category:addChild(L["Gekkan"], {
	-- Glintrok N' Roll
	6478
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- on level 2
	-- and in box
	return 885 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 2 and
			AchieveIt.Box:containsPlayer(34, 55, 57, 93);

end;

---------------------------------------------
-- Mogu'shan Palace / Xin the Weaponmaster --
---------------------------------------------

category:addChild(L["Xin the Weaponmaster"], {
	-- What Does This Button Do?
	6736
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- on level 3
	-- and in box
	return 885 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 3 and
			AchieveIt.Box:containsPlayer(32, 49, 57, 94);

end;

category:inheritAchievements();


----------------------------------
-- Shado-Pan Monastery Category --
----------------------------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(877), {
	-- Shado-Pan Monastery
	6469,
	-- Heroic: Shado-Pan Monastery
	6470
});

category.locate = function()

	-- in dungeon
	-- and heroic version
	return 877 == GetCurrentMapAreaID()
			and AchieveIt.difficulty.isHeroicDungeon();

end;

------------------------------------------
-- Shado-Pan Monastery / Gu Cloudstrike --
------------------------------------------

category:addChild(L["Gu Cloudstrike"], {
	-- Polyformic Acid Science
	6715
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- on level 2
	-- and in box
	return 877 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 2 and
			AchieveIt.Box:containsPlayer(28, 67, 9, 54);

end;

--------------------------------------------
-- Shado-Pan Monastery / Master Snowdrift --
--------------------------------------------

category:addChild(L["Master Snowdrift"], {
	-- Respect
	6477
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- on level 3
	return 877 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 3;

end;

-------------------------------------------
-- Shado-Pan Monastery / Sha of Violence --
-------------------------------------------

category:addChild(L["Sha of Violence"], {
	-- The Obvious Solution
	6472
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- on level 4
	return 877 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 4;

end;

-------------------------------------
-- Shado-Pan Monastery / Taran Zhu --
-------------------------------------

category:addChild(L["Taran Zhu"], {
	-- Hate Leads to Suffering
	6471
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- on level 1
	-- and in box
	return 877 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.Box:containsPlayer(62, 80, 37, 58);

end;

category:inheritAchievements();


--------------------------------------
-- Gate of the Setting Sun Category --
--------------------------------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(875), {
	-- Heroic: Gate of the Setting Sun
	6759,
	-- Conscriptinator
	6476
});

category.locate = function()

	-- in dungeon
	-- and heroic version
	return 875 == GetCurrentMapAreaID()
			and AchieveIt.difficulty.isHeroicDungeon();

end;

--------------------------------------------------
-- Gate of the Setting Sun / Saboteur Kip'tilak --
--------------------------------------------------

category:addChild(L["Saboteur Kip'tilak"], {
	-- Bomberman
	6479
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- on level 1
	-- and in box
	return 875 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.Box:containsPlayer(41, 53, 81, 94);

end;

------------------------------------------------
-- Gate of the Setting Sun / Commander Ri'mok --
------------------------------------------------

category:addChild(L["Commander Ri'mok"], {
	-- Polyformic Acid Science
	6715
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- on level 1
	-- and in box
	return 875 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.Box:containsPlayer(40, 52, 16, 37);

end;

---------------------------------------
-- Gate of the Setting Sun / Raigonn --
---------------------------------------

category:addChild(L["Raigonn"], {
	-- Mantid Swarm
	6945
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- on level 1
	-- and in box
	return 875 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.Box:containsPlayer(42.5, 53, 47, 73);

end;

category:inheritAchievements();


-------------------------------------
-- Siege of Niuzao Temple Category --
-------------------------------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(887), {
	-- Heroic: Siege of Niuzao Temple
	6763
});

category.locate = function()

	-- in dungeon
	-- and heroic version
	return 887 == GetCurrentMapAreaID()
			and AchieveIt.difficulty.isHeroicDungeon();

end;

---------------------------------------------
-- Siege of Niuzao Temple / Vizier Jin'bak --
---------------------------------------------

category:addChild(L["Vizier Jin'bak"], {
	-- Polyformic Acid Science
	6715
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- on level 2
	return 887 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 2;

end;

-----------------------------------------------
-- Siege of Niuzao Temple / Commander Vo'jak --
-----------------------------------------------

category:addChild(L["Commander Vo'jak"], {
	-- Where's My Air Support?
	6688
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- on level 1
	-- and in box
	return 887 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.Box:containsPlayer(30, 48, 60, 87);

end;

-----------------------------------------------
-- Siege of Niuzao Temple / General Pa'valak --
-----------------------------------------------

category:addChild(L["General Pa'valak"], {
	-- Return to Sender
	6485
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- on level 1
	-- and in box
	return 887 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.Box:containsPlayer(45, 60, 34, 55);

end;

---------------------------------------------------
-- Siege of Niuzao Temple / Wing Leader Ner'onok --
---------------------------------------------------

category:addChild(L["Wing Leader Ner'onok"], {
	-- Run with the Wind
	6822
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- on level 1
	-- and in box
	return 887 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.Box:containsPlayer(53, 61, 13, 31);

end;

category:inheritAchievements();


----------------------------
-- Scarlet Halls Category --
----------------------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(871), {
	-- Heroic: Scarlet Halls
	6760
});

category.locate = function()

	-- in dungeon
	-- and heroic version
	return 871 == GetCurrentMapAreaID()
			and AchieveIt.difficulty.isHeroicDungeon();

end;

---------------------------------------
-- Scarlet Halls / Houndmaster Braun --
---------------------------------------

category:addChild(L["Houndmaster Braun"], {
	-- Humane Society
	6684
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- on level 1
	-- and in box
	return 871 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.Box:containsPlayer(49, 60, 20, 37);

end;

---------------------------------------
-- Scarlet Halls / Armsmaster Harlan --
---------------------------------------

category:addChild(L["Armsmaster Harlan"], {
	-- Mosh Pit
	6427
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- on level 2
	-- and in box
	return 871 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 2 and
			AchieveIt.Box:containsPlayer(54, 69, 33, 58);

end;

category:inheritAchievements();


--------------------------------
-- Scarlet Monastery Category --
--------------------------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(874), {
	-- Heroic: Scarlet Monastery
	6761,
});

category.locate = function()

	-- in dungeon
	-- and heroic version
	return 874 == GetCurrentMapAreaID()
			and AchieveIt.difficulty.isHeroicDungeon();

end;

------------------------------------------------
-- Scarlet Monastery / Thalnos the Soulrender --
------------------------------------------------

category:addChild(L["Thalnos the Soulrender"], {
	-- Empowered Spiritualist
	6946
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- on level 1
	-- and in box
	return 874 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.Box:containsPlayer(14, 43, 27, 59);

end;

-----------------------------------------
-- Scarlet Monastery / Brother Korloff --
-----------------------------------------

category:addChild(L["Brother Korloff"], {
	-- Burning Man
	6928
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- on level 2
	-- and in box
	return 874 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 2 and
			AchieveIt.Box:containsPlayer(36, 61, 21, 57);

end;

---------------------------------------------------
-- Scarlet Monastery / High Inquisitor Whitemane --
---------------------------------------------------

category:addChild(L["High Inquisitor Whitemane"], {
	-- And Stay Dead!
	6929
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- on level 2
	-- and in box
	return 874 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 2 and
			AchieveIt.Box:containsPlayer(36, 64, 62, 88);

end;

category:inheritAchievements();


--------------------------
-- Scholomance Category --
--------------------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(898), {
	-- Heroic: Scholomance
	6762,
	-- Sanguinarian
	6396
});

category.locate = function()

	-- in dungeon
	-- and heroic version
	return 898 == GetCurrentMapAreaID()
			and AchieveIt.difficulty.isHeroicDungeon();

end;

---------------------------------
-- Scholomance / Jandice Barov --
---------------------------------

category:addChild(L["Jandice Barov"], {
	-- Attention to Detail
	6531
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- on level 2
	-- and in box
	return 898 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 2 and
			AchieveIt.Box:containsPlayer(57.5, 71, 7, 28);

end;

------------------------------
-- Scholomance / Rattlegore --
------------------------------

category:addChild(L["Rattlegore"], {
	-- Rattle No More
	6394
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- on level 2
	-- and in box
	return 898 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 2 and
			AchieveIt.Box:containsPlayer(40, 56, 18, 34);

end;

---------------------------------------
-- Scholomance / Darkmaster Gandling --
---------------------------------------

category:addChild(L["Darkmaster Gandling"], {
	-- School's Out Forever
	6821
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- on level 4
	return 898 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 4;

end;

category:inheritAchievements();