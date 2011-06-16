
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
		["r"] = 1,
		["g"] = 1,
		["b"] = 1,
	},
	["UpgradeToDualSpec"] = true,
	["OldWheelDown"] = "CAMERAZOOMOUT",
	["LastTemplate"] = "Solo",
	["LinkSelfBuffCheck"] = true,
	["UISync"] = true,
	["ToggleAutoSound"] = false,
	["ShowMiniGrp"] = false,
	["BlacklistTimer"] = 5,
	["ToggleMsgWarning"] = false,
	["MinCharges"] = 3,
	["AddList"] = {
	},
	["HideMmButton"] = false,
	["OldWheelUp"] = "CAMERAZOOMIN",
	["BuffInCities"] = true,
	["MMCPosY"] = -149.3007339749726,
	["LinkGrpBuffCheck"] = true,
	["Debug"] = false,
	["CompMode"] = false,
	["SplashDuration"] = 2,
	["ToggleMsgError"] = false,
	["CurrentFont"] = 9,
	["ToggleAuto"] = true,
	["InShapeshift"] = true,
	["CheckCharges"] = true,
	["HideSAButton"] = false,
	["ScrollWheelDown"] = true,
	["ToggleAutoChat"] = false,
	["Toggle"] = true,
	["ScrollWheelUp"] = false,
	["InCombat"] = false,
}
SMARTBUFF_Buffs = {
	{
		["Solo"] = {
			["Demon Armor"] = {
				["SelfOnly"] = false,
				["OH"] = false,
				["RBTime"] = 0,
				["MH"] = false,
				["CIn"] = false,
				["COut"] = true,
				["EnableS"] = false,
				["SelfNot"] = false,
				["IgnoreList"] = {
				},
				["ManaLimit"] = 0,
				["AddList"] = {
				},
				["Reminder"] = true,
				["RH"] = false,
				["EnableG"] = false,
			},
			["Create Healthstone"] = {
				["SelfOnly"] = false,
				["OH"] = false,
				["RBTime"] = 0,
				["MH"] = false,
				["CIn"] = false,
				["COut"] = true,
				["EnableS"] = false,
				["SelfNot"] = false,
				["IgnoreList"] = {
				},
				["ManaLimit"] = 0,
				["AddList"] = {
				},
				["Reminder"] = true,
				["RH"] = false,
				["EnableG"] = false,
			},
			["SelfFirst"] = false,
			["Soulstone"] = {
				["HUNTER"] = false,
				["WARRIOR"] = false,
				["PALADIN"] = false,
				["RBTime"] = 0,
				["MH"] = false,
				["CIn"] = false,
				["EnableS"] = false,
				["DAMAGER"] = false,
				["IgnoreList"] = {
				},
				["ManaLimit"] = 0,
				["AddList"] = {
				},
				["Reminder"] = true,
				["MAGE"] = false,
				["DRUID"] = false,
				["DEATHKNIGHT"] = false,
				["TANK"] = false,
				["ROGUE"] = false,
				["OH"] = false,
				["DKPET"] = false,
				["COut"] = true,
				["HEALER"] = false,
				["PRIEST"] = false,
				["HPET"] = false,
				["SelfNot"] = false,
				["WARLOCK"] = false,
				["SelfOnly"] = false,
				["WPET"] = false,
				["SHAMAN"] = false,
				["RH"] = false,
				["EnableG"] = false,
			},
			["Life Tap"] = {
				["SelfOnly"] = false,
				["OH"] = false,
				["RBTime"] = 0,
				["MH"] = false,
				["CIn"] = false,
				["COut"] = true,
				["EnableS"] = false,
				["SelfNot"] = false,
				["IgnoreList"] = {
				},
				["ManaLimit"] = 0,
				["AddList"] = {
				},
				["Reminder"] = true,
				["RH"] = false,
				["EnableG"] = false,
			},
			["Unending Breath"] = {
				["HUNTER"] = true,
				["WARRIOR"] = true,
				["PALADIN"] = true,
				["RBTime"] = 0,
				["MH"] = false,
				["CIn"] = false,
				["EnableS"] = false,
				["DAMAGER"] = false,
				["IgnoreList"] = {
				},
				["ManaLimit"] = 0,
				["AddList"] = {
				},
				["Reminder"] = true,
				["MAGE"] = true,
				["DRUID"] = true,
				["DEATHKNIGHT"] = true,
				["TANK"] = false,
				["ROGUE"] = true,
				["OH"] = false,
				["DKPET"] = false,
				["COut"] = true,
				["HEALER"] = false,
				["PRIEST"] = true,
				["HPET"] = false,
				["SelfNot"] = false,
				["WARLOCK"] = true,
				["SelfOnly"] = false,
				["WPET"] = false,
				["SHAMAN"] = true,
				["RH"] = false,
				["EnableG"] = false,
			},
			["Create Soulstone"] = {
				["SelfOnly"] = false,
				["OH"] = false,
				["RBTime"] = 0,
				["MH"] = false,
				["CIn"] = false,
				["COut"] = true,
				["EnableS"] = false,
				["SelfNot"] = false,
				["IgnoreList"] = {
				},
				["ManaLimit"] = 0,
				["AddList"] = {
				},
				["Reminder"] = true,
				["RH"] = false,
				["EnableG"] = false,
			},
			["GrpBuffSize"] = 4,
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
