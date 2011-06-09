local modName = "MissingFriends";
local core = CreateFrame("Frame");
local list, oldFriends;
local SOUND_WARNING = "Sound\\Interface\\AlarmClockWarning2.wav";

-- This makes the addon ignore the first "FRIENDLIST_UPDATE" event
core.firstUpdate = 1;

-- Global Chat Message Function
function AzMsg(msg) DEFAULT_CHAT_FRAME:AddMessage(tostring(msg):gsub("|1","|cffffff80"):gsub("|2","|cffffffff"),0.5,0.75,1.0); end

--------------------------------------------------------------------------------------------------------
--                                             Addon Code                                             --
--------------------------------------------------------------------------------------------------------

-- IsFriend - Returns true if the name is on the server friendlist
local function IsFriendMissing(name)
	for i = 1, GetNumFriends() do
		if (name == GetFriendInfo(i)) then
			return false;
		end
	end
	return true;
end

-- CompareFriendLists - Compare saved friendlist, with the server friendlist
local function CompareFriendLists()
	-- traverse backwards, so we can delete an entry, without messing up the loop
	for i = #list, 1, -1 do
		local friend = list[i];
		if (IsFriendMissing(friend)) then
			AzMsg("|2"..modName..":|r Friend |1"..friend.."|r no longer exists.");
			PlaySoundFile(SOUND_WARNING);
			oldFriends[friend] = time();
			tremove(list,i);
		end
	end
end

-- Friend list is not loaded here -- 2010.05.04: This event was changed from VARIABLES_LOADED
function core:ADDON_LOADED(event,addon)
	if (addon ~= modName) then
		return;
	end
	if (not MissingFriends_List) then
		MissingFriends_List = {};
	end
	if (not MissingFriends_OldFriends) then
		MissingFriends_OldFriends = {};
	end
	list = MissingFriends_List;
	oldFriends = MissingFriends_OldFriends;
	self:UnregisterEvent(event);
	self[event] = nil;
end

-- Update cached friend list -- Friend list is valid after the first "FRIENDLIST_UPDATE", and it will have been updated if a friend is removed
function core:FRIENDLIST_UPDATE(event)
	if (self.firstUpdate) and (#list ~= 0) then
		self.firstUpdate = nil;
	else
		wipe(list);
		for i = 1, GetNumFriends() do
			local name = GetFriendInfo(i);
			if (name and name ~= "") then
				list[#list + 1] = name;
			end
		end
	end
end

-- The "ERR_FRIEND_DELETED" message only occur during login, it will not happen if a friend is deleted while you are online, at least I've not seen this happen
function core:CHAT_MSG_SYSTEM(event,msg)
	if (msg == ERR_FRIEND_DELETED) then
		CompareFriendLists();
	end
end

core:SetScript("OnEvent",function(self,event,...) self[event](self,event,...); end);
core:RegisterEvent("ADDON_LOADED");
core:RegisterEvent("FRIENDLIST_UPDATE");
core:RegisterEvent("CHAT_MSG_SYSTEM");

--------------------------------------------------------------------------------------------------------
--                                            Slash Command                                           --
--------------------------------------------------------------------------------------------------------
_G["SLASH_"..modName.."1"] = "/mf";
SlashCmdList[modName] = function(cmd)
	AzMsg("----|2 Missing Friends |r----");
	for name, time in next, oldFriends do
		if (type(time) == "number") then
			AzMsg(date("%a, %b %d, %Y - %H:%M:%S",time)..": |1"..name);
		else
			AzMsg(time..": |1"..name);
		end
	end
end