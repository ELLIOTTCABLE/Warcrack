
SMARTBUFF_Options = {
	["ToggleAutoCombat"] = false,
	["AutoSwitchTemplateInst"] = false,
	["BuffTarget"] = false,
	["SplashY"] = -100,
	["MMCPosX"] = 12.53397451057906,
	["IgnoreList"] = {
	},
	["ToggleSubGrpChanged"] = false,
	["SplashX"] = 100,
	["ToggleMsgNormal"] = false,
	["AutoTimer"] = 5,
	["ToggleGrp"] = {
		true, -- [1]
		false, -- [2]
		false, -- [3]
		false, -- [4]
		false, -- [5]
		false, -- [6]
		false, -- [7]
		false, -- [8]
	},
	["AutoSwitchTemplate"] = false,
	["AntiDaze"] = true,
	["RebuffTimer"] = 20,
	["ToggleAutoSplash"] = true,
	["BuffPvP"] = false,
	["ColSplashFont"] = {
		["b"] = 1,
		["g"] = 1,
		["r"] = 1,
	},
	["UpgradeToDualSpec"] = true,
	["OldWheelDown"] = "CAMERAZOOMOUT",
	["LastTemplate"] = "Solo",
	["Toggle"] = true,
	["AddList"] = {
	},
	["OldWheelUp"] = "CAMERAZOOMIN",
	["ShowMiniGrp"] = false,
	["LinkSelfBuffCheck"] = true,
	["Debug"] = false,
	["MinCharges"] = 3,
	["UISync"] = true,
	["HideMmButton"] = false,
	["ToggleAutoSound"] = false,
	["BuffInCities"] = true,
	["MMCPosY"] = -149.3007339749726,
	["ToggleMsgError"] = false,
	["ToggleMsgWarning"] = false,
	["CompMode"] = false,
	["SplashDuration"] = 2,
	["LinkGrpBuffCheck"] = true,
	["CurrentFont"] = 9,
	["ToggleAuto"] = true,
	["InShapeshift"] = true,
	["CheckCharges"] = true,
	["HideSAButton"] = false,
	["ScrollWheelDown"] = true,
	["ToggleAutoChat"] = false,
	["BlacklistTimer"] = 5,
	["ScrollWheelUp"] = false,
	["InCombat"] = false,
}
SMARTBUFF_Buffs = {
	{
		["Solo"] = {
			["GrpBuffSize"] = 4,
			["Create Healthstone"] = {
				["EnableG"] = false,
				["ManaLimit"] = 0,
				["RBTime"] = 0,
				["MH"] = false,
				["CIn"] = false,
				["COut"] = true,
				["EnableS"] = false,
				["SelfNot"] = false,
				["IgnoreList"] = {
				},
				["SelfOnly"] = false,
				["AddList"] = {
				},
				["Reminder"] = true,
				["RH"] = false,
				["OH"] = false,
			},
			["Create Soulstone"] = {
				["EnableG"] = false,
				["ManaLimit"] = 0,
				["RBTime"] = 0,
				["MH"] = false,
				["CIn"] = false,
				["COut"] = true,
				["EnableS"] = false,
				["SelfNot"] = false,
				["IgnoreList"] = {
				},
				["SelfOnly"] = false,
				["AddList"] = {
				},
				["Reminder"] = true,
				["RH"] = false,
				["OH"] = false,
			},
			["Soulstone"] = {
				["HUNTER"] = false,
				["WARRIOR"] = false,
				["PALADIN"] = false,
				["RBTime"] = 0,
				["MH"] = false,
				["CIn"] = false,
				["EnableS"] = false,
				["EnableG"] = false,
				["IgnoreList"] = {
				},
				["ManaLimit"] = 0,
				["AddList"] = {
				},
				["Reminder"] = true,
				["MAGE"] = false,
				["SHAMAN"] = false,
				["DEATHKNIGHT"] = false,
				["TANK"] = false,
				["WPET"] = false,
				["SelfOnly"] = false,
				["HEALER"] = false,
				["PRIEST"] = false,
				["DKPET"] = false,
				["COut"] = true,
				["HPET"] = false,
				["SelfNot"] = false,
				["WARLOCK"] = false,
				["OH"] = false,
				["ROGUE"] = false,
				["DRUID"] = false,
				["RH"] = false,
				["DAMAGER"] = false,
			},
			["Life Tap"] = {
				["EnableG"] = false,
				["ManaLimit"] = 0,
				["RBTime"] = 0,
				["MH"] = false,
				["CIn"] = false,
				["COut"] = true,
				["EnableS"] = false,
				["SelfNot"] = false,
				["IgnoreList"] = {
				},
				["SelfOnly"] = false,
				["AddList"] = {
				},
				["Reminder"] = true,
				["RH"] = false,
				["OH"] = false,
			},
			["Unending Breath"] = {
				["HUNTER"] = true,
				["WARRIOR"] = true,
				["PALADIN"] = true,
				["RBTime"] = 0,
				["MH"] = false,
				["CIn"] = false,
				["EnableS"] = false,
				["EnableG"] = false,
				["IgnoreList"] = {
				},
				["ManaLimit"] = 0,
				["AddList"] = {
				},
				["Reminder"] = true,
				["MAGE"] = true,
				["SHAMAN"] = true,
				["DEATHKNIGHT"] = true,
				["TANK"] = false,
				["WPET"] = false,
				["SelfOnly"] = false,
				["HEALER"] = false,
				["PRIEST"] = true,
				["DKPET"] = false,
				["COut"] = true,
				["HPET"] = false,
				["SelfNot"] = false,
				["WARLOCK"] = true,
				["OH"] = false,
				["ROGUE"] = true,
				["DRUID"] = true,
				["RH"] = false,
				["DAMAGER"] = false,
			},
			["Demon Armor"] = {
				["EnableG"] = false,
				["ManaLimit"] = 0,
				["RBTime"] = 0,
				["MH"] = false,
				["CIn"] = false,
				["COut"] = true,
				["EnableS"] = false,
				["SelfNot"] = false,
				["IgnoreList"] = {
				},
				["SelfOnly"] = false,
				["AddList"] = {
				},
				["Reminder"] = true,
				["RH"] = false,
				["OH"] = false,
			},
			["SelfFirst"] = false,
		},
		["Order"] = {
			"Demon Armor", -- [1]
			"Unending Breath", -- [2]
			"Life Tap", -- [3]
			"Soulstone", -- [4]
			"Create Soulstone", -- [5]
			"Create Healthstone", -- [6]
		},
	}, -- [1]
}
