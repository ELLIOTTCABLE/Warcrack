GridStatusEmphasize.Modes = { }

local temp_emphasized_units = GridStatusEmphasize.temp_emphasized_units
local static_emphasized_units = GridStatusEmphasize.static_emphasized_units
local core = GridStatusEmphasize.core
local GridRoster = Grid:GetModule("GridRoster")
local settings

local cos = math.cos
local GetTime = GetTime

function GridStatusEmphasize.Modes:Initialize()
	settings = GridStatusEmphasize.db.profile.alert_emphasize
end

local function tisempty(t)
	return next(t) == nil
end

--[[ Lower
GridStatusEmphasize.Modes.Lower = {}

function GridStatusEmphasize.Modes.Lower:Initialize()
end

function GridStatusEmphasize.Modes.Lower:Disable()
end

local lower_color = { r = 0, g = 0, b = 0, a = 0 }

function GridStatusEmphasize.Modes.Lower:Update()
	if tisempty(temp_emphasized_units) then
		core:SendStatusLostAllUnits("alert_emphasize")
	else
		lower_color.a = settings.others_alpha
		for guid, unitid in GridRoster:IterateRoster() do
			if temp_emphasized_units[guid] or static_emphasized_units[guid] then
				core:SendStatusLost(guid, "alert_emphasize")
			else
				core:SendStatusGained(guid,
							"alert_emphasize",
							settings.priority,
							nil,
							lower_color,
							1,
							nil,
							nil)
			end
		end
	end
end
]]

-- Smooth blink
GridStatusEmphasize.Modes.SmoothBlink = {}

function GridStatusEmphasize.Modes.SmoothBlink:Initialize()
	if not self.update_frame then
		self.update_frame = CreateFrame("Frame")		
	end

	self.update_frame:SetScript("OnUpdate", 
		function(_, elapsed)
			GridStatusEmphasize.Modes.SmoothBlink:BlinkEmphasizeStep(elapsed)
		end)
end

function GridStatusEmphasize.Modes.SmoothBlink:Disable()
	self.update_frame:SetScript("OnUpdate", nil)
end

function GridStatusEmphasize.Modes.SmoothBlink:Update()
	if tisempty(temp_emphasized_units) then
		core:SendStatusLostAllUnits("alert_emphasize")
	else
		for guid in GridRoster:IterateRoster() do
			if not temp_emphasized_units[guid] then
				core:SendStatusLost(guid, "alert_emphasize")
			end
		end
	end
end

local cycle = 2 * math.pi
local alpha_low = 0.3
local update_cycle = 1/30
local update_time = 0
-- Two tables are needed because Grid, retardedly, won't update the status
-- if it is passed the same table, despite having different values.
local smooth_colors = {
	{ r = 0, g = 0, b = 0, a = 0 },
	{ r = 0, g = 0, b = 0, a = 0 },
}
local step = 0

function GridStatusEmphasize.Modes.SmoothBlink:BlinkEmphasizeStep(elapsed)
	update_time = update_time + elapsed
	
	if update_time >= update_cycle then
		update_time = 0
		if not tisempty(temp_emphasized_units) then
			step = (step + 1) % 2
			local smooth_color = smooth_colors[step + 1]
			local x = GetTime() * cycle * settings.cycles_sec
			local alpha = (cos(x) + 1) * 0.5 * (1 - alpha_low) + alpha_low
			smooth_color.a = alpha
			
			for guid, tags in pairs(temp_emphasized_units) do
				local tag = next(tags)
				local best = tags[tag]
				while true do
					tag = next(tags, tag)
					if not tag then break end
					local tdata = tags[tag]
					if tdata.p > best.p then
						best = tdata
					end
				end

				local tag_color = best.c
				smooth_color.r = tag_color.r
				smooth_color.g = tag_color.g
				smooth_color.b = tag_color.b
				
				core:SendStatusGained(guid,
							"alert_emphasize",
							settings.priority,
							nil,
							smooth_color)
			end
		end
	end
end
