
------------------------
-- Professions / Archaeology --
------------------------

local AchieveIt = AchieveIt;

-- Locale
local L = LibStub("AceLocale-3.0"):GetLocale("AchieveIt");

-- The achievement category ID
local categoryId = 15071;

-----------------------
-- Progress Category --
-----------------------

AchieveIt.Categories:addCategory(categoryId, L["Progress"], {
	-- Digger
	5315,
	-- Diggerer
	5469,
	-- Diggerest
	5470,
	-- Journeyman Archaeologist
	4857,
	-- Expert Archaeologist
	4919,
	-- Artisan Archaeologist
	4920,
	-- Master Archaeologist
	4921,
	-- Grand Master Archaeologist
	4922,
	-- Illustrious Grand Master Archaeologist
	4923,
	-- Zen Master Archaeologist
	6837,
    -- Draenor Archaeologist
    9409,
	-- I Had It in My Hand
	4854,
	-- What was Briefly Yours is Now Mine
	4855,
	-- It Belongs in a Museum!
	4856,
	-- It's Always in the Last Place You Look
	5511,	
	-- Seven Scepters
	4858,
	-- The Seat of Knowledge
	7612,
    -- Draenor Curator
    9419
});

----------------------
-- Arakkoa Category --
----------------------

AchieveIt.Categories:addCategory(categoryId, L["Arakkoa"], {
    -- Secrets of Skettis
    9415,
    -- Arakkoa Archivist
    9412
});

----------------------------
-- Draenor Clans Category --
----------------------------

AchieveIt.Categories:addCategory(categoryId, L["Draenor Clans"], {
    -- Strength and Honor
    9413,
    -- The Search For Fact, Not Truth
    9422
});

--------------------
-- Dwarf Category --
--------------------

AchieveIt.Categories:addCategory(categoryId, L["Dwarf"], {
    -- Blue Streak
    5193,
    -- Kings Under the Mountain
    4859
});

---------------------
-- Mantid Category --
---------------------

AchieveIt.Categories:addCategory(categoryId, L["Mantid"], {
	-- History of the Mantid
	8219,
	-- Collector: Ancient Sap Feeders
	8222,
	-- Collector: Ancient Sap Feeders
	8223,
	-- Collector: Banners of the Mantid Empire
	8220,
	-- Collector: Banners of the Mantid Empire
	8221,
	-- Collector: Carved Bronze Mirrors
	7343,
	-- Collector: Carved Bronze Mirrors
	7363,
	-- Collector: Inert Sound Beacons
	8226,
	-- Collector: Inert Sound Beacons
	8227,
	-- Collector: Kypari Sap Containers
	8234,
	-- Collector: Kypari Sap Containers
	8235,
	-- Collector: Mantid Lamps
	8230,
	-- Collector: Mantid Lamps
	8231,
	-- Collector: Pollen Collectors
	8232,
	-- Collector: Pollen Collectors
	8233,
	-- Collector: Praying Mantids
	8224,
	-- Collector: Praying Mantids
	8225,
	-- Collector: Remains of Paragons
	8228,
	-- Collector: Remains of Paragons
	8229
});

-------------------
-- Mogu Category --
-------------------

AchieveIt.Categories:addCategory(categoryId, L["Mogu"], {
	-- Documents of a Dark History
	7337,
	-- Instruments of Cruelty
	7334,
	-- Stone Servants
	7336,
	-- Symbols of Strength
	7335,
	-- Collector: Cracked Mogu Runestones
	7349,
	-- Collector: Cracked Mogu Runestones
	7369,
	-- Collector: Edicts of the Thunder King
	7353,
	-- Collector: Edicts of the Thunder King
	7373,
	-- Collector: Iron Amulets
	7354,
	-- Collector: Iron Amulets
	7374,
	-- Collector: Manacles of Rebellion
	7348,
	-- Collector: Manacles of Rebellion
	7368,
	-- Collector: Mogu Coins
	7356,
	-- Collector: Mogu Coins
	7376,
	-- Collector: Petrified Bone Whips
	7351,
	-- Collector: Petrified Bone Whips
	7371,
	-- Collector: Terracotta Arms
	7350,
	-- Collector: Terracotta Arms
	7370,
	-- Collector: Thunder King Insignias
	7352,
	-- Collector: Thunder King Insignias
	7372,
	-- Collector: Warlord's Branding Irons
	7355,
	-- Collector: Warlord's Branding Irons
	7375,
	-- Collector: Worn Monument Ledgers
	7357,
	-- Collector: Worn Monument Ledgers
	7377
});

------------------------
-- Night Elf Category --
------------------------

AchieveIt.Categories:addCategory(categoryId, L["Night Elf"], {
	-- Tragedy in Three Acts
	5191
});

-------------------
-- Ogre Category --
-------------------

AchieveIt.Categories:addCategory(categoryId, L["Ogre"], {
    -- Ogre Observer
    9414,
    -- Highmaul Historian
    9411
});

------------------
-- Orc Category --
------------------

AchieveIt.Categories:addCategory(categoryId, L["Orc"], {
    -- The Harder they Fall
    5192
});

-----------------------
-- Pandaren Category --
-----------------------

AchieveIt.Categories:addCategory(categoryId, L["Pandaren"], {
	-- The Broken Hearted
	7332,
	-- The Four Celestials
	7333,
	-- The Three Brew Fathers
	7331,
	-- Collector: Apothecary Tins
	7345,
	-- Collector: Apothecary Tins
	7365,
	-- Collector: Empty Kegs of Brewfather Xin Wo Yin
	7342,
	-- Collector: Empty Kegs of Brewfather Xin Wo Yin
	7362,
	-- Collector: Gold-Inlaid Porcelain Funerary Figurines
	7344,
	-- Collector: Gold-Inlaid Porcelain Funerary Figurines
	7364,
	-- Collector: Pandaren Game Boards
	7339,
	-- Collector: Pandaren Game Boards
	7359,
	-- Collector: Pandaren Tea Sets
	7338,
	-- Collector: Pandaren Tea Sets
	7358,
	-- Collector: Pearls of Yu'lon
	7346,
	-- Collector: Pearls of Yu'lon
	7366,
	-- Collector: Standards of Niuzao
	7347,
	-- Collector: Standards of Niuzao
	7367,
	-- Collector: Twin Stein Sets of Brewfather Quan Tou Kuo
	7340,
	-- Collector: Twin Stein Sets of Brewfather Quan Tou Kuo
	7360,
	-- Collector: Walking Canes of Brewfather Ren Yun
	7341,
	-- Collector: Walking Canes of Brewfather Ren Yun
	7361
});

----------------------
-- Tol'vir Category --
----------------------

AchieveIt.Categories:addCategory(categoryId, L["Tol'vir"], {
	-- The Boy Who Would be King
	5301
});