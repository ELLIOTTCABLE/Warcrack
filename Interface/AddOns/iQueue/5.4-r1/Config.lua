-----------------------------
-- Get the addon table
-----------------------------

local AddonName, iQueue = ...;

local L = LibStub("AceLocale-3.0"):GetLocale(AddonName);

local _G = _G;

--------------------------
-- The option table
--------------------------

function iQueue:CreateDB()
	return { profile = {
		LeaveDungeonWhenFinished = true,
		LeaveDungeonAction = 1,
		WatchWorldPvP = false,
		WorldPvPTimer = false,
		WorldPvPPopup = 2,
		WorldPvPLastAlert = { 0, 0 }, -- we save last alert times for both WG and TB
	}};
end

---------------------------------
-- The configuration table
---------------------------------

local function CreateConfig()
	return {
		type = "group",
		name = AddonName,
		order = 1,
		get = function(info)
			return iQueue.db[info[#info]];
		end,
		set = function(info, value)
			iQueue.db[info[#info]] = value;
		end,
		args = {
			GroupGeneral = {
				type = "group",
				name = L["General Options"],
				order = 10,
				inline = true,
				args = {
					LeaveDungeonWhenFinished = {
						type = "toggle",
						name = L["When a dungeon is cleared, do:"],
						order = 10,
						width = "double",
						set = function(info, value)
							iQueue.db.LeaveDungeonWhenFinished = value;
							iQueue:DungeonComplete();
						end,
					},
					LeaveDungeonAction = {
						type = "select",
						name = L["Action"],
						order = 11,
						values = {
							[1] = L["Show Popup"],
							[2] = L["Auto-leave Group"],
						},
					},
				},
			},
			GroupWorldPvP = {
				type = "group",
				name = L["World PvP Zones"],
				order = 20,
				inline = true,
				args = {
					Description1 = {
						type = "description",
						name = L["As of Mists of Pandaria, World PvP Zones are deprecated. If you would like to farm achievements or something else, you may enable World PvP handling in iQueue."].."\n",
						fontSize = "small",
						order = 10,
					},
					WatchWorldPvP = {
						type = "toggle",
						name = L["Enable handling for World PvP Zones"],
						order = 20,
						width = "full",
						set = function(info, value)
							iQueue.db.WatchWorldPvP = value;
							iQueue:WatchWorldPvP();
						end,
					},
					EmptyLine1 = {
						type = "header",
						name = "",
						order = 30,
					},
					WorldPvPTimer = {
						type = "toggle",
						name = L["Alert when a WG/TB queue opened!"],
						order = 40,
						width = "double",
						set = function(info, value)
							iQueue.db.WorldPvPTimer = value;
							iQueue:WatchWorldPvP();
						end,
					},
					WorldPvPPopup = {
						type = "select",
						name = L["Popup message for:"],
						order = 41,
						values = {
							[1] = _G.NONE,
							[2] = _G.ALL,
							[3] = L["Only Wintergrasp"],
							[4] = L["Only Tol Barad"],
						},
					},
				},
			},
		},
	};
end

function iQueue:OpenOptions()
	_G.InterfaceOptionsFrame_OpenToCategory(AddonName);
end

LibStub("AceConfig-3.0"):RegisterOptionsTable(AddonName, CreateConfig);
LibStub("AceConfigDialog-3.0"):AddToBlizOptions(AddonName);
_G.SlashCmdList["IQUEUE"] = iQueue.OpenOptions;
_G["SLASH_IQUEUE1"] = "/iqueue";