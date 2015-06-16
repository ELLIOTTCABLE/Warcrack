local api, MAJ, REV, execQueue, _, T = {}, 1, 8, {}, ...
if T.ActionBook then return end

local function assert(condition, err, ...)
	return (not condition) and error(tostring(err):format(...), 3) or condition
end
local safequote do
	local r = {u="\\117", ["{"]="\\123", ["}"]="\\125"}
	function safequote(s)
		return (("%q"):format(s):gsub("[{}u]", r))
	end
end

local core = CreateFrame("FRAME", nil, nil, "SecureHandlerAttributeTemplate")
core:SetFrameRef("sandbox", CreateFrame("FRAME", nil, nil, "SecureFrameTemplate"))
core:Execute([==[-- Kindred.Init
	pcache, nextDriverKey, sandbox, modStateMap = newtable(), 4200, self:GetFrameRef("sandbox"), newtable()
	cndType, cndState, cndDrivers, cndAlias, unitAlias, stateDrivers = newtable(), newtable(), newtable(), newtable(), newtable(), newtable()
	modStateMap.A, modStateMap.a, modStateMap.S, modStateMap.s, modStateMap.C, modStateMap.c = true, false, true, false, true, false
	btnState = newtable()

	OptionParse = [=[-- Kindred_OptionParse
		local ret, conditional = newtable(), ...
		local no, ns, lp = conditional:gmatch("()%["), conditional:gmatch("();"), #conditional + 1
		local po, lc, cur, pc, ps = no() or lp, 0
		repeat
			ps, cur = ns() or lp, newtable()
			while po < ps do
				pc = conditional:match("()%]", po)
				if pc then
					local clause, ct = conditional:sub(po+1, pc-1):lower(), newtable()
					for m in clause:gmatch("[^,%s][^,]*") do
						m = m:match("^%s*(.-)%s*$")
						if m:sub(1,1) == "@" or m:sub(1,7) == "target=" then
							ct.target = m:match("[=@](.*)")
						else
							local cvalparsed, mark, wname, inv, name, col, cval = nil, m:match("^([+%-#]?)((n?o?)([^:=]*))([:=]?)(.-)%s*$")
							if inv ~= "no" then inv, name = "", wname end
							cval, name = col == ":" and cval and ("/" .. cval .. "/"):gsub("%s*/%s*", "/"):match("/(.+)/") or nil, col == ":" and name or (name .. col .. cval)
							if cval and cval ~= "" then
								cvalparsed = newtable()
								for s in cval:gmatch("[^/]+") do cvalparsed[#cvalparsed+1] = s end
							end
							cct = newtable(name, cvalparsed, inv ~= "no", mark, cval)
							ct[#ct+1], cct[0] = cct, m
						end
					end
					cur[#cur+1], lc, po = ct, pc, no() or lp
				else
					break
				end
			end
			cur[1], cur.v = cur[1] or newtable(), conditional:sub(lc+1, ps-1):match("^%s*(.-)%s*$")
			ret[#ret + 1], lc = cur, ps
		until ps == lp
		pcache[conditional] = ret
	]=]
	OptionConstruct = [=[-- Kindred_OptionConstruct
		local cond, modState, skipChunks = ...
		local cond, out, msI, msA, msS, msC = pcache[cond] or owner:Run(OptionParse, cond) or pcache[cond]
		local getNextSkip = type(skipChunks) == "string" and skipChunks:gmatch("()s")
		local skipNext = getNextSkip and getNextSkip()
		for i=1,#cond do
			local chunk, cparse, isTautology, skipThis = cond[i], "", false, i == skipNext
			skipNext = skipThis and getNextSkip() or skipNext
			for i=1,skipThis and 0 or #chunk do
				local target, conditional, cnext = chunk[i].target, "", ""
				while unitAlias[target] do target = unitAlias[target] end
				for j=1,#chunk[i] do
					local c = chunk[i][j]
					local name, argp, goal, flag = c[1], c[2], c[3], c[4]
					if goal == false and (cndType[name] == nil and cndType["no" .. name]) then goal, name = true, "no" .. name end
					if cndAlias[name] then name = cndAlias[name] end
					if name == "mod" and modState then
						if not msI then
							local a,s,c = modState:match("(.)(.)(.)")
							msI, msA, msS, msC = 1, modStateMap[a], modStateMap[s], modStateMap[c]
						end
						local argu, all = c[5], argp == nil
						local wA, wS, wC = all or argu:match("alt"), all or argu:match("shift"), all or argu:match("ctrl")
						if (wA and msA) or (wS and msS) or (wC and msC) then
							if not goal then
								conditional = nil
								break
							end
						else
							local par, pn = goal and "mod:" or "nomod:", ""
							if wA and msA ~= false then par, pn = par .. pn .. "alt", "/" end
							if wS and msS ~= false then par, pn = par .. pn .. "shift", "/" end
							if wC and msC ~= false then par, pn = par .. pn .. "ctrl", "/" end
							if pn == "" and goal then
								conditional = nil
								break
							elseif pn ~= "" then
								conditional, cnext = conditional .. cnext .. par, ","
							end
						end
					elseif cndType[name] == nil then
						conditional, cnext = conditional .. cnext .. c[0], ","
					else
						local cres, ctype = false, cndType[name]
						if ctype == "state" then
							local cval, cs = nil, cndState[name]
							if argp == nil then
								cval = cs and cs["*"] or false
							elseif cs then
								for k=1,#argp do
									if cs[argp[k]] then
										cval = true
										break
									end
								end
							end
							cres = (not not cval) == goal
						elseif ctype == "srun" then
							local s = cndState[name]
							if type(s) == "string" then
								cres = sandbox:Run(s, c[5], target, c[4])
							elseif _shadowES and _shadowES[name] then
								cres = _shadowES[name](name, c[5], target, c[4])
							elseif s then
								cres = s:RunAttribute("EvaluateMacroConditional", name, c[5], target, c[4])
							end
							cres = (not not cres) == goal
						end
						if not cres then
							conditional = nil
							break
						end
					end
				end
				if conditional then
					if target then conditional = "@" .. target .. cnext .. conditional end
					cparse = cparse .. "[" .. conditional .. "]"
					if cnext == "" then
						isTautology = true
						break
					end
				end
			end
			if cparse ~= "" then
				out = (out and (out .. ";") or "") .. cparse .. chunk.v
				if isTautology then break end
			end
		end
		out = out or "[form:42]"
		return out
	]=]
	RefreshDrivers = [=[-- Kindred_RefreshDrivers
		local name = ...
		if cndDrivers[name] then
			for key, info in pairs(cndDrivers[name]) do
				local nv = owner:Run(OptionConstruct, info[3])
				if info[5] ~= nv then
					info[5] = nv
					RegisterStateDriver(info[1], info[2], nv)
				end
			end
		end
	]=]
]==])
core:SetAttribute("RegisterStateDriver", [=[-- Kindred:RegisterStateDriver
	local frame = owner:GetFrameRef("RegisterStateDriver-frame")
	owner:SetAttribute("frameref-RegisterStateDriver-frame", nil)
	if frame == nil then return owner:CallMethod("throw", 'Set the "RegisterStateDriver-frame" frameref before calling RegisterStateDriver."') end
	local drivers, state, values = stateDrivers[frame], ...
	local old = drivers and drivers[state]
	if old then
		drivers[state] = nil
		RegisterStateDriver(frame, state, "")
		for _, t in pairs(cndDrivers) do
			t[old[4]] = nil
		end
	end
	if values and type(state) == "string" and values ~= "" then
		local info, key
		drivers, info, key = drivers or newtable(), newtable(frame, state, values, nextDriverKey), nextDriverKey
		stateDrivers[frame], drivers[state], nextDriverKey = drivers, info, nextDriverKey + 1
		local parse, cv = pcache[values] or owner:Run(OptionParse, values) or pcache[values], owner:Run(OptionConstruct, values)
		info[5] = cv
		RegisterStateDriver(frame, state, cv)
		for i=1,#parse do
			for j=1,#parse[i] do
				local clause = parse[i][j]
				for k=1,#clause do
					local n = clause[k][1]
					cndDrivers[n] = cndDrivers[n] or newtable()
					cndDrivers[n][key] = info
				end
				local u = clause.target while u do
					local n = "unit:" .. u
					cndDrivers[n] = cndDrivers[n] or newtable()
					cndDrivers[n][key], u = info, unitAlias[u]
				end
			end
		end
	end
]=])
core:SetAttribute("EvaluateCmdOptions", [=[-- Kindred:EvaluateCmdOptions("options")
	return SecureCmdOptionParse(owner:Run(OptionConstruct, ...))
]=])
core:SetAttribute("UpdateStateConditional", [=[-- Kindred:UpdateStateConditional("name", "addSet", "remSet")
	local name, new, kill = ...
	local cs = cndState[name] or newtable()
	cndType[name], cndState[name] = "state", cs
	if kill == "*" then
		wipe(cs)
	else
		for s in (kill and tostring(kill) or ""):lower():gmatch("[^/]+") do
			cs[s] = nil
		end
		cs["*"] = nil
	end
	for s in (new and tostring(new) or ""):lower():gmatch("[^/]+") do
		cs[s] = 1
	end
	cs["*"] = next(cs) and 2 or nil
	if cndDrivers[name] then
		owner:Run(RefreshDrivers, name)
	end
]=])
core:SetAttribute("SetAliasUnit", [=[-- Kindred:SetAliasUnit("alias", "unit" or nil)
	local alias, unit = ...
	if not (type(alias) == "string" and (type(unit) == "string" or unit == nil)) then
		return owner:CallMethod("throw", 'Syntax: ("SetAliasUnit", "alias", "unit" or nil)')
	end
	local u = unit while unitAlias[u] and u ~= alias do u = unitAlias[u] end
	if u == alias then
		return owner:CallMethod("throw", ('Kindred:SetUnitAlias: would create a loop aliasing to %q'):format(alias))
	end
	unitAlias[alias] = unit
	owner:Run(RefreshDrivers, "unit:" .. alias)
]=])
core:SetAttribute("SetButtonState", [=[-- Kindred:SetButtonState("buttonid" or false or nil)
	local ostate, nstate = cndState.btn == btnState and btnState["*"], ...
	if nstate == false then
		cndType.btn, cndState.btn, btnState[ostate or 0] = nil
	else
		if ostate then
			btnState[ostate] = nil
		end
		if nstate then
			nstate = nstate .. ""
			btnState[nstate] = true
		end
		cndType.btn, cndState.btn, btnState["*"] = "state", btnState, nstate
	end
	return ostate
]=])
function core:throw(text)
	error(text)
end
function core:DeferExecute(snippet, key)
	if InCombatLockdown() then
		execQueue[key] = snippet
	elseif type(snippet) == "function" then
		snippet()
	else
		self:Execute(snippet)
	end
end
core:RegisterEvent("PLAYER_REGEN_ENABLED")
core:SetScript("OnEvent", function(self, e)
	for k,v in pairs(execQueue) do
		securecall(self.DeferExecute, self, v)
		execQueue[k] = nil
	end
end)

local EvaluateCmdOptions, SetExternalShadow do
	local ShadowEnvironment do
		local fcache, _R, _ENV = {}, {next=rtable.next, pairs=rtable.pairs, newtable=function(...) return {...} end}, {}
		local _shadow = {__index=function(t,k)
			local v = _ENV[t] and _ENV[t][k]
			if v == nil then
				v = _R[k] or _G[k]
			elseif type(v) == "userdata" then
				v = IsFrameHandle(v) and ShadowEnvironment(GetFrameHandleFrame(v)) or setmetatable({}, {__index=v})
			end
			t[k] = v
			return v
		end}
		local function ShadowRun(self, f, ...)
			local v = fcache[f] or loadstring(("-- %s\nreturn function(self, ...)\n%s\nend"):format(tostring(f):match("^[%s%-]*([^\n]*)"), f))()
			fcache[f] = setfenv(v, _ENV[self])
			return securecall(v, self, ...)
		end
		function ShadowEnvironment(h)
			local e = _ENV[h] or setmetatable({owner={Run=ShadowRun}}, _shadow)
			_ENV[h], _ENV[e], _ENV[e.owner] = e, GetManagedEnvironment(h), e
			return e.owner, e
		end
	end
	local _core, _env = ShadowEnvironment(core)
	_env._shadowES = {}
	function EvaluateCmdOptions(options, ...)
		return SecureCmdOptionParse((securecall(_core.Run, _core, _env.OptionConstruct, options, ...)))
	end
	function SetExternalShadow(name, func)
		_env._shadowES[name] = func
	end
end

function api:ClearConditional(name)
	assert(type(name) == "string", 'Syntax: Kindred:ClearConditional("name")')
	core:DeferExecute(([[-- KR:ClearConditional
		local name = %s
		cndAlias[name], cndType[name], cndState[name] = nil
		owner:Run(RefreshDrivers, name)
	]]):format(safequote(name)))
end
function api:SetStateConditionalValue(name, value)
	if type(value) == "boolean" then value = value and "*" or "" end
	assert(type(value) == 'string', 'Syntax: Kindred:SetStateConditionalValue("name", "value")')
	core:DeferExecute(([[owner:RunAttribute("UpdateStateConditional", %s, %s, "*")]]):format(safequote(name), safequote(value or "")), name)
end
function api:SetSecureExecConditional(name, snippet)
	assert(type(name) == "string" and type(snippet) == "string", 'Syntax: Kindred:SetSecureExecConditional("name", "snippet")')
	core:DeferExecute(([[-- KR:SetSecureExecConditional
		local name = %s
		cndType[name], cndState[name] = "srun", %s
		owner:Run(RefreshDrivers, name)
	]]):format(safequote(name), safequote(snippet)), name)
end
function api:SetSecureExternalConditional(name, handler, hint)
	assert(type(name) == "string" and type(handler) == "table" and handler[0] and type(hint) == "function", 'Syntax: Kindred:SetSecureExternalConditional("name", handlerFrame, hintFunc)')
	assert(handler.IsProtected and select(2,handler:IsProtected()) and handler:GetAttribute("EvaluateMacroConditional"), 'Handler frame must be explicitly protected; must have EvaluateMacroConditional attribute set')
	if InCombatLockdown() then
		core:DeferExecute(function() self:SetExternalConditional(name, handler, hint) end, name)
	else
		core:SetFrameRef("ExternalConditional-frame", handler)
		core:Execute(([[ local name, h = %s, self:GetFrameRef('ExternalConditional-frame')
			self:SetAttribute("frameref-ExternalConditional-frame", nil)
			cndType[name], cndState[name] = h and "srun", h
			owner:Run(RefreshDrivers, name)
		]]):format(safequote(name)), name)
		SetExternalShadow(name, hint)
	end
end
function api:SetAliasConditional(name, aliasFor)
	assert(type(name) == "string" and type(aliasFor) == "string", 'Syntax: Kindred:SetAliasConditional("name", "aliasFor")')
	core:DeferExecute(('cndAlias[%s] = %s\n owner:Run(RefreshDrivers, name)'):format(safequote(name), safequote(aliasFor)), name)
end
function api:PokeConditional(name)
	assert(type(name) == "string", 'Syntax: Kindred:PokeConditional("name")')
	core:DeferExecute(("owner:Run(RefreshDrivers, %s)"):format(safequote(name)), "_poke-" .. name)
end
function api:SetAliasUnit(alias, unit)
	assert(type(alias) == "string" and (type(unit) == "string" or unit == nil), 'Syntax: Kindred:SetAliasUnit("alias", "unit" or nil)')
	core:DeferExecute(('owner:RunAttribute("SetAliasUnit", %s, %s)'):format(safequote(alias), unit and safequote(unit) or "nil"), "_alias-" .. alias)
end
function api:RegisterStateDriver(frame, state, values)
	assert(type(frame) == "table" and type(state) == "string" and (values == nil or type(values) == "string"), 'Syntax: Kindred:RegisterStateDriver(frame, "state"[, "values"])')
	assert(not InCombatLockdown(), 'Combat lockdown in effect')
	core:SetFrameRef("RegisterStateDriver-frame", frame)
	core:Execute(([[self:RunAttribute("RegisterStateDriver", %s, %s)]]):format(safequote(state), safequote(values or "")))
end
function api:EvaluateCmdOptions(options, ...)
	return EvaluateCmdOptions(options, ...)
end
function api:seclib()
	return core
end
function api:compatible(cmaj, crev)
	return (cmaj == MAJ and crev <= REV) and api or nil, MAJ, REV
end

api:SetAliasConditional("modifier", "mod")
api:SetAliasConditional("button", "btn")

T.Kindred = {compatible=api.compatible}