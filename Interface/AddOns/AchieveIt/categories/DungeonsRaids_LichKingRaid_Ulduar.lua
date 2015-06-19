------------------------------------------------------------
-- Dungeons & Raids - Lich King Raid  - Vault of Archavon --
------------------------------------------------------------

local AchieveIt = AchieveIt;

-- Locale
local L = LibStub("AceLocale-3.0"):GetLocale("AchieveIt");

-- The achievement category ID
local categoryId = 14922;

---------------------
-- Ulduar Category --
---------------------

local ulduarCategory = AchieveIt.Categories:addCategory(categoryId, GetMapNameByID(529));

ulduarCategory.locate = function()
	
	-- user is in raid
	return GetCurrentMapAreaID() == 529;

end;

--------------------
-- Ulduar / Zones --
--------------------
local zonesCategory = ulduarCategory:addChild(L["Progress"]);

--------------------------------
-- Ulduar / Zones / 10 Player --
--------------------------------

zonesCategory:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- The Siege of Ulduar
	2886,
	-- The Antechamber of Ulduar
	2888,
	-- The Keepers of Ulduar
	2890,
	-- The Descent into Madness
	2892,
	-- The Secrets of Ulduar
	2894,
	-- Observed
	3036
});

--------------------------------
-- Ulduar / Zones / 25 Player --
--------------------------------

zonesCategory:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- The Siege of Ulduar
	2887,
	-- The Antechamber of Ulduar
	2889,
	-- The Keepers of Ulduar
	2891,
	-- The Descent into Madness
	2893,
	-- The Secrets of Ulduar
	2895,
	-- Observed
	3037
});

zonesCategory:inheritAchievements();

------------------------------
-- Ulduar / Flame Leviathan --
------------------------------

local flameCategory = ulduarCategory:addChild(L["Flame Leviathan"]);

------------------------------------------
-- Ulduar / Flame Leviathan / 10 Player --
------------------------------------------

flameCategory:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- Dwarfageddon
	3097,
	-- Nuked from Orbit
	2915,
	-- Orbit-uary
	3056,
	-- Orbital Bombardment
	2913,
	-- Orbital Devastation
	2914,
	-- Shutout
	2911,
	-- Take Out Those Turrets
	2909,
	-- Three Car Garage
	2907,
	-- Unbroken
	2905
	
}).locate = function()

	-- in ulduar
	-- on floor 1
	-- and 10 player
	-- and player is in box
	return GetCurrentMapAreaID() == 529 and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.difficulty.is10PlayerRaid() and
			AchieveIt.Box:containsPlayer(44, 54, 34, 48);

end;

------------------------------------------
-- Ulduar / Flame Leviathan / 25 Player --
------------------------------------------

flameCategory:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- Dwarfageddon
	3098,
	-- Nuked from Orbit
	2917,
	-- Orbit-uary
	3057,
	-- Orbital Bombardment
	2918,
	-- Orbital Devastation
	2916,
	-- Shutout
	2912,
	-- Take Out Those Turrets
	2910,
	-- Three Car Garage
	2908,
	-- Unbroken
	2906
}).locate = function()

	-- in ulduar
	-- on floor 1
	-- and 25 player
	-- and player is in box
	return GetCurrentMapAreaID() == 529 and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.difficulty.is25PlayerRaid() and
			AchieveIt.Box:containsPlayer(44, 54, 34, 48);

end;

flameCategory:inheritAchievements();

---------------------------------------
-- Ulduar / Ignis the Furnace Master --
---------------------------------------

local ignisCategory = ulduarCategory:addChild(L["Ignis the Furnace Master"]);

---------------------------------------------------
-- Ulduar / Ignis the Furnace Master / 10 Player --
---------------------------------------------------

ignisCategory:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- Hot Pocket
	2927,
	-- Shattered
	2925,
	-- Stokin' the Furnace
	2929
}).locate = function()

	-- in ulduar
	-- on floor 1
	-- and 10 player
	-- and player is in box
	return GetCurrentMapAreaID() == 529 and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.difficulty.is10PlayerRaid() and
			AchieveIt.Box:containsPlayer(34, 46, 20, 31);

end;

---------------------------------------------------
-- Ulduar / Ignis the Furnace Master / 25 Player --
---------------------------------------------------

ignisCategory:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- Hot Pocket
	2928,
	-- Shattered
	2926,
	-- Stokin' the Furnace
	2930
}).locate = function()

	-- in ulduar
	-- on floor 1
	-- and 25 player
	-- and player is in box
	return GetCurrentMapAreaID() == 529 and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.difficulty.is25PlayerRaid() and
			AchieveIt.Box:containsPlayer(34, 46, 20, 31);

end;

ignisCategory:inheritAchievements();

-------------------------
-- Ulduar / Razorscale --
-------------------------

local razorScaleCategory = ulduarCategory:addChild(L["Razorscale"]);

-------------------------------------
-- Ulduar / Razorscale / 10 Player --
-------------------------------------

razorScaleCategory:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- A Quick Shave
	2919,
	-- Iron Dwarf, Medium Rare
	2923
}).locate = function()

	-- in ulduar
	-- on floor 1
	-- and 10 player
	-- and player is in box
	return GetCurrentMapAreaID() == 529 and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.difficulty.is10PlayerRaid() and
			AchieveIt.Box:containsPlayer(50, 58, 20, 34);

end;

-------------------------------------
-- Ulduar / Razorscale / 25 Player --
-------------------------------------

razorScaleCategory:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- A Quick Shave
	2921,
	-- Iron Dwarf, Medium Rare
	2924
}).locate = function()

	-- in ulduar
	-- on floor 1
	-- and 25 player
	-- and player is in box
	return GetCurrentMapAreaID() == 529 and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.difficulty.is25PlayerRaid() and
			AchieveIt.Box:containsPlayer(50, 58, 20, 34);

end;

razorScaleCategory:inheritAchievements();

-----------------------------------
-- Ulduar / XT-002 Deconstructor --
-----------------------------------

local xtCategory = ulduarCategory:addChild(L["XT-002 Deconstructor"]);

-----------------------------------------------
-- Ulduar / XT-002 Deconstructor / 10 Player --
-----------------------------------------------

xtCategory:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- Heartbreaker 
	3058,
	-- Must Deconstruct Faster
	2937,
	-- Nerf Engineering
	2931,
	-- Nerf Gravity Bombs
	2934,
	-- Nerf Scrapbots
	2933
}).locate = function()

	-- in ulduar
	-- on floor 1
	-- and 10 player
	-- and player is in box
	return GetCurrentMapAreaID() == 529 and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.difficulty.is10PlayerRaid() and
			AchieveIt.Box:containsPlayer(43, 52, 8, 18);

end;

-----------------------------------------------
-- Ulduar / XT-002 Deconstructor / 25 Player --
-----------------------------------------------

xtCategory:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- Heartbreaker 
	3059,
	-- Must Deconstruct Faster
	2938,
	-- Nerf Engineering
	2932,
	-- Nerf Gravity Bombs
	2936,
	-- Nerf Scrapbots
	2935
}).locate = function()

	-- in ulduar
	-- on floor 1
	-- and 25 player
	-- and player is in box
	return GetCurrentMapAreaID() == 529 and
			GetCurrentMapDungeonLevel() == 1 and
			AchieveIt.difficulty.is25PlayerRaid() and
			AchieveIt.Box:containsPlayer(43, 52, 8, 18);

end;

xtCategory:inheritAchievements();

-------------------------------
-- Ulduar / Assembly of Iron --
-------------------------------

local assemblyCategory = ulduarCategory:addChild(L["Assembly of Iron"]);

-------------------------------------------
-- Ulduar / Assembly of Iron / 10 Player --
-------------------------------------------

assemblyCategory:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- But I'm On Your Side 
	2945,
	-- Can't Do That While Stunned
	2947,
	-- I Choose You, Runemaster Molgeim
	2939,
	-- I Choose You, Steelbreaker
	2941,
	-- I Choose You, Stormcaller Brundir
	2940,
}).locate = function()

	-- in ulduar
	-- on floor 2
	-- and 10 player
	-- and player is in box
	return GetCurrentMapAreaID() == 529 and
			GetCurrentMapDungeonLevel() == 2 and
			AchieveIt.difficulty.is10PlayerRaid() and
			AchieveIt.Box:containsPlayer(2, 25, 38, 75);

end;

-------------------------------------------
-- Ulduar / Assembly of Iron / 25 Player --
-------------------------------------------

assemblyCategory:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- But I'm On Your Side 
	2946,
	-- Can't Do That While Stunned
	2948,
	-- I Choose You, Runemaster Molgeim
	2942,
	-- I Choose You, Steelbreaker
	2944,
	-- I Choose You, Stormcaller Brundir
	2943,
}).locate = function()

	-- in ulduar
	-- on floor 2
	-- and 25 player
	-- and player is in box
	return GetCurrentMapAreaID() == 529 and
			GetCurrentMapDungeonLevel() == 2 and
			AchieveIt.difficulty.is25PlayerRaid() and
			AchieveIt.Box:containsPlayer(2, 25, 38, 75);

end;

assemblyCategory:inheritAchievements();

-----------------------
-- Ulduar / Kologarn --
-----------------------

local kologarnCategory = ulduarCategory:addChild(L["Kologarn"]);

-----------------------------------
-- Ulduar / Kologarn / 10 Player --
-----------------------------------

kologarnCategory:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- Disarmed 
	2953,
	-- If Looks Could Kill 
	2955,
	-- Rubble and Roll
	2959,
	-- With Open Arms
	2951
}).locate = function()

	-- in ulduar
	-- on floor 2
	-- and 10 player
	-- and player is in box
	return GetCurrentMapAreaID() == 529 and
			GetCurrentMapDungeonLevel() == 2 and
			AchieveIt.difficulty.is10PlayerRaid() and
			AchieveIt.Box:containsPlayer(28, 46, 5, 26);

end;

-----------------------------------
-- Ulduar / Kologarn / 25 Player --
-----------------------------------

kologarnCategory:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- Disarmed 
	2954,
	-- If Looks Could Kill 
	2956,
	-- Rubble and Roll
	2960,
	-- With Open Arms
	2952
}).locate = function()

	-- in ulduar
	-- on floor 2
	-- and 25 player
	-- and player is in box
	return GetCurrentMapAreaID() == 529 and
			GetCurrentMapDungeonLevel() == 2 and
			AchieveIt.difficulty.is25PlayerRaid() and
			AchieveIt.Box:containsPlayer(28, 46, 5, 26);

end;

kologarnCategory:inheritAchievements();

----------------------
-- Ulduar / Auriaya --
----------------------

local auriayaCategory = ulduarCategory:addChild(L["Auriaya"]);

----------------------------------
-- Ulduar / Auriaya / 10 Player --
----------------------------------

auriayaCategory:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- Crazy Cat Lady 
	3006,
	-- Nine Lives
	3076
}).locate = function()

	-- in ulduar
	-- on floor 3
	-- and 10 player
	-- and player is in box
	return GetCurrentMapAreaID() == 529 and
			GetCurrentMapDungeonLevel() == 3 and
			AchieveIt.difficulty.is10PlayerRaid() and
			AchieveIt.Box:containsPlayer(40, 56, 51, 77);

end;

----------------------------------
-- Ulduar / Auriaya / 25 Player --
----------------------------------

auriayaCategory:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- Crazy Cat Lady 
	3007,
	-- Nine Lives
	3077
}).locate = function()

	-- in ulduar
	-- on floor 3
	-- and 25 player
	-- and player is in box
	return GetCurrentMapAreaID() == 529 and
			GetCurrentMapDungeonLevel() == 3 and
			AchieveIt.difficulty.is25PlayerRaid() and
			AchieveIt.Box:containsPlayer(40, 56, 51, 77);

end;

auriayaCategory:inheritAchievements();

--------------------
-- Ulduar / Freya --
--------------------

local freyaCategory = ulduarCategory:addChild(L["Freya"]);

--------------------------------
-- Ulduar / Freya / 10 Player --
--------------------------------

freyaCategory:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- Con-speed-atory
	2980,
	-- Deforestation 
	2985,
	-- Getting Back to Nature 
	2982,
	-- Knock on Wood
	3177,
	-- Knock, Knock on Wood
	3178,
	-- Knock, Knock, Knock on Wood
	3179,
	-- Lumberjacked 
	2979
}).locate = function()

	-- in ulduar
	-- on floor 3
	-- and 10 player
	-- and player is in box
	return GetCurrentMapAreaID() == 529 and
			GetCurrentMapDungeonLevel() == 3 and
			AchieveIt.difficulty.is10PlayerRaid() and
			AchieveIt.Box:containsPlayer(40, 61, 11, 40);

end;

--------------------------------
-- Ulduar / Freya / 25 Player --
--------------------------------

freyaCategory:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- Con-speed-atory
	2981,
	-- Deforestation 
	2984,
	-- Getting Back to Nature 
	2983,
	-- Knock on Wood
	3185,
	-- Knock, Knock on Wood
	3186,
	-- Knock, Knock, Knock on Wood
	3187,
	-- Lumberjacked 
	3118
}).locate = function()

	-- in ulduar
	-- on floor 3
	-- and 25 player
	-- and player is in box
	return GetCurrentMapAreaID() == 529 and
			GetCurrentMapDungeonLevel() == 3 and
			AchieveIt.difficulty.is25PlayerRaid() and
			AchieveIt.Box:containsPlayer(40, 61, 11, 40);

end;

freyaCategory:inheritAchievements();

--------------------
-- Ulduar / Hodir --
--------------------

local hodirCategory = ulduarCategory:addChild(L["Hodir"]);

--------------------------------
-- Ulduar / Hodir / 10 Player --
--------------------------------

hodirCategory:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- Cheese the Freeze
	2961,
	-- Getting Cold in Here
	2967,
	-- I Could Say That This Cache Was Rare
	3182,
	-- I Have the Coolest Friends
	2963,
	-- Staying Buffed All Winter
	2969
}).locate = function()

	-- in ulduar
	-- on floor 3
	-- and 10 player
	-- and player is in box
	return GetCurrentMapAreaID() == 529 and
			GetCurrentMapDungeonLevel() == 3 and
			AchieveIt.difficulty.is10PlayerRaid() and
			AchieveIt.Box:containsPlayer(61, 71, 58, 69);

end;

--------------------------------
-- Ulduar / Hodir / 25 Player --
--------------------------------

hodirCategory:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- Cheese the Freeze
	2962,
	-- Getting Cold in Here
	2968,
	-- I Could Say That This Cache Was Rare
	3184,
	-- I Have the Coolest Friends
	2965,
	-- Staying Buffed All Winter
	2970
}).locate = function()

	-- in ulduar
	-- on floor 3
	-- and 25 player
	-- and player is in box
	return GetCurrentMapAreaID() == 529 and
			GetCurrentMapDungeonLevel() == 3 and
			AchieveIt.difficulty.is25PlayerRaid() and
			AchieveIt.Box:containsPlayer(61, 71, 58, 69);

end;

hodirCategory:inheritAchievements();

----------------------
-- Ulduar / Mimiron --
----------------------

local mimironCategory = ulduarCategory:addChild(L["Mimiron"]);

----------------------------------
-- Ulduar / Mimiron / 10 Player --
----------------------------------

mimironCategory:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- Firefighter
	3180,
	-- Not-So-Friendly Fire
	3138,
	-- Set Up Us the Bomb
	2989
}).locate = function()

	-- in ulduar
	-- on floor 5
	-- and 10 player
	return GetCurrentMapAreaID() == 529 and
			GetCurrentMapDungeonLevel() == 5 and
			AchieveIt.difficulty.is10PlayerRaid();

end;

----------------------------------
-- Ulduar / Mimiron / 25 Player --
----------------------------------

mimironCategory:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- Firefighter
	3189,
	-- Not-So-Friendly Fire
	2995,
	-- Set Up Us the Bomb
	3237
}).locate = function()

	-- in ulduar
	-- on floor 5
	-- and 25 player
	return GetCurrentMapAreaID() == 529 and
			GetCurrentMapDungeonLevel() == 5 and
			AchieveIt.difficulty.is25PlayerRaid();

end;

mimironCategory:inheritAchievements();

---------------------
-- Ulduar / Thorim --
---------------------

local thorimCategory = ulduarCategory:addChild(L["Thorim"]);

---------------------------------
-- Ulduar / Thorim / 10 Player --
---------------------------------

thorimCategory:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- Don't Stand in the Lightning
	2971,
	-- I'll Take You All On
	2973,
	-- Lose Your Illusion
	3176,
	-- Siffed 
	2977,
	-- Who Needs Bloodlust? 
	2975
}).locate = function()

	-- in ulduar
	-- on floor 3
	-- and 10 player
	-- and player is in box
	return GetCurrentMapAreaID() == 529 and
			GetCurrentMapDungeonLevel() == 3 and
			AchieveIt.difficulty.is10PlayerRaid() and
			AchieveIt.Box:containsPlayer(63, 74, 41, 56);

end;

---------------------------------
-- Ulduar / Thorim / 25 Player --
---------------------------------

thorimCategory:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- Don't Stand in the Lightning
	2972,
	-- I'll Take You All On
	2974,
	-- Lose Your Illusion
	3183,
	-- Siffed 
	2978,
	-- Who Needs Bloodlust? 
	2976
}).locate = function()

	-- in ulduar
	-- on floor 3
	-- and 25 player
	-- and player is in box
	return GetCurrentMapAreaID() == 529 and
			GetCurrentMapDungeonLevel() == 3 and
			AchieveIt.difficulty.is25PlayerRaid() and
			AchieveIt.Box:containsPlayer(63, 74, 41, 56);

end;

thorimCategory:inheritAchievements();

----------------------------
-- Ulduar / General Vezax --
----------------------------

local vezaxCategory = ulduarCategory:addChild(L["General Vezax"]);

----------------------------------------
-- Ulduar / General Vezax / 10 Player --
----------------------------------------

vezaxCategory:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- I Love the Smell of Saronite in the Morning
	3181,
	-- Shadowdodger 
	2996
}).locate = function()

	-- in ulduar
	-- on floor 4
	-- and 10 player
	-- and player is in box
	return GetCurrentMapAreaID() == 529 and
			GetCurrentMapDungeonLevel() == 4 and
			AchieveIt.difficulty.is10PlayerRaid() and
			AchieveIt.Box:containsPlayer(44, 60, 53, 78);

end;

----------------------------------------
-- Ulduar / General Vezax / 25 Player --
----------------------------------------

vezaxCategory:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- I Love the Smell of Saronite in the Morning
	3188,
	-- Shadowdodger 
	2997
}).locate = function()

	-- in ulduar
	-- on floor 4
	-- and 25 player
	-- and player is in box
	return GetCurrentMapAreaID() == 529 and
			GetCurrentMapDungeonLevel() == 4 and
			AchieveIt.difficulty.is25PlayerRaid() and
			AchieveIt.Box:containsPlayer(44, 60, 53, 78);

end;

vezaxCategory:inheritAchievements();

-------------------------
-- Ulduar / Yogg-Saron --
-------------------------

local yoggCategory = ulduarCategory:addChild(L["Yogg-Saron"]);

-------------------------------------
-- Ulduar / Yogg-Saron / 10 Player --
-------------------------------------

yoggCategory:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- Alone in the Darkness
	3159,
	-- Drive Me Crazy
	3008,
	-- He's Not Getting Any Older
	3012,
	-- In His House He Waits Dreaming
	3015,
	-- Kiss and Make Up
	3009,
	-- One Light in the Darkness
	3158,
	-- They're Coming Out of the Walls
	3014,
	-- Three Lights in the Darkness
	3157,
	-- Two Lights in the Darkness
	3141
}).locate = function()

	-- in ulduar
	-- and 10 player
	if (GetCurrentMapAreaID() == 529 and AchieveIt.difficulty.is10PlayerRaid()) then 

		-- on floor 4
		-- and player is in box
		if (
			GetCurrentMapDungeonLevel() == 4 and
			AchieveIt.Box:containsPlayer(60.01, 75, 25, 64)
		) then

			return true;

		-- on floor 6
		elseif (GetCurrentMapDungeonLevel() == 6) then

			return true;

		end

	end

	return false;

end;

-------------------------------------
-- Ulduar / Yogg-Saron / 25 Player --
-------------------------------------

yoggCategory:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- Alone in the Darkness
	3164,
	-- Drive Me Crazy
	3010,
	-- He's Not Getting Any Older
	3013,
	-- In His House He Waits Dreaming
	3016,
	-- Kiss and Make Up
	3011,
	-- One Light in the Darkness
	3163,
	-- They're Coming Out of the Walls
	3017,
	-- Three Lights in the Darkness
	3161,
	-- Two Lights in the Darkness
	3162
}).locate = function()

	-- in ulduar
	-- and 25 player
	if (GetCurrentMapAreaID() == 529 and AchieveIt.difficulty.is25PlayerRaid()) then 

		-- on floor 4
		-- and player is in box
		if (
			GetCurrentMapDungeonLevel() == 4 and
			AchieveIt.Box:containsPlayer(60.01, 75, 25, 64)
		) then

			return true;

		-- on floor 6
		elseif (GetCurrentMapDungeonLevel() == 6) then

			return true;

		end

	end

	return false;

end;

yoggCategory:inheritAchievements();

-----------------------------------
-- Ulduar / Algalon the Observer --
-----------------------------------

local algalonCategory = ulduarCategory:addChild(L["Algalon the Observer"]);

-----------------------------------------------
-- Ulduar / Algalon the Observer / 10 Player --
-----------------------------------------------

algalonCategory:addChild(_G["RAID_DIFFICULTY_10PLAYER"], {
	-- He Feeds On Your Tears
	3004,
	-- Observed 
	3036,
	-- Supermassive  
	3003
}).locate = function()

	-- in ulduar
	-- on floor 2
	-- and 10 player
	-- and player is in box
	return GetCurrentMapAreaID() == 529 and
			GetCurrentMapDungeonLevel() == 2 and
			AchieveIt.difficulty.is10PlayerRaid() and
			AchieveIt.Box:containsPlayer(63, 96, 24, 72);

end;

-----------------------------------------------
-- Ulduar / Algalon the Observer / 25 Player --
-----------------------------------------------

algalonCategory:addChild(_G["RAID_DIFFICULTY_25PLAYER"], {
	-- He Feeds On Your Tears
	3005,
	-- Observed 
	3037,
	-- Supermassive  
	3002
}).locate = function()

	-- in ulduar
	-- on floor 2
	-- and 25 player
	-- and player is in box
	return GetCurrentMapAreaID() == 529 and
			GetCurrentMapDungeonLevel() == 2 and
			AchieveIt.difficulty.is25PlayerRaid() and
			AchieveIt.Box:containsPlayer(63, 96, 24, 72);

end;

algalonCategory:inheritAchievements();


ulduarCategory:inheritAchievements();