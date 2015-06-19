local _G = _G
local Loremaster = Loremaster
local white, grey = "|cffffffff", "|cff778899"
local Loremaster = Loremaster
local L = Loremaster.L
local GameTooltip = GameTooltip
local string, pairs, ipairs, table = string, pairs, ipairs, table
local GetAchievementNumCriteria, GetAchievementCriteriaInfo = GetAchievementNumCriteria, GetAchievementCriteriaInfo
local GetMapNameByID = GetMapNameByID
local CreateFrame = CreateFrame
local tostring = tostring

local function mouseEnter(this)
	if this.disabled then return end
	local parent = this:GetParent()
	if this.id ~= parent.selected then
		this:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background"})
		this:SetBackdropColor(0, 0, 0, 0.4)
	end
	if parent.name == "LoremasterQuestFrame" then
		if this.desc then
			Loremaster.ttscale = GameTooltip:GetScale()
			GameTooltip:SetScale(0.8)
			GameTooltip:SetOwner(this, "ANCHOR_TOP")
			GameTooltip:ClearLines()
			GameTooltip:SetText(this.c .. this.desc)
			GameTooltip:Show()
		end
	end
end

local function mouseClick(this)
	if this.disabled then return end
	this:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background"})
	this:SetBackdropColor(0, 0, 0, 0.7)
end

local function mouseLeave(this)
	if this.disabled then return end
	local parent = this:GetParent()
	if this.id ~= parent.selected then this:SetBackdrop(nil) end
	if this.desc then 
		GameTooltip:Hide()
		GameTooltip:SetScale(Loremaster.ttscale or 1)
	end
end

local function sortQuests(a, b)
	local weighta, weightb = "z", "z"
	local ca, cb, c, sa, sb
	if (a[3] or 0) == 1 then weighta = "a" end
	if (a[3] or 0) == 0 and (a[4] or 0) == 0 and (a[5] or 0) == 0 then weighta = "b" end
	if (a[5] or 0) == 1 then weighta = "c" end
	if (b[3] or 0) == 1 then weightb = "a" end
	if (b[3] or 0) == 0 and (b[4] or 0) == 0 and (b[5] or 0) == 0 then weightb = "b" end
	if (b[5] or 0) == 1 then weightb = "c" end
	sa = string.lower(string.sub(a[1], 11))
	sb = string.lower(string.sub(b[1], 11))
	ca = weighta .. sa
	cb = weightb .. sb
	return ca < cb
end

--local function sortStories(a, b) return (a.title or "") < (b.title or "") end

function Loremaster:clickResponder(this)
	if this.disabled then return end
	local parent = this:GetParent()
	local row, zones, z, c, k, v, detail, q
	local data, qdata, dat = {}, {}, {}
	local item, series, first, other = "|cffffd200", "|cff668b8b", "|cff70db93", "|cffffffff"
	local grey, white = "|cff778899", "|cffffffff"
	local ach, det, t, desc

	if parent.selected then self:resetLines(parent) end

	mouseClick(this)
	parent.selected = this.id

	if parent.name == "LoremasterContinentFrame" then
		self.currentcontinent = this.id
		Loremaster.ContinentFrame.currentline = this

		if self.db.profile.hideach then
			for ach, det in pairs(LoremasterDB.Achievements[this.id] or {}) do
				if det[3] == false then table.insert(dat, LoremasterDB.Achievements[this.id][ach]) end
			end
		else dat = (LoremasterDB.Achievements[this.id] or {}) end

		Loremaster.ZoneFrame.data = dat
		table.sort(Loremaster.ZoneFrame.data, function(a, b) return string.lower(string.sub(a[1], 11)) < string.lower(string.sub(b[1], 11)) end)
		--if self.currentcontinent == 6 then table.insert(Loremaster.ZoneFrame.data, {white .. _G.UNKNOWN, 9999, false}) end
		self:updateScroll(LoremasterZoneFramescroll)
		LoremasterQuestFrame.data = {}
		LoremasterQuestFrame.qdata = {}
		self:updateQuestCount(-1)
		self:updateZoneCount(#dat)
		self:updateScroll(LoremasterQuestFramescroll)
		Loremaster.ZoneFrame.selected = nil
		Loremaster.ZoneFrame.currentline = nil
		--LoremasterStoryFrame.selected = nil
		--LoremasterStoryFrame.currentline = nil
		--LoremasterStoryFrame.data = {}
		--self:updateStoryCount(-1)
		--self:updateScroll(LoremasterStoryFramescroll)
		LoremasterQuestFrame.selected = nil
		LoremasterInfoFrame.qid = nil
		LoremasterInfoFrame.x = nil
		LoremasterInfoFrame.y = nil
		LoremasterInfoFrame.z = nil
		LoremasterInfoFrame.target = nil
		LoremasterInfoBox:SetText("")

	elseif parent.name == "LoremasterZoneFrame" then
		self.currentzone = this.id
		Loremaster.ZoneFrame.currentline = this
		local quests = Grail.indexedQuests[Grail.mapAreaBaseAchievement + this.id]
		local startsSeries, partOfSeries
		local questStatus

		if #quests > 0 then
			local possibleNPCs, npc, locations, meetsLevel, levelToCompare, levelRequired, levelNotToExceed
			for _, questId in pairs(quests) do
				questStatus = Grail:StatusCode(questId)
				if bit.band(questStatus, Grail.bitMaskQuestFailureWithAncestor + Grail.bitMaskCompleted) == 0 and not Grail:IsQuestObsolete(questId) and not Grail:IsQuestPending(questId) then	-- check the status of the quest to make sure it should be displayed
					startsSeries = Grail:_IsQuestMarkedInDatabase(questId, Loremaster.startsSeries) and 1 or nil
					partOfSeries = Grail:_IsQuestMarkedInDatabase(questId, Loremaster.partOfSeries) and 1 or nil
					possibleNPCs = Grail:QuestNPCPrerequisiteAccepts(questId)
					if nil == possibleNPCs then
						possibleNPCs = Grail:QuestNPCAccepts(questId)
					end
					if nil ~= possibleNPCs then
						locations = Grail:NPCLocations(possibleNPCs[1])	-- assume the first for the moment since this UI does not expect more than one questiver
						if nil ~= locations then
							npc = locations[1]	-- assume the first for the moment since this UI does not expect more than one location
							if npc.dropName then
								c = item
								desc = L["Starts from an item drop"]
							elseif startsSeries then
								c = first
								desc = L["Starts a series"]
							elseif partOfSeries then
								c = series
								desc = L["Part of a series"]
							else
								c = other
								desc = L["Standalone quest"]
							end
							meetsLevel, levelToCompare, levelRequired, levelNotToExceed = Grail:MeetsRequirementLevel(questId)
							table.insert(data, { c .. Grail:QuestName(questId), questId, nil, nil, npc.dropName and 1 or nil, c, desc})
							table.insert(qdata, { qid = questId, z = npc.mapArea, mapArea = npc.mapArea, mapLevel = npc.mapLevel or 0, l = levelRequired, x = npc.x or 0, y = npc.y or 0, npc = npc.name,
												s = partOfSeries, f = startsSeries, i = npc.dropName and 1 or nil, dup = nil, drop = npc.dropName, near = npc.near})
						end
					end
				end
			end
		else
			return
		end
		LoremasterQuestFrame.data = data
		LoremasterQuestFrame.qdata = qdata
		LoremasterQuestFrame.selected = nil
		--LoremasterStoryFrame.selected = nil
		--LoremasterStoryFrame.currentline = nil
		LoremasterInfoFrame.qid = nil
		LoremasterInfoFrame.x = nil
		LoremasterInfoFrame.y = nil
		LoremasterInfoFrame.z = nil
		LoremasterInfoFrame.target = nil
		self:updateQuestCount(#data)
		LoremasterInfoBox:SetText("")
		table.sort(LoremasterQuestFrame.data, sortQuests)
		self:updateScroll(LoremasterQuestFramescroll)
	elseif parent.name == "LoremasterQuestFrame" then
		for k, v in pairs(LoremasterQuestFrame.qdata) do
			if v.qid == this.id then
				detail = v
				break
			end
		end
		self:setNotes(detail)
		if self.LH then LightHeadedFrame:Hide() end
	end
end

function Loremaster:updateScroll(frame)
	local valueStep = 16
	local line, linePlusOffset, fLine
	local numItems, pretmp
	local parent = frame:GetParent()
	local numToDisplay = parent.displaylines
	local text, id, c, desc

	GameTooltip:Hide()

	if parent.data then
		numItems = #parent.data
		FauxScrollFrame_Update(frame, numItems, numToDisplay, valueStep)
		if numItems == 0 then
			for line = 1, numToDisplay do
				fLine = _G[parent.name .. line]
				fLine:Hide()
			end
		else
			for line = 1, numToDisplay do
				linePlusOffset = line + FauxScrollFrame_GetOffset(frame)
				fLine = _G[parent.name .. line]
				if linePlusOffset <= numItems then
					pretmp = parent.name .. line .. "_"					
					text = parent.data[linePlusOffset][1] or ""
					id = parent.data[linePlusOffset][2]					
					--if parent.name ~= "LoremasterStoryFrame" then
						text = parent.data[linePlusOffset][1] or ""
						id = parent.data[linePlusOffset][2]
						c = parent.data[linePlusOffset][6]
						desc = parent.data[linePlusOffset][7]
						fLine.c = c
						fLine.desc = desc
					--else
					--	text = parent.data[linePlusOffset]["title"] or ""
					--	id = parent.data[linePlusOffset]["id"]
					--end
					fLine.id = id
					_G[pretmp .. "f1"]:SetWidth(0)
--					if text == self.continents[6][1] then fLine.id = 6 end
					_G[pretmp .. "f1"]:SetText(white .. text)
					fLine.disabled = false
					if _G[pretmp .. "f1"]:GetWidth() > fLine:GetWidth() then self:Truncate(_G[pretmp .. "f1"], fLine:GetWidth()) end
					fLine:SetScript("OnMouseDown", function(this) self:clickResponder(this) end)
					fLine:SetScript("OnEnter", mouseEnter)
					fLine:SetScript("OnLeave", mouseLeave)
					if id == parent.selected then mouseClick(fLine)
					else fLine:SetBackdrop(nil) end
					fLine:Show()
				else fLine:Hide() end
			end
		end
	end
end

function Loremaster:createLine(parent, linename)
	local frame= CreateFrame("Frame", linename, parent)
	local f1 = frame:CreateFontString("$parent_f1", "ARTWORK", "GameFontNormal")
	frame:SetHeight(16)
	frame:SetWidth(parent:GetWidth() - 38)
	f1:SetPoint("LEFT", frame, "LEFT")
	f1:SetWidth(frame:GetWidth())
	f1:SetJustifyH("LEFT")
	f1:SetJustifyV("TOP")
	f1:Show()
	return frame
end

function Loremaster:placeLines(frame, lines)
	local c, ypos, pre, tmp
	pre = frame.name
	ypos = -14
	for c = 1, lines do
		tmp = self:createLine(frame, pre .. c)
		tmp:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, ypos)
		tmp:Hide()
		ypos = ypos - 20
	end
end

function Loremaster:createScrollFrame(parent, name)
	local frame = CreateFrame("ScrollFrame", name, parent, "FauxScrollFrameTemplate")
	local itemHeight = 16
	frame:SetScript("OnVerticalScroll", function(this, offset) FauxScrollFrame_OnVerticalScroll(this, offset, itemHeight, function() self:updateScroll(frame) end) end)
	frame:EnableMouseWheel(true)
	frame:SetScript("OnMouseWheel", ScrollFrameTemplate_OnMouseWheel)
	frame.name = name
	return frame
end

function Loremaster:createDisplayFrame(parent, framename, lines, height, width, data)
	local frame = CreateFrame("Frame", framename, parent)
	local sframe = Loremaster:createScrollFrame(frame, framename .. "scroll")
	frame:SetMovable(false)
	frame:EnableMouse(true)
	frame:EnableKeyboard(true)
	frame:SetHeight(height)
	frame:SetWidth(width)
	frame:SetBackdrop({bgFile = self[framename].bgfile, edgeFile = self[framename].edgefile, edgeSize = 16, insets = {left = 4, right = 4, top = 4, bottom = 4}})
	frame.data = data
	frame.name = framename
	frame.displaylines = lines
	sframe:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, -10)
	sframe:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -32, 10)
	self:placeLines(frame, lines)
	local function frameOnShow() self:updateScroll(sframe) end
	frame:SetScript("OnShow", frameOnShow)
	return frame
end