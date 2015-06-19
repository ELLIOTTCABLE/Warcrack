local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local THIS_ACCOUNT = "Default"

local ICON_NOT_STARTED = "Interface\\RaidFrame\\ReadyCheck-NotReady" 
local ICON_PARTIAL = "Interface\\RaidFrame\\ReadyCheck-Waiting"
local ICON_COMPLETED = "Interface\\RaidFrame\\ReadyCheck-Ready" 

local parentName = "AltoholicTabAchievements"
local parent

local view
local highlightIndex

local currentRealm = GetRealmName()
local currentAccount = THIS_ACCOUNT

addon.Tabs.Achievements = {}

local ns = addon.Tabs.Achievements		-- ns = namespace

local function BuildView()
	view = view or {}
	wipe(view)
	
	local cats = GetCategoryList()
	for _, categoryID in ipairs(cats) do
		local _, parentID = GetCategoryInfo(categoryID)
		
		if parentID == -1 then		-- add categories, followed by their respective sub-categories
			table.insert(view, { id = categoryID, isCollapsed = true } )
			
			for _, subCatID in ipairs(cats) do
				local _, subCatParentID = GetCategoryInfo(subCatID)
				if subCatParentID == categoryID then
					table.insert(view, subCatID )
				end
			end
		end
	end
end

local function Header_OnClick(frame)
	highlightIndex = frame.categoryIndex
	local header = view[highlightIndex]
	header.isCollapsed = not header.isCollapsed

	ns:Update();
	AltoholicFrameAchievements:Show()
	addon.Achievements:SetCategory(header.id)
	addon.Achievements:Update()
end

local function Item_OnClick(frame)
	highlightIndex = frame.subCategoryIndex
	local item = view[highlightIndex]
	
	ns:Update();
	AltoholicFrameAchievements:Show()
	addon.Achievements:SetCategory(item)
	addon.Achievements:Update()
end

function ns:Update()
	parent.ClassIcons:Update(currentAccount, currentRealm)

	if not view then
		BuildView()
	end

	local categoryIndex				-- index of the category in the menu table
	local categoryCacheIndex		-- index of the category in the cache table
	local MenuCache = {}
	
	for k, v in pairs (view) do		-- rebuild the cache
		if type(v) == "table" then		-- header
			categoryIndex = k
			table.insert(MenuCache, { linetype=1, nameIndex=k } )
			categoryCacheIndex = #MenuCache
			
			if (highlightIndex) and (highlightIndex == k) then
				MenuCache[#MenuCache].needsHighlight = true
			end
		else
			if view[categoryIndex].isCollapsed == false then
				table.insert(MenuCache, { linetype=2, nameIndex=k, parentIndex=categoryIndex } )
				
				if (highlightIndex) and (highlightIndex == k) then
					MenuCache[#MenuCache].needsHighlight = true
					MenuCache[categoryCacheIndex].needsHighlight = true
				end
			end
		end
	end
	
	local buttonWidth = 156
	if #MenuCache > 15 then
		buttonWidth = 136
	end
	
	local scrollFrame = parent.ScrollFrame
	local numRows = scrollFrame.numRows
	local offset = scrollFrame:GetOffset()
	local menuButton
	
	for rowIndex = 1, numRows do
		menuButton = scrollFrame:GetRow(rowIndex)
		
		local line = rowIndex + offset
		
		if line > #MenuCache then
			menuButton:Hide()
		else
			local p = MenuCache[line]
			
			menuButton:SetWidth(buttonWidth)
			menuButton.Text:SetWidth(buttonWidth - 21)
			if p.needsHighlight then
				menuButton:LockHighlight()
			else
				menuButton:UnlockHighlight()
			end			
			
			if p.linetype == 1 then
				local catName = GetCategoryInfo(view[p.nameIndex].id)
				
				menuButton.Text:SetText(colors.white .. catName)
				menuButton:SetScript("OnClick", Header_OnClick)
				menuButton.categoryIndex = p.nameIndex
			elseif p.linetype == 2 then
				local catName = GetCategoryInfo(view[p.nameIndex])
				
				menuButton.Text:SetText("|cFFBBFFBB   " .. catName)
				menuButton:SetScript("OnClick", Item_OnClick)
				menuButton.categoryIndex = p.parentIndex
				menuButton.subCategoryIndex = p.nameIndex
			end

			menuButton:Show()
		end
	end
	
	scrollFrame:Update(#MenuCache)
end

function ns:GetRealm()
	return currentRealm, currentAccount
end


-- ** realm selection **
local function OnRealmChange(self, account, realm)
	local oldAccount = currentAccount
	local oldRealm = currentRealm

	currentAccount = account
	currentRealm = realm

	parent.SelectRealm:SetSelectedValue(format("%s|%s", account, realm))
	parent.SelectRealm:SetText(format("%s%s: %s%s", colors.green, account, colors.white, realm))
	
	if oldRealm and oldAccount then	-- clear the "select char" drop down if realm or account has changed
		if (oldRealm ~= realm) or (oldAccount ~= account) then
			parent.ClassIcons:Update(currentAccount, currentRealm)
			parent.Status:SetText("")
			addon.Achievements:Update()
		end
	end
end

local function AddRealm(realm, account)
	local info = UIDropDownMenu_CreateInfo(); 

	info.text = format("%s: %s", colors.green..account, colors.white..realm)
	info.value = format("%s|%s", account, realm)
	info.checked = nil
	info.func = OnRealmChange
	info.arg1 = account
	info.arg2 = realm
	UIDropDownMenu_AddButton(info, 1); 
end

function ns.DropDownRealm_Initialize(frame)
	if not currentAccount or not currentRealm then return end

	-- this account first ..
	frame:AddTitle(colors.gold..L["This account"])
	for realm in pairs(DataStore:GetRealms()) do
		local info = frame:CreateInfo()

		info.text = colors.white..realm
		info.value = format("%s|%s", THIS_ACCOUNT, realm)
		info.checked = nil
		info.func = OnRealmChange
		info.arg1 = THIS_ACCOUNT
		info.arg2 = realm
		frame:AddButtonInfo(info, 1)
	end

	-- .. then all other accounts
	local accounts = DataStore:GetAccounts()
	local count = 0
	for account in pairs(accounts) do
		if account ~= THIS_ACCOUNT then
			count = count + 1
		end
	end
	
	if count > 0 then
		frame:AddTitle()
		frame:AddTitle(colors.gold..OTHER)
		for account in pairs(accounts) do
			if account ~= THIS_ACCOUNT then
				for realm in pairs(DataStore:GetRealms(account)) do
					local info = frame:CreateInfo()

					info.text = format("%s: %s", colors.green..account, colors.white..realm)
					info.value = format("%s|%s", account, realm)
					info.checked = nil
					info.func = OnRealmChange
					info.arg1 = account
					info.arg2 = realm
					frame:AddButtonInfo(info, 1)
				end
			end
		end
	end
	
	frame:AddTitle()
	frame:AddTitle(colors.gold..L["Not started"], ICON_NOT_STARTED)
	frame:AddTitle(colors.gold..L["Started"], ICON_PARTIAL)
	frame:AddTitle(colors.gold..COMPLETE, ICON_COMPLETED)
end


-- ** Icon events **
local function OnCharacterChange(self, id)
	if not id then return end		-- no icon id ? exit
	
	local key = self.value		-- key is either a datastore character key, or nil (if "None" is selected by the player for this column)

	if key == "empty" then		-- if the keyword "empty" is passed, save a nil value in the options
		key = nil
	end

	addon:SetOption(format("Tabs.Achievements.%s.%s.Column%d", currentAccount, currentRealm, id), key)
	parent.ClassIcons:Update(currentAccount, currentRealm)
	addon.Achievements:Update()
end

-- ** Menu Icons **
function ns:Icon_OnEnter(frame)
	local currentMenuID = frame:GetID()
	local menu = frame:GetParent():GetParent().ContextualMenu

	menu.menuID = currentMenuID
	menu:Close()
	menu:Toggle(frame, 0, 0)

	local key = addon:GetOption(format("Tabs.Achievements.%s.%s.Column%d", currentAccount, currentRealm, currentMenuID))
	if key then
		frame:DrawTooltip(key)
	end
end

local function ClassIcon_Initialize(frame, level)
	local id = frame.menuID
	
	frame:AddTitle(L["Characters"])
	local nameList = {}		-- we want to list characters alphabetically
	for _, character in pairs(DataStore:GetCharacters(currentRealm, currentAccount)) do
		table.insert(nameList, character)	-- we can add the key instead of just the name, since they will all be like account.realm.name, where account & realm are identical
	end
	table.sort(nameList)
	
	-- get the key associated with this button
	local key = addon:GetOption(format("Tabs.Achievements.%s.%s.Column%d", currentAccount, currentRealm, id)) or ""
	
	for _, character in ipairs(nameList) do
		local info = frame:CreateInfo()
		
		info.text		= DataStore:GetColoredCharacterName(character)
		info.value		= character
		info.func		= OnCharacterChange
		info.checked	= (key == character)
		info.arg1		= id
		frame:AddButtonInfo(info, 1)
	end
	
	frame:AddTitle()
	
	local info = frame:CreateInfo()
	info.text		= (id == 1) and RESET or NONE
	info.value		= "empty"
	info.func		= OnCharacterChange
	info.checked	= (key == "")
	info.arg1		= id
	frame:AddButtonInfo(info, 1)

	frame:AddCloseMenu()
end

function ns:OnLoad()
	parent = _G[parentName]
	parent.ContextualMenu:Initialize(ClassIcon_Initialize, "MENU")
end

local function OnAchievementEarned(event, id)
	if id then
		addon.Achievements:Update()
	end
end

addon:RegisterEvent("ACHIEVEMENT_EARNED", OnAchievementEarned)
