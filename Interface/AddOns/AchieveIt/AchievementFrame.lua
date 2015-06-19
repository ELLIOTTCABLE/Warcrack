local _, AchieveIt = ...

-- Locale
local L = LibStub("AceLocale-3.0"):GetLocale("AchieveIt");

-- Register Event
AchieveIt:RegisterEvent("ADDON_LOADED", function(eventName, addon)
	if (addon == "Blizzard_AchievementUI") then
		ModifyAchievementFrame();
		AchieveIt:UnregisterEvent(eventName);
	end
end);

-- Applies modifications to the achievements frame
function ModifyAchievementFrame()

-- fix for 5.4.1 UpdateMicroButtons taint issue
setfenv(AchievementFrame_OnShow, setmetatable({ UpdateMicroButtons = function() end }, { __index = _G }))

-- Lua functions
local tremove, tinsert, pairs, mathceil = tremove, tinsert, pairs, math.ceil;

local inGuildView = false;

-- The locate button
local locateButton;

---------------------------
-- WoW API Modifications --
---------------------------

-- GetCategoryInfo(id)
-- @param {int} id	The ID of the category
-- @returns name, parent id, int
--
-- Extended so it works for AchieveIt sub categories
AchieveIt:RawHook("GetCategoryInfo", function(id)

	-- if id is an AchieveIt sub category
	if (AchieveIt.Categories:isCategory(id)) then

		-- fetch sub category
		local subCategory;
		if (not inGuildView) then
			subCategory = AchieveIt.Categories:findCategory(id);		
		else
			subCategory = AchieveIt.GuildCategories:findCategory(id);		
		end

		-- return info (name, parent id, unknown number)

		return subCategory.name, subCategory.parentId, 0

	-- standard WoW achievement category
	else

		-- return original function
		return AchieveIt.hooks["GetCategoryInfo"](id);

	end

end, true);

-- GetAchievementInfo
--
-- Returns information about an achievement
-- Overwritten so it can handle using AchieveIt categories/achievement index
AchieveIt:RawHook("GetAchievementInfo", function(category, achievement)
	
	-- achievement index is set and category is an AchieveIt category
	if (achievement and AchieveIt.Categories:isCategory(category)) then

		-- find sub category
		local aiCategory;
		if (not inGuildView) then
			aiCategory = AchieveIt.Categories:findCategory(category);
		else 
			aiCategory = AchieveIt.GuildCategories:findCategory(category);
		end

		-- sort achievements adding completed ones to the top
		aiCategory:sort();

		-- get achievement id
		local achievementId	= aiCategory.achievements[achievement];

		-- if achievement id was found
		if (achievementId) then

			-- reset arguments so the function is called using the achievement id and not
			-- category/index
			category, achievement = achievementId, nil;

		-- not achievement if found
		else

			-- call an unreachable index from the General category to simulate no achievement found
			category, achievement = 92, 999999999;

		end

	end
	
	return AchieveIt.hooks["GetAchievementInfo"](category, achievement);

end, true);

-- GetCategoryNumAchievements
-- @param {int} categoryId	The ID of the category
--
-- Returns the total, completed and incomplete number of achievements
-- Overwritten so it can handle addon categories
AchieveIt:RawHook("GetCategoryNumAchievements", function(categoryId, showAll)
	
	if (AchieveIt.Categories:isCategory(categoryId)) then

		local aiCategory;
		if (not inGuildView) then
			aiCategory = AchieveIt.Categories:findCategory(categoryId);
		else
			aiCategory = AchieveIt.GuildCategories:findCategory(categoryId);
		end

		-- showAll only gets called on real achievement categories so we want to return nothing if the category if an addon category
		-- so that the totals are not added to the totals of the real categories as they are just duplications
		if (showAll) then
			return 0,0,0;
		else
			return aiCategory:getNum(), aiCategory:getNumCompleted(), aiCategory:getNumIncompleted();
		end

	else

		return AchieveIt.hooks["GetCategoryNumAchievements"](categoryId, showAll);

	end

end, true);

-------------------------------------
-- Achievement Frame Modifications --
-------------------------------------

-- Table containing various functions for achievements depending on what type of achievements are being viewed
-- {
-- 		categoryAccessor = function - WoW API function to access catagories
-- 		clearFunc = function - Clears the achievements in the main frame
-- 		updateFunc = function - Updates the achievements in the main frame
-- 		selectedCategory = string/number - The currently selected category id
-- }
local achievementFunctions = ACHIEVEMENT_FUNCTIONS;

----------------------
-- Helper Functions --
----------------------

-- Returns whether the button for the selected category id is in view in the categories panel
-- @param {number} id	The category id
local buttonShown = function(id, debug)

	-- assume button is not shown
	local isShown, categoryButton = false, nil;

	-- loop through each visible button
	for _, button in pairs(AchievementFrameCategoriesContainer.buttons) do

		-- if the current button is the requested category
		if (button.categoryID == id) then

			local comparison = mathceil(button:GetTop()) <= mathceil(AchievementFrameCategoriesContainer:GetTop())
										and mathceil(button:GetBottom()) >= mathceil(AchievementFrameCategoriesContainer:GetBottom());

			if (debug) then
				AchieveIt:Printd("comparison", comparison);
				AchieveIt:Printd("Button Top", mathceil(button:GetTop()), "Frame Top", mathceil(AchievementFrameCategoriesContainer:GetTop()));
				AchieveIt:Printd("Button Bottom", mathceil(button:GetBottom()), "Frame Bottom", mathceil(AchievementFrameCategoriesContainer:GetBottom()));
			end

			-- and it is fully in view
			if (comparison) then

				-- button is shown
				isShown = true;

				-- store button
				categoryButton = button;

			end

		end

	end

	return isShown, categoryButton;

end



-- Fetches all achievements in the parent chain
-- The parent chain is any category above the requested one
-- e.g.
-- 	1:
-- 		2:
-- 			3, 4
-- 		5:
-- 			6, 7
-- For ID 3, parent chain is 1, 2, 5 (everything above it)
-- direct parents are 1, 2
local getParentChain = function(id)

	-- initialise locals
	local currentId, directParents = id, {};

	-- loop through each achivement category backwards
	for i=#ACHIEVEMENTUI_CATEGORIES, 1, -1 do

		-- get current category
		local currentCategory = ACHIEVEMENTUI_CATEGORIES[i];

		-- if the current parent is a number and matches the current id
		if (type(currentCategory.parent) == "number" and currentCategory.id == currentId) then

			-- update current id
			currentId = currentCategory.parent;

			-- add current id to direct parents chain
			directParents[currentId] = true;

		end

	end
	
	-- inialise entire parent chain
	local parentChain = {};

	-- loop through each achievement category
	for i=1, #ACHIEVEMENTUI_CATEGORIES do

		-- get current category
		local currentCategory = ACHIEVEMENTUI_CATEGORIES[i];

		-- if the current category parent or id are in the direct chain
		if (
			(type(currentCategory.parent) == "number" and directParents[currentCategory.parent]) or
			(type(currentCategory.id) == "number" and directParents[currentCategory.id])
		) then

			-- add the current category to the parent chain
			parentChain[currentCategory.id] = true;

		end

	end

	-- return both parent chain and direct parents
	return parentChain, directParents;

end

-- Simulates a button click for a specific category
-- @param {Number} id	The category id we want to click
local simulateClick = function (id)

	AchieveIt:Printd("Simulating click for ", id);
	
	-- we will return this as the clicked button once we have found it
	local clickedButton = nil;

	-- hide all non chain categories
	local parentChain = getParentChain(id);

	-- loop through each category
	for i, category in next, ACHIEVEMENTUI_CATEGORIES do
		-- if category is not in the parent chain
		if (not parentChain[category.id] and type(category.parent) == "number") then
			-- hide it
			category.hidden = true;
		end
	end

	-- get current selected category
	local lastSelectedCategory = achievementFunctions.selectedCategory;

	-- select the summary category
	achievementFunctions.selectedCategory = id;

	-- update categories
	AchievementFrameCategories_Update();

	-- set the selected category back to the last one
	achievementFunctions.selectedCategory = lastSelectedCategory;

	-- we need the category to be in view before we can click it so we scroll through the list until we find it

	local shown, i = false, 1;

	-- check if category is shown
	shown, clickedButton = buttonShown(id);

	-- while not shown
	while (not shown) do

		-- scroll down a bit
		HybridScrollFrame_OnMouseWheel(AchievementFrameCategoriesContainer, -1);

		-- check if it is now shown
		shown, clickedButton = buttonShown(id);

		-- loop protection in case something goes wrong
		i = i+1;
		if (i > 100) then
			AchieveIt:Printd("Too many loops simulating");
			shown = true;
		end

	end

	if (clickedButton) then

		clickedButton.isSelected = nil;
		clickedButton.element.collapsed = true;

		AchievementFrameCategories_SelectButton(clickedButton);
		AchievementFrameCategories_Update();
	end

end

-- Store whether the category has been changed
-- We use this to determine whether we should try to scroll the categories frame into the correct location
local categoryChange = false;

-- Track whether we are currently scrolling a category into view
local scrollingIntoView = false;

local scrollCategoryInView = function(categoryID)
	
	local shown, categoryButton = false, nil;

	-- if we have not already started scrolling
	-- need to check this because auto scrolling will trigger another call which will result in an infinite loop
	if (not scrollingIntoView) then

		-- set scrolling into view
		scrollingIntoView = true;

		-- get the category
		local category = AchieveIt.Categories:findCategory(categoryID);

		-- Get all parents
		----------------------

		-- get direct parent chain
		local parentChain, directParentChain = getParentChain(categoryID);

		local directParent, categoryChain = nil, {};

		local positiveChain, negativeChain = {}, {};

		-- for each parent, select the parent and update the categories list
		for parentId, _ in pairs(directParentChain) do

			-- we now need to order the parent chain correctly as follows:
			-- ascending positives, followed by descending negatives

			-- positive id
			if (parentId > 0) then

				local added = false;

				-- first in category
				if (#positiveChain == 0) then

					tinsert(positiveChain, parentId);
					added = true;

				else

					-- loop through each category
					for j=1, #positiveChain do

						-- if parentId is less than current in chain then it should come before it
						if (parentId < positiveChain[j]) then

							tinsert(positiveChain, j, parentId);
							added = true;

						end

					end

				end

				-- if nothing has been added then add it to the end
				if (not added) then

					tinsert(positiveChain, parentId);

				end

			-- negative id
			else

				local added = false;

				-- first in category
				if (#negativeChain == 0) then

					tinsert(negativeChain, parentId);
					added = true;

				else

					-- loop through each category
					for j=1, #negativeChain do

						-- if parentId is greater than current in chain then it should come before it
						if (parentId > negativeChain[j]) then

							tinsert(negativeChain, j, parentId);
							added = true;

						end

					end

				end

				-- if nothing has been added then add it to the end				
				if (not added) then

					tinsert(negativeChain, parentId);

				end

			end

		end

		-- append negative chain to position chain
		for i=1, #negativeChain do

			tinsert(positiveChain, negativeChain[i]);

		end

		-- and get positive chain as the valid category chain
		categoryChain = positiveChain;

		-- add category id to chain
		tinsert(categoryChain, categoryID);

		-- remove top level category from chain if category level has more than 2 steps
		if (category and category.level > 1) then

			tremove(categoryChain, 1);

		end

		--AchieveIt:Printt("CategoryChain", categoryChain);

		-- scroll the requested category into view
		-- ideally the category parent, and all it's children will be in view
		-- otherwise we will scroll down until the final child is in view
		-- otherwise we will make sure the category is in view

		-- get scroll and container min and max values
		local scrollMin, scrollMax = AchievementFrameCategoriesContainerScrollBar:GetMinMaxValues();
		local containerTop, containerBottom = mathceil(AchievementFrameCategoriesContainer:GetTop()), mathceil(AchievementFrameCategoriesContainer:GetBottom());

		-- scroll top bottom
		AchievementFrameCategoriesContainerScrollBar:SetValue(scrollMax);

		local buttonAtTop, loopProtection = false, 1;

		-- loop through each category in chain
		for i=1, #categoryChain do

			-- scroll back down to the bottom
			AchievementFrameCategoriesContainerScrollBar:SetValue(scrollMax);

			-- check if button is shown
			buttonAtTop = buttonShown(categoryChain[i]);
			
			-- while it's not shown
			while (not buttonAtTop) do

				-- scroll up a bit
				HybridScrollFrame_OnMouseWheel(AchievementFrameCategoriesContainer, 1);

				-- check it again
				buttonAtTop = buttonShown(categoryChain[i]);

				-- check we aren't at top of scroll
				if (AchievementFrameCategoriesContainerScrollBar:GetValue() <= scrollMin ) then
					AchieveIt:Printd("Reached top of scroll container - categoryChain", categoryChain[i]);
					buttonAtTop = true;
				end

				-- loop protection
				loopProtection = loopProtection + 1;
				if (loopProtection > 100) then
					AchieveIt:Printd("Too many loops - categoryChain", categoryChain[i]);
					buttonAtTop = true;
				end

			end

			-- check if the selected category button is shown
			local selectedCategoryButtonShown;
			selectedCategoryButtonShown, categoryButton = buttonShown(categoryID);

			-- if it is then stop loop
			if (selectedCategoryButtonShown) then

				break;

			end

		end

		-- if the selected category was a custom category and it has children
		if (category and #category.children > 0) then

			-- get the last child
			local lastChild = category.children[#category.children];

			-- check if last child is shown
			local lastChildShown = buttonShown(lastChild.id);
			loopProtection = 1;

			-- while it's not shown
			while (not lastChildShown) do

				-- scroll down
				HybridScrollFrame_OnMouseWheel(AchievementFrameCategoriesContainer, -1);

				-- check again
				lastChildShown = buttonShown(lastChild.id);

				-- check we aren't at bottom of scroll
				if (AchievementFrameCategoriesContainerScrollBar:GetValue() >= scrollMax ) then
					AchieveIt:Printd("Reached bottom of scroll container - child scroll", lastChild.id);
					lastChildShown = true;
				end

				loopProtection = loopProtection + 1;
				if (loopProtection > 100) then
					AchieveIt:Printd("Too many loops");
					lastChildShown = true;
				end

			end

		end

		-- finished scrolling
		scrollingIntoView = false;

	end

	return categoryButton;

end

-- AchievementFrameBaseTab_OnClick
-- @param {int} id	The ID of the tab being clicked
--
-- Fires when a base tab is clicked
-- We hook into it so we can store out own local verion of the achievementFunctions table
-- as it is local to the WoW achivements frame and we need to be able to access it in our mods
AchieveIt:Hook("AchievementFrameBaseTab_OnClick", function(id)
	
	activeTabId = id;

	-- Character Achievements
	if (id == 1) then

		inGuildView = false;

		achievementFunctions = ACHIEVEMENT_FUNCTIONS;

	-- Guild Achievements
	elseif (id == 2) then

		inGuildView = true;

		achievementFunctions = GUILD_ACHIEVEMENT_FUNCTIONS;

	-- Character Stats
	else

		inGuildView = false;

		achievementFunctions = STAT_FUNCTIONS;

	end

end, true);

-- AchievementFrameComparisonTab_OnClick
-- @param {int} id	The ID of the comparison tab being clicked
--
-- Fires when a comparison view is requested
AchieveIt:SecureHook("AchievementFrameComparisonTab_OnClick", function(id)

	-- Character Achievements
	if (id == 1) then

		achievementFunctions = COMPARISON_ACHIEVEMENT_FUNCTIONS;

	-- Character Stats
	else

		achievementFunctions = COMPARISON_STAT_FUNCTIONS;

	end

end);

-- AchievementFrameCategories_GetCategoryList(categories)
-- @param {table} categories	Array of achievement categories
--
-- Adds all categories to an array that populates the AchievementFrameCategoriesContainer panel
-- Extended to add our own custom sub categories
AchieveIt:SecureHook("AchievementFrameCategories_GetCategoryList", function(categories)

	local parents = {};

	for i = 1, #categories do
		if (type(categories[i].parent) == "number") then
			parents[categories[i].parent] = true;
		end
	end

	for i = 1, #categories do
		if (parents[categories[i].id]) then			
			categories[i].hasChildren = true;
		end
	end
	
	local topLevelCategories;
	if (not inGuildView) then
		topLevelCategories = AchieveIt.Categories:findParent(false);
	else
		topLevelCategories = AchieveIt.GuildCategories:findParent(false);
	end

	for topLevelId, topLevelCategory in pairs(topLevelCategories) do

		tinsert(categories, {
			id			= topLevelId,
			level		= 0,
			hasChildren	= #topLevelCategory.children > 0
		});

	end

	-- loop through each category backwards (so we can add new entries without breaking the loop)
	for i = #categories, 1, -1 do 
		
		-- current category
		local currentCategory = categories[i];

		local parentCategory;
		if (not inGuildView) then
			parentCategory = AchieveIt.Categories:findParent(currentCategory.id);
		else
			parentCategory = AchieveIt.GuildCategories:findParent(currentCategory.id);
		end

		if (AchieveIt.Categories:isCategory(currentCategory.id)) then

			parentCategory = { parentCategory };

		end
		
		-- if addon category exists
		if (parentCategory) then
			
			currentCategory.hasChildren = true;

			-- Function to recursively add all sub categories and their children to the achievement frame
			-- categories list
			local addSubCategories;
			addSubCategories = function(parentId, category)

				-- loop through each sub category
				for j=#category.children, 1, -1 do

					-- current category
					local subCategory = category.children[j];

					-- firstly add sub category children
					addSubCategories(category.id, subCategory);

				end

				if (parentId ~= category.id) then

					-- finally add the current sub category
					tinsert(
						categories,
						i+1,
						{
							id			= category.id,
							parent		= parentId,
							hidden		= true,
							level		= category.level,
							hasChildren	= #category.children > 0
						}
					);

				end

			end

			-- loop through each category in the parent backwards
			for i=#parentCategory, 1, -1 do

				-- add the sub categories
				addSubCategories(currentCategory.id, parentCategory[i]);

			end
			
		end
		
	end

end);

-- AchievementFrameCategories_DisplayButton
-- 
-- Displays the achievement category buttons
-- Extended to format the sub category buttons making them smaller
AchieveIt:SecureHook("AchievementFrameCategories_DisplayButton", function(button, element)

	-- only if the button has an element (some don't)
	if (element) then

		-- if the button is for an AchieveIt sub category
		if (AchieveIt.Categories:isCategory(element.id) and element.level > 1) then

			-- reduce the width
			button:SetWidth(button:GetWidth()-((element.level-1)*10));

			-- reduce the font size
			button.label:SetFontObject("GameFontHighlightSmall");

		end

	end

end);

-- AchievementFrameCategories_SelectButton
-- 
-- This function is called when a category button is clicked
-- We need to totally overwrite this function in order to be able to handle multiple nested categories
AchieveIt:RawHook("AchievementFrameCategories_SelectButton", function(button)

	if (type(button) ~= "table") then

		simulateClick(category.id);
		return;

	end

	-- debug
	AchieveIt:Printfd('"%s (ID: %s)" button clicked', button.name, button.categoryID);
	
	local id = button.element.id;

	----------------------------------------------
	-- Modified                                 --
	-- Blizzard_AchievementUI.lua lines 587-608 --
	----------------------------------------------

	if (achievementFunctions.selectedCategory ~= id) then

		AchieveIt:Printd("Selected category was", achievementFunctions.selectedCategory, "but is now", id);

		categoryChange = true;

	else

		button.isSelected = true;

	end
		
	-- get button parent chain
	local parentChain = getParentChain(id);
	
	-- if button has no parent or it has children
	if ( type(button.element.parent) ~= "number" or button.element.hasChildren ) then

		-- button is selected and not collapsed
		-- we want to collapse it
		if ( button.isSelected and button.element.collapsed == false) then

			-- set collapsed
			button.element.collapsed = true;

			-- loop through each category
			for i, category in next, ACHIEVEMENTUI_CATEGORIES do

				-- if category parent is button category
				if ( category.parent == id ) then

					-- hide it
					category.hidden = true;

				end

			end

		-- button is either not selected or collapsed
		-- we want to expand it
		else

			categoryChange = true;

			-- loop through each category
			for i, category in next, ACHIEVEMENTUI_CATEGORIES do
				
				-- if category parent is button category
				-- or category is in the parent chain
				if ( category.parent == id or parentChain[category.id] ) then
					
					-- show it
					category.hidden = false;

				-- else if category is a parent
				elseif ( category.parent == true ) then

					-- collapse it
					category.collapsed = true;

				-- else if category has a parent
				elseif ( category.parent ) then

					-- hide it
					category.hidden = true;

				end

			end

			-- un-collapse button
			button.element.collapsed = false;

		end

	end

	------------------
	-- End Modified --
	------------------
	
	local buttons = AchievementFrameCategoriesContainer.buttons;
	for _, button in next, buttons do
		button.isSelected = nil;
	end
	
	button.isSelected = true;
	
	if ( id == achievementFunctions.selectedCategory ) then
		AchieveIt:Printd("No category change");
		-- If this category was selected already, bail after changing collapsed states
		return
	end
	
	--Intercept "summary" category
	if ( id == "summary" ) then
		if ( achievementFunctions == ACHIEVEMENT_FUNCTIONS or achievementFunctions == GUILD_ACHIEVEMENT_FUNCTIONS ) then
			AchievementFrame_ShowSubFrame(AchievementFrameSummary);
			achievementFunctions.selectedCategory = id;
			return;
		elseif (  achievementFunctions == STAT_FUNCTIONS ) then
			AchievementFrame_ShowSubFrame(AchievementFrameStats);
			achievementFunctions.selectedCategory = ACHIEVEMENT_COMPARISON_STATS_SUMMARY_ID;
			AchievementFrameStatsContainerScrollBar:SetValue(0);
		elseif ( achievementFunctions == COMPARISON_ACHIEVEMENT_FUNCTIONS ) then
			-- Put the summary stuff for comparison here, Derek!
			AchievementFrame_ShowSubFrame(AchievementFrameComparison, AchievementFrameComparisonContainer);
			achievementFunctions.selectedCategory = ACHIEVEMENT_COMPARISON_SUMMARY_ID;
			AchievementFrameComparisonContainerScrollBar:SetValue(0);
			AchievementFrameComparison_UpdateStatusBars(ACHIEVEMENT_COMPARISON_SUMMARY_ID);
		elseif ( achievementFunctions == COMPARISON_STAT_FUNCTIONS ) then
			AchievementFrame_ShowSubFrame(AchievementFrameComparison, AchievementFrameComparisonStatsContainer);
			achievementFunctions.selectedCategory = ACHIEVEMENT_COMPARISON_STATS_SUMMARY_ID;
			AchievementFrameComparisonStatsContainerScrollBar:SetValue(0);
		end
		
	else
		if ( achievementFunctions == STAT_FUNCTIONS ) then
			AchievementFrame_ShowSubFrame(AchievementFrameStats);
		elseif ( achievementFunctions == ACHIEVEMENT_FUNCTIONS or achievementFunctions == GUILD_ACHIEVEMENT_FUNCTIONS ) then
			AchievementFrame_ShowSubFrame(AchievementFrameAchievements);
			if ( id == FEAT_OF_STRENGTH_ID or id == GUILD_FEAT_OF_STRENGTH_ID ) then
				AchievementFrameFilterDropDown:Hide();
				AchievementFrameHeaderRightDDLInset:Hide();
			else
				AchievementFrameFilterDropDown:Show();
				AchievementFrameHeaderRightDDLInset:Show();
			end
		elseif ( achievementFunctions == COMPARISON_ACHIEVEMENT_FUNCTIONS ) then
			AchievementFrame_ShowSubFrame(AchievementFrameComparison, AchievementFrameComparisonContainer);
			AchievementFrameComparisonContainerScrollBar:SetValue(0);
			AchievementFrameComparison_UpdateStatusBars(id);
		else
			AchievementFrame_ShowSubFrame(AchievementFrameComparison, AchievementFrameComparisonStatsContainer);
			AchievementFrameComparisonStatsContainerScrollBar:SetValue(0);
		end
		achievementFunctions.selectedCategory = id;
	end
	
	if ( achievementFunctions.clearFunc ) then
		achievementFunctions.clearFunc();
	end
	AchievementFrameAchievementsContainerScrollBar:SetValue(0);
	achievementFunctions.updateFunc();

end, true);

-- AchievementFrameCategories_Update
-- 
-- This function is called from multiple places to update the category list
-- We pre-hook it and set all categories in the parent chain as not hidden so that closing and opening the achievements frame
-- will have all the correct categories visible
-- We also post-hook it so we can scroll the categories frame into the correct position so that the selected button is in view

local AchievementFrameCategories_Update_orig = AchievementFrameCategories_Update;

AchievementFrameCategories_Update = function()

	-- get the selected button parent chain
	local selectedParentChain = getParentChain(achievementFunctions.selectedCategory);

	-- loop through each category
	for i, category in next, ACHIEVEMENTUI_CATEGORIES do
		-- if category is in the parent chain
		if (selectedParentChain[category.id]) then
			-- set it as not hidden
			category.hidden = false;
		end
	end

	-- toggle the locate button
	locateButton:SetShown(AchievementFrame.selectedTab == 1);

	-- call original function
	local displayCategories = AchievementFrameCategories_Update_orig();
	
	-- if there has been a category change
	if (categoryChange) then

		-- scroll the selected category into view
		scrollCategoryInView(achievementFunctions.selectedCategory);

		categoryChange = false;

	end

	-- return original function results
	return displayCategories;

end;

-- AchievementFrame_GetCategoryTotalNumAchievements
-- @param {int} id			The category id
-- @param {boolean} showAll	Whether to include all sub categories (only applied to WoW categories)
--
-- Returns the total and completed number of achievements in the category
-- Overwritten so we can return values for addon categories
AchieveIt:RawHook("AchievementFrame_GetCategoryTotalNumAchievements", function(id, showAll)

	-- if category is an addon category
	if (AchieveIt.Categories:isCategory(id)) then

		-- find category
		local aiCategory;
		if (not inGuildView) then
			aiCategory = AchieveIt.Categories:findCategory(id);
		else
			aiCategory = AchieveIt.GuildCategories:findCategory(id);
		end

		-- return values
		return aiCategory:getNum(), aiCategory:getNumCompleted();

	-- not an addon category
	else

		-- call and return original function
		return AchieveIt.hooks["AchievementFrame_GetCategoryTotalNumAchievements"](id, showAll);

	end

end, true);



-- Make the achievement frame draggable
--------------------------------------------

-- This will make it do dragging all child Frames within the AchievementFrame will also drag it

-- The saved location point where the achievement frame was last moved to so we can show it again in the position
-- if closed and opened
local savedLocation;

-- dateFrame(frame)
-- Makes each frame and child frames move the AchievementFrame
local dragFrame;
dragFrame = function(frame)

	-- list of frames to exclude from the dragging process
	local excludedFrames = {
		"AchievementFrameSummary"
	};

	
	-- only Frames should be draggable
	if (
		(frame:GetObjectType() == "Frame" or frame:GetObjectType() == "ScrollFrame") and
		not AchieveIt:Contains(excludedFrames, frame:GetName())
	) then

		-- update flags
		frame:SetMovable(true);
		frame:EnableMouse(true);

		-- on mouse down we start moving the achievement frame
		frame:SetScript("OnMouseDown", function()
			AchievementFrame:StartMoving();
		end);

		-- on mouse up we store the location and stop moving it
		frame:SetScript("OnMouseUp", function()
			local point, relativeTo, relativePoint, x, y = AchievementFrame:GetPoint();
			savedLocation = {
				point = point,
				relativeTo = relativeTo,
				relativePoint = relativePoint,
				x = x,
				y = y
			};
			AchievementFrame:StopMovingOrSizing();
		end);

		-- loop through each child of the frame
		for _, child in ipairs({ frame:GetChildren() }) do
			-- also make them draggable
			dragFrame(child);
		end

	end

end
dragFrame(AchievementFrame);

AchievementFrame:HookScript("OnShow", function()

	-- Set the selected category to automatically show it when the achievement frame opens	
	--achievementFunctions.selectedCategory = -100;

	-- location was saved
	if (savedLocation) then
		-- place the achievement frame back where it was left
		AchievementFrame:ClearAllPoints();
		AchievementFrame:SetPoint(
			savedLocation.point,
			savedLocation.relativeTo and savedLocation.relativeTo:GetName() or "UIParent",
			savedLocation.relativePoint,
			savedLocation.x,
			savedLocation.y
		);
	end

end);

-- Add Locate Button
-- Button themes - AchievementCategoryTemplate / UIPanelButtonTemplate

-- Create locate button
locateButton = CreateFrame("Button", "AchieveIt_Locate_Button", AchievementFrameHeader, "AchievementCategoryTemplate");

-- set the button position
-- ElvUI moves the achievement points so we need to give it a different position if ElvUI is detected
if (ElvUI == nil) then
	locateButton:SetPoint("TOPLEFT", AchievementFrameHeader, "TOPLEFT", 108, -55);
else
	locateButton:SetPoint("TOPLEFT", AchievementFrameHeader, "TOPLEFT", 5, -33);
end

locateButton:SetWidth(130);
locateButton:SetHeight(24);
locateButton.label:SetText(L["Locate Category"]);

-- Add click handler
locateButton:SetScript("OnClick", function()

	-- debug
	AchieveIt:Printd("Locate button clicked");

	-- find the location category
	local category = AchieveIt.Categories:locate();

	-- if it was found
	if (false ~= category) then

		-- debug
		AchieveIt:Printfd("Category found: %s (ID: %d)", category.name, category.id);

		-- "click" the category button
		simulateClick(category.id);

	else

		-- tell user nothing was found
		AchieveIt:Print(L["No category found"]);

	end

end);

-- Show it
--locateButton:Show();


-- End ModifyAchievementFrame function
end