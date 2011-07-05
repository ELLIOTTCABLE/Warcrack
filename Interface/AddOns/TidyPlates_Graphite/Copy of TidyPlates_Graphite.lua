--TidyPlatesThemeList["Graphite"] = {}
local StyleDefault = {}
local Theme = {}
local path = "Interface\\Addons\\TidyPlates_Graphite" 

local artwidth = 128
local borderheight = 16
local barheight = 16
local widthfactor = .6
local heightfactor = .8


StyleDefault.healthborder = {
	texture	= path.."\\HealthBorder",
	glowtexture 			= path.."\\Mouseover",
	elitetexture = path.."\\HealthBorder",
	width = artwidth*widthfactor,
	height = borderheight*heightfactor,
	x = 0,
	y = 0,
}

StyleDefault.target = {
	texture = path.."\\TextPlate_Target",
	height = 46,
	width = 256,
	
}
--StyleTextOnly.target.y = 21
--StyleTextOnly.target.height = 46
--StyleTextOnly.target.texture = EmptyTexture

StyleDefault.highlight = {
	texture	= path.."\\Mouseover",
	width = artwidth*widthfactor,
	height = borderheight*heightfactor,
	x = 0,
	y = 0,
}

StyleDefault.healthbar = {
	texture 				= path.."\\StatusBar",
	width = 98*widthfactor,
	--width = 96*widthfactor,
	height = barheight*heightfactor,
	x = 0,
	y = 0,
}

StyleDefault.threatborder = {
	texture = path.."\\Empty",
	elitetexture = path.."\\Empty",
}

StyleDefault.castborder = {
	texture	= path.."\\HealthBorder",
	glowtexture 			= path.."\\HealthBorder",
	elitetexture = path.."\\HealthBorder",
	width = artwidth*widthfactor,
	height = borderheight*heightfactor,
	anchor = "CENTER",
	x = 0,
	y = -6,
}

StyleDefault.castbar = {
	texture 				= path.."\\StatusBar",
	width = 96*widthfactor,
	height = barheight*heightfactor,
	anchor = "CENTER",
	x = 0,
	y = -6,
}

--[[
StyleDefault.spellicon = {
	height = 12,
	width = 12,
	x = 0,
	y = -7,
	show = true,
}
--]]

StyleDefault.spellicon = {
	height = 12,
	width = 12,
	x = -38,
	y = -4,
	show = true,
}


StyleDefault.name = {
	typeface = "Interface\\Addons\\TidyPlates_Neon\\Media\\Qlassik_TB.ttf",
	
	size = 10,
	width = 175,
	height = 14,
	x = 0,
	y = 7,	-- For OVER the bar
	--y = -7,		-- For UNDER the bar
	align = "CENTER",
	anchor = "CENTER",
	vertical = "CENTER",
	--flags = "",
	shadow = true,
	show = true,
}

-- /run TidyPlatesThemeList["Graphite"].spellicon.x = 4

-- Test Cast Bar: 
--/run TestTidyPlatesCastBar("Boognish", 133)

StyleDefault.spelltext = {
	typeface = "Interface\\Addons\\TidyPlates_Neon\\Media\\Qlassik_TB.ttf",
	
	size = 10,
	width = 175,
	height = 14,
	x = 0,
	y = -16,		-- For UNDER the bar
	align = "CENTER",
	anchor = "CENTER",
	vertical = "CENTER",
	--flags = "",
	shadow = false,
	show = true,
}

StyleDefault.level = {
	typeface = "Interface\\Addons\\TidyPlates_Neon\\Media\\Qlassik_TB.ttf",
	show = false,
}

StyleDefault.customtext = {
	typeface = "Interface\\Addons\\TidyPlates_Neon\\Media\\Qlassik_TB.ttf",
	
	size = 10,
	width = 175,
	height = 14,
	x = 0,
	y = 7,	-- For OVER the bar
	--y = -7,		-- For UNDER the bar
	align = "CENTER",
	anchor = "CENTER",
	vertical = "CENTER",
	--flags = "",
	shadow = true,
	show = false,
}



StyleDefault.raidicon = {
	width = 18,
	height = 18,
	x = 0,
	y = 0,
	anchor = "LEFT",
}

StyleDefault.frame = {
	x = 0,
	y = 11,
}

StyleDefault.hitbox = {
	width = 100,
	height = 35,
}

StyleDefault.skullicon = {
	show = false,
}

-- No-Bar Style		(6.2)
local StyleTextOnly = CopyTable(StyleDefault)
StyleTextOnly.threatborder.texture = EmptyTexture
StyleTextOnly.healthborder.texture = EmptyTexture
StyleTextOnly.healthbar.texture = EmptyTexture
StyleTextOnly.healthbar.backdrop = EmptyTexture
StyleTextOnly.name.typeface = "Interface\\Addons\\TidyPlates_Neon\\Media\\Qlassik_TB.ttf"
--StyleTextOnly.eliteicon.texture = EmptyTexture
StyleTextOnly.customtext.align = "CENTER"
StyleTextOnly.customtext.size = 10
StyleTextOnly.customtext.y = 16
StyleTextOnly.level.show = false
StyleTextOnly.skullicon.show = false
StyleTextOnly.eliteicon = {show = false}
--StyleTextOnly.raidicon.x = 
--StyleTextOnly.raidicon.y = 
StyleTextOnly.highlight.texture = path.."\\TextPlate_Highlight"
StyleTextOnly.target.texture = path.."\\TextPlate_Target"
--StyleTextOnly.target.y = 21
--StyleTextOnly.target.height = 46
--StyleTextOnly.target.texture = EmptyTexture

local WidgetConfig = {}
WidgetConfig.ClassIcon = { anchor = "TOP" , x = 0,y = 26 }		-- Above Name
--WidgetConfig.ClassIcon = { anchor = "TOP" , x = -35 ,y = 14 }		-- Aside Name
--WidgetConfig.ClassIcon = { anchor = "TOP" , x = -26 ,y = 10 }		-- Upper Left on Bar
--WidgetConfig.ClassIcon = { anchor = "TOP" , x = 46 ,y = -8 }		-- Right, Opposite Spell Icon (not done)
WidgetConfig.TotemIcon = { anchor = "TOP" , x = 0 ,y = 26 }
--WidgetConfig.ThreatLineWidget = { anchor =  "TOP", x = 0 ,y = -7 }
WidgetConfig.ThreatLineWidget = { anchor =  "TOP", x = 0 ,y = 20 }	-- y = 20
--WidgetConfig.ThreatLineWidget = { anchor =  "TOP", x = 0 ,y = -2 }	-- y = 20
-- WidgetConfig.ThreatWheelWidget = { anchor =  "CENTER", x = 60 ,y = 15 } 
WidgetConfig.ThreatWheelWidget = { anchor =  "CENTER", x = 33 ,y = 27 } -- "CENTER", plate, 30, 18
WidgetConfig.ComboWidget = { anchor = "TOP" , x = 0 ,y = 0 }
WidgetConfig.RangeWidget = { anchor = "CENTER" , x = 0 ,y = 12 }
WidgetConfig.DebuffWidget = { anchor = "TOP" , x = 15 ,y = 33 }

local DamageThemeName = "Graphite/|cFFFF4400Damage"
local TankThemeName = "Graphite/|cFF3782D1Tank"

---------------------------------------------
-- Tidy Plates Hub Integration
---------------------------------------------
--Theme["Default"] = StyleDefault
--Theme["NameOnly"] = StyleTextOnly			-- (6.2)
Theme = StyleDefault

TidyPlatesThemeList[DamageThemeName] = Theme
local LocalVars = TidyPlatesHubDamageVariables

-- (6.2)

local function ApplyFontCustomization(style)
	local currentFont = font
	if LocalVars.TextUseBlizzardFont then currentFont = blizzfont end
	style.name.typeface = currentFont
	--style.level.typeface = currentFont
	style.customtext.typeface = currentFont
	style.spelltext.typeface = currentFont
	
	style.frame.y = ((LocalVars.FrameVerticalPosition-.5)*50)-16
end

local function OnApplyStyleCustomization(style)
	--style.level.show = (LocalVars.TextShowLevel == true)
	style.target.show = (LocalVars.WidgetTargetHighlight == true)
	--style.eliteicon.show = (LocalVars.WidgetEliteIndicator == true)
	ApplyFontCustomization(style)
end

local function OnApplyThemeCustomization(theme)
	OnApplyStyleCustomization(Theme)
	--OnApplyStyleCustomization(theme["Default"])
	--ApplyFontCustomization(theme["NameOnly"])
	TidyPlates:ForceUpdate()
end

local function OnApplyDamageCustomization()
	OnApplyThemeCustomization(Theme)
end

local function OnInitialize(plate)
	TidyPlatesHubFunctions.OnInitializeWidgets(plate, WidgetConfig)
end

local function OnActivateTheme(themeTable)
		if Theme == themeTable then
			LocalVars = TidyPlatesHubFunctions:UseDamageVariables()
			OnApplyDamageCustomization()
		end
end

local function StyleDelegate(unit)
	return "Default"
end

Theme.SetNameColor = TidyPlatesHubFunctions.SetNameColor
Theme.SetScale = TidyPlatesHubFunctions.SetScale
Theme.SetAlpha = TidyPlatesHubFunctions.SetAlpha
Theme.SetHealthbarColor = TidyPlatesHubFunctions.SetHealthbarColor
Theme.SetThreatColor = TidyPlatesHubFunctions.SetThreatColor
Theme.SetCastbarColor = TidyPlatesHubFunctions.SetCastbarColor
Theme.SetCustomText = TidyPlatesHubFunctions.SetCustomText
Theme.OnUpdate = TidyPlatesHubFunctions.OnUpdate
Theme.OnContextUpdate = TidyPlatesHubFunctions.OnContextUpdate
Theme.ShowConfigPanel = ShowTidyPlatesHubDamagePanel
--Theme.SetStyle = StyleDelegate

-- [[ (6.2)
local function GetLevelDescription(unit)
	local description
	if unit.reaction ~= "FRIENDLY" then
		description = "Level "..unit.level
		if unit.isElite then description = description.." (Elite)" end
		return description
	end
end

local HubCustomText = TidyPlatesHubFunctions.SetCustomText
local function CustomText(unit)
	if unit.style == "NameOnly" then
		local description, elite
		if TidyPlatesData.UnitDescriptions and unit.type == "NPC" then
			return (TidyPlatesData.UnitDescriptions[unit.name] or GetLevelDescription(unit) or "") , 1, 1, 1, .70
		end
	end
	return HubCustomText(unit) 
end
Theme.SetCustomText = CustomText

local StyleIndex = {"Default", "NameOnly"}
local function SetStyleDelegate(unit)
	return "Default"
	--return StyleIndex[TidyPlatesHubFunctions.SetMultistyle(unit)] or "Default"
end

--Theme.SetStyle = SetStyleDelegate		-- (6.2)

local GreyColor = { r = 98/255, g = 98/255, b = 98/255}
local function NameColorDelegate(unit)
	local class = TidyPlatesData.UnitClass[unit.name]
	local color
	if class then 
		color = RAID_CLASS_COLORS[class]
	end
	if color then return color.r, color.g, color.b end
	return TidyPlatesHubFunctions.SetNameColor(unit)
end
--Theme.SetNameColor = NameColorDelegate
--]]

Theme.OnInitialize = OnInitialize		-- Need to provide widget positions
Theme.OnActivateTheme = OnActivateTheme -- called by Tidy Plates Core, Theme Loader
Theme.OnApplyThemeCustomization = OnApplyDamageCustomization -- Called By Hub Panel

do
	local TankTheme = CopyTable(Theme)
	TidyPlatesThemeList[TankThemeName] = TankTheme
	
	local function OnApplyTankCustomization()
		OnApplyThemeCustomization(TankTheme)  -- OnApplyTankCustomization
	end

	local function OnActivateTheme(themeTable)
		if TankTheme == themeTable then
			LocalVars = TidyPlatesHubFunctions:UseTankVariables()
			OnApplyTankCustomization()
		end
	end
	
	TankTheme.OnActivateTheme = OnActivateTheme -- called by Tidy Plates Core, Theme Loader
	TankTheme.OnApplyThemeCustomization = OnApplyTankCustomization -- Called By Hub Panel
	TankTheme.ShowConfigPanel = ShowTidyPlatesHubTankPanel
end