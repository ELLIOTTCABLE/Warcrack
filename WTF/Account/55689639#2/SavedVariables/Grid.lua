
GridDB = {
	["namespaces"] = {
		["GridIndicatorCornerPlus"] = {
		},
		["LibDualSpec-1.0"] = {
		},
		["GridIndicatorText3"] = {
		},
		["GridStatusMana"] = {
		},
		["GridStatusThreat"] = {
		},
		["GridSCP"] = {
			["profiles"] = {
				["Default"] = {
					["pipesDB"] = {
						["pipes"] = {
						},
					},
				},
			},
		},
		["GridIndicatorCornerText"] = {
		},
		["GridStatusCasterBuffs"] = {
			["profiles"] = {
				["Default"] = {
					["spell_name"] = {
						[56038] = "Plaguebolt",
						[50047] = "Broken Bone",
						[54345] = "Withering Strike",
						[6788] = "Weakened Soul",
					},
					["debuff_type"] = {
						[54345] = "M",
					},
					["enemy_npc_debuffs_others"] = {
						["Withered Troll"] = {
							[54345] = "Time between attacks increased by 30%.",
						},
						["Vargul Deathwaker"] = {
							[56038] = "Inflicts 250 Shadow damage every 1 sec.",
						},
						["Vargul Blighthound"] = {
							[50047] = "Reduces chance to hit by 10%.",
						},
					},
					["aura_desc"] = {
						[56038] = "Inflicts 250 Shadow damage every 1 sec.",
						[50047] = "Reduces chance to hit by 10%.",
						[54345] = "Time between attacks increased by 30%.",
						[6788] = "Cannot be affected by Power Word: Shield.",
					},
				},
			},
		},
		["GridStatusRange"] = {
		},
		["GridStatus"] = {
			["profiles"] = {
				["Default"] = {
					["colors"] = {
						["HUNTER"] = {
							["r"] = 0.67,
							["g"] = 0.83,
							["b"] = 0.45,
						},
						["SHAMAN"] = {
							["r"] = 0,
							["g"] = 0.44,
							["b"] = 0.87,
						},
						["MAGE"] = {
							["r"] = 0.41,
							["g"] = 0.8,
							["b"] = 0.9399999999999999,
						},
						["DRUID"] = {
							["r"] = 1,
							["g"] = 0.49,
							["b"] = 0.04,
						},
						["DEATHKNIGHT"] = {
							["r"] = 0.77,
							["g"] = 0.12,
							["b"] = 0.23,
						},
						["PRIEST"] = {
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["WARLOCK"] = {
							["r"] = 0.58,
							["g"] = 0.51,
							["b"] = 0.79,
						},
						["WARRIOR"] = {
							["r"] = 0.78,
							["g"] = 0.61,
							["b"] = 0.43,
						},
						["PALADIN"] = {
							["r"] = 0.96,
							["g"] = 0.55,
							["b"] = 0.73,
						},
						["ROGUE"] = {
							["r"] = 1,
							["g"] = 0.96,
							["b"] = 0.41,
						},
					},
				},
			},
		},
		["GridStatusAggro"] = {
		},
		["GridStatusHeals"] = {
		},
		["GridStatusUnitTarget"] = {
		},
		["GridLayout"] = {
			["profiles"] = {
				["Default"] = {
					["hideTab"] = true,
					["anchorRel"] = "TOPLEFT",
					["layouts"] = {
						["party"] = "By Group 5 w/Pets",
						["solo"] = "By Group 5 w/Pets",
					},
					["FrameLock"] = true,
					["borderTexture"] = "None",
					["PosY"] = 0,
					["layout"] = "By Group 5 w/Pets",
					["Spacing"] = 0,
					["PosX"] = 0,
				},
			},
		},
		["GridStatusSpellCast"] = {
		},
		["GridFrame"] = {
			["profiles"] = {
				["Default"] = {
					["fontSize"] = 12,
					["cornerSize"] = 5,
					["showTooltip"] = "Always",
					["enableBarColor"] = true,
					["textlength"] = 13,
					["texture"] = "Armory",
					["frameHeight"] = 38,
					["enableText2"] = true,
					["invertBarColor"] = true,
					["orientation"] = "HORIZONTAL",
					["statusmap"] = {
						["cornerPlusBLtopleft"] = {
						},
						["sidetexttop"] = {
						},
						["sidetextbottom"] = {
						},
						["iconleft"] = {
							["ready_check"] = true,
							["alert_raidicons_player"] = true,
							["dungeonRole"] = true,
						},
						["iconBLcornerleft"] = {
						},
						["iconbottom"] = {
						},
						["sidePlusBcenter"] = {
						},
						["corner1"] = {
							["alert_heals"] = false,
						},
						["cornerPlusBRbottomleft"] = {
							["debuff_curse"] = true,
						},
						["icon"] = {
							["debuff_poison"] = false,
							["debuff_disease"] = false,
							["debuff_curse"] = false,
							["debuff_magic"] = false,
						},
						["iconTRcornerleft"] = {
						},
						["baricon8"] = {
						},
						["cornerPlusTLbottomright"] = {
						},
						["sidePlusBright"] = {
						},
						["iconright"] = {
						},
						["baricon2"] = {
						},
						["iconTLcornerright"] = {
						},
						["baricon5"] = {
						},
						["cornerPlusBLtopright"] = {
						},
						["barcolor"] = {
							["unitShieldLeft"] = false,
						},
						["sidePlusTright"] = {
						},
						["sidePlusLcenter"] = {
						},
						["cornertextbottomleft"] = {
						},
						["iconBRcornerleft"] = {
						},
						["iconTRcornerright"] = {
						},
						["sidePlusLtop"] = {
						},
						["cornertexttopleft"] = {
						},
						["text2"] = {
							["alert_feignDeath"] = false,
							["alert_offline"] = false,
							["debuff_Ghost"] = false,
							["alert_heals"] = true,
							["alert_death"] = false,
							["unit_health"] = true,
						},
						["baricon1"] = {
						},
						["cornerPlusTRbottomleft"] = {
							["alert_pws"] = false,
						},
						["cornerPlusBRtopleft"] = {
							["debuff_poison"] = true,
						},
						["iconTLcornerleft"] = {
						},
						["cornerPlusTRtopleft"] = {
							["alert_pomdur"] = true,
							["alert_pom"] = false,
						},
						["cornerPlusTRbottomright"] = {
							["alert_weakenedsoul"] = false,
						},
						["iconBLcornerright"] = {
						},
						["baricon4"] = {
						},
						["sidetextright"] = {
							["unitShieldLeft"] = true,
						},
						["text"] = {
							["alert_heals"] = false,
						},
						["baricon7"] = {
						},
						["corner4"] = {
							["alert_aggro"] = false,
						},
						["baricon3"] = {
						},
						["cornertextbottomright"] = {
						},
						["sidePlusRcenter"] = {
						},
						["sidePlusRtop"] = {
							["alert_pws"] = true,
						},
						["sidetextleft"] = {
						},
						["sidePlusTcenter"] = {
						},
						["sidePlusRbottom"] = {
							["alert_weakenedsoul"] = true,
						},
						["baricon9"] = {
						},
						["cornerPlusTLtopright"] = {
						},
						["icontop"] = {
						},
						["iconBRcornerright"] = {
						},
						["manabar"] = {
							["unit_mana"] = true,
						},
						["cornerPlusTLbottomleft"] = {
						},
						["baricon6"] = {
						},
						["cornertexttopright"] = {
						},
						["sidePlusLbottom"] = {
						},
						["sidePlusBleft"] = {
						},
						["cornerPlusBLbottomright"] = {
						},
						["sidePlusTleft"] = {
						},
						["cornerPlusBRtopright"] = {
							["debuff_disease"] = true,
						},
						["text3"] = {
						},
						["corner3"] = {
							["debuff_curse"] = false,
							["debuff_poison"] = false,
							["debuff_disease"] = false,
							["debuff_magic"] = false,
							["alert_renew"] = true,
							["buff_Renew"] = false,
						},
						["corner2"] = {
							["debuff_magic"] = true,
						},
					},
					["frameWidth"] = 100,
				},
			},
		},
		["GridStatusThreatColor"] = {
		},
		["GridRoster"] = {
		},
		["GridStatusAuras"] = {
			["profiles"] = {
				["Default"] = {
					["buff_Renew"] = {
						["icon"] = "Interface\\Icons\\Spell_Holy_Renew",
					},
					["buff_PowerWord:Shield"] = {
						["icon"] = "Interface\\Icons\\Spell_Holy_PowerWordShield",
					},
				},
			},
		},
		["GridIndicatorSidePlus"] = {
			["profiles"] = {
				["Default"] = {
					["SidePlusSpace"] = 5,
				},
			},
		},
		["GridMBStatus"] = {
		},
		["GridStatusTarget"] = {
		},
		["GridIndicatorCornerIcons"] = {
		},
		["GridStatusHealth"] = {
			["profiles"] = {
				["Default"] = {
					["unit_healthDeficit"] = {
						["threshold"] = 99,
					},
				},
			},
		},
		["DungeonRole"] = {
			["profiles"] = {
				["Default"] = {
					["dungeonRole"] = {
						["filter"] = {
							["DAMAGER"] = false,
						},
					},
				},
			},
		},
		["PipeStatus"] = {
		},
		["GridIndicatorSideText"] = {
		},
		["GridStatusName"] = {
		},
		["GridStatusVehicle"] = {
		},
		["GridStatusVoiceComm"] = {
		},
		["GridMBFrame"] = {
			["profiles"] = {
				["Default"] = {
					["side"] = "Bottom",
					["size"] = 0.15,
				},
			},
		},
		["GridStatusHots"] = {
			["profiles"] = {
				["Default"] = {
					["alert_pws"] = {
						["threshold2"] = 1,
						["color"] = {
							["g"] = 0.9647058823529412,
							["r"] = 1,
						},
						["color2"] = {
							["g"] = 0.9333333333333333,
						},
						["threshold3"] = 2,
					},
					["alert_weakenedsoul"] = {
						["threshold2"] = 1,
						["color"] = {
							["b"] = 0.1568627450980392,
							["g"] = 0.2980392156862745,
							["r"] = 0.4941176470588236,
						},
						["color2"] = {
							["b"] = 1,
							["g"] = 0,
							["r"] = 0.04705882352941176,
						},
						["color3"] = {
							["b"] = 0.1215686274509804,
							["g"] = 0.5137254901960784,
							["r"] = 0.803921568627451,
						},
						["threshold3"] = 2.5,
					},
					["alert_renew"] = {
						["threshold2"] = 1.5,
						["threshold3"] = 1,
						["totshow"] = false,
					},
				},
			},
		},
		["GridStatusReadyCheck"] = {
		},
		["GridIndicatorIconBar"] = {
		},
		["GridIndicatorSideIcons"] = {
			["profiles"] = {
				["Default"] = {
					["yoffsetLR"] = 0,
					["iconSizeLeft"] = 10,
					["xoffsetLR"] = -4,
				},
			},
		},
		["GridStatusAurasExt"] = {
			["profiles"] = {
				["Default"] = {
					["updateInterval"] = 0.25,
					["magicColors"] = {
						["Disease"] = {
							["a"] = 1,
							["r"] = 0.6,
							["g"] = 0.4,
							["b"] = 0,
						},
						["Poison"] = {
							["a"] = 1,
							["r"] = 0,
							["g"] = 0.6,
							["b"] = 0,
						},
						["Curse"] = {
							["a"] = 1,
							["r"] = 0.8,
							["g"] = 0,
							["b"] = 1,
						},
						["Magic"] = {
							["a"] = 1,
							["r"] = 0.2,
							["g"] = 0.4,
							["b"] = 1,
						},
						["none"] = {
							["a"] = 1,
							["r"] = 0.5,
							["g"] = 0.5,
							["b"] = 0.5,
						},
					},
				},
			},
		},
		["GridStatusShield"] = {
			["profiles"] = {
				["Default"] = {
					["unitShieldLeft"] = {
						["mark2Threshold"] = 1500,
						["mark1Threshold"] = 750,
						["mark2Color"] = {
							["g"] = 0.5882352941176471,
						},
						["color"] = {
							["g"] = 0.9490196078431372,
						},
					},
				},
			},
		},
		["GridStatusRaidIcons"] = {
		},
		["GridBuffIconStatus"] = {
		},
	},
	["profileKeys"] = {
		["Battlecollie - Ysondre"] = "Default",
	},
	["profiles"] = {
		["Default"] = {
			["minimap"] = {
			},
		},
	},
}
