
AsheylaLib_Settings = {
	["Default"] = {
		["DoTimer"] = {
			["userAnchors"] = {
				["DoTimer Anchor"] = {
					["default"] = true,
				},
			},
			["keybindings"] = {
				["Timer"] = {
					["Remove"] = "2",
					["Announce"] = "1",
					["Block"] = "s-2",
				},
			},
			["mouseoverFadeTime"] = 0.25,
			["updatedSettingsMouseover5.0"] = true,
			["sortTarget"] = true,
			["partyBuffs"] = {
				[" spirit"] = 1,
				["soulstone"] = 1,
				["shadow protection"] = 1,
				["thorns"] = 1,
				["blessing of"] = 1,
				["fortitude"] = 1,
				["^elixir"] = 1,
				["shout"] = 1,
				["of the wild"] = 1,
				["arcane"] = 1,
				["^potion"] = 1,
			},
			["updatedSettings4.3"] = true,
		},
		["TimerLib"] = {
			["timerSettings"] = {
				["Default Timer"] = {
					["barTexture"] = "Banto",
				},
				["PlayerAuras Timer"] = {
					["barLeftText"] = "Time Remaining",
					["fadeInLength"] = 0,
					["barFlipIcon"] = true,
					["timeFormat"] = "letters",
					["barMinorLength"] = 14,
					["barShowIcon"] = true,
					["clickable"] = true,
					["barFontHeight"] = 10,
					["barMajorLength"] = 150,
					["barGrow"] = false,
					["barRightText"] = "Timer Name",
					["barReversed"] = true,
				},
				["Cooldowns Timer"] = {
					["barGrow"] = false,
					["finalColor"] = {
						["r"] = 0.5254901960784314,
						["g"] = 0.9019607843137255,
						["b"] = 0.2156862745098039,
					},
					["barFlipIcon"] = false,
					["barTexture"] = "Banto-V",
					["barOrientation"] = "vertical",
					["barReversed"] = false,
					["barScaling"] = "exponential",
					["alpha"] = 0.5,
					["barMajorLength"] = 85,
					["barMinorLength"] = 30,
					["startColor"] = {
						["r"] = 0.9019607843137255,
						["g"] = 0.2274509803921569,
						["b"] = 0.3019607843137255,
					},
				},
				["DoTimer Timer"] = {
				},
				["Debuff Timer"] = {
					["barLeftText"] = "Timer Name",
					["clickable"] = true,
					["barFlipIcon"] = false,
					["reference"] = "PlayerAuras Timer",
					["barRightText"] = "Time Remaining",
					["barReversed"] = false,
				},
			},
			["anchorSettings"] = {
				["DoTimer Mouseover"] = {
					["positionX"] = 25,
					["positionY"] = -10,
				},
				["Cooldowns Anchor"] = {
					["overflowPoint"] = 0,
					["timerDirection"] = "right",
					["defaultTimerSetting"] = "Cooldowns Timer",
					["scale"] = 1,
					["timerSpacing"] = 3,
					["centering"] = "horizontal",
					["anchorPoint"] = "TOP",
					["positionY"] = -274.3189491679331,
					["relativePoint"] = "TOPLEFT",
					["locked"] = true,
					["maxNumGroups"] = 1,
					["groupDirection"] = "right",
					["positionX"] = 969.9798538039033,
					["interactable"] = true,
					["expectedScale"] = 0.6399999856948853,
					["timerSortMethod"] = "Time Added (A)",
					["overflowDirection"] = "down",
					["displayNames"] = false,
				},
				["Default Anchor"] = {
					["overflowPoint"] = 20,
					["standardAlpha"] = 0.800000011920929,
					["timerDirection"] = "down",
					["combatAlpha"] = 0.800000011920929,
					["scale"] = 0.800000011920929,
					["timerSpacing"] = 0,
					["positionY"] = 974.9999084472656,
					["displayNames"] = true,
					["anchorPoint"] = "TOPLEFT",
					["mouseoverAlpha"] = 1,
					["positionX"] = 793.1284790039062,
					["relativePoint"] = "BOTTOMLEFT",
					["groupSpacing"] = 5,
					["expectedScale"] = 0.6399999856948853,
					["overflowDirection"] = "right",
					["moveName"] = true,
				},
				["PlayerAuras Anchor"] = {
					["overflowPoint"] = 5,
					["expectedScale"] = 0.6399999856948853,
					["defaultTimerSetting"] = "PlayerAuras Timer",
					["combatAlpha"] = 0.800000011920929,
					["anchorPoint"] = "BOTTOMRIGHT",
					["positionY"] = 766.5512611592885,
					["locked"] = true,
					["groupSortMethod"] = "Time Added (A)",
					["interactable"] = false,
					["timerDirection"] = "up",
					["groupDirection"] = "up",
					["positionX"] = 827.6255829905507,
					["mouseoverAlpha"] = 0.6000000238418579,
					["displayNames"] = false,
					["timerSortMethod"] = "Time Added (A)",
					["overflowDirection"] = "left",
					["standardAlpha"] = 0.4000000059604645,
				},
				["DoTimer Anchor"] = {
					["positionY"] = 1011.38427734375,
					["positionX"] = 1664.736389160156,
					["defaultTimerSetting"] = "DoTimer Timer",
				},
				["Notifications Anchor"] = {
					["locked"] = true,
					["positionY"] = 499.9999694824219,
					["positionX"] = 565.4808959960938,
					["expectedScale"] = 0.6399999856948853,
				},
				["Debuffs"] = {
					["overflowPoint"] = 5,
					["timerDirection"] = "up",
					["defaultTimerSetting"] = "Debuff Timer",
					["interactable"] = false,
					["groupSortMethod"] = "Time Added (A)",
					["mouseoverAlpha"] = 0.6000000238418579,
					["groupDirection"] = "up",
					["anchorPoint"] = "BOTTOMLEFT",
					["displayNames"] = false,
					["positionX"] = 1156.585266113281,
					["positionY"] = 729.8779602050781,
					["locked"] = true,
					["timerSortMethod"] = "Time Added (A)",
					["overflowDirection"] = "right",
					["standardAlpha"] = 0.4000000059604645,
				},
			},
		},
		["Cooldowns"] = {
			["keybindings"] = {
				["Timer"] = {
					["Remove"] = "2",
					["Announce"] = "1",
					["Block"] = "s-2",
				},
			},
			["userAnchors"] = {
				["Cooldowns Anchor"] = {
					["timerSettings"] = {
					},
					["timers"] = {
					},
					["externalLoc"] = false,
					["default"] = true,
				},
			},
			["updatedSettings4.3"] = true,
			["minCooldown"] = 2,
			["maxCooldown"] = 0,
		},
		["VersionCommunication"] = {
		},
		["Notifications"] = {
			["updatedSettings4.3.1"] = true,
		},
		["PlayerAuras"] = {
			["userAnchors-Buffs"] = {
				["PlayerAuras Anchor"] = {
					["default"] = true,
				},
			},
			["userAnchors-Buffs-pet"] = {
				["PetAuras Anchor"] = {
					["timers"] = {
					},
					["default"] = true,
					["timerSettings"] = {
					},
				},
			},
			["userAnchors-Buffs-target"] = {
				["TargetAuras Anchor"] = {
					["timers"] = {
					},
					["default"] = true,
					["timerSettings"] = {
					},
				},
			},
			["userAnchors-Debuffs-target"] = {
				["TargetAuras Anchor"] = {
					["timers"] = {
					},
					["default"] = true,
					["timerSettings"] = {
					},
				},
			},
			["userAnchors-Debuffs-pet"] = {
				["PetAuras Anchor"] = {
					["timers"] = {
					},
					["default"] = true,
					["timerSettings"] = {
					},
				},
			},
			["userAnchors-Debuffs"] = {
				["PlayerAuras Anchor"] = {
					["timerSettings"] = {
					},
					["timers"] = {
					},
				},
				["Debuffs"] = {
					["default"] = 1,
				},
			},
			["userAnchors-Buffs-focus"] = {
				["FocusAuras Anchor"] = {
					["timers"] = {
					},
					["default"] = true,
					["timerSettings"] = {
					},
				},
			},
			["whiteList-Buffs"] = false,
			["keybindings"] = {
				["Timer"] = {
					["Remove"] = "2",
					["Announce"] = "1",
					["Block"] = "s-2",
				},
			},
			["userAnchors-Debuffs-focus"] = {
				["FocusAuras Anchor"] = {
					["timers"] = {
					},
					["default"] = true,
					["timerSettings"] = {
					},
				},
			},
			["blizzBuffs"] = true,
			["updatedSettings4.3"] = true,
			["updatedSettings4.3.3"] = true,
		},
	},
	["simpleMode"] = false,
}
