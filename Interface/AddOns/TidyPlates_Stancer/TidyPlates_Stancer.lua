local defaults = {
	on = false,
	["WARRIOR"] = {
		[0] = "None", -- No Stance
		[1] = "None", -- Battle Stance
		[2] = "None", -- Defensive Stance
		[3] = "None" -- Berserker Stance
	},
	["DRUID"] = {
		[0] = "None", -- Caster Form
		[1] = "None", -- Bear Form
		[2] = "None", -- Aquatic Form
		[3] = "None", -- Cat Form
		[4] = "None", -- Travel Form				
		[5] = "None", -- Moonkin Form, Tree of Life, (Swift) Flight Form
		[6] = "None" -- Flight Form (if moonkin or tree spec'd)
	},
	["PALADIN"] = {
		[0] = "None", -- No Aura
		[1] = "None", -- Devotion Aura
		[2] = "None", -- Retribution Aura
		[3] = "None", -- Concentration Aura
		[4] = "None", -- Resistance Aura
		[5] = "None" -- Crusader Aura
	},
	["DEATHKNIGHT"] = {
		[0] = "None", -- No Presence
		[1] = "None", -- Blood
		[2] = "None", -- Frost
		[3] = "None" -- Unholy
	},
}

local _,class = UnitClass("player")
local db
local addon = ">> "..GetAddOnMetadata("TidyPlates_Stancer", "title")..": "

local function SetTheme(theme)
	if TidyPlatesThemeList[theme] and type(TidyPlatesThemeList[theme]) == "table" then
		TidyPlates:ActivateTheme(TidyPlatesThemeList[theme])
		if GetActiveTalentGroup() == 1 then
			TidyPlatesOptions.primary = theme
		else
			TidyPlatesOptions.secondary = theme
		end
	else
		print(addon.."Theme table not found.")
	end
end

local commands = {}

commands.toggle = function()
	if TidyPlates_StancerDB.on then
		TidyPlates_StancerDB.on = false
		print(addon.."Now disabled.")
	else
		TidyPlates_StancerDB.on = true
		print(addon.."Now enabled.")
		SetTheme(TidyPlates_StancerDB[class][GetShapeshiftForm()])
	end
	TidyPlates:ForceUpdate()
end

commands.set = function(theme)
	if TidyPlatesThemeList[theme] and type(TidyPlatesThemeList[theme]) == "table" then
		SetTheme(theme)
		TidyPlates_StancerDB[class][GetShapeshiftForm()] = theme
		local icon, name, active, castable
		if GetShapeshiftForm() ~= 0 then
			icon, name, active, castable = GetShapeshiftFormInfo(GetShapeshiftForm())
		else
			name = "No stance or caster form"
		end
		print(addon.."Theme set to '"..theme.."' for '"..name.."'.")
	end
end

commands.list = function()
	if type(TidyPlatesThemeList) == "table" then
		for themename, themepointer in pairs(TidyPlatesThemeList) do
			print(themename)
		end
	end
end

commands.settings = function()
	local function enabled() 
		if TidyPlates_StancerDB.on then 
			return "enabled." 
		else 
			return "disabled."
		end
	end
	print(addon.." is currently "..enabled())
	for i=0,#TidyPlates_StancerDB[class] do
		print("Stance/Form '"..i.."' is set to: "..TidyPlates_StancerDB[class][i])
	end
end

local function TPSTANCER_COMMANDS(arg)
	local c,argument,_ = strsplit(" ", arg, 2)
	if c then
		c = strlower(c)
	end
	if c == "toggle" or c == "settings" or c == "list" then
		commands[c]()
	elseif c == "set" then
		if argument then
			commands[c](argument)
		else
			print(addon.."No theme name found.")
		end
	elseif c == "about" then
		print(addon.."Created by Suicidal Katt. Currently a work in progress.")
	else
		print(addon.."Available commands are '/tpstancer' 'toggle', 'set', 'list', 'settings', or 'about'")
	end
end

local function CreateSlashCommands()	
	SLASH_TIDYPLATESSTANCER1 = "/tpstancer";
	SlashCmdList["TIDYPLATESSTANCER"] = TPSTANCER_COMMANDS
end

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event,...)
	local arg1, arg2, arg3 = ...
	if event == "ADDON_LOADED" then
		if arg1 == "TidyPlates_Stancer" then
			if class == "WARRIOR" or class == "DRUID" or class == "PALADIN" or class == "DEATHKNIGHT" then
				self:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
				if not TidyPlates_StancerDB then
					TidyPlates_StancerDB = defaults
				end
				
				db = TidyPlates_StancerDB
				
				if db.on then
					SetTheme(db[class][GetShapeshiftForm()])
				end
				
				CreateSlashCommands()
			else
				print(addon.."Your class has no stances or cannot shapeshift, disabling AddOn for this character.")
				DisableAddOn("TidyPlates_Stancer")
			end
		end
	elseif event == "UPDATE_SHAPESHIFT_FORM" then
		if db.on then
			SetTheme(db[class][GetShapeshiftForm()])
		end
	end
end)