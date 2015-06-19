-- Dungeons & Raids - Classic

local AchieveIt = AchieveIt;

-- Locale
local L = LibStub("AceLocale-3.0"):GetLocale("AchieveIt");

-- The achievement category ID
local categoryId = 14808;

---------------------------
-- Dungeons Sub Category --
---------------------------

local category = AchieveIt.Categories:addCategory(categoryId, _G["DUNGEONS"], {
	-- Ragefire Chasm
	629,
	-- Deadmines
	628,
	-- Wailing Caverns
	630,
	-- Shadowfang Keep
	631,
	-- Blackfathom Deeps
	632,
	-- Stormwind Stockade
	633,
	-- Razorfen Kraul
	635,
	-- Gnomeregan
	634,
	-- Razorfen Downs
	636,
	-- Scarlet Halls
	7413,
	-- Scarlet Monastery
	637,
	-- Uldaman
	638,
	-- Zul'Farrak
	639,
	-- Maraudon
	640,
	-- Sunken Temple
	641,
	-- Blackrock Depths
	642,
	-- Lower Blackrock Spire
	643,
	-- King of Dire Maul
	644,
	-- Scholomance
	645,
	-- Stratholme
	646
});

category.locate = function()

	-- classic dungeon map ids
	local ids = {
		688, -- Blackfathom Deeps
		704, -- Blackrock Depths
		721, -- Blackrock Spire
		699, -- Dire Maul
		691, -- Gnomeregan
		750, -- Maraudon
		680, -- Ragefire Chasm
		760, -- Razorfen Downs
		761, -- Razorfen Kraul
		871, -- Scarlet Halls
		874, -- Scarlet Monastery
		898, -- Scholomance
		764, -- Shadowfang Keep
		765, -- Stratholme
		756, -- The Deadmines
		690, -- The Stockade
		687, -- The Temple of Atal'Hakkar
		692, -- Uldaman
		749, -- Wailing Caverns
		686  -- Zul'Farrak
	};

	return AchieveIt:Contains(ids, GetCurrentMapAreaID()) -- user is in one of these dungeons
			and AchieveIt.difficulty.isDungeon(); -- and it is a normal version (some have heroics which will be in different categories)

end;

------------------------
-- Raids Sub Category --
------------------------

local category = AchieveIt.Categories:addCategory(categoryId, _G["RAIDS"], {
	-- Ruins of Ahn'Qiraj
	689,
	-- Molten Core
	686,
	-- Blackwing Lair
	685,
	-- Temple of Ahn'Qiraj
	687
});

-- add locate
category.locate = function()
	
	-- classic raid map ids
	local ids = {
		755, -- Blackwing Lair
		696, -- Molten Core
		717, -- Ruins of Ahn'Qiraj
		766  -- Temple of Ahn'Qiraj
	};
	
	-- return whether user is in one of these raids
	return AchieveIt:Contains(ids, GetCurrentMapAreaID());

end;