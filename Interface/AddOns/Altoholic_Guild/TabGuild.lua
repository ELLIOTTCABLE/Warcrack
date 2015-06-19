local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local parentName = "AltoholicTabGuild"
local parent
local currentMode
local childrenObjects		-- these are the tables that actually contain the BuildView & Update methods. Not really OOP, but enough for our needs
local childrenFrames = {
	"Members",
	"Bank",
}

addon.Guild = {}
addon.Tabs.Guild = {}

local ns = addon.Tabs.Guild		-- ns = namespace

local function OnRosterUpdate()
	local _, onlineMembers = GetNumGuildMembers()
	parent.MenuItem1.Text:SetText(format("%s %s(%d)", L["Guild Members"], colors.green, onlineMembers))
	
	addon.Guild.Members:InvalidateView()
end

function ns:OnLoad()
	parent = _G[parentName]
	
	-- localization stuff
	parent.MenuItem1:SetText(L["Guild Members"])
	parent.MenuItem1:Show()
	parent.MenuItem2:SetText(GUILD_BANK)
	parent.MenuItem2:Show()
	
	-- register datastore events
	addon:RegisterMessage("DATASTORE_GUILD_ALTS_RECEIVED")

	addon:RegisterMessage("DATASTORE_BANKTAB_REQUEST_ACK")
	addon:RegisterMessage("DATASTORE_BANKTAB_REQUEST_REJECTED")
	addon:RegisterMessage("DATASTORE_BANKTAB_UPDATE_SUCCESS")
	addon:RegisterMessage("DATASTORE_GUILD_MEMBER_OFFLINE")
	
	if IsInGuild() then
		addon:RegisterEvent("GUILD_ROSTER_UPDATE", OnRosterUpdate);
	end
end

function ns:OnShow()
	if not currentMode then
		childrenObjects = {
			addon.Guild.Members,
			addon.Guild.Bank,
		}
		
		ns:MenuItem_OnClick(1)
	end
end

function ns:SetMode(mode)
	currentMode = mode
	
	if mode == 1 then
		parent.SortButtons:ShowChildFrames()
		parent.SortButtons:SetButton(1, NAME, 100, function(self) addon.Guild.Members:Sort(self, "name") end)
		parent.SortButtons:SetButton(2, LEVEL, 60, function(self) addon.Guild.Members:Sort(self, "level") end)
		parent.SortButtons:SetButton(3, "AiL", 65, function(self) addon.Guild.Members:Sort(self, "averageItemLvl") end)
		parent.SortButtons:SetButton(4, GAME_VERSION_LABEL, 80, function(self) addon.Guild.Members:Sort(self, "version") end)
		parent.SortButtons:SetButton(5, CLASS, 100, function(self) addon.Guild.Members:Sort(self, "englishClass") end)
	else
		parent.SortButtons:HideChildFrames()
	end
end

function ns:MenuItem_OnClick(id)
	for _, v in pairs(childrenFrames) do			-- hide all frames
		parent[v]:Hide()
	end

	ns:SetMode(id)
	
	parent[childrenFrames[id]]:Show()
	childrenObjects[id]:Update()
	
	for i = 1, 2 do 
		parent["MenuItem"..i]:UnlockHighlight()
	end
	parent["MenuItem"..id]:LockHighlight()
end

-- *** DataStore Event Handlers ***
function addon:DATASTORE_GUILD_ALTS_RECEIVED(event, sender, alts)
	addon.Guild.Members:InvalidateView()
end

function addon:DATASTORE_BANKTAB_REQUEST_ACK(event, sender)
	addon:Print(format(L["Waiting for %s to accept .."], sender))
end

function addon:DATASTORE_BANKTAB_REQUEST_REJECTED(event, sender)
	addon:Print(format(L["Request rejected by %s"], sender))
end

function addon:DATASTORE_BANKTAB_UPDATE_SUCCESS(event, sender, guildName, tabName, tabID)
	addon:Print(format(L["Guild bank tab %s successfully updated !"], tabName ))
	addon.Guild.Bank:Update()
end

function addon:DATASTORE_GUILD_MEMBER_OFFLINE(event, member)
	addon.Guild.Members:InvalidateView()
end
