local db

local addon = CreateFrame("Frame")
addon:RegisterEvent("ADDON_LOADED")
addon:RegisterEvent("MAIL_INBOX_UPDATE")
addon:RegisterEvent("UPDATE_PENDING_MAIL")
addon:SetScript("OnEvent", function(self, event, ...)
	self[event](self, ...)
end)

function addon:ADDON_LOADED(addon)
	if addon ~= "ForgottenMail" then return end
	
	ForgottenMailDB = ForgottenMailDB or {}
	db = ForgottenMailDB
	if db.expiry then
		MiniMapMailIcon:SetDesaturated(true)
		MiniMapMailBorder:SetDesaturated(true)
		MiniMapMailFrame:Show()
	end
	self:UnregisterEvent("ADDON_LOADED")
end

function addon:MAIL_INBOX_UPDATE()
	db.expiry = nil
	db.delete = nil
	local nextExpiry
	for i = 1, GetInboxNumItems() do
		local _, _, sender, subject, money, _, daysLeft = GetInboxHeaderInfo(i)
		if not nextExpiry or daysLeft < nextExpiry then
			nextExpiry = daysLeft
			db.expiry = time() + floor(daysLeft * 24 * 3600)
			db.delete = InboxItemCanDelete(i)
		end
	end
	self:UPDATE_PENDING_MAIL()
end

function addon:UPDATE_PENDING_MAIL()
	local mail = not HasNewMail() and db.expiry
	MiniMapMailIcon:SetDesaturated(mail)
	MiniMapMailBorder:SetDesaturated(mail)
	MiniMapMailFrame:SetShown(HasNewMail() or db.expiry)
end

-- hook mail icon tooltip text to reflect old inbox items if applicable
hooksecurefunc("MinimapMailFrameUpdate", function()
	if not db.expiry then return end
	
	if not HasNewMail() then
		GameTooltip:ClearLines("")
		GameTooltip:AddLine("You have old inbox items")
	end
	GameTooltip:AddLine(" ")
	GameTooltip:AddLine(format("Next item is %s in %s.", db.delete and "deleted" or "returned", SecondsToTime(db.expiry - time(), true, true)), nil, nil, nil, true)
	GameTooltip:Show()
end)