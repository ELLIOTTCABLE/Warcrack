------------------------------------------
-- Dungeons & Raids - Lich King Dungeon --
------------------------------------------

local AchieveIt = AchieveIt;

-- Locale
local L = LibStub("AceLocale-3.0"):GetLocale("AchieveIt");

-- The achievement category ID
local categoryId = 14806;

---------------------------
-- Dungeons Sub Category --
---------------------------

local category = AchieveIt.Categories:addCategory(categoryId, _G["DUNGEONS"], {
	-- Utgarde Keep
	477,
	-- The Nexus
	478,
	-- Azjol-Nerub
	480,
	-- Ahn'kahet: The Old Kingdom
	481,
	-- Drak'Tharon Keep
	482,
	-- The Violet Hold
	483,
	-- Gundrak
	484,
	-- Halls of Stone
	485,
	-- Halls of Lightning
	486,
	-- The Oculus
	487,
	-- Utgarde Pinnacle
	488,
	-- The Culling of Stratholme
	479,
	-- Trial of the Champion
	{
		id		= 3778,
		faction	= AchieveIt.Factions.HORDE
	},
	-- Trial of the Champion
	{
		id		= 4296,
		faction	= AchieveIt.Factions.ALLIANCE
	},
	-- The Forge of Souls
	4516,
	-- The Pit of Saron
	4517,
	-- The Halls of Reflection
	4518
});

category.locate = function()

	-- wrath dungeon map ids
	local ids = {
		522, -- Ahn'kahet: The Old Kingdom
		533, -- Azjol-Nerub
		534, -- Drak'Tharon Keep
		530, -- Gundrak
		525, -- Halls of Lightning
		603, -- Halls of Reflection
		526, -- Halls of Stone
		602, -- Pit of Saron
		521, -- The Culling of Stratholme
		601, -- The Forge of Souls
		520, -- The Nexus
		528, -- The Oculus
		536, -- The Violet Hold
		542, -- Trial of the Champion
		523, -- Utgarde Keep
		524 -- Utgarde Pinnacle
	};

	return AchieveIt:Contains(ids, GetCurrentMapAreaID()) -- user is in one of these dungeons
			and AchieveIt.difficulty.isDungeon(); -- and it is a normal version (heroic versions will open specific dungeon category)

end;

----------------------------------
-- Heroic Dungeons Sub Category --
----------------------------------

AchieveIt.Categories:addCategory(categoryId, L["Heroic Dungeons"], {
	-- Heroic: Utgarde Keep
	489,
	-- Heroic: The Nexus
	490,
	-- Heroic: Azjol-Nerub
	491,
	-- Heroic: Ahn'kahet: The Old Kingdom
	492,
	-- Heroic: Drak'Tharon Keep
	493,
	-- Heroic: The Violet Hold
	494,
	-- Heroic: Gundrak
	495,
	-- Heroic: Halls of Stone
	496,
	-- Heroic: Halls of Lightning
	497,
	-- Heroic: The Oculus
	498,
	-- Heroic: Utgarde Pinnacle
	499,
	-- Heroic: The Culling of Stratholme
	500,
	-- Heroic: Trial of the Champion
	{
		id		= 4297,
		faction	= AchieveIt.Factions.HORDE
	},
	-- Heroic: Trial of the Champion
	{
		id		= 4298,
		faction	= AchieveIt.Factions.ALLIANCE
	},
	-- Heroic: The Forge of Souls
	4519,
	-- Heroic: The Pit of Saron
	4520,
	-- Heroic: The Halls of Reflection
	4521
});

------------------
-- Utgarde Keep --
------------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(523), {
	-- Utgarde Keep
	477,					
	-- Heroic: Utgarde Keep
	489
});

category.locate = function()

	-- dungeon map id
	local id = 523;

	return id == GetCurrentMapAreaID() -- user is in the dungeon
			and AchieveIt.difficulty.isHeroicDungeon(); -- and it is the heroic version

end;

------------------------------------
-- Utgarde Keep - Prince Keleseth --
------------------------------------

local subcategory = category:addChild(L["Prince Keleseth"], {
	-- On The Rocks
	1919
});

subcategory.locate = function()

	-- dungeon map id
	local id = 523;

	-- user is in the dungeon
	-- and it is heroic
	-- and on the correct level
	if (id == GetCurrentMapAreaID() and AchieveIt.difficulty.isHeroicDungeon() and GetCurrentMapDungeonLevel() == 1) then

		-- check if player is in it
		return AchieveIt.Box:containsPlayer(17, 40, 47, 76);

	end

	-- return false by default
	return false;

end;

category:inheritAchievements();

----------------------
-- Utgarde Pinnacle --
----------------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(524), {
	-- Utgarde Pinnacle
	488,
	-- Heroic: Utgarde Pinnacle
	499
});

category.locate = function()

	-- dungeon map id
	local id = 524;

	return id == GetCurrentMapAreaID() -- user is in the dungeon
			and AchieveIt.difficulty.isHeroicDungeon(); -- and it is the heroic version

end;

------------------------------------------
-- Utgarde Pinnacle - Svala Sorrowgrave --
------------------------------------------

local subcategory = category:addChild(L["Svala Sorrowgrave"], {	
	-- The Incredible Hulk
	2043
});

subcategory.locate = function()

	-- dungeon map id
	local id = 524;

	-- user is in the dungeon
	-- and it is heroic
	if (id == GetCurrentMapAreaID() and AchieveIt.difficulty.isHeroicDungeon()) then

		-- map level 2
		if (GetCurrentMapDungeonLevel() == 2) then

			-- check if player is in it
			return AchieveIt.Box:containsPlayer(36, 49.5, 65, 80);

		-- map level 1
		elseif (GetCurrentMapDungeonLevel() == 1) then

			return AchieveIt.Box:containsPlayer(20, 40, 57, 80);

		end

	end

	-- return false by default
	return false;

end;

-------------------------------------------
-- Utgarde Pinnacle - Skadi the Ruthless --
-------------------------------------------

local subcategory = category:addChild(L["Skadi the Ruthless"], {
	-- Lodi Dodi We Loves the Skadi
	1873,
	-- My Girl Loves to Skadi All the Time
	2156
});

subcategory.locate = function()

	-- dungeon map id
	local id = 524;

	-- user is in the dungeon
	-- and it is heroic
	-- and on the correct level
	if (id == GetCurrentMapAreaID() and AchieveIt.difficulty.isHeroicDungeon() and GetCurrentMapDungeonLevel() == 2) then

		-- check if player is in box
		return AchieveIt.Box:containsPlayer(63, 70, 30, 73);

	end

	-- return false by default
	return false;

end;

------------------------------------
-- Utgarde Pinnacle - King Ymiron --
------------------------------------

local subcategory = category:addChild(L["King Ymiron"], {	
	-- King's Bane
	2157
});

subcategory.locate = function()

	-- dungeon map id
	local id = 524;

	-- user is in the dungeon
	-- and it is heroic
	-- and on the correct level
	if (id == GetCurrentMapAreaID() and AchieveIt.difficulty.isHeroicDungeon() and GetCurrentMapDungeonLevel() == 2) then

		-- check if player is in box
		return AchieveIt.Box:containsPlayer(36.5, 51, 43, 65);

	end

	-- return false by default
	return false;

end;

category:inheritAchievements();

---------------
-- The Nexus --
---------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(520), {
	-- The Nexus
	478,
	-- Heroic: The Nexus
	490
});

category.locate = function()

	-- dungeon map id
	local id = 520;

	return id == GetCurrentMapAreaID() -- user is in the dungeon
			and AchieveIt.difficulty.isHeroicDungeon(); -- and it is the heroic version

end;

--------------------------------------
-- The Nexus / Grand Magus Telestra --
--------------------------------------

category:addChild(L["Grand Magus Telestra"], {
	-- Split Personality
	2150
}).locate = function()

	-- dungeon map id
	local id = 520;

	-- heroic difficulty
	-- and within correct area
	return AchieveIt.difficulty.isHeroicDungeon() and
			AchieveIt.Box:containsPlayer(24.5, 30.5, 35, 44.5);

end;

--------------------------
-- The Nexus / Anomalus --
--------------------------

category:addChild(L["Anomalus"], {
	-- Chaos Theory
	2037
}).locate = function()

	-- dungeon map id
	local id = 520;

	-- heroic difficulty
	-- and within correct area
	return AchieveIt.difficulty.isHeroicDungeon() and
			AchieveIt.Box:containsPlayer(56, 67, 14, 27);

end;

-----------------------------
-- The Nexus / Keristrasza --
-----------------------------

category:addChild(L["Keristrasza"], {	
	-- Intense Cold
	2036
}).locate = function()

	-- dungeon map id
	local id = 520;

	-- heroic difficulty
	-- and within correct area
	return AchieveIt.difficulty.isHeroicDungeon() and
			AchieveIt.Box:containsPlayer(32.5, 40, 62, 73);

end;

category:inheritAchievements();

----------------
-- The Oculus --
----------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(528), {
	-- The Oculus
	487,
	-- Heroic: The Oculus
	498
});

category.locate = function()

	-- dungeon map id
	local id = 528;

	return id == GetCurrentMapAreaID() -- user is in the dungeon
			and AchieveIt.difficulty.isHeroicDungeon(); -- and it is the heroic version

end;

--------------------------------------
-- The Oculus / Ley-Guardian Eregos --
--------------------------------------

category:addChild(L["Ley-Guardian Eregos"], {	
	-- Make It Count
	1868,
	-- Experienced Drake Rider
	1871,
	-- Intense Cold
	2036,
	-- Amber Void
	2046,
	-- Emerald Void
	2045,
	-- Ruby Void
	2044
});

category:inheritAchievements();

-----------------
-- Azjol-Nerub --
-----------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(533), {
	-- Azjol-Nerub
	480,
	-- Heroic: Azjol-Nerub
	491
});

category.locate = function()

	-- dungeon map id
	local id = 533;

	return id == GetCurrentMapAreaID() -- user is in the dungeon
			and AchieveIt.difficulty.isHeroicDungeon(); -- and it is the heroic version
end;

---------------------------------------------
-- Azjol-Nerub / Krik'thir the Gatewatcher --
---------------------------------------------

category:addChild(L["Krik'thir the Gatewatcher"], {	
	-- Watch Him Die
	1296
}).locate = function()

	-- dungeon map id
	local id = 533;

	-- user is in the dungeon
	-- and it is heroic
	-- and on the correct level
	if (id == GetCurrentMapAreaID() and AchieveIt.difficulty.isHeroicDungeon() and GetCurrentMapDungeonLevel() == 3) then

		-- check if player is in box
		return AchieveIt.Box:containsPlayer(26, 54, 23, 70);

	end

	-- return false by default
	return false;

end;

----------------------------
-- Azjol-Nerub / Hadronox --
----------------------------

category:addChild(L["Hadronox"], {
	-- Hadronox Denied
	1297
}).locate = function()

	-- dungeon map id
	local id = 533;

	-- user is in the dungeon
	-- and it is heroic
	-- and on the correct level
	if (id == GetCurrentMapAreaID() and AchieveIt.difficulty.isHeroicDungeon()) then

		if (GetCurrentMapDungeonLevel() == 3) then

			-- check if player is in box
			return AchieveIt.Box:containsPlayer(62, 90, 25, 65);

		-- level 2 can count entirely for hadronax
		elseif (GetCurrentMapDungeonLevel() == 2) then

			-- check if player is in box
			return true;

		end

	end


	-- return false by default
	return false;

end;

-----------------------------
-- Azjol-Nerub / Anub'arak --
-----------------------------

category:addChild(L["Anub'arak"], {
	-- Gotta Go!
	1860
}).locate = function()

	-- dungeon map id
	local id = 533;

	-- user is in the dungeon
	-- and it is heroic
	-- and on the correct level
	if (id == GetCurrentMapAreaID() and AchieveIt.difficulty.isHeroicDungeon() and GetCurrentMapDungeonLevel() == 1) then

		-- check if player is in box
		return AchieveIt.Box:containsPlayer(46, 77, 38, 58);

	end

	-- return false by default
	return false;

end;

category:inheritAchievements();

--------------------------------
-- Ahn'kahet: The Old Kingdom --
--------------------------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(522), {
	-- Ahn'kahet: The Old Kingdom
	481,
	-- Heroic: Ahn'kahet: The Old Kingdom
	492
});

category.locate = function()

	-- dungeon map id
	local id = 522;

	return id == GetCurrentMapAreaID() -- user is in the dungeon
			and AchieveIt.difficulty.isHeroicDungeon(); -- and it is the heroic version
end;

----------------------------------------------
-- Ahn'kahet: The Old Kingdom / Elder Nadox --
----------------------------------------------

category:addChild(L["Elder Nadox"], {
	-- Respect Your Elders
	2038
}).locate = function()

	-- dungeon map id
	local id = 522;

	-- user is in the dungeon
	-- and it is heroic
	-- player is in box
	return id == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			AchieveIt.Box:containsPlayer(65.5, 76.5, 23, 40);

end;

------------------------------------------------------
-- Ahn'kahet: The Old Kingdom / Jedoga Shadowseeker --
------------------------------------------------------

category:addChild(L["Jedoga Shadowseeker"], {
	-- Volunteer Work
	2056
}).locate = function()

	-- dungeon map id
	local id = 522;

	-- user is in the dungeon
	-- and it is heroic
	-- player is in box
	return id == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			AchieveIt.Box:containsPlayer(42, 57.5, 59, 80);

end;

------------------------------------------------
-- Ahn'kahet: The Old Kingdom / Herald Volazj --
------------------------------------------------

category:addChild(L["Herald Volazj"], {
	-- Volazj's Quick Demise
	1862
}).locate = function()

	-- dungeon map id
	local id = 522;

	-- user is in the dungeon
	-- and it is heroic
	-- player is in box
	return id == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			AchieveIt.Box:containsPlayer(16, 36, 36, 64);

end;

category:inheritAchievements();

-------------------------------
-- The Culling of Stratholme --
-------------------------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(521), {
	-- The Culling of Stratholme
	479,
	-- Heroic: The Culling of Stratholme
	500,
	-- Zombiefest!
	1872
});

category.locate = function()

	-- dungeon map id
	local id = 521;

	return id == GetCurrentMapAreaID() -- user is in the dungeon
			and AchieveIt.difficulty.isHeroicDungeon(); -- and it is the heroic version
end;

----------------------------------------------------
-- The Culling of Stratholme / Infinite Corruptor --
----------------------------------------------------

category:addChild(L["Infinite Corruptor"], {
	-- The Culling of Time
	1817
});

category:inheritAchievements();

----------------------
-- Drak'Tharon Keep --
----------------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(534), {
	-- Drak'Tharon Keep
	482,
	-- Heroic: Drak'Tharon Keep
	493
});

category.locate = function()

	-- dungeon map id
	local id = 534;

	return id == GetCurrentMapAreaID() -- user is in the dungeon
			and AchieveIt.difficulty.isHeroicDungeon(); -- and it is the heroic version
end;

----------------------------------
-- Drak'Tharon Keep / Trollgore --
----------------------------------

category:addChild(L["Trollgore"], {
	-- Consumption Junction
	2151
}).locate = function()

	-- dungeon map id
	local id = 534;

	-- user is in the dungeon
	-- and it is heroic
	-- and on first floor
	-- player is in box
	return id == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.Box:containsPlayer(50, 63, 13, 40);

end;

-------------------------------------------
-- Drak'Tharon Keep / Novos the Summoner --
-------------------------------------------

category:addChild(L["Novos the Summoner"], {
	-- Oh Novos!
	2057
}).locate = function()

	-- dungeon map id
	local id = 534;

	-- user is in the dungeon
	-- and it is heroic
	-- and on first floor
	-- player is in box
	return id == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.Box:containsPlayer(64, 82, 36, 60);

end;

----------------------------------
-- Drak'Tharon Keep / King Dred --
----------------------------------

category:addChild(L["King Dred"], {
	-- Better Off Dred
	2039
}).locate = function()

	-- dungeon map id
	local id = 534;

	-- user is in the dungeon
	-- and it is heroic
	-- and on first floor
	-- player is in box
	return id == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.Box:containsPlayer(51, 70, 61, 94);

end;

category:inheritAchievements();

-------------
-- Gundrak --
-------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(530), {
	-- Gundrak
	484,
	-- Heroic: Gundrak
	495
});

category.locate = function()

	-- dungeon map id
	local id = 530;

	return id == GetCurrentMapAreaID() -- user is in the dungeon
			and AchieveIt.difficulty.isHeroicDungeon(); -- and it is the heroic version
end;

------------------------
-- Gundrak / Slad'ran --
------------------------

category:addChild(L["Slad'ran"], {
	-- Snakes. Why'd It Have To Be Snakes?
	2058
}).locate = function()

	-- dungeon map id
	local id = 530;

	-- user is in the dungeon
	-- and it is heroic
	-- player is in box
	return id == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			AchieveIt.Box:containsPlayer(51, 64, 41, 56);

end;

-----------------------
-- Gundrak / Moorabi --
-----------------------

category:addChild(L["Moorabi"], {
	-- Less-rabi
	2040
}).locate = function()

	-- dungeon map id
	local id = 530;

	-- user is in the dungeon
	-- and it is heroic
	-- player is in box
	return id == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			AchieveIt.Box:containsPlayer(30, 41, 42, 58);

end;

---------------------------------
-- Gundrak / Eck the Ferocious --
---------------------------------

category:addChild(L["Eck the Ferocious"], {
	-- What the Eck?
	1864
}).locate = function()

	-- dungeon map id
	local id = 530;

	-- user is in the dungeon
	-- and it is heroic
	-- player is in box
	return id == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			AchieveIt.Box:containsPlayer(19, 29, 60, 76);

end;

-------------------------
-- Gundrak / Gal'darah --
-------------------------

category:addChild(L["Gal'darah"], {
	-- Share The Love
	2152
}).locate = function()

	-- dungeon map id
	local id = 530;

	-- user is in the dungeon
	-- and it is heroic
	-- player is in box
	return id == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			AchieveIt.Box:containsPlayer(39, 53, 14, 40);

end;

category:inheritAchievements();

---------------------
-- The Violet Hold --
---------------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(536), {
	-- The Violet Hold
	483,
	-- Heroic: The Violet Hold
	494,
	-- Lockdown!
	1865
});

category.locate = function()

	-- dungeon map id
	local id = 536;

	return id == GetCurrentMapAreaID() -- user is in the dungeon
			and AchieveIt.difficulty.isHeroicDungeon(); -- and it is the heroic version

end;

-----------------------------------------------
-- The Violet Hold / Zuramat the Obliterator --
-----------------------------------------------

category:addChild(L["Zuramat the Obliterator"], {
	-- A Void Dance
	2153
});

-------------------------------
-- The Violet Hold / Ichoron --
-------------------------------

category:addChild(L["Ichoron"], {
	-- Dehydration
	2041
});

---------------------------------
-- The Violet Hold / Cyanigosa --
---------------------------------

category:addChild(L["Cyanigosa"], {
	-- Defenseless
	1816
});

category:inheritAchievements();

--------------------
-- Halls of Stone --
--------------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(526), {
	-- Halls of Stone
	485,
	-- Heroic: Halls of Stone
	496
});

category.locate = function()

	-- dungeon map id
	local id = 526;

	return id == GetCurrentMapAreaID() -- user is in the dungeon
			and AchieveIt.difficulty.isHeroicDungeon(); -- and it is the heroic version
end;

--------------------------------------
-- Halls of Stone / Maiden of Grief --
--------------------------------------

category:addChild(L["Maiden of Grief"], {
	-- Good Grief
	1866
}).locate = function()

	-- dungeon map id
	local id = 526;

	-- user is in the dungeon
	-- and it is heroic
	-- player is in box
	return id == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			AchieveIt.Box:containsPlayer(42, 56, 75, 93);

end;

-------------------------------------------
-- Halls of Stone / Tribunal of the Ages --
-------------------------------------------

category:addChild(L["The Tribunal of Ages"], {
	-- Brann Spankin' New
	2154
}).locate = function()

	-- dungeon map id
	local id = 526;

	-- user is in the dungeon
	-- and it is heroic
	-- player is in box
	return id == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			AchieveIt.Box:containsPlayer(78, 89, 67, 83);

end;

---------------------------------------------
-- Halls of Stone / Sjonnir The Ironshaper --
---------------------------------------------

category:addChild(L["Sjonnir The Ironshaper"], {
	-- Abuse the Ooze
	2155
}).locate = function()

	-- dungeon map id
	local id = 526;

	-- user is in the dungeon
	-- and it is heroic
	-- player is in box
	return id == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			AchieveIt.Box:containsPlayer(38, 60, 6, 23);

end;

category:inheritAchievements();

------------------------
-- Halls of Lightning --
------------------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(525), {
	-- Halls of Lightning
	486,
	-- Heroic: Halls of Lightning
	497
});

category.locate = function()

	-- dungeon map id
	local id = 525;

	return id == GetCurrentMapAreaID() -- user is in the dungeon
			and AchieveIt.difficulty.isHeroicDungeon(); -- and it is the heroic version
end;

--------------------------------------------
-- Halls of Lightning / General Bjarngrim --
--------------------------------------------

category:addChild(L["General Bjarngrim"], {
	-- Lightning Struck
	1834
}).locate = function()

	-- dungeon map id
	local id = 525;

	-- user is in the dungeon
	-- and it is heroic
	-- and on correct level
	-- player is in box
	return id == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.Box:containsPlayer(27, 60, 26, 80);

end;

----------------------------------
-- Halls of Lightning / Volkhan --
----------------------------------

category:addChild(L["Volkhan"], {
	-- Shatter Resistant
	2042
}).locate = function()

	-- dungeon map id
	local id = 525;

	-- user is in the dungeon
	-- and it is heroic
	-- and on correct level
	-- player is in box
	return id == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 2 and
			AchieveIt.Box:containsPlayer(32, 46, 13, 28);

end;

--------------------------------
-- Halls of Lightning / Loken --
--------------------------------

category:addChild(L["Loken"], {
	-- Timely Death
	1867
}).locate = function()

	-- dungeon map id
	local id = 525;

	-- user is in the dungeon
	-- and it is heroic
	-- and on correct level
	-- player is in box
	return id == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			GetCurrentMapDungeonLevel() == 2 and
			AchieveIt.Box:containsPlayer(7, 29, 39, 63);

end;

category:inheritAchievements();

---------------------------
-- Trial of the Champion --
---------------------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(542), {
	-- Trial of the Champion
	{
		id		= 3778,
		faction	= AchieveIt.Factions.HORDE
	},
	-- Trial of the Champion
	{
		id		= 4296,
		faction	= AchieveIt.Factions.ALLIANCE
	},
	-- Heroic: Trial of the Champion
	{
		id		= 4297,
		faction	= AchieveIt.Factions.HORDE
	},
	-- Heroic: Trial of the Champion
	{
		id		= 4298,
		faction	= AchieveIt.Factions.ALLIANCE
	}
});

category.locate = function()

	-- dungeon map id
	local id = 542;

	return id == GetCurrentMapAreaID() -- user is in the dungeon
			and AchieveIt.difficulty.isHeroicDungeon(); -- and it is the heroic version
end;

--------------------------------------------------------
-- Trial of the Champion / Argent Confessor Paletress --
--------------------------------------------------------

category:addChild(L["Argent Confessor Paletress"], {
	-- Argent Confessor
	3802
});

---------------------------------------------
-- Trial of the Champion / Eadric the Pure --
---------------------------------------------

category:addChild(L["Eadric the Pure"], {
	-- The Faceroller
	3803
});

----------------------------------------------
-- Trial of the Champion / The Black Knight --
----------------------------------------------

category:addChild(L["The Black Knight"], {
	-- I've Had Worse
	3804
});

category:inheritAchievements();

------------------------
-- The Forge of Souls --
------------------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(601), {
	-- The Forge of Souls
	4516,
	-- Heroic: The Forge of Souls
	4519
});

category.locate = function()

	-- dungeon map id
	local id = 601;

	return id == GetCurrentMapAreaID() -- user is in the dungeon
			and AchieveIt.difficulty.isHeroicDungeon(); -- and it is the heroic version
end;

-----------------------------------
-- The Forge of Souls / Bronjahm --
-----------------------------------

category:addChild(L["Bronjahm"], {
	-- Soul Power
	4522
}).locate = function()

	-- dungeon map id
	local id = 601;

	-- user is in the dungeon
	-- and it is heroic
	-- player is in box
	return id == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			AchieveIt.Box:containsPlayer(40, 47, 44, 55);

end;

--------------------------------------------
-- The Forge of Souls / Devourer of Souls --
--------------------------------------------

category:addChild(L["Devourer of Souls"], {
	-- Three Faced
	4523
}).locate = function()

	-- dungeon map id
	local id = 601;

	-- user is in the dungeon
	-- and it is heroic
	-- player is in box
	return id == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			AchieveIt.Box:containsPlayer(36, 48, 3, 18);

end;

category:inheritAchievements();

------------------
-- Pit of Saron --
------------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(602), {
	-- The Pit of Saron
	4517,
	-- Heroic: The Pit of Saron
	4520
});

category.locate = function()

	-- dungeon map id
	local id = 602;

	return id == GetCurrentMapAreaID() -- user is in the dungeon
			and AchieveIt.difficulty.isHeroicDungeon(); -- and it is the heroic version
end;

-----------------------------------------
-- Pit of Saron / Forgemaster Garfrost --
-----------------------------------------

category:addChild(L["Forgemaster Garfrost"], {
	-- Doesn't Go to Eleven
	4524
}).locate = function()

	-- dungeon map id
	local id = 602;

	-- user is in the dungeon
	-- and it is heroic
	-- player is in box
	return id == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			AchieveIt.Box:containsPlayer(61, 72, 47, 61);

end;

-----------------------------------------
-- Pit of Saron / Scourgelord Tyrannus --
-----------------------------------------

category:addChild(L["Scourgelord Tyrannus"], {
	-- Don't Look Up
	4525
}).locate = function()

	-- dungeon map id
	local id = 602;

	-- user is in the dungeon
	-- and it is heroic
	-- player is in box
	return id == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			AchieveIt.Box:containsPlayer(37, 48.5, 15, 32);

end;

category:inheritAchievements();

-------------------------
-- Halls of Reflection --
-------------------------

local category = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(603), {
	-- The Halls of Reflection
	4518,
	-- Heroic: The Halls of Reflection
	4521
});

category.locate = function()

	-- dungeon map id
	local id = 603;

	return id == GetCurrentMapAreaID() -- user is in the dungeon
			and AchieveIt.difficulty.isHeroicDungeon(); -- and it is the heroic version
end;

-------------------------------------
-- Halls of Reflection / Lich King --
-------------------------------------

category:addChild(L["The Lich King"], {
	-- We're Not Retreating; We're Advancing in a Different Direction.
	4526
}).locate = function()

	-- dungeon map id
	local id = 602;

	-- user is in the dungeon
	-- and it is heroic
	-- player is in box
	return id == GetCurrentMapAreaID() and
			AchieveIt.difficulty.isHeroicDungeon() and
			AchieveIt.Box:containsPlayer(1, 25, 5, 38);

end;

category:inheritAchievements();