local font = "Interface\\Addons\\TidyPlates\\Media\\DefaultFont.ttf"
local PanelHelpers = TidyPlatesUtility.PanelHelpers 		-- PanelTools

--[[
The basic concept of RapidPanel is that each UI widget will get attached to a 'rail' or alignment column.  This rail
provides access to a common update function.  Each widget gets attached as a stack, with widget definition tagging
the previous widget to anchor to.  Default and consistent anchor points also make for less work.

--]]


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
		frame:SetWidth(250)	
		-- Margins	-- Bottom/Left are negative
		frame.Margins = { Left = 12, Right = 8, Top = 20, Bottom = 13,}		
		QuickSetPoints(frame, ...)
		-- Set Feedback Function
		frame:SetScript("OnMouseUp", function() 
			--OnPanelItemChange()
			columnFrame.Callback()
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
			--OnPanelItemChange()
			columnFrame.Callback()
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
		--function frame:GetValue() return SplitToTable(strsplit("\n", EditBox:GetText() )) end
		--function frame:SetValue(value) EditBox:SetText(TableToString(value)) end
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
		frame.OnValueChanged = function() columnFrame.Callback() end
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
		frame.OnValueChanged = function() columnFrame.Callback() end
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


TidyPlatesHubRapidPanel = {}
TidyPlatesHubRapidPanel.CreateQuickSlider = CreateQuickSlider
TidyPlatesHubRapidPanel.CreateQuickCheckbutton = CreateQuickCheckbutton
TidyPlatesHubRapidPanel.SetSliderMechanics = SetSliderMechanics
TidyPlatesHubRapidPanel.CreateQuickEditbox = CreateQuickEditbox
TidyPlatesHubRapidPanel.CreateQuickColorbox = CreateQuickColorbox
TidyPlatesHubRapidPanel.CreateQuickDropdown = CreateQuickDropdown
TidyPlatesHubRapidPanel.CreateQuickHeadingLabel = CreateQuickHeadingLabel
TidyPlatesHubRapidPanel.CreateQuickItemLabel = CreateQuickItemLabel
TidyPlatesHubRapidPanel.OnMouseWheelScrollFrame = OnMouseWheelScrollFrame

--[[
local CreateQuickSlider = TidyPlatesHubRapidPanel.CreateQuickSlider
local CreateQuickCheckbutton = TidyPlatesHubRapidPanel.CreateQuickCheckbutton
local SetSliderMechanics = TidyPlatesHubRapidPanel.SetSliderMechanics
local CreateQuickEditbox = TidyPlatesHubRapidPanel.CreateQuickEditbox
local CreateQuickColorbox = TidyPlatesHubRapidPanel.CreateQuickColorbox
local CreateQuickDropdown = TidyPlatesHubRapidPanel.CreateQuickDropdown
local CreateQuickHeadingLabel = TidyPlatesHubRapidPanel.CreateQuickHeadingLabel
local CreateQuickItemLabel = TidyPlatesHubRapidPanel.CreateQuickItemLabel
local OnMouseWheelScrollFrame = TidyPlatesHubRapidPanel.OnMouseWheelScrollFrame
--]]


---------------
-- Helpers
---------------
local yellow, blue, red, orange = "|cffffff00", "|cFF3782D1", "|cFFFF1100", "|cFFFF6906"

local CallForStyleUpdate = TidyPlatesHubHelpers.CallForStyleUpdate
local GetPanelValues = TidyPlatesHubHelpers.GetPanelValues
local SetPanelValues = TidyPlatesHubHelpers.SetPanelValues
local GetSavedVariables = TidyPlatesHubHelpers.GetSavedVariables
local ListToTable = TidyPlatesHubHelpers.ListToTable
local ConvertStringToTable = TidyPlatesHubHelpers.ConvertStringToTable
local ConvertDebuffListTable = TidyPlatesHubHelpers.ConvertDebuffListTable
local CopyTable = TidyPlatesUtility.copyTable


local function CheckVariableIntegrity(objectName)
	for i,v in pairs(TidyPlatesHubDefaults) do
		if TidyPlatesHubSettings[objectName][i] == nil then
			TidyPlatesHubSettings[objectName][i] = v
			TidyPlatesHubCache[objectName][i] = v
		end
	end
end
--[[
local function VerifyVariableSet(objectName)
	TidyPlatesHubSettings[objectName] = TidyPlatesHubSettings[objectName] or {}
	TidyPlatesHubCache[objectName] = TidyPlatesHubCache[objectName] or {}
	

	for i,v in pairs(TidyPlatesHubDefaults) do
		if not TidyPlatesHubSettings[objectName][i] then
			if type(v) == "table" then new = CopyTable(v) else new = v end
			TidyPlatesHubSettings[objectName][i] = new
			TidyPlatesHubCache[objectName][i] = new
		end
		local new

	end
end
--]]

local function CreateVariableSet(objectName)
	TidyPlatesHubSettings[objectName] = CopyTable(TidyPlatesHubDefaults)
	TidyPlatesHubCache[objectName] = CopyTable(TidyPlatesHubDefaults)
	
	return TidyPlatesHubSettings[objectName]
end

local function GetVariableSet(panel)
	return TidyPlatesHubSettings[panel.objectName]
end

local function ClearVariableSet(panel)
	for i, v in pairs(TidyPlatesHubSettings[panel.objectName]) do TidyPlatesHubSettings[panel.objectName][i] = nil end
	TidyPlatesHubSettings[panel.objectName] = nil
	ReloadUI()
end

local function GetCacheSet(panel)
	return TidyPlatesHubCache[panel.objectName]
end

local function RefreshSettings(LocalVars)
	CallForStyleUpdate()
	ConvertDebuffListTable(LocalVars.WidgetsDebuffTrackList, LocalVars.WidgetsDebuffLookup, LocalVars.WidgetsDebuffPriority)			
	ConvertStringToTable(LocalVars.OpacityFilterList, LocalVars.OpacityFilterLookup)
end

local function OnPanelItemChange(panel) 
	local LocalVars = GetVariableSet(panel)
	GetPanelValues(panel, LocalVars)
	RefreshSettings(LocalVars)
end

-- Colors
local yellow, blue, red, orange = "|cffffff00", "|cFF3782D1", "|cFFFF1100", "|cFFFF6906"

local function PasteSettings(panel)
	local LocalVars = GetCacheSet(panel)
	print(yellow.."Pasted "..orange..panel.name..yellow.." Theme Values from Cache")
	SetPanelValues(panel, LocalVars)
	OnPanelItemChange(panel)
end

local function CopySettings(panel)
	local LocalVars = GetCacheSet(panel)
	print(yellow.."Copied "..orange..panel.name..yellow.." Theme Values to Cache")
	GetPanelValues(panel, LocalVars)	
end



local function ResetSettings(panel)
	if IsShiftKeyDown() then
		ClearVariableSet(panel)
		CreateVariableSet(panel.objectName)
	else
		SetPanelValues(panel, TidyPlatesHubDefaults)
		OnPanelItemChange(panel)
		print(yellow.."Resetting "..orange..panel.name..yellow.." Configuration to Default")
		print(yellow.."Holding down "..blue.."Shift"..yellow.." while clicking "..red.."Reset"..yellow.." will clear all saved settings, and reload the user interface.")
	end
end

	

local function CreateInterfacePanel( objectName, panelTitle, parentTitle)

	-- Variables
	------------------------------
	CreateVariableSet(objectName)
	
	-- Panel
	------------------------------
	local panel = CreateFrame( "Frame", objectName.."_InterfaceOptionsPanel", UIParent);
	panel.objectName = objectName
	panel:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", insets = { left = 2, right = 2, top = 2, bottom = 2 },})
	panel:SetBackdropColor(0.06, 0.06, 0.06, 1)
	if parentTitle then panel.parent = parentTitle end
	panel.name = panelTitle
	
	-- Heading
	------------------------------
	panel.MainLabel = CreateQuickHeadingLabel(nil, panelTitle, panel, nil, 16, 16)	
	
	-- Main Scrolled Frame
	------------------------------
	panel.MainFrame = CreateFrame("Frame")
	panel.MainFrame:SetWidth(412)
	panel.MainFrame:SetHeight(2760) 		-- This can be set VERY long since we've got it in a scrollable window.
	
	-- Scrollable Panel Window
	------------------------------
	panel.ScrollFrame = CreateFrame("ScrollFrame",objectName.."_Scrollframe", panel, "UIPanelScrollFrameTemplate")
	panel.ScrollFrame:SetPoint("TOPLEFT", 16, -48 )
	panel.ScrollFrame:SetPoint("BOTTOMRIGHT", -32 , 16 )
	panel.ScrollFrame:SetScrollChild(panel.MainFrame)
	panel.ScrollFrame:SetScript("OnMouseWheel", OnMouseWheelScrollFrame)
	
	-- Scroll Frame Border
	------------------------------
	panel.ScrollFrameBorder = CreateFrame("Frame", objectName.."ScrollFrameBorder", panel.ScrollFrame )
	panel.ScrollFrameBorder:SetPoint("TOPLEFT", -4, 5)
	panel.ScrollFrameBorder:SetPoint("BOTTOMRIGHT", 3, -5)
	panel.ScrollFrameBorder:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
												edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
												--tile = true, tileSize = 16,
												edgeSize = 16, 
												insets = { left = 4, right = 4, top = 4, bottom = 4 }
												});
	panel.ScrollFrameBorder:SetBackdropColor(0.05, 0.05, 0.05, 0)
	panel.ScrollFrameBorder:SetBackdropBorderColor(0.2, 0.2, 0.2, 1)
	
	-- Alignment Colum
	------------------------------
	panel.AlignmentColumn = CreateFrame("Frame", objectName.."_AlignmentColumn", panel.MainFrame) 
	panel.AlignmentColumn:SetPoint("TOPLEFT", 12,0)
	panel.AlignmentColumn:SetPoint("BOTTOMRIGHT", panel.MainFrame, "BOTTOM")	
	panel.AlignmentColumn.Callback = function() OnPanelItemChange(panel) end
	
	-----------------
	-- Button Handlers
	-----------------
	panel.okay = function() OnPanelItemChange(panel) end
	panel.refresh = function() SetPanelValues(panel, GetVariableSet(panel)) ; panel:UnRegisterForDrag() end

	-----------------
	-- Panel Event Handler
	-----------------
	panel:SetScript("OnEvent", function() 
		-- Check for Variable Set
		if not GetVariableSet(panel) then CreateVariableSet(objectName) end
		-- Verify Variable Integrity
		CheckVariableIntegrity(objectName)
		-- Refresh Panel based on loaded variables
		RefreshSettings(GetVariableSet(panel)) 
	end)
	panel:RegisterEvent("PLAYER_ENTERING_WORLD")
	
	-----------------
	-- Config Management Buttons
	-----------------

	-- Paste
	PasteThemeDataButton = CreateFrame("Button", objectName.."PasteThemeDataButton", panel, "UIPanelButtonTemplate2")
	PasteThemeDataButton:SetPoint("TOPRIGHT", -16, -20)
	PasteThemeDataButton:SetWidth(60)
	PasteThemeDataButton:SetScale(.85)
	PasteThemeDataButton:SetText("Paste")

	PasteThemeDataButton:SetScript("OnClick", function() PasteSettings(panel); end)
	
	-- Copy
	CopyThemeDataButton = CreateFrame("Button", objectName.."CopyThemeDataButton", panel, "UIPanelButtonTemplate2")
	CopyThemeDataButton:SetPoint("TOPRIGHT", PasteThemeDataButton, "TOPLEFT", -4, 0)
	CopyThemeDataButton:SetWidth(60)
	CopyThemeDataButton:SetScale(.85)
	CopyThemeDataButton:SetText("Copy")
	
	CopyThemeDataButton:SetScript("OnClick", function() CopySettings(panel); end)
	
	-- Reset
	ReloadThemeDataButton = CreateFrame("Button", objectName.."ReloadThemeDataButton", panel, "UIPanelButtonTemplate2")
	ReloadThemeDataButton:SetPoint("TOPRIGHT", CopyThemeDataButton, "TOPLEFT", -4, 0)
	ReloadThemeDataButton:SetWidth(60)
	ReloadThemeDataButton:SetScale(.85)
	ReloadThemeDataButton:SetText("Reset")
		
	ReloadThemeDataButton:SetScript("OnClick", function() ResetSettings(panel); end)
	
	--[[
	-- Jump
	JumpToButton = CreateFrame("Button", objectName.."JumpToButton", panel, "UIPanelButtonTemplate2")
	JumpToButton:SetPoint("TOPRIGHT", ReloadThemeDataButton, "TOPLEFT", -4, 0)
	JumpToButton:SetWidth(75)
	JumpToButton:SetScale(.85)
	JumpToButton:SetText("Unlink")
	
	--JumpToButton:SetScript("OnClick", function() panel.ScrollFrame:SetVerticalScroll(500) end)
	
	JumpToButton:SetScript("OnClick", function(self)
		HideUIPanel(InterfaceOptionsFrame)		-- ShowUIPanel(InterfaceOptionsFrame);
		panel:SetParent(UIParent)
		
		panel:SetBackdrop({ bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
											edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
											--tile = true, tileSize = 16,
											edgeSize = 16, 
											insets = { left = 4, right = 4, top = 4, bottom = 4 }
											});
		--panel:SetBackdropColor(0.05, 0.05, 0.05, .8)
		panel:SetBackdropColor(0.06, 0.06, 0.06, 1)
		panel:SetBackdropBorderColor(0.2, 0.2, 0.2, 1)
		
		panel:SetClampedToScreen(true)
		panel:RegisterForDrag("LeftButton")
		panel:EnableMouse(true)
		panel:SetMovable(true)
		panel:SetScript("OnDragStart",function(self, button) panel:SetAlpha(.8); if button =="LeftButton" then panel:StartMoving() end end)
		panel:SetScript("OnDragStop",function(self, button) panel:SetAlpha(1); panel:StopMovingOrSizing() end)
	
		--self:Hide()
	end)
	
	--]]
	
	
	----------------
	-- Return a pointer to the whole thingy
	----------------
	InterfaceOptions_AddCategory(panel)
	return panel
end

TidyPlatesHubRapidPanel.CreateInterfacePanel = CreateInterfacePanel
TidyPlatesHubRapidPanel.CreateVariableSet = CreateVariableSet

