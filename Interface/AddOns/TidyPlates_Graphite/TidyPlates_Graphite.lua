-----------------------------------------------------
-- Theme Definition
-----------------------------------------------------
local Theme = {}
local ThemeName = "Graphite"
local CopyTable = TidyPlatesUtility.copyTable

local path = "Interface\\Addons\\TidyPlates_Graphite\\" 
local font =					path.."Qlassik_TB.ttf"
local blizzfont =				NAMEPLATE_FONT

local castoffset = 1

local artwidth = 128
local borderheight = 16
local barheight = 16
local widthfactor = .6
local heightfactor = .8

local StyleDefault = {}

Theme.SetStatusbarWidthMatching = true

StyleDefault.hitbox = {
	width = 100,
	height = 35,
}

StyleDefault.frame = {
	--width = 100,
	--height = 45,
	x = 0,
	y = 0,		-- (-12) To put the bar near the middle
	anchor = "CENTER",
}

StyleDefault.healthborder = {
	texture	= path.."HealthBorder",
	--width = artwidth*widthfactor,
	width = 2,
	height = borderheight*heightfactor,
	x = 0,
	y = 0,
}

StyleDefault.healthbar = {
	texture 				= path.."StatusBar",
	width = 2,
	--width = 96*widthfactor,
	height = barheight*heightfactor,
	x = 0,
	y = 4,
}

StyleDefault.target = {
	texture 			= path.."Graphite2_Target_Backup",
	--width = 128,
	width = 16,
	--height = 36,
	height = borderheight*heightfactor,
	x = 0,
	y = 0,
	anchor = "CENTER",
	show = true,
}

StyleDefault.highlight = {
	texture 			= path.."Mouseover",
}

StyleDefault.threatborder = {
	texture = path.."Empty",
}

StyleDefault.castbar = {
	texture 				= path.."Graphite2_StatusBar",
	width = artwidth*widthfactor,
	height = barheight*heightfactor,
	anchor = "CENTER",
	x = 0,
	y = -8+castoffset,
}

StyleDefault.castborder = {
	texture	= path.."HealthBorder",
	width = artwidth*widthfactor,
	height = borderheight*heightfactor,
	anchor = "CENTER",
	x = 0,
	y = -3+castoffset,
}

StyleDefault.castnostop = {
	texture	= path.."HealthBorder",
	width = artwidth*widthfactor,
	height = borderheight*heightfactor,
	anchor = "CENTER",
	x = 0,
	y = -3+castoffset,
}

StyleDefault.name = {
	typeface =					font,
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

StyleDefault.level = {
	typeface =					font,
	show = false,
}



StyleDefault.customtext = {
	typeface =					font,
	size = 10,
	width = 175,
	height = 14,
	x = 0,
	y = -1,	-- For OVER the bar
	--y = -7,		-- For UNDER the bar
	align = "CENTER",
	anchor = "CENTER",
	vertical = "CENTER",
	--flags = "",
	shadow = true,
	show = true,
}

StyleDefault.spelltext = {
	typeface =					font,
	size = 10,
	width = 175,
	height = 14,
	x = 0,
	y = -12+castoffset,		-- For UNDER the bar
	align = "CENTER",
	anchor = "CENTER",
	vertical = "CENTER",
	--flags = "",
	shadow = true,
	show = true,
}

StyleDefault.spellicon = {
	height = 20,
	width = 20,
	x = 0,
	y = -26,
	show = true,
}

StyleDefault.eliteicon = {
	show = false,
}

StyleDefault.raidicon = {
	width = 12,
	height = 12,
	x = 0,
	y = 12,
	anchor = "CENTER",
}

StyleDefault.skullicon = {
	show = false,
}

StyleDefault.threatcolor = {
	LOW = {r = .6, g = 1, b = 0, a = 0,},
	MEDIUM = {r = .6, g = 1, b = 0, a = 1,},
	HIGH = {r = 1, g = 0, b = 0, a= 1,},  }

	
-- No-Bar Style		(6.2)
local StyleTextOnly = CopyTable(StyleDefault)
StyleTextOnly.threatborder.texture = EmptyTexture
StyleTextOnly.healthborder.texture = EmptyTexture
StyleTextOnly.healthbar.texture = EmptyTexture
StyleTextOnly.healthbar.backdrop = EmptyTexture
StyleTextOnly.eliteicon.texture = EmptyTexture
StyleTextOnly.customtext.align = "CENTER"
StyleTextOnly.customtext.size = 9
StyleTextOnly.customtext.y = -2
StyleTextOnly.level.show = false
StyleTextOnly.skullicon.show = false
StyleTextOnly.eliteicon.show = false
--StyleTextOnly.raidicon.x = 
--StyleTextOnly.raidicon.y = 
StyleTextOnly.highlight.texture = path.."TextPlate_Highlight"
StyleTextOnly.target.texture = path.."TextPlate_Target"
StyleTextOnly.target.y = -3
StyleTextOnly.target.width = 128
StyleTextOnly.target.height = 36
--StyleTextOnly.target.texture = EmptyTexture

local WidgetConfig = {}
WidgetConfig.ClassIcon = { anchor = "TOP" , x = 0,y = 26 }		-- Above Name
WidgetConfig.TotemIcon = { anchor = "TOP" , x = 0 ,y = 26 }
WidgetConfig.ThreatLineWidget = { anchor =  "TOP", x = 0 ,y = 0 }	-- y = 20
--WidgetConfig.ThreatWheelWidget = { anchor =  "CENTER", x = 33 ,y = 12 } -- "CENTER", plate, 30, 18
WidgetConfig.ThreatWheelWidget = { anchor =  "CENTER", x = 0 ,y = 16 } -- "CENTER", plate, 30, 18
WidgetConfig.ComboWidget = { anchor = "CENTER" , x = 0 ,y = 16 }
WidgetConfig.RangeWidget = { anchor = "CENTER" , x = 0 ,y = 12 }
WidgetConfig.DebuffWidget = { anchor = "TOP" , x = 15 ,y = 15 }

local DamageThemeName = ThemeName.."/|cFFFF4400Damage"
local TankThemeName = ThemeName.."/|cFF3782D1Tank"

---------------------------------------------
-- Tidy Plates Hub Integration
---------------------------------------------
Theme["Default"] = StyleDefault
Theme["NameOnly"] = StyleTextOnly			-- (6.2)

TidyPlatesThemeList[DamageThemeName] = Theme
local LocalVars = TidyPlatesHubDamageVariables

-- (6.2)

local function ApplyFontCustomization(style)
	local currentFont = font
	if LocalVars.TextUseBlizzardFont then currentFont = blizzfont end
	style.name.typeface = currentFont
	style.level.typeface = currentFont
	style.customtext.typeface = currentFont
	style.spelltext.typeface = currentFont
	
	style.frame.y = ((LocalVars.FrameVerticalPosition-.5)*50)-16
end

local function OnApplyStyleCustomization(style)
	style.level.show = (LocalVars.TextShowLevel == true)
	style.target.show = (LocalVars.WidgetTargetHighlight == true)
	style.eliteicon.show = (LocalVars.WidgetEliteIndicator == true)
	ApplyFontCustomization(style)
end

local function OnApplyThemeCustomization(theme)
	OnApplyStyleCustomization(theme["Default"])
	ApplyFontCustomization(theme["NameOnly"])
	TidyPlates:ForceUpdate()
end

local function OnApplyDamageCustomization()
	OnApplyThemeCustomization(Theme)
end

local function OnInitialize(plate)
	TidyPlatesHubFunctions.OnInitializeWidgets(plate, WidgetConfig)
	if plate.widgets.DebuffWidget then plate.widgets.DebuffWidget:SetScale(.75) end
	if plate.widgets.ThreatLineWidget then plate.widgets.ThreatLineWidget:SetScale(.75) end
	if plate.widgets.ThreatWheelWidget then plate.widgets.ThreatWheelWidget:SetScale(.70) end
	if plate.widgets.ComboWidget then plate.widgets.ComboWidget:SetScale(.70) end
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
Theme.SetStyle = StyleDelegate

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
	return StyleIndex[TidyPlatesHubFunctions.SetMultistyle(unit)] or "Default"
end

Theme.SetStyle = SetStyleDelegate		-- (6.2)

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


