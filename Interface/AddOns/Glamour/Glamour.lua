-- globals
Glamour_NAME =  "Glamour";
Glamour_VERSION = GetAddOnMetadata("Glamour", "Version") or "UnKnown";
print(Glamour_NAME.." "..Glamour_VERSION.." Loaded!");
GlamourLastFrame = nil;
GlamourFrameLimit = 12;
realm = GetRealmName("player");
player = GetUnitName("player");

-- Some Locals for BNToast Routines
local GlamourBNToasts = { };
local BNToastEvents = {
	showToastOnline = { "BN_FRIEND_ACCOUNT_ONLINE" },
	showToastOffline = { "BN_FRIEND_ACCOUNT_OFFLINE" },
	showToastBroadcast = { "BN_CUSTOM_MESSAGE_CHANGED" },
	showToastFriendRequest = { "BN_FRIEND_INVITE_ADDED", "BN_FRIEND_INVITE_LIST_INITIALIZED" },
	showToastConversation = { "BN_CHAT_CHANNEL_JOINED" },
};
local BN_TOAST_TYPE_ONLINE = 1;
local BN_TOAST_TYPE_OFFLINE = 2;
local BN_TOAST_TYPE_BROADCAST = 3;
local BN_TOAST_TYPE_PENDING_INVITES = 4;
local BN_TOAST_TYPE_NEW_INVITE = 5;
local BN_TOAST_TYPE_CONVERSATION = 6;

--
-- GUI Functions
--

-- This function is run on pressing the Ok or Close Buttons.
--   Sets the Status of the Saved Variables to the new settings
--
function GlamourPanel_Close()
	GlamourConfig["Settings"].BLIZ_AchAlert = GlamourGUIFrame_BLIZ_AchAlert:GetChecked();
	GlamourConfig["Settings"].RevOrder = GlamourGUIFrame_RevOrder:GetChecked();
	GlamourConfig["Settings"].BLIZ_DCAlert = GlamourGUIFrame_BLIZ_DCAlert:GetChecked();
	GlamourConfig["Settings"].BLIZ_BNToast = GlamourGUIFrame_BLIZ_BNToast:GetChecked();
	GlamourConfig["Settings"].BLIZ_GCAlert = GlamourGUIFrame_BLIZ_GCAlert:GetChecked();
	GlamourConfig["Settings"].BLIZ_BNToast_Scale = GlamourGUIFrame_BLIZ_BNToast_Scale:GetChecked();
	if GlamourGUIFrame_RELOADCHECK:GetChecked() then
		ReloadUI();
	end
end


-- This function is run on pressing the Cancel Button or from the VARIABLES LOADED event function.
--   Sets the status of the Check Boxes to the Values of the Saved Variables.
--
function GlamourPanel_CancelOrLoad()
	GlamourGUIFrame_BLIZ_AchAlert:SetChecked(GlamourConfig["Settings"].BLIZ_AchAlert);
	GlamourGUIFrame_RevOrder:SetChecked(GlamourConfig["Settings"].RevOrder);
	GlamourGUIFrame_BLIZ_DCAlert:SetChecked(GlamourConfig["Settings"].BLIZ_DCAlert);
	GlamourGUIFrame_BLIZ_BNToast:SetChecked(GlamourConfig["Settings"].BLIZ_BNToast);
	GlamourGUIFrame_BLIZ_BNToast_Scale:SetChecked(GlamourConfig["Settings"].BLIZ_BNToast_Scale);
	GlamourGUIFrame_BLIZ_GCAlert:SetChecked(GlamourConfig["Settings"].BLIZ_GCAlert);
end


-- The GUI OnLoad function.
--
function GlamourPanel_OnLoad(panel)
	-- Set the Text for the Check boxes.
	--
	GlamourGUIFrame_BLIZ_AchAlertText:SetText("Capture Blizzard Achievement Alerts |cffff0000Requires ReloadUI|r");
	GlamourGUIFrame_BLIZ_DCAlertText:SetText("Capture Blizzard Dungeon Completion Alerts");
	GlamourGUIFrame_BLIZ_GCAlertText:SetText("Capture Blizzard Guild Challenge Alerts");
	GlamourGUIFrame_BLIZ_BNToastText:SetText("Capture battle.net Toast Alerts");
	GlamourGUIFrame_BLIZ_BNToast_ScaleText:SetText("Scale large battle.net broadcasts messages.");
	GlamourGUIFrame_RevOrderText:SetText("Reverse Alert Direction  |cffff0000 Requires ReloadUI|r");
	GlamourGUIFrame_RELOADCHECKText:SetText("|cffff0000ReloadUI|r");

	-- Set the name for the Category for the Panel
	--
	panel.name = Glamour_NAME.." v"..Glamour_VERSION;

	-- When the player clicks okay, set the Saved Variables to the current Check Box setting
	--
	panel.okay = function (self) GlamourPanel_Close(); end;

	-- When the player clicks cancel, set the Check Box status to the Saved Variables.
	panel.cancel = function (self)  GlamourPanel_CancelOrLoad();  end;

	-- Add the panel to the Interface Options
	--
	InterfaceOptions_AddCategory(panel);
end

function Glamour_OnLoad(self)
	self:RegisterEvent("VARIABLES_LOADED");
end

function Glamour_OnEvent(frame, event, arg1, ...)
	if (not GlamourConfig) then
		GlamourConfig = {};
	end

	if (not GlamourConfig["Settings"]) then
		Glamour_SetDefaultConfig("1.0.1");
	elseif (not GlamourConfig["Settings"].LASTRUN) then
		Glamour_SetDefaultConfig("1.0.1");
	elseif (GlamourConfig["Settings"].LASTRUN ~= Glamour_VERSION) then
		Glamour_SetDefaultConfig(GlamourConfig["Settings"].LASTRUN);
	end
	GlamourConfig["Settings"].LASTRUN = Glamour_VERSION;
	GlamourPanel_CancelOrLoad();	
end

function Glamour_SetDefaultConfig(LASTVER)
	local major, minor, build = strsplit(".", LASTVER);
	local last_ver = tonumber(major.."."..minor..build);

	if (last_ver < 1.30) then
		--Standard Defaults
		GlamourConfig["Settings"] = {} ;
		GlamourConfig["Settings"].BLIZ_AchAlert = 1;
		GlamourConfig["Settings"].RevOrder = nil;
	end
	if (last_ver < 1.31) then
		--New Default Values for v1.3.1
		GlamourConfig["Settings"].BLIZ_DCAlert = 1;
		GlamourConfig["Settings"].BLIZ_BNToast = 1;
	end
	if (last_ver < 1.4) then
		--New Default Values for v1.4.0
		GlamourConfig["Settings"].BLIZ_GCAlert = 1;
		GlamourConfig["Settings"].BLIZ_BNToast_Scale = 1;
	end
	GlamourAnchor:Show();
end

function GlamourAlertSample(FrameStyle)
	
	local MyData = {};
	MyData.Text = "General Text";
	MyData.Title = "Title";
	MyData.bTitle = "bTitle";
	MyData.Icon = "Interface\\Icons\\INV_Misc_QuestionMark";
	MyData.tText = "tText";
	MyData.bText = "bText";
	MyData.FrameStyle = FrameStyle;
	MyData.ShieldHide = false;
	MyData.ShieldIcon = false;
	MyData.ShieldText = "shieldText";
	MyData.HideGlow = false;
	MyData.HideShine = false;
	MyData.ShowBanner = true;
	MyData.BannerColor = {r=.2,g=.2,b=.8};
	local green = {r=0,g=1,b=0};
	local red = {r=1,g=0,b=0 };
	
	 GlamourShowAlert(1, MyData, nil, nil);
	 GlamourShowAlert(1, MyData, red, green);
	--
	 GlamourShowAlert(0, MyData, nil, nil);
	 GlamourShowAlert(0, MyData, red, green); 
	--
	 GlamourShowAlert(400, MyData, green, red); 
	 GlamourShowAlert(200, MyData, red, green); 
	--
	 GlamourShowAlert(1, MyData, nil, nil);
	 GlamourShowAlert(1, MyData, red, green);
	--
end

function GlamourResetAlertFrame()

	local MyData = {};
	MyData.ShieldHide = false;
	MyData.ShieldIcon = false;
	MyData.HideGlow = false;
	MyData.HideShine = false;
	MyData.ShowBanner = true;
	MyData.ShowTitle = true;
	MyData.BannerColor = {r=.8,g=.8,b=.8};
	MyData.Reset = 1;
	
	GlamourShowAlert(1, MyData, nil, nil);
end

function GlamourShowAlert(size, data, glow, shine)
	-- size: numeric
	--  	width of the alert frame with the following predefinded values
	--  	0 : Shows just the Icon and IconFrame along with ttext and bttext from the data fields. This mode also hides the shine effect.
	--  	1 : Default size (width 300);
	--  	* : any other number will be used as a specific size to resize the width too. 300 is the default size, use this as a starting point.
	-- data: keytable: 
	-- 	Text = Text to display
	-- 	Title = Title to display
	-- 	bTitle = text to display on the border of the guild alert frame.
	-- 	IconBG = Set a texture behind Icon.
	-- 	IconBGAdjust = {x, y, x-offset, y-offset} Resizes and Adjusts the icon.
	-- 	Icon = icon path to display
	-- 	IconAdjust = {x, y, x-offset, y-offset} Resizes and Adjusts the icon. (offsets are relative to IconBG's CENTER
	-- 	IconFrameHide = Hide the border around the icon.
	-- 	tText = text to display at the top of the icon
	-- 	bText = text to display at the bottom of the icon
	-- 	Points = numeric value to display ontop of the shield icon (0 for nothing)
	--  	ShieldHide = Boolean (true or false ) hides the shield icon on the right of the frame. (This does not Hide shieldPoints).
	--	ShieldIcon = String containing the path to a custom Icon/Texture to use in place of the regular shield.
	--  	FrameStyle = String to identify the type of frame to use for your alert.
	--  		nil: Use the default Blizzard Achievement style.
	--  		GuildAchievement: Use the Blizzard Guild Achievement style.
	--  		Notice: A small alert that handles a single line/short sentence of text.
	--  	HideBanner = Boolean (true or false ) hides the banner and banner border textures when useGuildAch is active
	--  	BannerColor = keytable: {r,g,b} or nil for default - the rgb values to use for the banner color when useGuildAch is active.
	--  	HideGlow = Boolean (true or false) hides the glow effect on the alert window.
	--  	HideShine = Boolean (true or false) hides the shine effect on the alert window.
	-- glow: keytable: {r,g,b} or nil for default - the rgb values to use for the glow animation
	-- shine: keytable: {r,g,b} or nil for default - the rgb values to use for the shine animation

	local frame = GlamourAlertFrame_GetAlertFrame();

	if ( not frame ) then
		-- We ran out of frames! Bail!
		print("bailed!");
		return;
	end
	
	local frameName = frame:GetName();
	local displayName = _G[frameName.."Name"];
	local displayNameTop = _G[frameName.."IconNameTop"];
	local displayNameBottom = _G[frameName.."IconNameBottom"];
	local shieldPoints = _G[frameName.."ShieldPoints"];
	local shieldIcon = _G[frameName.."ShieldIcon"];
	local BackGround = _G[frameName.."Background"];
	local Unlocked = _G[frameName.."Unlocked"];
	local guildName = _G[frameName.."GuildName"];
	local guildBorder = _G[frameName.."GuildBorder"];
	local guildBanner = _G[frameName.."GuildBanner"];
	local frameIcon = _G[frameName.."IconTexture"];
	
	if(data.ClickFuncName) then
		frame.ClickFuncName = data.ClickFuncName;
	end

	if(data.ClickFuncVars) then
		frame.ClickFuncVars = data.ClickFuncVars;
	end

	displayName:SetText(data.Text);
	displayNameTop:SetText(data.tText);
	displayNameBottom:SetText(data.bText);
	guildName:SetText(data.bTitle);

	BackGround:Show();
	Unlocked:Show();
	displayName:Show();
	shieldPoints:Show();
	shieldIcon:Show();
	guildName:Show();
	guildBorder:Show();
	guildBanner:Show();


	if(data.IconBG) then
		_G[frameName.."IconTextureBG"]:SetTexture(data.IconBG);
	else
		_G[frameName.."IconTextureBG"]:SetTexture(0, 0, 0, 1);
	end

	if(data.IconBGAdjust) then
		_G[frameName.."IconTextureBG"]:SetWidth(data.IconBGAdjust[1]);
		_G[frameName.."IconTextureBG"]:SetHeight(data.IconBGAdjust[2]);
		_G[frameName.."IconTextureBG"]:SetPoint("CENTER", data.IconBGAdjust[3], data.IconBGAdjust[4]);
	else
		_G[frameName.."IconTextureBG"]:SetWidth(50);
		_G[frameName.."IconTextureBG"]:SetHeight(50);
		_G[frameName.."IconTextureBG"]:SetPoint("CENTER");
	end

	if(data.IconAdjust) then
		_G[frameName.."IconTexture"]:SetWidth(data.IconAdjust[1]);
		_G[frameName.."IconTexture"]:SetHeight(data.IconAdjust[2]);
		_G[frameName.."IconTexture"]:SetPoint("CENTER", data.IconAdjust[3], data.IconAdjust[4]);
	else
		_G[frameName.."IconTexture"]:SetWidth(50);
		_G[frameName.."IconTexture"]:SetHeight(50);
		_G[frameName.."IconTexture"]:SetPoint("CENTER");
	end

	if(data.IconFrameHide) then
		_G[frameName.."IconOverlay"]:Hide();
	else
		_G[frameName.."IconOverlay"]:Show();
	end

	if(data.Points) then
		data.ShieldText = data.Points;
	elseif(not data.ShieldText) then
		data.ShieldText = "";
	end

	if(data.ShieldIcon) then
		shieldIcon:SetTexture(data.ShieldIcon);
		shieldIcon:SetTexCoord(0,1,0,1);
	else
		if ( data.points == 0 ) then
			shieldIcon:SetTexture([[Interface\AchievementFrame\UI-Achievement-Shields-NoPoints]]);
		else
			shieldIcon:SetTexture([[Interface\AchievementFrame\UI-Achievement-Shields]]);
		end	
		if (data.FrameStyle == "GuildAchievement") then
			shieldIcon:SetTexCoord(0, 0.5, 0.5, 1);
		else
			shieldIcon:SetTexCoord(0, 0.5, 0, 0.45);
		end
	end


	if ( data.func ) then
		frame.func = data.func;
	else
		frame.func = nil;
	end

	if ( data.FrameStyle ) then
		if ( data.FrameStyle == "GuildAchievement" ) then
			frame:SetHeight(104);
			local background = _G[frameName.."Background"];
			background:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Guild");
			background:SetTexCoord(0.00195313, 0.62890625, 0.00195313, 0.19140625);
			background:SetPoint("TOPLEFT", -2, 2);
			background:SetPoint("BOTTOMRIGHT", 8, 8);
			_G[frameName.."IconOverlay"]:Show();
			local iconBorder = _G[frameName.."IconOverlay"];
			iconBorder:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Guild");
			iconBorder:SetTexCoord(0.25976563,0.40820313,0.50000000,0.64453125);
			iconBorder:SetPoint("CENTER", 0, 1);
			_G[frameName.."Icon"]:SetPoint("TOPLEFT", -26, 2);
			displayName:SetPoint("BOTTOMLEFT", 79, 37);
			displayName:SetPoint("BOTTOMRIGHT", -79, 37);
			displayNameTop:Show();
			displayNameBottom:Show();
			_G[frameName.."Shield"]:SetPoint("TOPRIGHT", -15, -28);
			frameIcon:Show();
			_G[frameName.."IconTextureBG"]:Show();
			_G[frameName.."IconOverlay"]:Show();
			shieldPoints:SetPoint("CENTER", 7, 5);
			shieldPoints:SetVertexColor(0, 1, 0);
			shieldPoints:Show();
			shieldIcon:Show();
			local unlocked = _G[frameName.."Unlocked"];
			unlocked:SetPoint("TOP", -1, -36);
			unlocked:SetText(GUILD_ACHIEVEMENT_UNLOCKED);
			unlocked:Show();
			guildName:Show();
			guildBanner:Show();
			guildBorder:Show();
			frame.glow:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Guild");
			frame.glow:SetTexCoord(0.00195313, 0.74804688, 0.19531250, 0.49609375);
			frame.shine:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Guild");
			frame.shine:SetTexCoord(0.75195313, 0.91601563, 0.19531250, 0.35937500);
			frame.shine:SetPoint("BOTTOMLEFT", 0, 16);
			frame.shine:Show();
			if(data.HideBanner) then
				guildBanner:Hide();
				guildBorder:Hide();
			elseif(data.BannerColor) then
				local BannerColor = data.BannerColor;
				guildBanner:SetVertexColor(BannerColor.r,BannerColor.g,BannerColor.b);
			end
		elseif ( data.FrameStyle == "Notice" ) then
			frame:SetHeight(20);
			local background = _G[frameName.."Background"];
			background:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Parchment-Horizontal-Desaturated");
			background:SetTexCoord(0, 1, 0, 1);
			background:SetPoint("TOPLEFT", 0, 0);
			background:SetPoint("BOTTOMRIGHT", 0, 0);
			_G[frameName.."IconOverlay"]:Hide();
			displayName:SetPoint("BOTTOMLEFT", 0, 3);
			displayName:SetPoint("BOTTOMRIGHT", 0, 3);
			displayNameTop:Hide();
			displayNameBottom:Hide();
			shieldPoints:Hide();
			shieldIcon:Hide();
			frameIcon:Hide();
			_G[frameName.."Unlocked"]:Hide();
			_G[frameName.."GuildName"]:Hide();
			_G[frameName.."GuildBorder"]:Hide();
			_G[frameName.."GuildBanner"]:Hide();
			_G[frameName.."IconTexture"]:Hide();
			_G[frameName.."IconTextureBG"]:Hide();
			_G[frameName.."IconOverlay"]:Hide();
			frame.glow:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Alert-Glow");
			frame.glow:SetTexCoord(0, 0.78125, 0, 0.66796875);
		else
			print(_G["RED_FONT_COLOR_CODE"],"[ERROR] Glamour Alert called with invalid FrameStyle: ", data.FrameStyle, _G["FONT_COLOR_CODE_CLOSE"]);
			data.FrameStyle = nil;
		end
	end

	if (not data.FrameStyle ) then
		frame:SetHeight(88);
		local background = _G[frameName.."Background"];
		background:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Alert-Background");
		background:SetTexCoord(0, 0.605, 0, 0.703);
		background:SetPoint("TOPLEFT", 0, 0);
		background:SetPoint("BOTTOMRIGHT", 0, 0);
		local iconBorder = _G[frameName.."IconOverlay"];
		iconBorder:SetTexture("Interface\\AchievementFrame\\UI-Achievement-IconFrame");
		iconBorder:SetTexCoord(0, 0.5625, 0, 0.5625);
		iconBorder:SetPoint("CENTER", -1, 2);
		_G[frameName.."Icon"]:SetPoint("TOPLEFT", -26, 16);
		displayName:SetPoint("BOTTOMLEFT", 72, 36);
		displayName:SetPoint("BOTTOMRIGHT", -60, 36);
		displayNameTop:Show();
		displayNameBottom:Show();
		_G[frameName.."Shield"]:SetPoint("TOPRIGHT", -10, -13);
		shieldPoints:SetPoint("CENTER", 7, 2);
		shieldPoints:SetVertexColor(1, 1, 1);
		shieldPoints:Show();
		shieldIcon:Show();
		local unlocked = _G[frameName.."Unlocked"];
		unlocked:SetPoint("TOP", 7, -23);
		unlocked:SetText(ACHIEVEMENT_UNLOCKED);
		unlocked:Show();
		_G[frameName.."GuildName"]:Hide();
		_G[frameName.."GuildBorder"]:Hide();
		_G[frameName.."GuildBanner"]:Hide();
		frameIcon:Show();
		_G[frameName.."IconTextureBG"]:Show();
		_G[frameName.."IconOverlay"]:Show();
		frame.glow:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Alert-Glow");
		frame.glow:SetTexCoord(0, 0.78125, 0, 0.66796875);
		frame.shine:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Alert-Glow");
		frame.shine:SetTexCoord(0.78125, 0.912109375, 0, 0.28125);
		frame.shine:SetPoint("BOTTOMLEFT", 0, 8);
		frame.shine:Show();
	end

	if (size == 0) then
		frame:SetWidth(44);
		BackGround:Hide();
		Unlocked:Hide();
		displayName:Hide();
		shieldPoints:Hide();
		shieldIcon:Hide();
		guildName:Hide();
		guildBorder:Hide();
		guildBanner:Hide();
		frame.glow:SetPoint("TOPLEFT", frameIcon,"TOPLEFT", -25, 75)
		frame.glow:SetPoint("BOTTOMRIGHT", frameIcon ,"BOTTOMRIGHT", 25, -75)
		frame.shine:Hide();
	elseif (size == 1) then
		frame:SetWidth(300);
		frame.glow:SetPoint("TOPLEFT", frame ,"TOPLEFT", -50, 0)
		frame.glow:SetPoint("BOTTOMRIGHT", frame ,"BOTTOMRIGHT", 50, 0)
		frame.shine:SetPoint("TOPLEFT", frame ,"TOPLEFT", -50, 0)
		--frame.shine:SetPoint("BOTTOMRIGHT", frame ,"BOTTOMRIGHT", 50, 0)
		
	else
		frame:SetWidth(size);
		frame.glow:SetPoint("TOPLEFT", frame ,"TOPLEFT", -50, 0)
		frame.glow:SetPoint("BOTTOMRIGHT", frame ,"BOTTOMRIGHT", 50, 0)
		frame.shine:SetPoint("TOPLEFT", frame ,"TOPLEFT", -50, 0)
		--frame.shine:SetPoint("BOTTOMRIGHT", frame ,"BOTTOMRIGHT", 50, 0)
	end


	GlamourAchievementShield_SetPoints(data.ShieldText, shieldPoints, GameFontNormal, GameFontNormalSmall);

	if(data.Title) then
		frame.unlocked:SetText(data.Title);
	end

	if(data.Icon) then
		frameIcon:SetTexture(data.Icon);
	end

	if(data.HideGlow) then
		frame.glow:Hide();
	end
	if(data.HideShine) then
		frame.shine:Hide();
	end

	if(data.ShieldHide) then
		shieldIcon:Hide();
	end

	if (glow) then
		frame.glow:SetVertexColor(glow.r,glow.g,glow.b);
	else
		frame.glow:SetVertexColor(1,1,1);
	end

	if (shine) then
		frame.shine:SetVertexColor(shine.r,shine.g,shine.b);
	else
		frame.shine:SetVertexColor(1,1,1);
	end
	
	if(not data.Reset) then
		GlamourAlertFrame_AnimateIn(frame);
	end

	BNToastFrame_UpdateAnchor(true);
	return frameName;
end


function GlamourAlertFrame_GetAlertFrame()
	local name, frame, previousFrame;
	for i=1, GlamourFrameLimit do
		name = "GlamourAlertFrame"..i;
		frame = _G[name];
		if ( frame ) then
			if ( not frame:IsShown() ) then
				GlamourLastFrame = frame;
				return frame;
			end
		else
			frame = CreateFrame("Button", name, UIParent, "GlamourAlertFrameTemplate");
			if ( not previousFrame or i == 13 ) then
				frame:SetPoint("CENTER", GlamourAnchor, "CENTER", 0, 0);
			else
				if (GlamourConfig["Settings"].RevOrder) then
					frame:SetPoint("BOTTOM", previousFrame, "TOP", 0, 0);
				else
					frame:SetPoint("TOP", previousFrame, "BOTTOM", 0, 0);
				end
			end
			GlamourLastFrame = frame;
			return frame;
		end	
		previousFrame = frame;
	end
	return nil;
end

Blizzard_AchievementAlertFrame_GetAlertFrame = AchievementAlertFrame_GetAlertFrame;
Blizzard_AchievementAlertFrame_ShowAlert = AchievementAlertFrame_ShowAlert;

function AchievementAlertFrame_GetAlertFrame()
	if (GlamourConfig["Settings"].BLIZ_AchAlert) then
		return GlamourAlertFrame_GetAlertFrame();
	else 
		return Blizzard_AchievementAlertFrame_GetAlertFrame();
	end
end

function AchievementAlertFrame_ShowAlert(achievementID)
	if (GlamourConfig["Settings"].BLIZ_AchAlert) then
		GlamourResetAlertFrame(GlamourAlertFrame_GetAlertFrame());
	end
	Blizzard_AchievementAlertFrame_ShowAlert(achievementID);
end

function GlamourAlertFrame_OnClick (self, button)

	if (self.ClickFuncName) then
		self.ClickFuncName(self, button);
		return;
	end

	if ( button == "RightButton" ) then
		self:Hide();
		return;
	end

	local id = self.id;
	if ( not id ) then
		self:Hide();
		return;
	end
	
	ShowUIPanel(AchievementFrame);
	
	local _, _, _, achCompleted = GetAchievementInfo(id);
	if ( achCompleted and (ACHIEVEMENTUI_SELECTEDFILTER == AchievementFrameFilters[ACHIEVEMENT_FILTER_INCOMPLETE].func) ) then
		AchievementFrame_SetFilter(ACHIEVEMENT_FILTER_ALL);
	elseif ( (not achCompleted) and (ACHIEVEMENTUI_SELECTEDFILTER == AchievementFrameFilters[ACHIEVEMENT_FILTER_COMPLETE].func) ) then
		AchievementFrame_SetFilter(ACHIEVEMENT_FILTER_ALL);
	end
	
	AchievementFrame_SelectAchievement(id)
end

function GlamourAchievementShield_OnLoad (self)
	self.Desaturate = AchievementShield_Desaturate;
	self.Saturate = AchievementShield_Saturate;
end

function GlamourAchievementShield_SetPoints(points, pointString, normalFont, smallFont)
	if ( strlen(points) > 3) then
		pointString:SetFontObject(normalFont);
	else
		pointString:SetFontObject(smallFont);
	end
	pointString:SetText(points);
end

function GlamourAlertFrame_AnimateIn(frame)
	frame:Show();
	frame.animIn:Play();
	frame.glow.animIn:Play();
	frame.shine.animIn:Play();
	frame.waitAndAnimOut:Stop();	--Just in case it's already animating out, but we want to reinstate it.
	if ( frame:IsMouseOver() ) then
		frame.waitAndAnimOut.animOut:SetStartDelay(1);
	else
		frame.waitAndAnimOut.animOut:SetStartDelay(4.05);
		frame.waitAndAnimOut:Play();
	end
end

Blizzard_AchievementAlertFrame_FixAnchors = AchievementAlertFrame_FixAnchors;

function AchievementAlertFrame_FixAnchors ()
	-- Temporary (here's hoping) workaround so that achievement alerts are anchored to loot roll windows. Eventually we want one system to handle placement for both alerts.
	if ( not GlamourAlertFrame1) then
		-- We haven't displayed any achievement alerts yet, so there's nothing to reanchor (read: this got called by LootFrame.lua)
		return;
	end
	
	GlamourAlertFrame1:ClearAllPoints();
	GlamourAlertFrame1:SetPoint("CENTER", GlamourAnchor);
end

Blizzard_DungeonCompletionAlertFrame_FixAnchors = DungeonCompletionAlertFrame_FixAnchors;

function DungeonCompletionAlertFrame_FixAnchors()
	DungeonCompletionAlertFrame1:ClearAllPoints();
	if (GlamourConfig["Settings"].BLIZ_DCAlert) then
	
		for i=GlamourFrameLimit, 1, -1 do
			local frame = _G["GlamourAlertFrame"..i];
			if ( frame and frame:IsShown() ) then
				if (GlamourConfig["Settings"].RevOrder) then
					DungeonCompletionAlertFrame1:SetPoint("BOTTOM", frame, "TOP");
				else
					DungeonCompletionAlertFrame1:SetPoint("TOP", frame, "BOTTOM");
				end
				return;
			end
		end
	
		DungeonCompletionAlertFrame1:SetPoint("CENTER", GlamourAnchor)
	else
		Blizzard_DungeonCompletionAlertFrame_FixAnchors();
	end
end

Blizzard_BNToastFrame_UpdateAnchor = BNToastFrame_UpdateAnchor;

function BNToastFrame_UpdateAnchor(forceAnchor)
	BNToastFrame:ClearAllPoints();
	if (GlamourConfig["Settings"].BLIZ_BNToast) then
	
		if ( GuildChallengeAlertFrame:IsShown() and GlamourConfig["Settings"].BLIZ_GCAlert) then
				if (GlamourConfig["Settings"].RevOrder) then
					BNToastFrame:SetPoint("BOTTOM",  GuildChallengeAlertFrame, "TOP");
				else
					BNToastFrame:SetPoint("TOP",  GuildChallengeAlertFrame, "BOTTOM");
				end
			return;
		end	

		if ( DungeonCompletionAlertFrame1:IsShown() and GlamourConfig["Settings"].BLIZ_DCAlert) then
				if (GlamourConfig["Settings"].RevOrder) then
					BNToastFrame:SetPoint("BOTTOM",  DungeonCompletionAlertFrame1, "TOP");
				else
					BNToastFrame:SetPoint("TOP",  DungeonCompletionAlertFrame1, "BOTTOM");
				end
			return;
		end	

		for i=GlamourFrameLimit, 1, -1 do
			local frame = _G["GlamourAlertFrame"..i];
			if ( frame and frame:IsShown() ) then
				if (GlamourConfig["Settings"].RevOrder) then
					BNToastFrame:SetPoint("BOTTOM", frame, "TOP");
				else
					BNToastFrame:SetPoint("TOP", frame, "BOTTOM");
				end
				return;
			end
		end
		BNToastFrame:SetPoint("CENTER", GlamourAnchor, "CENTER");
	else
		Blizzard_BNToastFrame_UpdateAnchor(forceAnchor);
	end
end

function Glamour_DungeonCompletionAlertFrame_ShowAlert()
	PlaySound("LFG_Rewards");
	local frame = DungeonCompletionAlertFrame1;
	--For now we only have 1 dungeon alert frame. If you're completing more than one dungeon within ~5 seconds, tough luck.
	--local name, typeID, textureFilename, moneyBase, moneyVar, experienceBase, experienceVar, numStrangers, numRewards= GetLFGCompletionReward();
	local name = "Test Dungeon";
	local typeID = TYPEID_HEROIC_DIFFICULTY;
	local textureFilename = "Stratholme";
	local moneyBase = 12; 
	local moneyVar = 12; 
	local experienceBase = 12; 
	local experienceVar = 12; 
	local numStrangers = 4; 
	local numRewards = 0;
	
	
	--Set up the rewards
	local moneyAmount = moneyBase + moneyVar * numStrangers;
	local experienceGained = experienceBase + experienceVar * numStrangers;
	
	local rewardsOffset = 0;

	if ( moneyAmount > 0 or experienceGained > 0 ) then --hasMiscReward ) then
		SetPortraitToTexture(DungeonCompletionAlertFrame1Reward1.texture, "Interface\\Icons\\inv_misc_coin_02");
		DungeonCompletionAlertFrame1Reward1.rewardID = 0;
		DungeonCompletionAlertFrame1Reward1:Show();

		rewardsOffset = 1;
	end
	
	for i = 1, numRewards do
		local frameID = (i + rewardsOffset);
		local reward = _G["DungeonCompletionAlertFrame1Reward"..frameID];
		if ( not reward ) then
			reward = CreateFrame("FRAME", "DungeonCompletionAlertFrame1Reward"..frameID, DungeonCompletionAlertFrame1, "DungeonCompletionAlertFrameRewardTemplate");
			reward:SetID(frameID);
			DUNGEON_COMPLETION_MAX_REWARDS = frameID;
		end
		DungeonCompletionAlertFrameReward_SetReward(reward, i);
	end
	
	local usedButtons = numRewards + rewardsOffset;
	--Hide the unused ones
	for i = usedButtons + 1, DUNGEON_COMPLETION_MAX_REWARDS do
		_G["DungeonCompletionAlertFrame1Reward"..i]:Hide();
	end
	
	if ( usedButtons > 0 ) then
		--Set up positions
		local spacing = 36;
		DungeonCompletionAlertFrame1Reward1:SetPoint("TOP", DungeonCompletionAlertFrame1, "TOP", -spacing/2 * usedButtons + 41, 0);
		for i = 2, usedButtons do
			_G["DungeonCompletionAlertFrame1Reward"..i]:SetPoint("CENTER", "DungeonCompletionAlertFrame1Reward"..(i - 1), "CENTER", spacing, 0);
		end
	end
	
	--Set up the text and icons.
	
	frame.instanceName:SetText(name);
	if ( typeID == TYPEID_HEROIC_DIFFICULTY ) then
		frame.heroicIcon:Show();
		frame.instanceName:SetPoint("TOP", 33, -44);
	else
		frame.heroicIcon:Hide();
		frame.instanceName:SetPoint("TOP", 25, -44);
	end
		
	frame.dungeonTexture:SetTexture("Interface\\LFGFrame\\LFGIcon-"..textureFilename);

	AlertFrame_AnimateIn(frame)
	AlertFrame_FixAnchors();
	BNToastFrame_UpdateAnchor(true);
end

Blizzard_BNToastFrame_Show = BNToastFrame_Show;
Blizzard_BNToastFrame_AddToast = BNToastFrame_AddToast;

function BNToastFrame_AddToast(toastType, toastData)
	if (not GlamourConfig["Settings"].BLIZ_BNToast_Scale) then
		Blizzard_BNToastFrame_AddToast(toastType, toastData);
		return;
	end
	local toast = { };
	toast.toastType = toastType;
	toast.toastData = toastData;
	tremove(GlamourBNToasts, 1);
	tinsert(GlamourBNToasts, toast);
	Blizzard_BNToastFrame_AddToast(toastType, toastData);
end

function BNToastFrame_Show()
	if (not GlamourConfig["Settings"].BLIZ_BNToast_Scale) then
		Blizzard_BNToastFrame_Show();
		return;
	end
	local toastType = GlamourBNToasts[1].toastType;
	local toastData = GlamourBNToasts[1].toastData;
	if ( toastType == BN_TOAST_TYPE_BROADCAST ) then
		local presenceID, givenName, surname, isBattleTagPresence, toonName, toonID, client, isOnline, lastOnline, isAFK, isDND, messageText = BNGetFriendInfoByID(toastData);
		if(strlen(messageText) < 20) then
			BNToastFrame:SetWidth(BN_TOAST_MAX_LINE_WIDTH);
			BNToastFrameBottomLine:SetHeight(20);
			Blizzard_BNToastFrame_Show();
			return;
		else
			BNToastFrame_RemoveToast(toastType, toastData);
			tremove(GlamourBNToasts, 1);
			local topLine = BNToastFrameTopLine;
			local middleLine = BNToastFrameMiddleLine;
			local bottomLine = BNToastFrameBottomLine;

			if ( not messageText or messageText == "" ) then
				return;
			end	

			BNToastFrameIconTexture:SetTexCoord(0, 0.25, 0, 0.5);
			topLine:Show();
			topLine:SetFormattedText(BATTLENET_NAME_FORMAT, givenName, surname);
			topLine:SetTextColor(FRIENDS_BNET_NAME_COLOR.r, FRIENDS_BNET_NAME_COLOR.g, FRIENDS_BNET_NAME_COLOR.b);
			bottomLine:Show();
			BNToastFrame:SetWidth((BN_TOAST_MAX_LINE_WIDTH * 2) + 10);
			bottomLine:SetWidth(0);
			bottomLine:SetText(messageText);
			bottomLine:SetWidth(BNToastFrame:GetWidth() - 33);		
			bottomLine:SetTextColor(FRIENDS_GRAY_COLOR.r, FRIENDS_GRAY_COLOR.g, FRIENDS_GRAY_COLOR.b);
			BNToastFrameDoubleLine:Hide();
			middleLine:Hide();

			bottomLine:SetPoint("TOPLEFT", topLine, 0, -4);
			bottomLine:SetHeight(53);
			BNToastFrame:SetHeight(63);
	
			local frame = BNToastFrame;
			BNToastFrame_UpdateAnchor(true);
			frame:Show();
			PlaySoundKitID(18019);
			frame.toastType = toastType;
			frame.toastData = toastData;
			frame.animIn:Play();
			BNToastFrameGlowFrame.glow.animIn:Play();
			frame.waitAndAnimOut:Stop();	--Just in case it's already animating out, but we want to reinstate it.
			if ( frame:IsMouseOver() ) then
				frame.waitAndAnimOut.animOut:SetStartDelay(1);
			else
				frame.waitAndAnimOut.animOut:SetStartDelay(frame.duration);
				frame.waitAndAnimOut:Play();
			end
		end
	else
		Blizzard_BNToastFrame_Show();
	end
end

function BNToastTest()
	local topLine = BNToastFrameTopLine;
	local bottomLine = BNToastFrameBottomLine;

		local presenceID, toonID, currentBroadcast, bnetAFK, bnetDND  = BNGetInfo();
		local hasFocus, toonName, client, realmName, faction, race, class, guild, zoneName, level, gameText = BNGetToonInfo(presenceID);

		local givenName = "BNET";
		local surname = "Test Alert";
		local isOnline = true;
		local lastOnline = 0;
		local messageText = "";

		BNToastFrameIconTexture:SetTexCoord(0, 0.25, 0, 0.5);
		topLine:Show();
		topLine:SetFormattedText(BATTLENET_NAME_FORMAT, givenName, surname);
		topLine:SetTextColor(FRIENDS_BNET_NAME_COLOR.r, FRIENDS_BNET_NAME_COLOR.g, FRIENDS_BNET_NAME_COLOR.b);
		bottomLine:Show();
		bottomLine:SetWidth(0);
		bottomLine:SetText(messageText);
		if ( bottomLine:GetWidth() > BN_TOAST_MAX_LINE_WIDTH ) then
			bottomLine:SetWidth(BN_TOAST_MAX_LINE_WIDTH);
			BNToastFrame.tooltip = messageText;
		end
		bottomLine:SetTextColor(FRIENDS_GRAY_COLOR.r, FRIENDS_GRAY_COLOR.g, FRIENDS_GRAY_COLOR.b);
		BNToastFrameDoubleLine:Hide();

	local frame = BNToastFrame;
	BNToastFrame_UpdateAnchor(true);
	frame:Show();
	PlaySoundKitID(18019);
	frame.toastType = 3;
	frame.toastData = toastData;
	frame.animIn:Play();
	BNToastFrameGlowFrame.glow.animIn:Play();
	frame.waitAndAnimOut:Stop();	--Just in case it's already animating out, but we want to reinstate it.
	if ( frame:IsMouseOver() ) then
		frame.waitAndAnimOut.animOut:SetStartDelay(1);
	else
		frame.waitAndAnimOut.animOut:SetStartDelay(frame.duration);
		frame.waitAndAnimOut:Play();
	end
end

Blizzard_GuildChallengeAlertFrame_FixAnchors = GuildChallengeAlertFrame_FixAnchors;

function GuildChallengeAlertFrame_FixAnchors()
	GuildChallengeAlertFrame:ClearAllPoints();
	if (GlamourConfig["Settings"].BLIZ_GCAlert) then
	
		if ( DungeonCompletionAlertFrame1:IsShown() and GlamourConfig["Settings"].BLIZ_DCAlert ) then
				if (GlamourConfig["Settings"].RevOrder) then
					GuildChallengeAlertFrame:SetPoint("BOTTOM",  DungeonCompletionAlertFrame1, "TOP");
				else
					GuildChallengeAlertFrame:SetPoint("TOP",  DungeonCompletionAlertFrame1, "BOTTOM");
				end
			return;
		end	

		for i=GlamourFrameLimit, 1, -1 do
			local frame = _G["GlamourAlertFrame"..i];
			if ( frame and frame:IsShown() ) then
				if (GlamourConfig["Settings"].RevOrder) then
					GuildChallengeAlertFrame:SetPoint("BOTTOM", frame, "TOP");
				else
					GuildChallengeAlertFrame:SetPoint("TOP", frame, "BOTTOM");
				end
				return;
			end
		end
		GuildChallengeAlertFrame:SetPoint("CENTER", GlamourAnchor, "CENTER");
	else
		Blizzard_GuildChallengeAlertFrame_FixAnchors();
	end
end

-- PARSES COMMAND-LINE PARAM AND CALLS PROPER FUNCTIONS
function Glamour_GetCmd(cmd)
	if cmd then
		local param = nil;
		local a,b,c = string.find(cmd,"^(%S+)")
		if c and # cmd ~= # c then
			param = string.trim(string.sub(cmd, b+2));
		end
		if c == "replay" then
			local a1, a2, a3, a4, a5 = GetLatestCompletedAchievements();
			ToggleAchievementFrame();
			ToggleAchievementFrame();
			AchievementAlertFrame_ShowAlert(a1);
			AchievementAlertFrame_ShowAlert(a2);
			AchievementAlertFrame_ShowAlert(a3);
			AchievementAlertFrame_ShowAlert(a4);
			AchievementAlertFrame_ShowAlert(a5);
		elseif c == "fake" and param then
			if (GetAchievementLink(param)) then
				ToggleAchievementFrame();
				ToggleAchievementFrame();
				AchievementAlertFrame_ShowAlert(param);
			else
				print(param.." is an invalid achievement id.");
			end
		elseif c == "showall" then
			local name, frame;
			for i=1, GlamourFrameLimit do
				name = "GlamourAlertFrame"..i;
				frame = _G[name];
				if ( frame ) then
					frame:Show();
				end
			end
			DungeonCompletionAlertFrame1:Show();
			GuildChallengeAlertFrame:Show();
			BNToastFrame:Show();
			AlertFrame_FixAnchors();
		elseif c == "showlast" then
			if(GlamourLastFrame) then
				GlamourLastFrame:Show();
			else
				print("No frame to show.");
			end
		elseif c == "sample" then
			GlamourAlertSample(param)
		elseif c == "test" then
			ToggleAchievementFrame();
			ToggleAchievementFrame();
			AchievementAlertFrame_ShowAlert(5010);
			AchievementAlertFrame_ShowAlert(5000);
			Glamour_DungeonCompletionAlertFrame_ShowAlert();
			GuildChallengeAlertFrame_ShowAlert(1,1,1);
			BNToastTest();
		elseif c == "testalert" then
			GlamourAlertSample(param);
		elseif c == "config" or 
			c == "conf" then
			InterfaceOptionsFrame_OpenToCategory(Glamour_NAME.." v"..Glamour_VERSION);
		elseif c == "styles" then
			print("The following style options are available:");
			print("Achievement -This is the default style. ");
			print("GuildAchievement -This is the Blizzard guild achievement style.");
			print("Notice -This is plain single line of text style.");
		elseif c == "anchor" or 
			c == "anch" then
			GlamourAnchor:Show();
		else
			print(Glamour_NAME.." v"..Glamour_VERSION.." Slash Command List:");
			print(Glamour_NAME.." responds to both /glam and /glamour in the following ways.");
			print("/glamour anchor -This will show the draggable anchor.");
			print("/glamour config -Open the config menu.");
			print("/glamour fake AchID -Runs a fake alert for specified Achievement ID.");
			print("/glamour showall -Unhide all alert frames.");
			print("/glamour showlast -Unhide the last alert frame.");
			print("/glamour replay -Shows alerts for the last 5 achievements you've completed.");
			print("/glamour test -Display the test alerts.");
			print("/glamour sample <style> -Display the sample alerts. <style> is optional.");
			print("/glamour styles -List all known styles.");
			print("/glamour help -Print this help text.");
		end
	end
end


-- SLASH COMMAND DECLARATION
SLASH_GLAMOUR1 = "/glamour";
SLASH_GLAMOUR2 = "/glam";
SlashCmdList["GLAMOUR"] = Glamour_GetCmd

