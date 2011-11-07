

local path = "Interface\\Addons\\TidyPlates_SharedPanels\\"
local font = "Interface\\Addons\\TidyPlates\\Media\\DefaultFont.ttf"
local Panel
local CopyTable = TidyPlatesUtility.copyTable
local PanelHelpers = TidyPlatesUtility.PanelHelpers

---------------------------------------------
-- Variables Definition
---------------------------------------------
TidyPlatesHubTankCache = {}
TidyPlatesHubTankSavedVariables = {}
TidyPlatesHubTankVariables = {

	-- Style
	---------------------------------------
	StyleEnemyMode = 1, 
	StyleFriendlyMode = 1,
	
	-- Opacity
	---------------------------------------
	OpacityTarget = 1,
	OpacityNonTarget = .5,
	OpacitySpotlightMode = 1,
	OpacitySpotlight = .5,
	OpacityFullSpell = false,				-- Bring Casting units to Full Opacity
	OpacityFullNoTarget = true,				-- Use full opacity when No Target
	OpacityFiltered = 0,
	OpacityFilterNeutralUnits = false,		-- OpacityHideNeutral = false,
	OpacityFilterNonElite = false,			-- OpacityHideNonElites = false,
	OpacityFilterInactive = false,
	OpacityFilterList = "Fanged Pit Viper",
	OpacityFilterLookup = {},

	-- Scale
	---------------------------------------
	ScaleStandard = 1,
	ScaleSpotlightMode = 4, 
	ScaleSpotlight = 1.2,
	ScaleIgnoreNeutralUnits = false,
	ScaleIgnoreNonEliteUnits = false,
	ScaleIgnoreInactive = false,
	
	-- Text
	---------------------------------------
	TextHealthTextMode = 1,
	TextShowLevel = false,
	TextUseBlizzardFont = false,

	-- Color
	---------------------------------------
	ColorHealthBarMode = 3,
	ColorDangerGlowMode = 2,
	TextNameColorMode = 1,
	ColorAttackingMe = {r = 15/255, g = 133/255, b = 255/255},		-- Bright Blue
	ColorAggroTransition = {r = 255/255, g = 216/255, b = 0/255},	-- Yellow
	ColorAttackingOthers = {r = 255/255, g = 128/255, b = 0,},		-- Orange
	ColorAttackingOtherTank = {r = 15/255, g = 133/255, b = 255/255},	-- Bright Blue
	ColorDangerGlowOnParty = false,
	ClassColorPartyMembers = false,
	
	-- Widgets
	---------------------------------------
	WidgetTargetHighlight = true,
	WidgetEliteIndicator = true,
	ClassEnemyIcon = false,
	ClassPartyIcon = false,
	WidgetsTotemIcon = false,
	WidgetsComboPoints = true,
	WidgetsThreatIndicator = true,
	WidgetsThreatIndicatorMode = 1,
	WidgetsRangeIndicator = false,
	WidgetsRangeMode = 1,
	WidgetsDebuff = true,
	WidgetsDebuffMode = 3,
	WidgetsDebuffList = { ["Obsolete"] = true, },
	--WidgetsDebuffTrackList = "Moonfire",
	WidgetsDebuffTrackList = "My Rake\nMy Rip\nMy Moonfire\nAll 339",
	WidgetsDebuffLookup = {},
	WidgetsDebuffPriority = {},	
	-- Frame
	---------------------------------------
	FrameVerticalPosition = .5,
}

TidyPlatesHubTankCache = CopyTable(TidyPlatesHubTankVariables)
local TidyPlatesHubTankDefaults = CopyTable(TidyPlatesHubTankVariables)
---------------
-- Helpers
---------------

local function CallForStyleUpdate()
	for name, theme in pairs(TidyPlatesThemeList) do
		if theme.OnApplyThemeCustomization then theme.OnApplyThemeCustomization() end
	end
end



local function GetPanelValues(panel, targetTable, cloneTable)
	local index
	for index in pairs(targetTable) do
		if panel[index] then
			--if type(targetTable[index]) == 'table' then
			--	wipe(targetTable[index])
			--	wipe(cloneTable[index])
			--end
			targetTable[index] = panel[index]:GetValue()
			cloneTable[index] = targetTable[index]
		end
	end
end

local function SetPanelValues(panel, sourceTable)
	for index, value in pairs(sourceTable) do
		if panel[index] then
			panel[index]:SetValue(value)
		end
	end
end

local function GetSavedVariables(targetTable, cloneTable)
	local i, v
	for i, v in pairs(targetTable) do 
		if cloneTable[i] ~= nil then
			targetTable[i] = cloneTable[i]
		end
	end
end

local function ListToTable( ... )
	local t = {}
	local index, line
	for index = 1, select("#", ...) do
		line = select(index, ...)	
		if line ~= "" then t[index] = line end
	end
	return t
end

local function ConvertStringToTable(source, target )
	local temp = ListToTable(strsplit("\n", source))
	target = wipe(target)
	
	for index = 1, #source do
		local str = temp[index]
		if str then target[str] = true end
	end		
end

local PrefixList = {
   ["ALL"] = 1,
   ["All"] = 1,
   ["all"] = 1,
   ["MY"] = 2,
   ["My"] = 2,
   ["my"] = 2,
   ["NO"] = 3,
   ["CC"] = 4,
   ["OTHER"] = 5,
}	

local function ConvertDebuffListTable(source, target, order)
--local function ConvertStringToTable(source, target, prefixes, order)
	local temp = ListToTable(strsplit("\n", source))
	target = wipe(target)
	if order then order = wipe(order) end
	
	for index = 1, #temp do
		local str = temp[index]
		local item
		local _, _, prefix, suffix = string.find( str, "(%w+)[%s%p]*(.*)");
		if prefix then
			if PrefixList[prefix] then
				item = suffix
				target[item] = PrefixList[prefix]
			else -- If no prefix is listed, assume 1
				if suffix and suffix ~= "" then item = prefix.." "..suffix
				else item = prefix end
				target[item] = 1
			end
			if order then order[item] = index end
		end
	end	
	
end
------------------------------------------------
-- Rapid Panel Functions
------------------------------------------------
local function OnPanelItemChange() 
	GetPanelValues(Panel, TidyPlatesHubTankVariables, TidyPlatesHubTankSavedVariables)
	CallForStyleUpdate()

	ConvertDebuffListTable(TidyPlatesHubTankVariables.WidgetsDebuffTrackList, TidyPlatesHubTankVariables.WidgetsDebuffLookup, TidyPlatesHubTankVariables.WidgetsDebuffPriority)
						
	ConvertStringToTable(TidyPlatesHubTankVariables.OpacityFilterList, TidyPlatesHubTankVariables.OpacityFilterLookup)
	
	--TidyPlates:ForceUpdate()
end
	
local function QuickSetPoints(frame, columnFrame, neighborFrame, xOffset, yOffset)
		local TopOffset = frame.Margins.Top + (yOffset or 0)
		local LeftOffset = frame.Margins.Left + (xOffset or 0)
		frame:ClearAllPoints()
		if neighborFrame then
			if neighborFrame.Margins then TopOffset = neighborFrame.Margins.Bottom + TopOffset + (yOffset or 0) end
			frame:SetPoint("TOP", neighborFrame, "BOTTOM", -(neighborFrame:GetWidth()/2), -TopOffset)
		else frame:SetPoint("TOP", columnFrame, "TOP", 0, -TopOffset) end
		frame:SetPoint("LEFT", columnFrame, "LEFT", LeftOffset, 0)
end

local function CreateQuickSlider(name, label, ... ) --, neighborFrame, xOffset, yOffset)
		local columnFrame = ...
		local frame = PanelHelpers:CreateSliderFrame(name, columnFrame, label, .5, 0, 1, .1)	
		frame:SetWidth(170)	
		-- Margins	-- Bottom/Left are negative
		frame.Margins = { Left = 12, Right = 8, Top = 20, Bottom = 13,}		
		QuickSetPoints(frame, ...)
		-- Set Feedback Function
		frame:SetScript("OnMouseUp", function() 
			OnPanelItemChange()
			--if columnFrame.OnFeedback then columnFrame:OnFeedback() end
		end)
		return frame
	end
	
	local function CreateQuickCheckbutton(name, label, ...)
		local columnFrame = ...
		local frame = PanelHelpers:CreateCheckButton(name, columnFrame, label)
		-- Margins	-- Bottom/Left are supposed to be negative
		frame.Margins = { Left = 2, Right = 100, Top = 0, Bottom = 0,}
		QuickSetPoints(frame, ...)	
		-- Set Feedback Function
		frame:SetScript("OnClick", function() 
			OnPanelItemChange()
			--if columnFrame.OnFeedback then columnFrame:OnFeedback() end
		end)
		return frame
	end


	local function SetSliderMechanics(slider, value, minimum, maximum, increment)
		slider:SetMinMaxValues(minimum, maximum)
		slider:SetValueStep(increment)
		slider:SetValue(value)
	end
	
	local function CreateQuickEditbox(name, ...)
		local columnFrame = ...
		local frame = CreateFrame("ScrollFrame", name, columnFrame, "UIPanelScrollFrameTemplate")
		frame.BorderFrame = CreateFrame("Frame", nil, frame )
		local EditBox = CreateFrame("EditBox", nil, frame)
		-- Margins	-- Bottom/Left are supposed to be negative
		frame.Margins = {Left = 4, Right = 24, Top = 8, Bottom = 8, }

		-- Frame Size
		frame:SetWidth(150)
		frame:SetHeight(100)
		-- Border
		frame.BorderFrame:SetPoint("TOPLEFT", 0, 5)
		frame.BorderFrame:SetPoint("BOTTOMRIGHT", 3, -5)
		frame.BorderFrame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
											edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
											tile = true, tileSize = 16, edgeSize = 16, 
											insets = { left = 4, right = 4, top = 4, bottom = 4 }
											});
		frame.BorderFrame:SetBackdropColor(0.05, 0.05, 0.05, 0)
		frame.BorderFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)
		-- Text
		
		EditBox:SetPoint("TOPLEFT")
		EditBox:SetPoint("BOTTOMLEFT")
		EditBox:SetHeight(100)
		EditBox:SetWidth(150)
		EditBox:SetMultiLine(true)
				
		EditBox:SetFrameLevel(frame:GetFrameLevel()-1)
		EditBox:SetFont("Fonts\\FRIZQT__.TTF", 11, "NONE")
		EditBox:SetText("Empty")
		EditBox:SetAutoFocus(false)
		EditBox:SetTextInsets(9, 6, 2, 2)
		frame:SetScrollChild(EditBox)
		frame.EditBox = EditBox
		--EditBox:SetIndentedWordWrap(true)
		--print(name, EditBox:GetFrameLevel(), frame:GetFrameLevel(), EditBox:GetFrameStrata(), frame:GetFrameStrata())
		-- Functions
		function frame:GetValue() return EditBox:GetText() end
		function frame:SetValue(value) EditBox:SetText(value) end
		frame._SetWidth = frame.SetWidth
		function frame:SetWidth(value) frame:_SetWidth(value); EditBox:SetWidth(value) end
		-- Set Positions
		QuickSetPoints(frame, ...)	
		-- Set Feedback Function
		--frame.OnValueChanged = columnFrame.OnFeedback
		return frame
	end
	
	local function CreateQuickColorbox(name, label, ...)
		local columnFrame = ...
		local frame = PanelHelpers:CreateColorBox(name, columnFrame, label, 0, .5, 1, 1)
		-- Margins	-- Bottom/Left are supposed to be negative
		frame.Margins = { Left = 5, Right = 100, Top = 3, Bottom = 2,}
		-- Set Positions
		QuickSetPoints(frame, ...)	
		-- Set Feedback Function
		frame.OnValueChanged = OnPanelItemChange
		--frame.OnValueChanged = columnFrame.OnFeedback
		return frame
	end
	
	local function CreateQuickDropdown(name, label, dropdownTable, initialValue, ...)
		local columnFrame = ...
		local frame = PanelHelpers:CreateDropdownFrame(name, columnFrame, dropdownTable, initialValue, label)
		-- Margins	-- Bottom/Left are supposed to be negative
		frame.Margins = { Left = -12, Right = 2, Top = 22, Bottom = 0,}
		-- Set Positions
		QuickSetPoints(frame, ...)
		-- Set Feedback Function
		frame.OnValueChanged = OnPanelItemChange
		--frame.OnValueChanged = columnFrame.OnFeedback
		return frame
	end

	local function CreateQuickHeadingLabel(name, label, ...)
		local columnFrame = ...
		local frame = CreateFrame("Frame", name, columnFrame)
		frame:SetHeight(20)
		frame:SetWidth(500)
		--frame.Text = frame:CreateFontString(name.."Text", 'ARTWORK', 'GameFontNormal')
		frame.Text = frame:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
		-- frame.Text:SetFont("Fonts\\FRIZQT__.TTF", 18 )
		-- frame.Text:SetFont("Fonts\\ARIALN.TTF", 18 )
		frame.Text:SetFont(font, 22 )
		--frame.Text:SetTextColor(1, .7, 0)
		--frame.Text:SetTextColor(55/255, 173/255, 255/255)
		frame.Text:SetTextColor(255/255, 105/255, 6/255)
		frame.Text:SetAllPoints()
		frame.Text:SetText(label)
		frame.Text:SetJustifyH("LEFT")
		frame.Text:SetJustifyV("BOTTOM")
		-- Margins	-- Bottom/Left are supposed to be negative
		frame.Margins = { Left = 6, Right = 2, Top = 2, Bottom = 2,}
		-- Set Positions
		QuickSetPoints(frame, ...)
		return frame
	end
	
	local function CreateQuickItemLabel(name, label, ...)
		local columnFrame = ...
		local frame = CreateFrame("Frame", name, columnFrame)
		frame:SetHeight(15)
		frame:SetWidth(500)
		frame.Text = frame:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
		--frame.Text = frame:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
		-- frame.Text:SetFont("Fonts\\FRIZQT__.TTF", 18 )
		-- frame.Text:SetFont("Fonts\\ARIALN.TTF", 18 )
		--frame.Text:SetFont(font, 22 )
		--frame.Text:SetTextColor(1, .7, 0)
		--frame.Text:SetTextColor(55/255, 173/255, 255/255)
		frame.Text:SetAllPoints()
		frame.Text:SetText(label)
		frame.Text:SetJustifyH("LEFT")
		frame.Text:SetJustifyV("BOTTOM")
		-- Margins	-- Bottom/Left are supposed to be negative
		frame.Margins = { Left = 6, Right = 2, Top = 2, Bottom = 2,}
		-- Set Positions
		QuickSetPoints(frame, ...)
		return frame
	end
	
local function OnMouseWheelScrollFrame(frame, value, name)
	local scrollbar = _G[frame:GetName() .. "ScrollBar"];
	local currentPosition = scrollbar:GetValue()
	local increment = 50
	
	-- Spin Up
	if ( value > 0 ) then scrollbar:SetValue(currentPosition - increment);
	-- Spin Down
	else scrollbar:SetValue(currentPosition + increment); end	
end

------------------------------------------------------------------
-- Interface Options Panel
------------------------------------------------------------------
local function CreateInterfacePanel( panelName, panelTitle, heading, parentTitle)
	
	local StyleModes = { 																-- Nameplate Style
						{ text = "Default", notCheckable = 1 } ,
						{ text = "Text Only", notCheckable = 1 } , 
						{ text = "Bars during Combat", notCheckable = 1 } , 
						{ text = "Bars on Active/Damaged Units", notCheckable = 1 } , 
						{ text = "Bars on Elite Units", notCheckable = 1 } , 
						{ text = "Bars on Marked Units", notCheckable = 1 } , 
						{ text = "Bars on Players", notCheckable = 1 } , 
						}						
	
	
	local TextModes = { { text = "None", notCheckable = 1 },
						{ text = "Percent Health", notCheckable = 1 } ,
						{ text = "Exact health", notCheckable = 1 } ,
						{ text = "Health Deficit", notCheckable = 1 } ,
						{ text = "Health Total & Percent", notCheckable = 1 } ,
						{ text = "Target Of", notCheckable = 1 } ,
						{ text = "Approximate Health", notCheckable = 1 } ,
						}
			
			
	local RangeModes = { { text = "9 yards"} , 
						{ text = "15 yards" } ,
						{ text = "28 yards" } ,
						{ text = "40 yards" } ,
						}


						
	local DebuffModes = { 
						{ text = "Show All", notCheckable = 1 } ,
						{ text = "Show These... ", notCheckable = 1 } , 
						{ text = "Show All Mine ", notCheckable = 1 } , 
						{ text = "Show My... ", notCheckable = 1 } ,
						{ text = "By Prefix...", notCheckable = 1 } ,						
						}
	
	local OpacityModes = {
						{ text = "None", notCheckable = 1 } ,
						{ text = "By Low Threat", notCheckable = 1 } ,
						{ text = "By Mouseover", notCheckable = 1 } ,
						{ text = "By Debuff Widget", notCheckable = 1 } ,
						{ text = "By Enemy", notCheckable = 1 } ,
						{ text = "By NPC", notCheckable = 1 } ,
						{ text = "By Raid Icon", notCheckable = 1 } ,
						{ text = "By Active/Damaged", notCheckable = 1 } ,
						--{ text = "By Low Health (>30%)", notCheckable = 1 } ,

						}
	local ScaleModes = {
						{ text = "None", notCheckable = 1 } ,
						{ text = "By Elite", notCheckable = 1 } ,
						{ text = "By Target", notCheckable = 1 } ,
						{ text = "By Low Threat", notCheckable = 1 } ,
						{ text = "By Debuff Widget", notCheckable = 1 } ,
						{ text = "By Enemy", notCheckable = 1 } ,
						{ text = "By NPC", notCheckable = 1 } ,
						{ text = "By Raid Icon", notCheckable = 1 } ,
						--{ text = "By Low Health (>30%)", notCheckable = 1 } ,

						}
	local HealthColorModes = {
						{ text = "None", notCheckable = 1 } ,
						{ text = "By Class", notCheckable = 1 } ,
						{ text = "By Threat", notCheckable = 1 } ,
						{ text = "By Reaction", notCheckable = 1 } ,
						--{ text = "By Health", notCheckable = 1 } ,
						}
						
	local WarningGlowModes = {
						{ text = "None", notCheckable = 1 } ,
						{ text = "By Low Threat", notCheckable = 1 } ,
						--{ text = "By Health", notCheckable = 1 } ,
						--{ text = "By Aggro Lost, Attacking Others", notCheckable = 1 } ,
						}
						
	local ThreatModes = {
						{ text = "Tug-o-Threat", notCheckable = 1 } ,
						{ text = "Threat Wheel", notCheckable = 1 } ,
						}
						
	local NameColorModes = {
					{ text = "Default", notCheckable = 1 } ,
					{ text = "By Class", notCheckable = 1 } ,
					{ text = "By Threat", notCheckable = 1 } ,
					{ text = "By Reaction", notCheckable = 1 } ,
					--{ text = "By Health", notCheckable = 1 } ,
					}


	local panel = CreateFrame( "Frame", panelName.."_InterfaceOptionsPanel", UIParent);
	panel.name = panelTitle
	if parentTitle then panel.parent = parentTitle end
	panel:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", insets = { left = 2, right = 2, top = 2, bottom = 2 },})
	--panel:SetBackdropColor(0.05, 0.05, 0.05, .7)
	panel:SetBackdropColor(0.06, 0.06, 0.06, 1)
	
	-- Main Scrolled Frame
	panel.MainFrame = CreateFrame("Frame")
	panel.MainFrame:SetWidth(412)
	panel.MainFrame:SetHeight(1850) 		-- This can be set VERY long since we've got it in a scrollable window.
	
	-- Scrollable Panel Window
	------------------------------
	panel.ScrollFrame = CreateFrame("ScrollFrame",panelName.."_Scrollframe", panel, "UIPanelScrollFrameTemplate")
	panel.ScrollFrame:SetPoint("TOPLEFT", 16, -48 )
	panel.ScrollFrame:SetPoint("BOTTOMRIGHT", -32 , 16 )
	panel.ScrollFrame:SetScrollChild(panel.MainFrame)
	panel.ScrollFrame:SetScript("OnMouseWheel", OnMouseWheelScrollFrame)
	
	-- Graphic Border on Scroll Frame
	panel.ScrollFrameBorder = CreateFrame("Frame", panelName.."ScrollFrameBorder", panel.ScrollFrame )
	panel.ScrollFrameBorder:SetPoint("TOPLEFT", -4, 5)
	panel.ScrollFrameBorder:SetPoint("BOTTOMRIGHT", 3, -5)
	panel.ScrollFrameBorder:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
												edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
												tile = true, tileSize = 16, edgeSize = 16, 
												insets = { left = 4, right = 4, top = 4, bottom = 4 }
												});
	panel.ScrollFrameBorder:SetBackdropColor(0.05, 0.05, 0.05, 0)
	panel.ScrollFrameBorder:SetBackdropBorderColor(0.2, 0.2, 0.2, 1)
	
	
	-- Alignment Colum
	------------------------------
	panel.AlignmentColumn = CreateFrame("Frame", panelName.."_AlignmentColumn", panel.MainFrame) 
	local AlignmentColumn = panel.AlignmentColumn
	AlignmentColumn:SetPoint("TOPLEFT", 12,0)
	AlignmentColumn:SetPoint("BOTTOMRIGHT", panel.MainFrame, "BOTTOM")	
	
	-- Heading
	------------------------------
	panel.MainLabel = CreateQuickHeadingLabel(nil, heading, panel, nil, 16, 16)	
		
	-- Style
	------------------------------
	panel.StyleLabel = CreateQuickHeadingLabel(nil, "Style", AlignmentColumn, nil, 0, 4)	
	panel.StyleEnemyMode =  CreateQuickDropdown(panelName.."StyleEnemyMode", "Enemy Nameplates:", StyleModes, 1, AlignmentColumn, panel.StyleLabel)
	panel.StyleFriendlyMode =  CreateQuickDropdown(panelName.."StyleFriendlyMode", "Friendly Nameplates:", StyleModes, 1, AlignmentColumn, panel.StyleEnemyMode)
		
	--Opacity
	------------------------------
	panel.OpacityLabel = CreateQuickHeadingLabel(nil, "Opacity", AlignmentColumn, panel.StyleFriendlyMode, 0, 4)
	--panel.OpacityLabel = CreateQuickHeadingLabel(nil, "Opacity", AlignmentColumn, nil, 0, 4)		
	panel.OpacityTarget = CreateQuickSlider(panelName.."OpacityTarget", "Current Target Opacity:", AlignmentColumn, panel.OpacityLabel, 0, 2)
	panel.OpacityNonTarget = CreateQuickSlider(panelName.."OpacityNonTarget", "Non-Target Opacity:", AlignmentColumn, panel.OpacityTarget, 0, 2)
	panel.OpacitySpotlightMode =  CreateQuickDropdown(panelName.."OpacitySpotlightMode", "Opacity Spotlight Mode:", OpacityModes, 1, AlignmentColumn, panel.OpacityNonTarget)
	panel.OpacitySpotlight = CreateQuickSlider(panelName.."OpacitySpotlight", "Spotlight Opacity:", AlignmentColumn, panel.OpacitySpotlightMode, 0, 2)
	panel.OpacityFullSpell = CreateQuickCheckbutton(panelName.."OpacityFullSpell", "Bring Casting Units to Target Opacity", AlignmentColumn, panel.OpacitySpotlight, 16)
	panel.OpacityFullNoTarget = CreateQuickCheckbutton(panelName.."OpacityFullNoTarget", "Use Target Opacity When No Target Exists", AlignmentColumn, panel.OpacityFullSpell, 16)
	panel.OpacityFiltered = CreateQuickSlider(panelName.."OpacityFiltered", "Filtered Unit Opacity:", AlignmentColumn, panel.OpacityFullNoTarget, 0, 2)
	panel.OpacityFilterNeutralUnits = CreateQuickCheckbutton(panelName.."OpacityFilterNeutralUnits", "Filter Neutral Units", AlignmentColumn, panel.OpacityFiltered, 16)
	panel.OpacityFilterNonElite = CreateQuickCheckbutton(panelName.."OpacityFilterNonElite", "Filter Non-Elite", AlignmentColumn, panel.OpacityFilterNeutralUnits, 16)
	panel.OpacityFilterInactive = CreateQuickCheckbutton(panelName.."OpacityFilterInactive", "Filter Inactive", AlignmentColumn, panel.OpacityFilterNonElite, 16)
	panel.OpacityCustomFilterLabel = CreateQuickItemLabel(nil, "Filter By Unit Name:", AlignmentColumn, panel.OpacityFilterInactive, 16)	
	panel.OpacityFilterList = CreateQuickEditbox(panelName.."OpacityFilterList", AlignmentColumn, panel.OpacityCustomFilterLabel, 16)

	--Scale
	------------------------------
	panel.ScaleLabel = CreateQuickHeadingLabel(nil, "Scale", AlignmentColumn, panel.OpacityFilterList, 0, 4)
	panel.ScaleStandard = CreateQuickSlider(panelName.."ScaleStandard", "Normal Scale:", AlignmentColumn, panel.ScaleLabel, 0, 2)
	panel.ScaleSpotlightMode =  CreateQuickDropdown(panelName.."ScaleSpotlightMode", "Scale Spotlight Mode:", ScaleModes, 1, AlignmentColumn, panel.ScaleStandard)
	panel.ScaleSpotlight = CreateQuickSlider(panelName.."ScaleSpotlight", "Spotlight Scale:", AlignmentColumn, panel.ScaleSpotlightMode, 0, 2)
	panel.ScaleIgnoreNeutralUnits= CreateQuickCheckbutton(panelName.."ScaleIgnoreNeutralUnits", "Ignore Neutral Units", AlignmentColumn, panel.ScaleSpotlight, 16)
	panel.ScaleIgnoreNonEliteUnits= CreateQuickCheckbutton(panelName.."ScaleIgnoreNonEliteUnits", "Ignore Non-Elite Units", AlignmentColumn, panel.ScaleIgnoreNeutralUnits, 16)
	panel.ScaleIgnoreInactive= CreateQuickCheckbutton(panelName.."ScaleIgnoreInactive", "Ignore Inactive Units", AlignmentColumn, panel.ScaleIgnoreNonEliteUnits, 16)

	--Text
	------------------------------
	panel.TextLabel = CreateQuickHeadingLabel(nil, "Text", AlignmentColumn, panel.ScaleIgnoreInactive, 0, 4)
	panel.TextNameColorMode =  CreateQuickDropdown(panelName.."TextNameColorMode", "Name Text Color Mode:", NameColorModes, 1, AlignmentColumn, panel.TextLabel)
	panel.TextHealthTextMode =  CreateQuickDropdown(panelName.."TextHealthTextMode", "Health Text:", TextModes, 1, AlignmentColumn, panel.TextNameColorMode)
	panel.TextShowLevel = CreateQuickCheckbutton(panelName.."TextShowLevel", "Show Level Text", AlignmentColumn, panel.TextHealthTextMode)
	panel.TextUseBlizzardFont = CreateQuickCheckbutton(panelName.."TextUseBlizzardFont", "Use Default Blizzard Font", AlignmentColumn, panel.TextShowLevel)

	--Color
	------------------------------
	panel.ColorLabel = CreateQuickHeadingLabel(nil, "Color", AlignmentColumn, panel.TextUseBlizzardFont, 0, 4)
	panel.ColorHealthBarMode =  CreateQuickDropdown(panelName.."ColorHealthBarMode", "Health Bar Color Mode:", HealthColorModes, 1, AlignmentColumn, panel.ColorLabel)
	panel.ColorDangerGlowMode =  CreateQuickDropdown(panelName.."ColorDangerGlowMode", "Warning Glow/Border Mode:", WarningGlowModes, 1, AlignmentColumn, panel.ColorHealthBarMode)
	panel.ColorThreatColorLabels = CreateQuickItemLabel(nil, "Threat Colors:", AlignmentColumn, panel.ColorDangerGlowMode, 0)
	panel.ColorAttackingMe = CreateQuickColorbox(panelName.."ColorAttackingMe", "Attacking Me", AlignmentColumn, panel.ColorThreatColorLabels , 16)
	panel.ColorAggroTransition = CreateQuickColorbox(panelName.."ColorAggroTransition", "Losing Aggro", AlignmentColumn, panel.ColorAttackingMe , 16)
	panel.ColorAttackingOthers = CreateQuickColorbox(panelName.."ColorAttackingOthers", "Attacking Others", AlignmentColumn, panel.ColorAggroTransition, 16)
	panel.ColorAttackingOtherTank = CreateQuickColorbox(panelName.."ColorAttackingOtherTank", "Attacking Another Tank", AlignmentColumn, panel.ColorAttackingOthers , 16)
	panel.ColorDangerGlowOnParty = CreateQuickCheckbutton(panelName.."ColorDangerGlowOnParty", "Show Warning around Group Members with Aggro", AlignmentColumn, panel.ColorAttackingOtherTank)
	--panel.ColorDangerGlowOnParty = CreateQuickCheckbutton(panelName.."ColorDangerGlowOnParty", "Show Warning on Group Members with Aggro", AlignmentColumn, panel.ColorAttackingOthers)
	panel.ClassColorPartyMembers = CreateQuickCheckbutton(panelName.."ClassColorPartyMembers", "Show Class Color for Party and Raid Members", AlignmentColumn, panel.ColorDangerGlowOnParty)
	
	--Widgets
	------------------------------
	panel.WidgetsLabel = CreateQuickHeadingLabel(nil, "Widgets", AlignmentColumn, panel.ClassColorPartyMembers, 0, 4)
	panel.WidgetTargetHighlight = CreateQuickCheckbutton(panelName.."WidgetTargetHighlight", "Show Highlight on Current Target", AlignmentColumn, panel.WidgetsLabel)
	panel.WidgetEliteIndicator = CreateQuickCheckbutton(panelName.."WidgetEliteIndicator", "Show Elite Indicator", AlignmentColumn, panel.WidgetTargetHighlight)
	panel.ClassEnemyIcon = CreateQuickCheckbutton(panelName.."ClassEnemyIcon", "Show Enemy Class Icons", AlignmentColumn, panel.WidgetEliteIndicator)
	panel.ClassPartyIcon = CreateQuickCheckbutton(panelName.."ClassPartyIcon", "Show Party Member Class Icons", AlignmentColumn, panel.ClassEnemyIcon)
	panel.WidgetsTotemIcon = CreateQuickCheckbutton(panelName.."WidgetsTotemIcon", "Show Totem Icons", AlignmentColumn, panel.ClassPartyIcon)
	panel.WidgetsComboPoints = CreateQuickCheckbutton(panelName.."WidgetsComboPoints", "Show Combo Points", AlignmentColumn, panel.WidgetsTotemIcon)
	panel.WidgetsThreatIndicator = CreateQuickCheckbutton(panelName.."WidgetsThreatIndicator", "Show Threat Indicator", AlignmentColumn, panel.WidgetsComboPoints)
	panel.WidgetsThreatIndicatorMode =  CreateQuickDropdown(panelName.."WidgetsThreatIndicatorMode", "Threat Indicator:", ThreatModes, 1, AlignmentColumn, panel.WidgetsThreatIndicator, 16)
	panel.WidgetsRangeIndicator = CreateQuickCheckbutton(panelName.."WidgetsRangeIndicator", "Show Party Range Warning", AlignmentColumn, panel.WidgetsThreatIndicatorMode)
	panel.WidgetsRangeMode =  CreateQuickDropdown(panelName.."WidgetsRangeMode", "Range:", RangeModes, 1, AlignmentColumn, panel.WidgetsRangeIndicator, 16)
	panel.WidgetsDebuff = CreateQuickCheckbutton(panelName.."WidgetsDebuff", "Show My Debuff Timers", AlignmentColumn, panel.WidgetsRangeMode)
	panel.WidgetsDebuffMode =  CreateQuickDropdown(panelName.."WidgetsDebuffMode", "Debuff Filter:", DebuffModes, 1, AlignmentColumn, panel.WidgetsDebuff, 16)
	panel.WidgetsDebuffListLabel = CreateQuickItemLabel(nil, "Debuff Names:", AlignmentColumn, panel.WidgetsDebuffMode, 16)	
	panel.WidgetsDebuffTrackList = CreateQuickEditbox(panelName.."WidgetsDebuffTrackList", AlignmentColumn, panel.WidgetsDebuffListLabel, 16)
		-- TIP
		panel.WidgetsDebuffTrackListDescription = CreateQuickItemLabel(nil, "Tip: |cffCCCCCCDebuffs should be listed with the exact name, or a spell ID number. "..
			"You can use the prefixes, 'My' or 'All', to distinguish personal damage spells from global crowd control spells. "..
			"Auras at the top of the list will get displayed before lower ones.", AlignmentColumn, panel.WidgetsDebuffListLabel, 210)	
		panel.WidgetsDebuffTrackListDescription:SetHeight(128)
		panel.WidgetsDebuffTrackListDescription:SetWidth(200)
		panel.WidgetsDebuffTrackListDescription.Text:SetJustifyV("TOP")

	--Frame
	------------------------------
	panel.FrameLabel = CreateQuickHeadingLabel(nil, "Frame", AlignmentColumn, panel.WidgetsDebuffTrackList, 0, 4)
	panel.FrameVerticalPosition = CreateQuickSlider(panelName.."FrameVerticalPosition", "Vertical Position of Artwork:", AlignmentColumn, panel.FrameLabel, 0, 2)


	-- Slider Ranges
	SetSliderMechanics(panel.OpacityTarget, 1, 0, 1, .01)
	SetSliderMechanics(panel.OpacityNonTarget, 1, 0, 1, .01)
	SetSliderMechanics(panel.OpacitySpotlight, 1, 0, 1, .01)
	SetSliderMechanics(panel.OpacityFiltered, 1, 0, 1, .01)
	SetSliderMechanics(panel.ScaleStandard, 1, .1, 3, .01)
	SetSliderMechanics(panel.ScaleSpotlight, 1, .1, 3, .01)
	SetSliderMechanics(panel.FrameVerticalPosition, .5, 0, 1, .02)
	
	-- [[
	PasteThemeDataButton = CreateFrame("Button", panelName.."PasteThemeDataButton", panel, "UIPanelButtonTemplate2")
	PasteThemeDataButton:SetPoint("TOPRIGHT", -6, -20)
	PasteThemeDataButton:SetWidth(60)
	PasteThemeDataButton:SetScale(.85)
	PasteThemeDataButton:SetText("Paste")
	
	CopyThemeDataButton = CreateFrame("Button", panelName.."CopyThemeDataButton", panel, "UIPanelButtonTemplate2")
	CopyThemeDataButton:SetPoint("TOPRIGHT", PasteThemeDataButton, "TOPLEFT", -4, 0)
	CopyThemeDataButton:SetWidth(60)
	CopyThemeDataButton:SetScale(.85)
	CopyThemeDataButton:SetText("Copy")
	
	ReloadThemeDataButton = CreateFrame("Button", panelName.."ReloadThemeDataButton", panel, "UIPanelButtonTemplate2")
	ReloadThemeDataButton:SetPoint("TOPRIGHT", CopyThemeDataButton, "TOPLEFT", -4, 0)
	ReloadThemeDataButton:SetWidth(60)
	ReloadThemeDataButton:SetScale(.85)
	ReloadThemeDataButton:SetText("Reset")
		
	local yellow, blue, red, orange = "|cffffff00", "|cFF3782D1", "|cFFFF1100", "|cFFFF6906"
	--frame.Text:SetTextColor(255/255, 105/255, 6/255)
	ReloadThemeDataButton:SetScript("OnClick", function()
		if IsShiftKeyDown() then
			wipe(TidyPlatesHubTankSavedVariables)
			ReloadUI()
		else
			SetPanelValues(panel, TidyPlatesHubTankDefaults)
			OnPanelItemChange()
			print(yellow.."Resetting "..orange.."Tidy Plates Hub: "..blue.."Damage "..yellow.."Configuration to Default")
			print(yellow.."Holding down "..blue.."Shift"..yellow.." while clicking "..red.."Reset"..yellow.." will clear all saved settings, and reload the user interface.")
		end
	end)
	
	PasteThemeDataButton:SetScript("OnClick", function()
		print(yellow.."Pasted "..orange.."Tidy Plates Hub: "..blue.."Tank"..yellow.." Theme Values from Cache")
		SetPanelValues(panel, TidyPlatesHubTankCache)
		OnPanelItemChange()
	end)
	
	CopyThemeDataButton:SetScript("OnClick", function()
		print(yellow.."Copied "..orange.."Tidy Plates Hub: "..blue.."Tank"..yellow.." Theme Values to Cache")
		GetPanelValues(panel, TidyPlatesHubTankCache, TidyPlatesHubTankSavedVariables)	
	end)
	
	--]]
	
	-----------------
	-- Button Handlers
	-----------------
	panel.okay = OnPanelItemChange
	panel.refresh = function() SetPanelValues(panel, TidyPlatesHubTankVariables) end

	-----------------
	-- Panel Event Handler
	-----------------
	panel:SetScript("OnEvent", function(self, event, ...) 
		if event == "PLAYER_LOGIN" then 
		elseif event == "PLAYER_ENTERING_WORLD" then 
		
			GetSavedVariables(TidyPlatesHubTankVariables, TidyPlatesHubTankSavedVariables)
			CallForStyleUpdate()
			
			-- Convert old list values for Opacity Filter
			if TidyPlatesHubTankVariables.OpacityFilterCustom and type(TidyPlatesHubTankVariables.OpacityFilterCustom) == 'table' then
				local convertedValues = ""
				for i, v in pairs(TidyPlatesHubTankVariables.OpacityFilterCustom) do
					convertedValues = convertedValues..tostring(i).."\n"
					TidyPlatesHubTankVariables.OpacityFilterCustom[i] = nil
				end
				TidyPlatesHubTankVariables.OpacityFilterCustom = nil
				TidyPlatesHubTankVariables.OpacityFilterList = convertedValues
			end
			
			-- Convert old list values for Debuff List
			if TidyPlatesHubTankVariables.WidgetsDebuffList and type(TidyPlatesHubTankVariables.WidgetsDebuffList) == 'table' then
				local convertedValues = ""
				for i, v in pairs(TidyPlatesHubTankVariables.WidgetsDebuffList) do
					convertedValues = convertedValues.."\n"..tostring(i)
					TidyPlatesHubTankVariables.WidgetsDebuffList[i]=nil
				end
				TidyPlatesHubTankVariables.WidgetsDebuffList = convertedValues
			end
			
			ConvertDebuffListTable(TidyPlatesHubTankVariables.WidgetsDebuffTrackList, TidyPlatesHubTankVariables.WidgetsDebuffLookup, TidyPlatesHubTankVariables.WidgetsDebuffPriority)
						
			ConvertStringToTable(TidyPlatesHubTankVariables.OpacityFilterList, TidyPlatesHubTankVariables.OpacityFilterLookup)
		end
	end)
	panel:RegisterEvent("PLAYER_LOGIN")
	panel:RegisterEvent("PLAYER_ENTERING_WORLD")
	panel:RegisterEvent("VARIABLES_LOADED")

	----------------
	-- Return a pointer to the whole thingy
	----------------
	InterfaceOptions_AddCategory(panel)
	return panel
end





--[[
So, the concept is this:
The GetUpdatedVariablePointers function should be called on PLAYER_ENTERING_WORLD or PLAYER_LOGIN, which will return the pointers to the
variables that the panel should use. This can be passed from a totally different file, allowing a single code base for the panel.
--]]

-- Variable Loading
local function GetUpdatedVariablePointers()
	--LocalVariables = TidyPlatesHubTankVariables
	--SavedVariables = TidyPlatesHubTankSavedVariables
	return TidyPlatesHubTankVariables, TidyPlatesHubTankSavedVariables
end

-- Create Instance of Panel
Panel = CreateInterfacePanel( "TidyPlatesHubTank", "Tidy Plates Hub: |cFF3782D1Tank", "Tidy Plates Hub: |cFF3782D1Tank", nil, GetUpdatedVariablePointers ) 

function ShowTidyPlatesHubTankPanel() InterfaceOptionsFrame_OpenToCategory(Panel) end

SLASH_HUBTANK1 = '/hubtank'
SlashCmdList['HUBTANK'] = ShowTidyPlatesHubTankPanel

