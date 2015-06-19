local _G = _G
local Loremaster, GameTooltip = Loremaster, GameTooltip
local L = Loremaster.L
local ttwaypoints = {}
local ipairs, pairs, table = ipairs, pairs, table
local UIParent, CreateFrame = UIParent, CreateFrame
local PlaySoundFile = PlaySoundFile
local GetQuestID = GetQuestID
local TomTom = TomTom
--local LoremasterInfoFrame, LoremasterMainFrame
local LoremasterInfoFrame
local StaticPopup_Show = StaticPopup_Show

local function clearTT()
	local uid
	for _, uid in ipairs(ttwaypoints) do TomTom:RemoveWaypoint(uid) end
end

local function showTT()
--	local zone, entry, zid, uid
--	local c, z, x, y, desc --, persistant, minimap, world
	
	clearTT()
	--code based on TomTom's own code
	--Find a match for the zone
	if LoremasterInfoFrame.qid then
--		zone = LoremasterInfoFrame.z:lower():gsub("[%L]", "")
--		for z, entry in pairs(Loremaster.zlist) do
--			if z:match(zone) then
--				c = entry[1]
--				zid = entry[2]
--				break
--			end
--		end
--		x = LoremasterInfoFrame.x
--		y = LoremasterInfoFrame.y
--		z = zid
--		desc = LoremasterInfoFrame.target
--		persistant = false
--		minimap = true
--		world = true
--		uid = TomTom:AddZWaypoint(c, z, x, y, desc, persistant, minimap, world)
		uid = TomTom:AddMFWaypoint(LoremasterInfoFrame.mapArea, LoremasterInfoFrame.mapLevel, LoremasterInfoFrame.x/100, LoremasterInfoFrame.y/100,
			{	persistent = false,
				minimap = true,
				world = true,
				title = LoremasterInfoFrame.target,
			})
		table.insert(ttwaypoints, uid)
	end
end

local function showLH()
	local lmrightedge = Loremaster.db.profile.x + 600
	local uirightedge = UIParent:GetWidth()

	if LightHeadedFrame:IsVisible() then
		LightHeadedFrame:Hide()
		return
	end

	if LoremasterInfoFrame.qid then
		--show on the right of the current frame if it will fit
		--otherwise, show it on the left
		LightHeadedFrame:ClearAllPoints()
		LightHeadedFrame:SetParent(Loremaster.MainFrame)

		if uirightedge - lmrightedge < 325 then
			--attach to left
			LightHeadedFrame:SetPoint("RIGHT", Loremaster.MainFrame, "LEFT", 0, 0)
		else
			--attach to right
			LightHeadedFrame:SetPoint("LEFT", Loremaster.MainFrame, "RIGHT", 0, 0)
		end

		LightHeadedFrame:Show()
		LightHeaded:UpdateFrame(LoremasterInfoFrame.qid, 1)
	end
end

local function showWH()
	if LoremasterInfoFrame.qid then
		Loremaster.WHtext = "http://www.wowhead.com/quest=" .. LoremasterInfoFrame.qid
		StaticPopup_Show("LOREMASTER_WOWHEAD")
	end
end

function Loremaster:CreateQuestFrame()
	local frame = CreateFrame("Frame", "LoremasterMainFrame", UIParent)
	Loremaster.MainFrame = frame
	local continentframe, zoneframe, questframe --, storyframe
	local infoframe = CreateFrame("Frame", "LoremasterInfoFrame", frame)
	local titleframe = CreateFrame("Frame", nil, frame)
	local titlelabel = titleframe:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	local continenttitle = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	local zonetitle = frame:CreateFontString("LoremasterZoneTitle", "ARTWORK", "GameFontNormal")
	--local storytitle
	local questtitle = frame:CreateFontString("LoremasterQuestTitle", "ARTWORK", "GameFontNormal")
	local infotitle = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	local infobox = infoframe:CreateFontString("LoremasterInfoBox", "ARTWORK", "GameFontNormal")
	local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
--	local resetButton = CreateFrame("Button", nil, frame)
	local white, offwhite = "|cffffffff", "|cffbababa"
	local whbutton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
	local ttbutton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
	local cttbutton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
	local x, y

	LoremasterInfoFrame = _G.LoremasterInfoFrame
--	LoremasterMainFrame = _G.LoremasterMainFrame

	local function frameOnShow()
		local v = GetAddOnMetadata("Loremaster", "Version")
		local forcerebuild = (self.db.profile.version ~= v)
		PlaySoundFile("Sound\\Interface\\iQuestLogOpenA.ogg")
		if (not LoremasterDB.Achievements) or self.rescan then self:achscan() end
		if forcerebuild or (not LoremasterDB.available) then
			if forcerebuild then self.db.profile.version = v end
			StaticPopup_Show("LOREMASTER_BUILD")
		end
	end

	local function frameOnHide()
		PlaySoundFile("Sound\\Interface\\iQuestLogCloseA.ogg")
		if self.LH then
			if self.db.profile.attachLH then
				if LightHeadedFrame then
					LightHeadedFrame:SetParent(QuestLogFrame)
					LightHeaded:LockUnlockFrame()
					LightHeaded:AdjustGUIParent()
				end
			end
		end
	end

	local function frameMouseUp()
		frame:StopMovingOrSizing()
		self.db.profile.x = frame:GetLeft()
		self.db.profile.y = frame:GetBottom()
	end

	frame:Hide()
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:EnableKeyboard(true)
	frame:SetClampedToScreen(true)
	frame:SetFrameStrata("MEDIUM")
	frame:SetFrameLevel(5)
	--frame:SetHeight(387)
	frame:SetHeight(400)
	frame:SetWidth(600)
	frame:SetBackdrop({bgFile = "Interface\\ACHIEVEMENTFRAME\\UI-GuildAchievement-Parchment-Horizontal-Desaturated", edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Gold-Border", edgeSize = 32, insets = {left = 4, right = 4, top = 4, bottom = 4}})
	frame:SetScript("OnMouseDown", function() frame:StartMoving() end)
	frame:SetScript("OnMouseUp", frameMouseUp)
	frame:SetScript("OnShow", frameOnShow)
	frame:SetScale(self.db.profile.scale)
	frame:SetScript("OnHide", frameOnHide)
	frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", self.db.profile["x"], self.db.profile["y"])
	frame:EnableMouseWheel(true)

	local function closeOnClick(self) Loremaster.MainFrame:Hide() end
	closeButton:SetScript("OnClick", closeOnClick)
	closeButton:SetPoint("TOPLEFT", frame, "TOPRIGHT", -40, -8)

--	local function resetOnEnter(this)
--		GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
--		GameTooltip:ClearLines()
--		GameTooltip:SetText(L["Loremaster"])
--		GameTooltip:AddLine(white .. L["Reset Loremaster"])
--		GameTooltip:Show()
--	end
--
--	resetButton:SetSize(24, 24)
--	resetButton:SetNormalTexture("Interface\\Buttons\\UI-RotationRight-Button-Up")
--	resetButton:SetPushedTexture("Interface\\Buttons\\UI-RotationRight-Button-Down")
--	resetButton:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Round", "ADD")
--	resetButton:SetPoint("TOPRIGHT", closeButton, "TOPLEFT", 0, -4)
--	resetButton:SetScript("OnClick", function() StaticPopup_Show("LOREMASTER_RESET") end)
--	resetButton:SetScript("OnEnter", resetOnEnter)
--	resetButton:SetScript("OnLeave", function() GameTooltip:Hide() end)

	titleframe:SetWidth(256)
	titleframe:SetHeight(64)
	titleframe:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 172, -50)
	titleframe:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Header"})

	titlelabel:SetWidth(256)
	titlelabel:SetHeight(64)
	titlelabel:SetPoint("CENTER", titleframe, "CENTER", 0, 12)
	titlelabel:SetText(L["Loremaster"])

	continentframe = self:createDisplayFrame(frame, "LoremasterContinentFrame", 6, 141, 244, self:getContinents())
	Loremaster.ContinentFrame = continentframe
	continentframe:SetPoint("TOPLEFT", frame, "TOPLEFT", 16, -46)
	self:updateScroll(continentframe)

	continenttitle:SetFormattedText("|T%s:%d|t%s", "Interface\\GossipFrame\\BinderGossipIcon", 16, L["Continent"])
	continenttitle:SetPoint("BOTTOMLEFT", continentframe, "TOPLEFT", 3, -2)
	
	zoneframe = self:createDisplayFrame(frame, "LoremasterZoneFrame", 6, 141, 324)
	Loremaster.ZoneFrame = zoneframe
	zoneframe:SetPoint("TOPLEFT", continentframe, "TOPRIGHT", 0, 0)
	zoneframe.data = {}
	self:updateScroll(zoneframe)

	self:updateZoneCount(-1)
	zonetitle:SetPoint("BOTTOMLEFT", zoneframe, "TOPLEFT", 0, -8)

	--[[
	storyframe = self:createDisplayFrame(frame, "LoremasterStoryFrame", 4, 104, 344)
	storyframe:SetPoint("TOPLEFT", continentframe, "BOTTOMLEFT", 0, -14)
	storytitle = storyframe:CreateFontString("LoremasterStoryTitle", "ARTWORK", "GameFontNormal")
	storytitle:SetPoint("BOTTOMLEFT", storyframe, "TOPLEFT", 0, -4)
	storyframe:Hide()
	]]--

	questframe = self:createDisplayFrame(frame, "LoremasterQuestFrame", 6, 145, 344)
	questframe:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 16, 50)
	questframe.data = {}
	self:updateScroll(questframe)
	self:updateQuestCount(-1)
	questtitle:SetPoint("BOTTOMLEFT", questframe, "TOPLEFT", 0, -2)

	infoframe:SetHeight(145)
	infoframe:SetWidth(224)
	infoframe:SetPoint("TOPLEFT", questframe, "TOPRIGHT", 0, 0)
	infoframe:SetBackdrop({bgFile = "Interface\\ACHIEVEMENTFRAME\\UI-Achievement-Parchment-Horizontal-Desaturated", edgeFile = "Interface\\LFGFrame\\LFGBorder", tile = false, tileSize = 16, edgeSize = 16, insets = {left = 4, right = 4, top = 4, bottom = 4}})

	infobox:SetWidth(212)
	infobox:SetHeight(133)
	infobox:SetPoint("TOPLEFT", infoframe, "TOPLEFT", 8, -8)
	infobox:SetPoint("BOTTOMRIGHT", infoframe, "BOTTOMRIGHT", -8, 8)

	infotitle:SetFormattedText("|T%s:%d|t%s", "Interface\\FriendsFrame\\InformationIcon", 16, L["Notes"])
	infotitle:SetPoint("BOTTOMLEFT", infoframe, "TOPLEFT", 3, -2)

	whbutton:SetHeight(32)
	whbutton:SetWidth(100)
	whbutton:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 16, 16)

	if self.LH then
		whbutton:SetText("LightHeaded")
		whbutton:SetScript("OnClick", showLH)
	else
		whbutton:SetText("Wowhead")
		whbutton:SetScript("OnClick", showWH)
	end

	ttbutton:SetHeight(32)
	ttbutton:SetWidth(200)
	ttbutton:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -16, 16)
	ttbutton:SetText(L["Set TomTom Waypoint"])
	ttbutton:SetScript("OnClick", showTT)
	self.tomTomButton = ttbutton

	cttbutton:SetHeight(32)
	cttbutton:SetWidth(200)
	cttbutton:SetPoint("RIGHT", ttbutton, "LEFT", -10, 0)
	cttbutton:SetText(L["Clear TomTom Waypoints"])
	cttbutton:SetScript("OnClick", clearTT)

	if not self.TT then
		ttbutton:Hide()
		cttbutton:Hide()
	end
end

--local qfcqborig = QuestFrameCompleteQuestButton:GetScript("OnClick")

--QuestFrameCompleteQuestButton:SetScript("OnClick", function(this, mouseButton, ...)
--	QuestRewardCompleteButton_OnClick()
--    --qfcqborig(this, mouseButton, ...)
--	Loremaster.qid = GetQuestID()
--	Loremaster:questComplete()
--end)

--	It seems when the Grail world and Loremaster are together, there is a possibility that
--	interaction causes failure with the above code.  Therefore, changing it to the Grail
--	notification system is the better way to go.
Loremaster._QuestCompleted = function(callbackType, questId)
	Loremaster.qid = tonumber(questId)
	Loremaster:questComplete()
end

Grail:RegisterObserverQuestComplete(Loremaster._QuestCompleted)
