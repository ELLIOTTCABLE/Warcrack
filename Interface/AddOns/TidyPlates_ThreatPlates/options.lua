local TidyPlatesThreat = TidyPlatesThreat
local LibStub = LibStub

-- Shared Media Configs
local Media = LibStub("LibSharedMedia-3.0")
Media:Register("statusbar", "ThreatPlatesBar", [[Interface\Addons\TidyPlates_ThreatPlates\Artwork\TP_BarTexture.tga]])
Media:Register("font", "Accidental Presidency",[[Interface\Addons\TidyPlates_ThreatPlates\Fonts\Accidental Presidency.ttf]])

-- Threat Texture Themes:
ThemeList = {none = "None", default = "Default", bar = "Bar Style"}
EliteList = {default = "Default", skullandcross = "Skull & Crossbones"}
ClassList = {default = "Default", transparent = "Transparent"}
ThreatStyleList = { [1] = "Threat Line", [2] = "Threat Wheel"}
local FullAlign = {
	TOPLEFT = "TOPLEFT",
	TOP = "TOP",
	TOPRIGHT = "TOPRIGHT",
	LEFT = "LEFT",
	CENTER = "CENTER",
	RIGHT = "RIGHT",
	BOTTOMLEFT = "BOTTOMLEFT",
	BOTTOM = "BOTTOM",
	BOTTOMRIGHT = "BOTTOMRIGHT"
}
local AlignH = {LEFT = "LEFT", CENTER = "CENTER", RIGHT = "RIGHT"}
local AlignV = {BOTTOM = "BOTTOM", CENTER = "CENTER", TOP = "TOP"}
FontStyle = {
	NONE = "None", 
	OUTLINE = "Outline", 
	THICKOUTLINE = "Thick Outline", 
	["NONE, MONOCHROME"] = "No Outline, Monochrome", 
	["OUTLINE, MONOCHROME"] = "Outline, Monochrome", 
	["THICKOUTLINE, MONOCHROME"] = "Thick Outline, Monochrome"
}

-- Add your own threat textures with a folder in the Artwork folder with your own LOW MEDIUM and HIGH textures.
-- For Example:
-- Create a folder in the Artwork folder named "Custom".
-- Place three textures of your preference, then edit the Themelist table above:
-- ThemeList = {default = "Default", bar = "Bar Style", Custom = "Custom"} 
-- The first value is the name of the folder, the second is the name of the texture layout.
-- So you could also have it this way:
-- ThemeList = {default = "Default", bar = "Bar Style", Custom = "TOTALLY RAD TEXTURES BY ME"} 
-- This will also set your textures available.
-- Feel free to submit your own themes to me @ shamtasticle@gmail.com for future embedding into the addon :D! * credit will always be given *


local function GetThemeInfo(info)
	local location, mod = info.arg[1], info.arg[2]
	return TidyPlatesThreat.db.profile.settings[location][mod]
end

local function SetThemeValue(info, val)
	local location, mod = info.arg[1], info.arg[2]
	local themeList = {'normal', 'tank', 'dps', 'empty'}
	local modList = {"width", "height"}
	TidyPlatesThreat.db.profile.settings[location][mod] = val
	TidyPlates:ReloadTheme()
	TidyPlates:ForceUpdate()
	if location == "specialArt" and mod == "scale" then -- Preserves Threat Textures from class icon changes.
		for z=1, 2 do
			TidyPlatesThemeList['Threat Plates']["normal"][location][modList[z]] = TidyPlatesThreat.db.profile.settings[location][mod]
		end
	elseif mod == "showSpecialArt" then
		TidyPlatesThemeList['Threat Plates']["normal"][location][mod] = TidyPlatesThreat.db.profile.settings[location][mod]
	else
		if mod == "scale" and location ~= "eliteIcon" then -- Allows width and height to be set for "scale" settings. Doesn't apply theme changes to eliteIcon.
			for z=1, 2 do
				for i=1,4 do
					TidyPlatesThemeList['Threat Plates'][themeList[i]][location][modList[z]] = TidyPlatesThreat.db.profile.settings[location][mod]
				end
			end
		elseif location ~= "eliteIcon" and location ~= "targetArt" then
			for i=1,4 do
				TidyPlatesThemeList['Threat Plates'][themeList[i]][location][mod] = TidyPlatesThreat.db.profile.settings[location][mod]
			end
		else
		end
	end
	
end

-- Text Colors

local function GetTextColor(info)
	local location, mod = info.arg[1], info.arg[2]
	local p = TidyPlatesThreat.db.profile.settings[location][mod]
	return p.r, p.g, p.b
end

local function SetTextColor(info, r, g, b)
	local location, mod = info.arg[1], info.arg[2]
	local p = TidyPlatesThreat.db.profile.settings[location][mod]
	p.r, p.g, p.b = r, g, b
end
-- Threat Colors

local function GetThreatColor(info)
	local location, mod, style = info.arg[1], info.arg[2], info.arg[3]
	local p = TidyPlatesThreat.db.profile.settings[style][location][mod]
	return p.r, p.g, p.b, p.a
end

local function SetThreatColor(info, r,g,b,a)
	local location, mod, style = info.arg[1], info.arg[2], info.arg[3]
	local p = TidyPlatesThreat.db.profile.settings[style][location][mod]
	p.r, p.g, p.b, p.a = r,g,b,a
	TidyPlates:ReloadTheme()
	TidyPlates:ForceUpdate()
end

-- SharedMedia 

local function SetTexture(info, val)
	local location, mod = info.arg[1], info.arg[2]
	local themeList = {'normal', 'tank', 'dps'}
	TidyPlatesThreat.db.profile.settings[location][mod] = val
	for i=1,3 do
		TidyPlatesThemeList['Threat Plates'][themeList[i]][location][mod] = Media:Fetch('statusbar', TidyPlatesThreat.db.profile.settings[location][mod])
	end
	TidyPlates:ReloadTheme()
	TidyPlates:ForceUpdate()
end

local function SetFont(info, val)
	local location, mod = info.arg[1], info.arg[2]
	local themeList = {'normal', 'tank', 'dps', 'empty'}
	TidyPlatesThreat.db.profile.settings[location][mod] = val
	for i=1,4 do
		TidyPlatesThemeList['Threat Plates'][themeList[i]][location][mod] = Media:Fetch('font', TidyPlatesThreat.db.profile.settings[location][mod])
	end
	TidyPlates:ReloadTheme()
end

-- Nameplate Toggle Functions

local function GetToggleNameplate(info)
	return TidyPlatesThreat.db.profile.nameplate.toggle[info.arg]
end

local function SetToggleNameplate(info)
	TidyPlatesThreat.db.profile.nameplate.toggle[info.arg] = not TidyPlatesThreat.db.profile.nameplate.toggle[info.arg]
	if TidyPlatesThreat.db.profile.nameplate.toggle[info.arg] then return print("-->>"..info.arg.." nameplates are now |cff00ff00ON!|r<<--") else return print("-->>"..info.arg.." nameplates are now |cffff0000OFF!|r<<--") end
	TidyPlates:ReloadTheme()
	TidyPlates:ForceUpdate()
end

local function SetToggleText(info)
	local location, mod, TextInfo = info.arg[1], info.arg[2], info.arg[3]
	local themeList = {'normal', 'tank', 'dps'}
	TidyPlatesThreat.db.profile.settings[location][mod] = not TidyPlatesThreat.db.profile.settings[location][mod]
	for i=1,3 do
		TidyPlatesThemeList['Threat Plates'][themeList[i]][location][mod] = TidyPlatesThreat.db.profile.settings[location][mod]
	end
	if TidyPlatesThreat.db.profile.settings[location][mod] then
		return print("-->>"..info.arg[3].." text is now |cff00ff00ON!|r<<--")
	else
		return print("-->>"..info.arg[3].." text is now |cffff0000OFF!|r<<--")
	end
	TidyPlates:ReloadTheme()	
	TidyPlates:ForceUpdate()
end

local function GetToggle(info)
	local location, mod, TextInfo = info.arg[1], info.arg[2], info.arg[3]
	return TidyPlatesThreat.db.profile[location][mod]
end

local function SetToggle(info)
	local location, mod, TextInfo = info.arg[1], info.arg[2], info.arg[3]
	TidyPlatesThreat.db.profile[location][mod] = not TidyPlatesThreat.db.profile[location][mod]
	if TidyPlatesThreat.db.profile[location][mod] then
		return print("-->>"..info.arg[3].." now |cff00ff00ON!|r<<--")
	else
		return print("-->>"..info.arg[3].." now |cffff0000OFF!|r<<--")
	end
	TidyPlates:ReloadTheme()	
	TidyPlates:ForceUpdate()
end

local function GetNameplateScale(info)
	return TidyPlatesThreat.db.profile.nameplate.scale[info.arg]
end

local function SetNameplateScale(info, v)
	TidyPlatesThreat.db.profile.nameplate.scale[info.arg] = v
	TidyPlates:ReloadTheme()
	TidyPlates:ForceUpdate()
end

local function GetNameplateAlpha(info)
	return TidyPlatesThreat.db.profile.nameplate.alpha[info.arg]
end

local function SetNameplateAlpha(info, v)
	TidyPlatesThreat.db.profile.nameplate.alpha[info.arg] = v
	TidyPlates:ReloadTheme()
	TidyPlates:ForceUpdate()
end

-- Nameplate Auto Hide

local function CombatAutoHide()
	if TidyPlatesThreat.db.profile.nameplate.autohide then
		--TidyPlates:UseAutoHide(true)
		TidyPlatesThreat.db.profile.nameplate.autohide = false
		print("-->>Auto hiding of nameplates upon leaving combat is now |cffff0000OFF!|r<<--")
	elseif not TidyPlatesThreat.db.profile.nameplate.autohide then
		--TidyPlates:UseAutoHide(false)
		TidyPlatesThreat.db.profile.nameplate.autohide = true
		print("-->>Auto hiding of nameplates upon leaving combat is now |cff00ff00ON!|r<<--")
	end
	TidyPlates:ReloadTheme()
	TidyPlates:ForceUpdate()
end

-- Threat Toggle Functions
local function GetThreatToggle(info)
	return TidyPlatesThreat.db.profile.threat.toggle[info.arg]
end

local function SetThreatToggle(info)
	TidyPlatesThreat.db.profile.threat.toggle[info.arg] = not TidyPlatesThreat.db.profile.threat.toggle[info.arg]
	if TidyPlatesThreat.db.profile.threat.toggle[info.arg] then 
		return print("-->>|cff00ff00"..info.arg.." Threat System is now ON!|r<<--") 
	else 
		return print("-->>|cffff0000"..info.arg.." Threat System is now OFF!|r<<--") 
	end
	TidyPlates:ReloadTheme()
end

function SetThreatOldSetting()
	self = TidyPlatesThreat.db.profile
	local inInstance, iType = IsInInstance()
	if iType == "party" or iType == "raid" or iType == "none" then
		self.OldSetting = self.threat.ON
	end
end
-- Get Set Threat Alpha & Scale per role
local function GetThreatValue(info)	
	local role, mod, location = info.arg[1], info.arg[2], info.arg[3]
	return TidyPlatesThreat.db.profile.threat[role][mod][location]
end

local function SetThreatValue(info, v)	
	local role, mod, location = info.arg[1], info.arg[2], info.arg[3]
	TidyPlatesThreat.db.profile.threat[role][mod][location] = v
	TidyPlates:ReloadTheme()
	TidyPlates:ForceUpdate()
end

-- Get Set Threat Scale per type

local function GetThreatType(info)
	local location, mod = info.arg[1], info.arg[2]
	return TidyPlatesThreat.db.profile.threat[location][mod]
end

local function SetThreatType(info, v)
	local location, mod = info.arg[1], info.arg[2]
	TidyPlatesThreat.db.profile.threat[location][mod] = v
	TidyPlates:ReloadTheme()
	TidyPlates:ForceUpdate()
end

local options = { 
		type = "group", 
		args = {
		--[[Options Frames]]--
			OptionsHeader = {
				order = 2,
				type = "header",
				name = GetAddOnMetadata("TidyPlates_ThreatPlates", "title").." v"..GetAddOnMetadata("TidyPlates_ThreatPlates", "version"),
			},
			NameplateOptFrame = {
		        order = 3,
		        type  = "group",
       			name  = "Nameplate Options",
		        args = {
					Header = {
						type = "header",
						order = 1,
						name = "Nameplate Options"
					},
					description = {
						type = "description",
						order = 2,
						name = "Toggle the showing and hiding of nameplates.",
					},
					ShowNeutral = {
						type = "toggle",
						order = 3,
						name = "Show Neutral",
						get = GetToggleNameplate,
						set = SetToggleNameplate,
						arg = "Neutral",
					},
					ShowNormal = {
						type = "toggle",
						order = 4,
						name = "Show Normal",
						get = GetToggleNameplate,
						set = SetToggleNameplate,
						arg = "Normal",
					},
					ShowElite = {
						type = "toggle",
						order = 5,
						name = "Show Elite",
						get = GetToggleNameplate,
						set = SetToggleNameplate,
						arg = "Elite",
					},
					ShowBoss = {
						type = "toggle",
						order = 6,
						name = "Show Boss",
						get = GetToggleNameplate,
						set = SetToggleNameplate,
						arg = "Boss",
					},
					Header2 = {
						type = "header",
						order = 7,
						name = "Texture Options"
					},
					showTarget = {
						type = 'toggle',
						order = 8,
						name = "Show Target Highlight",
						get = GetToggle,
						set = SetToggle,
						arg = {"settings","showTarget","Target Highlight textures are"},
					},
					Level = {
						type = "range",
						order = 8.05,
						name = "Highlight Frame Level",
						get = GetThemeInfo,
						set = SetThemeValue,
						arg = {"targetArt","level"},
						min = 0,
						max = 40,
						step = 1,
					},
					HealthBarTexture = {
						type = 'select',
						dialogControl = "LSM30_Statusbar",
						order = 8.1,
						name = 'Healthbar Texture',
						values = AceGUIWidgetLSMlists.statusbar,
						set = SetTexture,
						get = GetThemeInfo,
						arg = {"healthbar", "texture"},
					},
					CastBarTexture = {
						type = 'select',
						dialogControl = "LSM30_Statusbar",
						order = 9,
						name = 'Castbar Texture',
						values = AceGUIWidgetLSMlists.statusbar,
						set = SetTexture,
						get = GetThemeInfo,
						arg = {"castbar", "texture"},
					},
					Header3 = {
						type = "header",
						order = 10,
						name = "Threat Colors"
					},
					LowThreat = {
						type = 'color',
						order = 11,
						name = "Low Threat Color",
						get = GetThreatColor,
						set = SetThreatColor,
						arg = {"threatcolor", "LOW", "normal"},
						hasAlpha = true,
					},
					MediumThreat = {
						type = 'color',
						order = 12,
						name = "Medium Threat Color",
						get = GetThreatColor,
						set = SetThreatColor,
						arg = {"threatcolor", "MEDIUM", "normal"},
						hasAlpha = true,
					},
					HighThreat = {
						type = 'color',
						order = 13,
						name = "High Threat Color",
						get = GetThreatColor,
						set = SetThreatColor,
						arg = {"threatcolor", "HIGH", "normal"},
						hasAlpha = true,
					},
					Header4 = {
						type = "header",
						order = 14,
						name = "Custom HP Color"
					},
					GradualHPColor = {
						type = "toggle",
						order = 14.1,
						name = "HP Percentage Color",
						desc = "HP Bar color fades from green to red depending on the unit's HP amount.",
						get = GetToggle,
						set = SetToggle,
						arg = {"healthColorChange", "toggle", "Gradual HP Bar Color"},
					},
					EnableCustomHPColor = {
						type = "toggle",
						order = 15,
						name = "Enable Custom HP Color",
						get = GetToggle,
						set = SetToggle,
						arg = {"customColor", "toggle", "Custom HP Bar Color"},
					},
					EnableClassOverrideColor = {
						type = "toggle",
						desc = "Requires custom hp coloring on.",
						order = 15.5,
						name = "Hide Class HP Color",
						get = GetToggle,
						set = SetToggle,
						arg = {"allowClass", "toggle", "Hiding of Class HP Color"},
					},
					FriendlyCustomHPColor = {
						type = 'color',
						order = 16.25,
						name = "Friendly HP Bar Color",
						get = function(info) 
							local c = TidyPlatesThreat.db.profile.fHPbarColor
							return c.r, c.g, c.b
						end,
						set = function(info, r, g, b) 
							local p = TidyPlatesThreat.db.profile.fHPbarColor
							p.r, p.g, p.b = r,g,b,a
							TidyPlates:ReloadTheme()
							TidyPlates:ForceUpdate()
						end,
						hasAlpha = false,
					},
					NeutralCustomHPColor = {
						type = 'color',
						order = 16.75,
						name = "Neutral HP Bar Color",
						get = function(info) 
							local c = TidyPlatesThreat.db.profile.nHPbarColor
							return c.r, c.g, c.b
						end,
						set = function(info, r, g, b) 
							local p = TidyPlatesThreat.db.profile.nHPbarColor
							p.r, p.g, p.b = r,g,b,a
							TidyPlates:ReloadTheme()
							TidyPlates:ForceUpdate()
						end,
						hasAlpha = false,
					},
					HostileCustomHPColor = {
						type = 'color',
						order = 16,
						name = "Hostile HP Bar Color",
						get = function(info) 
							local c = TidyPlatesThreat.db.profile.HPbarColor
							return c.r, c.g, c.b
						end,
						set = function(info, r, g, b) 
							local p = TidyPlatesThreat.db.profile.HPbarColor
							p.r, p.g, p.b = r,g,b,a
							TidyPlates:ReloadTheme()
							TidyPlates:ForceUpdate()
						end,
						hasAlpha = false,
					},
					--[[
					xOff = {
						type = "range",
						order = 15,
						name = "X Offset",
						min = -120,
						max = 120,
						step = 1,
						get = function() return TidyPlatesThreat.db.profile.settings.offsetx end,
						set = function(info, val)
							TidyPlatesThreat.db.profile.settings.offsetx = val
							TidyPlates:ReloadTheme()
							end,
					},
					yOff = {
						type = "range",
						order = 15,
						name = "Y Offset",
						min = -120,
						max = 120,
						step = 1,
						get = function() return TidyPlatesThreat.db.profile.settings.offsety end,
						set = function(info, val)
							TidyPlatesThreat.db.profile.settings.offsety = val
							TidyPlates:ReloadTheme()
							end,
					},
					Header = {
						type = 'header',
						order = 6.1,
						name = "Auto Hide Nameplates",
					},
					Description = {
						type = 'description',
						order = 6.2,
						name = "Toggle the auto hiding of nameplates after leaving combat."
					},
					UseAutoHide = {
						type = "toggle",
						order = 6.3,
						name = "Enable Autohide",
						get = function() return TidyPlatesThreat.db.profile.nameplate.autohide end,
						set = CombatAutoHide,
					},]]--
					comboWidget = {
						name = "Combo Point Widget",
						type = 'group',
						desc = "Configure options for the mouseover combo widget.",
						order = 0.5,
						args = {
							widgetHeader = {
								type = "header",
								order = 1,
								name = "Combo Point Widget",
							},
							enable = {
								type = 'toggle',
								name = "Enable Combo Widget",
								order = 2,
								get = GetToggle,
								set = SetToggle,
								arg = {"comboWidget","ON", "Combo Widget"},
							},
							widgetX = {
								type = 'range',
								name = "Position X",
								order = 3,
								get = function() return TidyPlatesThreat.db.profile.comboWidget.x end,
								set = function(info, val)
									TidyPlatesThreat.db.profile.comboWidget.x = val
									TidyPlates:ForceUpdate()
									TidyPlates:ReloadTheme()
									end,
								min = -120,
								max = 120,
								step = 1,
								isPercent = false,
							},
							widgetY = {
								type = 'range',
								name = "Position Y",
								order = 3,
								get = function() return TidyPlatesThreat.db.profile.comboWidget.y end,
								set = function(info, val)
									TidyPlatesThreat.db.profile.comboWidget.y = val
									TidyPlates:ForceUpdate()
									TidyPlates:ReloadTheme()
									end,
								min = -120,
								max = 120,
								step = 1,
								isPercent = false,
							},
						},
					},
					RaidIcon = {
						type = "group",
						order = 1,
						name = "Raid Icon Options",
						args = {
							header = {
								type = 'header',
								order = 1,
								name = "Raid Icon Options",
							},
						--[[
							Enable = {
								type = "toggle",
								order = 1.5,
								name = "Raid Icon y",
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"options","showDangerSkull"},
							},
						]]--
							Size = {
								type = "range",
								order = 2,
								name = "Raid Icon Size",
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"raidicon","scale"},
								min = 6,
								max = 64,
								step = 1,
							},
							X = {
								type = "range",
								order = 3,
								name = "Raid Icon X",
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"raidicon","x"},
								min = -120,
								max = 120,
								step = 1,
							},
							Y = {
								type = "range",
								order = 4,
								name = "Raid Icon Y",
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"raidicon","y"},
								min = -120,
								max = 120,
								step = 1,
							},
							Anchor = {
								type = "select",
								order = 5,
								name = "Anchor Point",
								values = FullAlign,
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"raidicon","anchor"},
							},
						},
					},
					ClassIcon = {
						type = "group",
						order = 2,
						name = "Class Icon Options",
						args = {
							header = {
								type = 'header',
								order = 1,
								name = "Class Icon Options",
							},						
							Enable = {
								type = "toggle",
								order = 1.5,
								name = "Enable Class Icons",
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"options","showSpecialArt"},
							},
							textures = {
								type = 'select',
								order = 4,
								name = 'Texture',
								desc = 'Set the Class Icon theme',
								style = dropdown,
								values = ClassList,
								get = function() return TidyPlatesThreat.db.profile.classTheme end,
								set = function(info,val)  
									TidyPlatesThreat.db.profile.classTheme = val
									TidyPlates:ReloadTheme()
									end,
							},
							Size = {
								type = "range",
								order = 2,
								name = "Class Icon Size",
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"specialArt","scale"},
								min = 6,
								max = 64,
								step = 1,
							},
							X = {
								type = "range",
								order = 3,
								name = "Class Icon X",
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"specialArt","x"},
								min = -120,
								max = 120,
								step = 1,
							},
							Y = {
								type = "range",
								order = 4,
								name = "Class Icon Y",
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"specialArt","y"},
								min = -120,
								max = 120,
								step = 1,
							},
							Anchor = {
								type = "select",
								order = 5,
								name = "Anchor Point",
								values = FullAlign,
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"specialArt","anchor"},
							},
						},
					},
					SkullIcon = {
						type = "group",
						order = 3,
						name = "Skull Icon Options",
						args = {
							header = {
								type = 'header',
								order = 1,
								name = "Skull Icon Options",
							},
							Enable = {
								type = "toggle",
								order = 1.5,
								name = "Enable Skull Icon",
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"options","showDangerSkull"},
							},
						
							Size = {
								type = "range",
								order = 2,
								name = "Skull Icon Size",
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"dangerskull","scale"},
								min = 6,
								max = 64,
								step = 1,
							},
							X = {
								type = "range",
								order = 3,
								name = "Skull Icon X",
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"dangerskull","x"},
								min = -120,
								max = 120,
								step = 1,
							},
							Y = {
								type = "range",
								order = 4,
								name = "Skull Icon Y",
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"dangerskull","y"},
								min = -120,
								max = 120,
								step = 1,
							},
							Anchor = {
								type = "select",
								order = 5,
								name = "Anchor Point",
								values = FullAlign,
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"dangerskull","anchor"},
							},
						},
					},
					EliteIcon = {
						type = "group",
						order = 3.5,
						name = "Elite Icon Options",
						args = {
							header = {
								type = 'header',
								order = 1,
								name = "Elite Icon Options",
							},						
							Enable = {
								type = "toggle",
								order = 1.5,
								name = "Enable Elite Icons",
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"options","showEliteIcon"},
							},
							Size = {
								type = "range",
								order = 2,
								name = "Elite Icon Size",
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"eliteIcon","scale"},
								min = 6,
								max = 64,
								step = 1,
							},
							X = {
								type = "range",
								order = 3,
								name = "Elite Icon X",
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"eliteIcon","x"},
								min = -120,
								max = 120,
								step = 1,
							},
							Y = {
								type = "range",
								order = 4,
								name = "Elite Icon Y",
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"eliteIcon","y"},
								min = -120,
								max = 120,
								step = 1,
							},
							Level = {
								type = "range",
								order = 4.5,
								name = "Elite Icon Frame Level",
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"eliteIcon","level"},
								min = 0,
								max = 40,
								step = 1,
							},							
							textures = {
								type = 'select',
								order = 5,
								name = 'Texture',
								desc = 'Set the Elite Icon theme',
								style = dropdown,
								values = EliteList,
								get = function() return TidyPlatesThreat.db.profile.eliteTheme end,
								set = function(info,val)  
									TidyPlatesThreat.db.profile.eliteTheme = val
									TidyPlates:ReloadTheme()
									end,
							},
							Anchor = {
								type = "select",
								order = 6,
								name = "Anchor Point",
								values = FullAlign,
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"eliteIcon","anchor"},
							},							
						},
					},
					Scale = {
						type = "group",
						order = 6,
						name = "Nameplate Scale",
						desc = "Set nameplate scale levels",
						args = {
							levels = {
								type = "header",
								order = 3,
								name = "Nameplate Scale Levels",
							},
							Neutral_scale = {
								type 	= "range",
								order 	= 4,
								name 	= "Neutral Scale",
								arg 	= "Neutral",
								get 	= GetNameplateScale,
								set		= SetNameplateScale,
								step = 0.05,
								min = 0.3,
								max = 2,
								isPercent = true,
							},
							Normal_scale = {
								type 	= "range",
								order 	= 5,
								name 	= "Normal Scale",
								arg 	= "Normal",
								get 	= GetNameplateScale,
								set		= SetNameplateScale,								
								step = 0.05,
								min = 0.3,
								max = 2,
								isPercent = true,
							},
							Elite_scale = {
								type 	= "range",
								order 	= 6,
								name 	= "Elite Scale",
								arg 	= "Elite",
								get 	= GetNameplateScale,
								set		= SetNameplateScale,								
								step = 0.05,
								min = 0.3,
								max = 2,
								isPercent = true,
							},
							Boss_scale = {
								type 	= "range",
								order 	= 7,
								name 	= "Boss Scale",
								arg 	= "Boss",
								get 	= GetNameplateScale,
								set		= SetNameplateScale,								
								step = 0.05,
								min = 0.3,
								max = 2,
								isPercent = true,
							},
						},
					},
					Alpha = {
						type = "group",
						order = 7,
						name = "Nameplate Alpha",
						desc = "Set nameplate alpha levels",
						args = {
							levels = {
								type = "header",
								order = 3,
								name = "Nameplate Alpha Levels",
							},
							blizzFade = {
								type = "toggle",
								order = 3.1,
								name = "Disable OnTarget Fade",
								get = GetToggle,
								set = SetToggle,
								arg = {"blizzFade","toggle","Diabling of targetting alpha change"},
							},
							blizzFadeAmount = {
								type = "range",
								order = 3.2,
								name = "Non-Target Alpha",
								get = function() return TidyPlatesThreat.db.profile.blizzFade.amount end,
								set = function(info, val)
									TidyPlatesThreat.db.profile.blizzFade.amount = val
									TidyPlates:ForceUpdate()
									TidyPlates:ReloadTheme()
									end,
								min = -1,
								max = 0,
								step = 0.01,
								isPercent = true,
							},
							divider = {
								type = "header",
								order = 3.3,
								name = "",
							},
							Neutral_alpha = {
								type 	= "range",
								order 	= 4,
								name 	= "Neutral alpha",
								arg 	= "Neutral",
								get 	= GetNameplateAlpha,
								set		= SetNameplateAlpha,								
								step = 0.05,
								min = 0,
								max = 1,
								isPercent = true,
							},
							Normal_alpha = {
								type 	= "range",
								order 	= 5,
								name 	= "Normal alpha",
								arg 	= "Normal",
								get 	= GetNameplateAlpha,
								set		= SetNameplateAlpha,								
								step = 0.05,
								min = 0,
								max = 1,
								isPercent = true,
							},
							Elite_alpha = {
								type 	= "range",
								order 	= 6,
								name 	= "Elite alpha",
								arg 	= "Elite",
								get 	= GetNameplateAlpha,
								set		= SetNameplateAlpha,								
								step = 0.05,
								min = 0,
								max = 1,
								isPercent = true,
							},
							Boss_alpha = {
								type 	= "range",
								order 	= 7,
								name 	= "Boss alpha",
								arg 	= "Boss",
								get 	= GetNameplateAlpha,
								set		= SetNameplateAlpha,							
								step = 0.05,
								min = 0,
								max = 1,
								isPercent = true,
							},
						},
					},
				},
			},
			TextOptFrame = {
		        order = 4,
		        type  = "group",
       			name  = "Text Options",
		        args = {
					TextOptHeader = {
						order = 1,
						type = "header",
						name = "Text Options",
					},
					formatheader = {
						order = 6,
						type = "header",
						name = "Text Formatting"
					},
					fullhp = {
						order = 7,
						type = "toggle",
						name = "Show HP at full",
						desc = "Display HP when a unit is at 100%.",
						get = GetToggle,
						set = SetToggle,
						arg = {"text","full","Full HP text is"},
					},
					hpamount = {
						order = 8,
						type = "toggle",
						name = "Show HP Amount",
						desc = "Display HP amount number text.",
						get = GetToggle,
						set = SetToggle,
						arg = {"text","amount","HP Text Amount is"},
					},
					hptruncate = {
						order = 9,
						type = "toggle",
						name = "Truncate HP Amount",
						desc = "Truncate HP amount number text to simplified millions and thousands.",
						get = GetToggle,
						set = SetToggle,
						arg = {"text","truncate","HP Text Amount truncation is"},
					},
					hpdeficit = {
						order = 10,
						type = "toggle",
						name = "Deficit HP Amount",
						desc = "Deficit HP amount to show a negative value of HP.",
						get = GetToggle,
						set = SetToggle,
						arg = {"text","deficit","Deficit HP Text Amount is"},
					},
					extrasheader = {
						order = 11,
						type = "header",
						name = "Text Extras"
					},
					hp_percent = {
						order = 12,
						type = "toggle",
						name = "Show HP Percent",
						desc = "Display HP Percent text.",
						get = GetToggle,
						set = SetToggle,
						arg = {"text","percent","HP Percentage Text is"},
					},
					hpmax = {
						order = 13,
						type = "toggle",
						name = "Show HP Maximum",
						desc = "Display HP Max Value text.",
						get = GetToggle,
						set = SetToggle,
						arg = {"text","max","HP Maximum Text is"},
					},
					NameSettings = {
						type = "group",
						name = "Name Text",
						order = 1,
						args = {
							NameHeader = {
								type = 'header',
								order = 1,
								name = 'Name Text',
							},
							NameToggle = {
								order = 1.05,
								type = "toggle",
								name = "Enable",
								desc = "Toggles the showing and hiding of HP Special Text",
								arg = {"options","showName", "Name"},
								get = GetThemeInfo,
								set = SetToggleText,
							},
							Divider = {
								type = 'header',
								order = 1.1,
								name = "",
							},
							NameFont = {
								type = 'select',
								order = 1.2,
								name = 'Name Font:',
								dialogControl = 'LSM30_Font',
								values = AceGUIWidgetLSMlists.font,
								set = SetFont,
								get = GetThemeInfo,
								arg = {"name", "typeface"},
							},
							NameFontStyle = {
								type = 'select',
								order = 1.25,
								name = 'Font Style',
								desc = 'Set the outlining style of the name text.',
								style = dropdown,
								arg = {"name", "flags"},
								values = FontStyle,
								get = GetThemeInfo,
								set = SetThemeValue,
							},
							NameTextColor = {
								type = "color",
								order = 1.12,
								name = "Name Color",
								get = GetTextColor,
								set = SetTextColor,
								arg = {"name", "color"},
								hasAlpha = false,
							},
							NameShadow = {
								order = 1.3,
								type = 'toggle',
								name = "Enable Shadow",
								arg = {"name", "shadow", "Name Shadow"},
								get = GetThemeInfo,
								set = SetToggleText,
							},
							NameSize = {
								type = "range",
								order = 2,
								name = "Font Size",
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"name", "size"},
								max = 36,
								min = 6,
								step = 1,
								isPercent = false,
							},
							NameWidth = {
								type = "range",
								order = 3,
								name = "Text Width",
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"name", "width"},
								max = 250,
								min = 20,
								step = 1,
								isPercent = false,
							},
							NameHeight = {
								type = "range",
								order = 4,
								name = "Text Height",
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"name", "height"},
								max = 40,
								min = 8,
								step = 1,
								isPercent = false,
							},
							NamePosX = {
								type = "range",
								order = 5,
								name = "X position",
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"name", "x"},
								max = 120,
								min = -120,
								step = 1,
								isPercent = false,
							},
							NamePosY = {
								type = "range",
								order = 6,
								name = "Y position",
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"name", "y"},
								max = 120,
								min = -120,
								step = 1,
								isPercent = false,
							},
							NameAlignH = {
								type = "select",
								order = 7,
								name = "Horizontal Align",
								values = AlignH,
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"name", "align"},
							},
							NameAlignV = {
								type = "select",
								order = 8,
								name = "Vertical Align",
								values = AlignV,
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"name", "vertical"},
							},
						},
					},
					LevelSettings = {
						type = "group",
						name = "Level Text",
						order = 2,
						args = {
							LevelHeader = {
								type = 'header',
								order = 1,
								name = 'Level Text',
							},
							LevelToggle = {
								order = 1.05,
								type = "toggle",
								name = "Enable",
								desc = "Toggles the showing and hiding of HP Special Text",
								arg = {"options","showLevel", "Level"},
								get = GetThemeInfo,
								set = SetToggleText,
							},
							Divider = {
								type = 'header',
								order = 1.1,
								name = "",
							},
							LevelFont = {
								type = 'select',
								order = 1.2,
								name = 'Level Font:',
								dialogControl = 'LSM30_Font',
								values = AceGUIWidgetLSMlists.font,
								set = SetFont,
								get = GetThemeInfo,
								arg = {"level", "typeface"},
							},
							LevelFontStyle = {
								type = 'select',
								order = 1.25,
								name = 'Font Style',
								desc = 'Set the outlining style of the level text.',
								style = dropdown,
								arg = {"level", "flags"},
								values = FontStyle,
								get = GetThemeInfo,
								set = SetThemeValue,
							},
							LevelShadow = {
								order = 1.3,
								type = 'toggle',
								name = "Enable Shadow",
								arg = {"level", "shadow", "Level Shadow"},
								get = GetThemeInfo,
								set = SetToggleText,
							},
							LevelSize = {
								type = "range",
								order = 2,
								name = "Font Size",
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"level", "size"},
								max = 36,
								min = 6,
								step = 1,
								isPercent = false,
							},
							LevelWidth = {
								type = "range",
								order = 3,
								name = "Text Width",
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"level", "width"},
								max = 250,
								min = 20,
								step = 1,
								isPercent = false,
							},
							LevelHeight = {
								type = "range",
								order = 4,
								name = "Text Height",
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"level", "height"},
								max = 40,
								min = 8,
								step = 1,
								isPercent = false,
							},
							LevelPosX = {
								type = "range",
								order = 5,
								name = "X position",
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"level", "x"},
								max = 120,
								min = -120,
								step = 1,
								isPercent = false,
							},
							LevelPosY = {
								type = "range",
								order = 6,
								name = "Y position",
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"level", "y"},
								max = 120,
								min = -120,
								step = 1,
								isPercent = false,
							},
							LevelAlignH = {
								type = "select",
								order = 7,
								name = "Horizontal Align",
								values = AlignH,
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"level", "align"},
							},
							LevelAlignV = {
								type = "select",
								order = 8,
								name = "Vertical Align",
								values = AlignV,
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"level", "vertical"},
							},
						},
					},
					HealthSettings = {
						type = "group",
						name = "Health Text",
						order = 3,
						args = {
							HealthHeader = {
								type = 'header',
								order = 1,
								name = 'Health Text',
							},
							HealthToggle = {
								order = 1.05,
								type = "toggle",
								name = "Enable",
								desc = "Toggles the showing and hiding of HP Special Text",
								arg = {"options","showSpecialText", "Health"},
								get = GetThemeInfo,
								set = SetToggleText,
							},
							Divider = {
								type = 'header',
								order = 1.1,
								name = "",
							},
							HealthFont = {
								type = 'select',
								order = 1.2,
								name = 'Health Font:',
								dialogControl = 'LSM30_Font',
								values = AceGUIWidgetLSMlists.font,
								set = SetFont,
								get = GetThemeInfo,
								arg = {"specialText", "typeface"},
							},
							HealthFontStyle = {
								type = 'select',
								order = 1.25,
								name = 'Font Style',
								desc = 'Set the outlining style of the health text.',
								style = dropdown,
								arg = {"specialText", "flags"},
								values = FontStyle,
								get = GetThemeInfo,
								set = SetThemeValue,
							},
							HealthShadow = {
								order = 1.3,
								type = 'toggle',
								name = "Enable Shadow",
								arg = {"specialText", "shadow", "Health Shadow"},
								get = GetThemeInfo,
								set = SetToggleText,
							},
							HealthSize = {
								type = "range",
								order = 2,
								name = "Font Size",
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"specialText", "size"},
								max = 36,
								min = 6,
								step = 1,
								isPercent = false,
							},
							HealthWidth = {
								type = "range",
								order = 3,
								name = "Text Width",
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"specialText", "width"},
								max = 250,
								min = 20,
								step = 1,
								isPercent = false,
							},
							HealthHeight = {
								type = "range",
								order = 4,
								name = "Text Height",
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"specialText", "height"},
								max = 40,
								min = 8,
								step = 1,
								isPercent = false,
							},
							HealthPosX = {
								type = "range",
								order = 5,
								name = "X position",
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"specialText", "x"},
								max = 120,
								min = -120,
								step = 1,
								isPercent = false,
							},
							HealthPosY = {
								type = "range",
								order = 6,
								name = "Y position",
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"specialText", "y"},
								max = 120,
								min = -120,
								step = 1,
								isPercent = false,
							},
							HealthAlignH = {
								type = "select",
								order = 7,
								name = "Horizontal Align",
								values = AlignH,
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"specialText", "align"},
							},
							HealthAlignV = {
								type = "select",
								order = 8,
								name = "Vertical Align",
								values = AlignV,
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"specialText", "vertical"},
							},
						},
					},
					CastbarSettings = {
						type = "group",
						name = "Castbar Text",
						order = 4,
						args = {
							CastHeader = {
								type = 'header',
								order = 1,
								name = 'Cast Text',
							},
							CastToggle = {
								order = 1.05,
								type = "toggle",
								name = "Enable",
								desc = "Toggles the showing and hiding of HP Special Text",
								arg = {"options","showSpecialText2", "Cast"},
								get = GetThemeInfo,
								set = SetToggleText,
							},
							Divider = {
								type = 'header',
								order = 1.1,
								name = "",
							},
							CastbarFont = {
								type = 'select',
								order = 1.2,
								name = 'Castbar Font:',
								dialogControl = 'LSM30_Font',
								values = AceGUIWidgetLSMlists.font,
								set = SetFont,
								get = GetThemeInfo,
								arg = {"specialText2", "typeface"},
							},
							CastFontStyle = {
								type = 'select',
								order = 1.25,
								name = 'Font Style',
								desc = 'Set the outlining style of the cast text.',
								style = dropdown,
								arg = {"specialText2", "flags"},
								values = FontStyle,
								get = GetThemeInfo,
								set = SetThemeValue,
							},
							CastShadow = {
								order = 1.3,
								type = 'toggle',
								name = "Enable Shadow",
								arg = {"specialText2", "shadow", "Cast Shadow"},
								get = GetThemeInfo,
								set = SetToggleText,
							},
							CastbarSize = {
								type = "range",
								order = 2,
								name = "Font Size",
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"specialText2", "size"},
								max = 36,
								min = 6,
								step = 1,
								isPercent = false,
							},
							CastbarWidth = {
								type = "range",
								order = 3,
								name = "Text Width",
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"specialText2", "width"},
								max = 250,
								min = 20,
								step = 1,
								isPercent = false,
							},
							CastbarHeight = {
								type = "range",
								order = 4,
								name = "Text Height",
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"specialText2", "height"},
								max = 40,
								min = 8,
								step = 1,
								isPercent = false,
							},
							CastbarPosX = {
								type = "range",
								order = 5,
								name = "X position",
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"specialText2", "x"},
								max = 120,
								min = -120,
								step = 1,
								isPercent = false,
							},
							CastbarPosY = {
								type = "range",
								order = 6,
								name = "Y position",
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"specialText2", "y"},
								max = 120,
								min = -120,
								step = 1,
								isPercent = false,
							},
							CastbarAlignH = {
								type = "select",
								order = 7,
								name = "Horizontal Align",
								values = AlignH,
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"specialText2", "align"},
							},
							CastbarAlignV = {
								type = "select",
								order = 8,
								name = "Vertical Align",
								values = AlignV,
								get = GetThemeInfo,
								set = SetThemeValue,
								arg = {"specialText2", "vertical"},
							},
						},
					},
				},
			},
			ThreatOptFrame = {
		        order = 5,
		        type  = "group",
       			name  = "Threat Options",
		        args = {
					ThreatDescription = {
						type = "description",
						order = 1,
						name = "Toggle the threat system on or off",
					},
					threat = {
						order = 2,
						type = "toggle",
						name = "Enable Threat System",
						desc = "Enable or disable the threat plates system.",
						get = function() return TidyPlatesThreat.db.profile.threat.ON end,
						set = function(info,val) 
							TidyPlatesThreat.db.profile.threat.ON = not TidyPlatesThreat.db.profile.threat.ON
							SetThreatOldSetting()
							if TidyPlatesThreat.db.profile.threat.ON then return print("-->>|cff00ff00Threat System is now ON!|r<<--") else return print("-->>|cffff0000Threat System is now OFF!|r<<--") end
							TidyPlates:ReloadTheme()
						end
					},
					RoleDescription = {
						type = "description",
						order = 3,
						name = "Select which role you're currently fulfilling.",
					},
					DPSRole = {
						order = 4,
						type = "toggle",
						name = "DPS Role",
						desc = "Enable or disable the threat plates system for DPSing.",
						get = function() return not TidyPlatesThreat.db.char.threat.tanking end,
						set = function(info,val)
								print("-->>|cff00ff00DPS Role threat system is now active!!|r<<--")
								if GetActiveTalentGroup() == 1 then
									TidyPlatesThreat.db.char.spec.primary = not TidyPlatesThreat.db.char.spec.primary
									print("Your |cff89F559primary|r spec has been set to "..roleText(current)..".")
								elseif GetActiveTalentGroup() == 2 then	
									TidyPlatesThreat.db.char.spec.secondary = not TidyPlatesThreat.db.char.spec.secondary
									print("Your |cff89F559secondary|r spec has been set to "..roleText(current)..".")
								end
								TidyPlatesThreat.db.char.threat.tanking = false
								TidyPlatesThreat.db.profile.threat.ON = true
								SetThreatOldSetting()
								TidyPlates:ReloadTheme()
							end
					},
					TankRole = {
						order = 5,
						type = "toggle",
						name = "Tank Role",
						desc = "Enable or disable the threat plates system for Tanking.",
						get = function() return TidyPlatesThreat.db.char.threat.tanking end,
						set = function(info,val) 
								print("-->>|cff00ff00Tank Role threat system is now active!!|r<<--")
								if GetActiveTalentGroup() == 1 then
									TidyPlatesThreat.db.char.spec.primary = not TidyPlatesThreat.db.char.spec.primary
									print("Your |cff89F559primary|r spec has been set to "..roleText(current)..".")
								elseif GetActiveTalentGroup() == 2 then	
									TidyPlatesThreat.db.char.spec.secondary = not TidyPlatesThreat.db.char.spec.secondary
									print("Your |cff89F559secondary|r spec has been set to "..roleText(current)..".")
								end
								TidyPlatesThreat.db.char.threat.tanking = true
								TidyPlatesThreat.db.profile.threat.ON = true
								SetThreatOldSetting()
								TidyPlates:ReloadTheme()
							end
					},
					header2 = {
						type = "header",
						name = "Look & Feel",
						order = 6,
					},
					scaleOn = {
						type = "toggle",
						order = 6.1,
						name = "Enable Scale by Threat",
						get = GetToggle,
						set = SetToggle,
						arg = {"threat","useScale","Nameplate scaling by threat"},
					},
					alphaOn = {
						type = "toggle",
						order = 6.2,
						name = "Enable Alpha by Threat",
						get = GetToggle,
						set = SetToggle,
						arg = {"threat","useAlpha","Nameplate alpha by threat"},
					},
					textures = {
						type = 'select',
						order = 6.3,
						name = 'Texture',
						desc = 'Set the Threat Art Textures',
						style = dropdown,
						values = ThemeList,
						get = function() return TidyPlatesThreat.db.profile.theme end,
						set = function(info,val)  
							TidyPlatesThreat.db.profile.theme = val
							TidyPlates:ReloadTheme()
							end,
					},
					AdditionalToggles = {
						order = 7,
						type = "header",
						name = "Additional Toggles",
					},
					ColorHealth = {
						order = 7.05,
						type = 'toggle',
						name = "Color Health by Threat",
						get = function() return TidyPlatesThreat.db.profile.threat.useHPColor end,
						set = function(info)
							TidyPlatesThreat.db.profile.threat.useHPColor = not TidyPlatesThreat.db.profile.threat.useHPColor
							if TidyPlatesThreat.db.profile.threat.useHPColor then return print("-->>Coloring of health by threat is |cff00ff00ON!!|r<<--") else return print ("-->>Coloring of health by threat is |cffff0000OFF!!|r<<--") end
							end
					},
					NonCombat = {
						order = 7.1,
						type = 'toggle',
						name = 'Hide Non-Combat Mobs',
						get = function() return TidyPlatesThreat.db.profile.threat.nonCombat end,
						set = function(info)
							TidyPlatesThreat.db.profile.threat.nonCombat = not TidyPlatesThreat.db.profile.threat.nonCombat
							if TidyPlatesThreat.db.profile.threat.nonCombat then return print("-->>Hiding of Non-Combat mob threat is |cff00ff00ON!!|r<<--") else return print ("-->>Hiding of Non-Combat mob threat is |cffff0000OFF!!|r<<--") end
							end,
					},
					Neutral_Threat = {
						order = 8,
						type = "toggle",
						name = "Show Neutral Threat",
						desc = "Enable or disable the threat plates system for Neutral units.",
						arg = "Neutral",
						get = GetThreatToggle,
						set = SetThreatToggle,
					},
					Normal_Threat = {
						order = 9,
						type = "toggle",
						name = "Show Normal Threat",
						desc = "Enable or disable the threat plates system for Normal units.",
						arg = "Normal",
						get = GetThreatToggle,
						set = SetThreatToggle,
					},
					Elite_Threat = {
						order = 10,
						type = "toggle",
						name = "Show Elite Threat",
						desc = "Enable or disable the threat plates system for Elite units.",
						arg = "Elite",
						get = GetThreatToggle,
						set = SetThreatToggle,
					},
					Boss_Threat = {
						order = 11,
						type = "toggle",
						name = "Show Boss Threat",
						desc = "Enable or disable the threat plates system for Boss units.",
						arg = "Boss",
						get = GetThreatToggle,
						set = SetThreatToggle,
					},
					UnitTypeScales = {
						order = 12,
						type = "header",
						name = "Unit Type Threat Offsets",
					},
					useType = {
						order = 13,
						type = 'toggle',
						name = "Enable Type Offsets",
						get = function() return TidyPlatesThreat.db.profile.threat.useType end,
						set = function(info)
							TidyPlatesThreat.db.profile.threat.useType = not TidyPlatesThreat.db.profile.threat.useType
							if TidyPlatesThreat.db.profile.threat.useType then
								return print()
							else
								return print()
							end
							TidyPlates:ReloadTheme()
							TidyPlates:ForceUpdate()
						end,
					},
					NormalNeutral = {
						order = 14,
						type = 'range',
						name = 'Normal & Neutral',
						arg = {"scaleType", "Normal"},
						get = GetThreatType,
						set = SetThreatType,
						min = -0.5,
						max = 0.5,
						step = 0.01,
						isPercent = true,
					},
					Elite = {
						order = 15,
						type = 'range',
						name = 'Elite',
						arg = {"scaleType", "Elite"},
						get = GetThreatType,
						set = SetThreatType,
						min = -0.5,
						max = 0.5,
						step = 0.01,
						isPercent = true,
					},
					Boss = {
						order = 16,
						type = 'range',
						name = 'Boss',
						arg = {"scaleType", "Boss"},
						get = GetThreatType,
						set = SetThreatType,
						min = -0.5,
						max = 0.5,
						step = 0.01,
						isPercent = true,
					},
					threatWidget = {
						name = "Threat Widget",
						type = 'group',
						desc = "Configure options for the mouseover threat widget.",
						order = 0.5,
						args = {
							widgetHeader = {
								type = "header",
								order = 1,
								name = "Threat Widget",
							},
							enable = {
								type = 'toggle',
								name = "Enable Threat Widget",
								order = 2,
								get = GetToggle,
								set = SetToggle,
								arg = {"threatWidget","ON", "Threat Widget"},
							},--[[
							style = {
								type = 'select',
								name = "Threat Widget Style",
								order = 2.5,
								values = ThreatStyleList,
								get = function() return TidyPlatesThreat.db.profile.threatWidget.style end,
								set = function(info, val)
									TidyPlatesThreat.db.profile.threatWidget.style = val
									TidyPlates:ReloadTheme()
									TidyPlates:ForceUpdate()
								end
							},]]--
							widgetX = {
								type = 'range',
								name = "Position X",
								order = 3,
								get = function() return TidyPlatesThreat.db.profile.threatWidget.x end,
								set = function(info, val)
									TidyPlatesThreat.db.profile.threatWidget.x = val
									TidyPlates:ForceUpdate()
									TidyPlates:ReloadTheme()
									end,
								min = -120,
								max = 120,
								step = 1,
								isPercent = false,
							},
							widgetY = {
								type = 'range',
								name = "Position Y",
								order = 3,
								get = function() return TidyPlatesThreat.db.profile.threatWidget.y end,
								set = function(info, val)
									TidyPlatesThreat.db.profile.threatWidget.y = val
									TidyPlates:ForceUpdate()
									TidyPlates:ReloadTheme()
									end,
								min = -120,
								max = 120,
								step = 1,
								isPercent = false,
							},
						},
					},
					DPS = {
						name = "|cffffffffDPS Threat Levels|r",
						type = "group",
						desc = "Set threat scales and alpha for DPSing",
						order = 1,
						args = {
							scaleheader = {
								type = "header",
								order = 1,
								name = "Nameplate Scale",
							},
							lowthreat = {
								type 	= "range",
								order 	= 2,
								name 	= "|cff00ff00Low Threat Scale|r",
								arg = {"dps", "scale", "LOW"},
								get = GetThreatValue,
								set = SetThreatValue,
								step = 0.05,
								min = 0.3,
								max = 2,
								isPercent = true,
							},
							medthreat = {
								type 	= "range",
								order 	= 3,
								name 	= "|cffffff00Medium Threat Scale|r",
								arg = {"dps", "scale", "MEDIUM"},
								get = GetThreatValue,
								set = SetThreatValue,								
								step = 0.05,
								min = 0.3,
								max = 2,
								isPercent = true,
							},
							highthreat = {
								type 	= "range",
								order 	= 4,
								name 	= "|cffff0000High Threat Scale|r",
								arg = {"dps", "scale", "HIGH"},
								get = GetThreatValue,
								set = SetThreatValue,								
								step = 0.05,
								min = 0.3,
								max = 2,
								isPercent = true,
							},
							alphaheader = {
								type = "header",
								order = 5,
								name = "Nameplate Alpha",
							},
							alphalow = {
								type 	= "range",
								order 	= 7,
								name 	= "|cff00ff00Low Threat Alpha|r",
								arg = {"dps", "alpha", "LOW"},
								get = GetThreatValue,
								set = SetThreatValue,								
								step = 0.05,
								min = 0,
								max = 1,
								isPercent = true,
							},
							alphaMed = {
								type 	= "range",
								order 	= 8,
								name 	= "|cffffff00Medium Threat Alpha|r",
								arg = {"dps", "alpha", "MEDIUM"},
								get = GetThreatValue,
								set = SetThreatValue,								
								step = 0.05,
								min = 0,
								max = 1,
								isPercent = true,
							},
							alphahigh = {
								type 	= "range",
								order 	= 9,
								name 	= "|cffff0000High Threat Alpha|r",
								arg = {"dps", "alpha", "HIGH"},
								get = GetThreatValue,
								set = SetThreatValue,								
								step = 0.05,
								min = 0,
								max = 1,
								isPercent = true,
							},
							colorheader = {
								type = 'header',
								order = 10,
								name = 'Threat Colors'
							},
							LowThreat = {
								type = 'color',
								order = 11,
								name = "Low Threat Color",
								get = GetThreatColor,
								set = SetThreatColor,
								arg = {"threatcolor", "LOW", "dps"},
								hasAlpha = true,
							},
							MediumThreat = {
								type = 'color',
								order = 12,
								name = "Medium Threat Color",
								get = GetThreatColor,
								set = SetThreatColor,
								arg = {"threatcolor", "MEDIUM", "dps"},
								hasAlpha = true,
							},
							HighThreat = {
								type = 'color',
								order = 13,
								name = "High Threat Color",
								get = GetThreatColor,
								set = SetThreatColor,
								arg = {"threatcolor", "HIGH", "dps"},
								hasAlpha = true,
							},
						},
					},
					Tank = {
						name = "|cffffffffTank Threat Levels|r",
						type = "group",
						desc = "Set threat scales and alpha for Tanking",
						order = 2,
						args = {
							tankdesc = {
								type = "header",
								order = 1,
								name = "Nameplate Scale",
							},
							lowthreat = {
								type 	= "range",
								order 	= 2,
								name 	= "|cffff0000Low Threat Scale|r",
								arg = {"tank", "scale", "LOW"},
								get = GetThreatValue,
								set = SetThreatValue,								
								step = 0.05,
								min = 0.3,
								max = 2,
								isPercent = true,
							},
							medthreat = {
								type 	= "range",
								order 	= 3,
								name 	= "|cffffff00Medium Threat Scale|r",
								arg = {"tank", "scale", "MEDIUM"},
								get = GetThreatValue,
								set = SetThreatValue,								
								step = 0.05,
								min = 0.3,
								max = 2,
								isPercent = true,
							},
							highthreat = {
								type 	= "range",
								order 	= 4,
								name 	= "|cff00ff00High Threat Scale|r",
								arg = {"tank", "scale", "HIGH"},
								get = GetThreatValue,
								set = SetThreatValue,								
								step = 0.05,
								min = 0.3,
								max = 2,
								isPercent = true,
							},
							alphaheader = {
								type = "header",
								order = 5,
								name = "Nameplate Alpha",
							},
							alphalow = {
								type 	= "range",
								order 	= 7,
								name 	= "|cffff0000Low Threat Alpha|r",
								arg = {"tank", "alpha", "LOW"},
								get = GetThreatValue,
								set = SetThreatValue,								
								step = 0.05,
								min = 0,
								max = 1,
								isPercent = true,
							},
							alphaMed = {
								type 	= "range",
								order 	= 8,
								name 	= "|cffffff00Medium Threat Alpha|r",
								arg = {"tank", "alpha", "MEDIUM"},
								get = GetThreatValue,
								set = SetThreatValue,								
								step = 0.05,
								min = 0,
								max = 1,
								isPercent = true,
							},
							alphahigh = {
								type 	= "range",
								order 	= 9,
								name 	= "|cff00ff00High Threat Alpha|r",
								arg = {"tank", "alpha", "HIGH"},
								get = GetThreatValue,
								set = SetThreatValue,								
								step = 0.05,
								min = 0,
								max = 1,
								isPercent = true,
							},
							colorheader = {
								type = 'header',
								order = 10,
								name = 'Threat Colors'
							},
							LowThreat = {
								type = 'color',
								order = 11,
								name = "Low Threat Color",
								get = GetThreatColor,
								set = SetThreatColor,
								arg = {"threatcolor", "LOW", "tank"},
								hasAlpha = true,
							},
							MediumThreat = {
								type = 'color',
								order = 12,
								name = "Medium Threat Color",
								get = GetThreatColor,
								set = SetThreatColor,
								arg = {"threatcolor", "MEDIUM", "tank"},
								hasAlpha = true,
							},
							HighThreat = {
								type = 'color',
								order = 13,
								name = "High Threat Color",
								get = GetThreatColor,
								set = SetThreatColor,
								arg = {"threatcolor", "HIGH", "tank"},
								hasAlpha = true,
							},
						},
					},
					Marked = {
						name = "|cffffffffMarked Units|r",
						type = "group",
						desc = "Set threat textures, scales, and alpha for marked units.",
						order = 3,
						args = {
							header1 = {
								order = 1,
								type = "header",
								name = "Marked Mob Ignore Settings"
							},
							descript1 = {
								order = 2,
								type = "description",
								name = "Threat textures, scaling, and alpha changes can be ignored for units that are marked."
							},
							art = {
								order = 3,
								name = "Remove Threat Textures",
								type = "toggle",
								desc = "Disables all threat textures for marked units.",
								get = function() return TidyPlatesThreat.db.profile.threat.marked.art end,
								set = function(info,val) 
									TidyPlatesThreat.db.profile.threat.marked.art = not TidyPlatesThreat.db.profile.threat.marked.art
									if TidyPlatesThreat.db.profile.threat.marked.art then return print("-->>Ignoring of marked unit threat textures is now |cff00ff00ON!|r<<--") else return print("-->>Ignoring of marked unit threat textures is now |cffff0000OFF!|r<<--") end
									TidyPlates:ReloadTheme()
								end
							},
							alpha = {
								order = 4,
								name = "Remove Threat Alpha",
								type = "toggle",
								desc = "Disables all threat alpha settings for marked units.",
								get = function() return TidyPlatesThreat.db.profile.threat.marked.alpha end,
								set = function(info,val) 
									TidyPlatesThreat.db.profile.threat.marked.alpha = not TidyPlatesThreat.db.profile.threat.marked.alpha
									if TidyPlatesThreat.db.profile.threat.marked.alpha then return print("-->>Ignoring of marked unit threat alpha is now |cff00ff00ON!|r<<--") else return print("-->>Ignoring of marked unit threat alpha is now |cffff0000OFF!|r<<--") end
									TidyPlates:ReloadTheme()
								end
							},
							scale = {
								order = 4,
								name = "Remove Threat Scale",
								type = "toggle",
								desc = "Disables all threat scale settings for marked units.",
								get = function() return TidyPlatesThreat.db.profile.threat.marked.scale end,
								set = function(info,val) 
									TidyPlatesThreat.db.profile.threat.marked.scale = not TidyPlatesThreat.db.profile.threat.marked.scale
									if TidyPlatesThreat.db.profile.threat.marked.scale then return print("-->>Ignoring of marked unit threat scale is now |cff00ff00ON!|r<<--") else return print("-->>Ignoring of marked unit threat scale is now |cffff0000OFF!|r<<--") end
									TidyPlates:ReloadTheme()
								end
							},
							header2 = {
								order = 5,
								name = "Threat Ignored Settings",
								type = 'header',
							},
							Marked_Scale = {
								type 	= "range",
								order 	= 6,
								name 	= "Marked Scale",
								arg 	= "Marked",
								get 	= GetNameplateScale,
								set		= SetNameplateScale,
								step = 0.05,
								min = 0.3,
								max = 2,
								isPercent = true,
							},
							Marked_Alpha = {
								type 	= "range",
								order 	= 7,
								name 	= "Marked Alpha",
								arg 	= "Marked",
								get 	= GetNameplateAlpha,
								set		= SetNameplateAlpha,
								step = 0.05,
								min = 0,
								max = 1,
								isPercent = true,
							},
						},
					},
					SpecSetting = {
						name = "|cffffffffDual Spec Settings|r",
						type = "group",
						desc = "Set the role your primary and secondary spec represent.",
						order = 4,
						args = {
							header = {
								order = 1,
								name = "Dual Spec Settings",
								type = "header"
							},
							description = {
								order = 2,
								name = "Select your role for your primary and secondary specs.",
								type = "description"
							},
							primary = {
								order = 3,
								name = "Primary Spec",
								type = "header"
							},
							primaryTank = {
								order = 4,
								name = "Tank",
								type = "toggle",
								desc = "Sets your primary spec to tanking.",
								get = function() return TidyPlatesThreat.db.char.spec.primary end,
								set = function(info,val) 
									TidyPlatesThreat.db.char.spec.primary = true
									if GetActiveTalentGroup() == 1 then
										TidyPlatesThreat.db.char.threat.tanking = true
									end
									
									TidyPlates:ReloadTheme()
								end
							},
							primaryDPS = {
								order = 5,
								name = "DPS",
								type = "toggle",
								desc = "Sets your primary spec to DPS.",
								get = function() return not TidyPlatesThreat.db.char.spec.primary end,
								set = function(info,val) 
									TidyPlatesThreat.db.char.spec.primary = false
									if GetActiveTalentGroup() == 1 then
										TidyPlatesThreat.db.char.threat.tanking = false
									end
									
									TidyPlates:ReloadTheme()
								end
							},
							secondary = {
								order = 6,
								name = "Secondary Spec",
								type = "header"
							},
							secondaryTank = {
								order = 7,
								name = "Tank",
								type = "toggle",
								desc = "Sets your secondary spec to tanking.",
								get = function() return TidyPlatesThreat.db.char.spec.secondary end,
								set = function(info,val) 
									TidyPlatesThreat.db.char.spec.secondary = true
									if GetActiveTalentGroup() == 2 then
										TidyPlatesThreat.db.char.threat.tanking = true
									end
									
									TidyPlates:ReloadTheme()
								end
							},
							secondaryDPS = {
								order = 8,
								name = "DPS",
								type = "toggle",
								desc = "Sets your secondary spec to DPS.",
								get = function() return not TidyPlatesThreat.db.char.spec.secondary end,
								set = function(info,val) 
									TidyPlatesThreat.db.char.spec.secondary = false
									if GetActiveTalentGroup() == 2 then
										TidyPlatesThreat.db.char.threat.tanking = false
									end
									
									TidyPlates:ReloadTheme()
								end
							},
						},
					},
				},
			},
			About = {
		        order = 6,
		        type  = "group",
       			name  = "About",
		        args = {
					About = {
						type = "description",
						order = 1,
						name = "Clear and easy to use nameplate theme for use with TidyPlates.\n\nFeel free to email me at |cff00ff00Shamtasticle@gmail.com|r\n\n|cff2459FFSyronius|r, of Black Dragonflight - US <Fallout>",
					},
				},
			},
		},
	}
	
function TidyPlatesThreat:RegisterOptions()
	local profile = LibStub('AceDBOptions-3.0'):GetOptionsTable(self.db)
	local registry = LibStub('AceConfigRegistry-3.0')
	local dialog = LibStub('AceConfigDialog-3.0')

	registry:RegisterOptionsTable("Threat Plates Options", options)
	registry:RegisterOptionsTable("Threat Plates Profiles",  profile)
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Threat Plates Options", "Threat Plates Options")
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Threat Plates Profiles", 'Profiles', "Threat Plates Options")
	
	self:RegisterChatCommand("tptp", function () InterfaceOptionsFrame_OpenToCategory(self.optionsFrame) end)
end