
AsheylaLib_Settings = {
	["Default"] = {
		["DoTimer"] = {
			["userAnchors"] = {
				["DoTimer Anchor"] = {
					["default"] = true,
				},
			},
			["updatedSettingsMouseover5.0"] = true,
			["updatedSettings4.3"] = true,
			["partyBuffs"] = {
				[" spirit"] = 1,
				["soulstone"] = 1,
				["shadow protection"] = 1,
				["^potion"] = 1,
				["^elixir"] = 1,
				["fortitude"] = 1,
				["arcane"] = 1,
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
					["barFontHeight"] = 10,
					["barReversed"] = true,
					["barGrow"] = false,
					["barRightText"] = "Timer Name",
					["barMajorLength"] = 150,
				},
				["Cooldowns Timer"] = {
					["barGrow"] = false,
					["finalColor"] = {
						["b"] = 0.2156862745098039,
						["g"] = 0.9019607843137255,
						["r"] = 0.5254901960784314,
					},
					["barFlipIcon"] = false,
					["barTexture"] = "Banto-V",
					["barOrientation"] = "vertical",
					["barReversed"] = false,
					["startColor"] = {
						["b"] = 0.3019607843137255,
						["g"] = 0.2274509803921569,
						["r"] = 0.9019607843137255,
					},
					["barMinorLength"] = 30,
					["barMajorLength"] = 85,
				},
				["DoTimer Timer"] = {
				},
				["Debuff Timer"] = {
					["barLeftText"] = "Timer Name",
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
					["standardAlpha"] = 0.4000000059604645,
					["groupDirection"] = "up",
					["displayNames"] = false,
					["anchorPoint"] = "BOTTOMLEFT",
					["mouseoverAlpha"] = 0.6000000238418579,
					["positionX"] = 1158.309875488281,
					["positionY"] = 692.5502624511719,
					["locked"] = true,
					["timerSortMethod"] = "Time Added (A)",
					["overflowDirection"] = "right",
					["groupSortMethod"] = "Time Added (A)",
				},
				["Default Anchor"] = {
					["overflowPoint"] = 20,
					["timerDirection"] = "down",
					["scale"] = 0.800000011920929,
					["timerSpacing"] = 0,
					["moveName"] = true,
					["mouseoverAlpha"] = 1,
					["anchorPoint"] = "TOPLEFT",
					["displayNames"] = true,
					["relativePoint"] = "BOTTOMLEFT",
					["groupSpacing"] = 5,
					["expectedScale"] = 0.6399999856948853,
					["combatAlpha"] = 0.800000011920929,
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
					["positionY"] = 1007.93603515625,
					["positionX"] = 1894.970275878906,
					["defaultTimerSetting"] = "DoTimer Timer",
				},
				["PlayerAuras Anchor"] = {
					["overflowPoint"] = 5,
					["expectedScale"] = 0.6399999856948853,
					["defaultTimerSetting"] = "PlayerAuras Timer",
					["interactable"] = true,
					["anchorPoint"] = "BOTTOMRIGHT",
					["positionY"] = 695.1258239746094,
					["locked"] = true,
					["groupSortMethod"] = "Time Added (A)",
					["combatAlpha"] = 0.800000011920929,
					["displayNames"] = false,
					["groupDirection"] = "up",
					["positionX"] = 975.7052612304688,
					["timerDirection"] = "up",
					["standardAlpha"] = 0.4000000059604645,
					["timerSortMethod"] = "Time Added (A)",
					["overflowDirection"] = "left",
					["mouseoverAlpha"] = 0.6000000238418579,
				},
				["Cooldowns Anchor"] = {
					["overflowPoint"] = 0,
					["expectedScale"] = 0.6399999856948853,
					["timerDirection"] = "right",
					["defaultTimerSetting"] = "Cooldowns Timer",
					["scale"] = 1,
					["timerSpacing"] = 5,
					["centering"] = "horizontal",
					["displayNames"] = false,
					["anchorPoint"] = "BOTTOM",
					["groupDirection"] = "right",
					["positionX"] = 1063.472961425781,
					["maxNumGroups"] = 1,
					["locked"] = true,
					["timerSortMethod"] = "Time Added (A)",
					["overflowDirection"] = "up",
					["positionY"] = 756.5539474487305,
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
			["userAnchors-Debuffs-pet"] = {
				["PetAuras Anchor"] = {
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
			["updatedSettings4.3.3"] = true,
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
			["blizzBuffs"] = true,
			["updatedSettings4.3"] = true,
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
