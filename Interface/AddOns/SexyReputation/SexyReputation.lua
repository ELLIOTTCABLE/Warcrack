local SexyReputations = LibStub("AceAddon-3.0"):NewAddon("Sexy Reputations", "AceEvent-3.0", "AceTimer-3.0", "AceConsole-3.0")
local mod = SexyReputations
local tooltip

local GetNumFactions = GetNumFactions
local GetFactionInfo = GetFactionInfo
local fmt = string.format
local floor = math.floor
local IsAltKeyDown = IsAltKeyDown
local IsControlKeyDown = IsControlKeyDown
local IsShiftKeyDown = IsShiftKeyDown
local tconcat = table.concat
local GetFriendshipReputation = GetFriendshipReputation
local FL

local L        = LibStub("AceLocale-3.0"):GetLocale("SexyReputation", false)
local LD       = LibStub("LibDropdown-1.0")
local QTIP     = LibStub("LibQTip-1.0")
local BAR      = LibStub("LibSimpleBar-1.0")

local ldb = LibStub("LibDataBroker-1.1"):NewDataObject(L["Sexy Reputation"],
						       {
							  type =  "data source", 
							  label = L["Sexy Reputation"],
							  text = L["Factions"],
							  icon = (UnitFactionGroup("player") == "Horde" and
							       [[Interface\Addons\SexyReputation\hordeicon]] or
							       [[Interface\Addons\SexyReputation\allianceicon]]),
						       })


mod.repTitles = {
   FACTION_STANDING_LABEL1, -- Hated
   FACTION_STANDING_LABEL2, -- Hostile
   FACTION_STANDING_LABEL3, -- Unfriendly
   FACTION_STANDING_LABEL4, -- Neutral
   FACTION_STANDING_LABEL5, -- Friendly
   FACTION_STANDING_LABEL6, -- Honored
   FACTION_STANDING_LABEL7, -- Revered
   FACTION_STANDING_LABEL8, -- Exalted
}

-- names, used for looking up colors
mod.colorIds = {
   hated = 1, hostile = 2, unfriendly = 3, neutral = 4, friendly = 5, honored = 6, revered = 7, exalted = 8
}

local minReputationValues =  {
   [1] = -42000, -- Hated
   [2] =  -6000, -- Hostile
   [3] =  -3000, -- Unfriendly
   [4] =      0, -- Neutral
   [5] =   3000, -- Friendly
   [6] =   9000, -- Honored
   [7] =  21000, -- Revered
   [8] =  42000, -- Exalted
}


-- table recycling
local new, del, newHash, newSet, deepDel
do
   local list = setmetatable({}, {__mode='k'})
   function new(...)
      local t = next(list)
      if t then
	 list[t] = nil
	 for i = 1, select('#', ...) do
	    t[i] = select(i, ...)
	 end
	 return t
      else
	 return { ... }
      end
   end

   function newHash(...)
      local t = next(list)
      if t then
	 list[t] = nil
      else
	 t = {}
      end
      for i = 1, select('#', ...), 2 do
	 t[select(i, ...)] = select(i+1, ...)
      end
      return t
   end

   function del(t)
      if type(t) ~= table then
	 return nil
      end
      for k,v in pairs(t) do
	 t[k] = nil
      end
      list[t] = true
      return nil
   end

   function deepDel(t)
      if type(t) ~= "table" then
	 return nil
      end
      for k,v in pairs(t) do
	 t[k] = deepDel(v)
      end
      return del(t)
   end
end

function mod:OnInitialize()
   mod.db = LibStub("AceDB-3.0"):New("SexyRepDB", mod.defaults, "Default")
   mod.gdb = mod.db.global
   mod.cdb = mod.db.char
   FL = mod.gdb.factionLookup

   mod.sessionFactionChanges = new()
   mod.factionGainsCache = new()
   mod:SetDefaultColors()
end

function mod:OnEnable()
   mod:RegisterEvent("COMBAT_TEXT_UPDATE")
   mod:ScheduleTimer("UpdateLDBText", 3)
   mod:ScheduleTimer("ScanFactions", 5)
end

function mod:OnDisable()
   mod:UnregisterEvent("COMBAT_TEXT_UPDATE");
end

-- This transforms the faction name to an ID which is cached.
-- This means the data storage will be smaller. The faction
-- ID is unique to a computer and cannot be shared with others.
function mod:FactionID(name)
   if type(name) == "number" then return name end
   local id = FL[name]
   if not id then
      id = (mod.gdb.numFactions or 0) + 1
      mod.gdb.numFactions = id
      FL[name] = id
   end
   return id
end

function mod:ScanFactions(toggleActiveId)
   local foldedHeaders = new()
   
   mod.allFactions = deepDel(mod.allFactions) or new()
   mod.factionIdToIdx = del(mod.factionIdToIdx) or new()
   mod.factionGainsCache = deepDel(mod.factionGainsCache) or new()

   -- Iterate through the factions until we run out. We need to unfold
   -- any folded header, which changes the number of factions, so we just
   -- keep iterating until GetFactionInfo return nil
   local fr = mod.cdb.fr

   for idx = 1, 500 do 
      local name, description, standingId, bottomValue, topValue, earnedValue, atWarWith,
      canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild, factionId = GetFactionInfo(idx)
      local nextName = GetFactionInfo(idx + 1)
      if name == nextName then break end -- bugfix
      if not name then  break end -- last one reached
      local friendId, friendRep, friendMaxRep, _, friendshipText, _, friendTextLevel, friendThresh, nextFriendThresh = GetFriendshipReputation(factionId);
      local isCapped
      if (friendId ~= nil) then
         if nextFriendThresh then
            bottomValue = friendThresh
            topValue = nextFriendThresh 
            earnedValue = friendRep
         else
            bottomValue, topValue, earnedValue = 0, 1, 1
            isCapped = true
         end
      end
      local faction = newHash("name", name,
			      "desc", description,
			      "bottomValue", bottomValue,
			      "topValue", topValue,
			      "reputation", earnedValue,
			      "isHeader", isHeader,
			      "standingId", standingId,
			      "hasRep", hasRep or earnedValue ~= 0,
			      "isChild", isChild,
                              "friendId", friendId,
                              "friendshipText", friendshipText,
                              "friendTextLevel", friendTextLevel,
                              "friendIsCapped", isCapped,
			      "id", mod:FactionID(name))
      mod.allFactions[idx] = faction
      mod.factionIdToIdx[faction.id] = idx

      if faction.id == toggleActiveId then
	 local isInActive = IsFactionInactive(idx)
	 if isInActive then
	    SetFactionActive(idx)
	 else
	    SetFactionInactive(idx)
	 end
	 mod:ScanFactions() -- we need to rescan fully..
	 return
      end

      if isHeader and isCollapsed then
	 foldedHeaders[idx] = true
	 ExpandFactionHeader(idx)
      end
      if fr and faction.name == FACTION_INACTIVE then
	 mod.cdb.hf[faction.id] = true
      end
   end

   mod.cdb.fr = false
   
   -- Restore factions folded states
   for id = #mod.allFactions, 1, -1 do
      if foldedHeaders[idx] then
	 CollapseFactionHeader(idx)
      end
   end
   del(foldedHeaders)
end

function mod:GetDate(delta)
   local dt = date("*t", time()-(delta or 0))
   return dt.year * 10000 + dt.month * 100 + dt.day
end

function mod:ReputationLevelDetails(faction) 
   local reputation, standingId, friendId = faction.reputation, faction.standingId, faction.friendId
   local sc, color, rep, title, colorId
   rep = reputation - faction.bottomValue
   if friendId then 
      title = faction.friendTextLevel
      colorId = mod.colorIds.friendly
   else
      title = mod.repTitles[standingId]
      colorId = standingId
   end
   sc = mod.gdb.colors[colorId]
   if mod.gdb.colorFactions then
      color = fmt("%02x%02x%02x", floor(sc.r*255), floor(sc.g*255), floor(sc.b*255))
   else
      color = "ffffff"
   end
   return color, rep, title, colorId
end

function mod:GetGainsSummary(id)
   local today = mod:GetDate()
   local newlyCalculated = false
   local fc = mod.factionGainsCache[today]
   if not fc then
      -- Either we changed day, in which case we need to recalculate
      -- or it's new and it doesn't matter
      mod.factionGainsCache = deepDel(mod.factionGainsCache) or new()
      mod.factionGainsCache[today] = new()
      fc = mod.factionGainsCache[today]
   end
   if not fc[id] then
      newlyCalculated = true
      local todayDate = mod:GetDate() 
      local yesterDate = mod:GetDate(86400)
      local fh = mod.cdb.factionHistory
      local todayChange = fh[todayDate] and fh[todayDate][id] or 0
      local yesterChange = fh[yesterDate] and fh[yesterDate][id] or 0
      local weekChange = (todayChange or 0) + (yesterChange or 0)
      for day = 2,6 do
	 local dayChange = fh[mod:GetDate(day*86400)] -- going back in time
	 if dayChange and dayChange[id] then
	    weekChange = weekChange + dayChange[id]
	 end
      end
      local monthChange = weekChange
      for day = 7, 29 do
	 local dayChange = fh[mod:GetDate(day*86400)] -- going back in time
	 if dayChange and dayChange[id] then
	    monthChange = monthChange + dayChange[id]
	 end
      end
      fc[id] = newHash("today", todayChange,
		       "yesterday", yesterChange,
		       "week", weekChange,
		       "month", monthChange,
		       "changed", todayChange ~= 0 or yesterChange ~= 0
			  or weekChange ~= 0 or monthChange ~= 0)
   end
   return fc[id], newlyCalculated
end

---------------------------------------------------
-- LDB Display and display utility methods

local function _addIndentedCell(tooltip, icon, text, indentation, font, func, arg)
   local y, x = tooltip:AddLine(icon)
   tooltip:SetCell(y, 2, text, font or tooltip:GetFont(), "LEFT", 1, nil, indentation)
   if func then
      tooltip:SetLineScript(y, "OnMouseUp", func, arg)
   end
   return y, x
end

local function c(text, color)
   return fmt("|cff%s%s|r", color, text)
end
local function delta(number, zero)
   if not number or (not zero and number == 0) then
      return ""
   end
   if number < 0 then
      return fmt("|cffff2020%d|r", number)
   elseif number > 0 then
      return fmt("|cff00af00+%d|r", number)
   else
      return "|cffcfcfcf0|r"
   end
end

local function _plusminus(folded)
   return fmt("|TInterface\\Buttons\\UI-%sButton-Up:18|t", folded and "Plus" or "Minus")
end

local function _showFactionInfoTooltip(frame, faction)
   if mod.gdb.showTooltips then 
      local tooltip = QTIP:Acquire("SexyRepFactionTooltip")
      if faction.hasRep or (faction.desc and faction.desc ~= '') then
	 local y
	 tooltip:SetColumnLayout(faction.hasRep and 2 or 1, "LEFT", "RIGHT")
	 tooltip:Clear()
         local header = faction.name
         if faction.friendTextLevel then
            header = header .. " - "..faction.friendTextLevel.." ("..faction.standingId.." / 8)"
         end
	 tooltip:AddHeader(c(header, "ffd200"))
	 if faction.desc and faction.desc ~= '' then
	    tooltip:SetCell((tooltip:AddLine()), 1, faction.desc, tooltip:GetFont(), "LEFT", 1, nil, nil, 0, 300, 50)
	    tooltip:AddLine(" ")
	 end
	 if faction.friendshipText and faction.friendshipText ~= '' then
	    tooltip:SetCell((tooltip:AddLine()), 1, faction.friendshipText, tooltip:GetFont(), "LEFT", 1, nil, nil, 0, 300, 50)
	    tooltip:AddLine(" ")
	 end
            
	 if faction.hasRep then
	    -- Show recent reputtion history
	    local sessionChange = mod.sessionFactionChanges[faction.id] or 0
	    local gs = mod:GetGainsSummary(faction.id)
	    y = tooltip:AddHeader()
	    if sessionChange ~= 0 or gs.changed then
	       tooltip:SetCell(y, 1, c(L["Recent reputation changes"], "ffd200"), "CENTER", 2)
	       tooltip:AddSeparator(1)
	       tooltip:AddLine(L["Session"], delta(sessionChange, true))
	       tooltip:AddLine(L["Today"], delta(gs.today, true))
	       tooltip:AddLine(L["Yesterday"], delta(gs.yesterday, true))
	       tooltip:AddLine(L["Last Week"], delta(gs.week, true))
	       tooltip:AddLine(L["Last Month"], delta(gs.month, true))

               local color, rep, repTitle = mod:ReputationLevelDetails(faction)
               if not faction.friendId then
                  local remaining = 42999 - faction.bottomValue - rep
                  if remaining > 0 then
                     tooltip:AddLine(L["Remaining"], remaining)
                  end
                  local repetitions
                  if gs.today > 0 then
                     repetitions = remaining/gs.today
                  elseif gs.yesterday > 0 then
                     repetitions = remaining/gs.yesterday
                  end
                  if repetitions then
                     tooltip:AddLine(L["Repetitions"], string.format("%.2f", repetitions))
                  end
               end
	    else
	       tooltip:SetColumnLayout(1, "LEFT")
	       tooltip:SetCell(y, 1, c(L["Recent reputation changes"], "ffd200"))
	       tooltip:AddSeparator(1)
	       y = tooltip:AddLine(L["No changes recorded in the last 30 days."])
	    end
	 end
	 
	 if mod.cdb.watchedFaction == faction.id then
	    tooltip:AddLine(" ")
	    tooltip:AddSeparator(1)
	    tooltip:AddLine(c(L["This faction is currently being tracked."], "ffff00"))
	 end
	 tooltip:SetPoint("TOPLEFT", frame, "TOPRIGHT", 10, 0)
	 tooltip:SetFrameLevel(frame:GetFrameLevel()+1)
	 tooltip:SetClampedToScreen(true)
	 tooltip:Show()
	 tooltip:SetAutoHideDelay(0.25, frame)
      else
	 QTIP:Release(tooltip)
      end
   end
end

local function _factionOnClick(frame, faction, button)
   if button == "LeftButton" then
      if IsAltKeyDown() then
	 if faction.hasRep then
	    if mod.cdb.watchedFaction == faction.id then
	       mod.cdb.watchedFaction = nil
	    else
	       mod.cdb.watchedFaction = faction.id
	    end
	    mod:UpdateLDBText()
	 end
      elseif IsControlKeyDown() and IsShiftKeyDown() then
	 mod:ScanFactions(faction.id)
      elseif faction.isHeader then
	 mod.cdb.hf[faction.id] = not mod.cdb.hf[faction.id] or nil
      end
   end
   ldb.OnEnter() -- redraw
end

function ldb.OnEnter(frame)
   tooltip = QTIP:Acquire("SexyRepTooltip")
   tooltip:EnableMouse(true)

   local numCols = 2

   local showRep = mod.gdb.repTextStyle ~= mod.TEXT_STYLE_STANDING and mod.gdb.repStyle == mod.STYLE_TEXT
   local showStanding = mod.gdb.repTextStyle ~= mod.TEXT_STYLE_REPUTATION and mod.gdb.repStyle == mod.STYLE_TEXT
   local showRepBar = mod.gdb.repStyle == mod.STYLE_BAR
   local showPercentage = mod.gdb.showPercentage
   local showGains = mod.gdb.showGains
   local colorFactions = mod.gdb.colorFactions
   
   if showRepBar then
      numCols = numCols + 1
   else
      if showRep then numCols = numCols + 3 end
      if showStanding then numCols = numCols + 1 end
   end
   if showPercentage then numCols = numCols + 1 end
   if showGains then numCols = numCols + 2 end
   
   tooltip:Clear()
   tooltip:SetColumnLayout(numCols, "LEFT")
   
   if frame then
      tooltip:SetAutoHideDelay(0.5, frame)
   end
   
   if not mod.allFactions or not #mod.allFactions then
      mod:ScanFactions()
   end
   
   local y, x

   y = tooltip:AddHeader("", c(L["Faction"], "ffff00"))
   x = 3
   if showRepBar then
      tooltip:SetCell(y, x, c(L["Standing"], "ffff00"), "CENTER") x = x + 1
   else
      if showStanding then
	 tooltip:SetCell(y, x, c(L["Standing"], "ffff00"), "LEFT") x = x + 1
      end
      if showRep then
	 tooltip:SetCell(y, x, c(L["Reputation"], "ffff00"), "CENTER", 3) x = x + 3
      end
   end
   if showPercentage then
      tooltip:SetCell(y, x, c("%", "ffff00"), "CENTER") x = x + 1
   end
   if showGains then
      tooltip:SetCell(y, x, c(L["Session"], "ffff00"), "CENTER") x = x + 1
      tooltip:SetCell(y, x, c(L["Today"], "ffff00"), "CENTER") x = x + 1
   end
   tooltip:AddSeparator(1)

   local skipUntilHeader, skipUntilChildHeader
   local isTopLevelHeader, isChildHeader
   local todaysDate = mod:GetDate()
   local showOnlyChanged = mod.gdb.showOnlyChanged
   local watchedFaction = mod.cdb.watchedFaction
   local gridLines = mod.gdb.gridLines
   local indent, isTopLevelHeader, isChildHeader, sessionChange, today, showRow
   for id, faction in ipairs(mod.allFactions) do
      indent = 0
      isTopLevelHeader = faction.isHeader and not faction.isChild
      isChildHeader = faction.isHeader and faction.isChild
      
      sessionChange = mod.sessionFactionChanges[faction.id]
      today = mod.cdb.factionHistory[todaysDate] and mod.cdb.factionHistory[todaysDate][faction.id];
      
      showRow = true
      -- calculate whether this row should be displayed. Split out this way
      -- so it's possible to understand what it's filtering and why
      
      if skipUntilHeader and not isTopLevelHeader then
	 showRow = false
      elseif skipUntilChildHeader and not (isTopLevelHeader or isChildHeader) then
	 showRow = false
      elseif showOnlyChanged and not (sessionChange or today) then
	 showRow = false
      end
      if showRow then
	 local title, folded
	 if not showOnlyChanged then
	    if faction.isChild then indent = 20 end
	    if not faction.isHeader then indent = indent + 20 end
	    folded = faction.isHeader and mod.cdb.hf[faction.id]
	    local pm = _plusminus(folded)
	    title = faction.isHeader and fmt("%s %s", pm, faction.name) or c(faction.name, "ffd200")
	 else
	    title = faction.isHeader and faction.name or c(faction.name, "ffd200")
	 end
	 local color, rep, repTitle, colorId = mod:ReputationLevelDetails(faction)
	 local font

	 local icon = ""
	 if watchedFaction == faction.id then
	    icon = [[|TInterface\Icons\Spell_Shadow_EvilEye:20|t]]
	 end
	 y = _addIndentedCell(tooltip, icon, title, indent, font, _factionOnClick, faction)

	 tooltip:SetLineScript(y, "OnEnter", _showFactionInfoTooltip, faction)
	 tooltip:SetLineScript(y, "OnLeave", nil)
	 
	 if not faction.isHeader or faction.hasRep then
	    x = 3
	    -- "RIGHT", "CENTER", "RIGHT", "RIGHT")
	    if showStanding then
	       tooltip:SetCell(y, x, c(repTitle, color), "LEFT") x = x + 1
	    end
	    local maxValue = faction.topValue-faction.bottomValue
	    if showRep then
	       tooltip:SetCell(y, x, tostring(rep), "RIGHT") x = x + 1
	       tooltip:SetCell(y, x, "/", "CENTER") x = x + 1
	       tooltip:SetCell(y, x, tostring(maxValue), "RIGHT") x = x + 1
	    end
	    if showRepBar then
	       tooltip:SetCell(y, x, repTitle, "CENTER", mod.barProvider, mod.gdb.colors[colorId], rep, maxValue, 120, 12)
	       local xx, yy = x, y
	       
	       tooltip:SetLineScript(y, "OnEnter", function(frame, factionid)
						      local idx = mod.factionIdToIdx[factionid]
						      local faction
						      if idx then
							 local faction = mod.allFactions[idx]
							 if faction then
							    tooltip:SetCell(yy, xx, fmt("%d / %d", rep, maxValue), "CENTER", mod.barProvider, mod.gdb.colors[colorId], rep, maxValue, 120, 12)
							    _showFactionInfoTooltip(frame, faction)
							 end
						      end
						   end, faction.id)
	       tooltip:SetLineScript(y, "OnLeave", function(frame, factionid)
						      local idx = mod.factionIdToIdx[factionid]
						      if idx then
							 local faction = mod.allFactions[idx]
							 if faction then
							    -- Breaks encapsulation but.. otherwise it breaks the code
							    local lines = tooltip.lines and tooltip.lines[yy]
							    if lines and lines.cells and lines.cells[xx] then
							       tooltip:SetCell(yy, xx, repTitle, "CENTER", mod.barProvider, mod.gdb.colors[colorId], rep, maxValue, 120, 12)
							    end
							 end
						      end
						   end, faction.id)
	       x = x + 1
	    end
	    if showPercentage then
	       tooltip:SetCell(y, x, fmt("%.0f%%", (100.0*rep / maxValue)), "RIGHT") x = x + 1
	    end
	    if showGains then
	       tooltip:SetCell(y, x, delta(sessionChange), "CENTER") x = x + 1
	       tooltip:SetCell(y, x, delta(today), "CENTER") x = x + 1
	    end
	    if (sessionChange or today) and colorFactions and not showOnlyChanged then
	       tooltip:SetLineColor(y, 1, 1, 1, 0.2)
	    end
	    if gridLines then
	       tooltip:AddSeparator(0.5, 1, 1, 1, 0.5)
	    end
	 end
	 if folded then
	    if faction.isChild then
	       skipUntilChildHeader = true
	       skipUntilHeader = nil
	    else
	       skipUntilChildHeader = nil
	       skipUntilHeader = true
	    end
	 else
	    skipUntilChildHeader = nil
	    skipUntilHeader = nil
	 end
      end
   end

   tooltip:AddLine(" ")
   tooltip:AddSeparator(1)
   y = tooltip:AddLine()
   tooltip:SetCell(y, 1, c(L["Using the faction tooltip:"], "ffff00"), "LEFT", numCols)
   y = tooltip:AddLine("")
   tooltip:SetCell(y, 2, c(L["Click:"], "eda55f") .. " "..c(L["Fold / unfold faction headers."], "ffd200"), "LEFT", numCols-1)
   y = tooltip:AddLine("")
   tooltip:SetCell(y, 2, c(L["Alt-Click:"], "eda55f").. " "..c(L["Toggle faction tracking state on and off."], "ffd200"), "LEFT", numCols-1)
   y = tooltip:AddLine("")
   tooltip:SetCell(y, 2, c(L["Shift+Ctrl-Click:"], "eda55f").. " "..c(L["Toggle faction inactive state."], "ffd200"), "LEFT", numCols-1)
   
   if frame then
      tooltip:SmartAnchorTo(frame)
   end
   tooltip:SetScrollStep(100)
   tooltip:UpdateScrolling(mod.gdb.maxHeight)
   tooltip:Show()
end

function ldb.OnClick(frame, button)
   if button == "LeftButton" then
      --mod:ToggleConfigDialog()
   elseif button == "RightButton" then
      -- First hide the tooltip
      local tooltip = QTIP:Acquire("SexyRepTooltip")
      QTIP:Release(tooltip)

      local menu = LD:OpenAce3Menu(mod.options)
      menu:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 0, 0)
      menu:SetFrameLevel(frame:GetFrameLevel() + 50)
      menu:SetClampedToScreen(true)
   end
end

function ldb.OnLeave(frame)
   --   if ldb.tooltip then
   --      QTIP:Release(ldb.tooltip)
   --      ldb.tooltip = nil
   --   end
end

function mod:UpdateLDBText()
   local text = ""
   local gdb = mod.gdb
   if not mod.cdb.watchedFaction then
      ldb.text = L["Factions"]
      return
   end
   
   if not mod.allFactions then
      mod:ScanFactions()
   end
   local idx = mod.factionIdToIdx[mod.cdb.watchedFaction]
   local faction =  mod.allFactions[idx]
   if not faction then
      ldb.text = L["Factions"]
      return
   end
   
   local fields = new()
   if gdb.trackName then      
      fields[1] = faction.name
   end
   local color, rep, repTitle = mod:ReputationLevelDetails(faction)
   if gdb.trackStanding then
      fields[#fields+1] = c(repTitle, color)
   end
   local maxValue = faction.topValue - faction.bottomValue
   if gdb.trackRep then
      fields[#fields+1] = fmt("%d/%d", rep, maxValue)
   end
   if gdb.trackPercentage then
      fields[#fields+1] = fmt("|cffffd200%.1f%%|r", 100.0 * rep / maxValue)
   end
   if gdb.trackGains and mod.sessionFactionChanges[faction.id] then
      fields[#fields+1] = delta(mod.sessionFactionChanges[faction.id], true)
   end
   ldb.text = tconcat(fields, " - ")
end

-----------------------
--- EVENT HANDLING
do
   local factionScanTimer
   
   function mod:COMBAT_TEXT_UPDATE(event, type, faction, amount)
      if type == "FACTION" then
	 if factionScanTimer then
	    mod:CancelTimer(factionScanTimer, true)
	 end
	 factionScanTimer = mod:ScheduleTimer("ScanForFactionChanges", 1)
      end
   end

   function mod:ScanForFactionChanges()
      local previousFactionData = mod.allFactions
      factionScanTimer = nil
      mod.allFactions = nil
      mod:ScanFactions()
      
      if not previousFactionData then return end -- can't do anything, had no data before
      
      local date = mod:GetDate()

      local today =  mod.cdb.factionHistory[date] or new()
      mod.cdb.factionHistory[date] = today

      for _,faction in ipairs(previousFactionData) do
	 local idx = mod.factionIdToIdx[faction.id] -- required since faction orders might have changed
	 if idx then
	    local newFaction = mod.allFactions[idx]
	    if newFaction.reputation ~= faction.reputation then
	       -- Rep change occurred
	       local amount = newFaction.reputation - faction.reputation
	       mod.sessionFactionChanges[faction.id] = (mod.sessionFactionChanges[faction.id] or 0) + amount
	       today[faction.id] = (today[faction.id] or 0) + amount

	       -- Update the cached rep changes here, if needed.
	       local gs,upToDate = mod:GetGainsSummary(faction.id)
	       if not upToDate then
		  gs.changed = true
		  gs.today = gs.today + amount
		  gs.week  = gs.week + amount
		  gs.month = gs.month + amount
	       end
	       if faction.id == mod.cdb.watchedFaction then
		  mod:UpdateLDBText()
	       end
	    end
	 end
      end
      deepDel(previousFactionData)
   end
end


-- Set up a custom provider for the bars
local barProvider, barCellPrototype = QTIP:CreateCellProvider()
mod.barProvider = barProvider

function barCellPrototype:InitializeCell()
   self.bar = BAR:NewSimpleBar(self, 0, 0, 100, 10, BAR.LEFT_TO_RIGHT)
   self.bar:SetAllPoints(self)
   self.fontString = self.bar:CreateFontString()
   self.fontString:SetAllPoints(self.bar)
   self.fontString:SetFontObject(GameTooltipText)
   self.fontString:SetJustifyV("CENTER")
end

function barCellPrototype:SetupCell(tooltip, value, justification, font, color, rep, maxRep, width, height)
   local fs = self.fontString
   fs:SetFontObject(font or tooltip:GetFont())
   fs:SetJustifyH(justification)
   fs:SetText(tostring(value))
   fs:Show()
   
   self.bar:SetValue(rep, maxRep)
   self.bar:SetBackgroundColor(0, 0, 0, 0.4)
   self.bar:SetColor(color.r, color.g, color.b, 0.8)
   if width then
      self.bar:SetLength(width)
   end
   if height then
      self.bar:SetThickness(height)
   end
   self.bar.spark:Hide()
   self:SetWidth(width)
   return width, height
end

function barCellPrototype:getContentHeight()
   return self.bar:GetHeight()
end

function barCellPrototype:ReleaseCell()
   self.r, self.g, self.b = 1, 1, 1
end

