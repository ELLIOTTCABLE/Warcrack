
local latency = CreateFrame("Frame"):CreateAnimationGroup()
local lbl = MILLISECONDS_ABBR
local L_TOOLTIP = MAINMENUBAR_LATENCY_LABEL
local obj = LibStub("LibDataBroker-1.1"):NewDataObject("Latency", {type = "data source", value = "0", suffix = lbl, text = "0"..lbl})

local GetNetStats = GetNetStats

function obj.OnTooltipShow(tooltip)
	if not tooltip or not tooltip.AddLine then return end

	local _, _, home, world = GetNetStats()
	tooltip:AddLine(L_TOOLTIP:format(home, world), 0, 1, 1)
end

local update = latency:CreateAnimation()
latency:SetScript("OnLoop", function()
	local _, _, l = GetNetStats()
	obj.text = l..lbl
	obj.value = l
end)
update:SetOrder(1)
update:SetDuration(20)
latency:SetLooping("REPEAT")
latency:Play()

