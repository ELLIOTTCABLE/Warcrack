local L = LibStub("AceLocale-3.0"):GetLocale("GridStatusControlPipes")

--local AceOO = AceLibrary("AceOO-2.0")

local GridFrame = Grid:GetModule("GridFrame")
local GridRoster = Grid:GetModule("GridRoster")
local GridStatus = Grid:GetModule("GridStatus")

local OO = AnotherStupidSmallOOLibraryEspeciallyJustAndOnlyForGridStatusControlPipes_GoodEhQuestionmark
local GridPipe = OO.NewClass()

--[[
local PipeFrameClass = AceOO.Class(GridFrame.frameClass)

local _frameClass = nil
if ( not _frameClass ) then
	_frameClass = GridFrame.frameClass
	GridFrame.frameClass = PipeFrameClass
end
]]


GridPipe.status = Grid:GetModule("GridStatus"):NewModule("PipeStatus", "AceTimer-3.0")

GridPipe.status.menuName = L["Control pipes"]

GridPipe.status.defaultDB = {
}

--GridPipe.status.options = {}


function GridPipe.prototype:init(name, db, options, status)

    self.options = options

    --initialize database
    self.db = db

    db.enable = db.enable or (true and db.enable == nil)
	db.color = db.color or { r = 1, g = 1, b = 1, a = 1 }
	db.priority = db.priority or 50
    db.usePipeColor = db.usePipeColor or false

    self.db.guards = self.db.guards or {}
    self.db.filters = self.db.filters or {}

    --init filters and guards
    self.filters = {}
    self.guards = {}

    self.idCounter = 12

    self.status = status

    self.cache = {}

    self.resending = false

    for id, data in pairs(self.db.guards) do
        self.idCounter = max(self.idCounter, id)

        self:CreateGuard(id, data)
    end

    for id, data in pairs(self.db.filters) do
        self.idCounter = max(self.idCounter, id)

        self:CreateFilter(id, data)
    end
end

function GridPipe.prototype:CreateGuard(id, data)
    local guard = GridPipe:GetGuard(data.name)
    assert(guard)

    self.options.guards.args[tostring(id)] = {
        type = "group",
        name = data.name,
        desc = L["Settings for this guard"],
        args = {},
    }
    self.guards[id] = guard:new(self, id, data.db, self.options.guards.args[tostring(id)])

    self.options.guards.args[tostring(id)].args["remove_"..id] = {
        type = "execute",
        name = L["Remove"],
        desc = L["Removes this guard."],
        func = function() self:DeleteGuard(id) end,
        order = 1,
    }
end

function GridPipe.prototype:CreateFilter(id, data)
    local filter = GridPipe:GetFilter(data.name)
    assert(filter)

    self.options.filters.args[tostring(id)] = {
        type = "group",
        name = data.name,
        desc = L["Settings for this filter"],
        args = {},
    }
    self.filters[id] = filter:new(self, id, data.db, self.options.filters.args[tostring(id)])

    self.options.filters.args[tostring(id)].args["remove_"..id] = {
        type = "execute",
        name = L["Remove"],
        desc = L["Removes this filter."],
        func = function() self:DeleteFilter(id) end,
        order = 1,
    }
end

function GridPipe.prototype:NewUniqueId()
    self.idCounter = self.idCounter + 1
    return self.idCounter
end

function GridPipe.prototype:UpdatePipe()
    if self.resending then
        self:UpdateAll()
    end
end

function GridPipe.prototype:StatusResending(enabled)
    self.resending = enabled
end

function GridPipe.prototype:Destroy()

end

function GridPipe.prototype:GetOptions()
    return self.options
end

function GridPipe.prototype:UpdateAll()
    for guid, id in GridRoster:IterateRoster() do
        self:SendCachedStatus(guid)
    end
end

function GridPipe.prototype:AddFilter(filter)
    local id = self:NewUniqueId()

    local data = {name = filter, db = {}}

    self.db.filters[id] = data
    self:CreateFilter(id, data)
end

function GridPipe.prototype:AddGuard(guard)
    local id = self:NewUniqueId()

    local data = {name = guard, db = {}}

    self.db.guards[id] = data
    self:CreateGuard(id, data)
end

function GridPipe.prototype:DeleteGuard(id)
    self.guards[id]:Destroy()
    self.options.guards.args[tostring(id)] = nil
    self.db.guards[id] = nil
    self.guards[id] = nil

    self:UpdateAll()
end

function GridPipe.prototype:DeleteFilter(id)
    self.filters[id]:Destroy()
    self.options.filters.args[tostring(id)] = nil
    self.db.filters[id] = nil
    self.filters[id] = nil

    self:UpdateAll()
end

function GridPipe.prototype:SendCachedStatus(guid)
    local unitCache = self.cache[guid]
    if not unitCache then
        self:ClearStatus(guid)
    else
        if self:IsOpen(guid, unitCache.color, unitCache.text, unitCache.value, unitCache.maxValue, unitCache.texture, unitCache.start, unitCache.duration, unitCache.stack) then
            self:SendStatus(guid, unitCache.color, unitCache.text, unitCache.value, unitCache.maxValue, unitCache.texture, unitCache.start, unitCache.duration, unitCache.stack)
        else
            self:ClearStatus(guid)
        end
    end
end

function GridPipe.prototype:CacheStatus(guid, color, text, value, maxValue, texture, start, duration, stack, ...)
    local unitCache = self.cache[guid]
    if not unitCache then
        unitCache = {}
        self.cache[guid] = unitCache
    end

    unitCache.color = color
    unitCache.text = text
    unitCache.value = value
    unitCache.maxValue = maxValue
    unitCache.texture = texture
    unitCache.start = start
    unitCache.duration = duration
    unitCache.stack = stack
end

function GridPipe.prototype:ClearCache(guid)
    self.cache[guid] = nil
end

function GridPipe.prototype:IsOpen(guid, color, text, value, maxValue, texture, start, duration, stack, ...)
    local isOpen = true
    for i, guard in pairs(self.guards) do
        isOpen = isOpen and guard:IsOpen(guid, color, text, value, maxValue, texture, start, duration, stack, ...)
        if not isOpen then return false end
    end
    return isOpen
end

function GridPipe.prototype:SendStatus(guid, color, text, value, maxValue, texture, start, duration, stack, ...)


    if self.db.usePipeColor then
        color = self.db.color
    end

    for i, filter in pairs(self.filters) do
        guid, color, text, value, maxValue, texture, start, duration, stack = filter:Filter(guid, color, text, value, maxValue, texture, start, duration, stack, ...)
    end

    GridPipe.status.core:SendStatusGained(guid, self.status,
                self.db.priority, nil,
                color,
                text,
                value, maxValue,
                texture,
                start, duration, stack,
                ...)
end

function GridPipe.prototype:ClearStatus(guid)

    GridPipe.status.core:SendStatusLost(guid, self.status)
end

function GridPipe.prototype:OnStatus(guid, color, text, value, maxValue, texture, start, duration, stack, ...)
    self:CacheStatus(guid, color, text, value, maxValue, texture, start, duration, stack, ...)
    if self:IsOpen(guid, color, text, value, maxValue, texture, start, duration, stack, ...) then
        self:SendStatus(guid, color, text, value, maxValue, texture, start, duration, stack, ...)
    else
        self:ClearStatus(guid)
    end
end

function GridPipe.prototype:OnClearStatus(guid)
    self:ClearCache(guid)
    --if self:IsOpen() then
        self:ClearStatus(guid)
    --end
end

function GridPipe:Init(db, options)
    options.args = {
        ["newpipe"] = {
            type = "input",
            name = L["New pipe"],
            desc = L["Creates a new pipe with the entered name."],
            get = function() return "" end,
            usage = L["<unique pipe name>"],
            set = function(_, v) GridPipe:NewPipe(v) end,
            order = -3,
        },
    }

    GridPipe.options = options

    GridPipe.db = db

    GridPipe.db.pipes = GridPipe.db.pipes or {}

    GridPipe.pipes = {}
    GridPipe.guards = GridPipe.guards or {}
    GridPipe.filters = GridPipe.filters or {}
    
    --[[
    GridStatus.options.args["controlpipes"] = {
        type = "group",
        name = L["Control pipes"],
        desc = L["Control pipes"],
        args = {}
    }
    GridPipe.status.options = GridStatus.options.args["controlpipes"]
    ]]
    
    GridPipe.status.gpTimer = GridPipe.status:ScheduleRepeatingTimer(GridPipe.UpdatePipes, 0.5)

    for name, pipe in pairs(GridPipe.db.pipes) do
        GridPipe:CreatePipe(name)
    end
end

local function GridFrameSetIndicator(indicatorTbl, color, text, value, maxValue, texture, start, duration, stack, ...)
	local indicator = indicatorTbl.__id
    local frame = indicatorTbl.__owner
    if GridPipe:IsPipe(indicator) then
        local unitid = frame and SecureButton_GetModifiedUnit(frame)
        if not unitid then return end
        local guid = UnitGUID(unitid)
        if not guid then return end
        --DEFAULT_CHAT_FRAME:AddMessage(unitid or "nil")
        GridPipe:OnStatus(guid, indicator, color, text, value, maxValue, texture, start, duration, stack, ...)
    end
end

local function GridFrameClearIndicator(indicatorTbl)
    local indicator = indicatorTbl.__id
    local frame = indicatorTbl.__owner
    if GridPipe:IsPipe(indicator) then
        local unitid = frame and SecureButton_GetModifiedUnit(frame)
        if not unitid then return end
        local guid = UnitGUID(unitid)
        if not guid then return end
        --DEFAULT_CHAT_FRAME:AddMessage(SecureButton_GetModifiedUnit(self.frame) or "nil")
        GridPipe:OnClearStatus(guid, indicator)
    end
end

function GridPipe.status:OnInitialize()
    self.super.OnInitialize(self)
    
    --hooksecurefunc(GridFrame.prototype, "SetIndicator", GridFrameSetIndicator)
    --hooksecurefunc(GridFrame.prototype, "ClearIndicator", GridFrameClearIndicator)
end

function GridPipe.UpdatePipes()
    for name, pipe in pairs(GridPipe.pipes) do
        pipe:UpdatePipe()
    end
end

local IndicatorToPipe = setmetatable({}, {
	__index = function(t, i)
        local pipe = string.sub(i, 6)
		rawset(t, i, pipe)
		return pipe
	end,
})

local PipeIndicators = setmetatable({}, {
	__index = function(t, i)
        local first = string.sub(i, 1, 5)
		local isPipe = (first == "pipe_")
		rawset(t, i, isPipe)
		return isPipe
	end,
})

function GridPipe:IsPipe(indicator)
    return PipeIndicators[indicator]
end

function GridPipe:OnStatus(guid, indicator, color, text, value, maxValue, texture, start, duration, stack, ...)
    assert(self:IsPipe(indicator))

    local pipeName = IndicatorToPipe[indicator]
    local pipe = self.pipes[pipeName]
    if not pipe then return end
    assert(pipe)
    pipe:OnStatus(guid, color, text, value, maxValue, texture, start, duration, stack, ...)
end

function GridPipe:OnClearStatus(guid, indicator)
    assert(self:IsPipe(indicator))

    local pipeName = IndicatorToPipe[indicator]

    local pipe = self.pipes[pipeName]
    if not pipe then return end
    assert(pipe)

    pipe:OnClearStatus(guid)
end

function GridPipe:CreateDefaultOptions(name)
    local guardOptions = {
    }
    for guardName, guard in pairs(self.guards) do
        guardOptions["add"..guardName] = {
            type = "execute",
            name = L["New "]..guardName,
            order = 2,
            desc = L["Adds a new guard of type "]..guardName,
            func = function() GridPipe:AddGuard(name, guardName) end
        }
    end

    local filterOptions = {
    }
    for filterName, filter in pairs(self.filters) do
        filterOptions["add"..filterName] = {
            type = "execute",
            name = L["New "]..filterName,
            order = 2,
            desc = L["Adds a new filter of type "]..filterName,
            func = function() GridPipe:AddFilter(name, filterName) end
        }
    end

    local options = {
        ["usepipecolor"] = {
            type = "toggle",
            name = L["Use pipe color"],
            desc = L["If enabled, it will use the color of the pipes status instead the color of the piped status."],
            get = function() return self.status.db.profile["status_pipe_"..name].usePipeColor end,
            set = function(_, v) self.status.db.profile["status_pipe_"..name].usePipeColor = v end,
        },
        ["guards"] = {
            type = "group",
            name = L["Guards"],
            desc = L["Guards control the piping state (piping or not piping)."],
            args = guardOptions,
        },
        ["filters"] = {
            type = "group",
            name = L["Filters"],
            desc = L["Filters change the piped values."],
            args = filterOptions,
        },
    }

    return options
end

function GridPipe:AddFilter(pipeName, filterName)
    local pipe = self.pipes[pipeName]
    assert(pipe)

    pipe:AddFilter(filterName)
end

function GridPipe:AddGuard(pipeName, guardName)
    local pipe = self.pipes[pipeName]
    assert(pipe)

    pipe:AddGuard(guardName)
end

function GridPipe:GetGuard(name)
    local guard = self.guards[name]
    assert(guard, "Could not find guard "..name)

    return guard
end

function GridPipe:GetFilter(name)
    local filter = self.filters[name]
    assert(filter, "Could not find filter "..name)

    return filter
end


function GridPipe:CreatePipe(name)
    local options = self:CreateDefaultOptions(name)
    local statusName = "status_pipe_"..name
    self.status.db.profile[statusName] = self.status.db.profile[statusName] or {}
    local pipe = GridPipe:new(name, self.status.db.profile[statusName], options, statusName)
    self.pipes[name] = pipe

    GridFrame:RegisterIndicator("pipe_"..name, name, nil, nil, GridFrameSetIndicator, GridFrameClearIndicator)
    --local indicators = GridFrame.prototype.indicators
    --table.insert(indicators, { type = "pipe_"..name,    order = 15,  name = name })

    self.status:RegisterStatus(statusName,name,options, false)

    self.options.args[name] = {
        type = "group",
        name = name,
        desc = L["Settings for pipe "]..name,
        args = {
            ["remove"] = {
                type = "execute",
                name = L["Remove - Reload UI!"],
                desc = L["Removes this pipe. You have to reload your UI after this!"],
                func = function() GridPipe:DeletePipe(name) end
            },
        },
    }
end

function GridPipe:NewPipe(name)
    if not self.db.pipes[name] then
        self.db.pipes[name] = {name = name}
        self:CreatePipe(name)
    end
end

function GridPipe:DeletePipe(name)
    local pipe = self.pipes[name]
    if pipe then
        pipe:Destroy()
        self.pipes[name] = nil
        self.db.pipes[name] = nil
        self.status.db.profile["status_pipe_"..name] = nil
        self.status:UnregisterStatus("status_pipe_"..name)

        --[[
        for i, data in ipairs(GridFrame.prototype.indicators) do
            tremove(GridFrame.prototype.indicators, i)
            break
        end
        ]]

        self.options.args[name] = nil
    end
    assert(not self.db.pipes[name])
end

function GridPipe:RegisterGuard(name, guard)
    self.guards = self.guards or {}
    self.guards[name] = guard
end

function GridPipe:RegisterFilter(name, filter)
    self.filters = self.filters or {}
    self.filters[name] = filter
end

GridPipeClass = GridPipe