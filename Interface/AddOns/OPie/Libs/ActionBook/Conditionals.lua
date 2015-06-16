local _, T = ...
if T.SkipLocalActionBook then return end
local KR, EV = assert(T.ActionBook:compatible("Kindred", 1,7), "A compatible version of Kindred is required"), T.Evie
local _, playerClassLocal, playerClass = T.Toboe and T.Toboe(), UnitClass("player")

local safequote do
	local r = {u="\\117", ["{"]="\\123", ["}"]="\\125"}
	function safequote(s)
		return (("%q"):format(s):gsub("[{}u]", r))
	end
end

local RegisterStateConditional do
	local f = CreateFrame("FRAME", nil, nil, "SecureHandlerAttributeTemplate")
	f:SetFrameRef("KR", KR:seclib())
	f:Execute('KR, cndName, curValue = self:GetFrameRef("KR"), newtable(), newtable()')
	f:SetAttribute("_onattributechanged", [[--
		local state = name:match("^state%-(.+)")
		if state and value ~= "_" then
			KR:RunAttribute("UpdateStateConditional", cndName[state], value, curValue[state] or "")
			curValue[state] = value
		end
	]])
	function RegisterStateConditional(name, forName, conditional, isExtended)
		f:SetAttribute(forName, "_")
		f:Execute(([[-- KR-InternalStateConditionalRemap
			local name, forName, conditional, isExt = %q, %q, %s, %s
			cndName[name] = forName
			if isExt then
				KR:SetAttribute("frameref-RegisterStateDriver-frame", self)
				KR:RunAttribute("RegisterStateDriver", name, conditional)
			else
				RegisterStateDriver(self, name, conditional)
			end
		]]):format(name, forName, safequote(conditional), isExtended and 1 or "nil"))
	end
end

do -- zone:Zone/Sub Zone
	local function onZoneUpdate()
		local cz
		for i=1,4 do
			local z = (i == 1 and GetRealZoneText or i == 2 and GetSubZoneText or i == 3 and GetZoneText or GetMinimapZoneText)()
			if z and z ~= "" then
				cz = (cz and (cz .. "/") or "") .. z
			end
		end
		KR:SetStateConditionalValue("zone", cz or false)
	end
	onZoneUpdate()
	EV.RegisterEvent("ZONE_CHANGED", onZoneUpdate)
	EV.RegisterEvent("ZONE_CHANGED_INDOORS", onZoneUpdate)
	EV.RegisterEvent("PLAYER_ENTERING_WORLD", onZoneUpdate)
end
do -- me:Player Name/Class
	KR:SetStateConditionalValue("me", UnitName("player") .. "/" .. playerClassLocal .. "/" .. playerClass)
end
do -- known:spell id
	KR:SetSecureExecConditional("known", [=[-- KR_KnownSpell
		local ids = ...
		for sid in (type(ids) == "string" and ids or ""):gmatch("[^/]+") do
			local id = tonumber(sid:match("^%s*(%d+)%s*$"))
			if id and (FindSpellBookSlotBySpellID(id, true) or FindSpellBookSlotBySpellID(id, false)) then
				return true
			end
		end
		return false
	]=])
	local f = CreateFrame("FRAME")
	f:SetScript("OnUpdate", function(self)
		self:Hide()
		KR:PokeConditional("known")
	end)
	f:SetScript("OnEvent", f.Show)
	f:RegisterEvent("LEARNED_SPELL_IN_TAB")
	f:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
	f:RegisterEvent("PLAYER_ENTERING_WORLD")
end
do -- spec:id/name
	local _, _, cid = UnitClass("player")
	local function sync()
		local idx, s = GetSpecialization()
		if idx then
			local id, name = GetSpecializationInfoForClassID(cid, idx)
			s = idx .. "/" .. (id or idx) .. "/" .. (name or idx)
		else
			s = "-1/unspec"
		end
		KR:SetStateConditionalValue("spec", s)
	end
	EV.PLAYER_SPECIALIZATION_CHANGED = sync
	sync()
end
do -- form:token
	if playerClass == "DRUID" then
		KR:SetAliasConditional("stance", "form")
		local map, curCnd, pending = {
			[GetSpellInfo(40120)]="/flight",
			[GetSpellInfo(33943)]="/flight",
			[GetSpellInfo(1066)]="/aquatic",
			[GetSpellInfo(783)]="/travel",
			[GetSpellInfo(24858)]="/moon/moonkin",
			[GetSpellInfo(768)]="/cat",
			[GetSpellInfo(171745) or 1]="/cat",
			[GetSpellInfo(5487)]="/bear",
		}, nil
		local function sync()
			local s = ""
			for i=1,10 do
				local _, name = GetShapeshiftFormInfo(i)
				s = ("%s[form:%d] %d%s;"):format(s, i,i, map[name] or "")
			end
			if curCnd ~= s then
				RegisterStateConditional("form", "form", s, false)
			end
			pending = nil
			return "remove"
		end
		EV.RegisterEvent("PLAYER_LOGIN", sync)
		EV.RegisterEvent("UPDATE_SHAPESHIFT_FORMS", function()
			if not InCombatLockdown() then
				sync()
			elseif not pending then
				pending = 1
				EV.RegisterEvent("PLAYER_REGEN_ENABLED", sync)
			end
		end)
	end
end
do -- talent:tier.num/name
	local cur, levels = false, CLASS_TALENT_LEVELS[playerClass] or CLASS_TALENT_LEVELS.DEFAULT
	local function updateTalents()
		local s
		for i=1,GetNumTalents() do
			local name, _, tier, column, selected = GetTalentInfo(i)
			if selected then
				s = (s and s .. "/" or "") .. tier .. "." .. column .. "/" .. levels[tier] .. "." .. column .. "/" .. name
			end
		end
		if s ~= cur then
			cur = s
			KR:SetStateConditionalValue("talent", cur or "")
		end
	end
	EV.RegisterEvent("PLAYER_TALENT_UPDATE", updateTalents)
	updateTalents()
end
do -- instance:arena/bg/ratedbg/raid/instance/scenario
	local mapTypes = {party="dungeon", pvp="battleground/bg", ratedbg="ratedbg/rgb", none="world"}
	for n in ("1158 1331 1159 1152 1330 1153"):gmatch("%d+") do mapTypes[tonumber(n)] = "world/garrison" end
	EV.RegisterEvent("PLAYER_ENTERING_WORLD", function()
		local _, itype, did, _, _, _, _, imid = GetInstanceInfo()
		if imid and mapTypes[imid] then
			itype = mapTypes[imid]
		elseif itype == "pvp" and IsRatedBattleground() then
			itype = "ratedbg"
		elseif itype == "none" and IsInActiveWorldPVP() then
			itype = "worldpvp"
		elseif itype == "raid" then
			if did == 7 then
				itype = "lfr"
			end
		end
		KR:SetStateConditionalValue("in", mapTypes[itype] or itype)
	end)
	KR:SetAliasConditional("instance", "in")
	KR:SetStateConditionalValue("in", "daze")
end
do -- petcontrol
	local hasControl = (playerClass ~= "HUNTER" and playerClass ~= "WARLOCK") or UnitLevel("player") >= 10
	KR:SetStateConditionalValue("petcontrol", hasControl)
	if not hasControl then
		EV.RegisterEvent("PLAYER_LEVEL_UP", function(_, level)
			if level >= 10 then
				KR:SetStateConditionalValue("petcontrol", "*")
				return "remove"
			end
		end)
	end
end
do -- Draenor [flyable]
	local noFlight = {}
	for n in ("1158 1331 1159 1152 1330 1153; 1116 1265"):gmatch("%d+") do
		noFlight[tonumber(n)] = 1
	end
	EV.RegisterEvent("PLAYER_ENTERING_WORLD", function()
		local _, _, _, root = UnitPosition("player")
		if noFlight[root] then
			KR:SetStateConditionalValue("flyable", "")
		else
			KR:ClearConditional("flyable")
		end
	end)
end
do -- outpost
	local map, state, name = {
		[161676]="garrison", [161332]="garrison",
		[164012]="arena", [164050]="lumber yard/yard",
		[161767]="sanctum", [162075]="arsenal",
		[168499]="brewery", [168487]="brewery", [170108]="smuggling run/run", [170097]="smuggling run/run",
		[164222]="corral", [165803]="corral", [160240]="tankworks", [160241]="tankworks",
	}, false, GetSpellInfo(161691)
	local function sync()
		local ns = map[select(7, GetSpellInfo(name))]
		if state ~= ns then
			KR:SetStateConditionalValue("outpost", ns or "")
			state = ns
		end
	end
	EV.RegisterEvent("SPELLS_CHANGED", sync)
	sync()
end
do -- glyph:name/glyph id
	local names = {} do
		local nameFilter = ""
		hooksecurefunc("SetGlyphNameFilter", function(name)
			nameFilter = name
		end)
		setmetatable(names, {__index=function(t, k)
			local f8, f16, nameFilter = IsGlyphFlagSet(8) or ToggleGlyphFilter(8), IsGlyphFlagSet(16) or ToggleGlyphFilter(16), nameFilter
			local f1, f2 = IsGlyphFlagSet(1) or ToggleGlyphFilter(1), IsGlyphFlagSet(2) or ToggleGlyphFilter(2)
			SetGlyphNameFilter("")
			for i=1,GetNumGlyphs() do
				local name, _, _, _, id = GetGlyphInfo(i)
				if id then
					t[id] = name
				end
			end
			SetGlyphNameFilter(nameFilter)
			f8, f16 = f8 or ToggleGlyphFilter(8), f16 or ToggleGlyphFilter(16)
			f1, f2 = f1 or ToggleGlyphFilter(1), f2 or ToggleGlyphFilter(2)
			return rawget(t, k)
		end})
	end
	local state, marker, w = {}, 1, {}
	local function sync(e)
		marker = -marker
		local changed
		for i=1,GetNumGlyphSockets() do
			local id = select(6, GetGlyphSocketInfo(i)) or 0
			state[id], changed = marker, changed or id ~= 0 and not state[id]
		end
		state[0] = nil
		for k,v in pairs(state) do
			if v ~= marker then
				changed, state[k] = true
			end
		end
		if changed then
			local n = 1
			for k,v in pairs(state) do
				w[n], w[n+1], n = k, names[k] or "?", n+2
			end
			KR:SetStateConditionalValue("glyph", table.concat(w, "/", 1, n-1))
		end
	end
	EV.RegisterEvent("PLAYER_LOGIN", sync)
	EV.RegisterEvent("GLYPH_UPDATED", sync)
	EV.RegisterEvent("GLYPH_REMOVED", sync)
	EV.RegisterEvent("GLYPH_ADDED", sync)
end
do -- level:floor
	local ls = [=[--
		local n = tonumber((...))
		return n and n <= %d
	]=]
	local function sync()
		KR:SetSecureExecConditional("level", ls:format(UnitLevel("player") or 0))
	end
	sync()
	EV.RegisterEvent("PLAYER_LEVEL_UP", sync)
end