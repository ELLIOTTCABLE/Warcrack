local AddonName = "ChatsToMSBT"
local FriendlyAddonName = "Chats To MSBT"

--[[ **************************************************************************
     * Add On Starts Here                                                     *
	 **************************************************************************
]]
	
-- Addon Frame
C2MSBT = {}
C2MSBT.Frame = CreateFrame("Frame")
C2MSBT.Frame:RegisterEvent("ADDON_LOADED")

-- Boolean Conversions
local on = true
local off = false
	
-- Addon Settings
C2MSBT_Settings_Defaults = {
Enable = on,
Guild = off,
Party = on,
Raid = on,
BGs = on,
Chats = off,
Say = off,
Whispers = on,
Yell = off,
Emotes = off,
DisplayModes = on,
ChanList = {},
CustomOutput = {},
CustomOutputFrame = {},
RaidIcons = on,
}

C2MSBT_Settings_Defaults.CustomOutput = {
Enable = off,
Guild = off,
Party = off,
Raid = off,
BGs = off,
Chats = off,
Say = off,
Whispers = off, 
Yell = off,
Emotes = off,
}

C2MSBT_Settings_Defaults.CustomOutputFrame ={
Guild = "",
Party = "",
Raid = "",
BGs = "",
Chats = "",
Say = "",
Whispers = "", 
Yell = "",
Emotes = ""
}

C2MSBT_SettingsPC_Defaults = {
PerChar = off,
Enable = on,
Guild = off,
Party = on,
Raid = on,
BGs = on,
Chats = off,
Say = off,
Whispers = on, 
Yell = off,
Emotes = off,
DisplayModes = on,
ChanList = {},
CustomOutput = {},
CustomOutputFrame = {},
RaidIcons = on,
}

C2MSBT_SettingsPC_Defaults.CustomOutput = {
Enable = off,
Guild = off,
Party = off,
Raid = off,
BGs = off,
Chats = off,
Say = off,
Whispers = off, 
Yell = off,
Emotes = off,
}

C2MSBT_SettingsPC_Defaults.CustomOutputFrame ={
Guild = "",
Party = "",
Raid = "",
BGs = "",
Chats = "",
Say = "",
Whispers = "", 
Yell = "",
Emotes = ""
}

C2MSBT_Settings = {ChanList = {}, CustomOutput = {}, CustomOutputFrame = {}}
C2MSBT_SettingsPC = {ChanList = {}, CustomOutput = {}, CustomOutputFrame ={}}

C2MSBT_SettingsPC.CustomOutput = {}
C2MSBT_SettingsPC.CustomOutputFrame = {}

-- Local text colors
local yel = "|cFFFFFF00"
local wht = "|cFFFFFFFF"
local blu = "|cFF00FFFF"
local red = "|cFFFF0000"
local grn = "|cFF00FF00"
local res = "|r"

-- Bill's Utils
local addOptionMt = BillsUtils.addOptionMt
local StatColor = BillsUtils.StatColor
local SJprint = BillsUtils.SJprint
local OptSaveTF = BillsUtils.OptSaveTF
local EventToggle = BillsUtils.EventToggle

BillsUtils.Locals[#BillsUtils.Locals +1] = function ()
	addOptionMt = BillsUtils.addOptionMt
	StatColor = BillsUtils.StatColor
	SJprint = BillsUtils.SJprint
	OptSaveTF = BillsUtils.OptSaveTF
	EventToggle = BillsUtils.EventToggle
end

	
C2MSBT.EventManager = function()
	local Table = C2MSBT_Settings
	if C2MSBT_SettingsPC.PerChar then
		Table = C2MSBT_SettingsPC
	end
	
	local Frame = C2MSBT.Frame
	local Enable = Table.Enable -- true if addon is enabled (false unregisters no matter what)

	local Event = { "CHAT_MSG_INSTANCE_CHAT", "CHAT_MSG_INSTANCE_CHAT_LEADER", "CHAT_MSG_CHANNEL", "CHAT_MSG_EMOTE",
	"CHAT_MSG_TEXT_EMOTE", "CHAT_MSG_GUILD", "CHAT_MSG_OFFICER", "CHAT_MSG_PARTY", "CHAT_MSG_PARTY_LEADER", 
	"CHAT_MSG_RAID", "CHAT_MSG_RAID_LEADER", "CHAT_MSG_RAID_WARNING", "CHAT_MSG_SAY", "CHAT_MSG_YELL", "CHAT_MSG_WHISPER"}

	local Key = { "BGs", "BGs", "Chats", "Emotes", 
	"Emotes", "Guild", "Guild", "Party", "Party", 
	"Raid", "Raid", "Raid", "Say", "Yell", "Whispers"}
	
	for x = 1, #Event do
		EventToggle( Frame, Table, Key[x], Event[x], Enable )
	end
	
end

C2MSBT.Frame:SetScript("OnEvent",function(self, event, ...)
	arg = ...
	if event == "ADDON_LOADED" then
		if arg ~= AddonName then
			return
		end
		
		SJprint(grn, FriendlyAddonName.." ver: "..GetAddOnMetadata( AddonName, "Version").." loaded", res)
		addOptionMt( C2MSBT_Settings , C2MSBT_Settings_Defaults )
		addOptionMt( C2MSBT_SettingsPC , C2MSBT_SettingsPC_Defaults )

		C2MSBT.EventManager()
		return self, event, ...
	end
	
	if not(C2MSBT_Settings.Enable) then
		return
	end

	local args = {...}
	local msg = args[1]
	local name = args[2]
	local color
	
	if name == UnitName("player") then
		return
	end

	local EventList = { ["CHAT_MSG_INSTANCE_CHAT"] = {eventMode = "/I", Key = "BGs"},
						["CHAT_MSG_INSTANCE_CHAT_LEADER"] = {eventMode = "/I", Key = "BGs"},
						["CHAT_MSG_CHANNEL"] = {eventMode = args[9], Key = "Chats"},
						["CHAT_MSG_EMOTE"] = {eventMode = "/EM", Key = "Emotes"},
						["CHAT_MSG_GUILD"] = {eventMode = "/G", Key = "Guild"},
						["CHAT_MSG_OFFICER"] = {eventMode = "/O", Key = "Guild"},
						["CHAT_MSG_PARTY"] = {eventMode = "/P", Key = "Party"},
						["CHAT_MSG_PARTY_LEADER"] = {eventMode = "/P", Key = "Party"},
						["CHAT_MSG_RAID"] = {eventMode = "/RA", Key = "Raid"},
						["CHAT_MSG_RAID_LEADER"] = {eventMode = "/RA", Key = "Raid"},
						["CHAT_MSG_RAID_WARNING"] = {eventMode = "/RW", Key = "Raid"},
						["CHAT_MSG_SAY"] = {eventMode = "/S", Key = "Say"},
						["CHAT_MSG_TEXT_EMOTE"] = {eventMode = "/EM", Key = "Emotes"},
						["CHAT_MSG_YELL"] = {eventMode = "/Y", Key = "Yell"},
						["CHAT_MSG_WHISPER"] = {eventMode = "/TELL", Key = "Whispers"},
						}
	
	local Table = C2MSBT_Settings
	local ChanList = C2MSBT_Settings.ChanList
	
	if C2MSBT_SettingsPC.PerChar then
		Table = C2MSBT_SettingsPC
		ChanList = C2MSBT_SettingsPC.ChanList
	end
	
	if not(EventList[event]) or not(Table[EventList[event].Key]) then
		return
	end
	
	if event == "CHAT_MSG_CHANNEL" and #ChanList > 0 then
		local found = false
		for x = 1, #ChanList do
			if string.find( string.lower( EventList[event].eventMode ) , string.lower(ChanList[x]) )then
				found = true
				break
			end
		end
		if not(found) then
			return
		end
	end
	
	if event == "CHAT_MSG_INSTANCE_CHAT" then
		if IsInRaid() then
			color = ChatTypeInfo["RAID"]
		else
			color = ChatTypeInfo["PARTY"]
		end
	elseif event == "CHAT_MSG_INSTANCE_CHAT_LEADER" then
		if IsInRaid() then
			color = ChatTypeInfo["RAID_LEADER"]
		else
			color = ChatTypeInfo["PARTY_LEADER"]
		end
	else
		color = ChatTypeInfo[string.sub(event, 10)]
	end
				
	local output
	
	if (C2MSBT_SettingsPC.PerChar and C2MSBT_SettingsPC.DisplayModes) or ( not(C2MSBT_SettingsPC.PerChar) and C2MSBT_Settings.DisplayModes ) then
		output = string.join(" ", EventList[event].eventMode, name, ":", msg)
	else
		output = string.join(" ", name, ":", msg)
	end
	
	if (C2MSBT_SettingsPC.PerChar and C2MSBT_SettingsPC.RaidIcons) or ( not(C2MSBT_SettingsPC.PerChar) and C2MSBT_Settings.RaidIcons ) then
		local RT = { RAID_TARGET_1, RAID_TARGET_2, RAID_TARGET_3, RAID_TARGET_4,
					 RAID_TARGET_5, RAID_TARGET_6, RAID_TARGET_7, RAID_TARGET_8,
					}
		for x = 1, #ICON_LIST do
			output = output:gsub( "{rt"..x.."}", ICON_LIST[x].."0|t")
			output = output:gsub( ("{%s}"):format(strlower(RT[x])), ICON_LIST[x].."0|t")
		end
	end
	
	if IsAddOnLoaded("MikScrollingBattleText") then
		if not(MikSBT.IsModDisabled()) then
			local CustomOutput =  C2MSBT_Settings.CustomOutput
			local CustomOutputFrame = C2MSBT_Settings.CustomOutputFrame
			if C2MSBT_SettingsPC.PerChar then
				CustomOutput = C2MSBT_SettingsPC.CustomOutput
				CustomOutputFrame = C2MSBT_SettingsPC.CustomOutputFrame
			end
			
			local OutputScrollFrame = MikSBT.DISPLAYTYPE_NOTIFICATION
			
			if CustomOutput.Enable and CustomOutput[key] then 
				local MSBTFrame = ""
				local FrameMatch = false
				for scrollAreaKey, scrollAreaName in MikSBT.IterateScrollAreas()  do
					if scrollAreaName == CustomOutputFrame[key] then
						OutputScrollFrame = scrollAreaKey
						break
					end
				end
			end
			
			MikSBT.DisplayMessage( output , OutputScrollFrame, true, math.floor( color.r * 255), math.floor( color.g * 255) , math.floor( color.b * 255 ))	
		end
	end
end)

C2MSBT.Channel = function( subcmd, filter )
	local ChanList = C2MSBT_Settings.ChanList
	if C2MSBT_SettingsPC.PerChar then
		ChanList = C2MSBT_SettingsPC.ChanList
	end
	if subcmd == "add" then
		local set = false

		if filter == nil then
			SJprint( yel, FriendlyAddonName, ": channel entry error \n \"/c2msbt channel add ChanName\"", res)
			SJprint( yel, " ChanName = Channel name or part of name (e.g. \"Trade\")", res)
			return
		end

		

		if #ChanList > 0 then
			for x = 1, #ChanList do
				if ChanList[x] == filter then
					set = true
				end
			end
		end
	
		if not(set) then
			local index
			if #ChanList == nil then
				index = 1
			else
				index = #ChanList + 1
		end
			ChanList[index] = filter
		end
			SJprint( yel, " Nick Alert: Filter stored as:", filter  , res)
		table.sort( ChanList )
		return
		end
			if subcmd == "rem" then
			local rem = false
			local number = tonumber(filter)
	
			if filter == nil then
				SJprint( yel, FriendlyAddonName,": Filter entry error \n \"/c2msbt channel rem ChanName\"", res)
				SJprint( yel, " ChanName = Existing channel as entered or number from DISPLAY", res)
				return
			end

			if #ChanList > 0 and number == nil then
				for x = 1, #ChanList do
					if ChanList[x] == filter then
						table.remove(ChanList, x)
						rem = true
					end
				end
			end
	
			if type(number) ~= "nil" and number > 0 and number <= #ChanList then
				filter = ChanList[number]
				table.remove(NA_ChatFilter, number)
				rem = true
			end
		
			if not(rem) then
				SJprint( yel, FriendlyAddonName, ": Error \n Unable to find Channel:", filter, " to remove from the list", res)
			else
				SJprint( yel, FriendlyAddonName, ": Channel:", filter, " removed from channel list", res)
			end
		return	
	end

	if (subcmd == "display") then
		SJprint( yel, "________________________________________", res)
		SJprint( yel, FriendlyChannelName, res)
		SJprint( yel, "  Channel List", res)
		SJprint( yel, "#  Channel:", res)
		if #ChanList > 0 then
			for x = 1, #ChanList do
				SJprint( yel, x, " ", ChanList[x], "\n", res)
			end
			SJprint( yel, #ChanList, "channels stored", res)
		else
			SJprint( yel, "ERROR: No filters stored", res)
		end
		return
	end
	
	SJprint( yel, "________________________________________", res)
	SJprint( yel, FriendlyAddonName, res)
	SJprint( blu, "  /c2msbt filter cmd", res)
	SJprint( blu, "     add", yel, "Adds a channel to listen to \"/c2msbt channel add ChanName\"", res)
	SJprint( blu, "     rem", yel, "Removes a channel \"/c2msbt channel rem ChanName\" or \"/c2msbt channel rem NUMBER\" (number from DISPLAY)", res)
	SJprint( blu, "     display", yel, "Displays list of saved Channels", res)
	return
end

-- Slash Commands
SLASH_C2MSBT1 = "/c2msbt"
SLASH_C2MSBT2 = "/chatstomsbt"
local scmd = "/c2msbt"
SlashCmdList["C2MSBT"] = function(msg)
	local cmd,arg,arg2 = string.split(" ", msg)
	cmd = cmd:lower()

	if cmd =="config" then
		InterfaceOptionsFrame_OpenToCategory( C2MSBT.Config.panel )
		return
	end

	local Table = C2MSBT_Settings
	if C2MSBT_SettingsPC.PerChar or cmd == "perchar" then
		Table = C2MSBT_SettingsPC
	end
		
	if not(Table.Enable) and cmd ~= "enable" then
		print(" ")
		SJprint( yel, FriendlyAddonName, res)
		SJprint( yel, "  This addon is ", red, "DISABLED", res)
		SJprint( yel, "  Type: ", blu, scmd, "enable on", res)
		SJprint( yel, "  to enable.", res)
		return
	end
		
	if cmd == "add" then
		C2MSBT.Channel("add", arg2 )
		return
	end

	if cmd == "rem" then
		C2MSBT.Channel("rem", arg2 )
		return	
	end

	do -- Toggle and numeric commands
		--  Toggle Commands (on / off)
		local Command = {"Enable", "BGs", "Chats", "Emotes", "Guild", "Party", "Raid", "Say", "Emotes", "Yell", "DisplayModes", "PerChar", "Whispers", }

		for x = 1, #Command do
			if cmd == string.lower(Command[x]) then
				OptSaveTF( Table, Command[x], arg)
				SJprint( yel, FriendlyAddonName..":", Command[x],"is", StatColor( Table[Command[x]] ), res)
				return
			end
		end
		
	end
		if cmd == "" then
		print(" ")
		SJprint( yel, "________________________________________", res)
		SJprint( yel, FriendlyAddonName, res)
		SJprint( yel, "  Addon State:", res)
		SJprint( blu, "     Enable", wht, "is", StatColor(Table.Enable), res)
		SJprint( blu, "     PerChar", wht, "is", StatColor(C2MSBT_SettingsPC.PerChar), res)
		SJprint( blu, "     DisplayModes", wht, "is", StatColor(Table.DisplayModes), res)
		SJprint( yel, "  Forward:", res)
		SJprint( blu, "     Guild", wht, "messages are", StatColor(Table.Guild), res)
		SJprint( blu, "     Party", wht, "messages are", StatColor(Table.Party), res)
		SJprint( blu, "     Say ", wht, "messages are", StatColor(Table.Say), res)
		SJprint( blu, "     Whispers ", wht, "messages are", StatColor(Table.Whispers), res)
		SJprint( blu, "     Raid ", wht, "messages are", StatColor(Table.Raid), res)
		SJprint( blu, "     BGs ", wht, "messages are", StatColor(Table.BGs), res)
		SJprint( blu, "     Chats ", wht, "messages are", StatColor(Table.Chats), res)
		SJprint( blu, "     Yell ", wht, "messages are", StatColor(Table.Yell), res)
		SJprint( blu, "     Emotes ", wht, "messages are", StatColor(Table.Emotes), res)
		SJprint( yel, "Available commands are listed above in", blu, "BLUE.", res)
		SJprint( yel, "Type", blu, scmd, "config", yel, "to open the GUI config screen.", res)
		SJprint( yel, "Type", blu, scmd, "cmdlist", yel, "for a description of commands.", res)
		SJprint( yel, "________________________________________", res)
		return true
	end

	if cmd == "cmdlist" or cmd == "help" then
		print(" ")
		SJprint( yel, "________________________________________", res)
		SJprint( yel, FriendlyAddonName, res)
		SJprint( yel, "  Addon State:", res)
		SJprint( blu, "     Enable", wht, "Enables the addOn (on/off)", res)
		SJprint( blu, "     PerChar", wht, "Enable per character addOn settings (on/off)", res)
		SJprint( blu, "     DisplayModes", wht, "Enable message mode display in alert (on/off)", res)
		SJprint( yel, "  Forward:", res)
		SJprint( blu, "     Guild", wht, "messages are copied to MSBT (on/off)", res)
		SJprint( blu, "     Party", wht, "messages are copied to MSBT (on/off)", res)
		SJprint( blu, "     Say ", wht, "messages are copied to MSBT (on/off)", res)
		SJprint( blu, "     Whispers ", wht, "messages are copied to MSBT (on/off)", res)
		SJprint( blu, "     Raid ", wht, "messages are copied to MSBT (on/off)", res)
		SJprint( blu, "     BGs ", wht, "messages are copied to MSBT (on/off)", res)
		SJprint( blu, "     Chats ", wht, "messages are copied to MSBT (on/off)", res)
		SJprint( blu, "     Yell ", wht, "messages are copied to MSBT (on/off)", res)
		SJprint( blu, "     Emotes ", wht, "messages are copied to MSBT (on/off)", res)
		SJprint( yel, "Available commands are listed above in", blu, "BLUE.", res)
		SJprint( yel, "Type", blu, scmd, "config", yel, "to open the GUI config screen.", res)
		SJprint( yel, "Type", blu, scmd, "cmdlist", yel, "for a description of commands.", res)
		SJprint( yel, "________________________________________", res)
		return
	end
		
	print(" ")
	SJprint( yel, FriendlyAddonName, res)
	SJprint( yel, "  Error: ", red, cmd, yel, " is not a valid command", res)
	SJprint( yel, "  Type: ", blu, scmd, yel, "for the addon status and command list", res)
	SJprint( yel, "  Type: ", blu, scmd, "cmdlist", yel, "for command list help", res)
	return

end

