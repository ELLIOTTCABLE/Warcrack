
----------------------
-- General Category --
----------------------

local AchieveIt = AchieveIt;

-- Locale
local L = LibStub("AceLocale-3.0"):GetLocale("AchieveIt");

-- The achievement category ID
local categoryId = 92;

-------------------------
-- General / Levelling --
-------------------------

AchieveIt.Categories:addCategory(categoryId, L["Levelling"], {
    -- Level 10
    6,
    -- Level 20
    7,
    -- Level 30
    8,
    -- Level 40
    9,
    -- Level 50
    10,
    -- Level 60
    11,
    -- Level 70
    12,
    -- Level 80
    13,
    -- Level 85
    4826,
    -- Level 90
    6193,
    -- Level 100
    9060
}, 1);

---------------------
-- General / Equip --
---------------------

AchieveIt.Categories:addCategory(categoryId, L["Equip"], {
    -- Superior
    557,
    -- Epic
    556,
    -- Cataclysmically Superior
    5373,
    -- Cataclysmically Epic
    5372,
    -- Mystically Superior
    6348,
    -- Mystically Epic
    6349,
    -- Savagely Superior
    9707,
    -- Savagely Epic
    9708
}, 1);

-----------------------
-- General / Consume --
-----------------------

AchieveIt.Categories:addCategory(categoryId, L["Consume"], {
    -- Tastes Like Chicken
    1832,
    -- It's Happy Hour Somewhere
    1833,
    -- Cataclysmically Delicious
    5753,
    -- Drown Your Sorrows
    5754,
    -- Pandaren Cuisine
    7329,
    -- Pandaren Delicacies
    7330,
    -- Draenor Cuisine
    9502,
    -- You'll Feel Right as Rain
    5779
}, 1);

---------------------
-- General / Money --
---------------------

AchieveIt.Categories:addCategory(categoryId, L["Money"], {
    -- Got My Mind On My Money
    1176,
    -- Got My Mind On My Money
    1177,
    -- Got My Mind On My Money
    1178,
    -- Got My Mind On My Money
    1180,
    -- Got My Mind On My Money
    1181,
    -- Got My Mind On My Money
    5455,
    -- Got My Mind On My Money
    5456,
    -- Got My Mind On My Money
    6753,
    -- Got My Mind On My Draenor Money
    9487
}, 1);

----------------------
-- General / Riding --
----------------------

AchieveIt.Categories:addCategory(categoryId, L["Riding"], {
    -- Giddy Up!
    891,
    -- Fast and Furious
    889,
    -- Into The Wild Blue Yonder
    890,
    -- The Right Stuff
    892,
    -- Breaking The Sound Barrier
    5180
}, 1);

------------------------
-- General / Critters --
------------------------

AchieveIt.Categories:addCategory(categoryId, L["Critters"], {
    -- To All The Squirrels I've Loved Before
    1206,
    -- To All The Squirrels Who Shared My Life
    2557,
    -- To All the Squirrels Who Cared for Me
    5548,
    -- To All the Squirrels I Once Caressed?
    6350,
    -- Friend or Fowl?
    1254,
    -- Pest Control
    2556
}, 1);

--------------------------
-- General / Characters --
--------------------------

AchieveIt.Categories:addCategory(categoryId, L["Characters"], {
    -- Dual Talent Specialization
    2716,
    -- Dynamic Duo
    7382,
    -- Terrific Trio
    7383,
    -- Quintessential Quintet
    7384,
    -- Double Agent
    7380
}, 1);

-----------------------
-- General / Reading --
-----------------------

AchieveIt.Categories:addCategory(categoryId, L["Reading"], {
    -- Well Read
    1244,
    -- Higher Learning
    1956
}, 1);

---------------------
-- General / Other --
---------------------

AchieveIt.Categories:addCategory(categoryId, L["Other"], {
    -- Shave and a Haircut
    545,
    -- Going Down?
    964,
    -- Greedy
    558,
    -- Needy
    559,
    -- Safe Deposit
    546,
    -- Everything Is Awesome!
    9547
}, 1);