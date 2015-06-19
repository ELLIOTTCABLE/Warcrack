
local ZoneText = CreateFrame("Frame", "StatBlock_ZoneText")
ZoneText.obj = LibStub("LibDataBroker-1.1"):NewDataObject("ZoneText", {type = "data source", text = "ZoneText"})

local GetSubZoneText = GetSubZoneText
local GetRealZoneText = GetRealZoneText
ZoneText:SetScript("OnEvent", function()
	local zone = GetSubZoneText()
	if zone == "" then
		zone = GetRealZoneText()
	end

	ZoneText.obj.text = zone
end)

ZoneText:RegisterEvent("ZONE_CHANGED_INDOORS")
ZoneText:RegisterEvent("ZONE_CHANGED")
ZoneText:RegisterEvent("ZONE_CHANGED_NEW_AREA")
ZoneText:RegisterEvent("PLAYER_LOGIN")

