
SMARTBUFF_Options = {
	["ToggleAutoCombat"] = false,
	["AutoSwitchTemplateInst"] = false,
	["BuffTarget"] = false,
	["SplashY"] = -100,
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
	["AddList"] = {
	},
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
			["Battle Stance"] = {
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
			["SelfFirst"] = false,
			["GrpBuffSize"] = 4,
		},
		["Order"] = {
			"Battle Stance", -- [1]
		},
	}, -- [1]
}
