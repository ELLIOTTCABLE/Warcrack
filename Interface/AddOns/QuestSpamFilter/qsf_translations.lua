
--[[
	QuestSpam Filter
		By Myrilandell of Lothar
		
		This file contains the code for 
			* Translations of titles
			* World of Warcraft Global Strings
			
		Special thanks to:
			Wolf936 - incredible localization assistance, in German and in general.
			oXid_FoX  - better French titles for "Questlog Full", "Already On", and "Too Far Away".
]]



--------------------------------------------------------------------------------
--------------------------- GLOBAL VARIABLES ------------------------
--------------------------------------------------------------------------------

QSF_addon = {};
QSF_addon.region = GetLocale();

-- the localized strings for the QSF_addon.patterns table
QSF_addon.globalPatterns = {
	[1] = _G["ERR_QUEST_PUSH_ALREADY_DONE_S"],
	[2] = _G["ERR_QUEST_PUSH_BUSY_S"],
	[3] = _G["ERR_QUEST_PUSH_INVALID_S"],
	[4] = _G["ERR_QUEST_PUSH_LOG_FULL_S"],
	[5] = _G["ERR_QUEST_PUSH_ONQUEST_S"],
	[6] = _G["ERR_QUEST_PUSH_SUCCESS_S"],
	[7] = _G["ERR_QUEST_PUSH_TOO_FAR_S"],
};



-- this table gives titles to each of the tables, for use in printing
QSF_addon.titleName = {
	["Completed"] = {
		["enUS"] = "Completed",
		["enGB"] = "Completed",
		["esES"] = "Terminado",
		["esMX"] = "Terminado",
		["deDE"] = "Abgeschlossen",
		["frFR"] = "Termin\195\169", -- \195\169 = �
		["ruRU"] = "Zavershennyi",
		["zhCN"] = "Yi w\195\161nch\195\169ng", -- \195\161 = � 	\195\169 = �
		["zhTW"] = "Yi w\195\161nch\195\169ng", -- \195\161 = � 	\195\169 = �
		["koKR"] = "wanlyo",
	},
	["Busy"] =  {
		["enUS"] = "Busy",
		["enGB"] = "Busy",
		["esES"] = "Ocupado",
		["esMX"] = "Ocupado",
		["deDE"] = "Besch\195\164ftigt", -- \195\164 = �
		["frFR"] = "Occup\195\169", -- \195\169 = �
		["ruRU"] = "Zanyato",
		["zhCN"] = "M\195\161ng", -- \195\161 = �
		["zhTW"] = "M\195\161ng", -- \195\161 = �
		["koKR"] = "bappeun",
	},
	["Not Eligible"] =  {
		["enUS"] = "Not Eligible",
		["enGB"] = "Not Eligible",
		["esES"] = "No re\195\186ne los Requisitos", -- \195\186 = �
		["esMX"] = "No re\195\186ne los Requisitos", -- \195\186 = �
		["deDE"] = "Nicht Qualifiziert",
		["frFR"] = "Non Admissible",
		["ruRU"] = "Ne Priemlemye",
		["zhCN"] = "M\195\169iyou zig\195\169", -- \195\169 = �
		["zhTW"] = "M\195\169iyou zig\195\169", -- \195\169 = �
		["koKR"] = "jagyeog-i eobs-seubnida",
	},
	["Questlog Full"] =  {
		["enUS"] = "Questlog Full",
		["enGB"] = "Questlog Full",
		["esES"] = "Questlog Completo",
		["esMX"] = "Questlog Completo",
		["deDE"] = "Questlog voll",
		["frFR"] = "Journal de qu\195\170tes plein", -- � = \195\170
		["ruRU"] = "Polnyi Questlog",
		["zhCN"] = "Questlog qu\195\161nb\195\185", -- \195\161 = �	 \195\185 = �
		["zhTW"] = "Questlog qu\195\161nb\195\185", -- \195\161 = �	 \195\185 = �
		["koKR"] = "Questlog jeonche",
	},
	["Already On"] =  {
		["enUS"] = "Already On",
		["enGB"] = "Already On",
		["esES"] = "Ya se Encuentra en",
		["esMX"] = "Ya se Encuentra en",
		["deDE"] = "Hat bereits",
		["frFR"] = "D\195\169j\195\160 dessus", -- \195\169 = �	 \195\160 = �
		["ruRU"] = "Uzhe na",
		["zhCN"] = "Yijing",
		["zhTW"] = "Yijing",
		["koKR"] = "imi",
	},
	["Sharing ..."] =  {
		["enUS"] = "Sharing ...",
		["enGB"] = "Sharing ...",
		["esES"] = "Compartiendo ...",
		["esMX"] = "Compartiendo ...",
		["deDE"] = "Teile ...",
		["frFR"] = "Partage ...",
		["ruRU"] = "Raspredelenie ...",
		["zhCN"] = "G\195\178ngxiang ...", -- \195\178 = �
		["zhTW"] = "G\195\178ngxiang ...", -- \195\178 = �
		["koKR"] = "gong-yu ...",
	},
	["Too Far Away"] =  {
		["enUS"] = "Too Far Away",
		["enGB"] = "Too Far Away",
		["esES"] = "Demasiado Lejos",
		["esMX"] = "Demasiado Lejos",
		["deDE"] = "Zu weit entfernt",
		["frFR"] = "Trop loin",
		["ruRU"] = "Too Far Away",
		["zhCN"] = "T\195\160i yuan", -- \195\160 = �
		["zhTW"] = "T\195\160i yuan", -- \195\160 = �
		["koKR"] = "neomu meolli",
	},
};


