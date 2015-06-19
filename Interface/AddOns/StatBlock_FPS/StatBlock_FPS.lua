
local lbl = FPS_ABBR
local obj = LibStub("LibDataBroker-1.1"):NewDataObject("FPS", {type = "data source", value = "0", suffix = lbl, text = "0"..lbl})

local format = string.format
local GetFramerate = GetFramerate
local CTimerAfter = C_Timer.After

local function func()
	CTimerAfter(1.5, func)
	local rate = format("%.0f", GetFramerate())
	obj.text = rate..lbl
	obj.value = rate
end
func()

