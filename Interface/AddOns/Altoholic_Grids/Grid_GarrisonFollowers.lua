local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local OPTION_FOLLOWERS = "UI.Tabs.Grids.Garrisons.CurrentFollowers"

local view
local isViewValid
local collected = {}

-- Followers not recruited at the inn
local nonInnFollowers = { 
	[32] = true,
	[34] = true,
	[153] = true,
	[154] = true,
	[155] = true,
	[157] = true,
	[159] = true,
	[168] = true,
	[170] = true,
	[171] = true,
	[176] = true,
	[177] = true,
	[178] = true,
	[179] = true,
	[180] = true,
	[182] = true,
	[183] = true,
	[184] = true,
	[185] = true,
	[186] = true,
	[189] = true,
	[190] = true,
	[192] = true,
	[193] = true,
	[194] = true,
	[195] = true,
	[202] = true,
	[203] = true,
	[204] = true,
	[205] = true,
	[207] = true,
	[208] = true,
	[209] = true,
	[211] = true,
	[212] = true,
	[216] = true,
	[217] = true,
	[218] = true,
	[219] = true,
	[224] = true,
	[225] = true,
	[453] = true,
	[455] = true,
	[458] = true,
	[459] = true,
	[460] = true,
	[462] = true,
	[463] = true,
}

local followerTypes = {
	ALL,
	L["Collected"],
	L["Not collected"],
	L["Recruited at the inn"],
	L["Not recruited at the inn"],
}

local function SortByFollowerName(a, b)
	local nameA = C_Garrison.GetFollowerNameByID(a)
	local nameB = C_Garrison.GetFollowerNameByID(b)
	
	return nameA < nameB
end

local function BuildView()
	-- Prepare the followers' view
	-- list all collected followers (across all alts), sorted alphabetically
	-- .. then list all uncollected followers, also sorted alphabetically

	local realm, account = addon.Tabs.Grids:GetRealm()
	local uncollected = {}
	local followers
	
	-- Prepare a list of all collected followers across all alts on this realm
	for characterKey, character in pairs(DataStore:GetCharacters(realm, account)) do
		followers = DataStore:GetFollowers(character)
		
		if followers then
			for id, _ in pairs(followers) do
				-- temporary fix: follower keys have been replaced from their name (string) to their id (numeric)
				-- fix it here instead of in datastore, which is already ok.
				if type(id) == "number" then
					collected[id] = true	-- [123] = true
				end
			end
		end
	end
	
	-- Prepare a list of uncollected followers
	local link
	for k, follower in pairs(C_Garrison.GetFollowers()) do
		link = C_Garrison.GetFollowerLinkByID(follower.followerID)
		if link then
			local	id = link:match("garrfollower:(%d+)")
			id = tonumber(id)
				
			if not collected[id] then
				table.insert(uncollected, id)
			end
		end
	end
	table.sort(uncollected, SortByFollowerName)
	
	-- Now prepare the view, depending on user selection.
	view = {}
	
	local currentFollowers = addon:GetOption(OPTION_FOLLOWERS)
	
	if currentFollowers == 3 then		-- Not collected only
		for k, id in pairs(uncollected) do
			table.insert(view, id)
		end
		
		-- table is already sorted.
	
		isViewValid = true
		return 
	end
	
	-- in every other case (1, 2, 4 ,5) , we must add collected followers
	for id, _ in pairs(collected) do
		if currentFollowers <= 2 then				-- All (collected + uncollected) = 1, or 2 = collected only
			table.insert(view, id)
		elseif currentFollowers == 4 and not nonInnFollowers[id] then		-- All, but only from the inn
			table.insert(view, id)
		elseif currentFollowers == 5 and nonInnFollowers[id] then		-- All, but only NOT from the inn
			table.insert(view, id)
		end
	end
	table.sort(view, SortByFollowerName)

	-- add uncollected, only for the "All" option (1)
	if currentFollowers == 1 then				-- All (collected + uncollected)
		-- already sorted
		for k, id in pairs(uncollected) do
			table.insert(view, id)
		end
	end
	
	isViewValid = true
end

local function OnFollowerFilterChange(self)
	local currentFollowers = self.value
	
	addon:SetOption(OPTION_FOLLOWERS, currentFollowers)

	addon.Tabs.Grids:SetViewDDMText(followerTypes[currentFollowers])
	
	isViewValid = nil
	addon.Tabs.Grids:Update()
end

local function DropDown_Initialize(frame)
	local currentFollowers = addon:GetOption(OPTION_FOLLOWERS)
	
	for i = 1, #followerTypes do
		frame:AddButton(followerTypes[i], i, OnFollowerFilterChange, nil, (i==currentFollowers))
	end
	frame:AddCloseMenu()
end

local callbacks = {
	OnUpdate = function() 
			if not isViewValid then
				BuildView()
			end
		end,
	GetSize = function() return #view end,
	RowSetup = function(self, rowFrame, dataRowID)
			local id = view[dataRowID]
			local name = C_Garrison.GetFollowerNameByID(id)
			rowFrame.Name.followerID = id
			rowFrame.Name.followerName = name

			if name then
				rowFrame.Name.Text:SetText(colors.white .. name)
				rowFrame.Name.Text:SetJustifyH("LEFT")
			end
		end,
	RowOnEnter = function(self)
			local id = self.followerID
			local text = C_Garrison.GetFollowerSourceTextByID(id)
			if not text then return end
			
			AltoTooltip:SetOwner(self, "ANCHOR_TOP")
			AltoTooltip:ClearLines()
			AltoTooltip:AddLine(self.followerName, 1, 1, 1)
			AltoTooltip:AddLine(" ")
			AltoTooltip:AddLine(text)
			AltoTooltip:Show()
		end,
	RowOnLeave = function(self)
			AltoTooltip:Hide()
		end,
	ColumnSetup = function(self, button, dataRowID, character)
			local id = view[dataRowID]
			local rarity, level = DataStore:GetFollowerInfo(character, id)

			button.Name:SetFontObject("NumberFontNormalSmall")
			button.Name:SetJustifyH("RIGHT")
			button.Name:SetPoint("BOTTOMRIGHT", 0, 0)
			button.Background:SetDesaturated(false)
			button.Background:SetTexCoord(0, 1, 0, 1)
			GarrisonFollowerPortrait_Set(button.Background, C_Garrison.GetFollowerPortraitIconIDByID(id))
			
			if level then
				button.key = character
				button.followerID = id
				button.Background:SetVertexColor(1.0, 1.0, 1.0);
				button.Name:SetText(colors.green .. level)
				
				local r, g, b = GetItemQualityColor(rarity)
				button.IconBorder:SetVertexColor(r, g, b, 0.5)
				button.IconBorder:Show()
				
			else
				button.key = nil
				button.followerID = nil
				button.Background:SetVertexColor(0.4, 0.4, 0.4);
				button.Name:SetText("")
				button.IconBorder:SetVertexColor(1.0, 1.0, 1.0, 0.5)
				button.IconBorder:Hide()
			end
		end,
	OnEnter = function(frame)
			addon:DrawFollowerTooltip(frame)
		end,
	OnClick = function(frame, button)
			local character = frame.key
			if not character then return end

			-- get the follower link
			local link = DataStore:GetFollowerLink(character, frame.followerID)
			if not link then return end
			
			-- on shift-click, insert in chat
			if ( button == "LeftButton" ) and ( IsShiftKeyDown() ) then
				local chat = ChatEdit_GetLastActiveWindow()
				if chat:IsShown() then
					chat:Insert(link)
				end
			end
		end,
	OnLeave = function(self)
			FloatingGarrisonFollowerTooltip:Hide()
		end,
	InitViewDDM = function(frame, title)
			frame:Show()
			title:Show()

			local currentFollowers = addon:GetOption(OPTION_FOLLOWERS)
			
			frame:SetMenuWidth(100) 
			frame:SetButtonWidth(20)
			frame:SetText(followerTypes[currentFollowers])
			frame:Initialize(DropDown_Initialize, "MENU_NO_BORDERS")
		end,
}

local function OnFollowersUpdated()
	isViewValid = nil
	addon.Tabs.Grids:Update()
end

addon:RegisterMessage("DATASTORE_GARRISON_FOLLOWERS_UPDATED", OnFollowersUpdated)

addon.Tabs.Grids:RegisterGrid(11, callbacks)
