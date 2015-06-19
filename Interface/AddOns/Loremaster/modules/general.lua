local GetAchievementInfo = GetAchievementInfo
local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo
local GetAchievementNumCriteria = GetAchievementNumCriteria
local Loremaster = Loremaster
local L = Loremaster.L
local locale = GetLocale()
local _G = _G
local pairs, ipairs = pairs, ipairs
local string, tostring = string, tostring
local table, select = table, select

function Loremaster:resetLines(frame)
	local row
	for row = 1, frame.displaylines do _G[frame.name .. row]:SetBackdrop(nil) end
end

function Loremaster:getContinents()
	local cn, c, ach, det
	local dat = {}
	local shouldAdd

	for cn, c in pairs(Grail.continents) do
		if Grail.continentIndexMapping then
			cn = Grail.continentIndexMapping[cn]
		end
		shouldAdd = false
		if self.db.profile.hideach then
			for ach, det in pairs((LoremasterDB.Achievements[cn] or {})) do
				if det[3] == false then
					shouldAdd = true
					break
				end
			end
		else
			shouldAdd = true
		end
		if shouldAdd then
			table.insert(dat, { c.name, cn })
		end
	end
	return dat
end

function Loremaster:updateQuestCount(count)
	local texture = "Interface\\OPTIONSFRAME\\UI-OptionsFrame-NewFeatureIcon"
	local size = 16
	local qcount
	if (count or -1) == -1 then qcount = ""
	else qcount = "  |cffbebebe(" .. count .. " " .. L["available"] .. ")" end
	LoremasterQuestTitle:SetFormattedText("|T%s:%d|t%s", texture, size, L["Quests"] .. qcount)
end

function Loremaster:updateZoneCount(count)
	local texture = self.factiontexture
	local size = 32
	local zcount
	if (count or -1) == -1 then zcount = ""
	else zcount = "  |cffbebebe(" .. count .. " " .. L["available"] .. ")" end
	LoremasterZoneTitle:SetFormattedText("|T%s:%d|t%s",texture , size, L["Achievement"] .. zcount)
end

local function trim(s) return (string.gsub(s, "^%s*(.-)%s*$", "%1")) end
	
function Loremaster:setNotes(detail)
	local N = LoremasterInfoFrame
	local white, gold, green, blue = "|cffffffff", "|cffffd200", "|cff22ee55", "|cff00bfff"
	local text, sp1, npc, item, zone, target, article, z, i

	text = "|T"

	if locale == "enUS" then
		if detail.i == 1 then
			text = text .. self.itemicon
			target = detail.drop
			item = L["an item dropped by"] .. " " .. green .. target .. white
			sp1 = " "
		else
			text = text .. self.npcicon
			item = L["an NPC"]
			sp1 = ""
			target = detail.npc
		end

		npc = detail.npc
		text = text .. ":32|t" .. sp1 .. npc .. "\r\r" .. white	
		text = text .. L["This level"] .. " " .. detail.l .. " " .. L["quest"] .. " "

		if detail.f == 1 then text = text .. L["starts a series with"]
		elseif detail.s == 1 then text = text .. L["is part of a series from"]
		else text = text .. L["starts with"] end

--		zone = self.Zones[tostring(detail.z)] or _G.UNKNOWN
		zone = Grail.mapAreaMapping[detail.z] or _G.UNKNOWN
		text = text .. " " .. item .. " "	
		text = text .. L["in"] .. " " .. zone
		if detail.near then
			text = text .. " " .. "nearby"
		else
			text = text .. " " .. L["at"] .. " " .. blue .. detail.x .. white .. ", " .. blue .. detail.y .. white .. "."
		end
	else
		if detail.i == 1 then
			text = text .. self.itemicon
			item = L["Dropped by"] .. ": " .. white .. detail.drop .. "\r"
		else
			text = text .. self.npcicon
			item = L["NPC"] .. ": " .. white .. detail.npc .. "\r"
		end

		text = text .. ":32|t" .. "\r" .. green .. item
		text = text .. green .. L["Level"] .. ": " .. white .. detail.l .. "\r\r"
		if detail.f == 1 then text = text .. white .. L["Starts a series"] .. "\r\r"
		elseif detail.s == 1 then text = text .. white .. L["Part of a series"] .. "\r\r" end
--		zone = self.Zones[tostring(detail.z)]
		zone = Grail.mapAreaMapping[detail.z]
		text = text .. green .. L["Zone"] .. ": " .. white .. zone .. "\r"	
		if detail.near then
			text = text .. " near"
		else
			text = text .. green .. L["Co-ords"] .. ": " .. blue .. detail.x .. white .. ", " .. blue .. detail.y .. white
		end
	end

	LoremasterInfoFrame.qid = detail.qid
	LoremasterInfoFrame.x = detail.x
	LoremasterInfoFrame.y = detail.y
	LoremasterInfoFrame.mapArea = detail.mapArea
	LoremasterInfoFrame.mapLevel = detail.mapLevel
	LoremasterInfoFrame.z = zone
	LoremasterInfoFrame.target = target
	LoremasterInfoBox:SetText(text)

	if Loremaster.TT then
		if detail.near then
			Loremaster.tomTomButton:Hide()
		else
			Loremaster.tomTomButton:Show()
		end
	end
end

local function getPandariaCriteria(ach)
	local total, criteria, complete
	local completed = 0
	total = GetAchievementNumCriteria(ach)
	for criteria = 1, total do
		complete = select(3, GetAchievementCriteriaInfo(ach, criteria))
		if complete then completed = completed + 1 end
	end
	if total < 1 then
		local _,_,_,isComplete = GetAchievementInfo(ach)
		total = 1
		if isComplete then completed = 1 end
	end
	return completed, total
end

function Loremaster:scanAchievements()
	UIParentLoadAddOn("Grail-Achievements")
	local achlist = Grail.loremasterAchievements[self.faction]
	local continent, ach, name, complete
	local achievements, c = {[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={}}, ""
	local grey, white = "|cff778899", "|cffffffff"
	local cont, req, qty, _, reqCount

	if not achlist then return end
	local limit
	if Grail.continentMapIds then
		limit = #(Grail.continentMapIds)
	else
		limit = #(Grail.continents)
	end

	for continent = 1, limit do
		for _, ach in pairs(achlist[continent]) do
			ach = ach - Grail.mapAreaBaseAchievement
			_, name, _, complete = GetAchievementInfo(ach)
			if name then
				if continent == 6 or continent == 7 then qty, req = getPandariaCriteria(ach)
				else
					reqCount = GetAchievementNumCriteria(ach)
					if 0 ~= reqCount then	-- Only call GetAchievementCriteriaInfo when there are actually requirements to count
						_, _, _, qty, req = GetAchievementCriteriaInfo(ach, 1)
					else
						qty, req = 1, 1
					end
				end
				if complete then c = grey
				else c = white end
				cont = continent
				table.insert(achievements[cont], {c .. name .. grey .. " (" .. (qty or 0) .. " / " .. (req or 0) .. ")", ach, complete})
			end
		end
	end

	LoremasterDB.Achievements = achievements
	self.rescan = nil
end

function Loremaster:resetInterface()
	--reset the interface
	LoremasterQuestFrame.data = {}
	LoremasterQuestFrame.qdata = {}
	Loremaster.ZoneFrame.data = {}
	Loremaster.ContinentFrame.data = self:getContinents()
	self:updateQuestCount(-1)
	--self:updateStoryCount(-1)
	self:updateZoneCount(-1)
	Loremaster.ZoneFrame.selected = nil
	Loremaster.ZoneFrame.currentline = nil
	LoremasterQuestFrame.selected = nil
	Loremaster.ContinentFrame.selected = nil
	self:updateScroll(LoremasterContinentFramescroll)
	self:updateScroll(LoremasterQuestFramescroll)
	self:updateScroll(LoremasterZoneFramescroll)
	LoremasterInfoFrame.qid = nil
	LoremasterInfoFrame.x = nil
	LoremasterInfoFrame.y = nil
	LoremasterInfoFrame.z = nil
	LoremasterInfoFrame.target = nil
	LoremasterInfoBox:SetText("")
	self:resetLines(Loremaster.ContinentFrame)
end

function Loremaster:Truncate(fs, size)
	local chars
	local text = fs:GetText()
	for chars = 1, string.len(text) do
		fs:SetText(string.sub(text, 1, chars) .. "...")
		if fs:GetWidth() > size then
			fs:SetText(string.sub(text, 1, chars - 1) .. "...")
			break
		end
	end
end
