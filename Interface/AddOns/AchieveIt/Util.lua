-----------------------
-- Utility functions --
-----------------------

local _, AchieveIt = ...;

-- Lua functions
local type, pairs, tostring, stringrep, next = type, pairs, tostring, string.rep, next;

-- Prints a message only if DEBUG mode is enabled
function AchieveIt:Printd(...)
	if (self.DEBUG) then
		self:Print("|cFFFF0000<debug>|CFFFFFFFF", ...);
	end
end

-- Prints a formatted message only if DEBUG mode is enabled
function AchieveIt:Printfd(...)
	if (self.DEBUG) then
		local params = {...};
		params[1] = "|cFFFF0000<debug>|CFFFFFFFF " .. params[1];
		self:Printf(unpack(params));
	end
end

-- Prints the key/value pairs in a table, only if DEBUG mode is enabled
-- @param {string} msg			An optional message to prepend
-- @param {table} table			The table to print
-- @param {boolean} recursive	Whether to recursively print tables within the table
-- @param {int} level			The current level of recursion
function AchieveIt:Printt(msg, table, recursive, level)

	-- Only in debug mode
	if (self.DEBUG) then

		-- if first argument is a table then there is no message
		if (type(msg) == 'table') then

			-- reassign variables
			msg, table, recursive, level = tostring(msg), msg, table, recursive;

		end

		-- set default values
		recursive = recursive or false;
		level = level or 1;

		-- print msg
		if (level == 1) then
			self:Printd(msg);
		end

		-- generate indent
		local indentSpaces	= "     ";
		local indent		= stringrep(indentSpaces, level);

		if (type(table) ~= "table") then
			
			self:Printd(indent, "|CFFAAAAAA", msg, "is not a table");

		else

			-- loop through table keys
			for key, value in pairs(table) do

				-- print the current key/value
				self:Printd(indent .. tostring(key) .. " = " .. tostring(value));

				-- if current value is a table and recursive print is on
				if (type(value) == "table" and recursive) then

					-- if table is empty
					if (self:TableIsEmpty(value)) then

						-- report it
						self:Printd(indent .. indentSpaces .. "|CFFAAAAAAempty table");

					-- table is not empty
					else

						-- print out the current table as well
						self:Printt(value, true, level+1)

					end

				end

			end

		end

	end

end

-- Returns whether a table is empty
-- @param {table} table		The table to test
function AchieveIt:TableIsEmpty(table)

	return next(table) == nil;

end

-- Returns whether a specific value is in a table
-- @param {table} table			The table to search
-- @param {mixed} valueToFind	The value to find within the table
function AchieveIt:Contains(table, valueToFind)

	for _, value in pairs(table) do

		if (value == valueToFind) then

			return true;

		end

	end

	return false;

end

-----------------------------------------------------------------------------------
-- Box Class                                                                     --
-- This class is used to determine if a player is in a certain region of the map --
-----------------------------------------------------------------------------------
local AchieveItBox		= {};
AchieveItBox.__index	= AchieveItBox;

-- Creates a new instance of the AchieveItBox class
function AchieveItBox:new()

	-- initialise
	local self = {};
	setmetatable(self, AchieveItBox);

	-- initialise the positions
	self.left	= 0;
	self.right	= 0;
	self.top	= 0;
	self.bottom	= 0;

	return self;

end

-- Updates the box positions
-- @param {Number} left		The left position
-- @param {Number} right	The right position
-- @param {Number} top		The top position
-- @param {Number} bottom	The bottom position
function AchieveItBox:update(left, right, top, bottom)

	-- update positions
	self.left	= left;
	self.right	= right;
	self.top	= top;
	self.bottom	= bottom;

end

-- Checks if an x/y position is inside the current box positions
-- @param {Number} x	The x coordinate (optional)
-- @param {Number} y	The y coordinate (optional)
function AchieveItBox:contains(x, y)

	-- if x or y are a number between 0 and 1 then multiple by 100 to get the "proper" coordinates
	if (x <= 1) then
		x = x * 100;
	end
	if (y <= 1) then
		y = y * 100;
	end

	-- test and return whether the player position is within the box
	return x >= self.left and
			x <= self.right and
			y >= self.top and
			y <= self.bottom;

end

-- Checks if the player is inside the box by using GetPlayerMapPosition("player")
function AchieveItBox:containsPlayer(left, right, top, bottom)

	-- if box coordinates are specificed
	if (left and right and top and bottom) then

		-- set them first
		self:update(left, right, top, bottom);

	end

	-- check the player position is within the box
	return self:contains(GetPlayerMapPosition("player"));

end

-- Set reference to the object from the AchieveIt global
-- Only ever need a single instance so we create a new instance here and can just update() it when we want to change positions
-- rather than creating a new instance each time we want a new box
AchieveIt.Box = AchieveItBox:new();

-- Convenience table for querying instance difficulty
--[[
	Uses http://www.wowpedia.org/API_GetInstanceInfo
	0 = None
	1 = 5 Player, Scenario
	2 = 5 Player (Heroic)
	3 = 10 Player
	4 = 25 Player
	5 = 10 Player (Heroic)
	6 = 25 Player (Heroic)
	7 = Raid Finder
	8 = Challenge Mode
	9 = 40 Player
	10 = nil
	11 = Heroic Scenario
	12 = Normal Scenario
	13 = nil
	14 = Flexible / WoD Normal
	15 = WoD Heroic
	16 = WoD Mythic
]]
AchieveIt.difficulty = {

	isDungeon = function()
		local _, _, difficulty = GetInstanceInfo();
		return difficulty == 1;
	end,

	isHeroicDungeon = function()
		local _, _, difficulty = GetInstanceInfo();
		return difficulty == 2;
	end,

	isNormalRaid = function()
		local _, _, difficulty = GetInstanceInfo();
		return difficulty == 3 or difficulty == 4 or difficulty == 14;
	end,

	isHeroicRaid = function()
		local _, _, difficulty = GetInstanceInfo();
		return difficulty == 5 or difficulty == 6 or difficulty == 15;
	end,

    isMythicRaid = function()
        local _, _, difficulty = GetInstanceInfo();
        return difficulty == 16;
    end,

	is10PlayerRaid = function()
		local _, _, difficulty = GetInstanceInfo();
		return difficulty == 3 or difficulty == 5;
	end,

	is10PlayerNormalRaid = function()
		local _, _, difficulty = GetInstanceInfo();
		return difficulty == 3;
	end,

	is10PlayerHeroicRaid = function()
		local _, _, difficulty = GetInstanceInfo();
		return difficulty == 5;
	end,

	is25PlayerRaid = function()
		local _, _, difficulty = GetInstanceInfo();
		return difficulty == 4 or difficulty == 6;
	end,

	is25PlayerNormalRaid = function()
		local _, _, difficulty = GetInstanceInfo();
		return difficulty == 4;
	end,

	is25PlayerHeroicRaid = function()
		local _, _, difficulty = GetInstanceInfo();
		return difficulty == 6;
	end,

	is40PlayerRaid = function()
		local _, _, difficulty = GetInstanceInfo();
		return difficulty == 9;
	end,

	isScenario = function()
		local _, _, difficulty = GetInstanceInfo();
		return difficulty == 1;
	end,

	isRaidFinder = function()
		local _, _, difficulty = GetInstanceInfo();
		return difficulty == 7;
	end,

	isChallengeMode = function()
		local _, _, difficulty = GetInstanceInfo();
		return difficulty == 8;
	end

};