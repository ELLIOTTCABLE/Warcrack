local _G = _G
_G.AddonLoader = {}
local AddonLoader = AddonLoader
AddonLoader.events = {}
AddonLoader.conditiontexts = {}
AddonLoader.slashes = {} -- ["ADDONNAME"] = { "SLASHCOMMAND"=true, "SC"=true, ... }, ["ANOTHERADDON"] = ...

-- GLOBALS: GetAddOnInfo GetAddOnMetadata IsAddOnLoaded IsAddOnLoadOnDemand GetNumAddOns LoadAddOn GetAddOnEnableState
-- GLOBALS: AddonLoaderSV
local tostring, pairs, select, next, string = 
      tostring, pairs, select, next, string

local WoD = select(4, GetBuildInfo()) >= 60000

local frame = CreateFrame("Frame", "AddonLoaderFrame")
AddonLoader.frame = frame  -- easy reference for use in X-LoadOn-Events

function AddonLoader:Print(text)
	_G.DEFAULT_CHAT_FRAME:AddMessage("|cFF33FF99AddonLoader|r: ".. tostring(text))
end

function AddonLoader:AddCondition(condname, addonname, metatext)
	if AddonLoader.conditions[condname] then
		local cond = AddonLoader.conditions[condname]
		for k, event in pairs(cond.events) do
			if not AddonLoader.events[event] then
				AddonLoader.events[event] = {}
				frame:RegisterEvent(event)
			end
			if not AddonLoader.events[event][addonname] then
				AddonLoader.events[event][addonname] = {}
			end
			AddonLoader.events[event][addonname][condname] = {
				handler = cond.handler,
				arg = metatext,
			}
		end
	end
end

-- scan all addons and their metadata for X-LoadOn directives.
function AddonLoader:ScanAddons()
	local player = UnitName("player")
	for i = 1, GetNumAddOns() do
		local name, _, _, enabled = GetAddOnInfo(i)
		if WoD then
			enabled = (GetAddOnEnableState(player, i) > 0)
		end
		if enabled and IsAddOnLoadOnDemand(i) and not IsAddOnLoaded(i) then
			-- scan metadata.
			-- inject events with the correct handlers for all addons.
			-- register for those events on our frame
			for condname, cond in pairs(AddonLoader.conditions) do
				local meta = GetAddOnMetadata(name, condname)
				if meta then

					-- build the textblock as base for overrides
					if not AddonLoader.conditiontexts[name] then
						AddonLoader.conditiontexts[name] = ""
					end
					AddonLoader.conditiontexts[name] = AddonLoader.conditiontexts[name] .. condname..": "..meta.."\n"
					-- special handling for hook and events
					if condname == "X-LoadOn-Events" or condname == "X-LoadOn-Hooks" then
						for item in meta:gmatch("[^ ,]+") do
							local metaitem = GetAddOnMetadata(name, "X-LoadOn-"..item)
							if metaitem then
								AddonLoader.conditiontexts[name] = AddonLoader.conditiontexts[name].."X-LoadOn-"..item..": "..metaitem.."\n"
							end
						end
					elseif condname == "X-LoadOn-Execute" then -- special handling for execute
						for i = 2, 5 do
							local metaitem = GetAddOnMetadata(name, "X-LoadOn-Execute"..i)
							if metaitem then
								AddonLoader.conditiontexts[name] = AddonLoader.conditiontexts[name].."X-LoadOn-Execute"..i..": "..metaitem.."\n"
							end
						end
					end
					AddonLoader:AddCondition(condname, name, meta)
				end
			end
		end
	end
end

-- this will be called at PLAYER_LOGIN at which point the saved vars should be present
function AddonLoader:LoadOverrides()
	if not AddonLoaderSV then
		AddonLoaderSV = { -- overrides
			overrides = {},
		}
	end
	AddonLoader.originals = {}
	for k, v in pairs(AddonLoader.conditiontexts) do
		AddonLoader.originals[k] = v
	end
	for addon, conditiontext in pairs(AddonLoaderSV.overrides) do
		-- we have an addon lets clear the events for this addon and override unconditionaly.
		for event, addons in pairs(AddonLoader.events) do
			addons[addon] = nil -- nuke
		end
		AddonLoader.conditiontexts[addon] = conditiontext
		-- we have a conditiontext override lets do it.
		for line in conditiontext:gmatch("[^\n]+") do
			local condname, text = string.match(line, "^([^:]*): (.*)$")
			if condname and text then
				AddonLoader:AddCondition(condname, addon, text)
			end
		end
	end
end

function AddonLoader:LoadAddOn(name)
	-- Verify that the addon isn't disabled
	local enabled
	if WoD then
		enabled = (GetAddOnEnableState(UnitName("player"), name) > 0)
	else
		enabled = select(4, GetAddOnInfo(name))
	end
	if not enabled then return false end

	-- If there's slashes registered for the the addon, remove them
	if AddonLoader.slashes[name:upper()] then
		for v in pairs( AddonLoader.slashes[name:upper()] ) do
			_G['SLASH_'..v..'1'] = nil
			_G.SlashCmdList[v] = nil
			_G.hash_SlashCmdList['/'..v] = nil
		end
		AddonLoader.slashes[name:upper()] = nil   -- and nil out our list. saves resources and prevents us NILling again if someone calls this function on a loaded addon.
	end

	-- Load the addon
	if not AddonLoaderSV.silent then
		AddonLoader:Print("Loading " .. name)
	end
	local succ, err = LoadAddOn(name)
	if not succ then
		AddonLoader:Print("Error loading " .. name .. " (" .. err .. ")")
		return false, err
	end
	return true
end

local delayedevents = {}

-- event handler
local function OnEvent(this, event, ...)
	if event == "PLAYER_LOGIN" then
		AddonLoader:ScanAddons()
		AddonLoader:LoadOverrides()
	end
	if InCombatLockdown() and event ~= "PLAYER_REGEN_DISABLED" then -- an load event fired in combat
		-- delay it for later
		if not delayedevents[event] then
			delayedevents[event] = { ... }
		end
		return
	elseif event == "PLAYER_REGEN_ENABLED" then -- run delayed events
		for evt,args in pairs(delayedevents) do
			OnEvent(this, evt, unpack(args))
		end
		wipe(delayedevents)
	end
	if AddonLoader.events[event] then
		--- run the handlers
		for name, conditions in pairs(AddonLoader.events[event]) do
			if not IsAddOnLoaded(name) then
				for condname, condition in pairs(conditions) do
					if condition.handler(event, name, condition.arg, ...) then
						AddonLoader:LoadAddOn(name)
						break
					end
				end
			end
			-- we do a lazy cleanup here
			-- if an addon gets loaded by means other than AddonLoader it will be removed from the events list upon next firing of the event.
			if IsAddOnLoaded(name) then -- cleanup
				AddonLoader.events[event][name] = nil
				local found = next(AddonLoader.events[event])
				if not found then
					AddonLoader.events[event] = nil
					frame:UnregisterEvent(event)
				end
			end
		end
	end
end

frame:SetScript("OnEvent", OnEvent)
frame:RegisterEvent("PLAYER_LOGIN")

