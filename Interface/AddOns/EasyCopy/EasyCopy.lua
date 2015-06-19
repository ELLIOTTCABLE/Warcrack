ECVars = {};
ECRuntime = {
	splittedmsg = {""; ""; ""; ""; ""; ""; ""; ""; ""; ""; ""; ""; ""; ""; ""; ""; ""; ""; ""; ""};
	splitcnt = 0;
};

local EasyCopy_Original_ChatFrame_OnEvent;
local EasyCopy_Original_SetItemRef;

local iconList;
if (GetLocale() == "deDE") then
	iconList = {"stern", "kreis", "diamant", "dreieck", "mond", "quadrat", "kreuz", "totensch\195\164del"};
else
	iconList = {"star", "circle", "diamond", "triangle", "moon", "square", "cross", "skull"};
end

EasyCopy_Version = "5.0.1";

EasyCopy_RecentAFK = {};
EasyCopy_RecentAFK_Time = {};
EasyCopy_RecentDND = {};
EasyCopy_RecentDND_Time = {};
EasyCopy_Channels = {"Channel 1", "Channel 2", "Channel 3", "Channel 4", "Channel 5", "Channel 6", "Channel 7", "Channel 8", "Channel 9", "Channel 10"};
EasyCopy_ClassColors = {
	Deathknight = "C41F3B";
	Druid   = "ff7d0a";
	Hunter  = "abd473";
	Mage    = "69ccf0";
    Monk    = "00FF96";
	Paladin = "f58cba";
	Priest  = "ffffff";
	Rogue   = "fff569";
	Shaman  = "2459ff";
	Warlock = "9482c9";
	Warrior = "c79c6e";
}

function EasyCopy_OnLoad()
	if (not EasyCopy_Original_ChatFrame_OnEvent) then
		EasyCopy_Original_ChatFrame_OnEvent = ChatFrame_OnEvent;
	end
	ChatFrame_OnEvent = EasyCopy_ChatFrame_v3_OnEvent;
	
	if (not EasyCopy_Original_SetItemRef) then
		EasyCopy_Original_SetItemRef = SetItemRef;
	end
	SetItemRef = EasyCopy_SetItemRef;
	
	EasyCopyTitle:SetText("EasyCopy");
	
	if(ECVars.msgPrefix == nil) then
		ECVars.msgPrefix = "";
		DEFAULT_CHAT_FRAME:AddMessage("This is the first time you are running EasyCopy build "..EasyCopy_Version..". Type /ec to bring up the options frame.");
    else
        DEFAULT_CHAT_FRAME:AddMessage("[EC] EasyCopy Build "..EasyCopy_Version.."\n Thank you for using EasyCopy!\n");
	end
	
	if(ECVars.buttons == nil) then
		ECVars.buttons = 0;
	end
	EasyCopy_UpdateButtons();
	
	if(ECVars.mWheelScroll == nil) then
		ECVars.mWheelScroll = 1;
	end
	EasyCopy_MWheelOverlay_Update();
	
	if(ECVars.tabFlashing == nil) then
		ECVars.tabFlashing = 1;
	end
	
	if(ECVars.shortMSG == nil) then
		ECVars.shortMSG = 0;
	end
	
	if(ECVars.movableBox == nil) then
		ECVars.movableBox = 0;
		ECVars.boxLeft = -13;
		ECVars.boxTop = -37;
	end
	
	if(ECVars.movableBox == 1) then
		EasyCopy_MakeBoxesMovable();
	end
	
	if(ECVars.cLogCopying == nil) then
		ECVars.cLogCopying = 1;
	end
	
	if(ECVars.boxLeft ~= -13 or ECVars.boxTop ~= -37) then
		EasyCopy_PositionEditBoxes();
	end
	
	
	ChatFrameMenuButton:SetScript("OnShow", EasyCopy_UpdateButtons);
	FriendsMicroButton:SetScript("OnShow", EasyCopy_UpdateButtons);
	ChatFrame1ButtonFrame:SetScript("OnShow", EasyCopy_UpdateButtons);
	ChatFrame2ButtonFrame:SetScript("OnShow", EasyCopy_UpdateButtons);
	ChatFrame3ButtonFrame:SetScript("OnShow", EasyCopy_UpdateButtons);
	ChatFrame4ButtonFrame:SetScript("OnShow", EasyCopy_UpdateButtons);
	ChatFrame5ButtonFrame:SetScript("OnShow", EasyCopy_UpdateButtons);
	ChatFrame6ButtonFrame:SetScript("OnShow", EasyCopy_UpdateButtons);
	ChatFrame7ButtonFrame:SetScript("OnShow", EasyCopy_UpdateButtons);
	ChatFrame1:SetClampedToScreen(nil);
	ChatFrame2:SetClampedToScreen(nil);
	ChatFrame3:SetClampedToScreen(nil);
	ChatFrame4:SetClampedToScreen(nil);
	ChatFrame5:SetClampedToScreen(nil);
	ChatFrame6:SetClampedToScreen(nil);
	ChatFrame7:SetClampedToScreen(nil);
	
	hooksecurefunc("FCF_StartAlertFlash", function(chatFrame)
		if (ECVars.tabFlashing == 1) then
			FCF_StopAlertFlash(chatFrame);
		end
	end);
	
	SlashCmdList["EasyCopy"] = EasyCopyCMD;
	SLASH_EasyCopy1 = "/easycopy";
	SLASH_EasyCopy2 = "/ec";
	
	SlashCmdList["reloadui"] = function() ReloadUI(); end;
	SLASH_reloadui1 = "/rel";
	SLASH_reloadui2 = "/rl";
	
	--[[
	SlashCmdList["ecmytest"] = function() ECmytest(); end;
	SLASH_ecmytest1 = "/test";
	SLASH_ecmytest2 = "/text";
	--]]
	
	EasyCopy_core:RegisterForDrag("LeftButton");
	EasyCopyOptions_core:RegisterForDrag("LeftButton");
	
	-- DEFAULT_CHAT_FRAME:AddMessage("EasyCopy loaded");
	-- UIErrorsFrame:AddMessage("EasyCopy loaded", 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
end

function EasyCopy_AddToClassDB(uname, uclass)
	-- nothing here anymore
end

function EasyCopy_OnEvent(self, event, ...)
	if (event == "VARIABLES_LOADED") then
		EasyCopy_OnLoad();
	elseif (event == "PLAYER_ENTERING_WORLD") then
		EasyCopy_UpdateButtons();
	end
end

function EasyCopyCMD(msg)
	local args = "";
	cmd = strtrim(strlower(msg));
	if (strfind(cmd, " ") ~= nil) then
		args = strsub(cmd, strfind(cmd, " ") + 1);
		cmd = strsub(cmd, 0, strfind(cmd, " ") - 1);
	end
	
	if (cmd == "") then
		EasyCopyOptions_core:Show();
	elseif (cmd == "buttons") then
		if ((args == "" and ECVars.buttons == 0) or args == "off" or args == "1" or args == "hide") then
			ECVars.buttons = 1;
			EasyCopy_UpdateButtons();
			DEFAULT_CHAT_FRAME:AddMessage("EasyCopy - Scroll Buttons are now hidden");
		else
			ECVars.buttons = 0;
			EasyCopy_UpdateButtons();
			DEFAULT_CHAT_FRAME:AddMessage("EasyCopy - Scroll Buttons are now shown");
		end
	elseif (cmd == "mwheel") then
		if ((args == "" and ECVars.mWheelScroll == 0) or args == "on" or args == "1" or args == "enable") then
			ECVars.mWheelScroll = 1;
			DEFAULT_CHAT_FRAME:AddMessage("EasyCopy - Mouse wheel scrolling enabled");
		else
			ECVars.mWheelScroll = 0;
			DEFAULT_CHAT_FRAME:AddMessage("EasyCopy - Mouse wheel scrolling disabled");
		end
		EasyCopy_MWheelOverlay_Update();
	elseif (cmd == "flash") then
		if ((args == "" and ECVars.tabFlashing == 0) or args == "off" or args == "1" or args == "disable" or args == "hide") then
			ECVars.tabFlashing = 1;
			DEFAULT_CHAT_FRAME:AddMessage("EasyCopy - Tab-flashing disabled");
		else
			ECVars.tabFlashing = 0;
			DEFAULT_CHAT_FRAME:AddMessage("EasyCopy - Tab-flashing enabled");
		end
	elseif (cmd == "short") then
		if ((args == "" and ECVars.shortMSG == 0) or args == "on" or args == "1") then
			ECVars.shortMSG = 1;
			DEFAULT_CHAT_FRAME:AddMessage("EasyCopy - Displaying short messages");
		elseif (ECVars.shortMSG == 1) then
			ECVars.shortMSG = 0;
			DEFAULT_CHAT_FRAME:AddMessage("EasyCopy - Displaying original messages (long)");
		end
	elseif (cmd == "style") then
		ECVars.msgPrefix = tostring(args);
		if (args == "") then
			DEFAULT_CHAT_FRAME:AddMessage("EasyCopy - Message style: [13:37:00] [...");
		else
			DEFAULT_CHAT_FRAME:AddMessage("EasyCopy - Message style: "..ECVars.msgPrefix.." [...");
		end
	elseif (cmd == "flush") then
		ECVars.classDB = "";
		ECVars.classDB = {};
		DEFAULT_CHAT_FRAME:AddMessage("EasyCopy - The Lua garbage collector will take care of the class DB!");
	elseif (cmd == "memory" or cmd == "usage") then
		DEFAULT_CHAT_FRAME:AddMessage("EasyCopy uses "..(floor(GetAddOnMemoryUsage("EasyCopy") * 10) / 10).."kb memory.");
	end
end

function EasyCopy_UpdateButtons()
	if (ECVars.buttons == 1) then
		ChatFrameMenuButton:Hide();
		FriendsMicroButton:Hide();
		ChatFrame1ButtonFrame:Hide();
		ChatFrame2ButtonFrame:Hide();
		ChatFrame3ButtonFrame:Hide();
		ChatFrame4ButtonFrame:Hide();
		ChatFrame5ButtonFrame:Hide();
		ChatFrame6ButtonFrame:Hide();
		ChatFrame7ButtonFrame:Hide();
	else
		ChatFrameMenuButton:Show();
		FriendsMicroButton:Show();
		ChatFrame1ButtonFrame:Show();
		ChatFrame2ButtonFrame:Show();
		ChatFrame3ButtonFrame:Show();
		ChatFrame4ButtonFrame:Show();
		ChatFrame5ButtonFrame:Show();
		ChatFrame6ButtonFrame:Show();
		ChatFrame7ButtonFrame:Show();
	end
end

function EasyCopy_RemoveFlash()
	if (ECVars.tabFlashing == 1) then
		UIFrameFlashRemoveFrame(this);
		this:Hide();
	end
end

function EasyCopy_ChatFrame_v2_OnEvent(event)
	EasyCopy_Original_ChatFrame_OnEvent(event);
	if(not this.EasyCopy_Original_AddMessage) then
		this.EasyCopy_Original_AddMessage = this.AddMessage;
		this.AddMessage = EasyCopy_AddMessage;
	end
end

function EasyCopy_ChatFrame_v3_OnEvent(self, event, ...)
	EasyCopy_Original_ChatFrame_OnEvent(self, event, ...);
	if(not self.EasyCopy_Original_AddMessage) then
		self.EasyCopy_Original_AddMessage = self.AddMessage;
		self.AddMessage = EasyCopy_AddMessage;
	end
end

function EasyCopy_AddMessage(this, msg, r, g, b, id)
	if (strfind(msg, "%d:%d%d:%d%d>") ~= nil and strfind(msg, "%d:%d%d:%d%d>") < 3) then
		local newmsg = "";
		if (ECVars.cLogCopying == 0) then
			newmsg = "["..strsub(msg, 1, strfind(msg, ">")-1).."]"..strsub(msg, strfind(msg,">")+1);
		else
			newmsg = "|Hezc:"..EasyCopy_UnlinkMessage(msg).."|h["..strsub(msg, 1, strfind(msg, ">")-1).."]|h"..strsub(msg, strfind(msg,">")+1);
		end
		this:EasyCopy_Original_AddMessage(newmsg, r, g, b, id);
		return;
	elseif (strfind(msg, "%d:%d%d:%d%d%s") ~= nil and strfind(msg, "%d:%d%d:%d%d%s") < 3) then
		msg = strsub(msg, strfind(msg, "%s") + 1);
	end
	
	if (strfind(msg, "|Hchannel(.-)|h%[(%d)%.(.-)%]|h")) then
		local _, _, _, chnumber, chname = strfind(msg, "|Hchannel(.-)|h%[(%d)%.%s(.-)%]|h");
		EasyCopy_Channels[tonumber(chnumber)] = tostring(chnumber)..". "..tostring(chname);
	end
	
	
	--local ctime = date("*t");
	--local timestamp = "["..format("%02d:%02d:%02d", ctime["hour"], ctime["min"], ctime["sec"]).."]";
	if (ECVars.msgPrefix == "") then
		ECRuntime.timestamp = "["..date("%H:%M:%S").."] ";
	else
		ECRuntime.timestamp = ECVars.msgPrefix;
	end
	
	if (ECVars.shortMSG == 0) then
		this:EasyCopy_Original_AddMessage("|Hezc:"..EasyCopy_UnlinkMessage(msg).."|h"..ECRuntime.timestamp.."|h"..msg, r, g, b, id);
		return;
	end
	ECRuntime.tmsg = msg;
	ECRuntime.part = "";
	ECRuntime.done = False;
	ECRuntime.splitcnt = 0;
	ECRuntime.iterator = 0;
	for i = 1, strlen(ECRuntime.tmsg) do
		if (ECRuntime.tmsg == "") then break end
		if (strsub(ECRuntime.tmsg, 1, 2) == "|H") then
			ECRuntime.splitcnt = ECRuntime.splitcnt + 1;
			ECRuntime.splittedmsg[ECRuntime.splitcnt] = ECRuntime.part;
			ECRuntime.part = "|H";
			ECRuntime.tmsg = strsub(ECRuntime.tmsg, 3);
			ECRuntime.iterator = 0;
		elseif (strsub(ECRuntime.tmsg, 1, 2) == "|h") then
			if (strsub(ECRuntime.part, 1, 2) ~= "|H") then
				ECRuntime.iterator = -1;
				ECRuntime.part = ECRuntime.part.."||h";
				ECRuntime.tmsg = strsub(ECRuntime.tmsg, 3);
			else
				if (ECRuntime.iterator == 1) then
					ECRuntime.splitcnt = ECRuntime.splitcnt + 1;
					ECRuntime.splittedmsg[ECRuntime.splitcnt] = ECRuntime.part.."|h";
					ECRuntime.part = "";
					ECRuntime.tmsg = strsub(ECRuntime.tmsg, 3);
				else
					ECRuntime.part = ECRuntime.part.."|h";
					ECRuntime.tmsg = strsub(ECRuntime.tmsg, 3);
				end
				ECRuntime.iterator = ECRuntime.iterator + 1;
			end
		elseif (strsub(ECRuntime.tmsg, 1, 2) == ": ") then
			if (strsub(ECRuntime.part, 1, 2) ~= "|H") then
				ECRuntime.iterator = -1;
				ECRuntime.splitcnt = ECRuntime.splitcnt + 1;
				ECRuntime.splittedmsg[ECRuntime.splitcnt] = ECRuntime.part..": ";
				ECRuntime.part = "";
				ECRuntime.tmsg = strsub(ECRuntime.tmsg, 3);
			else
				ECRuntime.part = ECRuntime.part..strsub(ECRuntime.tmsg, 1, 1);
				ECRuntime.tmsg = strsub(ECRuntime.tmsg, 2);
			end
		elseif (strlower(strsub(ECRuntime.tmsg, 1, 7)) == "{heart}") then
			ECRuntime.part = ECRuntime.part.."|TInterface\\AddOns\\EasyCopy\\heart:0|t";
			ECRuntime.tmsg = strsub(ECRuntime.tmsg, 8);
		elseif (strlower(strsub(ECRuntime.tmsg, 1, 6)) == "{herz}") then
			ECRuntime.part = ECRuntime.part.."|TInterface\\AddOns\\EasyCopy\\heart:0|t";
			ECRuntime.tmsg = strsub(ECRuntime.tmsg, 7);
		else
			ECRuntime.part = ECRuntime.part..strsub(ECRuntime.tmsg, 1, 1);
			ECRuntime.tmsg = strsub(ECRuntime.tmsg, 2);
		end
	end
	if (ECRuntime.part ~= "") then
		ECRuntime.splitcnt = ECRuntime.splitcnt + 1;
		ECRuntime.splittedmsg[ECRuntime.splitcnt] = ECRuntime.part;
	end
	ECRuntime.dpoint = 0;
	for i = 1, ECRuntime.splitcnt do
		if (ECRuntime.dpoint == 0) then
			if (strtrim(ECRuntime.splittedmsg[i]) == "<Away>") then
				ECRuntime.splittedmsg[i] = gsub(ECRuntime.splittedmsg[i], "<Away>", "");
			elseif (strtrim(ECRuntime.splittedmsg[i]) == "<Busy>") then
				ECRuntime.splittedmsg[i] = gsub(ECRuntime.splittedmsg[i], "<Busy>", "");
			elseif (strsub(ECRuntime.splittedmsg[i], 1, 2) ~= "|H" and strfind(ECRuntime.splittedmsg[i], ":") ~= nil) then
				if (strfind(ECRuntime.splittedmsg[i], "%d:%d%d:%d%d") == nil) then
					ECRuntime.dpoint = i;
				end
			end
		end
		if (strsub(ECRuntime.splittedmsg[i], 1, 9) == "|Hchannel") then
			local _, _, friendlyname = strfind(ECRuntime.splittedmsg[i], "|h(.-)|h");
			ECRuntime.splittedmsg[i] = friendlyname;
			ECRuntime.splittedmsg[i] = gsub(ECRuntime.splittedmsg[i], "%[(.-)%]", function (tmatch)
				local ident = "";
				local origmatch = tmatch;
				if (strfind(tmatch, "(%d+)%. (.+)") ~= nil) then
					local _, _, chnum, chname = strfind(tmatch, "(%d)%. (.+)");
					ident = tostring(chnum);
					if (ECVars.shortMSG == 2) then
						tmatch = ident;
					else
						tmatch = chname;
					end
				elseif (tmatch == "Guild" or tmatch == "Gilde") then
					tmatch = "G";
				elseif (tmatch == "Officer" or tmatch == "Offizier") then
					tmatch = "O";
				elseif (tmatch == "Party" or tmatch == "Gruppe" or tmatch == "Party Leader" or tmatch == "Dungeon Guide") then
					tmatch = "P";
				elseif (tmatch == "Raid" or tmatch == "Schlachtzug" or tmatch == "Raid Leader" or tmatch == "Schlachtzugsleiter") then
					tmatch = "R";
				elseif (tmatch == "Raid Warning" or tmatch == "Schlachtzugswarnung") then
					tmatch = "RW";
				elseif (tmatch == "Battleground" or tmatch == "Schlachtfeld" or tmatch == "Battleground Leader" or tmatch == "Schlachtfeldleiter") then
					tmatch = "BG";
				else
					ident = "none";
				end
				if (ident == "") then
					if (tmatch == "RW") then
						ident = "w";
					else
						ident = strlower(strsub(tmatch, 1, 1));
					end
				end
				if (ident ~= "none") then
					if (ECVars.shortMSG == 3) then
						if (i < ECRuntime.splitcnt) then
							if (strsub(ECRuntime.splittedmsg[i + 1], 1, 1) == " ") then
								ECRuntime.splittedmsg[i + 1] = strsub(ECRuntime.splittedmsg[i + 1], 2);
							end
						end
						return "";
					end
					if ((ECRuntime.dpoint == 0) or ((ECRuntime.dpoint > 0) and (strfind(ECRuntime.splittedmsg[ECRuntime.dpoint], " Channel:") == nil))) then
						return "|Hezcc:"..ident.."|h["..tmatch.."]|h";
					else
						return "|Hezcc:"..ident.."|h["..origmatch.."]|h";
					end
				else
					return "["..tmatch.."]";
				end
			end);
		end
	end
	
	if (ECRuntime.dpoint > 1) then
		if (strsub(ECRuntime.splittedmsg[ECRuntime.dpoint - 1], 1, 8) == "|Hplayer" or strsub(ECRuntime.splittedmsg[ECRuntime.dpoint - 1], 1, 10) == "|HBNplayer") then
			local _, _, cplayer = strfind(ECRuntime.splittedmsg[ECRuntime.dpoint - 1], "|h(.-)|h");
			cplayer = strsub(cplayer, 2, -2);
			if (ECRuntime.splittedmsg[ECRuntime.dpoint] == " whispers: ") then
				ECRuntime.splittedmsg[ECRuntime.dpoint] = ": ";
			elseif (ECRuntime.splittedmsg[ECRuntime.dpoint] == " fl\195\188stert: ") then
				ECRuntime.splittedmsg[ECRuntime.dpoint] = ": ";
			elseif (ECRuntime.splittedmsg[ECRuntime.dpoint] == " is Away: " or ECRuntime.splittedmsg[ECRuntime.dpoint] == " ist nicht an der Tastatur: ") then
				local AFKmsg = "";
				for i = ECRuntime.dpoint + 1, ECRuntime.splitcnt do
					AFKmsg = AFKmsg..ECRuntime.splittedmsg[i];
				end
				if (EasyCopy_RecentAFK_Time[cplayer] == nil) then
					EasyCopy_RecentAFK[cplayer] = AFKmsg;
				else
					if ((time() - 90) < EasyCopy_RecentAFK_Time[cplayer]) then
						if (EasyCopy_RecentAFK[cplayer] == AFKmsg) then
							EasyCopy_RecentAFK_Time[cplayer] = time();
							return;
						else
							EasyCopy_RecentAFK[cplayer] = AFKmsg;
						end
					end
				end
				EasyCopy_RecentAFK_Time[cplayer] = time();
				ECRuntime.splittedmsg[ECRuntime.dpoint] = " AFK: ";
			elseif (ECRuntime.splittedmsg[ECRuntime.dpoint] == " does not wish to be disturbed: " or ECRuntime.splittedmsg[ECRuntime.dpoint] == " m\195\182chte nicht gest\195\182rt werden: ") then
				local DNDmsg = "";
				for i = ECRuntime.dpoint + 1, ECRuntime.splitcnt do
					DNDmsg = DNDmsg..ECRuntime.splittedmsg[i];
				end
				if (EasyCopy_RecentDND_Time[cplayer] == nil) then
					EasyCopy_RecentDND[cplayer] = DNDmsg;
				else
					if ((time() - 90) < EasyCopy_RecentDND_Time[cplayer]) then
						if (EasyCopy_RecentDND[cplayer] == DNDmsg) then
							EasyCopy_RecentDND_Time[cplayer] = time();
							return;
						else
							EasyCopy_RecentDND[cplayer] = DNDmsg;
						end
					end
				end
				EasyCopy_RecentDND_Time[cplayer] = time();
				ECRuntime.splittedmsg[ECRuntime.dpoint] = " DND: ";
			end
		end
	end
	if (ECRuntime.dpoint > 1 and (ECRuntime.splittedmsg[ECRuntime.dpoint] == " whispers: " or ECRuntime.splittedmsg[ECRuntime.dpoint] == " fl\195\188stert:")) then
		if (strsub(ECRuntime.splittedmsg[ECRuntime.dpoint - 1], 1, 8) == "|Hplayer") then
			ECRuntime.splittedmsg[ECRuntime.dpoint] = ": ";
		end
	end
	
	ECRuntime.newmsg = "";
	for i = 1, ECRuntime.splitcnt do
		ECRuntime.newmsg = ECRuntime.newmsg..ECRuntime.splittedmsg[i];
	end
	ECRuntime.newmsg = "|Hezc:"..EasyCopy_UnlinkMessage(ECRuntime.newmsg).."|h"..ECRuntime.timestamp.."|h"..ECRuntime.newmsg;
	-- this:EasyCopy_Original_AddMessage(gsub(ECRuntime.newmsg, "|", "|"), r, g, b, id);
	this:EasyCopy_Original_AddMessage(ECRuntime.newmsg, r, g, b, id);
end

function EasyCopy_UnlinkMessage(linkedmessage)
	local msg = "";
	local part = "";
	local mode = 0;
	if (GetLocale() == "deDE") then
		linkedmessage = gsub(linkedmessage, "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:0|t", "{stern}");
		linkedmessage = gsub(linkedmessage, "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_2:0|t", "{kreis}");
		linkedmessage = gsub(linkedmessage, "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_3:0|t", "{diamant}");
		linkedmessage = gsub(linkedmessage, "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_4:0|t", "{dreieck}");
		linkedmessage = gsub(linkedmessage, "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_5:0|t", "{mond}");
		linkedmessage = gsub(linkedmessage, "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_6:0|t", "{quadrat}");
		linkedmessage = gsub(linkedmessage, "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_7:0|t", "{kreuz}");
		linkedmessage = gsub(linkedmessage, "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8:0|t", "{totensch\195\164del}");
		linkedmessage = gsub(linkedmessage, "|TInterface\\AddOns\\EasyCopy\\heart:0|t", "{herz}");
	else
		linkedmessage = gsub(linkedmessage, "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:0|t", "{star}");
		linkedmessage = gsub(linkedmessage, "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_2:0|t", "{circle}");
		linkedmessage = gsub(linkedmessage, "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_3:0|t", "{diamond}");
		linkedmessage = gsub(linkedmessage, "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_4:0|t", "{triangle}");
		linkedmessage = gsub(linkedmessage, "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_5:0|t", "{moon}");
		linkedmessage = gsub(linkedmessage, "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_6:0|t", "{square}");
		linkedmessage = gsub(linkedmessage, "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_7:0|t", "{cross}");
		linkedmessage = gsub(linkedmessage, "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8:0|t", "{skull}");
		linkedmessage = gsub(linkedmessage, "|TInterface\\AddOns\\EasyCopy\\heart:0|t", "{heart}");
	end
	
	while (strfind(linkedmessage, "(%d-) |4(.-):(.-);")) do
		local _, _, num, sing, plur = strfind(linkedmessage, "(%d-) |4(.-):(.-);");
		if (num == "1") then
			linkedmessage = gsub(linkedmessage, "(%d-) |4(.-):(.-);", num.." "..sing, 1);
		else
			linkedmessage = gsub(linkedmessage, "(%d-) |4(.-):(.-);", num.." "..plur, 1);
		end
	end
	
	local retStat = 0;
	for i = 1, strlen(linkedmessage) do
		if (linkedmessage == "") then break end
		if (mode == 0) then
			if (strsub(linkedmessage, 1, 2) == "|H") then
				mode = 1;
				linkedmessage = strsub(linkedmessage, 3);
			elseif (strsub(linkedmessage, 1, 2) == "|T") then
				mode = 3;
				retStat = 0;
				linkedmessage = strsub(linkedmessage, 3);
				part = "";
			elseif (strsub(linkedmessage, 1, 2) == "||") then
				linkedmessage = strsub(linkedmessage, 3);
				msg = msg.."||";
			elseif (strsub(linkedmessage, 1, 2) == "|c") then
				linkedmessage = strsub(linkedmessage, 11);
			elseif (strsub(linkedmessage, 1, 2) == "|C") then
				linkedmessage = strsub(linkedmessage, 11);
			elseif (strsub(linkedmessage, 1, 2) == "|r") then
				linkedmessage = strsub(linkedmessage, 3);
			elseif (strsub(linkedmessage, 1, 2) == "|R") then
				linkedmessage = strsub(linkedmessage, 3);
			else
				msg = msg..strsub(linkedmessage, 1, 1);
				linkedmessage = strsub(linkedmessage, 2);
			end
		elseif (mode == 1) then
			if (strsub(linkedmessage, 1, 2) == "|h") then
				mode = 2;
				linkedmessage = strsub(linkedmessage, 3);
			else
				linkedmessage = strsub(linkedmessage, 2);
			end
		elseif (mode == 2) then
			if (strsub(linkedmessage, 1, 2) == "|h") then
				mode = 0;
				linkedmessage = strsub(linkedmessage, 3);
			elseif (strsub(linkedmessage, 1, 2) == "|T") then
				mode = 3;
				retStat = 2;
				linkedmessage = strsub(linkedmessage, 3);
				part = "";
			elseif (strsub(linkedmessage, 1, 2) == "||") then
				linkedmessage = strsub(linkedmessage, 3);
				msg = msg.."||";
			elseif (strsub(linkedmessage, 1, 2) == "|c") then
				linkedmessage = strsub(linkedmessage, 11);
			elseif (strsub(linkedmessage, 1, 2) == "|C") then
				linkedmessage = strsub(linkedmessage, 11);
			elseif (strsub(linkedmessage, 1, 2) == "|r") then
				linkedmessage = strsub(linkedmessage, 3);
			elseif (strsub(linkedmessage, 1, 2) == "|R") then
				linkedmessage = strsub(linkedmessage, 3);
			else
				msg = msg..strsub(linkedmessage, 1, 1);
				linkedmessage = strsub(linkedmessage, 2);
			end
		elseif (mode == 3) then
			if (strsub(linkedmessage, 1, 2) == "|t") then
				mode = retStat;
				linkedmessage = strsub(linkedmessage, 3);
				if (strsub(part, 1, -4) == "Interface\\TargetingFrame\\UI-RaidTargetingIcon_") then
					msg = msg.."{"..iconList[tonumber(strsub(part, -3, -3))].."}";
				elseif (part == "Interface\\AddOns\\EasyCopy\\heart:0") then
					if (GetLocale() == "deDE") then
						msg = msg.."{herz}";
					else
						msg = msg.."{heart}";
					end
				end
			else
				part = part..strsub(linkedmessage, 1, 1);
				linkedmessage = strsub(linkedmessage, 2);
			end
		end
	end
	msg = gsub(gsub(msg, "/", "/1"), "|", "/2");
	return msg;
end

function EasyCopy_SetItemRef(link, text, button)
	--ChatFrame1:AddMessage("[EasyCopy]", 1, 1, 0);
	--ChatFrame1:AddMessage("Link = "..gsub(tostring(link), "|", "||"), 1, 1, 0);
	if ( strsub(link, 1, 4) == "ezt:" ) then
		if (strfind(strsub(link, 5), ":")) then
			link = strsub(link, 5);
			ECmytest(strsub(link, strfind(link, ":") + 1), tonumber(strsub(link, 1, strfind(link, ":") - 1)));
		else
			ECmytest(strsub(link, 5));
		end
		return;
	elseif ( strsub(link, 1, 4) == "ezc:" ) then
		local chatmsg = gsub(gsub(strsub(link, 5), "/2", "|"), "/1", "/");
		if (not ACTIVE_CHAT_EDIT_BOX) then
			if (IsShiftKeyDown()) then
				if (LAST_ACTIVE_CHAT_EDIT_BOX:GetAttribute("chatType") == "CHANNEL") then
					SendChatMessage(chatmsg, "CHANNEL", nil, LAST_ACTIVE_CHAT_EDIT_BOX:GetAttribute("channelTarget"));
				elseif (LAST_ACTIVE_CHAT_EDIT_BOX:GetAttribute("chatType") == "WHISPER") then
					SendChatMessage(chatmsg, "WHISPER", nil, LAST_ACTIVE_CHAT_EDIT_BOX:GetAttribute("tellTarget"));
				elseif (LAST_ACTIVE_CHAT_EDIT_BOX:GetAttribute("chatType") == "BN_WHISPER") then
					local telltarget = tonumber(strsub(select(2, strsplit("|", LAST_ACTIVE_CHAT_EDIT_BOX:GetAttribute("tellTarget"))), 3));
					--telltarget = EasyCopy_BNGetFriendIDByPresenceID(telltarget);
					if (telltarget > -1) then
						BNSendWhisper(telltarget, chatmsg);
					end
				else
					SendChatMessage(chatmsg, LAST_ACTIVE_CHAT_EDIT_BOX:GetAttribute("chatType"), nil);
				end
			else
				if (not EasyCopy_core:IsShown()) then
					EasyCopy_core:Show();
					EasyCopy_core:SetBackdropColor(0, 0, 0, 0.9);
					EasyCopy_Edit:SetFont(DEFAULT_CHAT_FRAME:GetFont());
					EasyCopy_Edit:SetText("");
				end
				if (EasyCopy_Edit:GetText() == "") then
					EasyCopy_Edit:SetText(chatmsg);
				else
					EasyCopy_Edit:SetText(EasyCopy_Edit:GetText().."\n"..chatmsg);
				end
				-- EasyCopy_Edit:HighlightText();
				EasyCopy_Edit:SetFocus();
			end
		else
			if (IsShiftKeyDown()) then
				if (ACTIVE_CHAT_EDIT_BOX:GetAttribute("chatType") == "CHANNEL") then
					SendChatMessage(chatmsg, "CHANNEL", nil, ACTIVE_CHAT_EDIT_BOX:GetAttribute("channelTarget"));
				elseif (ACTIVE_CHAT_EDIT_BOX:GetAttribute("chatType") == "WHISPER") then
					SendChatMessage(chatmsg, "WHISPER", nil, ACTIVE_CHAT_EDIT_BOX:GetAttribute("tellTarget"));
				elseif (ACTIVE_CHAT_EDIT_BOX:GetAttribute("chatType") == "BN_WHISPER") then
					local telltarget = tonumber(strsub(select(2, strsplit("|", ACTIVE_CHAT_EDIT_BOX:GetAttribute("tellTarget"))), 3));
					if (telltarget > -1) then
						BNSendWhisper(telltarget, chatmsg);
					end
				else
					SendChatMessage(chatmsg, ACTIVE_CHAT_EDIT_BOX:GetAttribute("chatType"), nil);
				end
			else
				ACTIVE_CHAT_EDIT_BOX:Insert(chatmsg);
			end
		end
		return;
	elseif ( strsub(link, 1, 5) == "ezcc:" ) then
		if (ACTIVE_CHAT_EDIT_BOX == nil and not IsShiftKeyDown()) then
			LAST_ACTIVE_CHAT_EDIT_BOX:Show();
		end
		local chanID = strsub(link, 6, 6);
		if (chanID == "g") then
			LAST_ACTIVE_CHAT_EDIT_BOX:SetAttribute("chatType", "GUILD");
		elseif (chanID == "o") then
			LAST_ACTIVE_CHAT_EDIT_BOX:SetAttribute("chatType", "OFFICER");
		elseif (chanID == "p") then
			LAST_ACTIVE_CHAT_EDIT_BOX:SetAttribute("chatType", "PARTY");
		elseif (chanID == "r") then
			LAST_ACTIVE_CHAT_EDIT_BOX:SetAttribute("chatType", "RAID");
		elseif (chanID == "w") then
			LAST_ACTIVE_CHAT_EDIT_BOX:SetAttribute("chatType", "RAID_WARNING");
		elseif (chanID == "b") then
			LAST_ACTIVE_CHAT_EDIT_BOX:SetAttribute("chatType", "INSTANCE_CHAT");
		else
			if (IsShiftKeyDown()) then
				ListChannelByName(strsub(link, 6, 6));
				return;
			else
				LAST_ACTIVE_CHAT_EDIT_BOX:SetAttribute("chatType", "CHANNEL");
				LAST_ACTIVE_CHAT_EDIT_BOX:SetAttribute("channelTarget", strsub(link, 6, 6));
			end
		end
		ChatEdit_UpdateHeader(LAST_ACTIVE_CHAT_EDIT_BOX);
		ChatEdit_ActivateChat(LAST_ACTIVE_CHAT_EDIT_BOX);
		return;
	elseif (IsShiftKeyDown() and strsub(link, 1, 9) == "BNplayer:") then
		EasyCopy_BNFriendInfo(select(3, strsplit(":", link)));
		return;
	end
	EasyCopy_Original_SetItemRef(link, text, button);
end

function EasyCopy_MWheelOverlay_OnShow(this)
	EasyCopy_UpdateButtons();
	if (this:GetParent():GetFrameLevel() > 1) then
		this:SetFrameLevel(this:GetParent():GetFrameLevel() + 1);
	end
end

function EasyCopy_MWheelOverlay_OnMWheel(self, delta)
	if (delta < 0) then
		if IsShiftKeyDown() then
			self:GetParent():ScrollToBottom();
		else
			self:GetParent():ScrollDown();
			self:GetParent():ScrollDown();
		end
	else
		self:GetParent():ScrollUp();
		self:GetParent():ScrollUp();
	end
end

function EasyCopy_MWheelOverlay_Update()
	if (ECVars.mWheelScroll == 0) then
		ChatFrame1MWheelOverlay:Hide();
		ChatFrame2MWheelOverlay:Hide();
		ChatFrame3MWheelOverlay:Hide();
		ChatFrame4MWheelOverlay:Hide();
		ChatFrame5MWheelOverlay:Hide();
		ChatFrame6MWheelOverlay:Hide();
		ChatFrame7MWheelOverlay:Hide();
	else
		ChatFrame1MWheelOverlay:Show();
		ChatFrame2MWheelOverlay:Show();
		ChatFrame3MWheelOverlay:Show();
		ChatFrame4MWheelOverlay:Show();
		ChatFrame5MWheelOverlay:Show();
		ChatFrame6MWheelOverlay:Show();
		ChatFrame7MWheelOverlay:Show();
	end
end

function EasyCopyOptions_CheckButtonClick(button)
	local buttonID = strlower(strsub(button:GetName(), strfind(button:GetName(), "_") + 1));
	if (buttonID == "buttons") then
		if (button:GetChecked()) then
			ECVars.buttons = 1;
		else
			ECVars.buttons = 0;
		end
		EasyCopy_UpdateButtons();
	elseif (buttonID == "mwheelscroll") then
		if (button:GetChecked()) then
			ECVars.mWheelScroll = 1;
		else
			ECVars.mWheelScroll = 0;
		end
		EasyCopy_MWheelOverlay_Update();
	elseif (buttonID == "tabflashing") then
		if (button:GetChecked()) then
			ECVars.tabFlashing = 1;
		else
			ECVars.tabFlashing = 0;
		end
	elseif (buttonID == "movablebox") then
		if (button:GetChecked()) then
			ECVars.movableBox = 1;
			if (not ACTIVE_CHAT_EDIT_BOX) then
				ChatEdit_ActivateChat(LAST_ACTIVE_CHAT_EDIT_BOX);
			end
			EasyCopy_MakeBoxesMovable();
		else
			ECVars.movableBox = 0;
			EasyCopy_FixBoxPositions();
		end
	elseif (buttonID == "combatlog") then
		if (button:GetChecked()) then
			ECVars.cLogCopying = 1;
		else
			ECVars.cLogCopying = 0;
		end
	elseif (buttonID == "shortmessages_orig") then
		EasyCopyOptions_ShortMessages_Orig:SetChecked(1);
		EasyCopyOptions_ShortMessages_Long:SetChecked(0);
		EasyCopyOptions_ShortMessages_Medium:SetChecked(0);
		EasyCopyOptions_ShortMessages_Short:SetChecked(0);
		ECVars.shortMSG = 0;
	elseif (buttonID == "shortmessages_long") then
		EasyCopyOptions_ShortMessages_Orig:SetChecked(0);
		EasyCopyOptions_ShortMessages_Long:SetChecked(1);
		EasyCopyOptions_ShortMessages_Medium:SetChecked(0);
		EasyCopyOptions_ShortMessages_Short:SetChecked(0);
		ECVars.shortMSG = 1;
	elseif (buttonID == "shortmessages_medium") then
		EasyCopyOptions_ShortMessages_Orig:SetChecked(0);
		EasyCopyOptions_ShortMessages_Long:SetChecked(0);
		EasyCopyOptions_ShortMessages_Medium:SetChecked(1);
		EasyCopyOptions_ShortMessages_Short:SetChecked(0);
		ECVars.shortMSG = 2;
	elseif (buttonID == "shortmessages_short") then
		EasyCopyOptions_ShortMessages_Orig:SetChecked(0);
		EasyCopyOptions_ShortMessages_Long:SetChecked(0);
		EasyCopyOptions_ShortMessages_Medium:SetChecked(0);
		EasyCopyOptions_ShortMessages_Short:SetChecked(1);
		ECVars.shortMSG = 3;
	end
end

function EasyCopyOptions_LoadVars()
	EasyCopyOptions_core:SetBackdropColor(0, 0, 0, .7);
	EasyCopyOptions_Buttons:SetChecked(ECVars.buttons);
	EasyCopyOptions_MWheelScroll:SetChecked(ECVars.mWheelScroll);
	EasyCopyOptions_TabFlashing:SetChecked(ECVars.tabFlashing);
	EasyCopyOptions_MovableBox:SetChecked(ECVars.movableBox);
	EasyCopyOptions_CombatLog:SetChecked(ECVars.cLogCopying);
	EasyCopyOptions_MsgPrefix:SetText(tostring(ECVars.msgPrefix));
	EasyCopyOptions_ShortMessages_Long:SetChecked(0);
	EasyCopyOptions_ShortMessages_Medium:SetChecked(0);
	EasyCopyOptions_ShortMessages_Short:SetChecked(0);
	EasyCopyOptions_ShortMessages_Orig:SetChecked(0);
	if (ECVars.shortMSG == 1) then
		EasyCopyOptions_ShortMessages_Long:SetChecked(1);
	elseif (ECVars.shortMSG == 2) then
		EasyCopyOptions_ShortMessages_Medium:SetChecked(1);
	elseif (ECVars.shortMSG == 3) then
		EasyCopyOptions_ShortMessages_Short:SetChecked(1);
	else
		EasyCopyOptions_ShortMessages_Orig:SetChecked(1);
	end
end

function EasyCopy_QuoteButton_OnClick()
	if (ACTIVE_CHAT_EDIT_BOX) then
		local text = EasyCopy_Edit:GetText();
		text = gsub(gsub(text, "\r\n", "\n"), "\r", "");
		local coutput = {};
		local i = 1;
		local pos = 0;
		while (strfind(text, "\n")) do
			pos = strfind(text, "\n");
			coutput[i] = strsub(text, 1, pos - 1);
			i = i + 1;
			if ((pos + 1) > strlen(text)) then
				text = "";
			else
				text = strsub(text, pos + 1);
			end
		end
		if (text ~= "") then
			coutput[i] = text;
		end
		for i = 1, #(coutput), 1 do
			--ChatFrame1:AddMessage("Message to '"..ACTIVE_CHAT_EDIT_BOX:GetAttribute("chatType").."', tellTarget="..tostring(ACTIVE_CHAT_EDIT_BOX:GetAttribute("tellTarget")));
			if (ACTIVE_CHAT_EDIT_BOX:GetAttribute("chatType") == "WHISPER") then
				SendChatMessage(coutput[i], "WHISPER", nil, ACTIVE_CHAT_EDIT_BOX:GetAttribute("tellTarget"));
			elseif (ACTIVE_CHAT_EDIT_BOX:GetAttribute("chatType") == "BN_WHISPER") then
				--SendChatMessage(coutput[i], "BN_WHISPER", nil, ACTIVE_CHAT_EDIT_BOX:GetAttribute("tellTarget"));
				local telltarget = tonumber(strsub(select(2, strsplit("|", ACTIVE_CHAT_EDIT_BOX:GetAttribute("tellTarget"))), 3));
				--ChatFrame1:AddMessage("Message goes to #"..telltarget);
				--telltarget = EasyCopy_BNGetFriendIDByPresenceID(telltarget);
				if (telltarget > -1) then
					BNSendWhisper(telltarget, coutput[i]);
				end
			elseif (ACTIVE_CHAT_EDIT_BOX:GetAttribute("chatType") == "CHANNEL") then
				SendChatMessage(coutput[i], "CHANNEL", nil, ACTIVE_CHAT_EDIT_BOX:GetAttribute("channelTarget"));
			else
				SendChatMessage(coutput[i], ACTIVE_CHAT_EDIT_BOX:GetAttribute("chatType"));
			end
		end
	else
		UIDropDownMenu_Initialize(EasyCopy_QuoteDropDown, EasyCopy_QuoteDropDown_OnLoad, "MENU");
		ToggleDropDownMenu(1, nil, EasyCopy_QuoteDropDown, EasyCopy_QuoteButton, 0, 0);
	end
end

function EasyCopy_QuoteDropDown_OnLoad()
	local buttons = {
		[1]  = {"s",  "Say"},
        [2]  = {"e",  "Emote"},
		[3]  = {"y",  "Yell"},
		[4]  = {"w",  "Whisper"},
		[5]  = {"g",  "Guild"},
		[6]  = {"o",  "Officer"},
		[7]  = {"p",  "Party"},
		[8]  = {"r",  "Raid"},
		[9]  = {"b",  "LFR/LFG & Battleground"},
		[10]  = {"c1", EasyCopy_Channels[1]},
		[11] = {"c2", EasyCopy_Channels[2]},
		[12] = {"c3", EasyCopy_Channels[3]},
		[13] = {"c4", EasyCopy_Channels[4]},
		[14] = {"c5", EasyCopy_Channels[5]},
		[15] = {"c6", EasyCopy_Channels[6]},
		[16] = {"c7", EasyCopy_Channels[7]},
		[17] = {"c8", EasyCopy_Channels[8]},
		[18] = {"c9", EasyCopy_Channels[9]},
		[19] = {"c10", EasyCopy_Channels[10]},
	}
	local info = {};
	info.func = EasyCopy_QuoteDropDown_OnClick 
	info.notCheckable = 1;
	local info2 = { notCheckable = 1, notClickable = 1, text = " " };
	for i = 1, #(buttons), 1 do
		info.value = buttons[i][1];
		info.text  = buttons[i][2];
		UIDropDownMenu_AddButton(info);
		if (i == 9) then
			UIDropDownMenu_AddButton(info2);
		end
	end
end

function EasyCopy_QuoteDropDown_OnClick(b)
	local text = EasyCopy_Edit:GetText();
	text = gsub(gsub(text, "\r\n", "\n"), "\r", "");
	local coutput = {};
	local i = 1;
	local pos = 0;
	local channelID = {s = "SAY", e = "EMOTE", y = "YELL", g = "GUILD", o = "OFFICER", p = "PARTY", r = "RAID", b = "INSTANCE_CHAT"};
	while (strfind(text, "\n")) do
		pos = strfind(text, "\n");
		coutput[i] = strsub(text, 1, pos - 1);
		i = i + 1;
		if ((pos + 1) > strlen(text)) then
			text = "";
		else
			text = strsub(text, pos + 1);
		end
	end
	if (text ~= "") then
		coutput[i] = text;
	end
	for i = 1, #(coutput), 1 do
		if (b.value == "w") then
			if (ACTIVE_CHAT_EDIT_BOX ~= nil and ACTIVE_CHAT_EDIT_BOX:GetAttribute("chatType") == "WHISPER") then
				SendChatMessage(coutput[i], "WHISPER", nil, ACTIVE_CHAT_EDIT_BOX:GetAttribute("tellTarget"));
			elseif (ACTIVE_CHAT_EDIT_BOX ~= nil and ACTIVE_CHAT_EDIT_BOX:GetAttribute("chatType") == "BN_WHISPER") then
				local telltarget = tonumber(strsub(select(2, strsplit("|", ACTIVE_CHAT_EDIT_BOX:GetAttribute("tellTarget"))), 3));
				--telltarget = EasyCopy_BNGetFriendIDByPresenceID(telltarget);
				if (telltarget > -1) then
					BNSendWhisper(telltarget, coutput[i]);
				end
			else
				ChatFrame1:AddMessage("Usage: Open the chatbox and set a whisper target; You can do that for example by clicking on a name in chat.", 1, 0, 0);
				return;
			end
		elseif (channelID[b.value]) then
			SendChatMessage(coutput[i], channelID[b.value]);
		else
			-- ### b.value, 2, 2
			SendChatMessage(coutput[i], "CHANNEL", nil, tonumber(strsub(b.value, 2)));
		end
	end
end


function EasyCopy_SaveBoxPosition()
	ACTIVE_CHAT_EDIT_BOX:StopMovingOrSizing();
	ECVars.boxLeft = ACTIVE_CHAT_EDIT_BOX:GetLeft();
	ECVars.boxTop = ACTIVE_CHAT_EDIT_BOX:GetTop();
	EasyCopy_PositionEditBoxes();
end

function EasyCopy_PositionEditBoxes()
	for i = 1, 7 do
		getglobal("ChatFrame"..tostring(i).."EditBox"):ClearAllPoints();
		if (ECVars.boxLeft == -13 and ECVars.boxTop == -37) then
			getglobal("ChatFrame"..tostring(i).."EditBox"):SetPoint("TOPLEFT", "ChatFrame1", "BOTTOMLEFT", -5, -2);
			getglobal("ChatFrame"..tostring(i).."EditBox"):SetPoint("TOPRIGHT", "ChatFrame1", "BOTTOMRIGHT", 5, -2);
		else
			getglobal("ChatFrame"..tostring(i).."EditBox"):SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", ECVars.boxLeft, ECVars.boxTop);
			getglobal("ChatFrame"..tostring(i).."EditBox"):SetPoint("TOPRIGHT", "UIParent", "BOTTOMLEFT", ECVars.boxLeft + ChatFrame1:GetWidth() + 10, ECVars.boxTop);
		end
	end
end

function EasyCopy_MakeBoxesMovable()
	for i = 1, 7 do
		getglobal("ChatFrame"..tostring(i).."EditBox"):SetMovable();
		getglobal("ChatFrame"..tostring(i).."EditBox"):RegisterForDrag("LeftButton");
		getglobal("ChatFrame"..tostring(i).."EditBox"):SetScript("OnDragStart", getglobal("ChatFrame"..tostring(i).."EditBox").StartMoving);
		getglobal("ChatFrame"..tostring(i).."EditBox"):SetScript("OnDragStop", EasyCopy_SaveBoxPosition);
	end
end

function EasyCopy_FixBoxPositions()
	for i = 1, 7 do
		getglobal("ChatFrame"..tostring(i).."EditBox"):RegisterForDrag();
		getglobal("ChatFrame"..tostring(i).."EditBox"):SetScript("OnDragStart", nil);
		getglobal("ChatFrame"..tostring(i).."EditBox"):SetMovable(0);
	end
end

function EasyCopy_ResetEditBox()
	ECVars.boxLeft = -13;
	ECVars.boxTop = -37;
	EasyCopy_PositionEditBoxes();
end





function ECMWhisper(wto, wtext)
	SendChatMessage(gsub(wtext, "||", "|") , "WHISPER" , nil, wto);
end




function msg(someText)
	ChatFrame1:AddMessage(tostring(someText));
end

function ECmytest(cobj, start)
	if (cobj == nil) then cobj = "ChatFrame1"; end
	if (start == nil) then start = 1; end
	local kids = { getglobal(cobj):GetChildren() };
	-- local kids = { UIParent:GetChildren() };
	local counters = 0;
	local numb = 15;
	local msg = "";
	local nilcounter = 0;
	for _,child in ipairs(kids) do
		if (counters == 0) then
			DEFAULT_CHAT_FRAME:AddMessage("-- Children of: "..tostring(child:GetParent():GetName()).." --", 1, .5, 0);
			if (child:GetParent():GetParent()) then
				if (child:GetParent():GetParent():GetName()) then
					DEFAULT_CHAT_FRAME:AddMessage("|Hezt:"..child:GetParent():GetParent():GetName().."|h>> Show parent ("..child:GetParent():GetParent():GetName()..")|h",1,1,0);
				end
			end
		end
		counters = counters + 1;
		if (counters >= start) then
			if (child:GetName()) then
				msg = "|Hezt:"..child:GetName().."|h# "..counters..": "..tostring(child:GetName()).."|h";
				DEFAULT_CHAT_FRAME:AddMessage(msg, 1, 1, 0);
			else
				nilcounter = nilcounter + 1;
			end
		end
		if (counters > (start+numb-2)) then
			DEFAULT_CHAT_FRAME:AddMessage("|Hezt:"..(start+numb)..":"..cobj.."|hScroll down..|h", .5, 1, 0);
			DEFAULT_CHAT_FRAME:AddMessage("(Nameless elements: "..nilcounter..")", 1, 1, 0);
			return;
		end
	end
	DEFAULT_CHAT_FRAME:AddMessage("(Nameless elements: "..nilcounter..")", 1, 1, 0);
end

function lolhugs()
	local frame = CreateFrame("Frame")
	function frame:OnUpdate()
		if (lasthug + 4 < time()) then
			DoEmote("hug", "Mogic");
			lasthug = time();
		end
	end
	frame:SetScript("OnUpdate", frame.OnUpdate)
end

lasthug = 0;


printArr = function(tbl, iteration)
	local tableEmpty = function(sumTbl)
		for index,value in pairs(sumTbl) do
			return(nil);
		end
		return(true);
	end;
	if (iteration == nil) then
		iteration = "";
		if (tbl == nil) then
			ChatFrame1:AddMessage("--- PrintArr(nil) ---",1,1,0);
			return;
		end
		ChatFrame1:AddMessage("--- PrintArr("..type(tbl)..") ---",1,1,0);
	end
	for index,value in pairs(tbl) do
		if (type(value) == "table") then
			if (tableEmpty(value)) then
				ChatFrame1:AddMessage(iteration.."["..index.."] = {}");
			else
				ChatFrame1:AddMessage(iteration.."["..index.."] = {");
				printArr(value, iteration.."   ");
				ChatFrame1:AddMessage(iteration.."}");
			end
		elseif (type(value) == "string") then
			ChatFrame1:AddMessage(iteration.."["..index.."] = \""..value.."\"");
		elseif (type(value) == "number") then
			ChatFrame1:AddMessage(iteration.."["..index.."] = "..value);
		elseif (type(value) == "boolean") then
			if (value == true) then
				ChatFrame1:AddMessage(iteration.."["..index.."] = True");
			else
				ChatFrame1:AddMessage(iteration.."["..index.."] = False");
			end
		else
			ChatFrame1:AddMessage(iteration.."["..index.."] = |cff999999("..type(value)..")|r");
		end
	end
end;

function ec_bntest()
	local frnds, frndson = BNGetNumFriends();
	ChatFrame1:AddMessage("-- Friends: "..frnds.." ("..frndson.." online) --",1,1,0);
	for i = 1, frnds do
		local presenceID, givenName, surname, toonName, toonID, client, isOnline, lastOnline, isAFK, isDND, broadcastText, noteText, isFriend, broadcastTime = BNGetFriendInfo(i);
		ChatFrame1:AddMessage(i..") "..givenName.." "..surname..", ID "..presenceID..", ist als "..toonName.." in "..client.." on.");
		printArr({BNGetToonInfo(toonID)});
	end
end

function EasyCopy_BNFriendInfo(bnid)
	local friendID = EasyCopy_BNGetFriendIDByPresenceID(bnid);
	if (friendID == -1) then
		ChatFrame1:AddMessage("BNID "..bnid.." not found");
		return;
	end
	local presenceID, givenName, surname, toonName, toonID, client, isOnline, lastOnline, isAFK, isDND, broadcastText, noteText, isFriend, broadcastTime = BNGetFriendInfo(friendID);
	local msg = givenName.." "..surname.." ";
	if (not isOnline) then
		ChatFrame1:AddMessage(msg.."was last seen "..lastOnline, 1, 1, 0);
	else
		if (isAFK) then
			msg = msg.."<AFK> ";
		end
		if (isDND) then
			msg = msg.."<DND> ";
		end
		msg = msg.."plays "..client;
		ChatFrame1:AddMessage(msg, 1, 1, 0);
		if (client == "WoW") then
			local hasFocus, toonName, client, realmName, faction, race, class, guild, zoneName, level, gameText = BNGetToonInfo(toonID);
			ChatFrame1:AddMessage(toonName.." - "..realmName..": Level "..level.." "..race.." "..class.." - "..zoneName, 1, 1, 0);
		end
	end
end

function EasyCopy_BNGetFriendIDByPresenceID(friendID)
	local frnds, frndson = BNGetNumFriends();
	friendID = tonumber(friendID);
	for i = 1, frnds do
		if (select(1, BNGetFriendInfo(i)) == friendID) then
			return(i);
		end
	end
	return(-1);
end

function EasyCopy_ResetButton_OnClick()
    EasyCopy_core:ClearAllPoints();
    EasyCopy_core:SetPoint("CENTER",0,0);
end

function EasyCopyOptions_ResetButton_OnClick()
    EasyCopyOptions_core:ClearAllPoints();
    EasyCopyOptions_core:SetPoint("CENTER",0,0);
end