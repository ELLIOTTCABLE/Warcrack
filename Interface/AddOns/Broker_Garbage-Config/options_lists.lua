local _, BGC = ...

-- creates child options frame for setting up one's lists
function BGC:ShowListOptions(frame)
	local title = LibStub("tekKonfig-Heading").new(frame, "Broker_Garbage - " .. BGC.locale.LOTitle)
	
	local explanation = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	explanation:SetHeight(70)
	explanation:SetPoint("TOPLEFT", title, "TOPLEFT", 0, -20)
	explanation:SetPoint("RIGHT", frame, -4, 0)
	explanation:SetNonSpaceWrap(true)
	explanation:SetJustifyH("LEFT")
	explanation:SetJustifyV("TOP")
	explanation:SetText(BGC.locale.LOSubTitle)

	local default = LibStub("tekKonfig-Button").new(frame, "TOPLEFT", explanation, "BOTTOMLEFT", 0, -4)
	default:SetText(BGC.locale.defaultListsText)
	default.tiptext = BGC.locale.defaultListsTooltip
	default:SetWidth(150)
	default:RegisterForClicks("RightButtonUp", "LeftButtonUp")
	default:SetScript("OnClick", function(self, button)
		Broker_Garbage:CreateDefaultLists(IsShiftKeyDown())
	end)
	
	local autoSellIncludeItems = LibStub("tekKonfig-Checkbox").new(frame, nil, BGC.locale.LOIncludeAutoSellText, "LEFT", default, "RIGHT", 10, 8)
	autoSellIncludeItems.tiptext = BGC.locale.LOIncludeAutoSellTooltip .. BGC.locale.GlobalSetting
	autoSellIncludeItems:SetChecked( Broker_Garbage:GetOption("autoSellIncludeItems", true) )
	local checksound = autoSellIncludeItems:GetScript("OnClick")
	autoSellIncludeItems:SetScript("OnClick", function(autoSellIncludeItems)
		checksound(autoSellIncludeItems)
		Broker_Garbage:ToggleOption("autoSellIncludeItems", true)
		Broker_Garbage:ScanInventory(true)
	end)
	
	local includeMode = LibStub("tekKonfig-Checkbox").new(frame, nil, BGC.locale.LOUseRealValues, "TOPLEFT", autoSellIncludeItems, "BOTTOMLEFT", 0, 8)
	includeMode.tiptext = BGC.locale.LOUseRealValuesTooltip .. BGC.locale.GlobalSetting
	includeMode:SetChecked( Broker_Garbage:GetOption("useRealValues", true) )
	local checksound = includeMode:GetScript("OnClick")
	includeMode:SetScript("OnClick", function(includeMode)
		checksound(includeMode)
		Broker_Garbage:ToggleOption("useRealValues", true)
		Broker_Garbage:ScanInventory(true)
		-- maybe: Update LDB
	end)
	
	local panel = LibStub("tekKonfig-Group").new(frame, nil, "TOP", default, "BOTTOM", 0, -28)
	panel:SetPoint("LEFT", 8 + 3, 0)
	panel:SetPoint("BOTTOMRIGHT", -8 -4, 34)
	
	local topTab = LibStub("tekKonfig-TopTab")
	local include = topTab.new(frame, BGC.locale.LOTabTitleInclude, "BOTTOMLEFT", panel, "TOPLEFT", 0, -4)
	frame.current = "include"
	local exclude = topTab.new(frame, BGC.locale.LOTabTitleExclude, "LEFT", include, "RIGHT", -15, 0)
	exclude:Deactivate()
	local vendorPrice = topTab.new(frame, BGC.locale.LOTabTitleVendorPrice, "LEFT", exclude, "RIGHT", -15, 0)
	vendorPrice:Deactivate()
	local autoSell = topTab.new(frame, BGC.locale.LOTabTitleAutoSell, "LEFT", vendorPrice, "RIGHT", -15, 0)
	autoSell:Deactivate()
	local help = topTab.new(frame, "?", "LEFT", autoSell, "RIGHT", -15, 0)
	help:Deactivate()
	
	local scrollFrame = CreateFrame("ScrollFrame", frame:GetName().."_Scroll", panel, "UIPanelScrollFrameTemplate")
	scrollFrame:SetPoint("TOPLEFT", panel, "TOPLEFT", 0, -4)
	scrollFrame:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -26, 3)
	local scrollContent = CreateFrame("Frame", scrollFrame:GetName().."Frame", scrollFrame)
	scrollFrame:SetScrollChild(scrollContent)
	scrollContent:SetHeight(300); scrollContent:SetWidth(400)	-- will be replaced when used
	scrollContent:SetAllPoints()
	
	-- action buttons
	local plus = CreateFrame("Button", "Broker_Garbage_AddButton", frame)
	plus:SetPoint("TOPLEFT", panel, "BOTTOMLEFT", 4, -2)
	plus:SetWidth(25); plus:SetHeight(25)
	plus:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")
	plus:SetNormalTexture("Interface\\Icons\\Spell_chargepositive")
	plus.tiptext = BGC.locale.LOPlus
	plus:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	local minus = CreateFrame("Button", "Broker_Garbage_RemoveButton", frame)
	minus:SetPoint("LEFT", plus, "RIGHT", 4, 0)
	minus:SetWidth(25);	minus:SetHeight(25)
	minus:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")
	minus:SetNormalTexture("Interface\\Icons\\Spell_chargenegative")
	minus.tiptext = BGC.locale.LOMinus
	local demote = CreateFrame("Button", "Broker_Garbage_DemoteButton", frame)
	demote:SetPoint("LEFT", minus, "RIGHT", 14, 0)
	demote:SetWidth(25) demote:SetHeight(25)
	demote:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")
	demote:SetNormalTexture("Interface\\Icons\\INV_Misc_GroupLooking")
	demote.tiptext = BGC.locale.LODemote
	local promote = CreateFrame("Button", "Broker_Garbage_PromoteButton", frame)
	promote:SetPoint("LEFT", demote, "RIGHT", 4, 0)
	promote:SetWidth(25) promote:SetHeight(25)
	promote:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")
	promote:SetNormalTexture("Interface\\Icons\\INV_Misc_GroupNeedMore")
	promote.tiptext = BGC.locale.LOPromote
	local emptyList = CreateFrame("Button", "Broker_Garbage_EmptyListButton", frame)
	emptyList:SetPoint("LEFT", promote, "RIGHT", 14, 0)
	emptyList:SetWidth(25); emptyList:SetHeight(25)
	emptyList:SetNormalTexture("Interface\\Buttons\\UI-GroupLoot-Pass-UP")
	emptyList.tiptext = BGC.locale.LOEmptyList
	
	-- editbox curtesy of Tekkub
	local searchbox = CreateFrame("EditBox", frame:GetName().."SearchBox", frame)
	searchbox:SetAutoFocus(false)
	searchbox:SetPoint("TOPRIGHT", panel, "BOTTOMRIGHT", -4, 2)
	searchbox:SetWidth(160)
	searchbox:SetHeight(32)
	searchbox:SetFontObject("GameFontHighlightSmall")
	BGC.CreateFrameBorders(searchbox)

	searchbox:SetTextColor(0.75, 0.75, 0.75, 1)
	searchbox:SetText(BGC.locale.search)
	
	searchbox:SetScript("OnEscapePressed", searchbox.ClearFocus)
	searchbox:SetScript("OnEnterPressed", searchbox.ClearFocus)
	searchbox:SetScript("OnEditFocusGained", function(self)
		if not self.searchString then
			self:SetText("")
			self:SetTextColor(1,1,1,1)
		end
	end)
	searchbox:SetScript("OnEditFocusLost", function(self)
		if self:GetText() == "" then
			self:SetText(BGC.locale.search)
			self:SetTextColor(0.75, 0.75, 0.75, 1)
		end
	end)
	searchbox:SetScript("OnTextChanged", function(self)
		local t = self:GetText()
		self.searchString = t ~= "" and t ~= BGC.locale.search and t:lower() or nil
		BGC:UpdateSearch(self.searchString)
	end)
	
	-- tab changing actions
	include:SetScript("OnClick", function(self)
		self:Activate()
		exclude:Deactivate()
		vendorPrice:Deactivate()
		autoSell:Deactivate()
		help:Deactivate()
		promote:Enable(); promote:GetNormalTexture():SetDesaturated(false)
		demote:Enable(); demote:GetNormalTexture():SetDesaturated(false)
		frame.current = "include"
		scrollFrame:SetVerticalScroll(0)
		BGC:ListOptionsUpdate()
	end)
	exclude:SetScript("OnClick", function(self)
		self:Activate()
		include:Deactivate()
		vendorPrice:Deactivate()
		autoSell:Deactivate()
		help:Deactivate()
		promote:Enable(); promote:GetNormalTexture():SetDesaturated(false)
		demote:Enable(); demote:GetNormalTexture():SetDesaturated(false)
		frame.current = "exclude"
		scrollFrame:SetVerticalScroll(0)
		BGC:ListOptionsUpdate()
	end)
	vendorPrice:SetScript("OnClick", function(self)
		self:Activate()
		include:Deactivate()
		exclude:Deactivate()
		autoSell:Deactivate()
		help:Deactivate()
		promote:Disable(); promote:GetNormalTexture():SetDesaturated(true)
		demote:Disable(); demote:GetNormalTexture():SetDesaturated(true)
		frame.current = "forceVendorPrice"
		scrollFrame:SetVerticalScroll(0)
		BGC:ListOptionsUpdate()
	end)
	autoSell:SetScript("OnClick", function(self)
		self:Activate()
		include:Deactivate()
		exclude:Deactivate()
		vendorPrice:Deactivate()
		help:Deactivate()
		promote:Enable(); promote:GetNormalTexture():SetDesaturated(false)
		demote:Enable(); demote:GetNormalTexture():SetDesaturated(false)
		frame.current = "autoSellList"
		scrollFrame:SetVerticalScroll(0)
		BGC:ListOptionsUpdate()
	end)
	help:SetScript("OnClick", function(self)
		self:Activate()
		include:Deactivate()
		exclude:Deactivate()
		autoSell:Deactivate()
		vendorPrice:Deactivate()
		promote:Enable(); promote:GetNormalTexture():SetDesaturated(false)
		demote:Enable(); demote:GetNormalTexture():SetDesaturated(false)
		frame.current = nil
		scrollFrame:SetVerticalScroll(0)
		BGC:ListOptionsUpdate()
	end)
	
	-- function to set the drop treshold (limit) via the mousewheel
	local function OnMouseWheel(self, dir)
		if type(self.itemID) ~= "number" then return end
		
		local text, limit = self.limit:GetText()
		if self.isGlobal then
			list = Broker_Garbage:GetOption(frame.current, true)
		else
			list = Broker_Garbage:GetOption(frame.current, false)
		end
		
		local change = IsShiftKeyDown() and 10 or 1
		if dir == 1 then	-- up
			if list[self.itemID] == true then	-- trouble ahead :/
				list[self.itemID] = change
			else
				list[self.itemID] = list[self.itemID] + change
			end
			text = list[self.itemID]
		else				-- down
			if list[self.itemID] == true then	-- no change
				text = ""
			else
				list[self.itemID] = list[self.itemID] - change
				text = list[self.itemID]
			end
			
			if type(list[self.itemID]) == "number" and list[self.itemID] <= 0 then
				list[self.itemID] = true
				text = ""
			end
		end
		self.limit:SetText(text)
		Broker_Garbage:UpdateCache(self.itemID)
	end
	
	-- function that updates & shows items from various lists
	function BGC:ListOptionsUpdate()
		scrollContent:SetWidth(scrollFrame:GetWidth())	-- update scrollframe content to full width
		if frame.current == nil then
			local index = 1
			while _G["BG_ListOptions_ScrollFrame_Item"..index] do
				_G["BG_ListOptions_ScrollFrame_Item"..index]:Hide()
				index = index + 1
			end
			BGC:ShowHelp()
			return
		elseif _G["BG_HelpFrame"] then
			_G["BG_HelpFrame"]:Hide()
		end
		
		local localList, globalList = Broker_Garbage:GetOption(frame.current)
		local dataList = BGC:JoinTables(globalList or {}, localList or {})
		
		-- make this table sortable
		data = {}
		for key, value in pairs(dataList) do
			table.insert(data, key)
		end
		table.sort(data, function(a,b)
			if type(a) == "string" and type(b) == "string" then
				return a < b
			elseif type(a) == "number" and type(b) == "number" then
				return (GetItemInfo(a) or "z") < (GetItemInfo(b) or "z")
			else
				return type(a) == "string"
			end
		end)

		local numCols = math.floor((scrollContent:GetWidth() - 20 - 2)/(36 + 2))	-- or is it panel's width we want?
		for index, itemID in ipairs(data) do
			local button = _G[scrollContent:GetName().."_Item"..index]
			if not button then	-- create another button
				button = CreateFrame("CheckButton", scrollContent:GetName().."_Item"..index, scrollContent)
				button:SetWidth(36)
				button:SetHeight(36)

				button.limit = button:CreateFontString(nil, "ARTWORK", "NumberFontNormal")
				button.limit:SetPoint("BOTTOMLEFT", button, "BOTTOMLEFT", 2, 2)
				button.limit:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 2)
				button.limit:SetHeight(20)
				button.limit:SetJustifyH("RIGHT")
				button.limit:SetJustifyV("BOTTOM")
				button.limit:SetText("")
				
				button.global = button:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
				button.global:SetPoint("TOPLEFT", button, "TOPLEFT", 2, -2)
				button.global:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -3, 1)
				button.global:SetJustifyH("LEFT")
				button.global:SetJustifyV("TOP")
				button.global:SetText("")
				
				button:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")
				button:SetCheckedTexture("Interface\\Buttons\\UI-Button-Outline")
				button:SetChecked(false)
				local tex = button:GetCheckedTexture()
				tex:ClearAllPoints()
				tex:SetPoint("CENTER")
				tex:SetWidth(36/37*66) tex:SetHeight(36/37*66)
				
				button:SetScript("OnClick", function(self)
					local check = self:GetChecked()
					if IsModifiedClick() then	-- this handles chat linking as well as dress-up
						local linkText = type(self.itemID) == "string" and self.itemID or BGC.locale.AuctionAddonUnknown
						HandleModifiedItemClick(self.itemLink or linkText)
						self:SetChecked(not check)
					elseif not IsModifierKeyDown() then
						self:SetChecked(check)
					else
						self:SetChecked(not check)
					end
				end)
				button:SetScript("OnEnter", BGC.ShowTooltip)
				button:SetScript("OnLeave", BGC.HideTooltip)				
			end
			
			-- update button positions
			if index == 1 then		-- place first icon
				button:SetPoint("TOPLEFT", scrollContent, "TOPLEFT", 6, -6)
			elseif mod(index, numCols) == 1 then	-- new row
				button:SetPoint("TOPLEFT", _G[scrollContent:GetName().."_Item" .. index - numCols], "BOTTOMLEFT", 0, -6)
			else					-- new button next to the old one
				button:SetPoint("LEFT", _G[scrollContent:GetName().."_Item" .. index - 1], "RIGHT", 4, 0)
			end
			
			-- update this button with data
			local itemLink, texture
			if type(itemID) == "string" then
				if string.find(itemID, "^AC_") then
					-- this is an armor class
					local armorType = string.match(itemID, "^AC_(%d+)")
					local index = tonumber(armorType) 
					armorType = select(index, GetAuctionItemSubClasses(2))
					
					texture = "Interface\\Icons\\INV_Misc_Toy_07"
					
					button.itemLink = nil
					button.itemID = itemID
					button.tiptext = armorType or "Invalid Armor Type"
				elseif string.find(itemID, "^BEQ_") then
					-- blizzard gear set
					local setID, name, icon = string.match(itemID, "^BEQ_(%d+)")
					setID = tonumber(setID)
					if setID then
						name, icon = GetEquipmentSetInfo(setID)
					end
					
					texture = icon
					
					button.itemLink = nil
					button.itemID = itemID
					button.tiptext = name
				else
					-- this is an item category
					texture = "Interface\\Icons\\Trade_engineering"
					
					button.itemLink = nil
					button.itemID = nil
					button.tiptext = itemID			-- category description string
				end
			else
				-- this is an explicit item
				_, itemLink, _, _, _, _, _, _, _, texture, _ = GetItemInfo(itemID)
				button.itemLink = itemLink
				button.itemID = itemID
				button.tiptext = nil
			end
			
			if texture then	-- everything's fine
				if globalList[itemID] then
					button.global:SetText("G")
					button.isGlobal = true
				else
					button.global:SetText("")
					button.isGlobal = false
				end
				if button.isGlobal and globalList[itemID] ~= true then
					button.limit:SetText(globalList[itemID])
				elseif localList and localList[itemID] ~= true then
					button.limit:SetText(localList[itemID])
				else
					button.limit:SetText("")
				end
				
				if not itemLink and not BGC.PT then
					button:SetAlpha(0.2)
					button.tiptext = button.tiptext .. "\n|cffff0000"..BGC.locale.LPTNotLoaded
				else
					button:SetAlpha(1)
				end
			end
			button:SetNormalTexture(texture or "Interface\\Icons\\Inv_misc_questionmark")
			
			if BGC.listOptions.current == "include" then
				button:EnableMouseWheel(true)
				button:SetScript("OnMouseWheel", OnMouseWheel)
			else
				button:EnableMouseWheel(false)
			end
			button:SetChecked(false)
			button:Show()
		end
		-- hide unnessessary buttons
		local index = #data + 1
		while _G[scrollContent:GetName().."_Item"..index] do
			_G[scrollContent:GetName().."_Item"..index]:Hide()
			index = index + 1
		end
	end
	
	-- shows some help strings for setting up the lists
	function BGC:ShowHelp()
		if not _G["BG_HelpFrame"] then
			local helpFrame = CreateFrame("Frame", "BG_HelpFrame", scrollContent)
			helpFrame:SetAllPoints()
			
			local helpTexts = helpFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
			helpTexts:SetPoint("TOPLEFT", helpFrame, "TOPLEFT", 8, -4)
			helpTexts:SetWidth(helpFrame:GetWidth() - 8)	-- substract the offset we added to the left
			helpTexts:SetWordWrap(true)
			helpTexts:SetJustifyH("LEFT")
			helpTexts:SetJustifyV("TOP")
			helpTexts:SetText(BGC.locale.listsBestUse .. "\n\n" ..
				BGC.locale.listsSpecialOptions .. "\n\n" ..
				BGC.locale.iconButtonsUse .. "\n\n" ..
				BGC.locale.actionButtonsUse .. "\n")
		else
			_G["BG_HelpFrame"]:Show()
		end
	end
	
	-- when a search string is passed, suitable items will be shown while the rest is grayed out
	function BGC:UpdateSearch(searchString)
		local index = 1
		local button = _G[scrollContent:GetName().."_Item"..index]
		while button and button:IsVisible() do
			local name = button.itemID and GetItemInfo(button.itemID) or button.tiptext
			name = (button.itemID or "") .. " " .. (name or "")
			name = name:lower()
			
			if not searchString or string.match(name, searchString) then
				button:SetAlpha(1)
			else
				button:SetAlpha(0.3)
			end
			index = index + 1
			button = _G[scrollContent:GetName().."_Item"..index]
		end
	end
	
	local function AddItem(item)
		local cursorType, itemID, link = GetCursorInfo()
		if not item and not (cursorType and itemID and link) then
			return
		end
		
		local reset		
		-- create "link" for output
		if itemID and type(itemID) == "number" then
			-- item on cursor
			link = select(2, GetItemInfo(itemID))

		elseif item and type(item) == "string" then
			if string.find(item, "^AC_") then
				-- armor class
				reset = true
				itemID = item
				local armorType = string.match(item, "^AC_(%d+)")
				local index = tonumber(armorType) 
				armorType = select(index, GetAuctionItemSubClasses(2))
				link = BGC.locale.armorClass .. ": " .. (armorType or "Invalid Armor Class")
			elseif string.find(item, "^BEQ_") then
				-- equipment set
				reset = true
				itemID = item
				local setID = string.match(item, "^BEQ_(%d+)")
				setID = tonumber(setID)
				link = setID and GetEquipmentSetInfo(setID) or "Invalid Set"
		    else
				-- LPT category
				reset = true
				itemID = item
				link = item
			end
		end
		
		local localList, globalList = Broker_Garbage:GetOption(frame.current)
		if localList and localList[itemID] == nil then
			localList[itemID] = true
			BGC:Print(format(BGC.locale["addedTo_" .. frame.current], link))
			BGC:ListOptionsUpdate()
			ClearCursor()
		elseif localList == nil and globalList and globalList[itemID] == nil then
			globalList[itemID] = true
			BGC:Print(format(BGC.locale["addedTo_" .. frame.current], link))
			BGC:ListOptionsUpdate()
			ClearCursor()
		else
			BGC:Print(string.format(BGC.locale.itemAlreadyOnList, link))
		end
		
		-- post new data
		Broker_Garbage:SetOption(frame.current, false, localList)
		Broker_Garbage:SetOption(frame.current, true, globalList)
		
		if not reset then
			Broker_Garbage:UpdateCache(itemID)
		end
		Broker_Garbage:ScanInventory(reset)
		Broker_Garbage:UpdateRepairButton()
	end
	
	if not _G["BG_LPTMenuFrame"] then
		local RightClickMenuOnClick = function(self)
			AddItem(self.value)
			BGC:ListOptionsUpdate()
		end
		
		--initialize dropdown menu for adding setstrings
		BGC.menuFrame = CreateFrame("Frame", "BG_LPTMenuFrame", UIParent, "UIDropDownMenuTemplate")
		UIDropDownMenu_Initialize(BGC.menuFrame, function(self, level)
			BGC:LPTDropDown(self, level, RightClickMenuOnClick, true)
			
			-- add equipment sets
			if level == 1 then
				local info = UIDropDownMenu_CreateInfo()
				info.notCheckable = true
				UIDropDownMenu_AddButton(info, level)
				
				info = UIDropDownMenu_CreateInfo()
				info.notCheckable = true
				info.notClickable = true
				info.isTitle = true
				info.text = BGC.locale.tooltipHeadingOther
				UIDropDownMenu_AddButton(info, level)
				
				info = UIDropDownMenu_CreateInfo()
				info.notCheckable = true
				info.hasArrow = true
				info.text = BGC.locale.equipmentManager
				info.value = "BEQ"
				UIDropDownMenu_AddButton(info, level)
				
				info = UIDropDownMenu_CreateInfo()
				info.notCheckable = true
				info.hasArrow = true
				info.text = BGC.locale.armorClass
				info.value = "AC"
				UIDropDownMenu_AddButton(info, level)
			elseif level == 2 and UIDROPDOWNMENU_MENU_VALUE then
				if UIDROPDOWNMENU_MENU_VALUE == "BEQ" then
					for k = 1, GetNumEquipmentSets() do
						local info = UIDropDownMenu_CreateInfo()
						info.text = GetEquipmentSetInfo(k)
						info.value = "BEQ_" .. k
						
						info.notCheckable = true
						info.hasArrow = false
						info.func = RightClickMenuOnClick
						
						UIDropDownMenu_AddButton(info, level);
					end
				elseif UIDROPDOWNMENU_MENU_VALUE == "AC" then
					local armorTypes = { GetAuctionItemSubClasses(2) }
					
					for k = 2, 5 do
						local info = UIDropDownMenu_CreateInfo()
						info.text = armorTypes[k]
						info.value = "AC_"..k
						
						info.notCheckable = true
						info.hasArrow = false
						info.func = RightClickMenuOnClick
						
						UIDropDownMenu_AddButton(info, level);
					end
				end
			end
		end, "MENU")
	end
	
	local function OnClick(self, button)
		if frame.current == nil then return end
		if button == "RightButton" then
			-- toggle LibPeriodicTable menu
			BGC.menuFrame.clickTarget = self
			ToggleDropDownMenu(1, nil, BGC.menuFrame, self, -20, 0)
			return
		end
		
		local reset	-- used to clean the items cache once we're done here
		local localList, globalList = Broker_Garbage:GetOption(frame.current)
		-- add action
		if self == plus then			
			AddItem()
		-- remove action
		elseif self == minus then
			local index = 1
			while _G["BG_ListOptions_ScrollFrame_Item"..index] do
				local button = _G["BG_ListOptions_ScrollFrame_Item"..index]
				if button:IsVisible() and button:GetChecked() then
					local item = button.itemID or button.tiptext
					if localList then
						localList[item] = nil
					end
					if globalList then
						globalList[item] = nil
					end
					
					if type(item) == "number" then	-- regular item
						Broker_Garbage:UpdateCache(item)
					else							-- category string
						reset = true
					end
				end
				index = index + 1
			end
		-- demote action
		elseif self == demote then
			local index = 1
			while _G["BG_ListOptions_ScrollFrame_Item"..index] do
				local button = _G["BG_ListOptions_ScrollFrame_Item"..index]
				if button:IsVisible() and button:GetChecked() then
					local item = button.itemID or button.tiptext
					if globalList[item] and localList then
						localList[item] = globalList[item]
						globalList[item] = nil
					end
				end
				index = index + 1
			end
		-- promote action
		elseif self == promote then
			local index = 1
			while _G["BG_ListOptions_ScrollFrame_Item"..index] do
				local button = _G["BG_ListOptions_ScrollFrame_Item"..index]
				if button:IsVisible() and button:GetChecked() then
					local item = button.itemID or button.tiptext
					if not globalList[item] then
						globalList[item] = localList[item]
						localList[item] = nil
					end
				end
				index = index + 1
			end
		-- empty action
		elseif self == emptyList then
			BGC.itemsCache = {}
			if IsShiftKeyDown() then
				globalList = {}
			elseif localList then
				localList = {}
			end
		end
		
		-- post changed data
		Broker_Garbage:SetOption(frame.current, false, localList)
		Broker_Garbage:SetOption(frame.current, true, globalList)
		
		BGC:ListOptionsUpdate()
		Broker_Garbage:ScanInventory(reset)
		Broker_Garbage:UpdateRepairButton()
	end
	
	plus:SetScript("OnClick", OnClick)
	plus:SetScript("OnEnter", BGC.ShowTooltip)
	plus:SetScript("OnLeave", BGC.HideTooltip)
	minus:SetScript("OnClick", OnClick)
	minus:SetScript("OnEnter", BGC.ShowTooltip)
	minus:SetScript("OnLeave", BGC.HideTooltip)
	demote:SetScript("OnClick", OnClick)
	demote:SetScript("OnEnter", BGC.ShowTooltip)
	demote:SetScript("OnLeave", BGC.HideTooltip)
	promote:SetScript("OnClick", OnClick)
	promote:SetScript("OnEnter", BGC.ShowTooltip)
	promote:SetScript("OnLeave", BGC.HideTooltip)
	emptyList:SetScript("OnClick", OnClick)
	emptyList:SetScript("OnEnter", BGC.ShowTooltip)
	emptyList:SetScript("OnLeave", BGC.HideTooltip)
	
	-- support for add-mechanism
	plus:RegisterForDrag("LeftButton")
	plus:SetScript("OnReceiveDrag", ItemDrop)
	plus:SetScript("OnMouseDown", ItemDrop)
	
	BGC:ListOptionsUpdate()
	BGC.listOptions:SetScript("OnShow", BGC.ListOptionsUpdate)
end