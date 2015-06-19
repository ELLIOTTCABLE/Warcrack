------------------------------------------------------------------------------
--	GridStatusEmphasize by Slaren
------------------------------------------------------------------------------

local GridStatus = Grid:GetModule("GridStatus")

GridStatusEmphasize = Grid:NewStatusModule("GridStatusEmphasize", "AceTimer-3.0")
GridStatusEmphasize.menuName = "Emphasize"

-- module
GridStatusEmphasize.modulePrototype = {
	Debug = Grid.Debug,
}

function GridStatusEmphasize.modulePrototype:OnInitialize()
	if not self.db then
		self.db = Grid.db:RegisterNamespace(self.name, { profile = self.defaultDB or { } })		
	end
	
	self.debugging = GridStatusEmphasize.db.profile.debug
	self.debugFrame = self.debugFrame
end

function GridStatusEmphasize.modulePrototype:RegisterOptions(name, args)
	GridStatusEmphasize.emphasize_options[name] = {
		type ="group",
		name = name,
		desc = "Options for " .. name,
		args = args,
	}
	
	self.options = args
end

function GridStatusEmphasize:OnModuleCreated(module)
	module.super = self.modulePrototype
end

GridStatusEmphasize:SetDefaultModulePrototype(GridStatusEmphasize.modulePrototype)

-- upvalues
local GridRoster = Grid:GetModule("GridRoster")
local GridFrame = Grid:GetModule("GridFrame")
local next = next
local settings

-- data
-- [guid] = { [tag] = color, [tag2] = color.. }
GridStatusEmphasize.temp_emphasized_units = {}
local is_paused = false
local is_enabled = false

GridStatusEmphasize.defaultDB = {
	debug = false,
	is_first_v2 = true,

	alert_emphasize = {
		enable = true,
		priority = 99,
		cycles_sec = 2,
	}
}

local options = {
	color = false,
	opacity = false,
	range = false,
	["speed"] = {
		order = 101,
		type = "range",
		softMin = 0.5,
		softMax = 5,
		step = 0.1,
		width = "full",
		name = "Blink speed",
		desc = "In cycles/sec",
		get = function () return GridStatusEmphasize.db.profile.alert_emphasize.cycles_sec end,
		set = function (_, v) GridStatusEmphasize.db.profile.alert_emphasize.cycles_sec = v end,
	},
	["help"] = {
		order = 102,
		type = "description",
		name = "\n" .. "|cFFFFFF00GridStatusEmphasize|r is designed to be used with the |cFFFFFF00Frame Alpha|r and |cFFFFFF00Health Bar Color|r indicators. Note that by default, the |cFFFFFF00Health Bar Color|r indicator is disabled and can be enabled from the |cFFFFFF00Frame|r tab.",
	},
}

function GridStatusEmphasize:OnInitialize()
	-- GridStatus insists on being retarded, so we skip the call the OnInitilize and just do our own
	-- self.super.OnInitialize(self)
	if not self.db then
		self.db = Grid.db:RegisterNamespace(self.moduleName, { profile = self.defaultDB or { } })
	end

	
	self:RegisterStatus("alert_emphasize", "Emphasize", options, true)
	
	self.emphasize_options = GridStatus.options.args["alert_emphasize"].args
	
	settings = self.db.profile.alert_emphasize

	self.Modes:Initialize()
	
	-- set emphasize to indicators on first run
	if self.db.profile.is_first_v2 then
		GridFrame.db.profile.statusmap["frameAlpha"]["alert_emphasize"] = true
		GridFrame.db.profile.statusmap["barcolor"]["alert_emphasize"] = true
		
		GridFrame:UpdateAllFrames()
		self.db.profile.is_first_v2 = false
	end	
end

function GridStatusEmphasize:OnStatusEnable(status)
	if status == "alert_emphasize" then
		is_enabled = true
		self:RegisterEvent("Grid_RosterUpdated", "RosterUpdated")
		self:InitMode()
	end
end

function GridStatusEmphasize:OnStatusDisable(status)
	if status == "alert_emphasize" then
		is_enabled = false
		self:UnregisterEvent("Grid_RosterUpdated")
		self.core:SendStatusLostAllUnits("alert_emphasize")
		self.mode:Disable()
	end
end

function GridStatusEmphasize:InitMode()
	self.mode = self.Modes.SmoothBlink
	self.mode:Initialize()
	self.mode:Update()
end

local function tisempty(t)
	return next(t) == nil
end

function GridStatusEmphasize:RosterUpdated()
	local need_update = false

	for guid, tags in pairs(self.temp_emphasized_units) do
		if not GridRoster:IsGUIDInRaid(guid) then
			self.temp_emphasized_units[guid] = nil
			need_update = true
		end
	end

	if need_update then
		self:Update()
	end
end

function GridStatusEmphasize:Update()
	if not is_enabled or is_paused then
		return
	end
	
	self.mode:Update()
end

local default_color = { r = 1, g = 1, b = 1 }
local function AddEmphasize(t, guid, tag, priority, color)
	local tdata = {
		p = priority,
		c = color or default_color,
	}
	-- self:Debug("Add ", tag)
	if not t[guid] then
		t[guid] = { [tag] = tdata }
		GridStatusEmphasize:Update()
	else
		t[guid][tag] = tdata
	end
end

local function RemoveEmphasize(t, guid, tag)
	-- self:Debug("Remove ", tag)
	if t[guid] then
		t[guid][tag] = nil
		if tisempty(t[guid]) then
			t[guid] = nil
			GridStatusEmphasize:Update()
		end
	end
end

local function RemoveAllEmphasizes(t, tag)
	-- self:Debug("RemoveAll ", tag)
	local need_update = false
	for guid, _ in pairs(t) do
		if t[guid][tag] then
			t[guid][tag] = nil
			if tisempty(t[guid]) then
				t[guid] = nil
				need_update = true
			end
		end
	end
	
	if need_update then	
		GridStatusEmphasize:Update()
	end
end

-- API
function GridStatusEmphasize:EmphasizeUnit(guid, tag, priority, color)
	AddEmphasize(self.temp_emphasized_units, guid, tag, priority, color)
end

function GridStatusEmphasize:DeemphasizeUnit(guid, tag)
	RemoveEmphasize(self.temp_emphasized_units, guid, tag)
end

function GridStatusEmphasize:DeemphasizeAllUnits(tag)
	RemoveAllEmphasizes(self.temp_emphasized_units, tag)
end

-- Pause and resume updating
function GridStatusEmphasize:Pause()
	is_paused = true
end

function GridStatusEmphasize:Resume()
	is_paused = false
	self:Update()
end

-- Flash
local fns_step
local fns_num_step
function GridStatusEmphasize:Flash(steps)
	if not is_enabled then
		return
	end

	self:CancelTimer(self.flash_timer, true)
	self:Pause()

	fns_step = 1
	fns_num_step = steps or 2
	self.flash_timer = self:ScheduleRepeatingTimer("Flash_Step", 0.200)
	self:Flash_Step()
end

function GridStatusEmphasize:FlashStop()
	self:CancelTimer(self.flash_timer, true)
	self:Resume()
end

local flash_color = { r = 0, g = 0, b = 0, a = 0 }
function GridStatusEmphasize:Flash_Step()
	if (fns_step % 2) == 0 then
		-- show
		self.core:SendStatusLostAllUnits("alert_emphasize")
	else
		-- hide
		flash_color.a = 0.3
		for guid, unitid in GridRoster:IterateRoster() do
			self.core:SendStatusGained(guid,
						"alert_emphasize",
						settings.priority,
						nil,
						flash_color,
						1,
						nil,
						nil)
		end
	end
	
	fns_step = fns_step + 1
	if fns_step == (fns_num_step*2+1) then
		self:FlashStop()
	end
end
