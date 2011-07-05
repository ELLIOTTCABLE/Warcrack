local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local templates = {}
addon.templates = templates


do	-- config frame
	local function createTitle(frame)
		local title = frame:CreateFontString(nil, nil, "GameFontNormalLarge")
		title:SetPoint("TOPLEFT", 16, -16)
		title:SetPoint("RIGHT", -16, 0)
		title:SetJustifyH("LEFT")
		title:SetJustifyV("TOP")
		title:SetText(frame.name)
		frame.title = title
	end

	local function createDesc(frame)
		local desc = frame:CreateFontString(nil, nil, "GameFontHighlightSmall")
		desc:SetHeight(32)
		desc:SetPoint("TOPLEFT", frame.title, "BOTTOMLEFT", 0, -8)
		desc:SetPoint("RIGHT", -32, 0)
		desc:SetJustifyH("LEFT")
		desc:SetJustifyV("TOP")
		desc:SetNonSpaceWrap(true)
		frame.desc = desc
	end
	
	function templates:CreateConfigFrame(name, parent, addTitle, addDesc)
		local frame = CreateFrame("Frame")
		frame.name = name
		frame.parent = parent
		if addTitle then
			createTitle(frame)
			if addDesc then
				createDesc(frame)
			end
		end
		InterfaceOptions_AddCategory(frame)
		return frame
	end
end


do	-- click button
	local textures = {"l", "r", "m"}
	
	local function setTexture(self, texture)
		for _, v in ipairs(textures) do
			self[v]:SetTexture(texture)
		end
	end
	
	local function onMouseDown(self)
		if self:IsEnabled() == 1 then
			setTexture(self, "Interface\\Buttons\\UI-Panel-Button-Down")
		end
	end
	
	local function onMouseUp(self)
		if self:IsEnabled() == 1 then
			setTexture(self, "Interface\\Buttons\\UI-Panel-Button-Up")
		end
	end
	
	local function onDisable(self)
		setTexture(self, "Interface\\Buttons\\UI-Panel-Button-Disabled")
	end
	
	local function onEnable(self)
		setTexture(self, "Interface\\Buttons\\UI-Panel-Button-Up")
	end
	
	function templates:CreateButton(parent)
		local btn = CreateFrame("Button", nil, parent)
		btn:SetNormalFontObject("GameFontNormal")
		btn:SetHighlightFontObject("GameFontHighlight")
		btn:SetDisabledFontObject("GameFontDisable")
		btn:SetScript("OnMouseDown", onMouseDown)
		btn:SetScript("OnMouseUp", onMouseUp)
		btn:SetScript("OnDisable", onDisable)
		btn:SetScript("OnEnable", onEnable)
		
		local highlight = btn:CreateTexture(nil, nil, "UIPanelButtonHighlightTexture")
		btn:SetHighlightTexture(highlight)
		
		local l = btn:CreateTexture(nil, "BACKGROUND")
		l:SetTexture("Interface\\Buttons\\UI-Panel-Button-Up")
		l:SetTexCoord(0, 0.09375, 0, 0.6875)
		l:SetWidth(12)
		l:SetPoint("TOPLEFT")
		l:SetPoint("BOTTOMLEFT")
		btn.l = l
		
		local r = btn:CreateTexture(nil, "BACKGROUND")
		r:SetTexture("Interface\\Buttons\\UI-Panel-Button-Up")
		r:SetTexCoord(0.53125, 0.625, 0, 0.6875)
		r:SetWidth(12)
		r:SetPoint("TOPRIGHT")
		r:SetPoint("BOTTOMRIGHT")
		btn.r = r
		
		local m = btn:CreateTexture(nil, "BACKGROUND")
		m:SetTexture("Interface\\Buttons\\UI-Panel-Button-Up")
		m:SetTexCoord(0.09375, 0.53125, 0, 0.6875)
		m:SetPoint("TOPLEFT", l, "TOPRIGHT")
		m:SetPoint("BOTTOMRIGHT", r, "BOTTOMLEFT")
		btn.m = m
		
		return btn
	end
end


do	-- check button
	local function onClick(self)
		local checked = self:GetChecked()
		
		if checked then
			PlaySound("igMainMenuOptionCheckBoxOn")
		else
			PlaySound("igMainMenuOptionCheckBoxOff")
		end
		
		self.module[self.db].profile[self.setting] = checked and true or false
		
		if self.func then
			self:func()
		end
		
		addon:Debug(self.setting..(checked and " on" or " off"))
	end
	
	local function loadSetting(self)
		self:SetChecked(self.module[self.db].profile[self.setting])
		if self.func then
			self:func()
		end
	end

	function templates:CreateCheckButton(parent, data)
		local btn = CreateFrame("CheckButton", nil, parent, "OptionsBaseCheckButtonTemplate")
		btn:SetPushedTextOffset(0, 0)
		btn:SetScript("OnClick", onClick)
		
		btn.LoadSetting = loadSetting
		
		local text = btn:CreateFontString(nil, nil, "GameFontHighlight")
		text:SetPoint("LEFT", btn, "RIGHT", 0, 1)
		btn:SetFontString(text)
		
		if data then
			btn:SetText(data.text)
			data.text = nil
			data.db = data.perchar and "percharDB" or "db"
			data.perchar = nil
			for k, v in pairs(data) do
				btn[k] = v
			end
		end

		return btn
	end
end


do	-- slider template
	local backdrop = {
		bgFile = [[Interface\Buttons\UI-SliderBar-Background]],
		edgeFile = [[Interface\Buttons\UI-SliderBar-Border]],
		tile = true, tileSize = 8, edgeSize = 8,
		insets = {left = 3, right = 3, top = 6, bottom = 6}
	}
	
	local function onEnter(self)
		if self:IsEnabled() then
			if self.tooltipText then
				GameTooltip:SetOwner(self, self.tooltipOwnerPoint or "ANCHOR_RIGHT")
				GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, true)
			end
		end
	end
	
	function templates:CreateSlider(parent, data)
		local slider = CreateFrame("Slider", nil, parent)
		slider:EnableMouse(true)
		slider:SetSize(144, 17)
		slider:SetOrientation("HORIZONTAL")
		slider:SetHitRectInsets(0, 0, -10, -10)
		slider:SetBackdrop(backdrop)
		slider:SetScript("OnEnter", onEnter)
		slider:SetScript("OnLeave", GameTooltip_Hide)
		
		local text = slider:CreateFontString(nil, nil, "GameFontNormal")
		text:SetPoint("BOTTOM", slider, "TOP")
		slider.text = text
		
		local min = slider:CreateFontString(nil, nil, "GameFontHighlightSmall")
		min:SetPoint("TOPLEFT", slider, "BOTTOMLEFT", -4, 3)
		slider.min = min
		
		local max = slider:CreateFontString(nil, nil, "GameFontHighlightSmall")
		max:SetPoint("TOPRIGHT", slider, "BOTTOMRIGHT", 4, 3)
		slider.max = max
		
		if data then
			slider:SetMinMaxValues(data.minValue, data.maxValue)
			slider:SetValueStep(data.valueStep)
			slider:SetScript("OnValueChanged", data.func)
			text:SetText(data.text)
			min:SetText(data.minText or data.minValue)
			max:SetText(data.maxText or data.maxValue)
			slider.tooltipText = data.tooltipText
		end
		
		-- font string for current value
		local value = slider:CreateFontString(nil, "BACKGROUND", "GameFontHighlightSmall")
		value:SetPoint("CENTER", 0, -15)
		slider.value = value
		
		local thumb = slider:CreateTexture()
		thumb:SetTexture("Interface\\Buttons\\UI-SliderBar-Button-Horizontal")
		thumb:SetSize(32, 32)
		slider:SetThumbTexture(thumb)
		
		return slider
	end
end


do	-- swatch button template
	local ColorPickerFrame = ColorPickerFrame
	
	local function swatchFunc()
		local button = ColorPickerFrame.extraInfo
		local r, g, b = ColorPickerFrame:GetColorRGB()
		button.swatch:SetVertexColor(r, g, b)
		if button.func then button:func(r, g, b) end
		local color = button.color
		color.r = r
		color.g = g
		color.b = b
	end

	local function cancelFunc(prev)
		local button = ColorPickerFrame.extraInfo
		local r, g, b, a = prev.r, prev.g, prev.b, prev.opacity
		button.swatch:SetVertexColor(r, g, b)
		if button.func then button:func(r, g, b) end
		local color = button.color
		color.r = r
		color.g = g
		color.b = b
	end

	-- local function opacityFunc()
		-- local button = ColorPickerFrame.extraInfo
		-- local alpha = 1.0 - OpacitySliderFrame:GetValue()
		-- if button.opacityFunc then button:opacityFunc(alpha) end
	-- end
	
	local function onClick(self)
		local info = UIDropDownMenu_CreateInfo()
		local color = self.color
		info.r, info.g, info.b = color.r, color.g, color.b
		info.swatchFunc = swatchFunc
		-- info.hasOpacity = self.hasOpacity
		-- info.opacityFunc = opacityFunc
		-- info.opacity = color.a
		info.cancelFunc = cancelFunc
		info.extraInfo = self
		OpenColorPicker(info)
	end
	
	local function onEnter(self)
		self.bg:SetVertexColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
		if self.tooltipText then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, true)
		end
	end
	
	local function onLeave(self)
		self.bg:SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
		GameTooltip:Hide()
	end

	function templates:CreateColorButton(parent)
		local btn = CreateFrame("Button", nil, parent)
		btn:SetSize(16, 16)
		btn:SetPushedTextOffset(0, 0)
		
		btn:SetNormalTexture("Interface\\ChatFrame\\ChatFrameColorSwatch")
		btn.swatch = btn:GetNormalTexture()
		
		local bg = btn:CreateTexture(nil, "BACKGROUND")
		bg:SetTexture(1.0, 1.0, 1.0)
		bg:SetSize(14, 14)
		bg:SetPoint("CENTER")
		btn.bg = bg
		
		local text = btn:CreateFontString(nil, nil, "GameFontHighlight")
		text:SetPoint("LEFT", btn, "RIGHT", 5, 1)
		text:SetJustifyH("LEFT")
		btn:SetFontString(text)
		
		btn:SetScript("OnClick", onClick)
		btn:SetScript("OnEnter", onEnter)
		btn:SetScript("OnLeave", onLeave)
		
		return btn
	end
end


do	-- editbox
	function templates:CreateEditBox(parent)
		local editbox = CreateFrame("EditBox", nil, parent)
		editbox:SetAutoFocus(false)
		editbox:SetHeight(20)
		editbox:SetFontObject("ChatFontNormal")
		editbox:SetTextInsets(5, 0, 0, 0)

		local left = editbox:CreateTexture("BACKGROUND")
		left:SetTexture("Interface\\Common\\Common-Input-Border")
		left:SetTexCoord(0, 0.0625, 0, 0.625)
		left:SetWidth(8)
		left:SetPoint("TOPLEFT")
		left:SetPoint("BOTTOMLEFT")

		local right = editbox:CreateTexture("BACKGROUND")
		right:SetTexture("Interface\\Common\\Common-Input-Border")
		right:SetTexCoord(0.9375, 1, 0, 0.625)
		right:SetWidth(8)
		right:SetPoint("TOPRIGHT")
		right:SetPoint("BOTTOMRIGHT")

		local mid = editbox:CreateTexture("BACKGROUND")
		mid:SetTexture("Interface\\Common\\Common-Input-Border")
		mid:SetTexCoord(0.0625, 0.9375, 0, 0.625)
		mid:SetPoint("TOPLEFT", left, "TOPRIGHT")
		mid:SetPoint("BOTTOMRIGHT", right, "BOTTOMLEFT")
		
		return editbox
	end
end


do	-- dropdown menu frame
	local function setSelectedValue(self, value)
		UIDropDownMenu_SetSelectedValue(self, value)
		UIDropDownMenu_SetText(self, self.menu and self.menu[value] or value)
	end
	
	local function setDisabled(self, disable)
		if disable then
			self:Disable()
		else
			self:Enable()
		end
	end
	
	local function initialize(self)
		local onClick = self.onClick
		for _, v in ipairs(self.menu) do
			local info = UIDropDownMenu_CreateInfo()
			info.text = v.text
			info.value = v.value
			info.func = onClick or v.func
			info.owner = self
			info.fontObject = v.fontObject
			UIDropDownMenu_AddButton(info)
		end
	end
	
	function templates:CreateDropDownMenu(name, parent, menu, valueLookup)
		local frame = CreateFrame("Frame", name, parent, "UIDropDownMenuTemplate")
		
		frame.SetFrameWidth = UIDropDownMenu_SetWidth
		frame.SetSelectedValue = setSelectedValue
		frame.GetSelectedValue = UIDropDownMenu_GetSelectedValue
		frame.Refresh = UIDropDownMenu_Refresh
		frame.SetText = UIDropDownMenu_SetText
		frame.Enable = UIDropDownMenu_EnableDropDown
		frame.Disable = UIDropDownMenu_DisableDropDown
		frame.SetDisabled = setDisabled
		frame.JustifyText = UIDropDownMenu_JustifyText
		
		if menu then
			for _, v in ipairs(menu) do
				menu[v.value] = v.text
			end
		end
		frame.menu = menu or valueLookup
		
		frame.initialize = initialize
		
		local label = frame:CreateFontString(name.."Label", "BACKGROUND", "GameFontNormalSmall")
		label:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 16, 3)
		frame.label = label
		
		return frame
	end
end


do	-- used in Reset and Announce
	local MAXSPELLBUTTONS = 8
	local ITEMHEIGHT = 36
	
	local function update(self)
		local selectedTree = self.tree:GetSelectedValue()
		
		local spells = addon:GetSpellArray(selectedTree)
		
		local size = #spells
		
		FauxScrollFrame_Update(self.scrollFrame, size, MAXSPELLBUTTONS, ITEMHEIGHT)
		
		local offset = FauxScrollFrame_GetOffset(self.scrollFrame)
		
		for line = 1, MAXSPELLBUTTONS do
			local item = self.buttons[line]
			local lineplusoffset = line + offset
			if lineplusoffset <= size then
				local data = spells[lineplusoffset]
				item.data = data
				item.button.data = data
				local normal = data.normal and data.normal.amount
				local crit = data.crit and data.crit.amount
				item.icon:SetTexture(addon:GetSpellTexture(data.spellID))
				if addon.filters then
					item.icon:SetDesaturated(data.filtered)
					item.spell:SetFontObject(data.filtered and "GameFontDisable" or "GameFontNormal")
				end
				item.spell:SetText(addon:GetFullSpellName(data.spellID, data.periodic))
				item.target:SetFormattedText("%s / %s", data.normal and data.normal.target or "n/a", data.crit and data.crit.target or "n/a")
				item.record:SetFormattedText("%s\n%s", addon:ShortenNumber(normal or 0), addon:ShortenNumber(crit or 0))
				if self.history then
					local prevRecord = self.history[selectedTree][data.spellID]
					if prevRecord and prevRecord[data.periodic] then
						item.button.bg:Hide()
						item.button.texture:Hide()
						item.button.action = "Undo"
					else
						item.button.bg:Show()
						item.button.texture:Show()
						item.button.action = "Reset"
					end
				end
				item:Show()
			else
				item:Hide()
			end
		end
	end
	
	local function onMouseDown(self)
		self:SetPoint("RIGHT", -7, -1)
	end
	
	local function onMouseUp(self)
		self:SetPoint("RIGHT", -8, 0)
	end
	
	-- this is used for creating the scroll frames for the Reset and Announce frames
	function templates:CreateList(name, title, action)
		local frame = templates:CreateConfigFrame(title, addonName)
		
		frame.Update = update
		local function update()
			frame:Update()
		end
		
		addon.RegisterCallback(frame, "PerCharSettingsLoaded", "Update")
		addon.RegisterCallback(frame, "RecordsChanged", "Update")
		
		local scrollFrame = CreateFrame("ScrollFrame", name.."ScrollFrame", frame, "FauxScrollFrameTemplate")
		scrollFrame:SetHeight(MAXSPELLBUTTONS * ITEMHEIGHT + 4)
		scrollFrame:SetPoint("TOPLEFT", 32, -24)
		scrollFrame:SetPoint("TOPRIGHT", -32, -24)
		scrollFrame:SetScript("OnVerticalScroll", function(self, offset) FauxScrollFrame_OnVerticalScroll(self, offset, ITEMHEIGHT, update) end)
		frame.scrollFrame = scrollFrame

		local function onClick(self)
			frame[self.action](frame, self.data)
		end
		
		local function onEnter(self)
			GameTooltip.Critline = true
			GameTooltip:SetOwner(self, "ANCHOR_LEFT")
			GameTooltip:SetSpellByID(self.data.spellID)
			GameTooltip:AddLine(" ")
			addon:AddTooltipLine(self.data)
			if frame.history then
				local prevRecord = frame.history[frame.tree.selectedValue][self.data.spellID]
				prevRecord = prevRecord and prevRecord[self.data.periodic]
				if prevRecord then
					GameTooltip:AddLine(" ")
					GameTooltip:AddLine(L["Previous record:"])
					addon:AddTooltipLine(prevRecord)
				end
			end
			GameTooltip:Show()
		end
		
		-- create list of check buttons
		local buttons = {}
		for i = 1, MAXSPELLBUTTONS do
			local item = CreateFrame("Frame", nil, frame)
			item:SetHeight(ITEMHEIGHT)
			if i == 1 then
				item:SetPoint("TOPLEFT", scrollFrame)
			else
				item:SetPoint("TOP", buttons[i - 1], "BOTTOM")
			end
			item:SetPoint("RIGHT", scrollFrame)
			item:SetScript("OnEnter", onEnter)
			item:SetScript("OnLeave", GameTooltip_Hide)
			
			local icon = item:CreateTexture()
			icon:SetSize(32, 32)
			icon:SetPoint("LEFT")
			item.icon = icon

			local spell = item:CreateFontString(nil, nil, "GameFontNormal")
			spell:SetPoint("TOPLEFT", icon, "TOPRIGHT", 4, -4)
			spell:SetJustifyH("LEFT")
			item.spell = spell

			local target = item:CreateFontString(nil, nil, "GameFontHighlightSmall")
			target:SetPoint("BOTTOMLEFT", icon, "BOTTOMRIGHT", 4, 4)
			target:SetPoint("RIGHT", -64, 0)
			target:SetJustifyH("LEFT")
			item.target = target
			
			local button = CreateFrame("Button", nil, item)
			button:SetSize(24, 24)
			button:SetPoint("RIGHT", -8, 0)
			button:SetScript("OnClick", onClick)
			button:SetScript("OnMouseDown", onMouseDown)
			button:SetScript("OnMouseUp", onMouseUp)
			button.action = action
			item.button = button
			
			local border = button:CreateTexture(nil, "BORDER")
			border:SetAllPoints()
			border:SetTexture([[Interface\PaperDollInfoFrame\UI-GearManager-Undo]])
			
			local bg = button:CreateTexture()
			bg:SetSize(20, 20)
			bg:SetPoint("CENTER")
			bg:SetTexture(0, 0, 0)
			button.bg = bg
			
			local texture = button:CreateTexture()
			texture:SetPoint("CENTER")
			button.texture = texture
			
			if action == "Announce" then
				texture:SetSize(16, 16)
				texture:SetTexture([[Interface\Buttons\UI-GuildButton-MOTD-Up]])
			else
				texture:SetSize(22, 22)
				texture:SetTexture([[Interface\RaidFrame\ReadyCheck-NotReady]])
			end
			
			-- font string for record amounts
			local record = item:CreateFontString(nil, nil, "GameFontHighlightSmall")
			record:SetPoint("TOPRIGHT", -36, 0)
			record:SetPoint("BOTTOMRIGHT", -36, 0)
			record:SetJustifyH("RIGHT")
			record:SetSpacing(2)
			item.record = record
			
			buttons[i] = item
		end
		frame.buttons = buttons
		
		local menu = {
			{text = L["Damage"],	value = "dmg"},
			{text = L["Healing"],	value = "heal"},
			{text = L["Pet"],		value = "pet"},
		}
		
		local tree = templates:CreateDropDownMenu(name.."Tree", frame, menu)
		tree:SetPoint("TOPLEFT", scrollFrame, "BOTTOMLEFT", -16, -4)
		tree:SetFrameWidth(120)
		tree:SetSelectedValue("dmg")
		tree.onClick = function(self)
			self.owner:SetSelectedValue(self.value)
			StaticPopup_Hide("CRITLINE_RESET_ALL")
			FauxScrollFrame_SetOffset(scrollFrame, 0)
			_G[scrollFrame:GetName().."ScrollBar"]:SetValue(0)
			frame:Update()
		end
		frame.tree = tree
		
		return frame
	end
end