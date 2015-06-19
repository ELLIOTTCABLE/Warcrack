local Loremaster = Loremaster
local L = Loremaster.L
local markers = {}
local zonemarkers = {}
local mapzones = {}
local GetCurrentMapContinent, GetMapZones = GetCurrentMapContinent, GetMapZones
local GetMapInfo, GetCurrentMapZone = GetMapInfo, GetCurrentMapZone
local GetCurrentMapAreaID, GetCurrentMapDungeonLevel = GetCurrentMapAreaID, GetCurrentMapDungeonLevel
local ipairs, table, tonumber, CreateFrame = ipairs, table, tonumber, CreateFrame
local wipe, select, tostring, pairs = wipe, select, tostring, pairs

--update marker textures
function Loremaster:UpdateMarkerTextures()
	local marker, _
	local c = self.icons[self.db.profile.mapicon]
	for _, marker in ipairs(zonemarkers) do marker.texture:SetTexCoord(c[1], c[2], c[3], c[4]) end
	for _, marker in ipairs(markers) do marker.texture:SetTexCoord(c[1], c[2], c[3], c[4]) end
end

--create a new marker
local function createMarker()
	local frame = CreateFrame("Frame")
	local c = Loremaster.icons[Loremaster.db.profile.mapicon]
	frame.texture = frame:CreateTexture()
	frame.texture:SetTexture("Interface\\MINIMAP\\TRACKING\\OBJECTICONS")
	frame.texture:SetAllPoints()
	frame:SetSize(16, 16)
	frame.x = 0
	frame.y = 0
	frame.npc = ""
	frame.texture:SetTexCoord(c[1], c[2], c[3], c[4])
	table.insert(markers, frame)
	return frame
end

--return a marker, recycling old ones if possible
local function getMarker()
	local marker, m, _
	for _, m in ipairs(markers) do
		if not m.inuse then
			marker = m
			break
		end
	end
	marker = marker or createMarker()
	marker.inuse = true
	return marker
end

--reset an unused marker
function Loremaster:ClearMarker(marker, all)
	local m, _
	if all then
--		for _, m in ipairs(markers) do
		for _, m in pairs(markers) do
			m:Hide()
			m:ClearAllPoints()
			m.x = 0
			m.y = 0
			m.npc = ""
			m.inuse = false
		end
	else
		marker:Hide()
		marker.x = 0
		marker.y = 0
		marker.npc = ""
		marker.inuse = false
	end
end

--build a table of markers for the required zone
local function buildZoneMarkers(zone)
	local qs, x, y, z, l
	local m, f, _

	wipe(zonemarkers)
	Loremaster:ClearMarker(nil, true)

	local quests = Grail:QuestsInMap(zone, false, true) or {}	-- only Loremaster quests for this zone
	local questStatus, possibleNPCs, locations, npc
	if #quests > 0 then
		for _, qid in pairs(quests) do
			questStatus = Grail:StatusCode(qid)
			if bit.band(questStatus, Grail.bitMaskQuestFailureWithAncestor + Grail.bitMaskCompleted) == 0 and not Grail:IsQuestObsolete(questId) and not Grail:IsQuestPending(questId) then
				possibleNPCs = Grail:QuestNPCPrerequisiteAccepts(qid)
				if nil == possibleNPCs then
					possibleNPCs = Grail:QuestNPCAccepts(qid)
				end
				if nil ~= possibleNPCs then
					locations = Grail:NPCLocations(possibleNPCs[1])
					if nil ~= locations then
						npc = locations[1]
						x = npc.x or 0
						y = npc.y or 0
						--check there is no marker at this point and add one if necessary
						for _, m in ipairs(zonemarkers) do
							if (m.x == x) and (m.y == y) then
								f = true
								break
							end
						end
						if not f then
							m = getMarker()
							m.x = x
							m.y = y
							m.npc = npc.name or ""
							table.insert(zonemarkers, m)
						end
						f = nil
					end
				end
			end
		end
	end
end

--display markers for the current zone on the map
local function markerOnEnter(this)
	local tt = Loremaster.tooltip
	if nil ~= tt then
	tt:SetOwner(this, "ANCHOR_TOP")
	tt:ClearLines()
	tt:SetText("|cffffffff" .. L["Loremaster"])
	tt:AddLine(this.npc)
	tt:Show()
	end
end

function Loremaster:ShowZoneMarkers()
	buildZoneMarkers(GetCurrentMapAreaID())
	if #zonemarkers > 0 then
		--display markers on the map
		for _, marker in ipairs(zonemarkers) do
			marker:SetParent(WorldMapDetailFrame)
			marker:SetPoint("CENTER", WorldMapDetailFrame, "TOPLEFT", marker.x /100 * WorldMapDetailFrame:GetWidth(), -marker.y / 100 * WorldMapDetailFrame:GetHeight())
			marker:SetScript("OnEnter", markerOnEnter)
			marker:SetScript("OnLeave", function() if Loremaster.tooltip then Loremaster.tooltip:Hide() end end)
			marker:SetFrameLevel(marker:GetFrameLevel() + 2)
			marker:Show()
		end
	end
end

local function checkMapName(name)
	local mnames = {"Kalimdor", "Azeroth", "Expansion01", "Northrend", "TheMaelstromContinent", "Pandaria"}
	local n, o
	o = true
	for _, n in ipairs(mnames) do
		if (name or "Kalimdor") == n then
			o = false
			break
		end
	end
	return o
end

local function maphook(...)
	if not Loremaster.db then return end
	if Loremaster.disablehook then return end
--	if not Loremaster.c then Loremaster.c=0 end
	local cmz, cmc, mid
	local mname = GetMapInfo()
	if not checkMapName(mname) then return end
	if Loremaster.db.profile.showinconmap then
--		mid = GetCurrentMapAreaID()
--		if mid ~= Loremaster.mid then
--			Loremaster.c = Loremaster.c+1
			cmz = GetCurrentMapZone()
--			cmc = GetCurrentMapContinent()
--			Loremaster.mid = mid
			if cmz ~= 0 and GetCurrentMapDungeonLevel() == 0 then Loremaster:ShowZoneMarkers()
			else Loremaster:ClearMarker(nil, true) end
--		end
	end
end

hooksecurefunc("WorldMapFrame_Update", maphook)

local function zoomhook(...)
	Loremaster:ClearMarker(nil, true)
	Loremaster.disablehook = true
end

if Grail.blizzardRelease < 18505 then
WorldMapZoomOutButton:HookScript("OnClick", zoomhook)
end

local function zonehook(...)
	Loremaster.disablehook = nil
	Loremaster:ShowZoneMarkers()
end

if Grail.blizzardRelease < 18505 then
hooksecurefunc("WorldMapZoneButton_OnClick", zonehook)
end

local function mapclickhook(button, mousebutton)
	local z
	if mousebutton == "RightButton" then
		Loremaster:ClearMarker(nil, true)
		Loremaster.disablehook = true
	else z = GetCurrentMapZone()
		if z ~= 0 then
			Loremaster.disablehook = nil
			Loremaster:ShowZoneMarkers()
		end
	end
end

WorldMapButton:HookScript("OnClick", mapclickhook)
