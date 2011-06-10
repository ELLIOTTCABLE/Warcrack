

local copytable = TidyPlatesUtility.copyTable
local mergetable = TidyPlatesUtility.mergeTable
local PanelHelpers = TidyPlatesUtility.PanelHelpers

local currentThemeName = ""
local activespec = "primary"
local useAutohide = false

local defaultPrimaryTheme = "Neon/|cFFFF4400Damage"
local defaultSecondaryTheme = "Neon/|cFF3782D1Tank"

local function SetAutoHide(option) 
	useAutoHide = option
	if useAutoHide and (not InCombat) then SetCVar("nameplateShowEnemies", 0) end 
end

local function SetSpellCastWatcher(enable)
	if enable then TidyPlates:StartSpellCastWatcher()
	else TidyPlates:StopSpellCastWatcher()	end
end


-------------------------------------------------------------------------------------
--  Default Options
-------------------------------------------------------------------------------------

TidyPlatesOptions = {
	primary = defaultPrimaryTheme,
	secondary = defaultSecondaryTheme,
	autohide = false, 
	EnableCastWatcher = false, 
	WelcomeShown = false,
}
	
local TidyPlatesOptionsDefaults = copytable(TidyPlatesOptions)
local TidyPlatesThemeNames = {}
local warned = {}

-------------------------------------------------------------------------------------
-- Pre-Processor
-------------------------------------------------------------------------------------
local function LoadTheme(incomingtheme) 
	local theme, style, stylename, newvalue, propertyname, oldvalue
	
	-- Sends a notification to all available themes, if possible.
	for themename, themetable in pairs(TidyPlatesThemeList) do
		if themetable.OnActivateTheme then themetable.OnActivateTheme(nil, nil) end
	end
	
	-- Get theme table
	if type(TidyPlatesThemeList) == "table" then 
		if type(incomingtheme) == 'string' then 
			theme = TidyPlatesThemeList[incomingtheme] 
		end
	end
	
	-- If theme does not exist, try to use the default themes
	--[[
	if type(theme) ~= 'table' then 
		if activespec == "primary" then
			theme = TidyPlatesThemeList[defaultPrimaryTheme] 
		else 
			theme = TidyPlatesThemeList[defaultSecondaryTheme] 
		end
	end
	--]]
	
	-- Try to load theme	
	if type(theme) == 'table' then 
		if theme.SetStyle and type(theme.SetStyle) == "function" then
			-- Multi-Style Theme
			for stylename, style in pairs(theme) do
				if type(style) == "table" then theme[stylename] = mergetable(TidyPlates.Template, style) end 
			end
		else 	
			-- Single-Style Theme
			for propertyname, oldvalue in pairs(TidyPlates.Template) do
				newvalue = theme[propertyname]
				if type(newvalue) == "table" then theme[propertyname] = mergetable(oldvalue, newvalue)
				else theme[propertyname] = copytable(oldvalue) end 	
			end
		end
		-- Choices: Overwrite incomingtheme as it's processed, or Overwrite after the processing is done
		TidyPlates:ActivateTheme(theme)	
		if theme.OnActivateTheme then theme.OnActivateTheme(theme, incomingtheme) end
		currentThemeName = incomingtheme
		return theme
	else
		TidyPlatesOptions[activespec] = "None"
		currentThemeName = "None"
		TidyPlates:ActivateTheme(TidyPlatesThemeList["None"])
		return nil
	end

	--if TidyPlates.PostLoadTheme and type(TidyPlates.PostLoadTheme) == "function" then TidyPlates:PostLoadTheme() end
end

--TidyPlates.PostLoadTheme = function() end
TidyPlates.LoadTheme = LoadTheme
TidyPlates._LoadTheme = LoadTheme

function TidyPlates:ReloadTheme()
	LoadTheme(TidyPlatesOptions[activespec])
	TidyPlates:ForceUpdate()
end
	
-------------------------------------------------------------------------------------
-- Panel
-------------------------------------------------------------------------------------
local ThemeDropdownMenuItems = {}
local ApplyPanelSettings

local version = GetAddOnMetadata("TidyPlates", "version")
local versionString = string.gsub(string.gsub(string.gsub(version, "%$", ""), "%(", ""), "%)", "")
--local versionString = string.gsub(version, "%$", "")
local addonString = GetAddOnMetadata("TidyPlates", "title")
local titleString = addonString.." "..versionString
local firstShow = true

local panel = PanelHelpers:CreatePanelFrame( "TidyPlatesInterfaceOptions", "Tidy Plates", titleString )
local helppanel = PanelHelpers:CreatePanelFrame( "TidyPlatesInterfaceOptionsHelp", "Troubleshooting" )
panel:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", insets = { left = 2, right = 2, top = 2, bottom = 2 },})
panel:SetBackdropColor(0.06, 0.06, 0.06, 1)

-- Convert the Theme List into a Menu List
local function UpdateThemeNames()
	local themecount = 1
	if type(TidyPlatesThemeList) == "table" then
		for themename, themepointer in pairs(TidyPlatesThemeList) do
			TidyPlatesThemeNames[themecount] = themename
			--TidyPlatesThemeIndexes[themename] = themecount
			themecount = themecount + 1
		end
		-- Theme Choices
		for index, name in pairs(TidyPlatesThemeNames) do ThemeDropdownMenuItems[index] = {text = name, notCheckable = 1 } end
	end
	sort(ThemeDropdownMenuItems, function (a,b)		
	  return (a.text < b.text)
    end)
end


local function ConfigureTheme(spec)
	local themename = TidyPlatesOptions[spec]
	if themename then 
		local theme = TidyPlatesThemeList[themename]
		--print("Opening Interface Panel for", themename, theme)
		if theme and theme.ShowConfigPanel and type(theme.ShowConfigPanel) == 'function' then theme.ShowConfigPanel() end
	end
end

local function ThemeHasPanelLink(themename)
	if themename then
		local theme = TidyPlatesThemeList[themename]
		if theme and theme.ShowConfigPanel and type(theme.ShowConfigPanel) == 'function' then return true end
	end
end
		

local function ActivateInterfacePanel()
	---- Note 
	local offset = -28
	panel.label = panel:CreateFontString(nil, 'ARTWORK') --, 'GameFontLarge'
	panel.label:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
	panel.label:SetPoint("TOPLEFT", panel, "TOPLEFT", 35, -45)
	panel.label:SetWidth(340)
	panel.label:SetJustifyH("LEFT")
	panel.label:SetText(
		"Please choose a theme for your Primary and Secondary Specializations. "
		.."The appropriate theme will be automatically activated when you switch specs.")
	panel.label:SetTextColor(1,1,1,1)


	----------------------
	-- Primary Spec
	----------------------
	--  Dropdown
	panel.PrimarySpecTheme = PanelHelpers:CreateDropdownFrame("TidyPlatesChooserDropdown", panel, ThemeDropdownMenuItems, "None", nil, true)
	panel.PrimarySpecTheme:SetPoint("TOPLEFT", 16, -80+offset)
	
	-- [[	Edit Button
	panel.PrimaryEditButton = CreateFrame("Button", "TidyPlatesEditButton", panel)
	panel.PrimaryEditButton:SetPoint("LEFT", panel.PrimarySpecTheme, "RIGHT", 29, 2)
	panel.PrimaryEditButton.Texture = panel.PrimaryEditButton:CreateTexture(nil, "OVERLAY")
	panel.PrimaryEditButton.Texture:SetAllPoints(panel.PrimaryEditButton)
	panel.PrimaryEditButton.Texture:SetTexture( "Interface\\Addons\\TidyPlates\\media\\Wrench")
	panel.PrimaryEditButton:SetHeight(16)
	panel.PrimaryEditButton:SetWidth(16)
	panel.PrimaryEditButton:Enable()
	panel.PrimaryEditButton:EnableMouse()
	panel.PrimaryEditButton:SetScript("OnClick", function() ConfigureTheme("primary") end)
	--]]
	
	-- Label 
	panel.PrimaryLabel = panel:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
	panel.PrimaryLabel:SetPoint("BOTTOMLEFT", panel.PrimarySpecTheme,"TOPLEFT", 20, 5)
	panel.PrimaryLabel:SetWidth(170)
	panel.PrimaryLabel:SetJustifyH("LEFT")

	----------------------
	-- Secondary Spec
	----------------------
	-- Dropdown
	panel.SecondarySpecTheme = PanelHelpers:CreateDropdownFrame("TidyPlatesChooserDropdown2", panel, ThemeDropdownMenuItems, "None", nil, true)
	panel.SecondarySpecTheme:SetPoint("TOPLEFT",panel.PrimarySpecTheme, "TOPRIGHT", 45, 0)

	-- [[	Edit Button
	panel.SecondaryEditButton = CreateFrame("Button", "TidyPlatesEditButton", panel)
	panel.SecondaryEditButton:SetPoint("LEFT", panel.SecondarySpecTheme, "RIGHT", 29, 2)
	panel.SecondaryEditButton.Texture = panel.SecondaryEditButton:CreateTexture(nil, "OVERLAY")
	panel.SecondaryEditButton.Texture:SetAllPoints(panel.SecondaryEditButton)
	panel.SecondaryEditButton.Texture:SetTexture( "Interface\\Addons\\TidyPlates\\media\\Wrench")
	panel.SecondaryEditButton:SetHeight(16)
	panel.SecondaryEditButton:SetWidth(16)
	panel.SecondaryEditButton:Enable()
	panel.SecondaryEditButton:EnableMouse()
	panel.SecondaryEditButton:SetScript("OnClick", function() ConfigureTheme("secondary") end)
	--]]

	-- Label 
	panel.SecondaryLabel = panel:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
	panel.SecondaryLabel:SetPoint("BOTTOMLEFT", panel.SecondarySpecTheme,"TOPLEFT", 20, 5)
	panel.SecondaryLabel:SetWidth(170)
	panel.SecondaryLabel:SetJustifyH("LEFT")
	--panel.SecondaryLabel:SetText("Secondary Spec:")

	----------------------
	-- Other Options
	----------------------

	-- [[ Autohide:
	panel.AutoHide = PanelHelpers:CreateCheckButton("TidyPlatesOptions_Autohide", panel, "Auto-Show Enemy Plates During Combat")
	--panel.AutoHide:SetPoint("TOPLEFT", panel.AllowOverlap, "TOPLEFT", 0, -35)\
	panel.AutoHide:SetPoint("TOPLEFT", panel.PrimarySpecTheme, "TOPLEFT", 16, -55)
	panel.AutoHide:SetScript("OnClick", function(self) SetAutoHide(self:GetChecked()) end)
	
	-- Cast Watcher
	panel.EnableCastWatcher = PanelHelpers:CreateCheckButton("TidyPlatesOptions_EnableCastWatcher", panel, "Show Non-Target Casting Bars (When Possible)")
	panel.EnableCastWatcher:SetPoint("TOPLEFT", panel.AutoHide, "TOPLEFT", 0, -30)
	panel.EnableCastWatcher:SetScript("OnClick", function(self) SetSpellCastWatcher(self:GetChecked()) end)
	
	BlizzOptionsButton = CreateFrame("Button", "TidyPlatesOptions_BlizzOptionsButton", panel, "UIPanelButtonTemplate2")
	--BlizzOptionsButton:SetPoint("TOPRIGHT", ResetButton, "TOPLEFT", -8, 0)
	BlizzOptionsButton:SetPoint("TOPLEFT", panel.EnableCastWatcher, "TOPLEFT", 0, -35)
	BlizzOptionsButton:SetWidth(300)
	BlizzOptionsButton:SetText("Blizzard Nameplate Motion & Visibility")
	
	ResetButton = CreateFrame("Button", "TidyPlatesOptions_ResetButton", panel, "UIPanelButtonTemplate2")
	ResetButton:SetPoint("BOTTOMRIGHT", -16, 8)
	ResetButton:SetWidth(155)
	ResetButton:SetText("Reset Configuration")
	
	-- Update Functions
	panel.okay = ApplyPanelSettings
	panel.PrimarySpecTheme.OnValueChanged = ApplyPanelSettings
	panel.SecondarySpecTheme.OnValueChanged = ApplyPanelSettings
	
	local function RefreshPanel()
		panel.PrimarySpecTheme:SetValue(TidyPlatesOptions.primary)
		panel.SecondarySpecTheme:SetValue(TidyPlatesOptions.secondary)
		panel.AutoHide:SetChecked(TidyPlatesOptions.autohide)
		panel.EnableCastWatcher:SetChecked(TidyPlatesOptions.EnableCastWatcher)

		panel.PrimaryLabel:SetText("Primary Theme:")
		panel.SecondaryLabel:SetText("Secondary Theme:")
		
		if ThemeHasPanelLink(TidyPlatesOptions["primary"]) then panel.PrimaryEditButton:Show() else panel.PrimaryEditButton:Hide() end
		if ThemeHasPanelLink(TidyPlatesOptions["secondary"]) then panel.SecondaryEditButton:Show() else panel.SecondaryEditButton:Hide() end

	end
	
	panel.refresh = RefreshPanel
	
	local yellow, blue, red, orange = "|cffffff00", "|cFF3782D1", "|cFFFF1100", "|cFFFF6906"
	
	BlizzOptionsButton:SetScript("OnClick", function()
		InterfaceOptionsFrame_OpenToCategory(_G["InterfaceOptionsNamesPanel"])
	end)
	
	ResetButton:SetScript("OnClick", function()
		SetCVar("ShowClassColorInNameplate", 1)		-- Required for Class Detection
		SetCVar("nameplateShowEnemies", 1)
		SetCVar("threatWarning", 3)		-- Required for threat/aggro detection
		_G["InterfaceOptionsNamesPanelUnitNameplatesFriends"]:SetChecked(false)
		
		if IsShiftKeyDown() then
			wipe(TidyPlatesOptions)
			for i, v in pairs(TidyPlatesOptionsDefaults) do TidyPlatesOptions[i] = v end
			SetCVar("nameplateShowFriends", 0)
			ReloadUI()
		else
			wipe(TidyPlatesOptions)
			for i, v in pairs(TidyPlatesOptionsDefaults) do TidyPlatesOptions[i] = v end
			RefreshPanel()
			ApplyPanelSettings()
			-- InterfaceOptionsNamesPanel
			-- InterfaceOptionsNamesPanelUnitNameplatesFriends
			-- InterfaceOptionsFrame_OpenToCategory(
			--print(_G["InterfaceOptionsNamesPanelUnitNameplatesFriends"]:GetChecked())
			-- InterfaceOptionsFrame_OpenToCategory(_G["InterfaceOptionsNamesPanel"])
			print(yellow.."Resetting "..orange.."Tidy Plates"..yellow.." Theme Selection to Default")
			print(yellow.."Holding down "..blue.."Shift"..yellow.." while clicking "..red.."Reset Configuration"..yellow.." will clear your saved settings, AND reload the user interface.")
		end
		
	end)
	
	InterfaceOptions_AddCategory(panel);
end

TidyPlatesInterfacePanel = panel

ApplyPanelSettings = function()
	
	TidyPlatesOptions.primary = panel.PrimarySpecTheme:GetValue()
	TidyPlatesOptions.secondary = panel.SecondarySpecTheme:GetValue()
	TidyPlatesOptions.EnableCastWatcher = panel.EnableCastWatcher:GetChecked()
	TidyPlatesOptions.autohide = panel.AutoHide:GetChecked()

	-- Clear Widgets
	TidyPlatesWidgets:ResetWidgets()
	
	if currentThemeName ~= TidyPlatesOptions[activespec] then 
		LoadTheme(TidyPlatesOptions[activespec]) 
	end

	-- Update Appearance
	TidyPlates:ForceUpdate()
	SetAutoHide(TidyPlatesOptions.autohide) 
	SetSpellCastWatcher(TidyPlatesOptions.EnableCastWatcher)

	-- Spell Casting
	if	TidyPlatesOptions.EnableCastWatcher then TidyPlates:StartSpellCastWatcher()
	else TidyPlates:StopSpellCastWatcher()	end

	-- Editing Link
	if ThemeHasPanelLink(TidyPlatesOptions["primary"]) then panel.PrimaryEditButton:Show() else panel.PrimaryEditButton:Hide() end
	if ThemeHasPanelLink(TidyPlatesOptions["secondary"]) then panel.SecondaryEditButton:Show() else panel.SecondaryEditButton:Hide() end

end

local function ShowWelcome()
	if not TidyPlatesOptions.WelcomeShown then
		SetCVar("ShowClassColorInNameplate", 1)		-- Required for Class Detection
		SetCVar("nameplateShowEnemies", 1)
		SetCVar("nameplateShowFriends", 0)
		SetCVar("threatWarning", 3)		-- Required for threat/aggro detection
		TidyPlatesOptions.WelcomeShown = true
	end
	-- CHAT_MSG_SYSTEM
end

-------------------------------------------------------------------------------------
-- Auto-Loader
-------------------------------------------------------------------------------------
local panelevents = {}

function panelevents:ACTIVE_TALENT_GROUP_CHANGED()
	if GetActiveTalentGroup(false, false) == 2 then activespec = "secondary" 
	else activespec = "primary" end
	LoadTheme(TidyPlatesOptions[activespec])

	TidyPlatesWidgets:ResetWidgets()
	TidyPlates:ForceUpdate()
	
	-- Warn user if no theme is selected
	if currentThemeName == "None" and not warned[activespec] then
		print("|cFFFF6600Tidy Plates: |cFFFF9900No Theme is Selected.")
		print("|cFF77FF00Use |cFFFFFF00/tidyplates|cFF77FF00 to bring up the Theme Selection Window")
		warned[activespec] = true
	end
	
end

function panelevents:PLAYER_ENTERING_WORLD() panelevents:ACTIVE_TALENT_GROUP_CHANGED() end

function panelevents:PLAYER_REGEN_ENABLED() if useAutoHide then SetCVar("nameplateShowEnemies", 0) end end

function panelevents:PLAYER_REGEN_DISABLED() if useAutoHide then SetCVar("nameplateShowEnemies", 1) end end	


function panelevents:PLAYER_LOGIN()
	-- AutoHide
	SetAutoHide(TidyPlatesOptions.autohide)
	SetSpellCastWatcher(TidyPlatesOptions.EnableCastWatcher)
	
	UpdateThemeNames()
	ActivateInterfacePanel()
	ShowWelcome()
	--ActivateHelpPanel()
	LoadTheme("None")
	
	SetCVar("repositionfrequency", 0)
	
	--panelevents:ACTIVE_TALENT_GROUP_CHANGED()
	--SetCVar("bloattest", 1)			-- Possibly fixes problems
	--SetCVar("threatWarning", 3)		-- Required for threat/aggro detection
	--SetCVar("ShowClassColorInNameplate", 1)		-- Required for threat/aggro detection
end

panel:SetScript("OnEvent", function(self, event, ...) panelevents[event]() end)
for eventname in pairs(panelevents) do panel:RegisterEvent(eventname) end

-------------------------------------------------------------------------------------
-- Slash Commands
-------------------------------------------------------------------------------------

TidyPlatesSlashCommands = {}
--TidyPlatesSlashCommands.reset = function() print("Tidy Plates: Variables have been reset"); TidyPlatesOptions = copytable(TidyPlatesOptionsDefaults); LoadTheme(TidyPlatesOptions[activespec]) end

function slash_TidyPlates(arg)
	if type(TidyPlatesSlashCommands[arg]) == 'function' then 
		TidyPlatesSlashCommands[arg]() 
		TidyPlates:ForceUpdate()
	else InterfaceOptionsFrame_OpenToCategory(panel) end
end

SLASH_TIDYPLATES1 = '/tidyplates'
SlashCmdList['TIDYPLATES'] = slash_TidyPlates;

