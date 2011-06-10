local L = LibStub("AceLocale-3.0"):GetLocale("GridStatusControlPipes")

--local AceOO = AceLibrary("AceOO-2.0")

local GridStatus = Grid:GetModule("GridStatus")

local OO = AnotherStupidSmallOOLibraryEspeciallyJustAndOnlyForGridStatusControlPipes_GoodEhQuestionmark

local PipeFilter = OO.NewClass()


------------------------------------
--      General pipe filter       --
------------------------------------

function PipeFilter.prototype:init(pipe, id, db, options)
    self.options = options
    self.db = db
    self.pipe = pipe
end

function PipeFilter.prototype:Destroy()
end

function PipeFilter:RegisterFilterType(name, class)
    self.filterTypes = self.filterTypes or {}

    self.filterTypes[name] = class
    GridPipeClass:RegisterFilter(name, class)
end


------------------------------------
--          ToBarFilter           --
------------------------------------

local ToBarFilter = OO.NewClass(PipeFilter)
PipeFilter:RegisterFilterType("To-bar filter", ToBarFilter)

function ToBarFilter.prototype:init(pipe, id, db, options)
    ToBarFilter.super.prototype.init(self, pipe, id, db, options)
    pipe:StatusResending(true)
end

function ToBarFilter.prototype:Filter(guid, color, text, value, maxValue, texture, start, duration, stack, ...)
    if start and duration then
        value = start + duration - GetTime()
        maxValue = duration
    end
    return guid, color, text, value, maxValue, texture, start, duration, stack, ...
end

function ToBarFilter:GetName()
    return "To-bar filter"
end

------------------------------------
--       ClassColorFilter         --
------------------------------------

local ClassColorFilter = OO.NewClass(PipeFilter)
PipeFilter:RegisterFilterType("Class color filter", ClassColorFilter)

function ClassColorFilter.prototype:Filter(guid, color, text, value, maxValue, texture, start, duration, stack, ...)
    if color then
        color = GridStatus:UnitColor(guid) or color
    end
    return guid, color, text, value, maxValue, texture, start, duration, stack, ...
end

function ClassColorFilter:GetName()
    return "Class color filter"
end

------------------------------------
--          ToTextFilter          --
------------------------------------

local ToTextFilter = OO.NewClass(PipeFilter)
PipeFilter:RegisterFilterType("To-text filter", ToTextFilter)

function ToTextFilter.prototype:init(pipe, id, db, options)
    ToTextFilter.super.prototype.init(self, pipe, id, db, options)
    
    self.db.status = self.db.status or "value"
    if self.db.status == "duration" then
        pipe:StatusResending(true)
    end
    self.options.args = {
        ["status"] = {
            type = "select",
            name = L["Status"],
            desc = L["The status which should be converted to text."],
            get = function ()
                return self.db.status
            end,
            set = function(_, v)
                self.db.status = v
                if self.db.status == "duration" then
                    pipe:StatusResending(true)
                end
                self.pipe:UpdateAll()
            end,
            values = { ["value"] = L["Value"], ["duration"] = L["Duration"], ["stacks"] = L["Stacks"] },
            order = 10,
        },
    }
end

local function FormatText(val)
	local healthText
	if val > 999 then
		healthText = string.format("%.1fk", val/1000.0)
	else
		healthText = string.format("%d", val)
	end

	return healthText
end

function ToTextFilter.prototype:Filter(guid, color, text, value, maxValue, texture, start, duration, stack, ...)
    if value and self.db.status == "value" then
        text = FormatText(value)
    elseif start and duration and self.db.status == "duration" then
        text = string.format("%.0f", (start+duration)-GetTime())
    elseif stack and self.db.status == "stacks" then
        text = string.format("%d", stack)
    end

    return guid, color, text, value, maxValue, texture, start, duration, stack, ...
end

function ToTextFilter:GetName()
    return "To-text filter"
end


PipeFilterClass = PipeFilter
ToTextFilterClass = ToTextFilter
ToBarFilterClass = ToBarFilter