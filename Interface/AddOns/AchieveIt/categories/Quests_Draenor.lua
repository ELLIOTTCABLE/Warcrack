
----------------------
-- Quests / Draenor --
----------------------

local AchieveIt = AchieveIt;

-- Locale
local L = LibStub("AceLocale-3.0"):GetLocale("AchieveIt");

-- The achievement category ID
local categoryId = 15220;

--------------------
-- Zones Category --
--------------------

AchieveIt.Categories:addCategory(categoryId, L["Progress"], {

    -- Welcome to Draenor
    {
        id = 8921,
        faction = AchieveIt.Factions.ALLIANCE
    },
    -- Welcome to Draenor
    {
        id = 8922,
        faction = AchieveIt.Factions.HORDE
    },
    -- You'll Get Caught Up In The... Frostfire!
    {
        id = 8671,
        faction = AchieveIt.Factions.HORDE
    },
    -- Frostfire Fridge
    {
        id = 9606,
        faction = AchieveIt.Factions.HORDE
    },
    -- As I Walk Through the Valley of the Shadow of Moon
    {
        id = 8845,
        faction = AchieveIt.Factions.ALLIANCE
    },
    -- Shoot For the Moon
    {
        id = 9602,
        faction = AchieveIt.Factions.ALLIANCE
    },
    -- Putting the Gore in Gorgrond
    {
        id = 8923,
        faction = AchieveIt.Factions.ALLIANCE
    },
    -- Putting the Gore in Gorgrond
    {
        id = 8924,
        faction = AchieveIt.Factions.HORDE
    },
    -- Make It a Bonus
    9607,
    -- Don't Let the Tala-door Hit You on the Way Out
    {
        id = 8920,
        faction = AchieveIt.Factions.ALLIANCE
    },
    -- Don't Let the Tala-door Hit You on the Way Out
    {
        id = 8919,
        faction = AchieveIt.Factions.HORDE
    },
    -- I Want More Talador
    9674,
    -- Between Arak and a Hard Place
    {
        id = 8925,
        faction = AchieveIt.Factions.ALLIANCE
    },
    -- Between Arak and a Hard Place
    {
        id = 8926,
        faction = AchieveIt.Factions.HORDE
    },
    -- Arak Star
    9605,
    -- Nagrandeur
    {
        id = 8927,
        faction = AchieveIt.Factions.ALLIANCE
    },
    -- Nagrandeur
    {
        id = 8928,
        faction = AchieveIt.Factions.HORDE
    },
    -- With a Nagrand Cherry On Top
    9615,
    -- The Garrison Campaign
    {
        id = 9491,
        faction = AchieveIt.Factions.ALLIANCE
    },
    -- The Garrison Campaign
    {
        id = 9492,
        faction = AchieveIt.Factions.HORDE
    },
    -- Chapter I: Call of the Archmage
    9640,
    -- Chapter II: Gul'dan Strikes Back
    9641,
    -- Chapter III: The Foundry Falls
    9642,
    -- Securing Draenor
    {
        id = 9564,
        faction = AchieveIt.Factions.ALLIANCE
    },
    -- Securing Draenor
    {
        id = 9562,
        faction = AchieveIt.Factions.HORDE
    },
    -- On the Shadow's Trail
    {
        id = 9528,
        faction = AchieveIt.Factions.ALLIANCE
    },
    -- On the Shadow's Trail
    {
        id = 9529,
        faction = AchieveIt.Factions.HORDE
    }
});


------------------------------
-- Frostfire Ridge Category --
------------------------------

AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(941), {
    -- You'll Get Caught Up In The... Frostfire!
    {
        id = 8671,
        faction = AchieveIt.Factions.HORDE
    },
    -- Frostfire Fridge
    {
        id = 9606,
        faction = AchieveIt.Factions.HORDE
    },
    -- On the Shadow's Trail
    {
        id = 9529,
        faction = AchieveIt.Factions.HORDE
    },
    -- Breaker of Chains
    9533,
    -- Writing in the Snow
    {
        id = 9530,
        faction = AchieveIt.Factions.ALLIANCE
    },
    -- Writing in the Snow
    {
        id = 9531,
        faction = AchieveIt.Factions.HORDE
    },
    -- Delectable Ogre Delicacies
    9534,
    -- By Fire Be... Merged?
    9537,
    -- Slagnarok
    9536,
    -- That Was Entirely Unnecessary
    9535,
    -- Planned to Fail
    9711,
    -- Poisoning the Well
    9710
}).locate = function()

    -- in zone
    return 941 == GetCurrentMapAreaID();

end;


--------------------------------
-- Shadowmoon Valley Category --
--------------------------------

AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(947), {
    -- As I Walk Through the Valley of the Shadow of Moon
    {
        id = 8845,
        faction = AchieveIt.Factions.ALLIANCE
    },
    -- Shoot For the Moon
    {
        id = 9602,
        faction = AchieveIt.Factions.ALLIANCE
    },
    -- On the Shadow's Trail
    {
        id = 9528,
        faction = AchieveIt.Factions.ALLIANCE
    },
    -- A-VOID-ance
    9433,
    -- One of Us! One of Us!
    9434,
    -- Would You Like a Pamphlet?
    9432,
    -- It's the Stones!
    9436,
    -- Take From Them Everything
    9435,
    -- A Demidos of Reality
    9437,
    -- I Was Framed!
    9483,
    -- You Can't Make a Giant Omelette...
    9479,
    -- You Have Been Rylakinated!
    9481
}).locate = function()

-- in zone
    return 947 == GetCurrentMapAreaID();

end;


-----------------------------
-- Spires of Arak Category --
-----------------------------

AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(948), {
    -- Between Arak and a Hard Place
    {
        id = 8925,
        faction = AchieveIt.Factions.ALLIANCE
    },
    -- Between Arak and a Hard Place
    {
        id = 8926,
        faction = AchieveIt.Factions.HORDE
    },
    -- Arak Star
    9605,
    -- Eggs in One Basket
    9612,
    -- Fish Gotta Swim, Birds Gotta Eat
    9613
}).locate = function()

-- in zone
    return 948 == GetCurrentMapAreaID();

end;


-----------------------
-- Gorgrond Category --
-----------------------

AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(949), {
    -- Putting the Gore in Gorgrond
    {
        id = 8923,
        faction = AchieveIt.Factions.ALLIANCE
    },
    -- Putting the Gore in Gorgrond
    {
        id = 8924,
        faction = AchieveIt.Factions.HORDE
    },
    -- Make It a Bonus
    9607,
    -- Fight the Power
    9655,
    -- In Plain Sight
    9656,
    -- Iron Wings
    9659,
    -- Ancient No More
    9678,
    -- Burn it to the Ground
    9667,
    -- Mean and Green
    9654,
    -- Pillars of Draenor
    9658,
    -- Picky Palate
    9663
}).locate = function()

-- in zone
    return 949 == GetCurrentMapAreaID();

end;


----------------------
-- Talador Category --
----------------------

AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(946), {
    -- Don't Let the Tala-door Hit You on the Way Out
    {
        id = 8920,
        faction = AchieveIt.Factions.ALLIANCE
    },
    -- Don't Let the Tala-door Hit You on the Way Out
    {
        id = 8919,
        faction = AchieveIt.Factions.HORDE
    },
    -- I Want More Talador
    9674
}).locate = function()

-- in zone
    return 946 == GetCurrentMapAreaID();

end;


----------------------
-- Nagrand Category --
----------------------

AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(950), {
    -- Nagrandeur
    {
        id = 8927,
        faction = AchieveIt.Factions.ALLIANCE
    },
    -- Nagrandeur
    {
        id = 8928,
        faction = AchieveIt.Factions.HORDE
    },
    -- With a Nagrand Cherry On Top
    9615,
    -- History of Violence
    9610,
    -- Broke Back Precipice
    9571,
    -- Buried Treasures
    9548,
    -- The Song of Silence
    9541,
    -- Making the Cut
    9617
}).locate = function()

-- in zone
    return 950 == GetCurrentMapAreaID();

end;


-----------------------------
-- Shattrath City Category --
-----------------------------

AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(986), {
    -- Cut off the Head
    9633,
    -- Heralds of the Legion
    9638,
    -- Bobbing for Orcs
    9635,
    -- Charged Up
    9634,
    -- United We Stand
    9636,
    -- The Power Is Yours
    9632,
    -- Poor Communication
    9637,
    -- Goodness Gracious
    9486
}).locate = function()

-- in zone
    return 986 == GetCurrentMapAreaID();

end;


----------------------
-- Khadgar Category --
----------------------

AchieveIt.Categories:addCategory(categoryId, L["Khadgar"], {
    -- Chapter I: Call of the Archmage
    9640,
    -- Chapter II: Gul'dan Strikes Back
    9641,
    -- Chapter III: The Foundry Falls
    9642,
});