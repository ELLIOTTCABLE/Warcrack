-- mikma, 10/2014

-- The following function will require that debug.EnemyScanner2 is set to true.
-- Setting it true will also result this addon to work everywhere.
-- ChatFrame3 is used to print all the actions hostile players do.
-- ChatFrame4 is used to print tooltipscan results and mouseover results.
local function debugprint(chatframe,text,r,g,b)
	if debug and debug.EnemyScanner2 then
		_G["ChatFrame"..chatframe]:AddMessage(text,r,g,b)
	end
end

-- Let's create some locals.
local db
local _
local updating
local total = 0
local anchor = CreateFrame("Button", nil, UIParent)
local ES2timer = CreateFrame("Frame")
local ES2messages = {}
local rows = {}
local ES2temptable = {}
local pvpmatch
local HOSTILEUNITFLAG = 0x548

-- Stealth/Prowl/Invisibility watch.
local spellwatch = {
	[66] = true, -- Mage, Invisibility
	[110959] = true, -- Mage, Greater Invisibility
	[1784] = true, -- Rogue, Stealth
	[5215] = true, -- Druid, Prowl
}

-- If SavedVariables database does not exist, create it and add some default values for anchor, expiration time and temporary PvP table.
if not EnemyScanner2DB then EnemyScanner2DB = {["position"] = {point = "RIGHT", x = -70, y = 0}, ["expire"] = 10, ["PvP"] = {}, ["enabled"] = true,} end

-- Converts R,G,B into hexcolor. Example: RAID_CLASS_COLORS['SHAMAN'] (r,g,b) 0,0.44,0,87 turns into '|cff0070dd'.
local function DecimalToHex(r,g,b)
    return string.format("|cff%02x%02x%02x", r*255, g*255, b*255)
end

EnemyScanner2 = CreateFrame("Button", nil, UIParent)
EnemyScanner2:SetScript("OnEvent", function(self, event, ...)
	if self[event] then return self[event](self, event, ...) end
end)

-- function for SetScript("OnUpdate")
local function onUpdate(self,elapsed)
	total = total + elapsed
	if total >= 1 then
		updating = ES2timer:GetScript("OnUpdate")
		if updating and not next(ES2messages) then
			debugprint(3,"Timer stopped",1,0,0)
			ES2timer:SetScript("OnUpdate",nil)
			EnemyScanner2:Clear()
		end
		for k,v in pairs(ES2temptable) do
			if time() == v["spotted"] then
				local uid = ES2temptable[k]
				EnemyScanner2:DelMessage(uid)
			end
		end
		total = 0
	end
end

-- Register all the needed events.
function EnemyScanner2:Enable()
	EnemyScanner2:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	EnemyScanner2:RegisterEvent("PLAYER_LOGIN")
	EnemyScanner2:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
	EnemyScanner2:RegisterEvent("PLAYER_TARGET_CHANGED")
	EnemyScanner2:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	EnemyScanner2:RegisterEvent("LOADING_SCREEN_DISABLED")
end

-- Unregister all events except ZONE_CHANGED_NEW_AREA, which is used to enable the addon once again.
-- Oh and LOADING_SCREEN_DISABLED let's us basicly know we have zone'd out somewhere far. Clear messages.
function EnemyScanner2:Disable()
	EnemyScanner2:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	EnemyScanner2:UnregisterEvent("PLAYER_LOGIN")
	EnemyScanner2:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
	EnemyScanner2:UnregisterEvent("PLAYER_TARGET_CHANGED")
	updating = ES2timer:GetScript("OnUpdate")
	-- Clear the messages and disable onUpdate timer
	if updating then
		EnemyScanner2:Clear()
		ES2timer:SetScript("OnUpdate",nil)
	end
end

function EnemyScanner2:LOADING_SCREEN_DISABLED()
	debugprint(3,"Zone changed? Messages cleared.",1,1,0)
	EnemyScanner2:Clear()
	ES2timer:SetScript("OnUpdate",nil)
end

-- We use this to enable/disable the addon when player enter instance.
function EnemyScanner2:ZONE_CHANGED_NEW_AREA()
	local instancetype = select(2,GetInstanceInfo())
	if instancetype == "pvp" then
		pvpmatch = true
		table.wipe(EnemyScanner2DB["PvP"])
		EnemyScanner2:Enable()
		-- Change temptable to PvP.
		temptable = EnemyScanner2DB["PvP"]
		EnemyScanner2DB.expire = 10
		EnemyScanner2:Clear()
		debugprint(3,"EnemyScanner2 PvP",0,0,1)
		EnemyScanner2DB.enabled = true
	elseif instancetype == "party" or instancetype == "raid" or instancetype == "arena" then
		EnemyScanner2:Disable()
		debugprint(3,"EnemyScanner2 Disabled",1,0,0)
		EnemyScanner2DB.enabled = false
	else
		if not EnemyScanner2DB.enabled then 
			-- Change temptable to realmName.
			temptable = EnemyScanner2DB[realmName]
			EnemyScanner2:Enable()
			debugprint(3,"EnemyScanner2 Enabled",0,1,0)
			EnemyScanner2DB.enabled = true
		end
		if pvpmatch then
			EnemyScanner2:Clear()
			pvpmatch = nil
		end
		EnemyScanner2DB.expire = 30
	end
end

-- realmName is available after login.
function EnemyScanner2:PLAYER_LOGIN()
	local realmName = GetCVar("realmName")
	if not EnemyScanner2DB[realmName] then EnemyScanner2DB[realmName] = {} end
	db = EnemyScanner2DB[realmName]
	EnemyScanner2:ZONE_CHANGED_NEW_AREA()
	-- anchor SetPoint from SavedVariables is available after PLAYER_LOGIN, so initialize the anchor frame.
	EnemyScanner2:Initialize()
end

local function GetStats(unit)
	-- Unit exists, Unit is a player, and Unit is enemy to you.
	if UnitExists(unit) and UnitIsPlayer(unit) and UnitIsEnemy("player",unit) and (not UnitIsPVPSanctuary("player") or (debug and debug.EnemyScanner2)) then
		local guidsource = UnitGUID(unit)
		local level = UnitLevel(unit)
		local name = UnitName(unit)
		local classFilename = select(2,UnitClass(unit))
		-- In case game haven't had the time to cache the player's name yet.
		if name == "Unknown" then
			debugprint(4,"Mouseover: "..guidsource.." has no name yet?",1,0,0)
			return
		end
		
		-- Level is shown as '-1' with UnitLevel if the target is ovet 10 levels over your level.
		if level == -1 then
			level = 0
		end
		
		-- Level is shown as '-1' but we already know this player
		if level == -1 and db[guidsource] then
			level = db[guidsource]
		end
		
		-- Player doesn't exist in the database, create a spot for player in database.
		if not db[guidsource] then
			db[guidsource] = level
			debugprint(4,"Mouseover: "..name.." added and level set to: "..level)
		end
		
		-- Player exists in the database but level is greater than the one stored, upgrade it.
		if level > db[guidsource] then
			db[guidsource] = level
			debugprint(4,"Mouseover: "..name.." upgraded level to: "..level)
		end

		local found = false
		-- Let's check is the player shown on screen.
		for i=1,#ES2messages do
			if name == ES2messages[i]["name"] then
				-- Yeap!
				found = true
			end
		end
		-- Player was not on screen, let's add him.
		if not found then
			local uid = EnemyScanner2:AddMessage(name, db[guidsource], time()+EnemyScanner2DB.expire, classFilename)
			ES2temptable[guidsource] = uid
		-- Player was shown, let's upgrade the duration.
		else
			local uid = ES2temptable[guidsource]
			EnemyScanner2:EditMessage(uid,db[guidsource],time()+EnemyScanner2DB.expire)
		end

		-- Scanned, now update.
		total = 0
		ES2timer:SetScript("OnUpdate",onUpdate)
	end
end

-- Get stats of unit (mouseover).
function EnemyScanner2:UPDATE_MOUSEOVER_UNIT()
	GetStats("mouseover")
end

-- Get stats of unit (tab-target).
function EnemyScanner2:PLAYER_TARGET_CHANGED()
	GetStats("target")
end

-- We use this to store the guid of the players if they are at max level so they won't be scanned again.
local tooltiptable = {}

-- Let's create a simple tooltip what we use to scan the players. - Thanks Semlar!
local tooltip = CreateFrame("GameTooltip")
local toolText2 = tooltip:CreateFontString()
local toolText3 = tooltip:CreateFontString()
-- We only care about the Line2 left text (person's level without guild) and Line3 left text (person's level in a guild). 
tooltip:AddFontStrings(tooltip:CreateFontString(),tooltip:CreateFontString())
tooltip:AddFontStrings(toolText2, tooltip:CreateFontString())
tooltip:AddFontStrings(toolText3, tooltip:CreateFontString())
tooltip:SetOwner(UIParent, "ANCHOR_NONE")


local function tooltipScanner(guid)
	local tooltip = tooltip
	tooltip:ClearLines()
	tooltip:SetHyperlink('unit:' .. guid)
	if not tooltiptable[guid] then tooltiptable[guid] = true end

	local printline
	local lines = tooltip:NumLines()
	-- debugprint required stuff, can be deleted later.
	local class, classFilename, race, raceFilename, sex, name, realm = GetPlayerInfoByGUID(guid)
	
	if lines > 1 then
		if toolText2:GetText() and string.match(toolText2:GetText(), "Level %d+") then
			printline = string.match(toolText2:GetText(), "%d+")
			if not name then debugprint(4,"Tooltip: name not cached yet!",1,0,0); return; end
			debugprint(4,"Tooltip: scanning "..guid..": "..name..", "..printline)
			return tonumber(printline)
		elseif toolText3:GetText() and string.match(toolText3:GetText(), "Level %d+") then
			printline = string.match(toolText3:GetText(), "%d+")
			if not name then debugprint(4,"Tooltip: name not cached yet!",1,0,0); return; end
			debugprint(4,"Tooltip: scanning "..guid..": "..name..", "..printline)
			return tonumber(printline)
		elseif toolText2:GetText() and string.match(toolText2:GetText(), "Level ??") then
			debugprint(4,"Tooltip: scanning "..guid..": "..name..", ??")
			if UnitLevel("player") <= MAX_PLAYER_LEVEL_TABLE[GetAccountExpansionLevel()] - 10 then
				return UnitLevel("player")+10
			else
				return 0
			end
		elseif toolText3:GetText() and string.match(toolText3:GetText(), "Level ??") then
			debugprint(4,"Tooltip: scanning "..guid..": "..name..", ??")
			if UnitLevel("player") <= MAX_PLAYER_LEVEL_TABLE[GetAccountExpansionLevel()] - 10 then
				return UnitLevel("player")+10
			else
				return 0
			end
		end
	end 
end

-- This is where almost all of the magic is happening! CLEU <3
function EnemyScanner2:COMBAT_LOG_EVENT_UNFILTERED(_, _, minievent, _, guidsource, source, sourceflags, sourceflagsraid, guidtarget, target, targetflags, targetflagsraid, ...)
	-- bit.band the flag to check the following:
	-- Type: 					COMBATLOG_OBJECT_TYPE_PLAYER			0x00000400 
	-- Controller:				COMBATLOG_OBJECT_CONTROL_PLAYER			0x00000100 
	-- Reaction:				COMBATLOG_OBJECT_REACTION_HOSTILE		0x00000040
	-- Controller affiliation:	COMBATLOG_OBJECT_AFFILIATION_OUTSIDER	0X00000008
	-- PLAYER controlled by PLAYER which is REACTION HOSTILE and is OUTSIDER (not in raid or party with you).
	if bit.band(sourceflags,HOSTILEUNITFLAG) == HOSTILEUNITFLAG and (not UnitIsPVPSanctuary("player") or (debug and debug.EnemyScanner2)) then

		-- GUID is missing, exit.
		if guidsource == '' then
			debugprint(4,minievent..", "..guidsource and guidsource or "nil, "..source and source or "nil, "..sourceflags..", "..sourceflagsraid,...,1,0,0)
			return
		end

		-- Remove -Servername from player's name.
		local source = source:match("[^-]+")
		local spellID,spellName = ...
		local level

		-- GUID does not exist in database, add as level 0.
		if not db[guidsource] then
			db[guidsource] = 0
		end

		-- Spell alert will show messages only once, after spell has been applied.
		-- Might need to find a better way of printing the alerts on screen.
		if minievent == "SPELL_AURA_APPLIED" then
			if spellwatch[spellID] then
				local classFilename = select(2,GetPlayerInfoByGUID(guidsource))
				local texture = select(3,GetSpellInfo(spellID))
				local r,g,b = RAID_CLASS_COLORS[classFilename].r,RAID_CLASS_COLORS[classFilename].g,RAID_CLASS_COLORS[classFilename].b
				RaidNotice_AddMessage(RaidWarningFrame, source..": |T"..texture..":0|t"..spellName, RAID_CLASS_COLORS[classFilename])
				debugprint(4,source..": |T"..texture..":0|t"..spellName,r,g,b)
			end
		end

		-- Catch if action is melee.
		if minievent:match("[^_]+") == "SWING" then
			-- Turn ie. "SWING_MISS" text into "Swing Miss".
			spellName = minievent:gsub('_',' '):lower()
			spellName = spellName:gsub("(%l)(%w*)", function(a,b) return string.upper(a)..b end)
		end

		-- In case the level ain't clear yet (Melee strike/miss?)
		if not level then level = db[guidsource] and db[guidsource] or 0 end

		-- Check if action is spell.
		if minievent:match("[^_]+") ~= "SWING" and tonumber(spellID) then
			level = GetSpellLevelLearned(spellID)
			spellName = GetSpellLink(spellID)
		end

		-- If spell is greater than the one stored in database, upgrade it in the database.
		if level and (db[guidsource] < level) then
			-- If spell level is greater than current max level in player's expansion, don't upgrade.
			if level > MAX_PLAYER_LEVEL_TABLE[GetAccountExpansionLevel()] then
				level = MAX_PLAYER_LEVEL_TABLE[GetAccountExpansionLevel()]
			else
				level = GetSpellLevelLearned(spellID)
			end
			db[guidsource] = level
		end
		
		-- Let's do some tooltip scanning!
		local tooltiplevel
		if guidsource ~= '' and not tooltiptable[guidsource] and db[guidsource] < 90 then
			tooltiplevel = tooltipScanner(guidsource)
			if (tooltiplevel and level) and (tooltiplevel > level) then
				db[guidsource] = tooltiplevel
			end
		end
		
		local class, classFilename, race, raceFilename, sex, name, realm = GetPlayerInfoByGUID(guidsource)
		
		--[[ <START> debugprint for ChatFrame3 ]]
			local texture = select(3,GetSpellInfo(spellID))
			if not texture then
				texture = "Interface\\Icons\\INV_MISC_QUESTIONMARK"
			end
	
			local r,g,b
			if not classFilename then
				debugprint(3,"debugprint: "..guidsource.." does not have classFilename",1,0,0)
				r,g,b = 0.5,0.5,0.5
			else
				r,g,b = RAID_CLASS_COLORS[classFilename].r,RAID_CLASS_COLORS[classFilename].g,RAID_CLASS_COLORS[classFilename].b
			end
			local levelcolor = GetQuestDifficultyColor(db[guidsource])
			local levelcolorhex = DecimalToHex(levelcolor.r,levelcolor.g,levelcolor.b)
			debugprint(3,source.." |T"..texture..":0|t "..spellName.." - "..levelcolorhex..db[guidsource],r,g,b)
		--[[ <END> debugprint for ChatFrame3 ]]

		local found = false
		for i=1,#ES2messages do
			if source == ES2messages[i]["name"] then
				found = true
			end
		end
		-- If the player is new
		if not found then
			local uid = EnemyScanner2:AddMessage(source, db[guidsource], time()+EnemyScanner2DB.expire, classFilename)
			ES2temptable[guidsource] = uid
		-- If the player is already listed but does something new, refresh the expire.
		else
			local uid = ES2temptable[guidsource]
			EnemyScanner2:EditMessage(uid,db[guidsource],time()+EnemyScanner2DB.expire)
		end

		-- If we are not running onUpdate and there are messages in the queue, start it.
		updating = ES2timer:GetScript("OnUpdate")
		if not updating and next(ES2messages) then
			ES2timer:SetScript("OnUpdate",onUpdate)
		end
	end
end

local function ShowTooltip(self)
        GameTooltip:SetOwner(self, "ANCHOR_NONE")
        GameTooltip:SetPoint("BOTTOM", self, "TOP")
        GameTooltip:ClearLines()
        GameTooltip:AddLine("Doubleclick to clear messages")
        GameTooltip:Show()
end

local function HideTooltip()
        GameTooltip:Hide()
end

-- Initialize the anchor where rows are SetPoint'd.
function EnemyScanner2:Initialize()
	anchor:SetFrameStrata("MEDIUM")
	anchor:SetHeight(30)
	anchor:SetBackdrop(GameTooltip:GetBackdrop())
	anchor:SetBackdropColor(0.3, 0.3, 0.3)
	anchor.text = anchor:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
	anchor.text:SetAllPoints(true)
	anchor.text:SetText("EnemyScanner2")
	anchor:SetWidth(anchor.text:GetStringWidth() + 16)
	anchor:EnableMouse(true)
	anchor:SetMovable(true)
	anchor:RegisterForDrag("LeftButton")
	anchor:SetScript("OnDragStart", anchor.StartMoving)
	anchor:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
		EnemyScanner2DB.position.point, EnemyScanner2DB.position.x, EnemyScanner2DB.position.y = "BOTTOMLEFT", self:GetLeft(), self:GetBottom()
	end)
	anchor:SetScript("OnDoubleClick", function()
		ES2timer:SetScript("OnUpdate",nil)
		EnemyScanner2:Clear()
	end)
	anchor:SetScript("OnEnter", ShowTooltip)
	anchor:SetScript("OnLeave", HideTooltip)
	anchor:SetPoint(EnemyScanner2DB.position.point, EnemyScanner2DB.position.x, EnemyScanner2DB.position.y)
	anchor:Hide()
end

-- Adds a message to the alert frame, returns a uid.
function EnemyScanner2:AddMessage(name, level, spotted, class)
	if not name then debugprint(4,"AddMessage: Name not found!",1,0,0) return end
	if name == "Unknown" then debugprint(4,"AddMessage: Name not cached!",1,0,0) return end
	local uid = {
		name = name or "Unknown", 
		level = level or 1,
		spotted = spotted or time()+EnemyScanner2DB.expire,
		class = class or "Priest"
	}
	table.insert(ES2messages, uid)
	EnemyScanner2:Update()
	return uid
end


-- Edits a message if it already exists and is being displayed in alert frame.
function EnemyScanner2:EditMessage(uid,level,spotted)
	for i=1,#ES2messages do
		if ES2messages[i] == uid then
			ES2messages[i].level = level
			ES2messages[i].spotted = spotted
			EnemyScanner2:Update()
			return
		end
	end
end

-- Removes a message from the alert frame.
function EnemyScanner2:DelMessage(uid)
	for i=1,#ES2messages do
		if ES2messages[i] == uid then
			table.remove(ES2messages, i)
			EnemyScanner2:Update()
			return
		end
	end
end

-- Clears all messages from alert frame.
function EnemyScanner2:Clear()
	table.wipe(ES2messages)
	EnemyScanner2:Update()
end

-- Updates the frame to display.
function EnemyScanner2:Update()
	-- Create enough frames, if necessary.
	for i=#rows + 1, #ES2messages, 1 do
		row = CreateFrame("Button", nil, UIParent)
		row:SetFrameStrata("MEDIUM")
		row.text = row:CreateFontString(nil, "OVERLAY")
		row.text:SetPoint("RIGHT", 0, 0)
		row.text:SetJustifyH("RIGHT")
		rows[i] = row
	end
	-- Anchor the frames in order.
	for idx,entry in ipairs(ES2messages) do
		local row = rows[idx]
		if idx == 1 then
			row:ClearAllPoints()
			row:SetPoint("TOPRIGHT", anchor, "BOTTOMRIGHT", 0, 5)
		else
			row:ClearAllPoints()
			row:SetPoint("TOPRIGHT", rows[idx-1], "BOTTOMRIGHT", 0, 5)
		end
		row:SetHeight(20)
		row:SetWidth(250)
		row.text:SetFontObject("GameFontNormal")
		row:EnableMouse(false)
		-- Color the level by Difficulty
		local levelcolor = GetQuestDifficultyColor(entry.level)
		local levelcolorhex = DecimalToHex(levelcolor.r,levelcolor.g,levelcolor.b)
		row.text:SetText(entry.name.." "..levelcolorhex..entry.level)
		-- if raidclass is known use classcolor, else use gray.
		local raidclass = RAID_CLASS_COLORS[entry.class] and RAID_CLASS_COLORS[entry.class] or { ["r"] = 0.5, ["g"] = 0.5, ["b"] = 0.5,}
		row.text:SetTextColor(raidclass.r, raidclass.g, raidclass.b, 1)
		row:Show()
	end
	-- Hide any extra frames.
	for i=#rows, #ES2messages + 1, -1 do
		rows[i]:Hide()
	end   
end

-- Enable the addon by registering all the needed events.
EnemyScanner2:Enable()

-- Slashcommands!
SLASH_EnemyScanner21 = "/es"
SLASH_EnemyScanner22 = "/enemyscanner"
SLASH_EnemyScanner23 = "/es2"
SLASH_EnemyScanner24 = "/enemyscanner2"

SlashCmdList["EnemyScanner2"] = function()
	if anchor:IsVisible() then anchor:Hide() else anchor:Show() end
end