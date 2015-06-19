local L = LibStub("AceLocale-3.0"):GetLocale("Skada", false)

local Skada = Skada

local mod = Skada:NewModule("Survivability")
local deathlog = Skada:NewModule("Survivability log")

local math_floor			= math.floor
local function Round(num) return math_floor(num+.5) end

function mod:Update(win, set)
	local nr = 1
	local max = 0

	local starttime = set.starttime
	local endtime 	= set.endtime or 0
	local bossname 	= set.name
	local duration = 0, timespan
	
	if set.name == "Total" then
		local sets = Skada:GetSets()

		for i, myset in ipairs(sets) do
			duration = duration + (myset.endtime - myset.starttime)
		end
	else
		duration = endtime - starttime
	end
	
	timespan = SecondsToTime(duration)
	
	for i, player in ipairs(set.players) do
		if player.deaths and #player.deaths > 0 then
			local maxdeathts = 0
			local length_alive = 0, alive_timespan
			local died_at = 0
			
			for k,death in pairs(player.deaths) do
				died_at = death.ts
				length_alive = died_at - starttime
				alive_timespan = SecondsToTime(length_alive)
				
				if died_at > maxdeathts then
					maxdeathts = died_at
				end
			end
			
			local d = win.dataset[nr] or {}
			win.dataset[nr] = d

			d.id = player.id
			d.label = player.name
			d.class = player.class
			
			local percentage_alive = Round((length_alive / duration) * 100)
			d.value = percentage_alive
			
			if set.name == "Total" then
				d.valuetext = tostring(percentage_alive, 0) .. "%"
			else
				d.valuetext = Skada:FormatValueText(
										tostring(#player.deaths), self.metadata.columns.Deaths,
										percentage_alive .. "%", self.metadata.columns.Percent,
										alive_timespan, self.metadata.columns.Timestamp)
			end
			
			if maxdeathts > max then
				max = maxdeathts
			end
			
			nr = nr + 1
		end
	end
	
	win.metadata.maxvalue = 100
end

function deathlog:Enter(win, id, label)
	deathlog.playerid = id
	deathlog.title = label..L["'s Death"]
end

function deathlog:Update(win, set)
	local player = Skada:get_player(set, self.playerid)
	
	local starttime = set.starttime
	local endtime = set.endtime
	local duration = 0, timespan
	
	if set.name == "Total" then
		local sets = Skada:GetSets()
		
		for i, myset in ipairs(sets) do
			duration = duration + (myset.endtime - myset.starttime)
		end
	else
		if endtime == nil then
			endtime = 0
		end
		duration = endtime - starttime
	end
	
	timespan = SecondsToTime(duration)
	
	if player and player.deaths then
		local nr = 1
		
		table.sort(player.deaths, function(a,b) return a and b and a.ts > b.ts end)
		
		for i, death in ipairs(player.deaths) do
			local died_at = death.ts
			local length_alive = died_at - starttime
			local alive_timespan = SecondsToTime(length_alive)
			
			local d = win.dataset[nr] or {}
			win.dataset[nr] = d
			
			d.id = nr
			d.label = player.name
			d.class = player.class
			
			d.ts = death.ts
			d.value = 1
			
			if (timespan == nil) then
				d.valuetext = "unknown"
			else
				d.valuetext = alive_timespan .. "/" .. timespan
			end
			
			nr = nr + 1
		end
	end
end

function mod:OnEnable()
	mod.metadata 		= {click1 = deathlog, columns = {Deaths = true, Percent = true, Timestamp = true}}
	deathlog.metadata 	= {ordersort = true, columns = {Change = true, Health = false, Percent = true}}
	
	-- Skada:RegisterForCL(UnitDied, 'UNIT_DIED', {dst_is_interesting_nopets = true})
	
	Skada:AddMode(self)
end

function mod:OnDisable()
	Skada:RemoveMode(self)
end

function mod:GetSetSummary(set)
	local duration = 0
	if set.name ~= "Total" then
		if (set.endtime == nil) then 
			duration = 0
		else
			duration = set.endtime - set.starttime
		end
		
	else
		local sets = Skada:GetSets()
		
		for i, myset in ipairs(sets) do
			duration = duration + (myset.endtime - myset.starttime)
		end
	end
	return SecondsToTime(duration)
end