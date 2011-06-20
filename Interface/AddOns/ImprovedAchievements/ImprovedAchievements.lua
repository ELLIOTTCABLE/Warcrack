local IA = {}
local blankFunc = function() end
local metaList = {}
local achievementInfo = {}
local achievementShown = {}
local searchName

local L = {
	["Search"] = "Search...",
}

function IA:Initialize()
	local function OnEnter(self)
		-- Default tooltip that just shows date
		if( self.date ) then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:AddLine(self.date, 1, 1, 1)
			GameTooltip:Show()
		-- Our custom one that shows the description and such as well
		elseif( self.tooltip ) then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:AddLine(self.tooltipTitle)
			GameTooltip:AddLine(self.tooltip, 1, 1, 1, true)
			GameTooltip:Show()
		end
	end
	
	-- Gives us access to the metas easily
	orig_AchievementButton_GetMeta = AchievementButton_GetMeta
	AchievementButton_GetMeta = function(index)
		local frame = orig_AchievementButton_GetMeta(index)
		if( not metaList[index] ) then
			metaList[index] = frame
			
			frame:SetScript("OnEnter", OnEnter)
		end
		
		return frame
	end
		
	-- For modifying meta thingy
	orig_AchievementObjectives_DisplayCriteria = AchievementObjectives_DisplayCriteria
	AchievementObjectives_DisplayCriteria = function(objectives, id)
		orig_AchievementObjectives_DisplayCriteria(objectives, id)
		
		-- Are we using metas for this achievement?
		-- Using World Explorer for this example
		if( metaList[1] and metaList[1]:IsVisible() ) then
			-- #1 = Explore EK, #2 = Explore Kalimdor, #3 = Explore Outland, #4 = Explore Northrend
			for _, meta in pairs(metaList) do
				achievementInfo.total = 0
				achievementInfo.completed = 0
				
				local parentName, _, _, _, _, _, parentDescription = select(2, GetAchievementInfo(meta.id))
				
				-- Information of the Explore achievement
				for i=1, GetAchievementNumCriteria(meta.id) do
					local criteriaString, criteriaType, completed, quantity, reqQuantity, charName, flags, assetID, quantityString = GetAchievementCriteriaInfo(meta.id, i)
					-- This is a meta criteria, so it'll contain the parent achievement info
					if( criteriaType == CRITERIA_TYPE_ACHIEVEMENT and assetID ) then
						-- Now we have the actual achievement info of the parent, like Explore Duskwood, etc, etc
						completed = select(4, GetAchievementInfo(assetID))

						-- Update totals
						achievementInfo.total = achievementInfo.total + 1
						if( completed ) then
							achievementInfo.completed = achievementInfo.completed + 1
						end
					
					-- Progress bar
					elseif( bit.band(flags, ACHIEVEMENT_CRITERIA_PROGRESS_BAR) == ACHIEVEMENT_CRITERIA_PROGRESS_BAR ) then
						achievementInfo.total = achievementInfo.total + reqQuantity
						achievementInfo.completed = achievementInfo.completed + quantity
					
					-- Text achievement
					else
						-- Update totals
						achievementInfo.total = achievementInfo.total + 1
						if( completed ) then
							achievementInfo.completed = achievementInfo.completed + 1
						end
					end
				end
				
				-- No date, it's not compelted
				if( not meta.date ) then
					local completed = ""
					if( achievementInfo.total > 0 ) then
						completed = string.format(" (%s / %s)", achievementInfo.completed, achievementInfo.total)
					end
					
					meta.tooltipTitle = string.format("|cffffd100%s%s|r", parentName, completed)
					meta.tooltip = parentDescription
				end
			end
		end
	end
			
	-- So we can search things being lazy
	orig_AchievementFrameAchievements_Update = AchievementFrameAchievements_Update
	AchievementFrameAchievements_Update = function(...)
		-- Reset the list of what we showed already
		for k in pairs(achievementShown) do achievementShown[k] = nil end
		
		-- Call the original now!
		orig_AchievementFrameAchievements_Update(...)
	end

	-- Re-set functions so it uses the hooked one
	AchievementFrameAchievementsContainer.update = AchievementFrameAchievements_Update
	ACHIEVEMENT_FUNCTIONS.updateFunc = AchievementFrameAchievements_Update
		
	-- For searching achievements without having to rewrite an entire function
	local orig_AchievementButton_DisplayAchievement = AchievementButton_DisplayAchievement
	AchievementButton_DisplayAchievement = function(button, category, achievement, selectionID, ...)
		-- In order to avoid having to redo the entire display code, we hack the search in this way, I'm fairly happy with it
		if( searchName ) then
			local id, name, points, completed, month, day, year, description, flags, icon, rewardText = GetAchievementInfo(category, achievement)
			if( achievementShown[id] or not name or not string.match(string.lower(name), searchName) ) then
				button:Hide()
				
				-- Keep going until we run out of achievements
				if( name ) then
					return AchievementButton_DisplayAchievement(button, category, achievement + 1, selectionID, ...)
				end
				return
			end
			
			-- Prevent the same achievement from showing up 5000 times
			achievementShown[id] = true
		end
		
		-- Call original
		return orig_AchievementButton_DisplayAchievement(button, category, achievement, selectionID, ...)
	end
		
	-- Setup search input
	local search = CreateFrame("EditBox", "DASearchInput", AchievementFrameCategories, "InputBoxTemplate")
	search:SetHeight(16)
	search:SetWidth(184)
	search:SetAutoFocus(false)
	search:ClearAllPoints()
	search:SetPoint("BOTTOMLEFT", AchievementFrameCategories, "BOTTOMLEFT", 9, 4)
	search:SetFrameStrata("HIGH")
	search:Hide()
	
	search.searchText = true
	search:SetText(L["Search"])
	search:SetTextColor(0.90, 0.90, 0.90, 0.80)
	search:SetScript("OnTextChanged", function(self)
		if( self.searchText or self:GetText() == "" ) then
			searchName = nil
		else
			searchName = string.lower(self:GetText())
		end

		AchievementFrameAchievements_Update()
	end)
	search:SetScript("OnEditFocusGained", function(self)
		if( self.searchText ) then
			self.searchText = nil
			self:SetText("")
			self:SetTextColor(1, 1, 1, 1)
		end
	end)
	
	search:SetScript("OnEditFocusLost", function(self)
		if( not self.searchText and string.trim(self:GetText()) == "" ) then
			self.searchText = true
			self:SetText(L["Search"])
			self:SetTextColor(0.90, 0.90, 0.90, 0.80)
		end
	end)
		
	-- We can't monitor the OnShow/OnHide events because they aren't consistant (It's stupid, I know)
	orig_AchievementFrameBaseTab_OnClick = AchievementFrameBaseTab_OnClick
	AchievementFrameBaseTab_OnClick = function(id, ...)
		orig_AchievementFrameBaseTab_OnClick(id, ...)
		
		if( id == 1 ) then
			search:Show()
		else
			search:SetText("")
			search:ClearFocus()
			search:Hide()
		end
	end
end


local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon)
	if( IsAddOnLoaded("Blizzard_AchievementUI") ) then
		IA:Initialize()
		self:UnregisterAllEvents()
	end
end)