
local obj = LibStub("LibDataBroker-1.1"):NewDataObject("Coords", {type = "data source", text = "00.0, 00.0"})

local GetPlayerMapPosition = GetPlayerMapPosition
local format = string.format
local CTimerAfter = C_Timer.After

local function func()
	CTimerAfter(0.1, func)
	local x, y = GetPlayerMapPosition"player"
	obj.text = format("%.1f, %.1f", x*100, y*100)
end
func()

