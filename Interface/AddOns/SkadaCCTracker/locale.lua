---------------------------------------
-- Globals
---------------------------------------

local addonName, vars = ...
local Ld, La = {}, {}
local locale = GAME_LOCALE or GetLocale()

vars.L = setmetatable({}, {
	__index = function(t, s) return La[s] or Ld[s] or rawget(t, s) or s end
})

---------------------------------------
-- enUS --
---------------------------------------
Ld["LOCALE_MOD_DONE_GENERAL"] = "CC done"
Ld["LOCALE_MOD_DONE_SPELLS"] = "CC done spells"
Ld["LOCALE_MOD_DONE_SPELL_TARGETS"] = "CC done spell targets"
Ld["LOCALE_MOD_DONE_TARGETS"] = "CC done targets"
Ld["LOCALE_MOD_DONE_TARGET_SPELLS"] = "CC done target spells"
Ld["LOCALE_MOD_TAKEN_GENERAL"] = "CC taken"
Ld["LOCALE_MOD_TAKEN_SPELLS"] = "CC taken spells"
Ld["LOCALE_MOD_TAKEN_SPELL_SOURCES"] = "CC taken spell sources"
Ld["LOCALE_MOD_TAKEN_SOURCES"] = "CC taken sources"
Ld["LOCALE_MOD_TAKEN_SOURCE_SPELLS"] = "CC taken source spells"
Ld["LOCALE_TARGETS"] = "targets"
Ld["LOCALE_SOURCES"] = "sources"
Ld["LOCALE_SPELLS"] = "spells"

---------------------------------------
-- deDE --
---------------------------------------
if locale == "deDE" then do end
	-- La["LOCALE_MOD_DONE_GENERAL"] 		= ""
	-- La["LOCALE_MOD_DONE_SPELLS"] 		= ""
	-- La["LOCALE_MOD_DONE_SPELL_TARGETS"]	= ""
	-- La["LOCALE_MOD_DONE_TARGETS"] 		= ""
	-- La["LOCALE_MOD_DONE_TARGET_SPELLS"]	= ""
	-- La["LOCALE_MOD_TAKEN_GENERAL"] 		= ""
	-- La["LOCALE_MOD_TAKEN_SPELLS"] 		= ""
	-- La["LOCALE_MOD_TAKEN_SPELL_SOURCES"]	= ""
	-- La["LOCALE_MOD_TAKEN_SOURCES"] 		= ""
	-- La["LOCALE_MOD_TAKEN_SOURCE_SPELLS"]	= ""
	-- La["LOCALE_TARGETS"] 				= ""
	-- La["LOCALE_SOURCES"] 				= ""
	-- La["LOCALE_SPELLS"] 					= ""

	---------------------------------------
	-- esES --
	---------------------------------------
elseif locale == "esES" then do end
	-- La["LOCALE_MOD_DONE_GENERAL"] 		= ""
	-- La["LOCALE_MOD_DONE_SPELLS"] 		= ""
	-- La["LOCALE_MOD_DONE_SPELL_TARGETS"]	= ""
	-- La["LOCALE_MOD_DONE_TARGETS"] 		= ""
	-- La["LOCALE_MOD_DONE_TARGET_SPELLS"]	= ""
	-- La["LOCALE_MOD_TAKEN_GENERAL"] 		= ""
	-- La["LOCALE_MOD_TAKEN_SPELLS"] 		= ""
	-- La["LOCALE_MOD_TAKEN_SPELL_SOURCES"]	= ""
	-- La["LOCALE_MOD_TAKEN_SOURCES"] 		= ""
	-- La["LOCALE_MOD_TAKEN_SOURCE_SPELLS"]	= ""
	-- La["LOCALE_TARGETS"] 				= ""
	-- La["LOCALE_SOURCES"] 				= ""
	-- La["LOCALE_SPELLS"] 					= ""

	---------------------------------------
	-- esMX --
	---------------------------------------
elseif locale == "esMX" then do end
	-- La["LOCALE_MOD_DONE_GENERAL"] 		= ""
	-- La["LOCALE_MOD_DONE_SPELLS"] 		= ""
	-- La["LOCALE_MOD_DONE_SPELL_TARGETS"]	= ""
	-- La["LOCALE_MOD_DONE_TARGETS"] 		= ""
	-- La["LOCALE_MOD_DONE_TARGET_SPELLS"]	= ""
	-- La["LOCALE_MOD_TAKEN_GENERAL"] 		= ""
	-- La["LOCALE_MOD_TAKEN_SPELLS"] 		= ""
	-- La["LOCALE_MOD_TAKEN_SPELL_SOURCES"]	= ""
	-- La["LOCALE_MOD_TAKEN_SOURCES"] 		= ""
	-- La["LOCALE_MOD_TAKEN_SOURCE_SPELLS"]	= ""
	-- La["LOCALE_TARGETS"] 				= ""
	-- La["LOCALE_SOURCES"] 				= ""
	-- La["LOCALE_SPELLS"] 					= ""


	---------------------------------------
	-- frFR --
	---------------------------------------
elseif locale == "frFR" then do end
	-- La["LOCALE_MOD_DONE_GENERAL"] 		= ""
	-- La["LOCALE_MOD_DONE_SPELLS"] 		= ""
	-- La["LOCALE_MOD_DONE_SPELL_TARGETS"]	= ""
	-- La["LOCALE_MOD_DONE_TARGETS"] 		= ""
	-- La["LOCALE_MOD_DONE_TARGET_SPELLS"]	= ""
	-- La["LOCALE_MOD_TAKEN_GENERAL"] 		= ""
	-- La["LOCALE_MOD_TAKEN_SPELLS"] 		= ""
	-- La["LOCALE_MOD_TAKEN_SPELL_SOURCES"]	= ""
	-- La["LOCALE_MOD_TAKEN_SOURCES"] 		= ""
	-- La["LOCALE_MOD_TAKEN_SOURCE_SPELLS"]	= ""
	-- La["LOCALE_TARGETS"] 				= ""
	-- La["LOCALE_SOURCES"] 				= ""
	-- La["LOCALE_SPELLS"] 					= ""


	---------------------------------------
	-- itIT --
	---------------------------------------
elseif locale == "itIT" then do end
	-- La["LOCALE_MOD_DONE_GENERAL"] 		= ""
	-- La["LOCALE_MOD_DONE_SPELLS"] 		= ""
	-- La["LOCALE_MOD_DONE_SPELL_TARGETS"]	= ""
	-- La["LOCALE_MOD_DONE_TARGETS"] 		= ""
	-- La["LOCALE_MOD_DONE_TARGET_SPELLS"]	= ""
	-- La["LOCALE_MOD_TAKEN_GENERAL"] 		= ""
	-- La["LOCALE_MOD_TAKEN_SPELLS"] 		= ""
	-- La["LOCALE_MOD_TAKEN_SPELL_SOURCES"]	= ""
	-- La["LOCALE_MOD_TAKEN_SOURCES"] 		= ""
	-- La["LOCALE_MOD_TAKEN_SOURCE_SPELLS"]	= ""
	-- La["LOCALE_TARGETS"] 				= ""
	-- La["LOCALE_SOURCES"] 				= ""
	-- La["LOCALE_SPELLS"] 					= ""


	---------------------------------------
	-- koKR --
	---------------------------------------
elseif locale == "koKR" then do end
	-- La["LOCALE_MOD_DONE_GENERAL"] 		= ""
	-- La["LOCALE_MOD_DONE_SPELLS"] 		= ""
	-- La["LOCALE_MOD_DONE_SPELL_TARGETS"]	= ""
	-- La["LOCALE_MOD_DONE_TARGETS"] 		= ""
	-- La["LOCALE_MOD_DONE_TARGET_SPELLS"]	= ""
	-- La["LOCALE_MOD_TAKEN_GENERAL"] 		= ""
	-- La["LOCALE_MOD_TAKEN_SPELLS"] 		= ""
	-- La["LOCALE_MOD_TAKEN_SPELL_SOURCES"]	= ""
	-- La["LOCALE_MOD_TAKEN_SOURCES"] 		= ""
	-- La["LOCALE_MOD_TAKEN_SOURCE_SPELLS"]	= ""
	-- La["LOCALE_TARGETS"] 				= ""
	-- La["LOCALE_SOURCES"] 				= ""
	-- La["LOCALE_SPELLS"] 					= ""


	---------------------------------------
	-- ptBR --
	---------------------------------------
elseif locale == "ptBR" then do end
	-- La["LOCALE_MOD_DONE_GENERAL"] 		= ""
	-- La["LOCALE_MOD_DONE_SPELLS"] 		= ""
	-- La["LOCALE_MOD_DONE_SPELL_TARGETS"]	= ""
	-- La["LOCALE_MOD_DONE_TARGETS"] 		= ""
	-- La["LOCALE_MOD_DONE_TARGET_SPELLS"]	= ""
	-- La["LOCALE_MOD_TAKEN_GENERAL"] 		= ""
	-- La["LOCALE_MOD_TAKEN_SPELLS"] 		= ""
	-- La["LOCALE_MOD_TAKEN_SPELL_SOURCES"]	= ""
	-- La["LOCALE_MOD_TAKEN_SOURCES"] 		= ""
	-- La["LOCALE_MOD_TAKEN_SOURCE_SPELLS"]	= ""
	-- La["LOCALE_TARGETS"] 				= ""
	-- La["LOCALE_SOURCES"] 				= ""
	-- La["LOCALE_SPELLS"] 					= ""


	---------------------------------------
	-- ruRU --
	---------------------------------------
elseif locale == "ruRU" then do end
	-- La["LOCALE_MOD_DONE_GENERAL"] 		= ""
	-- La["LOCALE_MOD_DONE_SPELLS"] 		= ""
	-- La["LOCALE_MOD_DONE_SPELL_TARGETS"]	= ""
	-- La["LOCALE_MOD_DONE_TARGETS"] 		= ""
	-- La["LOCALE_MOD_DONE_TARGET_SPELLS"]	= ""
	-- La["LOCALE_MOD_TAKEN_GENERAL"] 		= ""
	-- La["LOCALE_MOD_TAKEN_SPELLS"] 		= ""
	-- La["LOCALE_MOD_TAKEN_SPELL_SOURCES"]	= ""
	-- La["LOCALE_MOD_TAKEN_SOURCES"] 		= ""
	-- La["LOCALE_MOD_TAKEN_SOURCE_SPELLS"]	= ""
	-- La["LOCALE_TARGETS"] 				= ""
	-- La["LOCALE_SOURCES"] 				= ""
	-- La["LOCALE_SPELLS"] 					= ""


	---------------------------------------
	-- zhCN --
	---------------------------------------
elseif locale == "zhCN" then do end
	-- La["LOCALE_MOD_DONE_GENERAL"] 		= ""
	-- La["LOCALE_MOD_DONE_SPELLS"] 		= ""
	-- La["LOCALE_MOD_DONE_SPELL_TARGETS"]	= ""
	-- La["LOCALE_MOD_DONE_TARGETS"] 		= ""
	-- La["LOCALE_MOD_DONE_TARGET_SPELLS"]	= ""
	-- La["LOCALE_MOD_TAKEN_GENERAL"] 		= ""
	-- La["LOCALE_MOD_TAKEN_SPELLS"] 		= ""
	-- La["LOCALE_MOD_TAKEN_SPELL_SOURCES"]	= ""
	-- La["LOCALE_MOD_TAKEN_SOURCES"] 		= ""
	-- La["LOCALE_MOD_TAKEN_SOURCE_SPELLS"]	= ""
	-- La["LOCALE_TARGETS"] 				= ""
	-- La["LOCALE_SOURCES"] 				= ""
	-- La["LOCALE_SPELLS"] 					= ""


	---------------------------------------
	-- zhTW --
	---------------------------------------
elseif locale == "zhTW" then do end
	-- La["LOCALE_MOD_DONE_GENERAL"] 		= ""
	-- La["LOCALE_MOD_DONE_SPELLS"] 		= ""
	-- La["LOCALE_MOD_DONE_SPELL_TARGETS"]	= ""
	-- La["LOCALE_MOD_DONE_TARGETS"] 		= ""
	-- La["LOCALE_MOD_DONE_TARGET_SPELLS"]	= ""
	-- La["LOCALE_MOD_TAKEN_GENERAL"] 		= ""
	-- La["LOCALE_MOD_TAKEN_SPELLS"] 		= ""
	-- La["LOCALE_MOD_TAKEN_SPELL_SOURCES"]	= ""
	-- La["LOCALE_MOD_TAKEN_SOURCES"] 		= ""
	-- La["LOCALE_MOD_TAKEN_SOURCE_SPELLS"]	= ""
	-- La["LOCALE_TARGETS"] 				= ""
	-- La["LOCALE_SOURCES"] 				= ""
	-- La["LOCALE_SPELLS"] 					= ""
end