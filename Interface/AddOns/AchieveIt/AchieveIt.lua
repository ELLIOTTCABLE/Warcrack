
local _, AchieveIt = ...

local AchieveIt = LibStub("AceAddon-3.0"):NewAddon(AchieveIt, "AchieveIt", "AceConsole-3.0", "AceEvent-3.0", "AceHook-3.0");
_G.AchieveIt = AchieveIt;

-- Locale
local L = LibStub("AceLocale-3.0"):GetLocale("AchieveIt");

-- WoW APIs
local _G = _G;

---------------
-- CONSTANTS --
---------------

-- Debug Mode
-- Set this to false for release
AchieveIt.DEBUG = false;
--[===[@debug@
AchieveIt.DEBUG = true;
--@end-debug@]===]

-- The current TOC version
-- Used for making sure new features are valid between US and EU patches
AchieveIt.TOC_VERSION = select(4, GetBuildInfo());

-- Player Faction
AchieveIt.FACTION = UnitFactionGroup("player");

-- Factions
AchieveIt.Factions = {
	HORDE		= "Horde",
	ALLIANCE	= "Alliance",
	NEUTRAL		= "Neutral"
};


-- Addon initialised
function AchieveIt:OnInitialize()

	AchieveIt:Printd("Initialized: master linux");

end

