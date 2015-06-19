-- TODO: auto tracking using CHAT_MSG_SKILL/CHAT_MSG_SYSTEM or auto tracking on panel selection
-- TODO: save/restore skill filters if window is opened
local addonName, L = ...

local meta = { __index = function(t,k) return k end }
L = setmetatable( L, meta )

local f = CreateFrame("Frame", "AraSkills", UIParent) -- main frame
local g = CreateFrame("Frame", nil, f) -- alt frame 1
local h = CreateFrame("Frame", nil, f) -- alt frame 2
local e = CreateFrame"Frame" -- OnUpdate if config.displayCDs
local ex = CreateFrame"Frame" -- bucketed skill tracking
local configMenu, nbEntries, UpdateTablet
local config, realm, char, options, c
local CDs, shortcuts, workingFrame, prevAltSkill
local baseScript, SetTracking

local prevIndex = 0
local info = {}
local playerName, realmName = GetUnitName"player", GetRealmName()
local scanner = CreateFrame("GameTooltip", "ABTS_GT", nil, "GameTooltipTemplate")
scanner:SetOwner(UIParent, "ANCHOR_NONE")
local fmtReagents = _G.SPELL_REAGENTS

local BUTTON_HEIGHT, ICON_SIZE, GAP, TEXT_OFFSET = 17, 15, 10, 4
local PANEL, PROFESSION, COMBAT_SKILL, LINK, SECONDARY, SPELL_ID = 1, 2, 4, 8, 16, 256
local MAX_SKILL_VALUE = 300 + 75 * GetAccountExpansionLevel()
local defaultColors, colors = { header={1,1,1}, activeName={1,.82,0}, infoName={.6,.5,0}, selected={.9,0.45,.1}, highlight={1,.8,0}, ownCD={1,.82,0}, foreignCD={.6,.5,0} }
local AUTO = "AUTO"

local bit_band, date, tonumber, wipe, ipairs, tremove, GetProfessionInfo, GetSpellInfo, GetTradeSkillInfo, GetTradeSkillRecipeLink, tip =
	bit.band, date, tonumber, wipe, ipairs, tremove, GetProfessionInfo, GetSpellInfo, GetTradeSkillInfo, GetTradeSkillRecipeLink

local skills = {
	[L.Alchemy]=		PROFESSION +  2259*SPELL_ID + PANEL + LINK,
	[L.Archaeology]=	PROFESSION + 78670*SPELL_ID + PANEL + SECONDARY,
	[L.Blacksmithing]=	PROFESSION +  2018*SPELL_ID + PANEL + LINK,
	[L.Cooking]=		PROFESSION +  2550*SPELL_ID + PANEL + LINK + SECONDARY, -- campfire
	[L.Enchanting]=		PROFESSION +  7411*SPELL_ID + PANEL + LINK, -- d/e
	[L.Engineering]=	PROFESSION +  4036*SPELL_ID + PANEL + LINK,
	[L["First Aid"]]=	PROFESSION +  3273*SPELL_ID + PANEL + LINK + SECONDARY,
	[L.Fishing]=		PROFESSION +  131474*SPELL_ID + SECONDARY, -- changed from 7620, 131490
	[L.Herbalism]=		PROFESSION +  2366*SPELL_ID, -- track herbs changed from 2366
	[L.Inscription]=	PROFESSION + 45357*SPELL_ID + PANEL + LINK, -- mill
	[L.Jewelcrafting]=	PROFESSION + 25229*SPELL_ID + PANEL + LINK, -- prospect
	[L.Leatherworking]=	PROFESSION +  2108*SPELL_ID + PANEL + LINK,
	[L.Lockpicking]=	PROFESSION + 1809*SPELL_ID + SECONDARY,
	[L.Runeforging]=	PROFESSION + 53428*SPELL_ID + PANEL + SECONDARY,
	[L.Skinning]=		PROFESSION +  8613*SPELL_ID,
	[L.Smelting]=		PROFESSION +  2580*SPELL_ID + PANEL, -- track minerals (icons: 2575=mining, 2580=smelting)
	[L.Tailoring]=		PROFESSION +  3908*SPELL_ID + PANEL + LINK,
	None =			0
}
local altNames = setmetatable( {
	[L.Mining] =		L.Smelting,
	[L.RuneforgingDN] =	L.Runeforging,
}, meta )

local revAlt = setmetatable( {}, meta )
for k,v in next, altNames do revAlt[v] = k end

local groupIcons = {
	["Transmutes"] = "Interface\\Icons\\Spell_Nature_ElementalPrecision_2",
  ["Facets of Research"] = "Interface\\Icons\\inv_misc_gem_variety_02",
	["Magnificient Hide"] = "Interface\\Icons\\inv_misc_pelt_08",
}

local HOUR, DAY, MIDNIGHT, DAWN = 3600, 86400, -1, -2
local TRANSMUTE_G1 = { skill= L.Alchemy, CD= DAWN, group= "Transmutes" }
local JCRESEARCH_G1 = { skill= L.Jewelcrafting, CD=DAWN, group="Facets of Research" } -- (Thanks for the research name, Uggers!)
local LWHIDE_G1 = {skill= L.Leatherworking, CD=DAWN, group= "Magnificent Hide" } -- (Thanks, Griffin224!)
	
local watchedCDs = {
	[11479]= TRANSMUTE_G1, -- Iron to Gold
	[11480]= TRANSMUTE_G1, -- Mithril to Truesilver
	[17559]= TRANSMUTE_G1, -- Air to Fire
	[17566]= TRANSMUTE_G1, -- Earth to Life
	[17561]= TRANSMUTE_G1, -- Earth to Water
	[17560]= TRANSMUTE_G1, -- Fire to Earth
	[17565]= TRANSMUTE_G1, -- Life to Earth
	[17563]= TRANSMUTE_G1, -- Undeath to Earth
	[17562]= TRANSMUTE_G1, -- Water to Air
	[17564]= TRANSMUTE_G1, -- Water to Undeath
	[28566]= TRANSMUTE_G1, -- Primal Air to Fire
	[28585]= TRANSMUTE_G1, -- Primal Earth to Life
	[28567]= TRANSMUTE_G1, -- Primal Earth to Water
	[28568]= TRANSMUTE_G1, -- Primal Fire to Earth
	[28583]= TRANSMUTE_G1, -- Primal Fire to Mana
	[28584]= TRANSMUTE_G1, -- Primal Life to Earth
	[28582]= TRANSMUTE_G1, -- Primal Mana to Fire
	[28580]= TRANSMUTE_G1, -- Primal Shadow to Water
	[28569]= TRANSMUTE_G1, -- Primal Water to Air
	[28581]= TRANSMUTE_G1, -- Primal Water to Shadow
	[53777]= TRANSMUTE_G1, -- Eternal Air to Earth
	[52776]= TRANSMUTE_G1, -- Eternal Air to Water
	[53781]= TRANSMUTE_G1, -- Eternal Earth to Air
	[53782]= TRANSMUTE_G1, -- Eternal Earth to Shadow
	[53775]= TRANSMUTE_G1, -- Eternal Fire to Life
	[53774]= TRANSMUTE_G1, -- Eternal Fire to Water
	[53773]= TRANSMUTE_G1, -- Eternal Life to Fire
	[53771]= TRANSMUTE_G1, -- Eternal Life to Shadow
	[54020]= TRANSMUTE_G1, -- Eternal Might
	[53779]= TRANSMUTE_G1, -- Eternal Shadow to Earth
	[52780]= TRANSMUTE_G1, -- Eternal Shadow to Life
	[53783]= TRANSMUTE_G1, -- Eternal Water to Air
	[53784]= TRANSMUTE_G1, -- Eternal Water to Fire

	[66658]= TRANSMUTE_G1, -- Ametrine
	[66659]= TRANSMUTE_G1, -- Cardinal Ruby
	[66662]= TRANSMUTE_G1, -- Dreadstone
	[66664]= TRANSMUTE_G1, -- Eye of Zul
	[66660]= TRANSMUTE_G1, -- King's Amber
	[66663]= TRANSMUTE_G1, -- Majestic Zircon

	-- [28027]= { skill= L.Enchanting,		CD= 2*DAY },		-- Prismatic Sphere
	-- [28028]= { skill= L.Enchanting,		CD= 2*DAY },		-- Void Sphere
	[47280]= { skill= L.Jewelcrafting,	CD=   DAWN },	-- Brilliant Glass
	[62242]= { skill= L.Jewelcrafting,	CD=   DAWN },	-- Icy Prism
--	[56005]= { skill= L.Tailoring,		CD= 6*DAY+20*HOUR },	-- Glacial Bag
	[61288]= { skill= L.Inscription,	CD=   DAWN },	-- Minor Glyph RS
	[61177]= { skill= L.Inscription,	CD=   DAWN },	-- Major Glyph RS
	[60893]= { skill= L.Alchemy,		CD= 3*DAWN },	-- Alchemy Research
	[44717]= { skill= "Item",		CD= 3*DAY },		-- Disgusting Jar (ripe jar: 44718)
	[39878]= { skill= "Item",		CD= 3*DAY },		-- Mysterious Egg (cracked egg: 39883)


	-------------------------------------- CATACLYSM ---------------------------------


	[78866]= TRANSMUTE_G1, -- Living Elements
--	[80237]= TRANSMUTE_G1, -- Shadowspirit Diamond (meta)
--	[80245]= TRANSMUTE_G1, -- Inferno Ruby
--	[80246]= TRANSMUTE_G1, -- Ocean Sapphire
--	[80247]= TRANSMUTE_G1, -- Amberjewel
--	[80248]= TRANSMUTE_G1, -- Demonseye
--	[80250]= TRANSMUTE_G1, -- Ember Topaz
--	[80251]= TRANSMUTE_G1, -- Dream Emerald

	[80243]= TRANSMUTE_G1, -- Truegold
	[80244]= TRANSMUTE_G1, -- Pyrium Bar
	
	[73478]= { skill= L.Jewelcrafting,	CD=		20*HOUR },	-- Fire Prism
	[89244]= { skill= L.Inscription,		CD=		DAWN },	-- Forged Documents (alliance)
	[86654]= { skill= L.Inscription,		CD=		DAWN },	-- Forged Documents (horde)
	[75141]= { skill= L.Tailoring,			CD=	6*DAY+20*HOUR },	-- Dream of Skywall
	[75142]= { skill= L.Tailoring,			CD=	6*DAY+20*HOUR },	-- Dream of Deepholm
--	[94743]= { skill= L.Tailoring,		CD=  },		-- Dream of Destruction
	[75144]= { skill= L.Tailoring,			CD= 6*DAY+20*HOUR },	-- Dream of Hyjal
	[75145]= { skill= L.Tailoring,			CD= 6*DAY+20*HOUR },	-- Dream of Ragnaros
	[75146]= { skill= L.Tailoring,			CD= 6*DAY+20*HOUR },	-- Dream of Azshara
	
	-------------------------------------- PANDARIA ---------------------------------
	-- Jewelcrafting
	[131593]= JCRESEARCH_G1, --{ skill= L.Jewelcrafting,	CD=   MIDNIGHT }, -- River's Heart (Blue)
	[131695]= JCRESEARCH_G1, --{ skill= L.Jewelcrafting,	CD=   MIDNIGHT }, -- Sun's Radiance (Yellow)
	[131690]= JCRESEARCH_G1, --{ skill= L.Jewelcrafting,	CD=   MIDNIGHT }, -- Vermilion Onyx (Orange)
	[131686]= JCRESEARCH_G1, --{ skill= L.Jewelcrafting,	CD=   MIDNIGHT }, -- Primordial Ruby (Red)
	[131691]= JCRESEARCH_G1, --{ skill= L.Jewelcrafting,	CD=   MIDNIGHT }, -- Imperial Amethyst (Purple)
	[131688]= JCRESEARCH_G1, --{ skill= L.Jewelcrafting,	CD=   MIDNIGHT }, -- Wild Jade (Green)
	[140050]= { skill= L.Jewelcrafting, CD=	DAWN }, -- Serpent's Heart, suggested by Anteract
	-- Alchemy
	[114780]= TRANSMUTE_G1, -- Transmute: Living Steel (Thanks Xanatandor!)
	-- Enchanting
	[116499]= { skill= L.Enchanting,		CD=	DAWN }, -- Sha Crystal
	--Tailoring
	[125557]= { skill= L.Tailoring,			CD=	DAWN }, -- Imperial Silk
	[143011]= { skill= L.Tailoring,			CD= DAWN }, -- Celestial Cloth
	--Inscription
	[112996]= { skill= L.Inscription,		CD=	DAWN }, -- Scroll of Wisdom
	--Blacksmithing
	[138646]= { skill= L.Blacksmithing,	CD=	DAWN }, -- Lightning Steel Ingot
	[143255]= { skill= L.Blacksmithing, CD= DAWN }, -- Balanced Trillium Ingot
	--Leatherworking
	[140040]= LWHIDE_G1, -- Magnificence of Leather
	[140041]= LWHIDE_G1, -- Magnificence of Scales
	[142976]= { skill= L.Leatherworking, CD= DAWN }, -- Hardened Magnificent Hide
	--Engineering
  [139176]= { skill= L.Engineering, CD= DAWN }, -- Jard's Peculiar Energy Source
  
  ------------------------ Draenor ------------------------------
	--Blacksmithing
	[176090]= { skill= L.Blacksmithing,	CD=	DAWN }, -- Secrets of Draenor Blacksmithing
	[171690]= { skill= L.Blacksmithing,	CD=	DAWN }, -- Truesteel Ingot
	--Enchanting
	[177043]= { skill= L.Enchanting,	CD=	DAWN }, -- Secrets of Draenor Enchanting
	[169092]= { skill= L.Enchanting,	CD=	DAWN }, -- Temporal Crystal
	--Engineering
	[177054]= { skill= L.Engineering,	CD=	DAWN }, -- Secrets of Draenor Engineering
	[169080]= { skill= L.Engineering,	CD=	DAWN }, -- Gearspring Parts
	--Jewelcrafting
	[176087]= { skill= L.Jewelcrafting,	CD=	DAWN }, -- Secrets of Draenor Jewelcrafting
	[170700]= { skill= L.Jewelcrafting,	CD=	DAWN }, -- Taladite Crystal
	--Tailoring
	[176058]= { skill= L.Tailoring,	CD=	DAWN }, -- Secrets of Draenor Tailoring
	[168835]= { skill= L.Tailoring,	CD=	DAWN }, -- Hexweave Cloth
	--Inscription
	[177045]= { skill= L.Inscription,	CD=	DAWN }, -- Secrets of Draenor Inscription
	[169081]= { skill= L.Inscription,	CD=	DAWN }, -- War Paints
	--Alchemy
	[175880]= { skill= L.Alchemy,	CD=	DAWN }, -- Secrets of Draenor Alchemy
	[156587]= { skill= L.Alchemy,	CD=	DAWN }, -- Alchemical Catalyst
	[181643]= { skill= L.Alchemy,   CD= DAWN }, -- Transmute: Savage Blood
	--Leatherworking
	[176089]= { skill= L.Leatherworking,	CD=	DAWN }, -- Secrets of Draenor Leatherworking
	[171391]= { skill= L.Leatherworking,	CD=	DAWN }, -- Burnished Leather
}

local watchedIndex, watchedSpell, watchedID, watchedIcon
--local orgDoTradeSkill = _G.DoTradeSkill

function abtDoTradeSkill(index, ...)
  if not GetTradeSkillRecipeLink(index) then return end
	watchedID = tonumber( (GetTradeSkillRecipeLink(index)):match"enchant:(%d+)" )
	if watchedCDs[watchedID] then
		watchedIndex, watchedSpell, watchedIcon = index, GetTradeSkillInfo(index), GetTradeSkillIcon(index)
		f:RegisterEvent"UNIT_SPELLCAST_SUCCEEDED"
		f:RegisterEvent"UNIT_SPELLCAST_STOP"
	end
	--return orgDoTradeSkill(index, ...)
end

hooksecurefunc("DoTradeSkill", abtDoTradeSkill)


local function CheckReagents(...)
	local maxQuantity = 999
	for i=1, select("#",...) do
		local reagent = select(i,...)
		local item, count = reagent:match"(.+).%((%d+)%)$" --TEXT_MODE_A_STRING_VALUE_TYPE "%s (%s)"
		if not count then item, count = reagent, 1 end
		local quantity = GetItemCount(item,true) / count
		if quantity < maxQuantity then maxQuantity = quantity end
		if maxQuantity == 0 then return 0 end
	end
	return floor(maxQuantity)
end

local function GetMaxFeasible(spellID)
	local quantity = 0
	scanner:ClearLines()
	scanner:SetHyperlink("spell:"..spellID)
	for i=2, scanner:NumLines() do
		local text = _G[("ABTS_GTTextLeft%i"):format(i)]:GetText()
		if text:find(fmtReagents) then
			text = text:sub(#fmtReagents+1)
			quantity = CheckReagents( (","):split( text:gsub(", ",","), 8 ) )
			break
		end
	end
	return quantity
end

-- function GetTimeUnits(str)
--	t = {}
--	print(str)
	-- Strip out color code (wtf blizzard?)
	-- str=string.sub(str, 11)
	-- print(str)
--	str=SecondsToTime(GetQuestResetTime())
--	print("Before match: "..str)
--	for k,v in string.gmatch(str, "(%d?%d)(%a?%a?%a)") do
--		print("V="..v.." K="..k)
--		t[v]=k
--	end
--	return t
-- end

--/script str=SecondsToTime(GetQuestResetTime());print("Before match: "..str);for k,v in string.gmatch(str, "(%d?%d)(%a?%a?%a)") do print("V="..v.." K="..k) end

-- function FindRealmResetTime(timeLeft)
  -- *********************************************************************
	-- * THIS IS WHERE WE NEED TO FOCUS TO GET THAT COOLDOWN TIMER WORKING *
	-- Hints at http://us.battle.net/wow/en/forum/topic/7392649782?page=1#8
	
	-- local hours,minutes = GetGameTime()
	-- print("Before function: "..SecondsToTime(timeLeft, false, false,5))
	-- local RealmTimeTable = GetTimeUnits(SecondsToTime(GetQuestResetTime(), false, false, 5))
	--Put check for hours being 0.
	-- local ResetHours = RealmTimeTable["h"]
	-- if not ResetHours then
		-- ResetHours = 0
	-- end
	-- local ResetMinute = RealmTimeTable["m"]
	-- local MinuteOffset = 1
	-- if minutes==0 then
	--	MinuteOffset=0
	-- end
	-- print("ResetHours= "..ResetHours)
	-- local HourReset = hours+tonumber(ResetHours)+MinuteOffset
	-- if HourReset>=24 then
	-- 	HourReset=HourReset-24
	-- end
	--print("Dawn Cooldown, ResetHours="..ResetHours.." ResetMinute="..ResetMinute)
	-- print("Time="..hours..":"..minutes..", CD="..SecondsToTime(timeLeft, false, false, 5)..", Realm Reset Time="..HourReset)
	-- return HourReset
	-- *********************************************************************
	-- * After all this, need to turn it into a time value and add to the
	-- * current time value, so that it can be saved in the settings file
	-- * as a "future cooldown date".
-- end

function f:UNIT_SPELLCAST_STOP(event, unit, spell)
	if unit ~= "player" or spell ~= watchedSpell then return end
	f:UnregisterEvent"UNIT_SPELLCAST_SUCCEEDED"
	f:UnregisterEvent"UNIT_SPELLCAST_STOP"
	if event ~= "UNIT_SPELLCAST_SUCCEEDED" then return end
	local cd, ownGroup = watchedCDs[watchedID]
	-- local start, dur, enabled = GetSpellCooldown(watchedID)
	-- print ("Start:"..start.." Duration: "..dur.." Enabled?: "..enabled)
	-- if duration then
	local duration = cd.CD
	if duration < 0 then -- reset after Dawn
	--	print("Midnight cooldown detected!")
	--	local hours, minutes = GetGameTime()
	--	duration = (-duration-1)*DAY + (24-hours)*HOUR - minutes*60 - 30
	-- elseif duration ==-2 then -- reset after dawn
	-- print("After dawn cooldown detected!")
	--	local hours, minutes = GetGameTime()
	--	if hours<=3 then
	--		duration = (3-hours)*HOUR - minutes*60 - 30
	--	else
	--		duration = (27-hours)*HOUR - minutes*60 - 30
	-- 	end
		char[watchedID] = time() + GetQuestResetTime()
	else
		char[watchedID] = time() + duration
	end
	if cd.group then
		ownGroup = cd.group .. "-" .. playerName
		config.names[ownGroup] = watchedID
	end
	config.icons[ownGroup or watchedID] = watchedIcon
	if config.displayCDs then e.timer = 0 end
	if f:IsShown() then UpdateTablet() end
	-- end
end
f.UNIT_SPELLCAST_SUCCEEDED = f.UNIT_SPELLCAST_STOP

local new, del

do
	local tables = setmetatable( {}, { __mode = "k" } )
	new = function(...)
		local t = next(tables)
		if t then tables[t] = nil else t = {} end
		for i = 1, select("#", ...), 2 do
			local k, v = select(i, ...)
			t[k] = v
		end
		return t
	end
	new1 = function(...)
		local t = next(tables)
		if t then tables[t] = nil else t = {} end
		for i = 1, select("#", ...) do t[i] = select(i,...) end
		return t
	end

	del = function(t)
		tables[wipe(t)] = true
	end

end

local getProfessions
do
	local p = {}
	getProfessions = function()
		del(p)
		p = new1( GetProfessions() )
		return p
	end
end

local md, mx, xx, dd = 20*HOUR, 3*DAY+20*HOUR, { DAY, HOUR, 60, 1 }, { L.d, L.h, L.m, L.s }
local function SecondsToTime(s)
	local p = s<md and s/md*.5 or s<mx and (s-md)/(mx-md)*.5+.5 or 1
	local i = s>=DAY and 1 or s>=HOUR and 2 or 3
	return ("|cff%.2x%.2x40%i%s %.2i%s|r"):format(
		p<.5 and 64+p*382 or 255, p<.5 and 255 or 446-p*382,
		floor(s/xx[i]), dd[i], floor((s%xx[i])/xx[i+1]), dd[i+1] )
end

local function ColorCurMax(cur,max,isProfession,NonTrainable)
	local pMax = isProfession and min(max/MAX_SKILL_VALUE,1) or 1
	local pCur = isProfession and 1-min(sqrt(max-cur)/10,1) or 2/sqrt(max-cur+4)
	if not NonTrainable then
		return ("|cff%.2x%.2x00%.3i|r / |cff%.2x%.2x00%.3i|r"):format(
		pCur<.5 and 255 or 510-pCur*510, pCur<.5 and pCur*510 or 255, cur,
		pMax<.5 and 255 or 510-pMax*510, pMax<.5 and pMax*510 or 255, max )
	else
		return ("      |cff%.2x%.2x00%.3i|r"):format(
		pCur<.5 and 255 or 510-pCur*510, pCur<.5 and pCur*510 or 255, cur,
		pMax<.5 and 255 or 510-pMax*510, pMax<.5 and pMax*510 or 255, max )
	end
end

local function SortSkills(a, b)
	if not a.isProfession == not b.isProfession then
		if a.primary == b.primary then
			return a.displayName < b.displayName
		else	return a.primary end
	else return a.isProfession end
end

local function SortCooldowns(a, b)
	if a.group and a.group == b.group then
		return a.timeLeft > b.timeLeft
	else	return a.name < b.name end
end

local function SortShortcuts(a, b)
	if a.skill == b.skill then
		return a.name < b.name
	else	return a.skill < b.skill end
end

local function SortAltSkills(a, b)
	local primA = bit_band( skills[a] or SECONDARY, SECONDARY ) == 0
	local primB = bit_band( skills[b] or SECONDARY, SECONDARY ) == 0
	if primA == primB then
		return a < b
	else	return primA end
end

local function SortAlts(a, b)
	return a.name < b.name
end

local function UpdateText()
	local skill = char.track and char.trackedSkill ~= AUTO and char.trackedSkill or char.skill
	f.block.icon = skill and select(3, GetSpellInfo( skills[ altNames[skill] ] / SPELL_ID ) ) or "Interface\\Minimap\\Tracking\\Profession"
	if char.track and skill then
	  if not char.maxSkills[skill] then
			f.block.text = char.skill or _G.TRADE_SKILLS
		else
			f.block.text = ColorCurMax( char.curSkills[skill], char.maxSkills[skill], bit_band( skills[skill], PROFESSION ) > 0 )
		end
	elseif not config.displayCDs then
		f.block.text = char.skill or _G.TRADE_SKILLS
	end
end

local orgAbandonSkill = _G.AbandonSkill
function AbandonSkill(...)
	if char.skill == GetProfessionInfo(...) then
		char.skill = nil
		SetTracking()
	end
	return orgAbandonSkill(...)
end

local highlight = g:CreateTexture()
highlight:SetTexture("Interface\\QuestFrame\\UI-QuestLogTitleHighlight")
highlight:SetBlendMode("ADD")
highlight:SetAlpha(0)

local function ShowBlockHints()
	if config.hideTips or not f:IsShown() then return end
	tip:SetOwner(f, "ANCHOR_NONE")
	local showRight = UIParent:GetWidth()/config.scale-f:GetLeft() < f:GetRight() and "LEFT" or "RIGHT"
	local showBelow = UIParent:GetHeight()/config.scale-f:GetTop() < f:GetBottom() and "TOP" or "BOTTOM"
	tip:SetPoint(showBelow..showRight, f, (showBelow == "TOP" and "BOTTOM" or "TOP")..showRight )
	tip:AddLine(L["Hints [|cffffffffBlock|r]"])
	tip:AddLine(L["|cffff8020Click|r to toggle panel."], 0.2, 1, 0.2)
	tip:AddLine(L["|cffff8020Right-Click|r to show config menu."], 0.2, 1, 0.2)
	tip:Show()
end

local function Block_OnEnter(frame)
	CloseDropDownMenus()
	f:Show()
	f.onBlock = true
	f:ClearAllPoints()
	local showBelow = select(2, frame:GetCenter()) > UIParent:GetHeight() / 2
	f:SetPoint(showBelow and "TOP" or "BOTTOM", frame, showBelow and "BOTTOM" or "TOP")
	highlight:SetVertexColor(unpack(colors.highlight))
	if Skinner then
		Skinner:applySkin(f)
--	else
--		f:SetBackdropColor( unpack( colors.background ) )
--		f:SetBackdropBorderColor( unpack( colors.border ) )
	end
	UpdateTablet()
	ShowBlockHints()
end

local function IsMouseOut()
	return not (f.onBlock or f:IsMouseOver() or g:IsShown() and g:IsMouseOver() or h:IsShown() and h:IsMouseOver())
end

local function Block_OnLeave(frame)
	f.onBlock = nil
	tip:Hide()
	if IsMouseOut() then f:Hide() end
end

--local function ToggleSFX()
--	if not config.silent then return end
--	if not f.soundFlag then
--		f.soundFlag = GetCVar"Sound_EnableSFX"
--		SetCVar("Sound_EnableSFX", 0)
--	else
--		SetCVar("Sound_EnableSFX", f.soundFlag)
--		f.soundFlag = nil
--	end
--end

--local function CloseTradeSkill()
--	ToggleSFX()
--	_G.CloseTradeSkill()
--	ToggleSFX()
--end


-- actions:	scan, link, craft, point, open (toggle)
-- args:	spellID (required for: craft, point), craftAll (option for: craft (shortcuts))
local function CastSpellByName(skillName)
--	ToggleSFX()
	if f.action == "point" or f.craftAll or f.action ~= "open" and TradeSkillFrame and TradeSkillFrame:IsVisible() then
		f.keepOpen = true
	--	if f.action == "point" then print("action = point") end -- DEBUG
		CloseTradeSkill()
	end
	f:RegisterEvent"TRADE_SKILL_SHOW"
	_G.CastSpellByName(skillName)
--	if f.action == "point" then print("action blanked") end -- DEBUG
	prevAltSkill, f.action, f.spellID, f.craftAll, f.keepOpen = nil
--	ToggleSFX()
end

local function Tradeskill_OnClick(button, click)
	if IsShiftKeyDown() and bit_band( skills[button.skill], LINK ) > 0 then
		f.action = "link"
	elseif click == "RightButton" then
		if bit_band( skills[button.skill], PANEL ) == 0 then return end
		f.action = "scan"
	elseif click == "MiddleButton" then
		char.show[button.skill] = not char.show[button.skill]
		return UpdateTablet()
	else
		local hasPanel = bit_band( skills[button.skill], PANEL ) > 0

		if (char.track and char.trackedSkill == AUTO or hasPanel) and button.skill ~= L.Runeforging then
			char.skill = button.skill
			UpdateText()

			button.fontLeft:SetTextColor(unpack(colors.selected))
			if f.selected and f.selected ~= button then
				local skill = skills[f.selected.skill]
				local color = skill and bit_band( skill, PANEL ) == 0 and colors.infoName or colors.activeName
				f.selected.fontLeft:SetTextColor(unpack(color))
			end
			f.selected = button
		end
		if not hasPanel then return end
		f.action = "open"
	end
	CastSpellByName(button.skill)
end

local function Cooldown_OnClick(button, click)
	local group = watchedCDs[button.spellID].group
	if click == "MiddleButton" then
		local char = realm[button.owner]
		if group then -- remove group
			for k, v in next, watchedCDs do
				if v.group == group then char[k] = nil end
			end
		else
			char[button.spellID] = nil
		end
		UpdateTablet()
	elseif button.skill == "Item" then
		return
	elseif click == "LeftButton" and IsControlKeyDown() then
		f.alias, f.aliasID = button.fontLeft:GetText():gsub( " %[%d+%]", "" ), group or button.spellID
		StaticPopup_Show("ABTS_SET_ALIAS", config.names[button.spellID] or group)
	else
		f.action = (button.ready and button.hasReagents and click == "LeftButton" and not IsModifierKeyDown()) and "craft" or "point"
		f.spellID = button.spellID
		CastSpellByName(button.skill)
	end
end

local function Shortcut_OnClick(button, click)
	if IsControlKeyDown() then
		f.alias, f.aliasID = button.fontLeft:GetText(), button.spellID
		StaticPopup_Show("ABTS_SET_ALIAS", config.names[button.spellID])
	elseif click == "MiddleButton" then
		char.shortcuts[button.spellID] = nil
		UpdateTablet()
	else
		f.action = (click ~= "RightButton" and button.hasReagents) and "craft" or "point"
		f.craftAll = click ~= "LeftButton" and click ~= "RightButton" or IsShiftKeyDown()
		f.spellID = button.spellID
		CastSpellByName(button.skill)
	end
end

local function Link_OnClick(button, click)
	if not button.link then return end
	if IsModifierKeyDown() then
		if not ChatEdit_InsertLink(button.link) then
			ChatEdit_GetLastActiveWindow():Show()
			ChatFrame_OpenChat(" "..button.link)
		end
	elseif click == "LeftButton" then
		if prevAltSkill == button.owner..button.skill and TradeSkillFrame and TradeSkillFrame:IsVisible() then
			return CloseTradeSkill()
		end
		prevAltSkill = button.owner..button.skill
	--	ToggleSFX()
		SetItemRef(button.link:match"|H([^|]+)")
	--	ToggleSFX()
	end
end

local function ProfessionsBook_OnClick()
	ProfessionsBook:ShowFrame()
end

local function Alt_OnEnter(self)
	if self and self.light then
		highlight:SetAllPoints(self)
		highlight:SetAlpha(1)

		if config.hideTips then return end
		local hasLink = bit_band( skills[self.skill], LINK ) > 0
		if not( self.link or hasLink ) then return end

		tip:SetOwner(g, "ANCHOR_NONE")
		local showRight = f:GetCenter() > UIParent:GetWidth()/config.scale/2 and "RIGHT" or "LEFT"
		local showBelow = select(2, g:GetCenter()) > UIParent:GetHeight()/config.scale/2 and "TOP" or "BOTTOM"
		tip:SetPoint(showBelow..showRight, self:GetParent(), (showBelow == "TOP" and "BOTTOM" or "TOP")..showRight )

		tip:AddLine(L.Hints)
		if self.link then
			tip:AddLine(L["|cffff8020Click|r to toggle panel."], .2,1,.2)
			tip:AddLine(L["|cffff8020Shift+Click|r to link in chat."], .2,1,.2)
		elseif hasLink then
			tip:AddLine(L["No link available. Open a character\ntradeskill panel to be able to access\nit from your other characters."], 1, .6, .2)
		end
		tip:Show()
	end
end

local function Alt_OnLeave(self)
	highlight:ClearAllPoints()
	if self and self.light then
		highlight:SetAlpha(0)
		tip:Hide()
	end
	if IsMouseOut() then f:Hide() end
end

local function Menu_OnEnter(self)
	if self and self.light then
		highlight:SetAllPoints(self)
		highlight:SetAlpha(1)
		if config.hideTips or self.skill == "None" then return end
		tip:SetOwner(f, "ANCHOR_NONE")
		local showRight = f:GetCenter() > UIParent:GetWidth()/config.scale/2 and "LEFT" or "RIGHT"
		local showBelow = select(2, f:GetCenter()) > UIParent:GetHeight()/config.scale/2 and "TOP" or "BOTTOM"
		tip:SetPoint(showBelow..showRight, f, (showBelow == "TOP" and "BOTTOM" or "TOP")..showRight )
		tip:AddLine(L.Hints)
		if self.shortcut then
			tip:AddLine(L["|cffff8020Click|r to craft."], .2,1,.2)
			tip:AddLine(L["|cffff8020Shift+Click|r to craft all."], .2,1,.2)
			tip:AddLine(L["|cffff8020Control+Click|r to set an alias."], .2,1,.2)
			tip:AddLine(L["|cffff8020Right-Click|r to show in panel."], .2,1,.2) -- "to show craft" would be better
		elseif self.spellID then
			tip:AddDoubleLine(L["Belongs to:"], self.owner, 1,1,1,1,1,1)
			if self.skill ~= "Item" then
				if self.owner == playerName and self.ready then
					tip:AddLine(L["|cffff8020Click|r to craft."], .2,1,.2)
					tip:AddLine(L["|cffff8020Right-Click|r to show CD in panel."], .2,1,.2)
				elseif char.show[watchedCDs[self.spellID].skill] ~= nil then
					tip:AddLine(L["|cffff8020Click|r to show CD in panel."], .2,1,.2) -- "to show CD"
				end
				tip:AddLine(L["|cffff8020Control+Click|r to set an alias."], .2,1,.2)
			end
		else
			local hasPanel = bit_band( skills[self.skill], PANEL ) > 0
			local hasLink = bit_band( skills[self.skill], LINK ) > 0
			if hasPanel then tip:AddLine(L["|cffff8020Click|r to toggle panel."], .2,1,.2) end
			if hasLink then	tip:AddLine(L["|cffff8020Shift+Click|r to link in chat."], .2,1,.2) end
			if hasPanel then tip:AddLine(L["|cffff8020Right-Click|r to scan for CDs."], .2,1,.2)
			elseif char.track and char.trackedSkill == AUTO then tip:AddLine(L["|cffff8020Click|r to track."], .2, 1, .2) end
		end
		tip:AddLine(L["|cffff8020Middle-Click|r to remove from list."], .2,1,.2)
		tip:Show()
	end
end

local function Menu_OnLeave(self)
	highlight:ClearAllPoints()
	if self and self.light then
		highlight:SetAlpha(0)
		tip:Hide()
	end
	if IsMouseOut() then f:Hide() end
end

local function OnMouseWheel(self, delta)
	if not IsControlKeyDown() then return end
	config.scale = config.scale - delta * 0.05
	UpdateTablet()
end

local metatable = { __index = function(table, key)
	local button = CreateFrame("Button", nil, workingFrame)
	rawset(table, key, button)
	button:RegisterForClicks"AnyUp"
	button:SetHeight(BUTTON_HEIGHT)
	button:SetPoint("TOPLEFT", workingFrame, "TOPLEFT", GAP, BUTTON_HEIGHT * (1-key) - GAP)
	button:SetScript("OnEnter", workingFrame == f and Menu_OnEnter or Alt_OnEnter)
	button:SetScript("OnLeave", workingFrame == f and Menu_OnLeave or Alt_OnLeave)
	button:SetScript("OnMouseWheel", OnMouseWheel)
	button.icon = button:CreateTexture(nil, "OVERLAY")
	button.icon:SetWidth(ICON_SIZE) button.icon:SetHeight(ICON_SIZE)
	button.icon:SetPoint("LEFT", button, "LEFT")
	button.fontLeft = button:CreateFontString(nil, "OVERLAY", "SystemFont_Shadow_Med1")
	button.fontLeft:SetPoint("LEFT", button, "LEFT", ICON_SIZE + TEXT_OFFSET, 0)
	button.fontRight = button:CreateFontString(nil, "OVERLAY", "SystemFont_Shadow_Med1")
	button.fontRight:SetPoint("RIGHT", button, "RIGHT")
	return button
end }

local buttons = setmetatable( {}, metatable )
local altButtons = setmetatable( {}, metatable )
local altButtons2 = setmetatable( {}, metatable )

local function AddEntry( buttons, icon, leftText, leftTextColor, rightText, rightTextColor, highlight )
	nbEntries = nbEntries + 1
	local button = buttons[nbEntries]
	button.icon:SetTexture(icon or "")
	if icon then button.icon:SetTexCoord(0.075, 0.925, 0.075, 0.925) end
	button.fontLeft:SetText(leftText or "")
	if leftTextColor then button.fontLeft:SetTextColor(unpack(leftTextColor)) end
	button.fontRight:SetText(rightText or "")
	if rightTextColor then button.fontRight:SetTextColor(unpack(rightTextColor)) end
	button.light = highlight
	button:Show()
	return button, ICON_SIZE + TEXT_OFFSET + (leftText and button.fontLeft:GetStringWidth() or 0), rightText and button.fontRight:GetStringWidth() or 0
end

local function UpdateCDs()
	local readyCDs = 0
	local temp = new()
	local dups = new()
	local now = time()

	for i, v in next, CDs do
		del(v)
		CDs[i] = nil
	end

	for char, data in next, realm do
		for spellID, expireTime in next, data do
			if type(spellID)=="number" then
				local cd = watchedCDs[spellID]
				if cd then
					temp[#temp+1] = new(
						"name", cd.group and (config.aliases[cd.group] or cd.group) or
							config.aliases[spellID] or
							config.names[spellID] or
							GetSpellInfo(spellID),
						"timeLeft", expireTime-now, -- Check for server time - local time here?
						"char", char,
						"spellID", spellID,
						"skill", cd.skill,
						"group", cd.group,
						"ownGroup", cd.group and cd.group.."-"..char or nil)
				end
			end
		end
	end
	--sort(temp, SortCooldowns)

	for i=1, #temp do
		local cd = temp[i]
		if not dups[cd.ownGroup] then
			CDs[#CDs+1] = cd
			temp[i] = nil
			if cd.timeLeft <= 0 then readyCDs = readyCDs + 1 end
		end
		if cd.group then
			dups[cd.ownGroup] = true
		end
	end

	for i, v in next, temp do
		if v then
			del(v)
			temp[i] = nil
		end
	end
	del(temp)
	del(dups)

	if config.displayCDs and not char.track then
		f.block.text = (" %i/%i CD|4:s;"):format(readyCDs, #CDs)
	end
end

SetTracking = function (self, name, dontUpdate)
	char.track = name ~= nil
	if name then char.trackedSkill = name end
	if not char.track then
		f:UnregisterEvent"CHAT_MSG_SKILL"
		f:UnregisterEvent"CHAT_MSG_SYSTEM"
		if dontUpdate then return end
		if config.displayCDs then UpdateCDs() else UpdateText() end
	else
		if name ~= AUTO then char.skill = name end
		f:RegisterEvent"CHAT_MSG_SKILL"
		f:RegisterEvent"CHAT_MSG_SYSTEM"
		if not dontUpdate then UpdateText() end
	end
end

local function ShowAlts()
	workingFrame = g
	local buttons = altButtons
	nbEntries = 0
	local firstEntry, button = true
	local itemLeftWidth, itemRightWidth, colRightWidth, colLeftWidth = 0, 0, 0, 0
	local list, subList = new(), new()

	for charName, charData in next, realm do -- Check for rogue somehow here to input the Lockpicking?
		if charName ~= playerName and charData.curSkills and next(charData.curSkills) then
			list[#list+1] = new("name",charName,"curSkills",charData.curSkills,"maxSkills",charData.maxSkills,"links",charData.links)
		end
	end
	sort(list,SortAlts)

	local maxEntries = type(config.breakMode)=="number" and 0 or floor( (UIParent:GetHeight()/config.scale -GAP*2) / BUTTON_HEIGHT - (config.hideTips and 3 or 6) / config.scale )
	local newColAt = 0
	for i, char in ipairs(list) do
		local firstCharEntry = true
		for skill, value in next, char.maxSkills do
			if value > 1 then subList[#subList+1] = skill end
		end
		sort(subList, SortAltSkills)
		if maxEntries == 0 and (i>config.breakMode) or maxEntries ~= 0 and (nbEntries+#subList+1 > maxEntries) then
			maxEntries, nbEntries, newColAt, workingFrame, buttons, firstEntry = 99, 0, nbEntries, h, altButtons2, true
		end
		for _, skill in ipairs(subList) do
			local bitSkill = skills[skill]
			if bitSkill and
				(not config.panelOnly or bit_band(bitSkill, LINK) > 0) and
				(not config.primaryOnly or bit_band(bitSkill, SECONDARY) == 0)
			then
				if firstCharEntry then
					if firstEntry then firstEntry=false else AddEntry(buttons) end
					AddEntry(buttons, "", char.name, colors.header)
				end
				firstCharEntry = false

				local hasLink = config.panelOnly or bit_band(bitSkill, LINK) > 0
				local color = hasLink and colors.activeName or colors.infoName
				local icon = select(3,GetSpellInfo(floor(bitSkill/SPELL_ID)))
				local strValues = ColorCurMax( char.curSkills[skill], char.maxSkills[skill], true )

				button, itemLeftWidth, itemRightWidth = AddEntry( buttons,
					icon, revAlt[skill], color, strValues, nil, hasLink)
				button:SetScript("OnClick", Link_OnClick)
				button.link = char.links and char.links[skill]
				button.skill, button.owner = skill, char.name
				if itemLeftWidth > colLeftWidth then colLeftWidth = itemLeftWidth + GAP end
				if itemRightWidth > colRightWidth then colRightWidth = itemRightWidth end
			end
		end
		wipe(subList)
	end
	del(list)
	del(subList)
	g:Show()
	if newColAt > 0 then h:Show() else h:Hide() newColAt = nbEntries end
	if _G.Skinner then
		_G.Skinner:applySkin(g)
		if newColAt ~= nbEntries then _G.Skinner:applySkin(h) end
	end

	local horiz = f:GetCenter() > UIParent:GetWidth()/config.scale/2 and "RIGHT" or "LEFT"
	local verti = (f:GetPoint()=="TOP"and f:GetTop() or f:GetBottom()) > UIParent:GetHeight()*.5 and "TOP" or "BOTTOM"

	local maxWidth = colLeftWidth + colRightWidth

	g:SetWidth( maxWidth + GAP*2 )
	g:SetHeight(BUTTON_HEIGHT * newColAt + GAP*2)

	g:ClearAllPoints()
	g:SetPoint(verti..horiz, f, verti..(horiz=="LEFT"and"RIGHT"or"LEFT"))

	for i, bt in next, altButtons do
		if i<=newColAt then bt:SetWidth(maxWidth) else bt:Hide() end
	end
	if newColAt ~= nbEntries then
		for i, bt in next, altButtons2 do
			if i <= nbEntries then bt:SetWidth(maxWidth) else bt:Hide() end
		end
		h:SetWidth( maxWidth + GAP*2 )
		h:SetHeight(BUTTON_HEIGHT * nbEntries + GAP*2)
		h:ClearAllPoints()
		h:SetPoint(verti..horiz, g, verti..(horiz=="LEFT"and"RIGHT"or"LEFT"))
	end

	if nbEntries == 0 then g:Hide() end
end

UpdateTablet = function(self)
	workingFrame = f

	f:SetScale(config.scale)
	nbEntries = 0

	local button, selectedSkillExists
	local itemLeftWidth, itemRightWidth, colRightWidth, colLeftWidth, skillWidth, cdWidth = 0, 0, 0, 0

	UpdateCDs()
	local showCDs, showProfessions, showCombatSkills, showShortcuts = min(#CDs,1), 0, 0, next(char.shortcuts) and 1 or 0
	for k,v in next,f.skills do del(v) f.skills[k]=nil end

--	ExpandSkillHeader(0)
--	TradeSkillCollapseAllButton:Click()
	for _, i in next, getProfessions() do
		local displayName, icon, value, valueMax = GetProfessionInfo(i)
		if displayName then
			-- print("DisplayName: "..displayName)
			local skillName = altNames[displayName]
			-- print("SkillName: "..skillName)
			local skill = skills[skillName]
			-- print("Skill: "..skill)
			if skill then
				local hasPanel, isProfession = bit_band(skill,PANEL)>0, bit_band(skill,PROFESSION)>0
				if char.show[skillName] == nil then 
					char.show[skillName] = hasPanel
				end
				local show = (not isProfession or not char.hideProfessions) and char.show[skillName]
				if show then if isProfession then showProfessions=1 else showCombatSkills=1 end end
				f.skills[#f.skills+1] = new(
					"displayName",	displayName,
					"skillName",	skillName,
					"isProfession",	isProfession and floor(skill/SPELL_ID),
					"hasPanel",	hasPanel,
					"color",	skillName==char.skill and colors.selected or hasPanel and colors.activeName or colors.infoName,
					"strValue",	valueMax <= 1 and "" or ColorCurMax(value,valueMax,isProfession),
					"show",		show,
					"primary",	bit_band(skill,SECONDARY) == 0)
				if isProfession then char.curSkills[skillName], char.maxSkills[skillName] = value, valueMax end
			end
		end
	end
	if GetSpellInfo(L.Runeforging) then
		local skillName = L.Runeforging
		if char.show[skillName] == nil then char.show[skillName] = true end
		f.skills[#f.skills+1] = new(
			"displayName",	altNames[L.RuneforgingDN] or skillName,
			"skillName",	skillName,
			"isProfession",	53428,
			"hasPanel",	true,
			"color",	skillName==char.skill and colors.selected or colors.activeName,
			"strValue",	"",
			"show",		not char.hideProfessions and char.show[skillName],
			"primary",	false)
	end
	if UnitClass("player")==L["Rogue"] then
		local skillName = L.Lockpicking
		local skill = skills[skillName]
		local hasPanel, isProfession = bit_band(skill,PANEL)>0, bit_band(skill,PROFESSION)>0
		if char.show[skillName] == nil then char.show[skillName] = true end
		f.skills[#f.skills+1] = new(
			"displayName",	altNames[L.Lockpicking] or skillName,
			"skillName",	skillName,
			"isProfession",	isProfession and floor(skill/SPELL_ID),
			"hasPanel",	false,
			"color",	skillName==char.skill and colors.selected or hasPanel and colors.activeName or colors.infoName,
			"strValue",	ColorCurMax(UnitLevel("player")*5,UnitLevel("player")*5,isProfession,true),
			"show",		not char.hideProfessions and char.show[skillName],
			"primary",	false)
	end
	
	local nbHeaders = showProfessions + showCombatSkills + showCDs + showShortcuts

	sort(f.skills, SortSkills)
	for i, v in ipairs(f.skills) do
		if v.show then
			if nbEntries == 0 and showProfessions == 1 and nbHeaders > 1 then
				AddEntry(buttons, "", _G.TRADE_SKILLS, colors.header)
			end
			local texture = select(3,GetSpellInfo(v.isProfession)) or ""
			button, itemLeftWidth, itemRightWidth = AddEntry( buttons,
				texture, v.displayName, v.color, v.strValue,
				nil, true)
			button:SetScript("OnClick", Tradeskill_OnClick)
			button.skill, button.spellID, button.shortcut = v.skillName
			if v.color == colors.selected then f.selected = button end
			if itemLeftWidth > colLeftWidth then colLeftWidth = itemLeftWidth end
			if itemRightWidth > colRightWidth then colRightWidth = itemRightWidth end
		end
	end
	skillWidth = colLeftWidth + colRightWidth
	colRightWidth, colLeftWidth = 0, 0

	-- Cooldowns
	for index, data in ipairs(CDs) do
		local group = data.group
		if index == 1 then
			if nbEntries>0 then AddEntry(buttons) end
			if nbHeaders>1 then AddEntry(buttons, "", L.Cooldowns, colors.header, "(Reset: "..SecondsToTime(GetQuestResetTime())..")",colors.header) end
		end

		local missingReagents = data.char == playerName and GetMaxFeasible(data.spellID) == 0

		button, itemLeftWidth, itemRightWidth = AddEntry( buttons,
			config.icons[data.ownGroup or data.spellID] or
			config.names[data.ownGroup] and select(3,GetSpellInfo(config.names[data.ownGroup])) or
			groupIcons[group], data.name,
			data.char == playerName and colors.ownCD or colors.foreignCD,
			data.timeLeft<=0 and (missingReagents and L["|cffff4040Reagents!|r"] or L["|cff20ff20Ready!|r"]) or SecondsToTime(GetQuestResetTime()), nil, true ) -- SecondsToTime(data.timeLeft),
		button:SetScript("OnClick", Cooldown_OnClick)
		button.skill, button.spellID, button.ready, button.owner, button.hasReagents, button.shortcut = data.skill, group and config.names[data.ownGroup] or data.spellID, data.timeLeft<=0, data.char, not missingReagents
		if itemLeftWidth > colLeftWidth then colLeftWidth = itemLeftWidth end
		if itemRightWidth > colRightWidth then colRightWidth = itemRightWidth end
	end
	cdWidth = colLeftWidth + colRightWidth
	colLeftWidth = 0

	-- Shortcuts
	local shortcuts = new()
	for spellID, skill in next, char.shortcuts do
		shortcuts[#shortcuts+1] = new(
			"skill", skill,
			"name", config.aliases[spellID] or config.names[spellID],
			"spellID", spellID)
	end
	sort(shortcuts, SortShortcuts)
	local firstShortcut = true
	for _, shortcut in ipairs(shortcuts) do
		if firstShortcut then
			firstShortcut = false
			if nbEntries>0 then AddEntry(buttons) end
			if nbHeaders>1 then AddEntry(buttons, "", L.Shortcuts, colors.header) end
		end

		local quantity = GetMaxFeasible(shortcut.spellID)

		button, itemLeftWidth = AddEntry( buttons,
			config.icons[shortcut.spellID],
			shortcut.name .. ( quantity==0 and " [|cffff4040" or " [|cffffffff" ) .. quantity .. "|r]",
			colors.activeName, nil, nil, true )
		if itemLeftWidth > colLeftWidth then colLeftWidth = itemLeftWidth end
		button:SetScript("OnClick", Shortcut_OnClick)
		button.skill, button.spellID, button.ready, button.shortcut, button.hasReagents = shortcut.skill, shortcut.spellID, true, true, quantity > 0
	end
	del(shortcuts)

	-- ProfessionsBook
	if ProfessionsBook then
		if nbEntries>0 then AddEntry(buttons) end
		if nbHeaders>1 then AddEntry(buttons, "", L["Miscellaneous"], colors.header) end
		button, itemLeftWidth = AddEntry( buttons, "Interface\\Spellbook\\Spellbook-Icon", "ProfessionsBook", colors.activeName, nil, nil, true )
		button:SetScript("OnClick", ProfessionsBook_OnClick)
		button.skill, button.spellID, button.ready, button.shortcut = "None"
	end

	local maxWidth = math.max(skillWidth, cdWidth, colLeftWidth, itemLeftWidth) + GAP

	for i, bt in next, buttons do
		if i<=nbEntries then bt:SetWidth(maxWidth) else bt:Hide() end
	end
	f:SetWidth(maxWidth + GAP*2)
	f:SetHeight(BUTTON_HEIGHT * nbEntries + GAP*2)

	local isHidden = nbEntries == 0 or IsMouseOut()
	if isHidden or config.hideAlts then
		if isHidden then f:Hide() end
		g:SetWidth(0)
		return h:SetWidth(0)
	end
	ShowAlts()
end


local function Block_OnClick(self, click)
	if click == "LeftButton" then
		local skill = skills[char.skill]
		if skill and bit_band( skill, PANEL ) > 0 then f.action = "open"; CastSpellByName(char.skill) end
	elseif click == "RightButton" then
		f:Hide() tip:Hide()
		if not configMenu then f:SetupConfigMenu() end
		configMenu.scale = UIParent:GetScale()
		ToggleDropDownMenu(1, nil, configMenu, self, 0, 0)
	end
end


f.block = LibStub("LibDataBroker-1.1"):NewDataObject("|cFFFFB366Ara|r Tradeskills", {
	type = "data source",
	text = _G.TRADESKILLS,
	icon = "",
	iconCoords = { 0.075, 0.925, 0.075, 0.925 },
	OnEnter = Block_OnEnter,
	OnLeave = Block_OnLeave,
	OnClick = Block_OnClick,
} )

function f:TRADE_SKILL_SHOW()
	f:UnregisterEvent"TRADE_SKILL_SHOW"
	if f.SetHooks then f:SetHooks() end
	if IsTradeSkillLinked() then return end

	char.links[ altNames[ GetTradeSkillLine() ] ] = GetTradeSkillListLink()

	local action = f.action
	if not action or action == "open" then return end
	if action == "link" then
		local link = GetTradeSkillListLink()
		if not ChatEdit_InsertLink(link) then
			ChatEdit_GetLastActiveWindow():Show()
			ChatFrame_OpenChat(" "..link)
		end
		if not f.keepOpen then CloseTradeSkill() end
		return
	end

	ExpandTradeSkillSubClass(0)
	SetTradeSkillCategoryFilter(0,1,1)
	SetTradeSkillInvSlotFilter(0,1,1)
	TradeSkillOnlyShowMakeable(false)
	for i=1, GetNumTradeSkills() do
		local itemName, itemType, quantity = GetTradeSkillInfo(i)
		-- print (itemType)
		if itemType ~= "header" and itemType ~= "subheader" then
			local spellID = tonumber(GetTradeSkillRecipeLink(i):match"enchant:(%d+)")
			if spellID == f.spellID and (f.action == "point" or f.action == "craft") then
				TradeSkillFrame_SetSelection(i)
				if f.action == "craft" and not GetTradeSkillCooldown(i) then
					if f.craftAll then
						TradeSkillInputBox:SetNumber(quantity)
						TradeSkillCreateButton:Click()
					else
						abtDoTradeSkill(i)
					end
				end
				TradeSkillListScrollFrame:SetVerticalScroll(max(i-5,0)*TradeSkillSkill1:GetHeight())
				TradeSkillFrame_Update()
			--	if f.action == "point" then print("pointed --> done") end -- DEBUG
				break
			end
			local cd = watchedCDs[spellID]
			if cd and f.action == "scan" then
				local timeLeft = GetTradeSkillCooldown(i) or 0
				if timeLeft>0 or config.addReadyCD then
					-- if cd.CD < 0 then
					-- FindRealmResetTime(timeLeft)
					-- System time offset from hours left 
					-- end
					char[spellID] = time() + GetQuestResetTime() -- time() + timeLeft
					if not cd.group then
						config.icons[spellID] = GetTradeSkillIcon(i)
						config.names[spellID] = itemName
					end
				end
			end
		end
	end

	if not f.keepOpen then CloseTradeSkill() end
	if f.action == "scan" and f:IsShown() then UpdateTablet() end
end


function f:SetAlias(alias)
	config.aliases[self.aliasID] = alias ~= "" and alias or nil
	if f:IsShown() then UpdateTablet()end
end

function f:PLAYER_LOGOUT()
	for _, i in next, getProfessions() do
		local skillName, icon, value, valueMax, skill = GetProfessionInfo(i)
		if skillName then
			skill = skills[skillName]
			if skill then
				if bit_band(skill,PROFESSION) == 0 then break end
				char.curSkills[skillName], char.maxSkills[skillName] = value, valueMax
			end
		end
	end
	if UnitClass("player") == L["Rogue"] then
	  -- print("Rogue Detected...")
		skillName = L.Lockpicking
		skill = skills[skillName]
		char.curSkills[skillName], char.maxSkills[skillName] = UnitLevel("player")*5,UnitLevel("player")*5
	end
end

local function Error_OnHide()
	BasicScriptErrors:SetScript("OnHide", baseScript)
	StaticPopup_Show"ABTS_SET_SCALE"
end

------------------------------[[  options  ]]------------------------------

local function DisplayCD_OnUpdate(self, elapsed)
	self.timer = self.timer - elapsed
	if self.timer > 0 then return end
	self.timer = 60
	UpdateCDs()
end

function f:SetupConfigMenu()
	configMenu = CreateFrame("Frame", "AraSkillsDD")
	configMenu.displayMode = "MENU"

	local function RemoveChar(self, char)
		realm[char] = nil
		print( "|cFFFFB366Ara|cffffffffBrokerTradeskills: "..(L["|cff8080ff%s|r has been removed."]):format(char) )
	end

	local function SetRadioOption(bt, var, val, checked)
		config[var] = val
		local p = bt:GetName():sub(1, 19)
		for i = 1, bt:GetParent().numButtons do
			if _G[p..i] == bt then
				_G[p..i.."Check"]:Show()
			else
				_G[p..i.."Check"]:Hide()
				_G[p..i.."UnCheck"]:Show()
			end
		end
	end

	local function SetOption(self, t, v, c) t[v] = not t[v] end
	local function ColorPickerChange()	c[1], c[2], c[3] = ColorPickerFrame:GetColorRGB() end
	local function ColorPickerCancel(prev)	c[1], c[2], c[3] = unpack(prev) end
	local function OpenColorPicker(self, col)
		c = colors[col]
		ColorPickerFrame.func = ColorPickerChange
		ColorPickerFrame.cancelFunc = ColorPickerCancel
		ColorPickerFrame.previousValues = {unpack(c)}
		ColorPickerFrame:SetColorRGB( c[1], c[2], c[3] )
		ColorPickerFrame:Show()
	end

	options = {
		--{ text = ("|cFFFFB366Ara|r Broker Tradeskills (%s)"):format( GetAddOnMetadata(addonName, "Version") ), isTitle = true },
		{ text = ("Ara Broker Tradeskills (%s)"):format(GetAddOnMetadata(addonName, "Version")), isTitle = true },
		{ text = _G.TRADE_SKILLS, submenu = "isProfession", scope=char, var="hideProfessions", inv=true },
		-- SEARCH STOP
		-- Following lines control the checkbox when a different skill to track is chosen.
		{ text = L["Tracking..."], submenu = "track", checked=function() return char.track end, func=
			function()
				char.track = not char.track
				SetTracking(nil, char.track and char.trackedSkill or nil)
			end },
		{ text = L["Display number of Ready CD"], func=
			function()
				config.displayCDs = not config.displayCDs
				e.timer = 0
				e:SetScript("OnUpdate", config.displayCDs and DisplayCD_OnUpdate or nil)
				if not config.displayCDs then return UpdateText() end
			end, checked=function() return config.displayCDs end },
		{ text = L["Include |cff20ff20Ready!|r CDs when scanning"], scope=config, var="addReadyCD" },
	--	{ text = L["Silently open/close panels"], scope=config, var="silent" },
		{ text = L["Show alt skills"], scope=config, var="hideAlts", inv=true, submenu = {
			{ text = L["Primary only"], scope=config, var="primaryOnly" },
			{ text = L["With a craft window only"], scope=config, var="panelOnly" },
		} },
		{ text = L["Alt list break mode"], submenu = {
			{ text = L.Auto, radio="breakMode", val="auto" },
			{ text = L["After 5th"], radio="breakMode", val=5 },
		} },
		{ text = L["Remove an alt"], submenu="alts" },
		{ text = L["Tooltip size"], submenu = {
			{ text =  "90%", radio="scale", val = .9 },
			{ text = "100%", radio="scale", val = 1 },
			{ text = "110%", radio="scale", val = 1.1 },
			{ text = "120%", radio="scale", val = 1.2 },
			{ text = L["Custom..."], radio="scaleX", func=function() StaticPopup_Show"ABTS_SET_SCALE" end },
			}	},
		{ text = L.Colors, submenu = {
			{ text = L["Header"], color = "header" },
			{ text = L["Interactive skill name"], color = "activeName" },
			{ text = L["Last selected skill"], color = "selected" },
			{ text = L["Informative skill name"], color = "infoName" },
			{ text = L["Player CD"], color = "ownCD" },
			{ text = L["Other player CD"], color = "foreignCD" },
			{ text = L["Highlight"], color = "highlight" },
			{ text = "|cffaaaaff"..L["Restore default colors"], func=function() CloseDropDownMenus() for k, v in next, defaultColors do colors[k][1], colors[k][2], colors[k][3] = v[1], v[2], v[3] end end },
			} },
		{ text = L["Show hints"], scope=config, var="hideTips", inv=true },
	}
	configMenu.initialize = function(self, level)
		if not level then return end
		local options = level>1 and UIDROPDOWNMENU_MENU_VALUE or options
		if options == "alts" then
			for char in next, realm do
				if char ~= playerName then
					info = wipe(info)
					info.text, info.notCheckable = char, true
					info.func, info.arg1 = RemoveChar, char
					UIDropDownMenu_AddButton( info, level )
				end
			end
			return
		elseif options == "track" then
			info = wipe(info)
			info.text = L.Auto
			info.func, info.arg1 = SetTracking, AUTO
			info.checked = char.trackedSkill == AUTO
			UIDropDownMenu_AddButton( info, level )

			for i, s in ipairs(f.skills) do
				if s.isProfession then
					info = wipe(info)
					info.text = ("|cff%.2x%.2x%.2x%s|r"):format( s.color[1]*255, s.color[2]*255, s.color[3]*255, s.displayName )
					info.func, info.arg1 = SetTracking, s.skillName
					if char.trackedSkill ~= AUTO then
						info.checked = s.skillName == char.trackedSkill
					end
					info.keepShownOnClick = true
					UIDropDownMenu_AddButton( info, level )
				end
			end
			return
		end
		local custom = type(options)~="table"
		for i, v in ipairs(custom and f.skills or options) do
			if not custom or v[options] then
				info = wipe(info)
				info.text = custom and ("|cff%.2x%.2x%.2x%s|r"):format( v.color[1]*255, v.color[2]*255, v.color[3]*255, v.displayName ) or v.text or v.ftext()
				info.isTitle, info.value, info.hasArrow = v.isTitle, v.submenu, v.submenu ~= nil
				if custom then
					info.isNotRadio = true
					info.checked = char.show[v.skillName]
					info.func, info.arg1, info.arg2 = SetOption, char.show, v.skillName
				elseif v.radio then
					if v.radio == "scaleX" then
						info.checked = config.scale ~= .9 and config.scale ~= 1 and config.scale ~= 1.1 and config.scale ~= 1.2
						info.func = v.func
						if info.checked then
							info.text = ("%s (%i%%)"):format(info.text, config.scale*100)
						end
					else
						info.checked = config[v.radio] == v.val
						info.func, info.arg1, info.arg2 = SetRadioOption, v.radio, v.val
					end
				elseif v.scope then
					info.checked = v.inv and not v.scope[v.var] or not v.inv and v.scope[v.var]
					info.func, info.arg1, info.arg2, info.tooltipText = SetOption, v.scope, v.var, v.inv
					info.isNotRadio = true
				else
					info.notCheckable = not v.checked
					if v.color then
						info.hasColorSwatch, info.notCheckable = true, true
						info.r, info.g, info.b = unpack(colors[v.color])
						info.func, info.arg1 = OpenColorPicker, v.color
						info.padding = 10
					else
						info.func, info.checked = v.func, v.checked
						info.isNotRadio = true
					end
				end
				info.keepShownOnClick = info.func
				-- print(info.text)
				-- print(self.scale)
				if level==1 and info.notCheckable then
					info.text = ("%s"):format(info.text)
					-- info.text = ("|Tx:%i|t%s"):format(25/self.scale, info.text) -- Original line from Above, causes green squares to appear.
				end
				UIDropDownMenu_AddButton( info, level )
				if level==1 and info.notCheckable and info.hasArrow then
					local frame = _G[("DropDownList1Button%i"):format(DropDownList1.numButtons)]
					frame:SetPoint("TOPLEFT", 11, select(5,frame:GetPoint())) --
				end
			end
		end
	end

	local function SetCustomScale(dialog)
		local val = tonumber( dialog.editBox:GetText():match"(%d+)" )
		if not val or val<70 or val>200 then
			baseScript = BasicScriptErrors:GetScript"OnHide"
			BasicScriptErrors:SetScript("OnHide",Error_OnHide)
			BasicScriptErrorsText:SetText(L["Invalid scale.\nShould be a number between 70 and 200%"])
			return BasicScriptErrors:Show()
		end
		config.scale = val/100
	end

	local dialog = {
		text = L["Set tooltip scale.\nEnter a value between 70 and 200 (%%)."],
		maxLetters = 12,
		OnAccept = SetCustomScale,
		OnShow = function(self) CloseDropDownMenus() self.editBox:SetText(config.scale*100) self.editBox:SetFocus() end,
		EditBoxOnEnterPressed = function(self) local p=self:GetParent() SetCustomScale(p) p:Hide() end,
	}
	for k, v in next, StaticPopupDialogs.ADD_IGNORE do -- ADD_MUTE
		if not dialog[k] then dialog[k] = v end
	end
	StaticPopupDialogs.ABTS_SET_SCALE = dialog

	f.SetupConfigMenu = nil
end

local function InitAltFrame(g, backdrop)
	g:SetFrameStrata"TOOLTIP"
	g:SetScript("OnEnter", Alt_OnEnter)
	g:SetScript("OnLeave", Alt_OnLeave)
	g:SetScript("OnMouseWheel", OnMouseWheel)

	g:SetBackdrop(backdrop)
	g:SetBackdropColor(.1, .1, .1, .85)
	g:SetBackdropBorderColor(.3, .3, .3, .9)
end

local function Tablet_OnHide(f)
	g:Hide() g:SetWidth(0)
	h:Hide() h:SetWidth(0)
end

function f:AdjustGroupHandling()
	local groups = new()
	for char, data in next, realm do
		for id, timer in next, data do
			if type(id)=="number" then
				local cd = watchedCDs[id]
				if cd then
					if cd.group then
						local ownGroup = cd.group.."-"..char
						config.icons[ownGroup] = config.icons[ownGroup] or config.icons[cd.group] or groupIcons[cd.group]
						config.names[ownGroup] = config.names[ownGroup] or config.names[cd.group]
						if not watchedCDs[ config.names[ownGroup] ] then config.names[ownGroup] = nil end
						groups[cd.group] = true
					end
				else
					data[id] = nil
				end
			end
		end
	end
	for group in next, groups do
		config.icons[group], config.names[group] = nil
	end
	del(groups)
	f.AdjustGroupHandling = nil
end


function f:ADDON_LOADED(event, addon)
	if addon ~= addonName then return end

	AraTradeskillsDB = AraTradeskillsDB or {icons={},names={},aliases={},colors=defaultColors}
	config = AraTradeskillsDB
	if not config.scale then config.scale = 1 end
	if not config.breakMode then config.breakMode = "auto" end -- r38
	if not config[realmName] then config[realmName] = {} end
	realm = config[realmName]
	if not realm[playerName] then realm[playerName] = {show={}} end
	char = realm[playerName]
	if not char.shortcuts then char.shortcuts = {} end -- r14
	if not char.curSkills then char.curSkills, char.maxSkills = {}, {} end
	if not char.links then char.links = {} end -- r25
	f.AdjustGroupHandling() -- r30
	if char.tracking then
		char.trackedSkill, char.track, char.tracking = char.tracking, true
	end
	if char.trackedSkill == nil then char.trackedSkill = AUTO end
	colors = config.colors

	CDs = new()
	if config.displayCDs then
		e.timer = 0
		e:SetScript("OnUpdate", DisplayCD_OnUpdate)
	end

	tip = _G.GameTooltip

	local popup = {
		text = L["Set an alias for \"%s\".\nLeave blank to reset."],
		maxLetters = 32,
		OnAccept = function(self) AraSkills:SetAlias(self.editBox:GetText()) end,
		OnShow = function(self) self.editBox:SetText(AraSkills.alias) self.editBox:SetFocus() end,
		EditBoxOnEnterPressed = function(self)
			local parent = self:GetParent()
			AraSkills:SetAlias(parent.editBox:GetText())
			parent:Hide()
		end,
	}
	for k, v in next, StaticPopupDialogs.SET_FRIENDNOTE do--SET_FRIENDNOTE do
		if not popup[k] then popup[k] = v end
	end
	StaticPopupDialogs.ABTS_SET_ALIAS = popup

	self:Hide()
	self.skills = {}
	self:SetFrameStrata"TOOLTIP"
	self:SetClampedToScreen(true)
	self:SetScript("OnEnter", Menu_OnEnter)
	self:SetScript("OnLeave", Menu_OnLeave)
	self:SetScript("OnHide", Tablet_OnHide)
	self:SetScript("OnMouseWheel", OnMouseWheel)
	self:RegisterEvent"TRADE_SKILL_SHOW"
	self:RegisterEvent"PLAYER_LOGOUT"
	self:RegisterEvent"CHAT_MSG_LOOT"
	SetTracking(nil, char.track and char.trackedSkill or nil, true)

	local backdrop = { bgFile="Interface\\Buttons\\WHITE8X8", edgeFile="Interface\\Tooltips\\UI-Tooltip-Border",
		tile=false, tileSize=0, edgeSize=14, insets = { left=3, right=3, top=3, bottom=3 } }
	self:SetBackdrop(backdrop)
	self:SetBackdropColor(.1, .1, .1, .85)
	self:SetBackdropBorderColor(.3, .3, .3, .9)

	InitAltFrame(g, backdrop)
	InitAltFrame(h, backdrop)

	if IsLoggedIn() then UpdateText() else
		f.PLAYER_ENTERING_WORLD = UpdateText
		f:RegisterEvent"PLAYER_ENTERING_WORLD"
	end
	self:UnregisterEvent(event)
	self.ADDON_LOADED = nil
end

local matchSkillValue = ERR_SKILL_UP_SI:gsub("%%s","(.+)"):gsub("%%d","(%%d+)"):gsub("%%%d+%$s","(.+)"):gsub("%%%d+%$d","(.+)")

function f:CHAT_MSG_SKILL(event,msg)
	if not char.track then return end
	local skill, value = msg:match(matchSkillValue)
	if value and char.track and (char.trackedSkill == altNames[skill] or char.skill == altNames[skill]) then
		char.curSkills[skill] = value
		return UpdateText()
	end
end

-- I believe the following function might be the ones needed to store information in the file on logout.
-- SEARCH STOP
local function UpdateTrackedSkill(self, elapsed)
	ex.timer = ex.timer - elapsed
	if ex.timer > 0 then return else ex:SetScript("OnUpdate", nil) end
--	ExpandSkillHeader(0)
	for _, i in next, getProfessions() do
		local skillName, icon, value, valueMax = GetProfessionInfo(i)
		if skillName and (char.trackedSkill == AUTO and skillName == char.skill or skillName == char.trackedSkill) then
			char.maxSkills[skillName] = valueMax
			return UpdateText()
		end
	end
end

local matchSkillRankUp = ERR_LEARN_ABILITY_S:gsub("%%s", "(.+)")

function f:CHAT_MSG_SYSTEM(event,msg)
	if not msg:match(matchSkillRankUp) then return end
	ex.timer = 1
	ex:SetScript("OnUpdate", UpdateTrackedSkill)
end

-- Insert PLAYER_LEVEL_UP function here to scan for rogue lockpicking skills.
--[[function f:PLAYER_LEVEL_UP

end
--]]

local matchPushedItem = LOOT_ITEM_PUSHED_SELF:gsub("(%%s)", "(.+)") -- LOOT_ITEM_SELF for corpse loot

function f:CHAT_MSG_LOOT(event, msg)
	local item = msg:match(matchPushedItem)
	if not item then return end
	local name, id, cd, _, _, _, _, _, _, texture = GetItemInfo(item)
	if not name or not id then return end
	id = tonumber( id:match"(%d+):" )
	cd = watchedCDs[id]
	if not cd or cd.skill ~= "Item" then return end
	if cd.CD < 0 then
		char[id] = time() + GetQuestResetTime()
	else
		char[id] = time() + cd.CD
	end
	config.names[id] = name
	config.icons[id] = texture
	UpdateCDs()
end

function f:SetHooks()
	LoadAddOn"Blizzard_TradeSkillUI"
	local b = TradeSkillSkillIcon
	local TS_OnEnter = b:GetScript"OnEnter"
	local TS_OnLeave = b:GetScript"OnLeave"
	local TS_OnClick = b:GetScript"OnClick"

	local OrgSetItem = GameTooltip.SetTradeSkillItem
	local function NewSetItem(...)
		OrgSetItem(...)
		tip:AddLine("\n"..L["|cffff8040Click|r to create a shortcut."], .2, 1, .2)
		tip:Show()
	end

	b:SetScript("OnEnter", function(self, ...)
		if not IsTradeSkillLinked() then tip.SetTradeSkillItem = NewSetItem end
		TS_OnEnter(self, ...)
	end)
	b:SetScript("OnLeave", function(...)
		TS_OnLeave(...)
		if not IsTradeSkillLinked() then tip.SetTradeSkillItem = OrgSetItem end
	end)
	b:SetScript("OnClick", function(self,button,...)
		TS_OnClick(self,button,...)
		if not IsTradeSkillLinked() and not IsModifierKeyDown() and button == "LeftButton" then
			local index = TradeSkillFrame.selectedSkill
			local spellID = tonumber( GetTradeSkillRecipeLink(index):match"enchant:(%d+)" )
			local skill = GetTradeSkillLine()
			char.shortcuts[spellID] = altNames[skill]
			config.names[spellID] = GetTradeSkillInfo(index)
			config.icons[spellID] = GetTradeSkillIcon(index)
			print("|cFFFFB366Ara|cffffff00BrokerTradeskills: "..(L["|cff8080ff%s|r|cffffff00 added to shortcuts."]:format( config.names[spellID] )))
		end
	end)

	f.SetHooks = nil
end

f:SetScript("OnEvent", function(self, event, ...) return self[event](self, event, ...) end)
f:RegisterEvent"ADDON_LOADED"