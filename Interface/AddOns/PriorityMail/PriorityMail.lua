
----------------------------
--      Localization      --
----------------------------

local L = {
	["Alt-Click to mail this item."] = "Alt-Click to mail this item.",
}


------------------------------
--      Are you local?      --
------------------------------

local last, mailshown
local SendMailNameEditBox, SendMailFrame = SendMailNameEditBox, SendMailFrame


---------------------------------
--      Addon Declaration      --
---------------------------------

PriorityMail = DongleStub("Dongle-1.0"):New("PriorityMail")

function PriorityMail:Enable()
	SendMailNameEditBox:SetHistoryLines(15)

	self:RegisterEvent("MAIL_SHOW", function() mailshown = true end)
	self:RegisterEvent("MAIL_CLOSED", function() mailshown = false end)
	self:RegisterEvent("MAIL_SEND_INFO_UPDATE")
end


-------------------------------
--      Auto-fill Hooks      --
-------------------------------

local orig1 = SendMailFrame_Reset
local post1 = function(...)
	if last then
		SendMailNameEditBox:SetText(last)
		SendMailNameEditBox:HighlightText()
	end
	return ...
end
SendMailFrame_Reset = function(...)
	if not last then last = SendMailNameEditBox:GetText() end
	return post1(orig1(...))
end


local orig2 = SendMailFrame_SendMail
SendMailFrame_SendMail = function(...)
	last = SendMailNameEditBox:GetText()
	SendMailNameEditBox:AddHistoryLine(last)
	return orig2(...)
end


local orig3 = MailFrameTab_OnClick
local post3 = function(...)
	if last and not SendMailNameEditBox:GetText() then
		SendMailNameEditBox:SetText(last)
		SendMailNameEditBox:HighlightText()
	end
	return ...
end
MailFrameTab_OnClick = function(tab, ...)
	return post3(orig3(tab, ...))
end


--------------------------------------
--      Alt-click item sending      --
--------------------------------------

local orig4 = GameTooltip:GetScript("OnTooltipSetItem")
GameTooltip:SetScript("OnTooltipSetItem", function(tooltip, ...)
	if mailshown and SendMailFrame:IsVisible() and not CursorHasItem() then
		tooltip:AddLine(L["Alt-Click to mail this item."])
	end
	if orig4 then return orig4(tooltip, ...) end
end)


local orig5 = ContainerFrameItemButton_OnModifiedClick
ContainerFrameItemButton_OnModifiedClick = function(button, ...)
	if mailshown and button == "LeftButton" and IsAltKeyDown() and SendMailFrame:IsVisible() and not CursorHasItem() then
		local bag, slot = this:GetParent():GetID(), this:GetID()
		local texture, count = GetContainerItemInfo(bag, slot)
		PickupContainerItem(bag, slot)
		ClickSendMailItemButton()

		local _, tex2, count2 = GetSendMailItem()
		if SendMailNameEditBox:GetText() and texture == tex2 and count == count2 then
			SendMailFrame_SendMail()
		end
	else return orig5(button, ...) end
end


---------------------------------------------
--      Auto-send when 12 attachments      --
---------------------------------------------

function PriorityMail:MAIL_SEND_INFO_UPDATE()
	if not SendMailNameEditBox:GetText() then return end

	local attachments = 0
	for i=1,ATTACHMENTS_MAX_SEND do if GetSendMailItem(i) then attachments = attachments + 1 end end
	if attachments == 12 then SendMailFrame_SendMail() end
end


