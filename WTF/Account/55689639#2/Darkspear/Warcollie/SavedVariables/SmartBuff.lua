
SMARTBUFF_Options = {
	["ToggleAutoCombat"] = false,
	["AutoSwitchTemplateInst"] = false,
	["BuffTarget"] = false,
	["SplashY"] = -100,
	["MMCPosX"] = -51.6744384765625,
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
	["ToggleMsgWarning"] = false,
	["UpgradeToDualSpec"] = true,
	["OldWheelDown"] = "CAMERAZOOMOUT",
	["ColSplashFont"] = {
		["r"] = 1,
		["g"] = 1,
		["b"] = 1,
	},
	["LastTemplate"] = "Arena",
	["UISync"] = true,
	["AddList"] = {
	},
	["ShowMiniGrp"] = false,
	["BlacklistTimer"] = 5,
	["LinkSelfBuffCheck"] = true,
	["MinCharges"] = 3,
	["Toggle"] = true,
	["HideMmButton"] = true,
	["OldWheelUp"] = "CAMERAZOOMIN",
	["BuffInCities"] = true,
	["MMCPosY"] = -68.630126953125,
	["LinkGrpBuffCheck"] = true,
	["Debug"] = false,
	["CompMode"] = false,
	["SplashDuration"] = 2,
	["ToggleMsgError"] = false,
	["CurrentFont"] = 9,
	["ToggleAuto"] = true,
	["InShapeshift"] = true,
	["CheckCharges"] = true,
	["HideSAButton"] = true,
	["ScrollWheelDown"] = true,
	["ToggleAutoChat"] = false,
	["ToggleAutoSound"] = false,
	["ScrollWheelUp"] = false,
	["InCombat"] = false,
}
SMARTBUFF_Buffs = {
	{
		["Party"] = {
			["Frost Presence"] = {
				["IgnoreList"] = {
				},
				["ManaLimit"] = 0,
				["RBTime"] = 0,
				["MH"] = false,
				["CIn"] = false,
				["COut"] = true,
				["EnableS"] = true,
				["SelfNot"] = false,
				["EnableG"] = false,
				["OH"] = false,
				["AddList"] = {
				},
				["Reminder"] = true,
				["RH"] = false,
				["SelfOnly"] = false,
			},
			["SelfFirst"] = true,
			["GrpBuffSize"] = 4,
		},
		["Solo"] = {
			["Frost Presence"] = {
				["SelfOnly"] = false,
				["OH"] = false,
				["RBTime"] = 0,
				["MH"] = false,
				["CIn"] = false,
				["COut"] = true,
				["EnableS"] = true,
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
			["SelfFirst"] = true,
			["GrpBuffSize"] = 4,
		},
		["Order"] = {
			"Frost Presence", -- [1]
			"Raise Dead", -- [2]
		},
		["Raid"] = {
			["Frost Presence"] = {
				["IgnoreList"] = {
				},
				["ManaLimit"] = 0,
				["RBTime"] = 0,
				["MH"] = false,
				["CIn"] = false,
				["COut"] = true,
				["EnableS"] = true,
				["SelfNot"] = false,
				["EnableG"] = false,
				["OH"] = false,
				["AddList"] = {
				},
				["Reminder"] = true,
				["RH"] = false,
				["SelfOnly"] = false,
			},
			["SelfFirst"] = true,
			["GrpBuffSize"] = 4,
		},
		["Arena"] = {
			["Raise Dead"] = {
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
			["Frost Presence"] = {
				["IgnoreList"] = {
				},
				["ManaLimit"] = 0,
				["RBTime"] = 0,
				["MH"] = false,
				["CIn"] = false,
				["COut"] = true,
				["EnableS"] = true,
				["SelfNot"] = false,
				["EnableG"] = false,
				["OH"] = false,
				["AddList"] = {
				},
				["Reminder"] = true,
				["RH"] = false,
				["SelfOnly"] = false,
			},
			["SelfFirst"] = true,
			["GrpBuffSize"] = 4,
		},
		["Battleground"] = {
			["Frost Presence"] = {
				["IgnoreList"] = {
				},
				["ManaLimit"] = 0,
				["RBTime"] = 0,
				["MH"] = false,
				["CIn"] = false,
				["COut"] = true,
				["EnableS"] = true,
				["SelfNot"] = false,
				["EnableG"] = false,
				["OH"] = false,
				["AddList"] = {
				},
				["Reminder"] = true,
				["RH"] = false,
				["SelfOnly"] = false,
			},
			["SelfFirst"] = true,
			["GrpBuffSize"] = 4,
		},
	}, -- [1]
}
