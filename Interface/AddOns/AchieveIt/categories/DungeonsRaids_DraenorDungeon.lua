----------------------------------------
-- Dungeons & Raids - Draenor Dungeon --
----------------------------------------

local AchieveIt = AchieveIt;

-- Locale
local L = LibStub("AceLocale-3.0"):GetLocale("AchieveIt");

-- The achievement category ID
local categoryId = 15228;

-----------------------
-- Dungeons Category --
-----------------------

AchieveIt.Categories:addCategory(categoryId, _G["DUNGEONS"], {
    -- Bloodmaul Slag Mines
    9037,
    -- Iron Docks
    9038,
    -- Auchindoun
    9039,
    -- Skyreach
    8843,
    -- Upper Blackrock Spire
    9042,
    -- The Everbloom
    9044,
    -- Grimrail Depot
    9043,
    -- Shadowmoon Burial Grounds
    9041
}).locate = function()

	-- dungeon map ids
	local ids = {
        984, -- Auchindoun
        964, -- Bloodmaul Slag Mines
        993, -- Grimrail Depot
        987, -- Iron Docks
        969, -- Shadowmoon Burial Grounds
        989, -- Skyreach
        1008, -- The Everbloom
        995 -- Upper Blackrock Spire
	};

	return AchieveIt:Contains(ids, GetCurrentMapAreaID()) -- user is in one of these dungeons
			and AchieveIt.difficulty.isDungeon(); -- and it is a normal version

end;

------------------------------
-- Heroic Dungeons Category --
------------------------------

AchieveIt.Categories:addCategory(categoryId, L["Heroic Dungeons"], {
    -- Heroic: Bloodmaul Slag Mines
    9046,
    -- Heroic: Iron Docks
    9047,
    -- Heroic: Auchindoun
    9049,
    -- Heroic: Skyreach
    8844,
    -- Heroic: Upper Blackrock Spire
    9055,
    -- Heroic: The Everbloom
    9053,
    -- Heroic: Grimrail Depot
    9052,
    -- Heroic: Shadowmoon Burial Grounds
    9054
});

-----------------------------------
-- Bloodmaul Slag Mines Category --
-----------------------------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(964), {
    -- Bloodmaul Slag Mines
    9037,
    -- Heroic: Bloodmaul Slag Mines
    9046
});

category.locate = function()

	-- in dungeon
	return 964 == GetCurrentMapAreaID();

end;

-------------------------------------
-- Bloodmaul Slag Mines / Gug'rokk --
-------------------------------------

category:addChild(L["Gug'rokk"], {
    -- Is Draenor on Fire?
    9008,
    -- Come With Me If You Want to Live
    9005
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- in box
	return 964 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
            AchieveIt.Box:containsPlayer(55, 71, 15, 31);

end;

---------------------------------------
-- Bloodmaul Slag Mines / Magmolatus --
---------------------------------------

category:addChild(L["Magmolatus"], {
    -- A Gift of Earth and Fire
    8993
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- and in box
	return 964 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			AchieveIt.Box:containsPlayer(20, 42, 44, 66);

end;

category:inheritAchievements();


-------------------------
-- Iron Docks Category --
-------------------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(987), {
    -- Iron Docks
    9038,
    -- Heroic: Iron Docks
    9047,
    -- Expert Timing
    9081
});

category.locate = function()

	-- in dungeon
	return 987 == GetCurrentMapAreaID();

end;

--------------------------------------
-- Iron Docks / Fleshrender Nok'gar --
--------------------------------------

category:addChild(L["Fleshrender Nok'gar"], {
    -- Militaristic, Expansionist
    9083
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- and in box
	return 987 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			AchieveIt.Box:containsPlayer(39, 51, 25, 43);

end;

--------------------------
-- Iron Docks / Skulloc --
--------------------------

category:addChild(L["Skulloc"], {
    -- Take Cover!
    9082
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- and in box
	return 867 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			AchieveIt.Box:containsPlayer(61, 73, 24, 53);

end;

category:inheritAchievements();


-------------------------
-- Auchindoun Category --
-------------------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(984), {
    -- Auchindoun
    9039,
    -- Heroic: Auchindoun
    9049
});

category.locate = function()

	-- in dungeon
	return 984 == GetCurrentMapAreaID();

end;

-----------------------------------
-- Auchindoun / Soulbinder Nyami --
-----------------------------------

category:addChild(L["Soulbinder Nyami"], {
    -- ...They All Fall Down
    9023
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- and in box
	return 984 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			AchieveIt.Box:containsPlayer(40, 61, 58, 76);

end;

---------------------------
-- Auchindoun / Azzakel  --
---------------------------

category:addChild(L["Azzakel"], {
    -- Demon's Souls
    9551
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- and in box
	return 984 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			AchieveIt.Box:containsPlayer(63, 79, 23, 46);

end;

----------------------------
-- Auchindoun / Teron'gor --
----------------------------

category:addChild(L["Teron'gor"], {
    -- No Tag-backs!
    9552
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- and in box
	return 984 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			AchieveIt.Box:containsPlayer(39, 60, 16, 48);

end;

category:inheritAchievements();


-----------------------
-- Skyreach Category --
-----------------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(989), {
    -- Skyreach
    8843,
    -- Heroic: Skyreach
    8844,
    -- Magnify... Enhance
    9034
});

category.locate = function()

	-- in dungeon
	return 989 == GetCurrentMapAreaID();

end;

-----------------------
-- Skyreach / Ranjit --
-----------------------

category:addChild(L["Ranjit"], {
    -- Ready for Raiding IV
    9033
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- on level 1
	-- and in box
	return 989 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.Box:containsPlayer(56, 70, 28, 48);

end;

------------------------
-- Skyreach / Rukhran --
------------------------

category:addChild(L["Rukhran"], {
    -- I Saw Solis
    9035
}).locate = function()

	-- in dungeon
	-- is heroic mode
    -- on level 1
    -- and in box
	return 989 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
            GetCurrentMapDungeonLevel() == 1 and
            AchieveIt.Box:containsPlayer(35, 48, 73, 90);

end;

--------------------------------
-- Skyreach / High Sage Viryx --
--------------------------------

category:addChild(L["High Sage Viryx"], {
    -- Monomania
    9036
}).locate = function()

	-- in dungeonc
	-- is heroic mode
	-- on level 2
	return 989 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 2;

end;

category:inheritAchievements();


------------------------------------
-- Upper Blackrock Spire Category --
------------------------------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(995), {
    -- Upper Blackrock Spire
    9042,
    -- Heroic: Upper Blackrock Spire
    9055,
    -- Leeeeeeeeeeeeeroy...?
    9058
});

category.locate = function()

	-- in dungeon
	return 995 == GetCurrentMapAreaID();

end;

--------------------------------------------------
-- Upper Blackrock Spire / Orebender Gor'ashan  --
--------------------------------------------------

category:addChild(L["Orebender Gor'ashan"], {
    -- Magnets, How Do They Work?
    9045
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- on level 2
	-- and in box
	return 995 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 2 and
			AchieveIt.Box:containsPlayer(26, 34, 21, 32);

end;

--------------------------------------------------
-- Upper Blackrock Spire / Ragewing the Untamed --
--------------------------------------------------

category:addChild(L["Ragewing the Untamed"], {
    -- Bridge Over Troubled Fire
    9056
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- on level 3
	-- and in box
	return 995 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 3 and
			AchieveIt.Box:containsPlayer(40, 52, 40, 52);

end;

-------------------------------------------
-- Upper Blackrock Spire / Warlord Zaela --
-------------------------------------------

category:addChild(L["Warlord Zaela"], {
    -- Dragonmaw? More Like Dragonfall!
    9057
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- on level 3
	-- and in box
	return 875 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 3 and
			AchieveIt.Box:containsPlayer(6, 24, 37, 62);

end;

category:inheritAchievements();


----------------------------
-- The Everbloom Category --
----------------------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(1008), {
    -- The Everbloom
    9044,
    -- Heroic: The Everbloom
    9053
});

category.locate = function()

	-- in dungeon
	return 1008 == GetCurrentMapAreaID();

end;

----------------------------------
-- The Everbloom / Archmage Sol --
----------------------------------

category:addChild(L["Archmage Sol"], {
    -- They Burn, Burn, Burn
    9493
}).locate = function()

-- in dungeon
-- is heroic mode
-- on level 1
-- and in box
    return 1008 == GetCurrentMapAreaID() and
            AchieveIt.difficulty.isHeroicDungeon() and
            GetCurrentMapDungeonLevel() == 1 and
            AchieveIt.Box:containsPlayer(47, 63, 27, 41);

end;

---------------------------
-- The Everbloom / Yalnu --
---------------------------

category:addChild(L["Yalnu"], {
    -- Weed Whacker
    9223
}).locate = function()

    -- in dungeon
    -- is heroic mode
    -- on level 2
    return 1008 == GetCurrentMapAreaID() and
            AchieveIt.difficulty.isHeroicDungeon() and
            GetCurrentMapDungeonLevel() == 2;

end;

--------------------------------
-- The Everbloom / Witherbark --
--------------------------------

category:addChild(L["Witherbark"], {
    -- Water Management
    9017
}).locate = function()

    -- in dungeon
    -- is heroic mode
    -- on level 1
    -- and in box
    return 1008 == GetCurrentMapAreaID() and
            AchieveIt.difficulty.isHeroicDungeon() and
            GetCurrentMapDungeonLevel() == 1 and
            AchieveIt.Box:containsPlayer(44, 62, 48, 70);

end;

category:inheritAchievements();


-----------------------------
-- Grimrail Depot Category --
-----------------------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(993), {
    -- Grimrail Depot
    9043,
    -- Heroic: Grimrail Depot
    9052
});

category.locate = function()

	-- in dungeon
	return 993 == GetCurrentMapAreaID();

end;

----------------------------------------------
-- Grimrail Depot / Railmaster Rocketspark  --
----------------------------------------------

category:addChild(L["Railmaster Rocketspark"], {
    -- This Is Why We Can't Have Nice Things
    9024
}).locate = function()

	-- in dungeon
	-- is heroic mode
	-- on level 1
	-- and in box
	return 993 == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.Box:containsPlayer(54, 83, 27, 73);

end;

---------------------------------------------
-- Grimrail Depot / Nitrogg Thundertower   --
---------------------------------------------

category:addChild(L["Nitrogg Thundertower"], {
    -- No Ticket
    9007
}).locate = function()

    -- in dungeon
    -- is heroic mode
    -- on level 4
    -- and in box
    return 993 == GetCurrentMapAreaID() and
            AchieveIt.difficulty.isHeroicDungeon() and
            GetCurrentMapDungeonLevel() == 4 and
            AchieveIt.Box:containsPlayer(54, 94, 28, 73);

end;

category:inheritAchievements();


----------------------------------------
-- Shadowmoon Burial Grounds Category --
----------------------------------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(969), {
    -- Shadowmoon Burial Grounds
    9041,
    -- Heroic: Shadowmoon Burial Grounds
    9054
});

category.locate = function()

	-- in dungeon
	return 969 == GetCurrentMapAreaID();

end;

--------------------------------------------------
-- Shadowmoon Burial Grounds / Sadana Bloodfury --
--------------------------------------------------

category:addChild(L["Sadana Bloodfury"], {
    -- What's Your Sign?
    9018
}).locate = function()

    -- in dungeon
    -- is heroic mode
    -- on level 1
    -- and in box
    return 969 == GetCurrentMapAreaID() and
            AchieveIt.difficulty.isHeroicDungeon() and
            GetCurrentMapDungeonLevel() == 1 and
            AchieveIt.Box:containsPlayer(43, 61, 37, 66);

end;

-----------------------------------------
-- Shadowmoon Burial Grounds / Bonemaw --
-----------------------------------------

category:addChild(L["Bonemaw"], {
    -- Icky Ichors
    9025
}).locate = function()

    -- in dungeon
    -- is heroic mode
    -- on level 2
    -- and in box
    return 969 == GetCurrentMapAreaID() and
            AchieveIt.difficulty.isHeroicDungeon() and
            GetCurrentMapDungeonLevel() == 2 and
            AchieveIt.Box:containsPlayer(24, 47, 34, 69);

end;

-------------------------------------------
-- Shadowmoon Burial Grounds / Ner'zhul  --
-------------------------------------------

category:addChild(L["Ner'zhul"], {
    -- Souls of the Lost
    9026
}).locate = function()

    -- in dungeon
    -- is heroic mode
    -- on level 3
    return 969 == GetCurrentMapAreaID() and
            AchieveIt.difficulty.isHeroicDungeon() and
            GetCurrentMapDungeonLevel() == 3;

end;

category:inheritAchievements();
