local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

addon.Garrisons = {}

local ns = addon.Garrisons		-- ns = namespace

local view = {}
local isViewValid

local modes = {
	[1] = {	-- available missions
		GetName = function() return GARRISON_LANDING_AVAILABLE end,
		GetMissions = function(c) return DataStore:GetAvailableMissions(c) end,
		GetNumMissions = function(c) return DataStore:GetNumAvailableMissions(c) end,
		GetMissionInfo = function(c, id) return DataStore:GetAvailableMissionInfo(c, id) end,
	},
	[2] = {	-- active missions
		GetName = function() return GARRISON_LANDING_IN_PROGRESS end,
		GetMissions = function(c) return DataStore:GetActiveMissions(c) end,
		GetNumMissions = function(c) return DataStore:GetNumActiveMissions(c) end,
		GetMissionInfo = function(c, id) return DataStore:GetActiveMissionInfo(c, id) end,
	},
}

local function BuildView()
	wipe(view)

	local character = addon.Tabs.Characters:GetAltKey()
	local mode = addon:GetOption("UI.Tabs.Characters.GarrisonMissions")
	local api = modes[mode]
	local missions = api.GetMissions(character)
	if not missions then return end
	
	for id, mission in pairs(missions) do
		table.insert(view, id)
	end
	
	if mode == 2 then
		table.sort(view, function(a,b) 
				local remainingA = select(8, api.GetMissionInfo(character, a)) or 0
				local remainingB = select(8, api.GetMissionInfo(character, b)) or 0
				return remainingA < remainingB
			end)
	end
	
	isViewValid = true
end

function ns:Update()
	local character = addon.Tabs.Characters:GetAltKey()
	local mode = addon:GetOption("UI.Tabs.Characters.GarrisonMissions")
	local api = modes[mode]
	
	AltoholicTabCharacters.Status:SetText(format("%s|r / %s", DataStore:GetColoredCharacterName(character),
		format(api.GetName(), api.GetNumMissions(character))))
	
	if not isViewValid then
		BuildView()
	end

	local frame = AltoholicFrameGarrisonMissions
	local scrollFrame = frame.ScrollFrame
	local numRows = scrollFrame.numRows
	
	if not isViewValid then		-- make sure the scroll frame is cleared !
		for rowIndex = 1, numRows do
			local rowFrame = scrollFrame:GetRow(rowIndex) 
			rowFrame:Hide()
		end

		scrollFrame:Update(numRows)
		return
	end

	local offset = scrollFrame:GetOffset()
	
	for rowIndex = 1, numRows do
		local rowFrame = scrollFrame:GetRow(rowIndex)
		local line = rowIndex + offset
	
		if line <= #view then
			local missionID = view[line]
			local missionType, typeAtlas, missionLevel, missionILevel, cost, duration, 
				followers, remainingTime, successChance = api.GetMissionInfo(character, missionID)
			
			local color = colors.white
			local level = missionLevel
			
			if missionILevel ~= 0 then
				level = missionILevel
				
				if missionILevel >= 645 then
					color = colors.epic
				elseif missionILevel >= 630 then
					color = colors.rare
				elseif missionILevel >= 615 then
					color = colors.uncommon
				end
			end
			
			rowFrame.Name:SetText(format("%s%s |r(%s)", colors.white, C_Garrison.GetMissionName(missionID), SecondsToTime(duration)))
			rowFrame.Type.Icon:SetAtlas(typeAtlas)
			rowFrame.Type.Count:SetText(format("%s%s", color, level))
			rowFrame.Type.Count:Show()
			if remainingTime then
				if remainingTime == 0 then
					rowFrame.Remaining:SetText(colors.green .. GARRISON_MISSION_COMPLETE)
				else
					rowFrame.Remaining:SetText(SecondsToTime(remainingTime, true))
				end
				rowFrame.Remaining:Show()
			else
				rowFrame.Remaining:Hide()
			end
			
			if successChance then
				if successChance >= 75 then
					color = colors.green
				elseif successChance >= 50 then
					color = colors.yellow
				else
					color = colors.red
				end
				rowFrame.Success:SetText(format("%s%s%%", color, successChance))
				rowFrame.Success:Show()
			else
				rowFrame.Success:Hide()
			end
			
			if cost and cost > 0 then
				rowFrame.CostIcon:Show()
				rowFrame.Cost:SetText(cost)
				rowFrame.Cost:Show()
			else
				rowFrame.CostIcon:Hide()
				rowFrame.Cost:SetText("")
				rowFrame.Cost:Hide()
			end
			
			-- Followers
			local numFollowers = C_Garrison.GetMissionMaxFollowers(missionID)
			
			for i = 1, numFollowers do
				local portrait = rowFrame["Follower"..i].Portrait
				if followers then
					local followerID = followers[i]
					portrait:SetToFileData(C_Garrison.GetFollowerPortraitIconIDByID(followerID))
					portrait:Show()
					rowFrame["Follower"..i].key = character
					rowFrame["Follower"..i].followerID = followerID
				else
					portrait:Hide()
					rowFrame["Follower"..i].key = nil
					rowFrame["Follower"..i].followerID = nil
				end
			end
						
			if numFollowers == 1 then
				rowFrame.Follower1:Show()
				rowFrame.Follower2:Hide()
				rowFrame.Follower3:Hide()
			elseif numFollowers == 2 then
				rowFrame.Follower1:Show()
				rowFrame.Follower2:Show()
				rowFrame.Follower3:Hide()
			elseif numFollowers == 3 then
				rowFrame.Follower1:Show()
				rowFrame.Follower2:Show()
				rowFrame.Follower3:Show()
			end
			
			
			-- Rewards
			local rewardInfo = C_Garrison.GetMissionRewardInfo(missionID)
			local rewardIndex = 2
			
			for _, reward in pairs(rewardInfo) do
				local rewardButton = rowFrame["Reward" ..rewardIndex]
			
				if reward.itemID then
					rewardButton.Icon:SetTexture(GetItemIcon(reward.itemID))
					
					local iLvl = select(4, GetItemInfo(reward.itemID))
					if iLvl then	-- if the reward has an iLevel .. show it
						color = colors.white
						if iLvl >= 645 then
							color = colors.epic
						elseif iLvl >= 630 then
							color = colors.rare
						elseif iLvl >= 615 then
							color = colors.uncommon
						end
						rewardButton.Quantity:SetText(format("%s%s", color, iLvl))
					else
						rewardButton.Quantity:SetText("")
					end
					rewardButton.id = reward.itemID
					rewardButton.title = nil
					rewardButton.tooltip = nil
				elseif reward.icon then
					rewardButton.Icon:SetTexture(reward.icon)
					
					local quantity = ""
					local title = reward.title
					local tooltip = reward.tooltip
					
					if reward.followerXP then
						quantity = reward.followerXP
						if quantity >= 10000 then
							quantity = format("%2.0fk", quantity/1000)
						elseif quantity >= 1000 then
							quantity = format("%2.1fk", quantity/1000)
						end
						
					elseif reward.currencyID then
						quantity = reward.quantity
						
						if reward.currencyID == 0 then	-- this is money
							quantity = reward.quantity / 10000
							tooltip = GetMoneyString(reward.quantity)
						else
							title = GetCurrencyInfo(reward.currencyID)
							tooltip = quantity
						end
					end

					rewardButton.id = nil
					rewardButton.title = title
					rewardButton.tooltip = tooltip
					rewardButton.Quantity:SetText(quantity)
				end
				rewardButton:Show()
	
				rewardIndex = rewardIndex - 1
			end
			
			if rewardIndex == 1 then	-- will be 0 if 2 rewards
				rowFrame.Reward1:Hide()
			end
			
			rowFrame:Show()
		else
			rowFrame:Hide()
		end
	end
	
	scrollFrame:Update(#view)
end

function ns:InvalidateView()
	isViewValid = nil
end

local function OnGarrisonMissionListUpdate()
	ns:InvalidateView()
	ns:Update()
end

addon:RegisterEvent("GARRISON_MISSION_LIST_UPDATE", OnGarrisonMissionListUpdate)