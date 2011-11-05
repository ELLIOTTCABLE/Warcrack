
AsheylaLib_Settings = {
	["Default"] = {
		["DoTimer"] = {
			["userAnchors"] = {
				["DoTimer Anchor"] = {
					["default"] = true,
				},
			},
			["updatedSettings4.3"] = true,
			["mouseoverFadeTime"] = 0.25,
			["updatedSettingsMouseover5.0"] = true,
			["sortTarget"] = true,
			["partyBuffs"] = {
				[" spirit"] = 1,
				["soulstone"] = 1,
				["shadow protection"] = 1,
				["^potion"] = 1,
				["arcane"] = 1,
				["fortitude"] = 1,
				["^elixir"] = 1,
				["of the wild"] = 1,
				["shout"] = 1,
				["blessing of"] = 1,
				["thorns"] = 1,
			},
			["keybindings"] = {
				["Timer"] = {
					["Remove"] = "2",
					["Announce"] = "1",
					["Block"] = "s-2",
				},
			},
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
					["barReversed"] = true,
					["barGrow"] = false,
					["barRightText"] = "Timer Name",
					["barMajorLength"] = 150,
				},
				["Cooldowns Timer"] = {
					["finalColor"] = {
						["b"] = 0.2156862745098039,
						["g"] = 0.9019607843137255,
						["r"] = 0.5254901960784314,
					},
					["barFlipIcon"] = true,
					["barTexture"] = "Banto-V",
					["barOrientation"] = "vertical",
					["barReversed"] = true,
					["startColor"] = {
						["b"] = 0.3019607843137255,
						["g"] = 0.2274509803921569,
						["r"] = 0.9019607843137255,
					},
					["barMinorLength"] = 30,
					["barMajorLength"] = 85,
					["alpha"] = 0.5,
				},
				["DoTimer Timer"] = {
				},
				["Debuff Timer"] = {
					["barLeftText"] = "Timer Name",
					["clickable"] = true,
					["barFlipIcon"] = false,
					["barRightText"] = "Time Remaining",
					["reference"] = "PlayerAuras Timer",
					["barReversed"] = false,
				},
			},
			["anchorSettings"] = {
				["DoTimer Mouseover"] = {
					["positionX"] = 25,
					["positionY"] = -10,
				},
				["Debuffs"] = {
					["overflowPoint"] = 5,
					["timerDirection"] = "up",
					["defaultTimerSetting"] = "Debuff Timer",
					["interactable"] = false,
					["standardAlpha"] = 0.4000000059604645,
					["groupDirection"] = "up",
					["displayNames"] = false,
					["anchorPoint"] = "BOTTOMLEFT",
					["mouseoverAlpha"] = 0.6000000238418579,
					["positionX"] = 1156.585266113281,
					["positionY"] = 729.8779602050781,
					["locked"] = true,
					["timerSortMethod"] = "Time Added (A)",
					["overflowDirection"] = "right",
					["groupSortMethod"] = "Time Added (A)",
				},
				["Default Anchor"] = {
					["overflowPoint"] = 20,
					["moveName"] = true,
					["timerDirection"] = "down",
					["scale"] = 0.800000011920929,
					["combatAlpha"] = 0.800000011920929,
					["timerSpacing"] = 0,
					["expectedScale"] = 0.6399999856948853,
					["groupSpacing"] = 5,
					["anchorPoint"] = "TOPLEFT",
					["positionY"] = 974.9999084472656,
					["positionX"] = 793.1284790039062,
					["relativePoint"] = "BOTTOMLEFT",
					["mouseoverAlpha"] = 1,
					["displayNames"] = true,
					["overflowDirection"] = "right",
					["standardAlpha"] = 0.800000011920929,
				},
				["Notifications Anchor"] = {
					["locked"] = true,
					["positionY"] = 499.9999694824219,
					["positionX"] = 565.4808959960938,
					["expectedScale"] = 0.6399999856948853,
				},
				["DoTimer Anchor"] = {
					["positionY"] = 1011.38427734375,
					["positionX"] = 1664.736389160156,
					["defaultTimerSetting"] = "DoTimer Timer",
				},
				["PlayerAuras Anchor"] = {
					["overflowPoint"] = 5,
					["expectedScale"] = 0.6399999856948853,
					["defaultTimerSetting"] = "PlayerAuras Timer",
					["combatAlpha"] = 0.800000011920929,
					["anchorPoint"] = "BOTTOMRIGHT",
					["positionY"] = 727.8844299316406,
					["locked"] = true,
					["groupSortMethod"] = "Time Added (A)",
					["standardAlpha"] = 0.4000000059604645,
					["timerDirection"] = "up",
					["groupDirection"] = "up",
					["positionX"] = 978.2921752929688,
					["mouseoverAlpha"] = 0.6000000238418579,
					["displayNames"] = false,
					["timerSortMethod"] = "Time Added (A)",
					["overflowDirection"] = "left",
					["interactable"] = false,
				},
				["Cooldowns Anchor"] = {
					["overflowPoint"] = 0,
					["timerDirection"] = "right",
					["defaultTimerSetting"] = "Cooldowns Timer",
					["scale"] = 1,
					["timerSpacing"] = 3,
					["centering"] = "horizontal",
					["anchorPoint"] = "TOP",
					["positionY"] = -879.6521682739258,
					["relativePoint"] = "TOPLEFT",
					["locked"] = true,
					["maxNumGroups"] = 1,
					["groupDirection"] = "right",
					["positionX"] = 1068.646728515625,
					["displayNames"] = false,
					["expectedScale"] = 0.6399999856948853,
					["timerSortMethod"] = "Time Added (A)",
					["overflowDirection"] = "down",
					["interactable"] = false,
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
					["default"] = true,
					["timers"] = {
					},
					["timerSettings"] = {
					},
					["externalLoc"] = false,
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
			["updatedSettings4.3.3"] = true,
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
			["updatedSettings4.3"] = true,
			["blizzBuffs"] = true,
			["userAnchors-Debuffs-focus"] = {
				["FocusAuras Anchor"] = {
					["timers"] = {
					},
					["default"] = true,
					["timerSettings"] = {
					},
				},
			},
			["keybindings"] = {
				["Timer"] = {
					["Remove"] = "2",
					["Announce"] = "1",
					["Block"] = "s-2",
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
		},
	},
	["simpleMode"] = false,
}
