----------------------------------------------------------
-- Dungeons & Raids - Lich King Raid - Icecrown Citadel --
----------------------------------------------------------

local AchieveIt = AchieveIt;

-- Locale
local L = LibStub("AceLocale-3.0"):GetLocale("AchieveIt");

-- The achievement category ID
local categoryId = 14922;

-------------------------------
-- Icecrown Citadel Category --
-------------------------------

local icecrownCategory = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(604));

icecrownCategory.locate = function()
	
	-- user is in raid
	return GetCurrentMapAreaID() == 604;

end;

-------------------------------
-- Icecrown Citadel / Bosses --
-------------------------------

local bossCategory = icecrownCategory:addChild(L["Progress"]);

-------------------------------------------
-- Icecrown Citadel / Bosses / 10 Player --
-------------------------------------------

bossCategory:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- Storming the Citadel (10 player) 
	4531,
	-- The Plagueworks (10 player) 
	4528,
	-- The Crimson Hall (10 player) 
	4529,
	-- The Frostwing Halls (10 player) 
	4527,	
	-- The Frozen Throne (10 player) 
	4530,
	-- Fall of the Lich King (10 player) 
	4532,
	-- Heroic: Storming the Citadel (10 player) 
	4628,
	-- Heroic: The Plagueworks (10 player) 
	4629,
	-- Heroic: The Crimson Hall (10 player) 
	4630,
	-- Heroic: The Frostwing Halls (10 player) 
	4631,
	-- Heroic: Fall of the Lich King (10 player) 
	4636,
	-- Bane of the Fallen King
	4583
});

-------------------------------------------
-- Icecrown Citadel / Bosses / 25 Player --
-------------------------------------------

bossCategory:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {	
	-- Storming the Citadel (25 player) 
	4604,
	-- The Plagueworks (25 player) 
	4605,
	-- The Crimson Hall (25 player) 
	4606,
	-- The Frostwing Halls (25 player) 
	4607,
	-- The Frozen Throne (25 player) 
	4597,
	-- Fall of the Lich King (25 player) 
	4608,
	-- Heroic: Storming the Citadel (25 player) 
	4632,
	-- Heroic: The Plagueworks (25 player) 
	4633,
	-- Heroic: The Crimson Hall (25 player) 
	4634,
	-- Heroic: The Frostwing Halls (25 player) 
	4635,
	-- Heroic: Fall of the Lich King (25 player)
	4637,
	-- The Light of Dawn 
	4584
});

bossCategory:inheritAchievements();

---------------------------------------
-- Icecrown Citadel / Lord Marrowgar --
---------------------------------------

local category = icecrownCategory:addChild(L["Lord Marrowgar"]);

---------------------------------------------------
-- Icecrown Citadel / Lord Marrowgar / 10 Player --
---------------------------------------------------

category:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- Boned (10 player) 
	4534
}).locate = function()

	-- in icecrown citadel
	-- on floor 1
	-- and 10 player
	-- and player is in box
	return GetCurrentMapAreaID() == 604 and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.difficulty.is10PlayerRaid() and
			AchieveIt.Box:containsPlayer(29, 47, 49, 73);

end;

---------------------------------------------------
-- Icecrown Citadel / Lord Marrowgar / 25 Player --
---------------------------------------------------

category:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- Boned (25 player) 
	4610
}).locate = function()

	-- in icecrown citadel
	-- on floor 1
	-- and 25 player
	-- and player is in box
	return GetCurrentMapAreaID() == 604 and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.difficulty.is25PlayerRaid() and
			AchieveIt.Box:containsPlayer(29, 47, 49, 73);

end;

category:inheritAchievements();

------------------------------------------
-- Icecrown Citadel / Lady Deathwhisper --
------------------------------------------

local category = icecrownCategory:addChild(L["Lady Deathwhisper"]);

------------------------------------------------------
-- Icecrown Citadel / Lady Deathwhisper / 10 Player --
------------------------------------------------------

category:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- Full House (10 player) 
	4535
}).locate = function()

	-- in icecrown citadel
	-- on floor 1
	-- and 10 player
	-- and player is in box
	return GetCurrentMapAreaID() == 604 and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.difficulty.is10PlayerRaid() and
			AchieveIt.Box:containsPlayer(32, 44, 71, 93);

end;

------------------------------------------------------
-- Icecrown Citadel / Lady Deathwhisper / 25 Player --
------------------------------------------------------

category:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- Full House (25 player) 
	4611
}).locate = function()

	-- in icecrown citadel
	-- on floor 1
	-- and 25 player
	-- and player is in box
	return GetCurrentMapAreaID() == 604 and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.difficulty.is25PlayerRaid() and
			AchieveIt.Box:containsPlayer(32, 44, 71, 93);

end;

category:inheritAchievements();

---------------------------------------
-- Icecrown Citadel / Gunship Battle --
---------------------------------------

local category = icecrownCategory:addChild(L["Icecrown Gunship Battle"]);

---------------------------------------------------
-- Icecrown Citadel / Gunship Battle / 10 Player --
---------------------------------------------------

category:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- I'm on a Boat (10 player) 
	4536
}).locate = function()

	-- in icecrown citadel
	-- on floor 2
	-- and 10 player
	return GetCurrentMapAreaID() == 604 and
			GetCurrentMapDungeonLevel() == 2 and
			AchieveIt.difficulty.is10PlayerRaid();

end;

---------------------------------------------------
-- Icecrown Citadel / Gunship Battle / 25 Player --
---------------------------------------------------

category:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- I'm on a Boat (25 player) 
	4612
}).locate = function()

	-- in icecrown citadel
	-- on floor 2
	-- and 25 player
	return GetCurrentMapAreaID() == 604 and
			GetCurrentMapDungeonLevel() == 2 and
			AchieveIt.difficulty.is25PlayerRaid();

end;

category:inheritAchievements();

----------------------------------------------
-- Icecrown Citadel / Deathbringer Saurfang --
----------------------------------------------

local category = icecrownCategory:addChild(L["Deathbringer Saurfang"]);

----------------------------------------------------------
-- Icecrown Citadel / Deathbringer Saurfang / 10 Player --
----------------------------------------------------------

category:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- I've Gone and Made a Mess (10 player) 
	4537
}).locate = function()

	-- in icecrown citadel
	-- on floor 3
	-- and 10 player
	return GetCurrentMapAreaID() == 604 and
			GetCurrentMapDungeonLevel() == 3 and
			AchieveIt.difficulty.is10PlayerRaid();

end;

----------------------------------------------------------
-- Icecrown Citadel / Deathbringer Saurfang / 25 Player --
----------------------------------------------------------

category:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- I've Gone and Made a Mess (25 player) 
	4613
}).locate = function()

	-- in icecrown citadel
	-- on floor 3
	-- and 25 player
	return GetCurrentMapAreaID() == 604 and
			GetCurrentMapDungeonLevel() == 3 and
			AchieveIt.difficulty.is25PlayerRaid();

end;

category:inheritAchievements();

----------------------------------
-- Icecrown Citadel / Festergut --
----------------------------------

local category = icecrownCategory:addChild(L["Festergut"]);

----------------------------------------------
-- Icecrown Citadel / Festergut / 10 Player --
----------------------------------------------

category:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- Flu Shot Shortage (10 player) 
	4577
}).locate = function()

	-- in icecrown citadel
	-- on floor 5
	-- and 10 player
	-- and player is in box
	return GetCurrentMapAreaID() == 604 and
			GetCurrentMapDungeonLevel() == 5 and
			AchieveIt.difficulty.is10PlayerRaid() and
			AchieveIt.Box:containsPlayer(16, 27, 59, 73);

end;

----------------------------------------------
-- Icecrown Citadel / Festergut / 25 Player --
----------------------------------------------

category:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- Flu Shot Shortage (25 player) 
	4615
}).locate = function()

	-- in icecrown citadel
	-- on floor 5
	-- and 25 player
	-- and player is in box
	return GetCurrentMapAreaID() == 604 and
			GetCurrentMapDungeonLevel() == 5 and
			AchieveIt.difficulty.is25PlayerRaid() and
			AchieveIt.Box:containsPlayer(16, 27, 59, 73);

end;

category:inheritAchievements();

--------------------------------
-- Icecrown Citadel / Rotface --
--------------------------------

local category = icecrownCategory:addChild(L["Rotface"]);

--------------------------------------------
-- Icecrown Citadel / Rotface / 10 Player --
--------------------------------------------

category:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- Dances with Oozes (10 player) 
	4538
}).locate = function()

	-- in icecrown citadel
	-- on floor 5
	-- and 10 player
	-- and player is in box
	return GetCurrentMapAreaID() == 604 and
			GetCurrentMapDungeonLevel() == 5 and
			AchieveIt.difficulty.is10PlayerRaid() and
			AchieveIt.Box:containsPlayer(16, 27, 34, 48);

end;

--------------------------------------------
-- Icecrown Citadel / Rotface / 25 Player --
--------------------------------------------

category:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- Dances with Oozes (25 player) 
	4614
}).locate = function()

	-- in icecrown citadel
	-- on floor 5
	-- and 25 player
	-- and player is in box
	return GetCurrentMapAreaID() == 604 and
			GetCurrentMapDungeonLevel() == 5 and
			AchieveIt.difficulty.is25PlayerRaid() and
			AchieveIt.Box:containsPlayer(16, 27, 34, 48);

end;

category:inheritAchievements();

--------------------------------------------
-- Icecrown Citadel / Professor Putricide --
--------------------------------------------

local category = icecrownCategory:addChild(L["Professor Putricide"]);

--------------------------------------------------------
-- Icecrown Citadel / Professor Putricide / 10 Player --
--------------------------------------------------------

category:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- Nausea, Heartburn, Indigestion... (10 player) 
	4578
}).locate = function()

	-- in icecrown citadel
	-- on floor 5
	-- and 10 player
	-- and player is in box
	return GetCurrentMapAreaID() == 604 and
			GetCurrentMapDungeonLevel() == 5 and
			AchieveIt.difficulty.is10PlayerRaid() and
			AchieveIt.Box:containsPlayer(7, 21, 48.01, 58.99);

end;

--------------------------------------------------------
-- Icecrown Citadel / Professor Putricide / 25 Player --
--------------------------------------------------------

category:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- Nausea, Heartburn, Indigestion... (25 player) 
	4616
}).locate = function()

	-- in icecrown citadel
	-- on floor 5
	-- and 25 player
	-- and player is in box
	return GetCurrentMapAreaID() == 604 and
			GetCurrentMapDungeonLevel() == 5 and
			AchieveIt.difficulty.is25PlayerRaid() and
			AchieveIt.Box:containsPlayer(7, 21, 48.01, 58.99);

end;

category:inheritAchievements();

---------------------------------------------
-- Icecrown Citadel / Blood Prince Council --
---------------------------------------------

local category = icecrownCategory:addChild(L["Blood Prince Council"]);

---------------------------------------------------------
-- Icecrown Citadel / Blood Prince Council / 10 Player --
---------------------------------------------------------

category:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- The Orb Whisperer (10 player) 
	4582
}).locate = function()

	-- in icecrown citadel
	-- on floor 5
	-- and 10 player
	-- and player is in box
	return GetCurrentMapAreaID() == 604 and
			GetCurrentMapDungeonLevel() == 5 and
			AchieveIt.difficulty.is10PlayerRaid() and
			AchieveIt.Box:containsPlayer(43, 59, 4, 37);

end;

---------------------------------------------------------
-- Icecrown Citadel / Blood Prince Council / 25 Player --
---------------------------------------------------------

category:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- The Orb Whisperer (25 player) 
	4617
}).locate = function()

	-- in icecrown citadel
	-- on floor 5
	-- and 25 player
	-- and player is in box
	return GetCurrentMapAreaID() == 604 and
			GetCurrentMapDungeonLevel() == 5 and
			AchieveIt.difficulty.is25PlayerRaid() and
			AchieveIt.Box:containsPlayer(43, 59, 4, 37);

end;

category:inheritAchievements();

----------------------------------------------
-- Icecrown Citadel / Blood-Queen Lana'thel --
----------------------------------------------

local category = icecrownCategory:addChild(L["Blood-Queen Lana'thel"]);

----------------------------------------------------------
-- Icecrown Citadel / Blood-Queen Lana'thel / 10 Player --
----------------------------------------------------------

category:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- Once Bitten, Twice Shy (10 player) 
	4539
}).locate = function()

	-- in icecrown citadel
	-- on floor 6
	-- and 10 player
	return GetCurrentMapAreaID() == 604 and
			GetCurrentMapDungeonLevel() == 6 and
			AchieveIt.difficulty.is10PlayerRaid();

end;

----------------------------------------------------------
-- Icecrown Citadel / Blood-Queen Lana'thel / 25 Player --
----------------------------------------------------------

category:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- Once Bitten, Twice Shy (25 player) 
	4618
}).locate = function()

	-- in icecrown citadel
	-- on floor 6
	-- and 25 player
	return GetCurrentMapAreaID() == 604 and
			GetCurrentMapDungeonLevel() == 6 and
			AchieveIt.difficulty.is25PlayerRaid();

end;

category:inheritAchievements();

----------------------------------------------
-- Icecrown Citadel / Valithria Dreamwalker --
----------------------------------------------

local category = icecrownCategory:addChild(L["Valithria Dreamwalker"]);

----------------------------------------------------------
-- Icecrown Citadel / Valithria Dreamwalker / 10 Player --
----------------------------------------------------------

category:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- Portal Jockey (10 player) 
	4579
}).locate = function()

	-- in icecrown citadel
	-- on floor 5
	-- and 10 player
	-- and player is in box
	return GetCurrentMapAreaID() == 604 and
			GetCurrentMapDungeonLevel() == 5 and
			AchieveIt.difficulty.is10PlayerRaid() and
			AchieveIt.Box:containsPlayer(70, 83, 59, 85);

end;

----------------------------------------------------------
-- Icecrown Citadel / Valithria Dreamwalker / 25 Player --
----------------------------------------------------------

category:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- Portal Jockey (25 player) 
	4619
}).locate = function()

	-- in icecrown citadel
	-- on floor 5
	-- and 25 player
	-- and player is in box
	return GetCurrentMapAreaID() == 604 and
			GetCurrentMapDungeonLevel() == 5 and
			AchieveIt.difficulty.is25PlayerRaid() and
			AchieveIt.Box:containsPlayer(70, 83, 59, 85);

end;

category:inheritAchievements();

-----------------------------------
-- Icecrown Citadel / Sindragosa --
-----------------------------------

local category = icecrownCategory:addChild(L["Sindragosa"]);

-----------------------------------------------
-- Icecrown Citadel / Sindragosa / 10 Player --
-----------------------------------------------

category:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- All You Can Eat (10 player) 
	4580
}).locate = function()

	-- in icecrown citadel
	-- on floor 4
	-- and 10 player
	-- and player is in box
	return GetCurrentMapAreaID() == 604 and
			GetCurrentMapDungeonLevel() == 4 and
			AchieveIt.difficulty.is10PlayerRaid() and
			AchieveIt.Box:containsPlayer(23, 45, 6, 48);

end;

-----------------------------------------------
-- Icecrown Citadel / Sindragosa / 25 Player --
-----------------------------------------------

category:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- All You Can Eat (25 player) 
	4620
}).locate = function()

	-- in icecrown citadel
	-- on floor 4
	-- and 25 player
	-- and player is in box
	return GetCurrentMapAreaID() == 604 and
			GetCurrentMapDungeonLevel() == 4 and
			AchieveIt.difficulty.is25PlayerRaid() and
			AchieveIt.Box:containsPlayer(23, 45, 6, 48);

end;

category:inheritAchievements();

--------------------------------------
-- Icecrown Citadel / The Lich King --
--------------------------------------

local category = icecrownCategory:addChild(L["The Lich King"]);

--------------------------------------------------
-- Icecrown Citadel / The Lich King / 10 Player --
--------------------------------------------------

category:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- The Frozen Throne (10 player) 
	4530,
	-- Bane of the Fallen King 
	4583,
	-- Been Waiting a Long Time for This (10 player) 
	4601,
	-- Neck-Deep in Vile (10 player) 
	4581
}).locate = function()

	-- in icecrown citadel
	-- on floor 7
	-- and 10 player
	return GetCurrentMapAreaID() == 604 and
			GetCurrentMapDungeonLevel() == 7 and
			AchieveIt.difficulty.is10PlayerRaid();

end;

--------------------------------------------------
-- Icecrown Citadel / The Lich King / 25 Player --
--------------------------------------------------

category:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- The Frozen Throne (25 player) 
	4597,
	-- The Light of Dawn 
	4584,
	-- Been Waiting a Long Time for This (25 player) 
	4621,
	-- Neck-Deep in Vile (25 player) 
	4622
}).locate = function()

	-- in icecrown citadel
	-- on floor 7
	-- and 25 player
	return GetCurrentMapAreaID() == 604 and
			GetCurrentMapDungeonLevel() == 7 and
			AchieveIt.difficulty.is25PlayerRaid();

end;

category:inheritAchievements();


icecrownCategory:inheritAchievements();