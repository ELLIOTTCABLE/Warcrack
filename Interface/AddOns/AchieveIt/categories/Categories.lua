local _, AchieveIt = ...;

-- Locale
local L = LibStub("AceLocale-3.0"):GetLocale("AchieveIt");

-- Globals
local tinsert, setmetatable, pairs = tinsert, setmetatable, pairs;
local UnitFactionGroup = UnitFactionGroup;

-- Each category is assigned a unique ID which can identify it
-- ID's are negative so they do not clash with WoW ID's and start at -10 because the comparison 
-- frames use -1 and -2 to idenitfy themselves
local categoryID = -10;

-- Flat array of all categories
-- Used for easy looping through each category
local flat = {};

-- Array of locate functions that don't have a custom category to attach themselves to
local locate = {};

-----------------------------------------------------------------------------
-- Category Class                                                          --
-- This class will represent each category we are adding sub categories to --
-----------------------------------------------------------------------------
local AchieveItCategory		= {};
AchieveItCategory.__index	= AchieveItCategory;

-- Creates a new instance of the AchieveItCategories class
-- @param {int} parentId	The ID of the parent category this category is being added to
-- @param {string} name		The name of the category
function AchieveItCategory:new(parentId, name, achievements, level)

	-- initialise
	local self = {};
	setmetatable(self, AchieveItCategory);

	-- if the category is a custom category
	if (parentId ~= false) then
		-- add it to the flat array
		tinsert(flat, self);
	end

	------------------------
	-- instance variables --
	------------------------

	-- The ID of the category we are adding sub categories to
	self.id				= self:generateId();

	-- The ID of the parent category we are adding this one to
	self.parentId		= parentId;

	-- The name of the category
	self.name			= name;

	-- The depth level of the category
	self.level			= level or 2;

	-- if there is no parent
	if (parentId == false) then

		-- reset level to 0 as it's a top level category
		self.level = 0;

	end

	-- Array of achievements in the category
	self.achievements	= self:processAchievements(achievements or {});

	-- The number of achievements in this category that have been completed
	self.numCompleted	= nil;

	-- Array of children in the category
	-- allowing multiple levels of categories
	self.children		= {};

	-- The function for determining if the location of the user relates to the category
	-- This is set directly in each category file
	self.locate			= nil;

	-- return instance
	return self;

end

-- Generates and returns a new sub category id
function AchieveItCategory:generateId()

	-- get category id
	local id = categoryID;

	-- set the next category id
	categoryID = categoryID - 1;

	-- return the category id
	return id;

end

-- Processes achievements for the category, filtering out any achievements the user can
-- not access (e.g. for other faction)
function AchieveItCategory:processAchievements(achievements)
	
	-- Achievements that will be returned
	-- This will only contain achievements the player can get (i.e. none for opposite faction)
	local achievementsToReturn = {};

	-- loop through each achievement
	for i=1, #achievements do

		-- get current achievement
		local achievement = achievements[i];

		if (achievement ~= nil) then

			-- if achievement is an id
			if (type(achievement) == "number") then

	 			-- then just add it
				tinsert(achievementsToReturn, achievement);

			-- otherwise check the achivement faction to make sure it's applicable to the user
			else
				
				-- if achievement is for player faction or is neutral
				if (achievement.faction == AchieveIt.FACTION or achievement.faction == AchieveIt.Factions.NEUTRAL) then

					-- add it to the return array
					tinsert(achievementsToReturn, achievement.id);

				end

			end

		end

	end

	-- return valid achievements
	return achievementsToReturn;

end

-- Adds a new child category
-- @param {string} name			The sub category to add
-- @param {table} achievements	Array of achievements to add to the sub category
function AchieveItCategory:addChild(name, achievements)

	-- create new sub category
	local subCategory = self:new(self.id, name, achievements, self.level+1);

	-- add it to the children array
	tinsert(self.children, subCategory);

	-- return it
	return subCategory;

end

-- Searches for a category
-- @param {int} id	The ID of the category to find
function AchieveItCategory:find(id)

	-- if searched id is own id
	if (id == self.id) then

		-- return self
		return self;

	else

		-- loop through each child
		for i=1, #self.children do

			-- search current category
			local category = self.children[i]:find(id);

			-- if category was found
			if (category ~= false) then

				-- return it
				return category;

			end

		end

	end

	-- return false for not found
	return false;

end


-- Returns the total number of achievements in this sub category
function AchieveItCategory:getNum()

	return #self.achievements;

end

-- Returns the number of completed achievements in this sub category
function AchieveItCategory:getNumCompleted()

	-- if numCompleted hasn't been set yet
	if (self.numCompleted == nil) then

		-- initialise it to 0
		self.numCompleted = 0;

		-- loop through each achievement
		for i=1, #self.achievements do

			-- get the completed state
			local _, _, _, completed = GetAchievementInfo(self.achievements[i]);

			-- if it was completed
			if (completed) then

				-- increment num completed
				self.numCompleted = self.numCompleted + 1;

			end

		end

	end

	return self.numCompleted;

end

-- Returns the number of incompleted achievements in this sub category
function AchieveItCategory:getNumIncompleted()

	return self:getNum() - self:getNumCompleted();

end

-- Adds all achievements from the category's children to it's own achievements
function AchieveItCategory:inheritAchievements()

	-- initialise added list
	-- used to make sure duplicated are not added
	local added = {};

	-- loop through each child
	for i=1, #self.children do

		-- get current child
		local child = self.children[i];

		-- loop through current childs achievements
		for j=1, #child.achievements do

			-- get current achievement
			local achievement = child.achievements[j];

			-- if it hasn't yet been added
			if (not added[achievement]) then

				-- add each achievement to the sub categories own
				tinsert(self.achievements, child.achievements[j]);

				-- add achievement to added list
				added[achievement] = true;

			end

		end

	end

end

-- Sorts the achievements in the category so that all completed ones are at the top
function AchieveItCategory:sort()

	-- initialise tables used in sorting
	local complete, incomplete, combined = {}, {};

	-- loop through each achievement in the category
	for i=1, #self.achievements do

		-- get achievement completed status
		local id, name, points, completed = GetAchievementInfo(self.achievements[i]);

		-- if it is completed
		if (completed) then

			-- add to the complete table
			tinsert(complete, self.achievements[i]);

		-- not completed
		else 

			-- add to the incomplete table
			tinsert(incomplete, self.achievements[i]);

		end

	end

	-- combine incomplete with complete so that all completed achievements are at the top
	for i=1, #incomplete do

		tinsert(complete, incomplete[i]);

	end

	-- overwrite achievements with the new sorted table
	self.achievements = complete;

end

--------------------------------------------------------------------------
-- Categories Class                                                     --
-- This class will store all categories we are adding sub categories to --
--------------------------------------------------------------------------

-- Initialise class
local AchieveItCategories	= {};
AchieveItCategories.__index	= AchieveItCategories;

-- Creates a new instance of the AchieveItCategories class
function AchieveItCategories:new()

	-- initialise
	local self = {};
	setmetatable(self, AchieveItCategories);

	------------------------
	-- instance variables --
	------------------------

	-- Array of top level categories we are adding sub categories to
	self.parentCategories = {};

	self.flat = flat;

	-- return instance
	return self;

end

-- Adds a new category to the categories array, if it doesn't already exist
-- @param {int} id	The ID of the new category
-- @return AchieveItCategory
function AchieveItCategories:addCategory(parentId, name, achievements, level)

	-- create new category
	local category = AchieveItCategory:new(parentId, name, achievements, level);

	-- if categories list doesn't yet have an entry for the parent
	if (not self.parentCategories[parentId]) then

		-- create it
		self.parentCategories[parentId] = {};

	end

	-- if there is no parent
	if (false == parentId) then

		-- add the current category as it's own category
		self.parentCategories[false][category.id] = category;

	-- there is a parent
	else

		-- add the category to the parent category list
		tinsert(self.parentCategories[parentId], category);

	end

	-- return new category
	return category;

end

-- Searches and returns a category
-- @param {int} id	The ID of the category to find
function AchieveItCategories:findCategory(id)

	-- loop through each parent category	
	for parentId, categories in pairs(self.parentCategories) do

		-- if parent is a top level categpry
		if (parentId == false) then

			-- loop through each category
			for k,v in pairs(categories) do

				-- search for current category
				local category = v:find(id);

				-- if found
				if (category ~= false) then

					-- return it
					return category;

				end

			end

		-- parent is not top level
		else

			-- loop through each category in the parent
			for i=1, #categories do

				-- search current category
				local category = categories[i]:find(id);

				-- if category was found
				if (category ~= false) then

					-- return it
					return category;

				end

			end

		end

	end

	-- return false if not found
	return false;

end

-- Searches through each 
function AchieveItCategories:findParent(parentId)

	-- if parent is an addon category
	if (self:isCategory(parentId)) then

		-- if it exists as a top level category
		if (self.parentCategories[false] and self.parentCategories[false][parentId]) then

			-- return it
			return self.parentCategories[false][parentId];

		end

	-- parent is a WoW category
	else

		-- if parent exists
		if (self.parentCategories[parentId]) then

			-- return it
			return self.parentCategories[parentId];

		end

	end

	-- return false if not found
	return false;

end

-- Returns whether the passed id is an AchieveIt Category
-- @param {int} id	The ID of the category to check
-- @return boolean
function AchieveItCategories:isCategory(id)

	-- addon categories are numbers -10 or lower
	return type(id) == "number" and id <= -10;

end

function AchieveItCategories:addLocate(fn)

	tinsert(locate, fn);

end

-- Returns the category relating to the users current location
function AchieveItCategories:locate()

	-- loop through each custom locate function
	for i=1, #locate do

		category = locate[i]();

		if (category ~= false) then

			return category;

		end


	end

	-- loop through each category backwards so children always get priority as they are always more specialised
	for i=#self.flat, 1, -1 do

		-- get current category
		local category = self.flat[i];

		-- if the category has a location function and it returns true
		if (type(category.locate) == "function" and category.locate()) then

			-- we have found the category so return category id
			return category;

		end

	end

	-- nothing found so return false
	return false;

end

-- Create a new instance of the Categories class and add it to the AchieveIt object
AchieveIt.Categories = AchieveItCategories:new();
AchieveIt.GuildCategories = AchieveItCategories:new();