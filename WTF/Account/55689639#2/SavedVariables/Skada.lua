
SkadaDB = {
	["profileKeys"] = {
		["Battlecollie - Ysondre"] = "Default",
	},
	["profiles"] = {
		["Default"] = {
			["modules"] = {
				["threatsound"] = true,
				["notankwarnings"] = true,
				["threatraw"] = false,
				["threatflash"] = true,
				["threatsoundname"] = "Fel Nova",
			},
			["windows"] = {
				{
					["point"] = "BOTTOMLEFT",
					["scale"] = 1,
					["barcolor"] = {
						["r"] = 0.4235294117647059,
						["g"] = 0.4235294117647059,
						["b"] = 0.4235294117647059,
					},
					["returnaftercombat"] = true,
					["modeincombat"] = "Threat",
					["x"] = 0,
					["mode"] = "Absorbs and healing",
					["set"] = "total",
					["bartexture"] = "Minimalist",
					["barwidth"] = 325,
					["barheight"] = 16,
					["y"] = 164.1379699707031,
					["barfont"] = "Friz Quadrata TT",
					["title"] = {
						["font"] = "Friz Quadrata TT",
						["borderthickness"] = 0,
						["color"] = {
							["a"] = 0.3600000143051147,
						},
						["menubutton"] = false,
						["texture"] = "Armory",
					},
					["baraltcolor"] = {
						["r"] = 0.7529411764705882,
						["g"] = 0,
						["b"] = 0.07450980392156863,
					},
					["reversegrowth"] = true,
					["background"] = {
						["borderthickness"] = 18.5,
						["height"] = 119,
						["bordertexture"] = "Blizzard Tooltip",
						["margin"] = 7,
						["texture"] = "Blizzard Dialog Background",
					},
					["barfontsize"] = 12,
				}, -- [1]
			},
			["feed"] = "Damage: Raid DPS",
			["columns"] = {
				["Threat_TPS"] = true,
			},
			["hidedisables"] = false,
			["setstokeep"] = 30,
		},
	},
}
