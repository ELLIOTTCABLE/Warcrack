-------------------------------------
-- Dungeons & Raids - Draenor Raid --
-------------------------------------

local AchieveIt = AchieveIt;

-- Locale
local L = LibStub("AceLocale-3.0"):GetLocale("AchieveIt");

-- The achievement category ID
local categoryId = 15231;

---------------------------
-- World Bosses Category --
---------------------------

local category = AchieveIt.Categories:addCategory(categoryId, L["World Bosses"], {
    -- Goliaths of Gorgrond
    9423,
    -- So Grossly Incandescent
    9425
});

-----------------------
-- Highmaul Category --
-----------------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(994));

category.locate = function()

    -- in raid
    return 994 == GetCurrentMapAreaID();

end;

-----------------------
-- Highmaul / Bosses --
-----------------------

category:addChild(L["Progress"], {
    -- The Walled City
    8986,
    -- Arcane Sanctum
    8987,
    -- Imperator's Fall
    8988,
    -- Mythic: Kargath Bladefist
    8949,
    -- Mythic: The Butcher
    8960,
    -- Mythic: Tectus
    8961,
    -- Mythic: Brackenspore
    8962,
    -- Mythic: Twin Ogron
    8963,
    -- Mythic: Ko'ragh
    8964,
    -- Mythic: Imperator's Fall
    8965
});

----------------------------------
-- Highmaul / Kargath Bladefist --
----------------------------------

category:addChild(L["Kargath Bladefist"], {
    -- Mythic: Kargath Bladefist
    8949,
    -- Flame On!
    8948
}).locate = function()

    -- in raid
    -- not raid finder
    -- on level 3
    return 994 == GetCurrentMapAreaID() and
            not AchieveIt.difficulty.isRaidFinder() and
            GetCurrentMapDungeonLevel() == 3;

end;

----------------------------
-- Highmaul / The Butcher --
----------------------------

category:addChild(L["The Butcher"], {
    -- Mythic: The Butcher
    8960,
    -- Hurry Up, Maggot!
    8947
}).locate = function()

    -- in raid
    -- not raid finder
    -- on level 1
    -- and in box
    return 994 == GetCurrentMapAreaID() and
            not AchieveIt.difficulty.isRaidFinder() and
            GetCurrentMapDungeonLevel() == 1 and
            AchieveIt.Box:containsPlayer(49, 63, 42, 64);

end;

-----------------------
-- Highmaul / Tectus --
-----------------------

category:addChild(L["Tectus"], {
    -- Mythic: Tectus
    8961,
    -- More Like Wrecked-us
    8974
}).locate = function()

    -- in raid
    -- not raid finder
    -- on level 1
    -- and in box
    return 994 == GetCurrentMapAreaID() and
            not AchieveIt.difficulty.isRaidFinder() and
            GetCurrentMapDungeonLevel() == 1 and
            AchieveIt.Box:containsPlayer(26, 43, 64, 85);

end;

-----------------------------
-- Highmaul / Brackenspore --
-----------------------------

category:addChild(L["Brackenspore"], {
    -- Mythic: Brackenspore
    8962,
    -- A Fungus Among Us
    8975
}).locate = function()

    -- in raid
    -- not raid finder
    -- on level 1
    -- and in box
    return 994 == GetCurrentMapAreaID() and
            not AchieveIt.difficulty.isRaidFinder() and
            GetCurrentMapDungeonLevel() == 1 and
            AchieveIt.Box:containsPlayer(39, 57, 4, 39);

end;

---------------------------
-- Highmaul / Twin Ogron --
---------------------------

category:addChild(L["Twin Ogron"], {
    -- Mythic: Twin Ogron
    8963,
    -- Brothers in Arms
    8958
}).locate = function()

    -- in raid
    -- not raid finder
    -- on level 4
    -- and in box
    return 994 == GetCurrentMapAreaID() and
            not AchieveIt.difficulty.isRaidFinder() and
            GetCurrentMapDungeonLevel() == 4 and
            AchieveIt.Box:containsPlayer(41, 72, 10, 52);

end;

------------------------
-- Highmaul / Ko'ragh --
------------------------

category:addChild(L["Ko'ragh"], {
    -- Mythic: Ko'ragh
    8964,
    -- Pair Annihilation
    8976
}).locate = function()

    -- in raid
    -- not raid finder
    -- on level 4
    -- and in box
    return 994 == GetCurrentMapAreaID() and
            not AchieveIt.difficulty.isRaidFinder() and
            GetCurrentMapDungeonLevel() == 4 and
            AchieveIt.Box:containsPlayer(23, 49, 49, 87);

end;

----------------------------------
-- Highmaul / Imperator Mar'gok --
----------------------------------

category:addChild(L["Imperator Mar'gok"], {
    -- Imperator's Fall
    8988,
    -- Mythic: Imperator's Fall
    8965,
    -- Lineage of Power
    8977
}).locate = function()

    -- in raid
    -- not raid finder
    -- on level 6
    return 994 == GetCurrentMapAreaID() and
            not AchieveIt.difficulty.isRaidFinder() and
            GetCurrentMapDungeonLevel() == 6;

end;


category:inheritAchievements();


--------------------------------
-- Blackrock Foundry Category --
--------------------------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(988));

category.locate = function()

    -- in raid
    return 988 == GetCurrentMapAreaID();

end;

--------------------------------
-- Blackrock Foundry / Bosses --
--------------------------------

category:addChild(L["Progress"], {
    -- Slagworks
    8989,
    -- Black Forge
    8990,
    -- Iron Assembly
    8991,
    -- Blackhand's Crucible
    8992,
    -- Mythic: Gruul
    8966,
    -- Mythic: Oregorger
    8967,
    -- Mythic: Hans'gar and Franzok
    8968,
    -- Mythic: Beastlord Darmac
    8956,
    -- Mythic: Flamebender Ka'graz
    8932,
    -- Mythic: Operator Thogar
    8969,
    -- Mythic: Blast Furnace
    8970,
    -- Mythic: Kromog
    8971,
    -- Mythic: Iron Maidens
    8972,
    -- Mythic: Blackhand's Crucible
    8973
});

-------------------------------
-- Blackrock Foundry / Gruul --
-------------------------------

category:addChild(L["Gruul"], {
    -- Mythic: Gruul
    8966,
    -- The Iron Price
    8978
}).locate = function()

    -- in raid
    -- not raid finder
    -- on level 2
    -- and in box
    return 988 == GetCurrentMapAreaID() and
            not AchieveIt.difficulty.isRaidFinder() and
            GetCurrentMapDungeonLevel() == 2 and
            AchieveIt.Box:containsPlayer(29, 48, 9, 32);

end;

-----------------------------------
-- Blackrock Foundry / Oregorger --
-----------------------------------

category:addChild(L["Oregorger"], {
    -- Mythic: Oregorger
    8967,
    -- He Shoots, He Ores
    8979
}).locate = function()

-- in raid
-- not raid finder
-- on level 2
-- and in box
    return 988 == GetCurrentMapAreaID() and
            not AchieveIt.difficulty.isRaidFinder() and
            GetCurrentMapDungeonLevel() == 2 and
            AchieveIt.Box:containsPlayer(28, 48, 71, 97);

end;

----------------------------------------------
-- Blackrock Foundry / Hans'gar and Franzok --
----------------------------------------------

category:addChild(L["Hans'gar and Franzok"], {
    -- Mythic: Hans'gar and Franzok
    8968,
    -- Stamp Stamp Revolution
    8980
}).locate = function()

    -- in raid
    -- not raid finder
    -- on level 2
    -- and in box
    return 988 == GetCurrentMapAreaID() and
            not AchieveIt.difficulty.isRaidFinder() and
            GetCurrentMapDungeonLevel() == 1 and
            AchieveIt.Box:containsPlayer(42, 53, 65, 89);

end;

------------------------------------------
-- Blackrock Foundry / Beastlord Darmac --
------------------------------------------

category:addChild(L["Beastlord Darmac"], {
    -- Mythic: Beastlord Darmac
    8956,
    -- Fain Would Lie Down
    8981
}).locate = function()

    -- in raid
    -- not raid finder
    -- on level 4
    -- and in box
    return 988 == GetCurrentMapAreaID() and
            not AchieveIt.difficulty.isRaidFinder() and
            GetCurrentMapDungeonLevel() == 4 and
            AchieveIt.Box:containsPlayer(51, 78, 58, 94);

end;

---------------------------------------------
-- Blackrock Foundry / Flamebender Ka'graz --
---------------------------------------------

category:addChild(L["Flamebender Ka'graz"], {
    -- Mythic: Flamebender Ka'graz
    8932,
    -- The Steel Has Been Brought
    8929
}).locate = function()

-- in raid
-- not raid finder
-- on level 1
-- and in box
    return 988 == GetCurrentMapAreaID() and
            not AchieveIt.difficulty.isRaidFinder() and
            GetCurrentMapDungeonLevel() == 1 and
            AchieveIt.Box:containsPlayer(14, 25, 65, 89);

end;

-----------------------------------------
-- Blackrock Foundry / Operator Thogar --
-----------------------------------------

category:addChild(L["Operator Thogar"], {
    -- Mythic: Operator Thogar
    8969,
    -- There's Always a Bigger Train
    8982
}).locate = function()

    -- in raid
    -- not raid finder
    -- on level 4
    -- and in box
    return 988 == GetCurrentMapAreaID() and
            not AchieveIt.difficulty.isRaidFinder() and
            GetCurrentMapDungeonLevel() == 4 and
            AchieveIt.Box:containsPlayer(35, 55, 13, 42);

end;

---------------------------------------
-- Blackrock Foundry / Blast Furnace --
---------------------------------------

category:addChild(L["Blast Furnace"], {
    -- Mythic: Blast Furnace
    8970,
    -- Ya, We've Got Time...
    8930
}).locate = function()

    -- in raid
    -- not raid finder
    -- on level 2
    -- and in box
    return 988 == GetCurrentMapAreaID() and
            not AchieveIt.difficulty.isRaidFinder() and
            GetCurrentMapDungeonLevel() == 2 and
            AchieveIt.Box:containsPlayer(30, 53, 36, 68);

end;

--------------------------------
-- Blackrock Foundry / Kromog --
--------------------------------

category:addChild(L["Kromog"], {
    -- Mythic: Kromog
    8971,
    -- Would You Give Me a Hand?
    8983
}).locate = function()

    -- in raid
    -- not raid finder
    -- on level 1
    -- and in box
    return 988 == GetCurrentMapAreaID() and
            not AchieveIt.difficulty.isRaidFinder() and
            GetCurrentMapDungeonLevel() == 1 and
            AchieveIt.Box:containsPlayer(20, 41, 32, 55);

end;

--------------------------------------
-- Blackrock Foundry / Iron Maidens --
--------------------------------------

category:addChild(L["Iron Maidens"], {
    -- Mythic: Iron Maidens
    8972,
    -- Be Quick or Be Dead
    8984
}).locate = function()

    -- in raid
    -- not raid finder
    -- on level 1
    -- and in box
    return 988 == GetCurrentMapAreaID() and
            not AchieveIt.difficulty.isRaidFinder() and
            GetCurrentMapDungeonLevel() == 1 and
            AchieveIt.Box:containsPlayer(64, 93, 10, 56);

end;

-----------------------------------
-- Blackrock Foundry / Blackhand --
-----------------------------------

category:addChild(L["Blackhand"], {
    -- Blackhand's Crucible
    8992,
    -- Mythic: Blackhand's Crucible
    8973,
    -- Ashes, Ashes...
    8952
}).locate = function()

    -- in raid
    -- not raid finder
    -- on level 5
    return 988 == GetCurrentMapAreaID() and
            not AchieveIt.difficulty.isRaidFinder() and
            GetCurrentMapDungeonLevel() == 5;

end;


category:inheritAchievements();
