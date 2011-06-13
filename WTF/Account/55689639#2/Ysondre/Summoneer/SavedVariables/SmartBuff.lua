
SMARTBUFF_Options = {
	["ToggleAutoCombat"] = false,
	["AutoSwitchTemplateInst"] = false,
	["BuffTarget"] = false,
	["SplashY"] = -100,
	["MMCPosX"] = -39.0754474842573,
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
	["AddList"] = {
	},
	["UpgradeToDualSpec"] = true,
	["OldWheelDown"] = "CAMERAZOOMOUT",
	["Debug"] = false,
	["ColSplashFont"] = {
		["b"] = 1,
		["g"] = 1,
		["r"] = 1,
	},
	["ToggleMsgError"] = false,
	["OldWheelUp"] = "CAMERAZOOMIN",
	["ShowMiniGrp"] = false,
	["BlacklistTimer"] = 5,
	["LastTemplate"] = "Solo",
	["MinCharges"] = 3,
	["Toggle"] = true,
	["HideMmButton"] = false,
	["ToggleAutoSound"] = false,
	["BuffInCities"] = true,
	["MMCPosY"] = -104.2519173384316,
	["LinkSelfBuffCheck"] = true,
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
	["UISync"] = true,
	["ScrollWheelUp"] = false,
	["InCombat"] = false,
}
SMARTBUFF_Buffs = {
	{
		["Solo"] = {
			["Create Soulstone"] = {
				["IgnoreList"] = {
				},
				["ManaLimit"] = 0,
				["RBTime"] = 0,
				["MH"] = false,
				["CIn"] = false,
				["COut"] = true,
				["EnableS"] = false,
				["SelfNot"] = false,
				["EnableG"] = false,
				["OH"] = false,
				["AddList"] = {
				},
				["Reminder"] = true,
				["RH"] = false,
				["SelfOnly"] = false,
			},
			["Create Healthstone"] = {
				["IgnoreList"] = {
				},
				["ManaLimit"] = 0,
				["RBTime"] = 0,
				["MH"] = false,
				["CIn"] = false,
				["COut"] = true,
				["EnableS"] = false,
				["SelfNot"] = false,
				["EnableG"] = false,
				["OH"] = false,
				["AddList"] = {
				},
				["Reminder"] = true,
				["RH"] = false,
				["SelfOnly"] = false,
			},
			["Soulstone"] = {
				["HUNTER"] = false,
				["WARRIOR"] = false,
				["PALADIN"] = false,
				["RBTime"] = 0,
				["MH"] = false,
				["CIn"] = false,
				["EnableS"] = false,
				["IgnoreList"] = {
				},
				["EnableG"] = false,
				["ManaLimit"] = 0,
				["AddList"] = {
				},
				["Reminder"] = true,
				["DAMAGER"] = false,
				["HEALER"] = false,
				["DEATHKNIGHT"] = false,
				["TANK"] = false,
				["SHAMAN"] = false,
				["WPET"] = false,
				["ROGUE"] = false,
				["PRIEST"] = false,
				["DKPET"] = false,
				["COut"] = true,
				["HPET"] = false,
				["SelfNot"] = false,
				["WARLOCK"] = false,
				["SelfOnly"] = false,
				["DRUID"] = false,
				["MAGE"] = false,
				["RH"] = false,
				["OH"] = false,
			},
			["GrpBuffSize"] = 4,
			["Life Tap"] = {
				["IgnoreList"] = {
				},
				["ManaLimit"] = 0,
				["RBTime"] = 0,
				["MH"] = false,
				["CIn"] = false,
				["COut"] = true,
				["EnableS"] = false,
				["SelfNot"] = false,
				["EnableG"] = false,
				["OH"] = false,
				["AddList"] = {
				},
				["Reminder"] = true,
				["RH"] = false,
				["SelfOnly"] = false,
			},
			["Unending Breath"] = {
				["HUNTER"] = true,
				["WARRIOR"] = true,
				["PALADIN"] = true,
				["RBTime"] = 0,
				["MH"] = false,
				["CIn"] = false,
				["EnableS"] = false,
				["IgnoreList"] = {
				},
				["EnableG"] = false,
				["ManaLimit"] = 0,
				["AddList"] = {
				},
				["Reminder"] = true,
				["DAMAGER"] = false,
				["HEALER"] = false,
				["DEATHKNIGHT"] = true,
				["TANK"] = false,
				["SHAMAN"] = true,
				["WPET"] = false,
				["ROGUE"] = true,
				["PRIEST"] = true,
				["DKPET"] = false,
				["COut"] = true,
				["HPET"] = false,
				["SelfNot"] = false,
				["WARLOCK"] = true,
				["SelfOnly"] = false,
				["DRUID"] = true,
				["MAGE"] = true,
				["RH"] = false,
				["OH"] = false,
			},
			["SelfFirst"] = false,
			["Demon Armor"] = {
				["IgnoreList"] = {
				},
				["ManaLimit"] = 0,
				["RBTime"] = 0,
				["MH"] = false,
				["CIn"] = false,
				["COut"] = true,
				["EnableS"] = false,
				["SelfNot"] = false,
				["EnableG"] = false,
				["OH"] = false,
				["AddList"] = {
				},
				["Reminder"] = true,
				["RH"] = false,
				["SelfOnly"] = false,
			},
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
