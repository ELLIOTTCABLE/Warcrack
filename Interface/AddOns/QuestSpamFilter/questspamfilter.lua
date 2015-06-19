
--[[
	QuestSpam Filter
		By Myrilandell of Lothar
		
		Special thanks to:
			v6o for his addon MatronPatron
			Riokou - table emptying help
				RioUI - http://www.wowinterface.com/downloads/fileinfo.php?id=16982
			Aleiah - string matching help
				I was there in the beginning... and things were very different back then
]]



--------------------------------------------------------------------------------
--------------------------- GLOBAL VARIABLES ------------------------
--------------------------------------------------------------------------------

QSF_addon.version = GetAddOnMetadata("QuestSpamFilter", "Version"); -- automatically get QuestSpamFilter's version number

QuestSpamFilter_SVO = {
	["minTime"] = 1, -- the minimum time to allow for results to be collected.   NOTE: QuestSpamFilter_SVO["minTime"] seconds after QSF_addon.time, the tables will be printed and then emptied
	["addself"] = false, -- if true, adds yourself to the "Already On" table
	["singleLine"] = true, -- determines whether to start the consolidated list on the same line as its title, or on a new line
	["joinchar"] = " ", -- determines what to place between the table title and the list of names
	["colorize"] = false, -- determines whether to color the names of party members as QSF prints them
};

-- when the addon was last updated. 
	-- QuestSpamFilter_SVO["minTime"]  seconds after QSF_addon.time, the tables will be printed and then emptied
QSF_addon.time = 8;


-- these localized patterns match all the ways you can interact quest-wise with another player
QSF_addon.patterns = {};

-- the string fragments for the patterns
QSF_addon.patternFragments = {};

-- Adds"(" and "+)" around the "%s" in the pattern strings
	-- This is necessary because the basic WoW parser won't correctly switch out the default symbols with the player's name
function QSF_addon.addBetterStuff(in_string)
	local temp = string.gsub(in_string, "%%1$s", "(%%S+)");
	toReturn = string.gsub(temp, "%%s", "(%%S+)");
	
	return toReturn;
end

-- Adds"%" before the "."s in the input string
	-- This is necessary because the basic parser interprets "."s as wildcard characters, which is NOT desirable
function QSF_addon.sanitizePeriods(in_string)
	local toReturn = "";
	for i=1, in_string:len() do
		if (in_string:sub(i,i) == ".") then
			toReturn = toReturn .. "%.";
		else
			toReturn = toReturn .. in_string:sub(i,i);
		end
	end
	return toReturn;
end

-- Breaks the input string into two parts, one is to the left of the "%s" and the other is to the right of the "%s". Neither part includes the "%s"
function QSF_addon.makeFragments(in_string)
	local tbl = {
		[1] = "",
		[2] = "",
	};
	
	local value = "";
	local mod_string = QSF_addon.sanitizePeriods(in_string);
	for i=1, mod_string:len() do
		if (mod_string:sub(i,i+1) == "%s") then
			tbl[1] = value;
			tbl[2] = mod_string:sub(i+2);
			return tbl;
		elseif (mod_string:sub(i,i+3) == "%1$s") then -- happens in German for some strings - ex: "Questlog von %1$s ist voll."
			tbl[1] = value;
			tbl[2] = mod_string:sub(i+4);
			return tbl;
		else
			value = value .. mod_string:sub(i,i);
		end
	end
	
	tbl[1] = mod_string;
	return tbl;
end

-- these are the tables that the player names will be stuffed into, each will be put in the appropriate table
QSF_addon.completed = {};
QSF_addon.busy = {};
QSF_addon.noteligible = {};
QSF_addon.full = {};
QSF_addon.alreadyon = {};
QSF_addon.sharing = {};
QSF_addon.toofaraway = {};

-- players are added to this table whenever they are added to another table. This prevents adding them twice in one update
QSF_addon.addedtoatable = {};

-- this table links patterns to the appropriate table
QSF_addon.link = {
	[1] = QSF_addon.completed,
	[2] = QSF_addon.busy,
	[3] = QSF_addon.noteligible,
	[4] = QSF_addon.full,
	[5] = QSF_addon.alreadyon,
	[6] = QSF_addon.sharing,
	[7] = QSF_addon.toofaraway,
};

-- this table gives titles to each of the tables, for use in printing
QSF_addon.title = {
	["Completed"] = QSF_addon.completed,
	["Busy"] = QSF_addon.busy,
	["Not Eligible"] = QSF_addon.noteligible,
	["Questlog Full"] = QSF_addon.full,
	["Already On"] = QSF_addon.alreadyon,
	["Sharing ..."] = QSF_addon.sharing,
	["Too Far Away"] = QSF_addon.toofaraway,
};

-- this table gives class codes to each of the players in your group, for use in printing
QSF_addon.classes = {};

-- this table gives color codes to each of the classes, for use in printing
QSF_addon.colors = {
	["DEATHKNIGHT"] = "C41F3B",
	["DRUID"] = "FF7D0A",
	["HUNTER"] = "ABD473",
	["MAGE"] = "69CCF0",
	["PALADIN"] = "F58CBA",
	["PRIEST"] = "FFFFFF",
	["ROGUE"] = "FFF569",
	["SHAMAN"] = "2459FF",
	["WARLOCK"] = "9482C9",
	["WARRIOR"] = "C79C6E",
};



-- Populate the QSF_addon.patterns table with the formatted Global String
for index, globalString in ipairs (QSF_addon.globalPatterns) do
	QSF_addon.patterns[index] = QSF_addon.addBetterStuff(globalString);
	QSF_addon.patternFragments[index] = QSF_addon.makeFragments(globalString);
end



-- Prevents QSF from acting on false positives - such as the "player is busy" message gotten when trading
QSF_addon.falseTable = {};
QSF_addon.falseTable[1] = QSF_addon.addBetterStuff(_G["ERR_OBJECT_IS_BUSY"]);
QSF_addon.falseTable[2] = QSF_addon.addBetterStuff(_G["ERR_PLAYER_BUSY_S"]);
QSF_addon.falseTable[3] = QSF_addon.addBetterStuff(_G["ERR_TAXIPLAYERBUSY"]);
QSF_addon.falseTable[4] = QSF_addon.addBetterStuff(_G["ERR_TOOBUSYTOFOLLOW"]);
function QSF_addon.falsePositive(input)
	for k,v in ipairs (QSF_addon.falseTable) do
		if (input:find(QSF_addon.falseTable[k])) then return true; end
	end
	
	return false;
end





--------------------------------------------------------------------------------
-------------------------------- FUNCTIONS -----------------------------
--------------------------------------------------------------------------------

function QSF_addon.debug()
	for index,globalString in ipairs (QSF_addon.globalPatterns) do
		DEFAULT_CHAT_FRAME:AddMessage(" ");
		DEFAULT_CHAT_FRAME:AddMessage("global: " .. globalString);
		DEFAULT_CHAT_FRAME:AddMessage("modded: '" .. QSF_addon.patterns[index] .. "'");
		DEFAULT_CHAT_FRAME:AddMessage("fragments: '" .. QSF_addon.patternFragments[index][1] .. "'    and    '" .. QSF_addon.patternFragments[index][2] .. "'");
	end
end



-- Filters the Quest Spam, adds player names to the appropriate table, and turns on the frame's OnUpdate
function QSF_addon.QuestSpamFilter(self, event, msg)
	if (QSF_addon.falsePositive(msg)) then return false; end
	
	for i=1, #(QSF_addon.patterns) do
		if (msg:find(QSF_addon.patterns[i])) then
			local playerNameTemp, playerName = "", "";
			if (QSF_addon.patternFragments[i][1] ~= "") then
				playerNameTemp = string.gsub(msg, QSF_addon.patternFragments[i][1], "");
			else
				playerNameTemp = msg;
			end
			if (QSF_addon.patternFragments[i][2] ~= "") then
				playerName = string.gsub(playerNameTemp, QSF_addon.patternFragments[i][2], "");
			else
				playerName = playerNameTemp;
			end
			
			if (QSF_addon.addedtoatable[playerName] == nil) then
				QSF_addon.addedtoatable[playerName] = true;
				
				local tempTable = QSF_addon.link[i];
				tempTable[#(tempTable) + 1] = playerName;
				QSF_addon.time = GetTime();
				QSF_addon.frame:SetScript("OnUpdate", QSF_addon.summarize);
			end
			
			return true;
		end
	end
	
	return false;
end

-- Prints the contents of a table, separated by ", "
function QSF_addon.print(intable)
	local toReturn = " ";
	for k,name in pairs(intable) do
		if ((QuestSpamFilter_SVO["colorize"] == true) and (QSF_addon.classes[name] == nil)) then
			local _, class = UnitClass(name);
			QSF_addon.classes[name] = class;
		end
		
		if (QuestSpamFilter_SVO["colorize"] == true) then
			toReturn = toReturn .. "|cff" .. QSF_addon.colors[QSF_addon.classes[name]] .. name .. "|r, ";
		else
			toReturn = toReturn .. name .. ", ";
		end
	end
	
	return toReturn;
end

-- For every table that has values, prints that table's title and its values, then wipes the tables (to prevent repeated names)
function QSF_addon.summarize()
	if ((GetTime() - QSF_addon.time) > QuestSpamFilter_SVO["minTime"]) then
		QSF_addon.frame:SetScript("OnUpdate", nil);
		
		for title,tbl in pairs(QSF_addon.title) do
			if (#(tbl) > 0) then
				local titleTable = QSF_addon.titleName[title];
				DEFAULT_CHAT_FRAME:AddMessage(#(tbl) .. " " .. titleTable[QSF_addon.region] .. ":" .. QuestSpamFilter_SVO["joinchar"] .. QSF_addon.print(tbl), 1, 1, 0);
			end
		end
		
		-- wipe all the tables, to prevent repeated names
		for k, tbl in ipairs ( QSF_addon.link ) do wipe(tbl); end
		wipe(QSF_addon.addedtoatable);
		
		if (QuestSpamFilter_SVO["addself"] == true) then
			QSF_addon.alreadyon[1] = GetUnitName("player");
		end
	end
end




--------------------------------------------------------------------------------
---------------------------- FRAME VARIABLES ------------------------
--------------------------------------------------------------------------------

-- Create a frame so we can OnUpdate it
QSF_addon.frame = CreateFrame("Frame", "QuestSpamFilterFrame", UIParent);
QSF_addon.frame:SetScript("OnUpdate", QSF_addon.summarize);

-- Add the Quest Spam Filter to the Chat Frame's Message Event Filter
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", QSF_addon.QuestSpamFilter);
