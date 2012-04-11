
local Dura = CreateFrame("Frame", "StatBlock_Durability")
Dura.obj = LibStub("LibDataBroker-1.1"):NewDataObject("Durability", {type = "data source", text = "0%", icon = "Interface\\Icons\\Trade_BlackSmithing"})

local L_GOLD = GOLD_AMOUNT_SYMBOL
local L_SILVER = SILVER_AMOUNT_SYMBOL
local L_COPPER = COPPER_AMOUNT_SYMBOL

local itemSlots = {
	"HeadSlot",
	"ShoulderSlot",
	"ChestSlot",
	"WristSlot",
	"HandsSlot",
	"WaistSlot",
	"LegsSlot",
	"FeetSlot",
	"MainHandSlot",
	"SecondaryHandSlot",
	"RangedSlot",
}

Dura:SetScript("OnEvent", function(self)
	local durability, maximum = 0, 0

	for i=1, #itemSlots do
		local slotId = GetInventorySlotInfo(itemSlots[i])
		local d, m = GetInventoryItemDurability(slotId)
		durability = durability + (d or 0)
		maximum = maximum + (m or 0)
	end

	self.obj.text = ("%.0f%%"):format(durability / maximum * 100)
end)
Dura:RegisterEvent("PLAYER_DEAD")
Dura:RegisterEvent("MERCHANT_CLOSED")
Dura:RegisterEvent("PLAYER_REGEN_ENABLED")
Dura:RegisterEvent("PLAYER_ENTERING_WORLD")

local function FormatCurrency(amount, rep)
	if rep then
		local percent = amount*20/100
		amount = amount - percent
	end
	local gold = floor(amount / 10000)
	local silver = floor((amount - (gold * 10000)) / 100)
	local copper = mod(amount, 100)

	return ("%i|cffffd700%s|r %i|cffc7c7cf%s|r %i|cffeda55f%s|r"):format(gold, L_GOLD, silver, L_SILVER, copper, L_COPPER)
end

local myTip = nil
function Dura.obj.OnTooltipShow(tip)
	if not tip or not tip.AddDoubleLine or MerchantFrame:IsShown() then return end

	if not myTip then myTip = CreateFrame("GameTooltip") end
	local wornRepairCost, bagRepairCost, totalRepairCost = 0, 0, 0

	for i=1, #itemSlots do
		local item = _G["Character" .. itemSlots[i]]
		local hasItem, _, repairCost = myTip:SetInventoryItem("player", item:GetID())
		if hasItem and repairCost and repairCost > 0 then
			wornRepairCost = wornRepairCost + repairCost
		end
	end

	for bag = 0, 4 do
		for slot = 1, GetContainerNumSlots(bag) do
			local hasCooldown, repairCost = myTip:SetBagItem(bag, slot)

			if repairCost and repairCost > 0 then
				bagRepairCost = bagRepairCost + repairCost
			end
		end
	end

	totalRepairCost = wornRepairCost + bagRepairCost

	tip:AddDoubleLine(REPAIR_ALL_ITEMS, FormatCurrency(totalRepairCost), 0, 1, 1, 0, 1, 0)
	tip:AddDoubleLine(("-20%% (%s)"):format(REPUTATION), FormatCurrency(totalRepairCost, true), 0, 1, 1, 0, 1, 0)
	tip:AddDoubleLine(" ", " ")
	tip:AddDoubleLine(CURRENTLY_EQUIPPED, FormatCurrency(wornRepairCost), 0, 1, 1, 0, 1, 0)
	tip:AddDoubleLine(BAGSLOT, FormatCurrency(bagRepairCost), 0, 1, 1, 0, 1, 0)
end

