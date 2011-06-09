local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local templates = addon.templates


local module = templates:CreateList("CritlineAnnounce", L["Announce"], "Announce")

addon.RegisterCallback(module, "SpellsChanged", "Update")

local function onClick(self)
	self.owner:SetSelectedValue(self.value)
	local target = module.target
	if self.value == "WHISPER" or self.value == "CHANNEL" then
		target:Show()
		target:SetFocus()
	else
		target:Hide()
	end
end

local channels = {
	"SAY",
	"GUILD",
	"PARTY",
	"RAID",
	"WHISPER",
	"CHANNEL",
}

local channel = templates:CreateDropDownMenu("CritlineAnnounceChannel", module, nil, _G)
channel:SetFrameWidth(120)
channel:SetPoint("TOPLEFT", module.tree, "BOTTOMLEFT")
channel:SetSelectedValue("SAY")
channel.initialize = function(self)
	for i, v in ipairs(channels) do
		local info = UIDropDownMenu_CreateInfo()
		info.text = _G[v]
		info.value = v
		info.func = onClick
		info.owner = self
		UIDropDownMenu_AddButton(info)
	end
end
module.channel = channel

local target = templates:CreateEditBox(module)
target:SetWidth(144)
target:SetPoint("LEFT", channel, "RIGHT", 0, 2)
target:SetScript("OnEnterPressed", target.ClearFocus)
target:SetScript("OnEscapePressed", target.ClearFocus)
target:Hide()
module.target = target


local announceFormat = format("%%s - %s: %%s %s: %%s", L["Normal"], L["Crit"])

function module:Announce(data)
	local channel = self.channel:GetSelectedValue()
	local target = self.target:GetText():trim()
	
	if channel == "WHISPER" then
		if target == "" then
			addon:Message(L["Invalid player name."])
			return
		end
	elseif channel == "CHANNEL" then
		target = GetChannelName(target)
		if target == 0 then
			addon:Message(L["Invalid channel. Please enter a valid channel name or ID."])
			return
		end
	end
	
	local normal = data.normal and addon:ShortenNumber(data.normal.amount)
	local crit = data.crit and addon:ShortenNumber(data.crit.amount)
	local text = format(announceFormat, addon:GetFullSpellName(data.spellID, data.periodic, true), (normal or L["n/a"]), (crit or L["n/a"]))
	SendChatMessage(text, channel, nil, target)

	self.target:SetText("")
end