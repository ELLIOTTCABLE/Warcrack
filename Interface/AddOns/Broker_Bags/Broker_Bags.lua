--[[
Name: Broker_Bags
Description: Keeps track of your favorite things to say

Copyright 2008 Quaiche of Dragonblight

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
]]

local db
local playerName, playerRealm = UnitName("player"), GetRealmName()

local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
local dataobj = ldb:GetDataObjectByName("Bags") or ldb:NewDataObject("Bags", {
	type = "data source", icon = [[Interface\Icons\INV_Misc_Bag_11]], text = "0/0",
	OnClick = function() ToggleBackpack() end,
	OnTooltipShow = function(tip)
		tip:AddLine("Characters on " .. playerRealm)
		for k,v in pairs(db[playerRealm]) do
			tip:AddDoubleLine(k, v, 1,1,1, 1,1,1)
		end
		tip:AddLine("Click to open your bags.")
		tip:AddLine("Hint: Click to open your bags.", 0, 1, 0, true)
	end,
})

local function UpdateText()
	local totalSlots, freeSlots = 0, 0
	local itemLink, subtype, isBag
	for i = 0,NUM_BAG_SLOTS do
		isBag = true
		if i > 0 then
			itemLink = GetInventoryItemLink("player", ContainerIDToInventoryID(i))
			if itemLink then
				subtype = select(7, GetItemInfo(itemLink))
				if (subtype == "Soul Bag") or (subtype == "Ammo Pouch") or (subtype == "Quiver") then
					isBag = false
				end
			end
		end
		if isBag then
			totalSlots = totalSlots + GetContainerNumSlots(i)
			freeSlots = freeSlots + GetContainerNumFreeSlots(i)
		end
	end

	dataobj.text = string.format("%d/%d", totalSlots - freeSlots, totalSlots)
	db[playerRealm][playerName] = dataobj.text
end

local f = CreateFrame("Frame")
f:SetScript("OnEvent", function(self, event, ...) if self[event] then return self[event](self, event, ...) end end)
f:RegisterEvent("ADDON_LOADED")

f:RegisterEvent("BAG_UPDATE")
f.BAG_UPDATE = UpdateText

f:RegisterEvent("UNIT_INVENTORY_CHANGED")
f.UNIT_INVENTORY_CHANGED = UpdateText

function f:ADDON_LOADED(event,addon)
	if addon:lower() ~= "broker_bags" then return end
	db = Broker_BagsDB or {}
	if not db[playerRealm] then db[playerRealm] = {} end	
	LibStub("tekKonfig-AboutPanel").new(nil, "Broker_Bags")
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil

	if IsLoggedIn() then UpdateText() else self:RegisterEvent("PLAYER_LOGIN"); self.PLAYER_LOGIN = UpdateText end
end
