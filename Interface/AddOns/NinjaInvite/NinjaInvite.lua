-- 
-- NinjaInvite by Travistey updated by Timmid AKA Smokey
-- 
-- MMOwned
-- 

--Activate AceAddon stuff
local NinjaInvite = LibStub("AceAddon-3.0"):NewAddon("NinjaInvite", "AceTimer-3.0")

--Local # variables
local levelStart = 1
local levelEnd = 85
local levelProgress = 1
local levelIncrement = 5
local lstGathered = 0
local numWhos = 0
local declineCount, invitesSent = 0, 0
local lastClass, lastRace = 1, 1

--Local true/false variables
local searching, longSearch, uberLongSearch, isInviting, forceShort, showedUpdate = false, false, false, false, false, false

--Local table variable(s)
local Inviteable = { ['CHARNAME'] = {} }
local classes = { "Priest", "Warrior", "Warlock", "Druid", "Rogue", "Mage", "Hunter", "Paladin", "Shaman", "Death Knight" }
local racesA = { "Gnome", "Human", "Night Elf", "Draenei", "Dwarf", "Worgen" }
local racesH = { "Undead", "Orc", "Troll", "Blood Elf", "Tauren", "Goblin" }

--Local Frame Stuff
local frame, events = CreateFrame"Frame", {}
frame:SetScript("OnEvent", function(self, event, ...)
 events[event](self, ...); -- call one of the functions above
end);
local niVersion = GetAddOnMetadata("NinjaInvite", "Version")
local NIS = {}
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("CHAT_MSG_ADDON")

--Default Settings, if we don't have them saved this is what gets put in.
Ni_DefaultSettings = {
	["msg"] = "Hello. Would you like to join my guild? Send me a PM with Yes or No. If you say no you will not get this message again.",
	["msg2"] = "This is an optional message. Not included yet. Yet. Yet. Yet.",
	["msgPlayer"] = false,
	["verbose"] = true,
	["autostart"] = true,
	["msginvite"] = false,
	["instant"] = false,
	["levelStart"] = 1,
	["levelEnd"] = 85,
	}

--Easier chat function
local function NinjaMessage(text)

	if (Ni_Settings.verbose==true) then
	
	DEFAULT_CHAT_FRAME:AddMessage("|cFF00CCFFNinjaInvite: |cFFFFFFFF" .. text);
	
	end	
	
end

local function sendSync(prefix,msg)

local zoneType = select(2, IsInInstance())

	if zoneType == "pvp" or zoneType == "arena" then
		SendAddonMessage("NinjaInvite", prefix .. ": " .. msg, "BATTLEGROUND")
	end
	
	if GetRealNumRaidMembers() > 0 then
		SendAddonMessage("NinjaInvite", prefix .. ": " .. msg, "RAID")
	end
	
	if GetRealNumPartyMembers() > 0 then
		SendAddonMessage("NinjaInvite", prefix .. ": " .. msg, "PARTY")
	end
	
	if IsInGuild() then
		SendAddonMessage("NinjaInvite", prefix .. ": " .. msg, "GUILD")
	end

end

function events:CHAT_MSG_ADDON(prefix, msg, channel, sender)

--print("Prefix: " .. prefix,"|Msg: " .. msg,"|Channel: " .. channel,"|Sender: " .. sender)

if (prefix=="NinjaInvite") then

	if (string.find(msg,"V")) then
		
		--is this a beta version? probably me sending out messages in which case we will ignore :p
		if (string.find(msg,"Beta")) then
			showedUpdate = true
		end
		
		msg = string.gsub(msg,"V: ","")
		msg = string.gsub(msg," Release","")
		msg = string.gsub(msg," ","")
		
		local CurrentVersion = string.gsub(niVersion," Release","")
		CurrentVersion = string.gsub(CurrentVersion," Beta","")
		CurrentVersion = string.gsub(CurrentVersion," ","")
		
		if (msg > CurrentVersion and showedUpdate == false) then
			NinjaMessage("Your Ninja Invite Add-on is out of date.  Please visit MMOwned forums for the latest version.")
			showedUpdate = true
		end
		
	end

end

end

function events:PLAYER_ENTERING_WORLD()


if (IsAddonMessagePrefixRegistered("NinjaInvite")==false) then
	RegisterAddonMessagePrefix("NinjaInvite")
end

sendSync("V",niVersion)

end

--Load addon saved variables, use default settings if we don't have them already.
function events:ADDON_LOADED(arg1)

	if not ( Ni_Settings ) then
		Ni_Settings = { }
		Ni_Settings = Ni_DefaultSettings
		if (not Ni_Invited) then 
			Ni_Invited = { ["CHARNAME"] = {} }
		end
	NinjaMessage("First load, default settings loaded.")
	end

	if (not Ni_Invited) then 
		Ni_Invited = { ["CHARNAME"] = {} }
	end
	
	if (not Ni_Settings.msginvite) then 
		Ni_Settings.msginvite = false
	end
	
	if (not Ni_Settings.levelStart) then 
		Ni_Settings.levelStart = 1
		Ni_Settings.levelEnd = 85
	end
	
	if (not Ni_Settings.msg2) then 
		Ni_Settings.msg2 = "Hello. Would you like to join my guild? Send me a PM with Yes or No. If you say no you will not get this message again."
	end

	if (not Ni_Settings.msgPlayer) then 
		Ni_Settings.msgPlayer = false
	end

	if not ( Ni_Settings.autostart ) then

		Ni_Settings.autostart = true

	end

	if not ( Ni_Settings.verbose ) then

		Ni_Settings.verbose = true

	end
	
	if not ( Ni_Settings.instant ) then

		Ni_Settings.instant = false

	end
	
	NIS = Ni_Settings
	
	levelStart = Ni_Settings.levelStart
	levelEnd = Ni_Settings.levelEnd

end

--Whispered
function events:CHAT_MSG_WHISPER(msg, CharName)
		if (Ni_Settings.msginvite==true) then
		
			if (string.find(msg:lower(),"yes") or string.find(msg:lower(),"invite")) then
			
				GuildInvite(CharName)
	
				if (not Ni_Invited.CHARNAME) then 
					Ni_Invited.CHARNAME = { ["CHARNAME"] = {} }
					table.insert(Ni_Invited.CHARNAME,CharName)
				else
					table.insert(Ni_Invited.CHARNAME,CharName)
				end
			
			end
		
		end
end

--This is called after a who search is COMPLETED.
function events:WHO_LIST_UPDATE()

numWhos = GetNumWhoResults() or 0

for i=1, numWhos do
	
	name, guild, level, race, class, zone, group = GetWhoInfo(i);
	
	if (guild=="") then
		local AlreadyInvited = false
		local pattern = "[0-9\| :]";
	    if( string.find( name, pattern ) ~= nil ) then --this happens sometimes when in BG
			AlreadyInvited = true --so we'll exclude that name
		end
		for v in pairs(Inviteable.CHARNAME) do
				if (name:lower()==Inviteable.CHARNAME[v]:lower()) then
					AlreadyInvited = true
				end
		end
		for v in pairs(Ni_Invited.CHARNAME) do
			if (name:lower()==Ni_Invited.CHARNAME[v]:lower()) then
				AlreadyInvited = true
			end
		end
		if (level==1) then
			AlreadyInvited = true
		end
		if (AlreadyInvited==false) then
			table.insert(Inviteable.CHARNAME,name)
			if (Ni_Settings.instant == true) then
				isInviting = true
				NinjaInvite:GInvite(name)
			end
			lstGathered = lstGathered or 0
			lstGathered = lstGathered + 1
		end
	end
	
end

if (forceShort == false) then
if (longSearch == true) then
		if (uberLongSearch == true) then
			lastRace = lastRace + 1;
			if (racesH[lastRace] == nil) then
				uberLongSearch = false;
				lastClass = lastClass + 1;
				if (classes[lastClass] == nil) then
					longSearch = false;
					levelStart = levelStart + levelIncrement;
				end
			end
		else
			if (numWhos >= 49) then
				lastRace = 1;
				uberLongSearch = true;
				return
			end
			lastClass = lastClass + 1;
			if (classes[lastClass] == nil) then
				longSearch = false;
				levelStart = levelStart + levelIncrement;
			end
		end
else
	if (numWhos >= 49) then

		lastClass = 1;
		longSearch = true;
		return
	else
		longSearch = false;
		levelStart = levelStart + levelIncrement;
	end
end
else
	levelStart = levelStart + levelIncrement;
end

if (levelStart>=levelEnd) then

	StopSearch()

end

end


--The timer uses this function to send a WHO to server.
function NinjaInvite:SendSearch()

if (searching==false) then return end

SetWhoToUI(1)
local whoString

whoString = "g-\"\" " .. levelStart .. "-" .. levelStart + levelIncrement - 1;
	if (longSearch == true) then
		whoString = whoString .. " c-\"" .. classes[lastClass] .. "\"";
	end
	if (uberLongSearch == true) then
		whoString = whoString .. " r-\"";
		if (UnitFactionGroup("player") == "Horde") then
			whoString = whoString .. racesH[lastRace];
		else
			whoString = whoString .. racesA[lastRace];
		end
		whoString = whoString ..  "\""; 
	end

if (searching==true) then
if (Ni_Settings.instant == true) then
	NinjaMessage("who: " .. whoString .. " (" .. invitesSent .. " invited so far)")
else
	NinjaMessage("who: " .. whoString .. " (" .. tostring(table.getn(Inviteable.CHARNAME)) .. " able to be invited)")
end
lastSearchTime = time();
searching=true
SendWho(whoString)
end

end

--This function stops all searching, resets some variables.
function StopSearch()
	searching = false
	FriendsFrame:RegisterEvent("WHO_LIST_UPDATE");
	SetWhoToUI(0)
	if (Ni_Settings.instant == false) then
		NinjaMessage("Stopped datamining")
		print ("Gathered " .. table.getn(Inviteable.CHARNAME) .. " characters.")
	else
		NinjaMessage("NinjaInvite stopped.")
	end
	frame:UnregisterEvent"WHO_LIST_UPDATE"
	NinjaInvite:CancelTimer("SendSearch",true)
	PlaySoundFile("Interface\\AddOns\\NinjaInvite\\Sounds\\Complete.ogg")
	levelStart = Ni_Settings.levelStart
	lastClass = 1
	lastRace = 1
	longSearch = false
	uberLongSearch = false
	forceShort = false
	if (Ni_Settings.autostart == true and Ni_Settings.instant == false) then
		SlashCmdList.GINV("startinvite")
	end
		
end


--The /slash functions.
SLASH_GINVMSG1 = "/gmsg"
SlashCmdList["GINVMSG"] = function(args)
	if (args == "") then
	
		NinjaMessage("Usage: \"/gmsg MESSAGE TO SEND TO PLAYER\"")
	
	else
	
		Ni_Settings.msg = args
		NinjaMessage("Player message set to: " .. args)
	
	end
	
end

SLASH_GINV1 = "/ni"
SlashCmdList["GINV"] = function(args)
	if (args == "stop") then
		StopSearch()
	elseif (args=="msginvite") then
		if (Ni_Settings.msginvite==false) then
			Ni_Settings.msginvite = true
			Ni_Settings.instant = false
			if (Ni_Settings.msgPlayer == true) then
				Ni_Settings.msgPlayer = false
			end
			NinjaMessage("Player invite on whisper ENABLED.")
		else
			Ni_Settings.msginvite = false
			NinjaMessage("Player invite on whisper DISABLED.")
		end
	elseif (string.find(args,"startlvl")) then
		args = string.gsub(args,"startlvl ","")
		Ni_Settings.levelStart = tonumber(args)
		levelStart = tonumber(args)
		print("Ninja Invite will now search from levels " .. levelStart .. " to " .. levelEnd .. ".")
	elseif (string.find(args,"endlvl")) then
		args = string.gsub(args,"endlvl ","")
		Ni_Settings.levelEnd = tonumber(args)
		levelEnd = tonumber(args)
		print("Ninja Invite will now search from levels " .. levelStart .. " to " .. levelEnd .. ".")
	elseif (args=="print") then
		--for k,v in pairs(Inviteable.CHARNAME) do
		--	print(v)
		--end
		print (table.getn(Inviteable.CHARNAME),"names ready to be invited.")
		print (table.getn(Ni_Invited.CHARNAME),"names already invited.")
		print (declineCount,"people have declined invites last invite wave.")
	elseif (args == "clearplayers") then
		print ("Clearing invited player database:",table.getn(Ni_Invited.CHARNAME),"characters.")
		Ni_Invited.CHARNAME = { }
		NinjaMessage("Cleared the invited players database.")
	elseif (args == "startinvite") then
		if (searching==true) then
		NinjaMessage("Can't invite, gathering is in progress.")
		return
		end
		NinjaMessage("Starting invites.")
		isInviting = true
		silentDecline = true
		NinjaInvite:SendInvite()
	elseif (args == "stopinvite") then
		NinjaMessage("Stopping invites.")
		isInviting = false
	elseif (args == "autostart") then
		Ni_Settings.autostart = true
	elseif (args == "autostop") then
		Ni_Settings.autostart = false
	elseif (args == "instant") then
		if (Ni_Settings.instant == true) then
			Ni_Settings.instant = false
			NinjaMessage("Invite on character find disabled.")
		else
			NinjaMessage("Invite on character find enabled.")
			Ni_Settings.instant = true
			Ni_Settings.autostart = false
			Ni_Settings.msginvite = false
		end
	elseif (args == "msgplayer") then
		if (Ni_Settings.msgPlayer==false) then
			if (Ni_Settings.msginvite == true) then
				Ni_Settings.msginvite = false
			end
			Ni_Settings.msgPlayer = true
			NinjaMessage("Player invite message ENABLED.")
		else
			Ni_Settings.msgPlayer = false
			NinjaMessage("Player invite message DISABLED.")
		end
	elseif (args == "verbose") then
		if (Ni_Settings.verbose==false) then
			Ni_Settings.verbose = true
			NinjaMessage("Verbose mode ENABLED.")
		else
			NinjaMessage("Verbose mode DISABLED. You will not see any NinjaInvite Messages.")
			Ni_Settings.verbose = false
		end
	elseif (args == "gather" or args == "start") then
		if (not CanGuildInvite()) then
			NinjaMessage("You do not have permission to do that.")
			return
		end
		if (searching==true) then
			NinjaMessage("You are already searching.")
			return
		end
		NinjaMessage("Starting to gather character names...")
		FriendsFrame:UnregisterEvent("WHO_LIST_UPDATE")
		frame:RegisterEvent"WHO_LIST_UPDATE"
		levelProgress = levelStart
		lstGathered = 0
		searching = true
		finishedClass = true
		numWhos = 0
		declineCount = 0
		invitesSent = 0
		forceShort = false -- idk why this would be set, but just in case.
		NinjaInvite:CancelAllTimers()
		NinjaInvite:ScheduleRepeatingTimer("SendSearch", 7)
	elseif (args == "start short") then
		if (not CanGuildInvite()) then
			NinjaMessage("You do not have permission to do that.")
			return
		end
		if (searching==true) then
			NinjaMessage("You are already searching.")
			return
		end
		NinjaMessage("Starting a SHORT gather of character names...")
		FriendsFrame:UnregisterEvent("WHO_LIST_UPDATE")
		frame:RegisterEvent"WHO_LIST_UPDATE"
		levelProgress = levelStart
		lstGathered = 0
		searching = true
		finishedClass = true
		numWhos = 0
		forceShort = true
		declineCount = 0
		NinjaInvite:CancelAllTimers()
		NinjaInvite:ScheduleRepeatingTimer("SendSearch", 7)
	else
		NinjaMessage("Ninja Invite v" .. niVersion)
		NinjaMessage("/ni stop - Stops gathering names")
		NinjaMessage("/ni start - Starts gathering names to invite, this is in 5 second intervals.")
		NinjaMessage("/ni startinvite - Starts the inviting process")
		NinjaMessage("/ni stopinvite - Stops the inviting process.")
		NinjaMessage("/ni clearplayers - Clears the invited characters database")
		NinjaMessage("/ni msgplayer - Toggles Character Message on invite on/off")
		NinjaMessage("/ni msginvite - Toggles sending a character an invite when they send a tell with yes/invite")
		NinjaMessage("/ni verbose - Toggles display of addon messages, I recommend this stay on unless you want to avoid the who spam.")
		NinjaMessage("/gmsg MESSAGE - This is the message to send to a player when you invite them.")
	end
	
end


--This function sends out the guild invites.
function NinjaInvite:SendInvite()

if (table.getn(Inviteable.CHARNAME)==0 or isInviting==false) then
	NinjaMessage("Guild inviting stopped.")
	NinjaInvite:ScheduleTimer("DeclineSpam", 60)
	return 
end

local AlreadyInvited = false
local CharName = "ThisShouldntBeAName"

if (not Ni_Invited) then 
	Ni_Invited = { ["CHARNAME"] = {} }
end

for v in pairs(Ni_Invited.CHARNAME) do
	if (Inviteable.CHARNAME[1]:lower()==Ni_Invited.CHARNAME[v]:lower()) then
		AlreadyInvited = true
	end
end
			
if (AlreadyInvited==false and isInviting==true) then
			
	CharName = Inviteable.CHARNAME[1]
	--NinjaMessage("Sent Guild Invite")
	
	NinjaInvite:GInvite(CharName)
	
	NinjaInvite:ScheduleTimer("SendInvite", 0.3)
	
end

end

--decided to put this into a function to make this easier.
function NinjaInvite:GInvite(CharName)

if (not Ni_Invited.CHARNAME) then 
	Ni_Invited.CHARNAME = { ["CHARNAME"] = {} }
	table.insert(Ni_Invited.CHARNAME,CharName)
	table.remove(Inviteable.CHARNAME,1)
else
	table.insert(Ni_Invited.CHARNAME,CharName)
	table.remove(Inviteable.CHARNAME,1)
end
				
if (Ni_Settings.msginvite==true) then
	SendChatMessage(Ni_Settings.msg, "WHISPER", nil, CharName)
elseif (Ni_Settings.msgPlayer==true) then
	SendChatMessage(Ni_Settings.msg, "WHISPER", nil, CharName)
	GuildInvite(CharName)
else
	GuildInvite(CharName)
end

invitesSent = invitesSent + 1

end

--
--	This function prevents you from getting a ton of declined invite
--spam after it starts inviting people, it lasts for 60 seconds.
--
function NinjaInvite:DeclineSpam()

if (silentDecline==true) then

silentDecline = false
print (declineCount,"people have declined invites.")

end

end

--This is actually where it filters the spam.
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", function(_, _, msg)
	if (string.find(msg,"declines your guild invitation.") and silentDecline==true or string.find(msg,"declines your guild invitation.") and Ni_Settings.instant==true and searching==true) then
	declineCount = declineCount + 1
	return true
	end
	if (string.find(msg,"declining") and silentDecline==true or string.find(msg,"declining") and Ni_Settings.instant==true and searching==true) then
	declineCount = declineCount + 1
	return true
	end
	if (string.find(msg,"is already in a guild") and silentDecline==true or string.find(msg,"is already in a guild") and Ni_Settings.instant==true and searching==true) then
	return true
	end
	if (string.find(msg,"players total") and searching==true) then
	return true
	end
	if (string.find(msg,"to join your guild") and isInviting==true or string.find(msg,"to join your guild") and Ni_Settings.instant==true and searching==true) then
	return true
	end
	if (string.find(msg,"not found") and isInviting==true or string.find(msg,"not found") and Ni_Settings.instant==true and searching==true) then
	return true
	end
end)