
local latency = {}
local lbl = "MS"
latency.obj = _G.LibStub("LibDataBroker-1.1"):NewDataObject("Latency", {type = "data source", value = "0", suffix = lbl, text = "0"..lbl})
_G.LibStub("AceTimer-3.0"):Embed(latency)

function latency:Update()
	local _, _, l = _G.GetNetStats()
	self.obj.text = l..lbl
	self.obj.value = l
end

latency:ScheduleRepeatingTimer("Update", 30)
latency:ScheduleTimer("Update", 4)
