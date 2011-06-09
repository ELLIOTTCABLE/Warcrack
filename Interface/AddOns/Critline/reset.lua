local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local templates = addon.templates

local treeNames = addon.treeNames
-- history for undoing recent (last fight) records
local history = {dmg = {}, heal = {}, pet = {}}


local module = templates:CreateList("CritlineReset", L["Reset"])
module:RegisterEvent("PLAYER_REGEN_DISABLED")
module:SetScript("OnEvent", function(self)
	-- previous records are wiped upon entering combat
	self:ClearHistory()
end)

module.history = history

-- reset/announce button
local button = templates:CreateButton(module)
button:SetPoint("TOPRIGHT", module.scrollFrame, "BOTTOMRIGHT", 0, -7)
button:SetSize(100, 22)
button:SetText(L["Reset all"])
button:SetScript("OnClick", function(self)
	PlaySound("gsTitleOptionOK")
	StaticPopup_Show("CRITLINE_RESET_ALL", addon.treeNames[module.tree:GetSelectedValue()])
end)

-- "edit tooltip format" popup
StaticPopupDialogs["CRITLINE_RESET_ALL"] = {
	text = L["Are you sure you want to reset all %s records?"],
	button1 = OKAY,
	button2 = CANCEL,
	OnAccept = function(self)
		module:ResetAll()
	end,
	whileDead = true,
	timeout = 0,
}


function module:Reset(data)
	local tree = self.tree.selectedValue
	addon:DeleteSpell(tree, data.spellID, data.periodic)
	addon:UpdateRecords(tree)
end


function module:Undo(data)
	local tree = self.tree.selectedValue
	local history = history[tree][data.spellID]
	local spell = addon:GetSpellInfo(tree, data.spellID, data.periodic)
	for k, v in pairs(history[data.periodic]) do
		local hitType = spell[k]
		local amount, target = hitType.amount, hitType.target
		for k, v in pairs(v) do
			hitType[k] = v
		end
		addon:Message(format("Reverted %s (%d, %s) record on %s.", data.spellName, amount, tree, target))
	end
	history[data.periodic] = nil
	addon:UpdateTopRecords(tree)
	addon:UpdateRecords(tree)
end


function module:ResetAll()
	local tree = self.tree:GetSelectedValue()
	local spells = addon.percharDB.profile.spells[tree]
	
	wipe(spells)
	wipe(addon:GetSpellArray(tree))
	addon:Message(format(L["Reset all %s records."], treeNames[tree]))
	
	self:Update()
	addon:UpdateTopRecords(tree)
	addon:UpdateSpells(tree)
end


-- stores previous record for the undo feature
function module:NewRecord(event, tree, spellID, periodic, amount, crit, prevRecord)
	-- do not store previous record if it was 0
	if prevRecord.amount == 0 then
		return
	end
	
	history[tree][spellID] = history[tree][spellID] or {}
	local hitType = crit and "crit" or "normal"
	local spell = history[tree][spellID]
	spell[periodic] = spell[periodic] or {}
	-- do not store previous records gained in current fight
	if spell[periodic][hitType] then
		return
	else
		spell[periodic][hitType] = {}
	end
	for k, v in pairs(prevRecord) do
		spell[periodic][hitType][k] = v
	end
	addon:Debug(format("Storing previous record for %s = %d (%s, %s, %s)", addon:GetSpellName(spellID), prevRecord.amount, tree, periodic == 2 and "periodic" or "direct", hitType))
end

addon.RegisterCallback(module, "NewRecord")


function module:ClearHistory()
	for k, tree in pairs(history) do
		wipe(tree)
	end
	self:Update()
end

addon.RegisterCallback(module, "PerCharSettingsLoaded", "ClearHistory")