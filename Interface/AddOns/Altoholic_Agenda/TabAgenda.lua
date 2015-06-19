local addonName = "Altoholic"
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local parentName = "AltoholicTabAgenda"
local parent

local currentMode

local childrenFrames = {
	"Calendar",
	"Contacts",
}

local childrenObjects = {}		-- these are the tables that actually contain the BuildView & Update methods. Not really OOP, but enough for our needs

addon.Tabs.Agenda = {}

local ns = addon.Tabs.Agenda		-- ns = namespace

function ns:MenuItem_OnClick(id)

	for _, v in pairs(childrenFrames) do			-- hide all frames
		if _G[ "AltoholicFrame" .. v] then
			_G[ "AltoholicFrame" .. v]:Hide()
		end
	end

	ns:SetMode(id)
	
	local f = _G[ "AltoholicFrame" .. childrenFrames[id]]
	local o = childrenObjects[id]
	
	if o.BuildView then
		o:BuildView()
	end
	f:Show()
	o:Update()
	
	for i = 1, 5 do 
		parent["MenuItem"..i]:UnlockHighlight()
	end
	parent["MenuItem"..id]:LockHighlight()
end

function ns:SetMode(mode)
	currentMode = mode
end

function ns:Refresh()
	if AltoholicFrameCalendar:IsVisible() then
		addon.Calendar:Update()
	elseif AltoholicFrameContacts:IsVisible() then
		addon.Contacts:Update()
	end
end

function ns:RegisterChildPane(pane)
	table.insert(childrenObjects, pane)
end

function ns:OnLoad()
	parent = _G[parentName]
	parent.MenuItem1:SetText(L["Calendar"])
	parent.MenuItem2:SetText("Contacts")
	parent.MenuItem3:SetText("Tasks")
	parent.MenuItem4:SetText("Notes")
	parent.MenuItem5:SetText("Mail")
	
	addon:RegisterMessage("DATASTORE_ITEM_COOLDOWN_UPDATED")
	addon:RegisterMessage("DATASTORE_CALENDAR_SCANNED")
end

function addon:DATASTORE_ITEM_COOLDOWN_UPDATED(event, itemID)
	addon.Calendar:InvalidateView()
	ns:Refresh()
end

function addon:DATASTORE_CALENDAR_SCANNED(event)
	addon.Calendar:InvalidateView()
	ns:Refresh()
end
