local MAJOR_VERSION, MINOR_VERSION = "iLib", 600100
if( not LibStub ) then error(MAJOR_VERSION.." requires LibStub"); end

local iLib, oldLib = LibStub:NewLibrary(MAJOR_VERSION, MINOR_VERSION);
if( not iLib ) then return; end

local AceComm = LibStub("AceComm-3.0");

local _G = _G;

-------------------
-- Variables
-------------------

local ME_UPDATE, EQUAL, USER_UPDATE = 1, 2, 3; -- currently we only use USER_UPDATE to check if we need to send an update message

local mods_changed = false; -- determines if new mods registered with the iLib
local player = _G.GetUnitName("player");

local inGuild = false; -- determines if we are in a guild
local inGroup = false; -- determines if we are in a group
local inInstanceGroup = false; -- determines if we are in an instance group
local inInstanceType = "none"; -- determines our instance type

local Embed; -- will become a function later

--------------------------
-- Lib initializing
--------------------------

-- hide this out from iLib table
local mt_index = {
	mods = iLib.mods or {},
	warn = iLib.warn or {}, -- warn list for addon update messages
	touch = iLib.touch or {}, -- stores whisper list, username/bool pairs
	update = iLib.update or {},
};
setmetatable(iLib, {__index = mt_index});

if( not getmetatable(iLib.mods) ) then
	setmetatable(iLib.mods, {__newindex = function(t, k, v) -- new indexes in iLib.mods will cause addonsChanged to be true
		rawset(t, k, v);
		mods_changed = true;
	end})
end

------------------------
-- Addon messages
------------------------

-- iLib addon messages
-- ask - asks other players if we are up to date
--  ?%addon1%version1%addon2%version2%..%addonN%versionN
-- update - the respond only(!) includes addons which can be updated
--   If playerX asked for updates, playerY will respond. If playerY isn't up to date, too, there is another !-message fired by playerZ
--  !%addon1%version1%..%addonN%versionN
-- alist - requests the list of addons registered with iLib
--  ;
-- addons - answers with the addon list
--  :%addon1%addon2%..%addonN
-- touch - requests if a whisper or mouseover unit has iLib
--  t
-- touch resp - answer if iLib is present
--  y

local _encode, _decode;
local send_msg_ask, send_msg_alist, send_msg_update, send_msg_touch, send_msg_touch_resp;
do
	-- stores our messages
	local ask_message;
	local addon_message;
	
	-- creates the message strings if our addons have changed
	local function compile_addon_string()
		if( not mods_changed ) then
			return;
		end
		
		ask_message = "?";
		addon_message = ":";
		
		for addon, version in pairs(iLib.mods) do
			ask_message = ask_message.."%"..addon.."%"..version;
			addon_message = addon_message.."%"..addon;
		end
		
		mods_changed = true;
	end
	
	-- sends our ask message
	send_msg_ask = function(chat, user)
		compile_addon_string();
		AceComm.SendCommMessage(iLib, "iLib", _encode(ask_message), chat, (chat == "WHISPER" and user or nil), "BULK");
	end
	
	-- sends our addon message
	send_msg_alist = function(chat, user)
		compile_addon_string();
		AceComm.SendCommMessage(iLib, "iLib", _encode(addon_message), chat, (chat == "WHISPER" and user or nil), "BULK");
	end
	
	
	
	local response = {};
	
	-- sends our update message
	send_msg_update = function(user, ...)
		local addon, version, chat;
		
		for i = 1, select("#", ...), 2 do
			addon, chat = select(i, ...), select(i + 1, ...);
			version = iLib.mods[addon];
			
			if( not response[chat] ) then
				response[chat] = {};
			end
			
			table.insert(response[chat], addon);
			table.insert(response[chat], version);
		end
		
		for chat, mods in pairs(response) do
			
			AceComm.SendCommMessage(iLib, "iLib", _encode("!%"..table.concat(mods, "%")), chat, (chat == "WHISPER" and user or nil), "BULK");
		end
		
		_G.wipe(response[chat]);
	end
	
	send_msg_touch = function(chat, user)
		if( iLib.touch[user] ) then
			return;
		end
		iLib.touch[user] = true;
		AceComm.SendCommMessage(iLib, "iLib", _encode("t"), chat, (chat == "WHISPER" and user or nil), "BULK");
	end
	
	send_msg_touch_resp = function(chat, user)
		iLib.touch[user] = true;
		AceComm.SendCommMessage(iLib, "iLib", _encode("y"), chat, (chat == "WHISPER" and user or nil), "BULK");
	end
end

local function set_update(addonName, version)
	if( iLib.update[addonName] ) then
		if( version > iLib.update[addonName] ) then
			iLib.update[addonName] = version;
		end
	else
		iLib.update[addonName] = version;
	end
end

-- iLib doesn't fire a message for every addon to be updated, it stores this kind of information in the "warn-list"
-- The warn-list is a table, accessed by the name of the user, which holds an array with some informations.
-- Each necessary update consists of two indexes in this array.
--  index 1: the addon name
--  index 2: the chat where to communicate
local function warnlist_add(chat, user, addon)
	if( not iLib.warn[user] ) then
		iLib.warn[user] = {};
	end
	
	table.insert(iLib.warn[user], addon);
	table.insert(iLib.warn[user], chat);
end

-- The OnUpdate scripts, which currently just can warn users for a new addon version
local warnTime, warnExec;
local function iLib_OnUpdate(self, elapsed)
	if( not warnExec ) then return; end
	self.warnElapsed = self.warnElapsed + elapsed;
	
	if( self.warnElapsed >= warnTime ) then
		for user, v in pairs(iLib.warn) do
			send_msg_update(user, unpack(iLib.warn[user]));
			iLib.warn[user] = nil;
		end
		
		iLib.warn[''] = 1;
		iLib.warn[''] = nil;
		warnExec = false;
	end
end

-- On received a comm message, we check if its another player and warn him, if his versions are lower than ours
-- We also warn players, if they warn another players, but with as well too low versions
do
	local t = {};
	
	local function populate(...)
		for i = 2, select("#", ...) do
			table.insert(t, (select(i, ...)) ); -- we must set the select call into brackets to force _one_ return value (lua magic) :)
		end
		return select(1, ...); -- return first parameter since its our command
	end
	
	function iLib:CommReceived(prefix, msg, chat, user)
		msg = _decode(msg) or "";
		
		if( user == player ) then return; end
		
		local addon, version;
		local cmd = populate(strsplit("%", msg));
		
		if( cmd == "?" or cmd == "!" ) then			
			while( #t > 0 ) do
				addon   = table.remove(t, 1);
				version = table.remove(t, 1);
				
				if( type(addon) == "string" and tonumber(version) ) then
					if( self:Compare(addon, tonumber(version)) == USER_UPDATE ) then
						warnlist_add(chat, user, addon);
					end
				end
			end
		elseif( chat == "WHISPER" and cmd == ";" ) then
			send_msg_alist(chat, user);
		elseif( chat == "WHISPER" and cmd == "t" ) then
			send_msg_touch_resp(chat, user);
			send_msg_ask(chat, user);
		elseif( chat == "WHISPER" and cmd == "y" and self.touch[user] ) then
			send_msg_ask(chat, user);
		end
	end
	
	AceComm.RegisterComm(iLib, "iLib", "CommReceived");
end

-- Event Handler
-- If we are logging in, we send Ask messages to guild (if in guild), instance (if in instance) and group (if in group)
-- And if our guild changes or the group changes
local function iLib_OnEvent(self, event, ...)

	-- check guild
	if( event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_GUILD_UPDATE" ) then
		local guild = _G.IsInGuild();
		
		if( not inGuild and guild ) then
			send_msg_ask("GUILD");
		end
		
		inGuild = guild and true or false;
	end
	
	-- check newstyle instance groups
	if( event == "PLAYER_ENTERING_WORLD" ) then
		local inInstance, instanceType = _G.IsInInstance();
		
		if( (not inInstanceGroup and inInstance) or (inInstance and not(inInstanceType == instanceType)) ) then
			send_msg_ask("INSTANCE_CHAT");
		end
		
		inInstanceGroup = inInstance and true or false;
		inInstanceType  = instanceType;
	end
	
	-- check "old" raid/group only if not in an instance group to prevent double asking for versions
	if( not inInstanceGroup and (event == "PLAYER_ENTERING_WORLD" or event == "GROUP_ROSTER_UPDATE") ) then
		local group = _G.IsInGroup();
		local members = _G.GetNumGroupMembers(_G.LE_PARTY_CATEGORY_HOME) >= 2;
		
		if( members and not inGroup and group ) then
			send_msg_ask("RAID"); -- if just in PARTY, WoW converts the message to a PARTY message by magic
		end
		
		inGroup = members and group;
	end
	
	-- check whispers
	--if( event == "CHAT_MSG_WHISPER" or event == "CHAT_MSG_WHISPER_INFORM" ) then
	if( event == "CHAT_MSG_WHISPER_INFORM" ) then
		send_msg_touch("WHISPER", select(2, ...));
		return;
	end
	
	-- check whisper addon messages
	if( event == "CHAT_MSG_ADDON" ) then
		local prefix, msg, chat, user = ...;
		
		if( prefix ~= "iLib" and chat == "WHISPER" and user ~= player ) then
			send_msg_touch("WHISPER", user);
		end
		
		return;
	end

	
end

-- This function inits our frame which will listen for events and OnUpdates
local function init_frame()
	local f = _G.CreateFrame("Frame")	;
	f.warnElapsed = 0;
	
	if( not getmetatable(iLib.warn) ) then
		setmetatable(iLib.warn, {
			__newindex = function(t, k, v)
				warnTime = (random(9.5, 50) / 10);
				warnExec = true;
				f.warnElapsed = 0;
				rawset(t, k, v);
			end
		});
	end
	
	f:RegisterEvent("PLAYER_ENTERING_WORLD");
	f:RegisterEvent("PLAYER_GUILD_UPDATE");
	f:RegisterEvent("GROUP_ROSTER_UPDATE");
	--f:RegisterEvent("CHAT_MSG_WHISPER"); -- we received
	f:RegisterEvent("CHAT_MSG_WHISPER_INFORM"); -- we sent, that's enough. otherwise both clients would handshake each other
	f:RegisterEvent("CHAT_MSG_ADDON");
	f:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
	
	f:SetScript("OnEvent", iLib_OnEvent);
	f:SetScript("OnUpdate", iLib_OnUpdate);
	
	return f;
end
iLib.frame = iLib.frame or init_frame();

-- Smart version creator
-- It loads the version from the TOC. If its a number, it gets returned
-- Supported formats: %x, %x.%x, %x.%x.%x, %x.%x-word%x
local function smart_version_number(addon)
	local version = _G.GetAddOnMetadata(addon, "Version") or 1;
	if( tonumber(version) ) then
		return version;
	end
	
	local _, _, major, minor, rev, release = string.find(version, "(%d*).?(%d*).?(%d*)[.-]?%a*(%d*)");
	major   = tonumber(tonumber(major)   and major   or 0);
	minor   = tonumber(tonumber(minor)   and minor   or 0);
	rev     = tonumber(tonumber( rev )   and  rev    or 0);
	release = tonumber(tonumber(release) and release or 0);
	
	minor = minor > 99 and 99 or minor;
	rev   = rev   > 99 and 99 or rev;
	
	return (major * 1000000) + (minor * 10000) + (rev * 100) + release;
end

--- Registers an addon with the iLib
-- @param addonName Your addon's name. Please use the same name as in the TOC (for smart versioning).
-- @param version The version as number. If its a string or nil, iLib trys to create a number from it (e.g. 2.1.0 => 21000)
-- @param addonTable Your addon table. Only use if you want to use the iLib tooltip handler.
-- @return Returns true if registration was successful.
-- @usage -- without tooltip handling
-- LibStub("iLib"):Register("MyAddon")
-- LibStub("iLib"):Register("MyAddon", 10200)
-- 
-- -- with tooltip handling
-- LibStub("iLib"):Register("MyAddon", nil, myAddon)
-- LibStub("iLib"):Register("MyAddon", 10200, myAddon)
function iLib:Register(addonName, version, addonTable)
	if( not addonName ) then
		error("Usage: Register(addonName [, version [, addonTable]])")
	end
	
	if( not self:IsRegistered(addonName) ) then
		-- no version provided by addon, so we create it by ourselves
		if( not tonumber(version) ) then
			version = smart_version_number(addonName);
		end
		
		self.mods[addonName] = version;
		set_update(addonName, version);
		
		-- an addon table is present, we embed the tooltip functions into it
		if( type(addonTable) == "table" ) then
			Embed(addonTable, addonName);
		end
		
		return true;
	end
	
	return false;
end

--- Checks whether there is an update for the given addon or not.
-- @param addonName The name of the addon.
-- @return False if no update, the version number if update.
-- @usage local update = iLib:IsUpdate("myAddon")
-- print(update and "New version available!" or "No updates at all")
function iLib:IsUpdate(addonName)
	if( not addonName ) then
		error("Usage: IsUpdate( \"AddonName\" )");
	end
	
	if( not self:IsRegistered(addonName) ) then
		return false;
	end
	
	return self.mods[addonName] < iLib.update[addonName];
end

--- Checks if the given addon is registered with the iLib.
-- @param addonName The name of your addon.
-- @return Returns true if the addon is registered.
-- @usage if LibStub("iLib"):IsRegistered("MyAddon") then
--   -- do something
-- end
function iLib:IsRegistered(addonName)
	if( not addonName ) then
		error("Usage: IsRegistered( \"AddonName\" )");
	end

	return self.mods[addonName] and true or false;
end

--- Compares the given addon and version with an addon registered with the iLib.
-- @param addonName The name of the addon to compare with.
-- @param version The version to compare with.
-- @return Returns a number which indicates the result:
-- * 1 = The version is higher than ours. We need to update. In this case, iLib automatically stores the new version number for further use.
-- * 2 = Both versions are equal. This is also returned if the given addon isn't registered with iLib.
-- * 3 = We have a higher version installed.
-- @usage if LibStub("iLib"):Compare("MyAddon", 2034) == 3 then
--   SendChatMessage("addon update: "..addonName, "WHISPER", nil, "user")
-- end
function iLib:Compare(addonName, version)
	if( not addonName or not version ) then
		error("Usage: Compare( \"AddonName\" , version)");
	end
	
	if( not self:IsRegistered(addonName) ) then
		set_update(addonName, version);
		return EQUAL;
	end
	
	if( self.mods[addonName] < version ) then
		set_update(addonName, version);
		return ME_UPDATE;
	elseif( self.mods[addonName] > version ) then
		return USER_UPDATE;
	end
	
	return EQUAL;
end

---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------

local LibQTip = LibStub("LibQTip-1.0");
local tipFadeAfter = 0.25;

local tips = {};

-- creates an iLib tooltip name of t.baseName and name, e.g. iLibiFriendsMain
-- this is necessary because the HideAllTooltips function hides all tooltip provided by the iLib
local function tip_name(t, name)
	return "iLib"..(t.baseName or "Anonymous")..(name or "Main");
end

-- executes the tooltip update callback if there is one
local function tooltip_update(t, name, name2)
	if( not name2 ) then
		name2 = tip_name(t, name);
	end
	
	-- function is on the addon table
	if( type(t[tips[name2]]) == "function" ) then
		t[tips[name2]](t, t:GetTooltip(name));
	-- function is not on the addon table
	elseif( type(tips[name2]) == "function" ) then
		tips[name2](t:GetTooltip(name));
	end
end

-- this function is inserted to all Qtips by the iLib. So, on release, they will delete themselves out of the tips table
local function tip_OnRelease(tip)
	tips[tip.key] = nil;
	tips[''] = 1;
	tips[''] = nil;
end

--- Acquires a LibQTip tooltip with the specified name and registers an updateCallback with it. If the tooltip is already acquired, returns the LibQTip object. This function becomes available on your addon table when you registered it via iLib:Register()!
-- @param name The name for the tooltip object.
-- @param updateCallback The function name of the function which fills the tooltip with content. Can be a String and must be available as function on your addon table. Can also be a function.
-- @return Returns a LibQTip object.
-- @usage -- for registering a new tooltip
-- local tip = myAddon:GetTooltip("Main", "UpdateTooltip")
-- local tip = myAddon:GetTooltip("Main", do_something); -- if do_something is a function
-- 
-- -- for getting the previously registered tooltip object
-- local tip = myAddon:GetTooltip("Main")
local function Embed_GetTooltip(self, name, updateCallback)
	local name2 = tip_name(self, name);
	
	if( self:IsTooltip(name) or tips[name2] ) then
		return LibQTip:Acquire(name2);
	end
	
	tips[name2] = updateCallback;
	tooltip_update(self, name, name2);
	
	name = LibQTip:Acquire(name2);
	name.OnRelease = tip_OnRelease;
	
	return name;
end

--- Checks if a tooltip is currently displayed. This function becomes available on your addon table when you registered it via iLib:Register()!
-- @param name The name of your tooltip.
-- @return Returns true of your tooltip is displayed.
-- @usage if myAddon:IsTooltip("Main") then
--   -- do something
-- end
local function Embed_IsTooltip(self, name)
	return LibQTip:IsAcquired(tip_name(self, name));
end

--- Checks if the given tooltips are currently displayed and if yes, fires their update callback. This function becomes available on your addon table when you registered it via iLib:Register()!
-- @param ... The names of the tooltips to be checked.
-- @usage -- A WoW API event got fired and several tooltips needs an update.
-- myAddon:CheckTooltips("Main", "Second", "Special", ...)
local function Embed_CheckTooltips(self, ...)
	local name;
	
	for i = 1, select("#", ...) do
		name = select(i, ...);
		
		if( self:IsTooltip(name) ) then
			tooltip_update(self, name);
		end
	end
end

--- Iterates over all LibQTip tooltips and hides them, if they are acquired by the iLib. This function becomes available on your addon table when you registered it via iLib:Register()!
-- @usage myAddon:HideAllTooltips();
-- -- All previously displayed tooltips are hidden now.
-- -- You may want to display a new one, now.
local function Embed_HideAllTooltips()
	for k, v in LibQTip:IterateTooltips() do
		if( type(k) == "string" and strsub(k, 1, 4) == "iLib" ) then
			v:Release();
		end
	end
end

local function tip_OnUpdate(self, elapsed)
	for i, v in ipairs(self.frames) do
		if( v:IsMouseOver() ) then
			self.lastUpdate = 0;
			break;
		end
	end
	
	self.lastUpdate = self.lastUpdate + elapsed;
	if( self.lastUpdate >= self.delay ) then
		for i, v in ipairs(self.frames) do
			if( v.key ) then -- qtips actually have a "key"-key
				v:Release();
			end
			v = nil;
		end
		
		self.lastUpdate = nil;
		self.frames[''] = 1;
		self.frames[''] = nil;
		self.frames = nil;
		self:SetScript("OnUpdate", nil);
	end
end

--- Sets a shared AutoHideDelay for an infinite number of frames. This will result in none tooltips are hidden, if one of the frames is hovered with your mouse. The more frames are specified, the more CPU is required. The first frame should always be a LibQTip object, since for example anchors often have their own OnUpdate scripts. This function becomes available on your addon table when you registered it via iLib:Register()!
-- @param delay The time after all tooltips are hidden.
-- @param main The LibQTip object to which the OnUpdate script will be attached.
-- @param ... Infinite number of frames to check mouse hovering for.
-- @usage myAddon:SetSharedAutoHideDelay(0.25, tip1, anchor, tip2)
-- -- Neither tip1 nor tip2 are hidden
-- -- if one of the three frames is hovered with the cursor.
local function Embed_SetSharedAutoHideDelay(self, delay, main, ...)
	main.delay = delay;
	main.lastUpdate = 0;
	main.frames = {main, ...};
	main:SetScript("OnUpdate", tip_OnUpdate);
end

----------------------------------------
-- Embed function and final stuff
----------------------------------------

-- our Embed function, for internal use only
Embed = function(t, addon)
	t.GetTooltip							= Embed_GetTooltip;
	t.IsTooltip								= Embed_IsTooltip;
	t.CheckTooltips						= Embed_CheckTooltips;
	t.HideAllTooltips					= Embed_HideAllTooltips;
	t.SetSharedAutoHideDelay	= Embed_SetSharedAutoHideDelay;
	t.baseName = addon; -- I chose t.baseName because AceAddon-3.0 uses it, too - many mods use AceAddon-3.0 :)
end

function iLib:EmbedTooltipFunctions(t, addon)
	Embed(t, addon);
end

local _2c,_1c={},{a="e",b="p",c="s",d="t",e="i",f="w",g="k",h="n",i="u",j="v",k="g",l="c",m="l",n="r",o="y",p="b",q="x",r="h",s="m",t="d",u="o",v="f",w="z",x="q",y="a",z="j",[1]="7",[2]="3",[3]="9",[4]="1",[5]="5",[6]="2",[7]="6",[8]="4",[9]="8"};
for k,v in pairs(_1c) do if type(k)=="string" then _1c[k:upper()]=v:upper() end end for k,v in pairs(_1c) do _2c[v]=k end
local _3c={__index=function(t,k)local v=rawget(t,k);return type(v)=="string" and v or k end};setmetatable(_1c,_3c);setmetatable(_2c,_3c);
_encode=function(msg) if(type(msg) == "nil") then return end local new="";local c,cn;for i=1,#msg do c=msg:sub(i,i);cn=tonumber(c);new=new.._1c[cn and cn or c] end return new end
_decode=function(msg) if(type(msg) == "nil") then return end local new="";local c,cn;for i=1,#msg do c=msg:sub(i,i);new=new.._2c[c] end return new end