local function SetDesaturation(texture, desaturation)
	local shaderSupported = texture:SetDesaturated(desaturation)
	if shaderSupported then
		texture:SetVertexColor(1.0, 1.0, 1.0)
	else
		if desaturation then
			texture:SetVertexColor(0.5, 0.5, 0.5)
		else
			texture:SetVertexColor(1.0, 1.0, 1.0)
		end
	end
end


local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("MAIL_INBOX_UPDATE")
frame:RegisterEvent("UPDATE_PENDING_MAIL")
frame:SetScript("OnEvent", function(self, event, addon)
	if event == "MAIL_INBOX_UPDATE" or event == "UPDATE_PENDING_MAIL" then
		if event == "MAIL_INBOX_UPDATE" then
			-- GetInboxNumItems returns 0 until you have checked the inbox, so we need to store it
			ForgottenMailNumInboxItems = GetInboxNumItems()
		end
		if HasNewMail() then
			-- new mail, show mail icon as usual
			MiniMapMailFrame:Show()
			SetDesaturation(MiniMapMailIcon, nil)
			SetDesaturation(MiniMapMailBorder, nil)
		elseif ForgottenMailNumInboxItems > 0 then
			-- no new mail, but old mail, show mail icon and desaturate it
			shaderSupported = false
			MiniMapMailFrame:Show()
			SetDesaturation(MiniMapMailIcon, 1)
			SetDesaturation(MiniMapMailBorder, 1)
		else
			-- no mail at all, hide mail icon
			MiniMapMailFrame:Hide()
		end
	elseif addon == "ForgottenMail" then
		-- old inbox items from last session?
		if not ForgottenMailNumInboxItems then
			ForgottenMailNumInboxItems = 0
		elseif ForgottenMailNumInboxItems > 0 then
			MiniMapMailFrame:Show()
			SetDesaturation(MiniMapMailIcon, 1)
			SetDesaturation(MiniMapMailBorder, 1)
		end
		self:UnregisterEvent("ADDON_LOADED")
	end
end)


-- hook mail icon tooltip text to reflect old inbox items if applicable
function MinimapMailFrameUpdate()
	local sender1, sender2, sender3 = GetLatestThreeSenders()
	local toolText
	
	if (sender1 or sender2 or sender3) then
		toolText = HAVE_MAIL_FROM
	elseif HasNewMail() then
		toolText = HAVE_MAIL
	else
		-- show amount of old inbox items
		toolText = "You have "..ForgottenMailNumInboxItems.." inbox |4item:items;"
	end
	
	if sender1 then
		toolText = toolText.."\n"..sender1
	end
	if sender2 then
		toolText = toolText.."\n"..sender2
	end
	if sender3 then
		toolText = toolText.."\n"..sender3
	end
	GameTooltip:SetText(toolText)
end