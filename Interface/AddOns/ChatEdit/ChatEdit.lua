--[[
ChatEdit
by Karl Isenberg

Brought to you by the author of ChatScroll:
No more clumsy chat edit interfaces. Just shift-click-it and edit.
]]--

CHAT_EDIT_MAX_LINES = 500;
CHAT_EDIT_HOVER_SCROLL_TIMER = 1/10;

for i=1, 7 do
	_G["ChatFrame"..i]:SetMaxLines(CHAT_EDIT_MAX_LINES);
end

local function Compare(x, y)
	local delta = 0.001
	return x <= y + delta and x >= y - delta
end

ChatEdit = {};

function ChatEdit:Hide()
	ChatEditScrollFrameEditBox:ClearFocus();
	self:RestoreNormalChat(ChatEditScrollFrame:GetParent():GetID());
	ChatEditScrollFrame:Hide();
end

function ChatEdit:RefuseUpdate()
	if (self.ignoreTextChange and self.ignoreTextChange > 0) then
		self.ignoreTextChange = self.ignoreTextChange - 1;
		ChatEditScrollFrame:UpdateScrollChildRect();
	elseif (type(ChatEditScrollFrame.text) == "string") then
		if (ChatEditScrollFrameEditBox:GetText() ~= ChatEditScrollFrame.text) then
			ChatEditScrollFrameEditBox:SetText(ChatEditScrollFrame.text);
			self.ignoreTextChange = 1; --This used to be 2, not sure why
		end
		
	else
		ChatEdit:Hide();
		ChatEditScrollFrameEditBox:SetText("");
		
	end
end

function ChatEdit:Show(id)
	if (ChatEditScrollFrame:IsVisible()) then
		if (id == ChatEditScrollFrame:GetParent():GetID()) then
			return
		end
		ChatEdit:Hide();
	end
	
	local name, fontSize, r, g, b, a, shown, locked, docked = GetChatWindowInfo(id);
	local chatFrame = _G["ChatFrame"..id];
	ChatEditScrollFrame:SetParent(chatFrame);
	ChatEditScrollFrame:SetAllPoints(chatFrame);
	ChatEditScrollFrame:SetScrollChild(ChatEditScrollFrameEditBox);
	--ChatEditScrollFrameEditBox:SetAllPoints(ChatEditScrollFrame);
	if (docked) then
		ChatEditScrollFrameEditBox:SetWidth(DEFAULT_CHAT_FRAME:GetWidth());
	else
		ChatEditScrollFrameEditBox:SetWidth(chatFrame:GetWidth());
	end
	
	--ChatEditScrollFrameEditBox:SetTextInsets(0,0,0,2)
	
	-- Get Chat Text
	self:UpdateText(id);
	
	if (ChatEditScrollFrame:IsShown()) then
		self:RestoreNormalChat(ChatEditScrollFrame:GetParent():GetID());
	end
	self:HideNormalChat(id);
	
	ChatEditScrollFrame:Show();
	
	local ignores = 0;
	
	-- Trigger a ScrollToBottom on the next OnSizeChanged (first open) or OnScrollRangeChanged (subsequent opennings)
	self.newText = true;
	
	-- Update Font and Size
	local fontObj = chatFrame:GetFontObject()
	if fontObj ~= ChatEditScrollFrameEditBox:GetFontObject() then
		ChatEditScrollFrameEditBox:SetFontObject(fontObj)
		ignores = ignores + 1;
	end
	local font, size = ChatEditScrollFrameEditBox:GetFont()
	if not Compare(fontSize, size) then
		ChatEditScrollFrameEditBox:SetFont(font, fontSize)
		ignores = ignores + 1;
	end
	
	-- Set Content
	ChatEditScrollFrameEditBox:SetText(ChatEditScrollFrame.text);
	ignores = ignores + 1;
	
	-- SetFontObject, SetFont and SetText all trigger OnTextChanged. Ignore them any amount of times. 'ignore' still updates the rect.
	self.ignoreTextChange = ignores;
	
	self.hoverUp = ChatEditScrollFrameScrollUp
	self.hoverDown = ChatEditScrollFrameScrollDown

	--/run for i=1111111000, 1111111040 do Portfolio.Print(i) end
end

function ChatEdit:UpdateText(id)
	local text = ""
	local numLines = #(ChatEditScrollFrame.chatData[id])
	for line=1, numLines do
		text = text..ChatEditScrollFrame.chatData[id][line]
		if line ~= numLines then
			text = text.."\n"
		end
	end
	--text = text.."\n "
	ChatEditScrollFrame.text = text
end

function ChatEdit:GetChatOffset(id, chatFrame, font, fontSize)
	-- Impossible to calculate line wraps by measuring line
	-- Scroll Conversion by Emulation
	--[[
	ChatEditScrollFrameMessageFrame:ClearAllPoints();
	ChatEditScrollFrameMessageFrame = nil
	local smf = CreateFrame("MessageFrame", "ChatEditScrollFrameMessageFrame", ChatEditScrollFrame);
	smf:Hide()
	smf:SetPoint("TOPLEFT", ChatEditScrollFrame, "TOPLEFT")
	ChatEditScrollFrame:SetScrollChild(smf);
	smf:SetWidth(ChatEditScrollFrameEditBox:GetWidth());
	smf:SetFont(font, fontSize)
	for line=1, getn(ChatEditScrollFrame.chatData[id]) - chatFrame:GetCurrentScroll() do
		smf:AddMessage(ChatEditScrollFrame.chatData[id][line])
	end
	local height = smf:GetHeight()
	ChatEditScrollFrame:SetScrollChild(ChatEditScrollFrameEditBox);
	return height
	]]--
	return ChatEditScrollFrame:GetVerticalScrollRange()
end

function ChatEdit:HideNormalChat(id)
	local chatFrame = _G["ChatFrame"..id];
	if (not self.CurrentScroll) then
		self.CurrentScroll = {}
	end
	local temp = chatFrame:GetCurrentScroll()
	if (temp > 0 or not self.CurrentScroll[id]) then
		self.CurrentScroll[id] = temp
	end
	chatFrame:SetScrollOffset(0)
	
	if (not self.FadeTimes) then
		self.FadeTimes = {}
	end
	temp = chatFrame:GetFadeDuration()
	if (temp > 0.1 or not self.FadeTimes[id]) then
		self.FadeTimes[id] = temp
	end
	chatFrame:SetFadeDuration(0.1)
	
	if (not self.TimesVisible) then
		self.TimesVisible = {}
	end
	temp = chatFrame:GetTimeVisible()
	if (temp > 0 or not self.TimesVisible[id]) then
		self.TimesVisible[id] = temp
	end
	chatFrame:SetTimeVisible(0)
end

function ChatEdit:RestoreNormalChat(id)
	local chatFrame = _G["ChatFrame"..id];
	if (self.CurrentScroll and self.CurrentScroll[id]) then
		chatFrame:SetScrollOffset(self.CurrentScroll[id])
	end
	
	if (self.FadeTimes and self.FadeTimes[id]) then
		chatFrame:SetFadeDuration(self.FadeTimes[id])
	end
	
	if (self.TimesVisible and self.TimesVisible[id]) then
		chatFrame:SetTimeVisible(self.TimesVisible[id])
	end
	
	chatFrame:SetScrollOffset(chatFrame:GetCurrentScroll())
end

function ChatEdit.ChatFrameScrollUp(chatFrame)
	local currScroll = ChatEditScrollFrame:GetVerticalScroll()
	if (currScroll <= 0 ) then
		return
	end
	local name, fontSize, r, g, b, a, shown, locked, docked = GetChatWindowInfo(chatFrame:GetID());
	ChatEditScrollFrame:SetVerticalScroll(currScroll - fontSize)
end

function ChatEdit.ChatFrameScrollDown(chatFrame)
	local currScroll = ChatEditScrollFrame:GetVerticalScroll()
	local maxScroll = ChatEditScrollFrameEditBox:GetHeight() - chatFrame:GetHeight();
	if (currScroll >= maxScroll ) then
		return
	end
	local name, fontSize, r, g, b, a, shown, locked, docked = GetChatWindowInfo(chatFrame:GetID());
	ChatEditScrollFrame:SetVerticalScroll(currScroll + fontSize)
end

function ChatEdit.ChatFramePageUp(chatFrame)
	local currScroll = ChatEditScrollFrame:GetVerticalScroll()
	if (currScroll <= 0 ) then
		return
	end
	local name, fontSize, r, g, b, a, shown, locked, docked = GetChatWindowInfo(chatFrame:GetID())
	local newScroll = currScroll - chatFrame:GetHeight() + fontSize
	if (newScroll <= 0 ) then
		ChatEditScrollFrame:SetVerticalScroll(0)
	else
		ChatEditScrollFrame:SetVerticalScroll(newScroll)
	end
end

function ChatEdit.ChatFramePageDown(chatFrame)
	local currScroll = ChatEditScrollFrame:GetVerticalScroll()
	local maxScroll = ChatEditScrollFrame:GetVerticalScrollRange()
	if (currScroll >= maxScroll ) then
		return
	end
	local name, fontSize, r, g, b, a, shown, locked, docked = GetChatWindowInfo(chatFrame:GetID())
	local newScroll = currScroll + chatFrame:GetHeight() - fontSize
	if (newScroll >= maxScroll ) then
		ChatEditScrollFrame:SetVerticalScroll(maxScroll)
	else
		ChatEditScrollFrame:SetVerticalScroll(newScroll)
	end
end

function ChatEdit:ScrollToTop()
	ChatEditScrollFrame:SetVerticalScroll(0)
end

function ChatEdit:ScrollToBottom()
	ChatEditScrollFrame:SetVerticalScroll(ChatEditScrollFrame:GetVerticalScrollRange())
end

--[[
function ChatEdit.OnMouseWheel(self,direction)
	if ( IsShiftKeyDown() ) then
		if ( direction > 0 ) then
			ChatEditScrollFrame:ScrollToTop()
		elseif ( direction < 0 ) then
			ChatEditScrollFrame:ScrollToBottom();
		end
	else
		if ( direction > 0 ) then
			ChatEditScrollFrame:ScrollUp();
		elseif ( direction < 0 ) then
			ChatEditScrollFrame:ScrollDown();
		end
	end
end
]]--

function ChatEdit:OnLoad(frame)
	--frame:RegisterEvent("PLAYER_ENTERING_WORLD");
	local chatData = {}
	for id=1, NUM_CHAT_WINDOWS do
		-- init curr text storage
		chatData[id] = {}
	end
	frame.chatData = chatData;
	
	ScrollFrame_OnLoad(frame);
	
	self.ignoreTextChange = 0;
	
	ChatEdit:SetUpHooks();
end

function ChatEdit.ColorText(text, r, g, b, id)
	local color = "|c"..format("FF%.2X%.2X%.2X", (r or 1) * 255, (g or 1) * 255, (b or 1) * 255);
	text = gsub(text, "|r", color)
	--local colorPrefix = format("[%.2f,%.2f,%.2f,%s]", r, g, b, id or "")
	--text = colorPrefix..color..text.."|r"
	text = color..text.."|r"
	return text
end

-- after hook
-- Insert at the end, remove from the front
-- only store as many as are normally visible.
-- addToFront causes it to add to the front of the array, which is usually the oldest text (combat log does this)
function ChatEdit.ChatFrameAddMessage(self, text, r, g, b, lineID, addToFront)
	local id = self:GetID()
	if (type(text) ~= "string" and type(text) ~= "number") then
		return
	end
	local currentMax = getn(ChatEditScrollFrame.chatData[id])
	if (addToFront) then
		tinsert(ChatEditScrollFrame.chatData[id], 1, ChatEdit.ColorText(text, r, g, b))
		if (currentMax > self:GetMaxLines()) then
			tremove(ChatEditScrollFrame.chatData[id])
		end
	else
		tinsert(ChatEditScrollFrame.chatData[id], ChatEdit.ColorText(text, r, g, b))
		if (currentMax > self:GetMaxLines()) then
			tremove(ChatEditScrollFrame.chatData[id], 1)
		end
	end
end

-- after hook
-- Clear the message history
function ChatEdit.ChatFrameClear(self)
	local id = self:GetID()
	ChatEditScrollFrame.chatData[id] = {}
end

-- after hook
-- Truncate the message history
function ChatEdit.ChatFrameSetMaxLines(self, maxLines)
	local id = self:GetID()
	--[[ This would remove from the end, but we need to remove from the front
	for i=maxLines+1, getn(ChatEditScrollFrame.chatData[id]) do 
		t[i] = nil;
	end
	]]--
	local currentMax = getn(ChatEditScrollFrame.chatData[id])
	if (currentMax > maxLines) then
		ChatEditScrollFrame.chatData[id] = { unpack(ChatEditScrollFrame.chatData, currentMax-maxLines, currentMax) }
	end
end

function ChatEdit.WorldFrameOnMouseDown(self, button)
	if (button == "LeftButton" and IsShiftKeyDown()) then
		local chatFrame;
		for id=1, NUM_CHAT_WINDOWS do
			chatFrame = _G["ChatFrame"..id];
			if (chatFrame:IsVisible() and chatFrame:IsMouseOver()) then
				ChatEdit:Show(id);
				return;
			end
		end
	end
	
	if (ChatEditScrollFrame:IsVisible()) then
		if (ChatEditScrollFrame:IsMouseOver()) then
			ChatEditScrollFrameEditBox:SetFocus(1);
		else
			ChatEdit:Hide()
		end
	end
end

function ChatEdit:SetUpHooks()
	if (not self.hooksInPlace) then
		for id=1, NUM_CHAT_WINDOWS do
			local frame = _G["ChatFrame"..id];
			-- hook AddMessage
			hooksecurefunc(frame, "AddMessage", ChatEdit.ChatFrameAddMessage);
			hooksecurefunc(frame, "Clear", ChatEdit.ChatFrameClear);
			hooksecurefunc(frame, "SetMaxLines", ChatEdit.ChatFrameSetMaxLines);
		end
		
		if (type(WorldFrame:GetScript("OnMouseDown")) == "function") then
			WorldFrame:HookScript("OnMouseDown", ChatEdit.WorldFrameOnMouseDown);
		else
			WorldFrame:SetScript("OnMouseDown", ChatEdit.WorldFrameOnMouseDown);
		end

		self.hooksInPlace = true;
	end
end

--[[
function ChatEdit:OnEvent(frame, event)
	if (event == "PLAYER_ENTERING_WORLD") then
		self:SetUpHooks()
	end
end
]]--

function ChatEdit:OnSizeChanged(frame)
	local name, fontSize, r, g, b, a, shown, locked, docked = GetChatWindowInfo(frame:GetParent():GetID());
	if (docked) then
		ChatEditScrollFrameEditBox:SetWidth(DEFAULT_CHAT_FRAME:GetWidth());
	else
		ChatEditScrollFrameEditBox:SetWidth(frame:GetWidth());
	end
	if (self.newText) then
		ChatEdit:ScrollToBottom();
		self.newText = nil;
	end
end

function ChatEdit:OnScrollRangeChanged(frame)
	ScrollFrame_OnScrollRangeChanged(frame, arg2);
	if (self.newText) then
		ChatEdit:ScrollToBottom();
		self.newText = nil;
	end
end

function ChatEdit:OnUpdate()
	if (self.hoverUp:IsMouseOver()) then
		if (not self.scrollTimer) then
			self.scrollTimer = GetTime();
		elseif (GetTime() > (self.scrollTimer + CHAT_EDIT_HOVER_SCROLL_TIMER)) then
			-- scroll up
			ChatEdit.ChatFrameScrollUp(ChatEditScrollFrame:GetParent())
			self.scrollTimer = GetTime();
		end
		
	elseif (self.hoverDown:IsMouseOver()) then
		if (not self.scrollTimer) then
			self.scrollTimer = GetTime();
		elseif (GetTime() > (self.scrollTimer + CHAT_EDIT_HOVER_SCROLL_TIMER)) then
			-- scroll down
			ChatEdit.ChatFrameScrollDown(ChatEditScrollFrame:GetParent())
			self.scrollTimer = GetTime();
		end
		
	elseif (self.ScrollTimer) then
		self.scrollTimer = nil;
		
	end
end

function ChatEdit:OnMouseDown(frame)
	frame:SetScript("OnUpdate", function() ChatEdit:OnUpdate() end)
end

function ChatEdit:OnMouseUp(frame)
	frame:SetScript("OnUpdate", nil)
end

function ChatEdit:OnHide(frame)
	frame:SetScript("OnUpdate", nil)
end
