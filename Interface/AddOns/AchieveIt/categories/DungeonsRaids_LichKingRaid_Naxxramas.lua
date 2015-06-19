----------------------------------------------------
-- Dungeons & Raids - Lich King Raid  - Naxxramas --
----------------------------------------------------

local AchieveIt = AchieveIt;

-- Locale
local L = LibStub("AceLocale-3.0"):GetLocale("AchieveIt");

-- The achievement category ID
local categoryId = 14922;

------------------------
-- Naxxramas Category --
------------------------

local naxxramasCategory = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(535));

naxxramasCategory.locate = function()
	
	-- user is in raid
	return GetCurrentMapAreaID() == 535;

end;

--------------------------------
-- Naxxramas / Zones Category --
--------------------------------

local naxxZones = naxxramasCategory:addChild(L["Progress"]);

--------------------------------------------
-- Naxxramas / Zones / 10 Player Category --
--------------------------------------------

naxxZones:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- Fall of Naxxramas
	576,
	-- Arachnid Quarter
	562,
	-- Plague Quarter
	566,
	-- Military Quarter
	568,
	-- Construct Quarter
	564,
	-- Sapphiron's Demise
	572,
	-- Kelthuzad's Defeat
	574,
	-- The Dedicated Few
	578
});

--------------------------------------------
-- Naxxramas / Zones / 25 Player Category --
--------------------------------------------

naxxZones:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- Fall of Naxxramas
	577,
	-- Arachnid Quarter
	563,
	-- Plague Quarter
	567,
	-- Military Quarter
	569,
	-- Construct Quarter
	565,
	-- Sapphiron's Demise
	573,
	-- Kelthuzad's Defeat
	575,
	-- The Dedicated Few
	579
});

naxxZones:inheritAchievements();

--------------------------------------
-- Naxxramas / Anub'Rekhan Category --
--------------------------------------

local naxxAnubrekhanCategory = naxxramasCategory:addChild(L["Anub'Rekhan"]);

--------------------------------------------------
-- Naxxramas / Anub'Rekhan / 10 Player Category --
--------------------------------------------------

naxxAnubrekhanCategory:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- Arachnophobia
	1858
}).locate = function()

	-- in naxx
	-- on floor 2
	-- and 10 player
	-- and player is in box
	return GetCurrentMapAreaID() == 535 and
			GetCurrentMapDungeonLevel() == 2 and
			AchieveIt.difficulty.is10PlayerRaid() and
			AchieveIt.Box:containsPlayer(23, 36, 36, 59);

end;

--------------------------------------------------
-- Naxxramas / Anub'Rekhan / 25 Player Category --
--------------------------------------------------

naxxAnubrekhanCategory:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- Arachnophobia
	1859
}).locate = function()

	-- in naxx
	-- on floor 2
	-- and 25 player
	-- and player is in box
	return GetCurrentMapAreaID() == 535 and
			GetCurrentMapDungeonLevel() == 2 and
			AchieveIt.difficulty.is25PlayerRaid() and
			AchieveIt.Box:containsPlayer(23, 36, 36, 59);

end;

naxxAnubrekhanCategory:inheritAchievements();

-----------------------------------------------
-- Naxxramas / Grand Widow Faerlina Category --
-----------------------------------------------

local naxxFaerlinaCategory = naxxramasCategory:addChild(L["Grand Widow Faerlina"]);

-----------------------------------------------------------
-- Naxxramas / Grand Widow Faerlina / 10 Player Category --
-----------------------------------------------------------

naxxFaerlinaCategory:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- Momma Said Knock You Out
	1997
}).locate = function()

	-- in naxx
	-- on floor 2
	-- and 10 player
	-- and player is in box
	return GetCurrentMapAreaID() == 535 and
			GetCurrentMapDungeonLevel() == 2 and
			AchieveIt.difficulty.is10PlayerRaid() and
			AchieveIt.Box:containsPlayer(40, 53, 28, 43);

end;

-----------------------------------------------------------
-- Naxxramas / Grand Widow Faerlina / 25 Player Category --
-----------------------------------------------------------

naxxFaerlinaCategory:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- Momma Said Knock You Out
	2140
}).locate = function()

	-- in naxx
	-- on floor 2
	-- and 25 player
	-- and player is in box
	return GetCurrentMapAreaID() == 535 and
			GetCurrentMapDungeonLevel() == 2 and
			AchieveIt.difficulty.is25PlayerRaid() and
			AchieveIt.Box:containsPlayer(40, 53, 28, 43);

end;

naxxFaerlinaCategory:inheritAchievements();

----------------------------------
-- Naxxramas / Maexxna Category --
----------------------------------

local naxxMaexxnaCategory = naxxramasCategory:addChild(L["Maexxna"]);

----------------------------------------------
-- Naxxramas / Maexxna / 10 Player Category --
----------------------------------------------

naxxMaexxnaCategory:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- Arachnophobia
	1858
}).locate = function()

	-- in naxx
	-- on floor 2
	-- and 10 player
	-- and player is in box
	return GetCurrentMapAreaID() == 535 and
			GetCurrentMapDungeonLevel() == 2 and
			AchieveIt.difficulty.is10PlayerRaid() and
			AchieveIt.Box:containsPlayer(61, 76, 4, 28);

end;

----------------------------------------------
-- Naxxramas / Maexxna / 25 Player Category --
----------------------------------------------

naxxMaexxnaCategory:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- Arachnophobia
	1859
}).locate = function()

	-- in naxx
	-- on floor 2
	-- and 25 player
	-- and player is in box
	return GetCurrentMapAreaID() == 535 and
			GetCurrentMapDungeonLevel() == 2 and
			AchieveIt.difficulty.is25PlayerRaid() and
			AchieveIt.Box:containsPlayer(61, 76, 4, 28);

end;

naxxMaexxnaCategory:inheritAchievements();

---------------------------------
-- Naxxramas / Heigan Category --
---------------------------------

local naxxHeiganCategory = naxxramasCategory:addChild(L["Heigan the Unclean"]);

---------------------------------------------
-- Naxxramas / Heigan / 10 Player Category --
---------------------------------------------

naxxHeiganCategory:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- Safety Dance
	1996
}).locate = function()

	-- in naxx
	-- on floor 4
	-- and 10 player
	-- and player is in box
	return GetCurrentMapAreaID() == 535 and
			GetCurrentMapDungeonLevel() == 4 and
			AchieveIt.difficulty.is10PlayerRaid() and
			AchieveIt.Box:containsPlayer(45, 54, 37, 53);

end;

---------------------------------------------
-- Naxxramas / Heigan / 25 Player Category --
---------------------------------------------

naxxHeiganCategory:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- Safety Dance
	2139
}).locate = function()

	-- in naxx
	-- on floor 4
	-- and 25 player
	-- and player is in box
	return GetCurrentMapAreaID() == 535 and
			GetCurrentMapDungeonLevel() == 4 and
			AchieveIt.difficulty.is25PlayerRaid() and
			AchieveIt.Box:containsPlayer(45, 54, 37, 53);

end;

naxxHeiganCategory:inheritAchievements();

----------------------------------
-- Naxxramas / Loatheb Category --
----------------------------------

local naxxLoathebCategory = naxxramasCategory:addChild(L["Loatheb"]);

----------------------------------------------
-- Naxxramas / Loatheb / 10 Player Category --
----------------------------------------------

naxxLoathebCategory:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- Spore Loser
	2182
}).locate = function()

	-- in naxx
	-- on floor 4
	-- and 10 player
	-- and player is in box
	return GetCurrentMapAreaID() == 535 and
			GetCurrentMapDungeonLevel() == 4 and
			AchieveIt.difficulty.is10PlayerRaid() and
			AchieveIt.Box:containsPlayer(69, 80, 18, 36);

end;

----------------------------------------------
-- Naxxramas / Loatheb / 25 Player Category --
----------------------------------------------

naxxLoathebCategory:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- Spore Loser
	2183
}).locate = function()

	-- in naxx
	-- on floor 4
	-- and 25 player
	-- and player is in box
	return GetCurrentMapAreaID() == 535 and
			GetCurrentMapDungeonLevel() == 4 and
			AchieveIt.difficulty.is25PlayerRaid() and
			AchieveIt.Box:containsPlayer(69, 80, 18, 36);

end;

naxxLoathebCategory:inheritAchievements();

----------------------------------------
-- Naxxramas / Four Horsemen Category --
----------------------------------------

local naxxHorsemenCategory = naxxramasCategory:addChild(L["The Four Horsemen"]);

----------------------------------------------------
-- Naxxramas / Four Horsemen / 10 Player Category --
----------------------------------------------------

naxxHorsemenCategory:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- And They Would All Go Down Together
	2176
}).locate = function()

	-- in naxx
	-- on floor 3
	-- and 10 player
	-- and player is in box
	return GetCurrentMapAreaID() == 535 and
			GetCurrentMapDungeonLevel() == 3 and
			AchieveIt.difficulty.is10PlayerRaid() and
			AchieveIt.Box:containsPlayer(22, 39, 61, 88);

end;

----------------------------------------------------
-- Naxxramas / Four Horsemen / 25 Player Category --
----------------------------------------------------

naxxHorsemenCategory:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- And They Would All Go Down Together
	2177
}).locate = function()

	-- in naxx
	-- on floor 3
	-- and 25 player
	-- and player is in box
	return GetCurrentMapAreaID() == 535 and
			GetCurrentMapDungeonLevel() == 3 and
			AchieveIt.difficulty.is25PlayerRaid() and
			AchieveIt.Box:containsPlayer(22, 39, 61, 88);

end;

naxxHorsemenCategory:inheritAchievements();

------------------------------------
-- Naxxramas / Patchwerk Category --
------------------------------------

local naxxPatchwerkCategory = naxxramasCategory:addChild(L["Patchwerk"]);

------------------------------------------------
-- Naxxramas / Patchwerk / 10 Player Category --
------------------------------------------------

naxxPatchwerkCategory:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- Make Quick Werk of Him
	1856
}).locate = function()

	-- in naxx
	-- on floor 1
	-- and 10 player
	-- and player is in box
	return GetCurrentMapAreaID() == 535 and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.difficulty.is10PlayerRaid() and
			AchieveIt.Box:containsPlayer(38, 53, 56, 83);

end;

------------------------------------------------
-- Naxxramas / Patchwerk / 25 Player Category --
------------------------------------------------

naxxPatchwerkCategory:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- Make Quick Werk of Him
	1857
}).locate = function()

	-- in naxx
	-- on floor 1
	-- and 25 player
	-- and player is in box
	return GetCurrentMapAreaID() == 535 and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.difficulty.is25PlayerRaid() and
			AchieveIt.Box:containsPlayer(38, 53, 56, 83);

end;

naxxPatchwerkCategory:inheritAchievements();

-----------------------------------
-- Naxxramas / Thaddius Category --
-----------------------------------

local naxxThaddiusCategory = naxxramasCategory:addChild(L["Thaddius"]);

-----------------------------------------------
-- Naxxramas / Thaddius / 10 Player Category --
-----------------------------------------------

naxxThaddiusCategory:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- Shocking!
	2178,
	-- Subtraction
	2180
}).locate = function()

	-- in naxx
	-- on floor 1
	-- and 10 player
	-- and player is in box
	return GetCurrentMapAreaID() == 535 and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.difficulty.is10PlayerRaid() and
			AchieveIt.Box:containsPlayer(18, 39, 4, 33);

end;

-----------------------------------------------
-- Naxxramas / Thaddius / 25 Player Category --
-----------------------------------------------

naxxThaddiusCategory:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- Shocking!
	2179,
	-- Subtraction
	2181
}).locate = function()

	-- in naxx
	-- on floor 1
	-- and 25 player
	-- and player is in box
	return GetCurrentMapAreaID() == 535 and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.difficulty.is25PlayerRaid() and
			AchieveIt.Box:containsPlayer(18, 39, 4, 33);

end;

naxxThaddiusCategory:inheritAchievements();

------------------------------------
-- Naxxramas / Sapphiron Category --
------------------------------------

local naxxSapphironCategory = naxxramasCategory:addChild(L["Sapphiron"]);

-----------------------------------------------
-- Naxxramas / Sapphiron / 10 Player Category --
-----------------------------------------------

naxxSapphironCategory:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- Sapphiron's Demise!
	572,
	-- The Hundred Club
	2146
}).locate = function()

	-- in naxx
	-- on floor 6
	-- and 10 player
	-- and player is in box
	return GetCurrentMapAreaID() == 535 and
			GetCurrentMapDungeonLevel() == 6 and
			AchieveIt.difficulty.is10PlayerRaid() and
			AchieveIt.Box:containsPlayer(42, 78, 43, 92);

end;

-----------------------------------------------
-- Naxxramas / Sapphiron / 25 Player Category --
-----------------------------------------------

naxxSapphironCategory:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- Sapphiron's Demise!
	573,
	-- The Hundred Club
	2147
}).locate = function()

	-- in naxx
	-- on floor 6
	-- and 25 player
	-- and player is in box
	return GetCurrentMapAreaID() == 535 and
			GetCurrentMapDungeonLevel() == 6 and
			AchieveIt.difficulty.is25PlayerRaid() and
			AchieveIt.Box:containsPlayer(42, 78, 43, 92);

end;

naxxSapphironCategory:inheritAchievements();

-------------------------------------
-- Naxxramas / Kel'Thuzad Category --
-------------------------------------

local naxxKelthuzadCategory = naxxramasCategory:addChild(L["Kel'Thuzad"]);

-------------------------------------------------
-- Naxxramas / Kel'Thuzad / 10 Player Category --
-------------------------------------------------

naxxKelthuzadCategory:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- Kel'Thuzad's Defeat
	574,
	-- Just Can't Get Enough
	2184
}).locate = function()

	-- in naxx
	-- on floor 6
	-- and 10 player
	-- and player is in box
	return GetCurrentMapAreaID() == 535 and
			GetCurrentMapDungeonLevel() == 6 and
			AchieveIt.difficulty.is10PlayerRaid() and
			AchieveIt.Box:containsPlayer(20, 50, 2, 43);

end;

-------------------------------------------------
-- Naxxramas / Kel'Thuzad / 25 Player Category --
-------------------------------------------------

naxxKelthuzadCategory:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- Kel'Thuzad's Defeat
	575,
	-- Just Can't Get Enough
	2185
}).locate = function()

	-- in naxx
	-- on floor 6
	-- and 25 player
	-- and player is in box
	return GetCurrentMapAreaID() == 535 and
			GetCurrentMapDungeonLevel() == 6 and
			AchieveIt.difficulty.is25PlayerRaid() and
			AchieveIt.Box:containsPlayer(20, 50, 2, 43);

end;

naxxKelthuzadCategory:inheritAchievements();

naxxramasCategory:inheritAchievements();