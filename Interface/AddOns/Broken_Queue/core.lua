--[[
	Broker LFD
		"Moving the LFD Frame, one element at a time"
]]--
local addonName, ns = ...
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local LibLDB = LibStub("LibDataBroker-1.1", true)
assert(LibLDB, "LDB Not Found")

local ldb

local modetrans = {
	["lfgparty"] = L["LFG Party"],
	["abandonedInDungeon"] = L["Left In Dungeon"],
--	["queued"] = L["Queued"],
--	["empowered"] =  L["Waiting"],
	["unempowered"] = L["Waiting for more"],
--	["unaccepted"] = L["Waiting"],
	["proposal"] = L["Queue Pop"],
	["accepted"] = L["Forming Group"],
	["rolecheck"] = L["Role Check"],
	["notQueued"] = L["Not Queued"],
--PVP Status
	["confirm"] = L["Queue Pop"],
	["active"] = L["In BG"],
}

local need, dontNeed = ("|cffFF3300%s|r"), ("|cff33FF00%s|r")
local leader_A, leader_B =  need:format(LEADER), dontNeed:format(LEADER)
local tank_A, tank_B  = need:format(TANK), dontNeed:format(TANK)
local healer_A, healer_B = need:format(HEALER), dontNeed:format(HEALER)
local dps_A, dps_B = need:format(DAMAGE), dontNeed:format(DAMAGE)
local needingFormat = "%s / %s / %s / %s"

local tankShortA, tankShortB = need:format("T"), dontNeed:format("T")
local healerShortA, healerShortB = need:format("H"), dontNeed:format("H")
local dpsShortA, dpsShortB = need:format("D"), dontNeed:format("D")

local shortNeedFormat = "%s%s%s%s"
local function updateLDBText()
	if not ldb then return end
	local bgStatusA, bgNameA = GetBattlefieldStatus(1)
	local bgStatusB, bgNameB = GetBattlefieldStatus(2)
	local bgWaitA, bgWaitB = GetBattlefieldTimeWaited(1), GetBattlefieldTimeWaited(2)

	local text = ""
	if GetLFGMode() then
		local status,substat = GetLFGMode()
		if status and modetrans[status] then
			text = modetrans[status]
		end

		local hasData, _, tankNeeds, healerNeeds, dpsNeeds, _, _, _, _, _, _, _, queuedAt= GetLFGQueueStats()
		if hasData then
			local dpsA = dpsShortA:rep(dpsNeeds)
			local dpsB = dpsShortB:rep(3-dpsNeeds)
			text = text.." "..shortNeedFormat:format( (tankNeeds ~= 0 and tankShortA or tankShortB),
			(healerNeeds ~= 0 and healerShortA or healerShortB), dpsA, dpsB )
		end

		substat = (substat or ""):trim()
		if substat ~= "" and modetrans[substat] then
			text = text.." - "..modetrans[substat]
		end
		
		if queuedAt then
			local timeInQueue = "("..SecondsToTime( GetTime()-(queuedAt or 0), BrokenLFDdb and BrokenLFDdb.noSecondsTime )..")"
			if timeInQueue ~= "()" then
				text = text.." "..timeInQueue
			else
				text = text.." (<1 min)"
			end
		end
	---LFG and Battlegrounds are mutually exclusive, so no need to worry about steping on toes
	elseif bgStatusA ~= "none" or bgStatusB ~= "none" then
		
		if bgStatusA == "confirm" or bgStatusB == "confirm" then
			text = modetrans["confirm"].." ".. ( (bgStatusA == "conferm" and bgNameA) or (bgStatusB == "conferm" and bgNameB) or "" )
		elseif bgStatusA == "queued" or bgStatusB == "queued" then		--if either are queued, show heighest
			if bgWaitA > bgWaitB then
				local timeInQueue = "("..SecondsToTime(GetBattlefieldTimeWaited(1)/1000, BrokenLFDdb and BrokenLFDdb.noSecondsTime)..")"
				if timeInQueue ~= "()" then
					text = (bgNameA or "").." "..timeInQueue
				else
					text = (bgNameA or "").." (<1 min)"
				end
			else
				local timeInQueue = "("..SecondsToTime(GetBattlefieldTimeWaited(2)/1000, BrokenLFDdb and BrokenLFDdb.noSecondsTime)..")"
				if timeInQueue ~= "()" then
					text = (bgNameB or "").." "..timeInQueue
				else
					text = (bgNameB or "").." (<1 min)"
				end
			end
		elseif bgStatusA == "active" or bgStatusB == "active" then
			text = modetrans["active"].." "..( (bgStatusA == "active" and bgNameA) or (bgStatusB == "active" and bgNameB) or "" )
		end
	end
	if text == "" then
		text = modetrans["notQueued"]
	end

	
	ldb.text = text
end


local function OnTooltipShow(self,...)
	self:AddLine(L["Broken Queue"])

	local status,substat = GetLFGMode()
	local bgStatus, bgName = GetBattlefieldStatus(1)
	local hasData, leaderNeeds, tankNeeds, healerNeeds, dpsNeeds, instanceType, instanceName, averageWait, tankWait, healerWait, damageWait, myWait, queuedAt = GetLFGQueueStats()

	local bgStatusA, bgNameA = GetBattlefieldStatus(1)
	local bgStatusB, bgNameB = GetBattlefieldStatus(2)
	local bgWaitA, bgWaitB = GetBattlefieldTimeWaited(1)/1000, GetBattlefieldTimeWaited(2)/1000

	if hasData then
		self:AddLine(" ")
		self:AddLine(LOOKING_FOR_DUNGEON)
		self:AddLine(" ")
		self:AddLine(QUEUED_FOR:format(instanceName))
		self:AddLine(" ")
		self:AddLine(LOOKING_FOR)
		local needing = needingFormat:format( (leaderNeeds and leader_A or leader_B), (tankNeeds ~= 0 and tank_A or tank_B),
			(healerNeeds ~= 0 and healer_A or healer_B), (dpsNeeds ~= 0 and dps_A or dps_B) )
		self:AddLine("    "..needing)
		self:AddLine(" ")
		self:AddLine(LFG_STATISTIC_AVERAGE_WAIT:format(SecondsToTime(averageWait, BrokenLFDdb and BrokenLFDdb.noSecondsTime) ) )
		tankWait = SecondsToTime(tankWait, BrokenLFDdb and BrokenLFDdb.noSecondsTime)
		tainWait = tankWait ~= "" and tankWait or "<1 min"
		healerWait = SecondsToTime(healerWait, BrokenLFDdb.noSecondsTime)
		tainWait = healerWait ~= "" and healerWait or "<1 min"
		damageWait = SecondsToTime(damageWait, BrokenLFDdb.noSecondsTime)
		tainWait = damageWait ~= "" and damageWait or "<1 min"

		self:AddDoubleLine(TANK, tankWait ~= "" and tankWait or UNKNOWN )
		self:AddDoubleLine(HEALER, healerWait ~= "" and healerWait or UNKNOWN )
		self:AddDoubleLine(DAMAGE, damageWait ~= "" and damageWait or UNKNOWN )

		if queuedAt and BrokenLFDdb.showToolTipTime then
			self:AddLine(" ")
			self:AddLine(TIME_IN_QUEUE:format( SecondsToTime( GetTime()-(queuedAt or 0), BrokenLFDdb.noSecondsTime ) ) )
		end
	elseif bgStatusA ~= "none" or bgStatusB ~= "none" then
		self:AddLine(" ")
		if bgStatusA ~= "none" then	--BG 1 is queued
			self:AddLine(bgNameA)
			local waitTime = GetBattlefieldEstimatedWaitTime(1)/1000
			self:AddLine("    "..LFG_STATISTIC_AVERAGE_WAIT:format(SecondsToTime(waitTime, BrokenLFDdb and BrokenLFDdb.noSecondsTime) ) )
			self:AddLine("    "..TIME_IN_QUEUE:format( SecondsToTime( (bgWaitA or 0), BrokenLFDdb.noSecondsTime ) ) )
		end
		if bgStatusB ~= "none" then	--BG 2 is queued
			self:AddLine(bgNameB)
			local waitTime = GetBattlefieldEstimatedWaitTime(2)/1000
			self:AddLine("    "..LFG_STATISTIC_AVERAGE_WAIT:format(SecondsToTime(waitTime, BrokenLFDdb and BrokenLFDdb.noSecondsTime) ) )
			self:AddLine("    "..TIME_IN_QUEUE:format( SecondsToTime( (bgWaitB or 0), BrokenLFDdb.noSecondsTime ) ) )
		end
	end
	updateLDBText()
end

local function GetAnchors(frame)
	local x, y = frame:GetCenter()
	local leftRight
	if x < GetScreenWidth() / 2 then
		leftRight = "LEFT"
	else
		leftRight = "RIGHT"
	end
	if y < GetScreenHeight() / 2 then
		return "BOTTOM", "TOP"
	else
		return "TOP", "BOTTOM"
	end
end

local function PrepareTooltip(frame, anchorFrame)
	if frame and frame.SetOwner and anchorFrame then
		frame:SetOwner(anchorFrame, "ANCHOR_NONE")
		frame:ClearAllPoints()
		local a1, a2 = GetAnchors(anchorFrame)
		frame:SetPoint(a1, anchorFrame, a2)
	end
end

local mouseIsOverLDB = false
local function OnEnter(self, ...)	--GameTooltip
	PrepareTooltip(GameTooltip, self)
	mouseIsOverLDB = true
	OnTooltipShow(GameTooltip)
	GameTooltip:Show()
end
local function OnLeave(self, ...)
	mouseIsOverLDB = false
	GameTooltip:Hide()
end
local function gt_onUpdateHack(self)
	if mouseIsOverLDB then
		self:ClearLines()
		OnTooltipShow(self)
		self:Show()
	end
end
GameTooltip:HookScript("OnUpdate", gt_onUpdateHack)

local function OnClick(self, button)
	local mode, submode = GetLFGMode()
	local bgStatusA, bgStatusB = GetBattlefieldStatus(1), GetBattlefieldStatus(2)
	if button == "LeftButton" then
		if bgStatusA ~= "none" or bgStatusB ~= "none" then
			TogglePVPFrame()
			if PVPParentFrame:IsShown() then
				PVPParentFrameTab2:Click()
			end
		elseif (mode == "lfgparty" or mode == "abandonedInDungeon") then
			local point, relPoint = GetAnchors(self)
			MiniMapLFGFrameDropDown.point = point
			MiniMapLFGFrameDropDown.relativePoint = relPoint
			MiniMapLFGFrameDropDown:SetClampedToScreen(true)
			ToggleDropDownMenu(1, nil, MiniMapLFGFrameDropDown, self, 0, 0)
		elseif ( mode == "proposal" ) then
			if ( not LFDDungeonReadyPopup:IsShown() ) then
				PlaySound("igCharacterInfoTab")
				StaticPopupSpecial_Show(LFDDungeonReadyPopup)
			end
		elseif ( mode == "queued" or mode == "rolecheck" ) then
			ToggleLFDParentFrame()
		elseif ( mode == "listed" ) then
			ToggleLFRParentFrame()
		else
			ToggleLFDParentFrame()
		end
	end
	if button == "RightButton" then
		if not mode then	--It's BG Time!
			if bgStatusA == "none" and bgStatusB == "none" then
				TogglePVPFrame()
				if PVPParentFrame:IsShown() then
					PVPParentFrameTab2:Click()
				end
			elseif bgStatus ~= "none" then
				local point, relPoint = GetAnchors(self)
				MiniMapBattlefieldDropDown.point = point
				MiniMapBattlefieldDropDown.relativePoint = relPoint
				MiniMapBattlefieldDropDown:SetClampedToScreen(true)
				ToggleDropDownMenu(1, nil, MiniMapBattlefieldDropDown, self, 0, 0)
			end
		elseif mode then
			if ( button == "RightButton" or mode == "lfgparty" or mode == "abandonedInDungeon") then
				local point, relPoint = GetAnchors(self)
				MiniMapLFGFrameDropDown.point = point
				MiniMapLFGFrameDropDown.relativePoint = relPoint
				MiniMapLFGFrameDropDown:SetClampedToScreen(true)
				ToggleDropDownMenu(1, nil, MiniMapLFGFrameDropDown, self, 0, 0)
			elseif ( mode == "proposal" ) then
				if ( not LFDDungeonReadyPopup:IsShown() ) then
					PlaySound("igCharacterInfoTab")
					StaticPopupSpecial_Show(LFDDungeonReadyPopup)
				end
			elseif ( mode == "queued" or mode == "rolecheck" ) then
				ToggleLFDParentFrame()
			elseif ( mode == "listed" ) then
				ToggleLFRParentFrame()
			else
				ToggleLFDParentFrame()
			end
		end
	end
	updateLDBText()
end
local function createLDB()
	ldb = {
		type = "data source",
		text = modetrans["notQueued"] or "",
		label = addonName,
		icon = "Interface\\ICONS\\INV_Misc_GroupNeedMore",
		OnEnter = OnEnter,
		OnLeave = OnLeave,
--		OnTooltipShow = OnTooltipShow,
		OnClick = OnClick,
	}
	ldb = LibLDB:NewDataObject("Looking for Dungeon", ldb)
end

local frame = CreateFrame("frame")
frame:SetScript("OnEvent", function(self, event, ...)
	if (event == "PLAYER_ENTERING_WORLD") or (event == "ADDON_LOADED" and ... == addonName) then
		BrokenLFDdb = BrokenLFDdb or {	--Setup Defaults
			showIdleText = true,
			showToolTipTime = true,
			noSecondsTime = false,
			showMiniMap = false,
		}	
		if not BrokenLFDdb.showIdleText then	--Adjust for Defaults
			modetrans["lfgparty"] = ""
			modetrans["notQueued"] = ""
		end
		if BrokenLFDdb.showMiniMap then		--Toggle Minimap
			MiniMapLFGFrame:Show()
		else
			MiniMapLFGFrame:Hide()
		end

		createLDB()

		self:SetScript("OnEvent", function(selfA, eventA, ...)
			local bgStatusA, bgStatusB = GetBattlefieldStatus(1), GetBattlefieldStatus(2)
			--LFD Stuff
			if GetLFGMode() then
				selfA:Show()
				if GetLFGMode() == "lfgparty" then
					selfA:Hide()
				end
			--Battleground Stuff
			elseif bgStatusA ~= "none" or bgStatusB ~= "none" then
				selfA:Show()
			else

				selfA:Hide()
			end

			updateLDBText()
		end
		)
	end
end)
local delay, interval = 1,1
frame:SetScript("OnUpdate", function(self, elapsed)
	delay = delay + elapsed
	if delay > interval then
		updateLDBText()
	end
end)
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("LFG_UPDATE")
frame:RegisterEvent("LFG_ROLE_CHECK_UPDATE")
frame:RegisterEvent("LFG_PROPOSAL_UPDATE")
frame:RegisterEvent("LFG_QUEUE_STATUS_UPDATE")
frame:RegisterEvent("LFG_ROLE_CHECK_SHOW")
frame:RegisterEvent("LFG_ROLE_CHECK_HIDE")
frame:RegisterEvent("UPDATE_BATTLEFIELD_STATUS");

MiniMapLFGFrame:Hide()
do
	MiniMapLFGFrame:SetScript("OnShow", function(self,...)
		if GetLFGMode() then
			if not BrokenLFDdb.showMiniMap then
				self:Hide()
			end
		else
			self:Hide()
		end
	end)
	MiniMapLFGFrame:SetScript("OnHide", function(self,...)
		if GetLFGMode() then
			if BrokenLFDdb.showMiniMap then
				self:Show()
			end
		else
			self:Hide()
		end
	end)
end

SLASH_BLFD1 = "/blfd"
SlashCmdList["BLFD"] = function(msg, editBox)
	msg = msg:lower():trim()
	if msg == "default" then
		BrokenLFDdb.showIdleText = true
		BrokenLFDdb.showToolTipTime = true
		BrokenLFDdb.noSecondsTime = false
		modetrans["lfgparty"] = L["LFG Party"]
		modetrans["notQueued"] = L["Not Queued"]
		print("BrokerLFD: ", L["Reset Options to Default"])

	elseif msg == "showidletext" then
		BrokenLFDdb.showIdleText = not BrokenLFDdb.showIdleText
		if BrokenLFDdb.showIdleText then
			modetrans["lfgparty"] = L["LFG Party"]
			modetrans["notQueued"] = L["Not Queued"]
			print("BrokerLFD: ", L["Idle Text Enabled"])
		else
			modetrans["lfgparty"] = ""
			modetrans["notQueued"] = ""
			print("BrokerLFD: ", L["Idle Text Disabled"])
		end			

	elseif msg == "showtooltiptime" then
		BrokenLFDdb.showToolTipTime = not BrokenLFDdb.showToolTipTime
		print("BrokerLFD: ", BrokenLFDdb.showToolTipTime and L["Showing Time in Queue on Tooltip"] or L["Hiding Time in Queue on Tooltip"] )

	elseif msg == "noseconds" then
		BrokenLFDdb.noSecondsTime = not BrokenLFDdb.noSecondsTime
		print("BrokerLFD: ", BrokenLFDdb.noSecondsTime and L["Hiding Seconds"] or L["Showing Seconds"] )

	elseif msg == "toggleicon" then
		BrokenLFDdb.showMiniMap = not BrokenLFDdb.showMiniMap
		if BrokenLFDdb.showMiniMap then
			MiniMapLFGFrame:Show()
			print("BrokerLFD: ", L["Showing Minimap Icon"])
		else
			MiniMapLFGFrame:Hide()
			print("BrokerLFD: ", L["Hiding Minimap Icon"])
		end
	else
		print(L["Broken_Queue Options"])
		print(L[" /blfd ShowIdleText  => Toggle showing text when not doing something"])
		print(L[" /blfd ShowTooltipTime => Toggle showing time in queue in tooltip"])
		print(L[" /blfd NoSeconds => toggle showing seconds everywhere"])
		print(L[" /blfd default => reset to defaults"])
		print(L[" /blfd toggleicon => toggle minimap icon"])
		print(L["Commands are not case sensitive"])
	end
	updateLDBText()
end
