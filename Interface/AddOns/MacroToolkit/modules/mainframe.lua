local _G = _G
local MT = MacroToolkit
local CreateFrame, PlaySound, GameTooltip, GameTooltip_Hide, UnitName = CreateFrame, PlaySound, GameTooltip, GameTooltip_Hide, UnitName
local format, string, ipairs = format, string, ipairs
local L = MT.L
local AceGUI = MT.LS("AceGUI-3.0")

function MT:FrameOnKeyDown(this, key)
	if GetBindingFromClick(key) == "TOGGLEGAMEMENU" then this:Hide()
	else
		local action = GetBindingAction(key)
		if not MT:IsSecureAction(action) then RunBinding(action) end
	end
end

function MT:CreateMTFrame()
	local mtframe = CreateFrame("Frame", "MacroToolkitFrame", UIParent, "ButtonFrameTemplate")

	local function frameMouseUp()
		mtframe:StopMovingOrSizing()
		MT.db.profile.x = mtframe:GetLeft()
		MT.db.profile.y = mtframe:GetBottom()
	end

	mtframe:SetScale(MT.db.profile.scale)
	mtframe:SetSize(638, MT.db.profile.height)
	mtframe:SetMovable(true)
	mtframe:EnableMouse(true)
	mtframe:EnableKeyboard(true)
	mtframe:SetResizable(true)
	mtframe:SetMinResize(638, 424)
	mtframe:SetMaxResize(638, UIParent:GetHeight() - 220)
	mtframe:SetPoint("BOTTOMLEFT", MT.db.profile.x, MT.db.profile.y)
	mtframe:SetScript("OnMouseDown", function() mtframe:StartMoving() end)
	mtframe:SetScript("OnMouseUp", frameMouseUp)
	--need a null texture to get the filenames from icon numbers ... is there an api call to do this???
	mtframe.nulltexture = mtframe:CreateTexture("BACKGROUND")
	--if MT.db.profile.escape then mtframe:SetScript("OnKeyDown", function(this, key) MT:FrameOnKeyDown(this, key) end) end

	local mtfportrait = mtframe:CreateTexture(nil, "OVERLAY", nil, 1)
	mtfportrait:SetSize(96, 96)
	mtfportrait:SetTexture("Interface\\AddOns\\MacroToolkit\\mt")
	mtfportrait:SetPoint("TOPLEFT", -24, 24)
	
	local mttitle = mtframe:CreateFontString(nil, "BORDER", "GameFontNormal")
	mttitle:SetText("Macro Toolkit")
	mttitle:SetPoint("TOP", 0, -5)
	
	local drake, mterrorbg
	local mtresizer = CreateFrame("Frame", nil, mtframe)
	mtresizer:SetSize(638, 28)
	mtresizer:SetPoint("BOTTOMLEFT")
	mtresizer:EnableMouse(true)
	mtresizer:SetScript("OnMouseDown", function() drake:Hide(); mtframe:StartSizing() end)
	mtresizer:SetScript("OnMouseUp",
		function()
			frameMouseUp()
			MT.db.profile.height = mtframe:GetHeight()
			drake:SetPoint("TOPLEFT", 342, -220 - ((mtframe:GetHeight() -424) / 2))
			if MT.db.profile.visdrake then drake:Show() end
		end)
	local lvl = mtresizer:GetFrameLevel() + 1

	local mtcustomflyout = CreateFrame("Button", "MacroToolkitFlyout")
	mtcustomflyout:SetSize(32, 32)
	mtcustomflyout:SetPoint("TOPRIGHT", mtframe, "TOPRIGHT", -4, -27)
	mtcustomflyout:SetScript("OnEnter",
		function(this)
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
			GameTooltip:SetText(L["Show custom commands"])
		end)
	mtcustomflyout:SetScript("OnClick",
		function()
			if MT.showingcustom then
				MT.showcustom.frame:Hide()
				MT.showingcustom = nil
			else
				if not MT.showcustom then
					MT.showcustom = AceGUI:Create("InlineGroup")
					MT.showcustom.frame:Hide()
					MT.showcustom:SetWidth(120)
					MT.showcustom:SetPoint("TOPLEFT", mtcustomflyout, "TOPRIGHT", 6, 0)
					MT.showcustom.frame:SetScript("OnShow", function() PlaySound("igCharacterInfoOpen") end)
					MT.showcustom.frame:SetScript("OnHide", function() PlaySound("igCharacterInfoClose") end)
				end
				MT.showcustom:ReleaseChildren()
				for _, c in ipairs(MT.db.global.custom) do
					local l = AceGUI:Create("Label")
					l:SetText(format("%s%s", MT.slash, c.n))
					l:SetWidth(100)
					MT.showcustom:AddChild(l)
				end
				MT.showcustom.frame:Show()
				MT.showingcustom = true
			end
		end)
	mtcustomflyout:SetScript("OnLeave", GameTooltip_Hide)
	mtcustomflyout:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")
	mtcustomflyout:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down")
	mtcustomflyout:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Disabled")
	mtcustomflyout:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")

	local mtcustom = CreateFrame("Button", "MacroToolkitCustom", mtframe, "UIPanelButtonTemplate")
	mtcustom:SetText(_G.CUSTOM)
	mtcustom:SetSize(80, 22)
	mtcustom:SetPoint("TOPRIGHT", mtcustomflyout, "TOPLEFT", 0, -5)
	mtcustomflyout:SetParent(mtcustom)
	mtcustom:SetScript("OnClick",
		function()
			if MT.showingcustom then
				MT.showcustom.frame:Hide()
				MT.showingcustom = nil
			end
			StaticPopup_Show("MACROTOOLKIT_SLASHNAME")
		end)

	local mthbleft = mtframe:CreateTexture(nil, "ARTWORK")
	mthbleft:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-HorizontalBar")
	mthbleft:SetSize(556, 16)
	mthbleft:SetPoint("TOPLEFT", 2, -210)
	mthbleft:SetTexCoord(0, 1, 0, 0.25)

	local mthbright = mtframe:CreateTexture(nil, "ARTWORK")
	mthbright:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-HorizontalBar")
	mthbright:SetSize(75, 16)
	mthbright:SetPoint("LEFT", mthbleft, "RIGHT", 0, 0)
	mthbright:SetTexCoord(0, 0.29296875, 0.25, 0.5)

	local mtselbg = mtframe:CreateTexture("MacroToolkitSelBg", "ARTWORK")
	mtselbg:SetTexture("Interface\\Buttons\\UI-EmptySlot")
	mtselbg:SetSize(64, 64)
	mtselbg:SetPoint("TOPLEFT", 5, -218)

	local mtselname = mtframe:CreateFontString("MacroToolkitSelMacroName", "ARTWORK", "GameFontNormalLarge")
	mtselname:SetJustifyH("LEFT")
	mtselname:SetSize(256, 16)
	mtselname:SetPoint("TOPLEFT", mtselbg, "TOPRIGHT", -4, -10)
	local LSM = MT.LS("LibSharedMedia-3.0")
	local font = LSM:Fetch(LSM.MediaType.FONT, MT.db.profile.fonts.mfont)
	mtselname:SetFont(font, 16)

	local mtentermt = mtframe:CreateFontString("MacroToolkitEnterText", "ARTWORK", "GameFontHighlightSmall")
	mtentermt:SetText(_G.ENTER_MACRO_LABEL)
	mtentermt:SetPoint("TOPLEFT", mtselbg, "BOTTOMLEFT", 8, 3)

	local mtcharlt = mtframe:CreateFontString("MacroToolkitLimit", "ARTWORK", "GameFontHighlightSmall")
	mtcharlt:SetSize(0, 10)
	mtcharlt:SetPoint("BOTTOM", -165, 30)
	
	local mtselbutton = CreateFrame("CheckButton", "MacroToolkitSelMacroButton", mtframe, "MacroToolkitButtonTemplate")
	mtselbutton:SetID(0)
	mtselbutton:SetPoint("TOPLEFT", mtselbg, 14, -14)
	mtselbutton:SetScript("OnClick", function(this) MT:SelOnClick(this) end)
	MacroToolkitSelMacroButtonUnbound:Hide()

	local mtscroll = CreateFrame("ScrollFrame", "MacroToolkitButtonScroll", mtframe, "UIPanelScrollFrameTemplate")
	mtscroll:SetSize(294, 146)
	mtscroll:SetPoint("TOPLEFT", 12, -66)
	ScrollFrame_OnLoad(mtscroll)
	
	local mtscrolltop = mtscroll:CreateTexture(nil, "ARTWORK")
	mtscrolltop:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ScrollBar")
	mtscrolltop:SetSize(31, 102)
	mtscrolltop:SetPoint("TOPLEFT", mtscroll, "TOPRIGHT", -2, 5)
	mtscrolltop:SetTexCoord(0, 0.484375, 0, 0.4)
	
	local mtscrollbot = mtscroll:CreateTexture(nil, "ARTWORK")
	mtscrollbot:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ScrollBar")
	mtscrollbot:SetSize(31, 106)
	mtscrollbot:SetPoint("BOTTOMLEFT", mtscroll, "BOTTOMRIGHT", -2, -2)
	mtscrollbot:SetTexCoord(0.515625, 1, 0, 0.4140625)
	
	local mtscrollmid = mtscroll:CreateTexture(nil, "ARTWORK")
	mtscrollmid:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ScrollBar")
	mtscrollmid:SetSize(31, 1)
	mtscrollmid:SetPoint("TOP", mtscrolltop, "BOTTOM")
	mtscrollmid:SetPoint("BOTTOM", mtscrollbot, "TOP")
	mtscrollmid:SetTexCoord(0, 0.484375, 0.75, 1)

	local mttextbg = CreateFrame("Frame", "MacroToolkitTextBg", mtframe)
	mttextbg:SetPoint("TOPLEFT", 6, -289)
	mttextbg:SetPoint("BOTTOMRIGHT", mtframe, "BOTTOMLEFT", 328, 40)
	mttextbg:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16, tileSize = 16, tile = true, insets = {left = 5, right = 5, top = 5, bottom = 5}})
	mttextbg:SetBackdropBorderColor(_G.TOOLTIP_DEFAULT_COLOR.r, _G.TOOLTIP_DEFAULT_COLOR.g, _G.TOOLTIP_DEFAULT_COLOR.b)
	mttextbg:SetBackdropColor(_G.TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, _G.TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, _G.TOOLTIP_DEFAULT_BACKGROUND_COLOR.b)

	local mtscrollchild = CreateFrame("Frame", "MacroToolkitButtonContainer")
	mtscrollchild:SetSize(285, 10)
	mtscrollchild:SetPoint("TOPLEFT")
	MT:ContainerOnLoad(mtscrollchild)
	mtscroll:SetScrollChild(mtscrollchild)

	local mteditbutton = CreateFrame("Button", "MacroToolkitEdit", mtframe, "UIPanelButtonTemplate")
	mteditbutton:SetText(_G.CHANGE_MACRO_NAME_ICON)
	mteditbutton:SetSize(170, 22)
	mteditbutton:SetPoint("TOPLEFT", mtselbg, 55, -30)
	mteditbutton:SetScript("OnClick", 
		function()
			MT:SaveMacro()
			if not MT.MTPF then MT.MTPF = MT:CreateMTPopup() end
			MT.MTPF.mode = "edit"
			MT.MTPF:Show()
		end)

	local mtmscroll = CreateFrame("ScrollFrame", "MacroToolkitScrollFrame", mttextbg, "UIPanelScrollFrameTemplate")
	mtmscroll:SetPoint("TOPLEFT", 10, -6)
	mtmscroll:SetPoint("BOTTOMRIGHT", -26, 4)

	local function onverticalscroll(this, offset)
		local scrollbar1 = MacroToolkitScrollFrameScrollBar
		local scrollbar2 = MacroToolkitFauxScrollFrameScrollBar
		scrollbar1:SetValue(offset)
		scrollbar2:SetValue(offset)
		local mini1, maxi1 = scrollbar1:GetMinMaxValues()
		local mini2, maxi2 = scrollbar2:GetMinMaxValues()
		if offset == 0 then
			MacroToolkitScrollFrameScrollBarScrollUpButton:Disable()
			MacroToolkitFauxScrollFrameScrollBarScrollUpButton:Disable()
		else
			MacroToolkitScrollFrameScrollBarScrollUpButton:Enable()
			MacroToolkitFauxScrollFrameScrollBarScrollUpButton:Enable()
		end
		if scrollbar1:GetValue() - maxi1 == 0 then
			MacroToolkitScrollFrameScrollBarScrollDownButton:Disable()
			MacroToolkitFauxScrollFrameScrollBarScrollDownButton:Disable()
		else
			MacroToolkitScrollFrameScrollBarScrollDownButton:Enable()
			MacroToolkitFauxScrollFrameScrollBarScrollDownButton:Enable()
		end
	end

	mtmscroll:SetScript("OnVerticalScroll", onverticalscroll)
	mtmscroll:SetScript("OnMouseWheel",
		function(this, value, scrollBar)
			ScrollFrameTemplate_OnMouseWheel(MacroToolkitFauxScrollFrame, value)
			ScrollFrameTemplate_OnMouseWheel(this, value)
		end)
	
	local function ontextchanged(this, userinput)
		MT:UpdateCharLimit()
		if not userinput then return end
		mtframe.textChanged = 1
		if MT.MTPF then if MT.MTPF.mode == "new" then MT.MTPF:Hide() end end
		local m,e = MT:FormatMacro(this:GetText())
		MacroToolkitFauxText:SetText(m)
		MT:UpdateErrors(e)
		ScrollingEdit_OnTextChanged(this, this:GetParent())
		ScrollingEdit_OnTextChanged(MacroToolkitFauxText, MacroToolkitFauxScrollFrame)
	end
	
	local mtmscrollchild = CreateFrame("EditBox", "MacroToolkitText", mtmscroll)
	mtmscrollchild:SetMultiLine(true)
	mtmscrollchild:SetAutoFocus(false)
	mtmscrollchild:SetCountInvisibleLetters(true)
	mtmscrollchild:SetSize(mtmscroll:GetSize())
	mtmscrollchild:SetScript("OnTextChanged", ontextchanged)
		
	local function reformat(key)
		if key == "enter" then mtmscrollchild:Insert("\n") end
		local _, err = MT:FormatMacro(mtmscrollchild:GetText())
		MT:UpdateErrors(err)
	end

	local function oncursorchanged(this, x, y, w, h)
		this.cursorOffset = y
		this.cursorHeight = h
		this.handleCursorChange = true
		MacroToolkitFauxText.cursorOffset = y
		MacroToolkitFauxText.cursorHeight = h
		MacroToolkitFauxText.handleCursorChange = true
	end
	
	mtmscrollchild:SetScript("OnCursorChanged", oncursorchanged)
	mtmscrollchild:SetScript("OnEnterPressed", function(this) reformat("enter") end)
	mtmscrollchild:SetScript("OnSpacePressed", function(this) reformat("space") end)
	mtmscrollchild:SetScript("OnUpdate",
		function(this)
			ScrollingEdit_OnUpdate(this)
			ScrollingEdit_OnUpdate(MacroToolkitFauxText)
		end)
	mtmscrollchild:SetScript("OnEscapePressed", EditBox_ClearFocus)
	font = LSM:Fetch(LSM.MediaType.FONT, MT.db.profile.fonts.edfont)
	mtmscrollchild:SetFont(font, MT.db.profile.fonts.edsize)
	mtmscrollchild:SetScript("OnEditFocusGained", function() mtmscrollchild.EditFocus = mtmscrollchild end)
	mtmscrollchild:SetScript("OnEditFocusLost", function() mtmscrollchild.EditFocus = nil end)
	mtmscroll:SetScrollChild(mtmscrollchild)

	local mtmfscroll = CreateFrame("ScrollFrame", "MacroToolkitFauxScrollFrame", mttextbg, "UIPanelScrollFrameTemplate")
	mtmfscroll:SetPoint("TOPLEFT", 10, -6)
	mtmfscroll:SetPoint("BOTTOMRIGHT", -26, 4)
	
	local mtmfscrollchild = CreateFrame("EditBox", "MacroToolkitFauxText", mtmfscroll)
	mtmfscrollchild:SetMultiLine(true)
	mtmfscrollchild:SetAutoFocus(false)
	mtmfscrollchild:SetCountInvisibleLetters(true)
	mtmfscrollchild:SetSize(mtmfscroll:GetSize())
	mtmfscrollchild:SetScript("OnUpdate", nil)
	mtmfscrollchild:SetScript("OnTextChanged", nil)
	font = LSM:Fetch(LSM.MediaType.FONT, MT.db.profile.fonts.edfont)
	mtmfscrollchild:SetFont(font, MT.db.profile.fonts.edsize)
	mtmscrollchild:SetScript("OnEditFocusGained", function() mtmscrollchild:SetFocus() end)
	mtmfscroll:SetScrollChild(mtmfscrollchild)

	mterrorbg = CreateFrame("Frame", "MacroToolkitErrorBg", mtframe)
	mterrorbg:SetPoint("TOPLEFT", 328, -289)
	mterrorbg:SetPoint("BOTTOMRIGHT", -8, 40)
	mterrorbg:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16, tileSize = 16, tile = true, insets = {left = 5, right = 5, top = 5, bottom = 5}})
	mterrorbg:SetBackdropBorderColor(_G.TOOLTIP_DEFAULT_COLOR.r, _G.TOOLTIP_DEFAULT_COLOR.g, _G.TOOLTIP_DEFAULT_COLOR.b)
	mterrorbg:SetBackdropColor(_G.TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, _G.TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, _G.TOOLTIP_DEFAULT_BACKGROUND_COLOR.b)
	
	local mterrorscroll = CreateFrame("ScrollFrame", "MacroToolkitErrorScrollFrame", mterrorbg, "UIPanelScrollFrameTemplate")
	mterrorscroll:SetPoint("TOPLEFT", 10, -6)
	mterrorscroll:SetPoint("BOTTOMRIGHT", -26, 4)

	local mtescrollchild = CreateFrame("EditBox", "MacroToolkitErrors", mterrorscroll)
	mtescrollchild:SetMultiLine(true)
	mtescrollchild:SetAutoFocus(false)
	mtescrollchild:SetEnabled(false)
	mtescrollchild:SetSize(mterrorscroll:GetSize())
	mtescrollchild:SetScript("OnUpdate", function(this, elapsed) ScrollingEdit_OnUpdate(this, elapsed, this:GetParent()) end)
	mtescrollchild:SetScript("OnTextChanged",
		function(this)
			if string.len(this:GetText()) == 0 then MacroToolkitShorten:Enable()
			else MacroToolkitShorten:Disable() end
		end)
	font = LSM:Fetch(LSM.MediaType.FONT, MT.db.profile.fonts.errfont)
	mtescrollchild:SetFont(font, MT.db.profile.fonts.errsize)
	mterrorscroll:SetScrollChild(mtescrollchild)

	local mterrort = mterrorscroll:CreateFontString("MacroToolkitErrorLabel", "ARTWORK", "GameFontHighlightSmall")
	mterrort:SetFormattedText("%s:", _G.ERRORS)
	mterrort:SetPoint("BOTTOMLEFT", mterrorscroll, "TOPLEFT", -3, 5)
	
	local mttextbutton = CreateFrame("Button", nil, mtframe)
	mttextbutton:SetSize(286, 85)
	mttextbutton:SetPoint("TOPLEFT", mtmfscrollchild)
	mttextbutton:SetScript("OnClick", function() mtmscrollchild:SetFocus() end)

	local mtcancelbutton = CreateFrame("Button", "MacroToolkitCancel", mtframe, "UIPanelButtonTemplate")
	mtcancelbutton:SetText(_G.CANCEL)
	mtcancelbutton:SetSize(80, 22)
	mtcancelbutton:SetPoint("TOPLEFT", 245, -263)
	mtcancelbutton:SetScript("OnClick", 
		function()
			PlaySound("igMainMenuOptionCheckBoxOn")
			MT:MacroFrameUpdate()
			if MT.MTPF then MT.MTPF:Hide() end
			MacroToolkitText:ClearFocus()
		end)

	local mtsavebutton = CreateFrame("Button", "MacroToolkitSave", mtframe, "UIPanelButtonTemplate")
	mtsavebutton:SetText(_G.SAVE)
	mtsavebutton:SetSize(80, 22)
	mtsavebutton:SetPoint("BOTTOM", mtcancelbutton, "TOP", 0, 15)
	mtsavebutton:SetScript("OnClick", 
		function()
			PlaySound("igMainMenuOptionCheckBoxOn")
			MT:SaveMacro()
			MT:MacroFrameUpdate()
			if MT.MTPF then MT.MTPF:Hide() end
			MacroToolkitText:ClearFocus()
		end)
	
	local mcopy
	local mttab1 = CreateFrame("Button", "MacroToolkitFrameTab1", mtframe, "TabButtonTemplate")
	--mttab1:SetText(_G.GENERAL_MACROS)
	mttab1:SetText(_G.GENERAL)
	mttab1:SetID(1)
	mttab1:SetPoint("TOPLEFT", 51, -28)
	PanelTemplates_TabResize(mttab1, -15)
	MacroToolkitFrameTab1HighlightTexture:SetWidth(mttab1:GetTextWidth() + 31)
	mttab1:SetScript("OnClick",
		function(this)
			PlaySound("igMainMenuOptionCheckBoxOn")
			MT:SaveMacro()
			PanelTemplates_SetTab(mtframe, this:GetID())
			MT:SetMacros(true)
			mtmscrollchild:SetText("")
			mtmfscrollchild:SetText("")
			mtescrollchild:SetText("")
			MT:MacroFrameUpdate()
			mtscroll:SetVerticalScroll(0)
			MT:GetLastBackupDate()
			mcopy:Hide()
		end)
	
	local mttab2 = CreateFrame("Button", "MacroToolkitFrameTab2", mtframe, "TabButtonTemplate")
	mttab2:SetID(2)
	mttab2:SetPoint("LEFT", mttab1, "RIGHT", 0, 0)
	--mttab2:SetFormattedText(_G.CHARACTER_SPECIFIC_MACROS, UnitName("player"))
	mttab2:SetText(UnitName("player"))
	PanelTemplates_TabResize(mttab2, -15, nil, nil, 150)
	MacroToolkitFrameTab2HighlightTexture:SetWidth(mttab2:GetTextWidth() + 31)
	mttab2:SetScript("OnEnter",
		function(this)
			--if this:GetFontString():IsTruncated() then
				GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
				GameTooltip:SetText(format(_G.CHARACTER_SPECIFIC_MACROS, UnitName("player")), 1, 1, 1)
			--end
		end)
	mttab2:SetScript("OnLeave", GameTooltip_Hide)
	mttab2:SetScript("OnClick",
		function(this)
			PlaySound("igMainMenuOptionCheckBoxOn")
			MT:SaveMacro()
			PanelTemplates_SetTab(mtframe, this:GetID())
			MT:SetMacros(false)
			mtmscrollchild:SetText("")
			mtmfscrollchild:SetText("")
			mtescrollchild:SetText("")
			MT:MacroFrameUpdate()
			mtscroll:SetVerticalScroll(0)
			MT:GetLastBackupDate()
			mcopy:Show()
		end)
	
	local mttab3 = CreateFrame("Button", "MacroToolkitFrameTab3", mtframe, "TabButtonTemplate")
	mttab3:SetID(3)
	mttab3:SetPoint("LEFT", mttab2, "RIGHT", 0, 0)
	mttab3:SetText(L["Key bind only"])
	PanelTemplates_TabResize(mttab3, -15, nil, nil, 150)
	MacroToolkitFrameTab3HighlightTexture:SetWidth(mttab3:GetTextWidth() + 31)
	mttab3:SetScript("OnEnter",
		function(this)
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
			GameTooltip:SetText(L["Extra macros that cannot be used on action bars"], 1, 1, 1)
		end)
	mttab3:SetScript("OnLeave", GameTooltip_Hide)
	mttab3:SetScript("OnClick",
		function(this)
			PlaySound("igMainMenuOptionCheckBoxOn")
			MT:SaveMacro()
			PanelTemplates_SetTab(mtframe, this:GetID())
			MT:SetMacros(true, true)
			mtmscrollchild:SetText("")
			mtmfscrollchild:SetText("")
			mtescrollchild:SetText("")
			MT:MacroFrameUpdate()
			mtscroll:SetVerticalScroll(0)
			MT:GetLastBackupDate()
			mcopy:Hide()
		end)

	mcopy = CreateFrame("Button", "MacroToolkitCopyButton", mtframe)
	mcopy:SetSize(32, 32)
	--mcopy:SetPoint("TOPLEFT", -30, -60)
	mcopy:SetPoint("LEFT", mttab3, "RIGHT", 0, -3)
	mcopy:SetScript("OnEnter",
		function(this)
			GameTooltip:SetOwner(this, "ANCHOR_LEFT")
			GameTooltip:SetText(L["Copy an extended macro from another character"])
		end)
	mcopy:SetScript("OnLeave", GameTooltip_Hide)
	mcopy:SetScript("OnClick",
		function()
			if not MT.MTCF then MT.MTCF = MT:CreateCopyFrame() end
			MT.MTCF:Show()
			mtframe:Hide()
		end)
	mcopy:SetNormalTexture("Interface\\CHATFRAME\\UI-ChatRosterIcon-Up")
	mcopy:SetPushedTexture("Interface\\CHATFRAME\\UI-ChatRosterIcon-Down")
	mcopy:SetDisabledTexture("Interface\\CHATFRAME\\UI-ChatRosterIcon-Disabled")
	mcopy:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
	mcopy:Hide()

	local mtdel = CreateFrame("Button", "MacroToolkitDelete", mtframe, "UIPanelButtonTemplate")
	mtdel:SetText(_G.DELETE)
	mtdel:SetSize(80, 22)
	mtdel:SetFrameLevel(lvl)
	mtdel:SetPoint("BOTTOMLEFT", 4, 4)
	mtdel:SetScript("OnClick",
		function()
			PlaySound("igMainMenuOptionCheckBoxOn")
			local selectedMacro = mtframe.selectedMacro
			local numMacros
			if selectedMacro > 1000 then
				local commandName = format("CLICK MTSB%d:LeftButton", mtframe.extra)
				local k1, k2 = GetBindingKey(commandName)
				if MacroToolkitBindingFrame then MacroToolkitBindingFrame.selected = nil end
				if k1 then MT:UnbindKey(k1) end
				if k2 then MT:UnbindKey(k2) end
				SaveBindings(GetCurrentBindingSet())
				MT.db.global.extra[tostring(selectedMacro)] = nil
				numMacros = MT:CountExtra()
			else
				if mtmscrollchild.extended then
					local mindex = MT:GetCurrentIndex()
					if mindex then MT:DeleteExtended(mindex) end
				end
				DeleteMacro(selectedMacro)
				numMacros = select(PanelTemplates_GetSelectedTab(mtframe), GetNumMacros())
			end
			if selectedMacro > (numMacros + mtframe.macroBase) then selectedMacro = selectedMacro - 1 end
			if selectedMacro <= mtframe.macroBase then mtframe.selectedMacro = nil
			else mtframe.selectedMacro = selectedMacro end
			MT:MacroFrameUpdate()
			mtmscrollchild:ClearFocus()
		end)

	local mtmb = CreateFrame("Button", "MacroToolkitMacroBox", mtframe, "UIPanelButtonTemplate")
	mtmb:SetText("MacroBox")
	mtmb:SetSize(80, 22)
	mtmb:SetFrameLevel(lvl)
	mtmb:SetPoint("LEFT", mtdel, "RIGHT")
	mtmb:Hide()
	mtmb:SetScript("OnClick",
		function()
			mtframe:Hide()
			MacroBoxFrame:Show()
		end)

	local mtex = CreateFrame("Button", "MacroToolkitExtend", mtframe, "UIPanelButtonTemplate")
	mtex:SetText(L["Extend"])
	mtex:SetSize(80, 22)
	mtex:SetFrameLevel(lvl)
	mtex:SetPoint("LEFT", mtdel, "RIGHT", 80, 0)
	mtex:SetScript("OnClick", function(this) MT:ExtendClick(this) end)

	local mtshorten = CreateFrame("Button", "MacroToolkitShorten", mtframe, "UIPanelButtonTemplate")
	mtshorten:SetText(L["Shorten"])
	mtshorten:SetSize(80, 22)
	mtshorten:SetFrameLevel(lvl)
	mtshorten:SetPoint("LEFT", mtex, "RIGHT", 00, 0)
	mtshorten:SetScript("OnClick", 
		function()
			local mt, c = MT:ShortenMacro(mtmscrollchild:GetText())
			mtmscrollchild:SetText(mt)
			local m, e = MT:FormatMacro(mt)
			mtmfscrollchild:SetText(m)
			mtframe.textChanged = true
			MT:ShowShortened(c)
		end)
		
	local mtnew = CreateFrame("Button", "MacroToolkitNew", mtframe, "UIPanelButtonTemplate")
	mtnew:SetText(_G.NEW)
	mtnew:SetSize(80, 22)
	mtnew:SetFrameLevel(lvl)
	mtnew:SetPoint("BOTTOMRIGHT", -84, 4)
	mtnew:SetScript("OnClick", 
		function()
			MT:SaveMacro()
			if not MT.MTPF then MT.MTPF = MT:CreateMTPopup() end
			MT.MTPF.mode = "new"
			MT.MTPF:Show()
	end)

	local mtexit = CreateFrame("Button", "MacroToolkitExit", mtframe, "UIPanelButtonTemplate")
	mtexit:SetText(_G.EXIT)
	mtexit:SetSize(80, 22)
	mtexit:SetFrameLevel(lvl)
	mtexit:SetPoint("BOTTOMRIGHT", -5, 4)
	mtexit:SetScript("OnClick", HideParentPanel)

	MT.dwfunc =
		function() 
			if MT.db.profile.doublewide then
				if not mterrorbg:IsVisible() then
					mttextbg:SetPoint("BOTTOMRIGHT", mterrorbg, "BOTTOMRIGHT")
					mtmscroll:SetPoint("BOTTOMRIGHT", mterrorbg, "BOTTOMRIGHT", -26, 4)
					mtmfscroll:SetPoint("BOTTOMRIGHT", mterrorbg, "BOTTOMRIGHT", -26, 4)
				end
			else
				mttextbg:SetPoint("BOTTOMRIGHT", mtframe, "BOTTOMLEFT", 328, 40)
				mtmscroll:SetPoint("BOTTOMRIGHT", -26, 4)
				mtmfscroll:SetPoint("BOTTOMRIGHT", -26, 4)
			end
			mtmscrollchild:SetSize(mtmscroll:GetSize())
			mtmfscrollchild:SetSize(mtmfscroll:GetSize())
		end

	PanelTemplates_SetNumTabs(mtframe, 3)
	PanelTemplates_SetTab(mtframe, 1)
	mtframe:SetScript("OnShow", 
		function()
			if MT.db.profile.override then
				if not (MacroFrameText == MacroToolkitText) then MacroFrameText = MacroToolkitText end
			end
			MT:Skin(mtframe)
			mtframe:SetPoint("BOTTOMLEFT", MT.db.profile.x, MT.db.profile.y)
			MT:MacroFrameUpdate()
			PlaySound("igCharacterInfoOpen")
			--UpdateMicroButtons()
			MT:GetLastBackupDate()
			if #MT.db.global.custom == 0 then mtcustomflyout:Disable()
			else mtcustomflyout:Enable() end
			if MacroBox and MT.db.profile.vismacrobox then mtmb:Show() else mtmb:Hide() end
			MT.dwfunc()
		end)

	mtframe:SetScript("OnHide", 
		function()
			if MT.MTPF then MT.MTPF:Hide() end
			MT:SaveMacro()
			PlaySound("igCharacterInfoClose")
			--UpdateMicroButtons()
		end)

	local crest = CreateFrame("Frame", "MacroToolkitCrest", mtframe)
	crest:SetSize(136, 136)
	local ctl = crest:CreateTexture(nil, "ARTWORK")
	local faction = UnitFactionGroup("player")
	local cname, cx, cy
	if faction == "Alliance" then
		cname = "Acrest"
		cx = 76
		cy = -8
	else
		cname = "HordeBanner"
		cx = 86
		cy = -5
	end
	ctl:SetTexture(format("Interface\\Glues\\CREDITS\\%s1", cname))
	ctl:SetSize(68, 68)
	ctl:SetPoint("TOPLEFT")
	local ctr = crest:CreateTexture(nil, "ARTWORK")
	ctr:SetTexture(format("Interface\\Glues\\CREDITS\\%s2", cname))
	ctr:SetSize(68, 68)
	ctr:SetPoint("TOPRIGHT")
	local cbl = crest:CreateTexture(nil, "ARTWORK")
	cbl:SetTexture(format("Interface\\Glues\\CREDITS\\%s3", cname))
	cbl:SetSize(68, 68)
	cbl:SetPoint("BOTTOMLEFT")
	local cbr = crest:CreateTexture(nil, "ARTWORK")
	cbr:SetTexture(format("Interface\\Glues\\CREDITS\\%s4", cname))
	cbr:SetSize(68, 68)
	cbr:SetPoint("BOTTOMRIGHT")
	crest:SetPoint("TOPLEFT", mtscrolltop, "TOPRIGHT", cx, cy)
	crest:Hide()

	drake = CreateFrame("Frame", "MacroToolkitDrake", mtframe)
	drake:SetSize(258, 172)
	local dtl = drake:CreateTexture(nil, "ARTWORK")
	dtl:SetTexture("Interface\\Glues\\CREDITS\\drake1")
	dtl:SetSize(86, 86)
	dtl:SetPoint("TOPLEFT")
	local dtc = drake:CreateTexture(nil, "ARTWORK")
	dtc:SetTexture("Interface\\Glues\\CREDITS\\drake2")
	dtc:SetSize(86, 86)
	dtc:SetPoint("TOP")
	local dtr = drake:CreateTexture(nil, "ARTWORK")
	dtr:SetTexture("Interface\\Glues\\CREDITS\\drake3")
	dtr:SetSize(86, 86)
	dtr:SetPoint("TOPRIGHT")
	local dbl = drake:CreateTexture(nil, "ARTWORK")
	dbl:SetTexture("Interface\\Glues\\CREDITS\\drake4")
	dbl:SetSize(86, 86)
	dbl:SetPoint("BOTTOMLEFT")
	local dbc = drake:CreateTexture(nil, "ARTWORK")
	dbc:SetTexture("Interface\\Glues\\CREDITS\\drake5")
	dbc:SetSize(86, 86)
	dbc:SetPoint("BOTTOM")
	local dbr = drake:CreateTexture(nil, "ARTWORK")
	dbr:SetTexture("Interface\\Glues\\CREDITS\\drake6")
	dbr:SetSize(86, 86)
	dbr:SetPoint("BOTTOMRIGHT")
	drake:SetPoint("TOPLEFT", 342, -220 - ((mtframe:GetHeight() -424) / 2))
	drake:Hide()

	local ddvalues = {}
	for k, v in ipairs(MT.scripts) do ddvalues[k] = v[1] end
	table.sort(ddvalues, function(a,b) return a < b end)
	local mtaddscript = CreateFrame("Button", "MacroToolkitAddScript", mtframe, "UIPanelButtonTemplate")
	mtaddscript:SetText(_G.KEY_INSERT)
	mtaddscript:SetSize(80, 22)
	mtaddscript:SetPoint("TOPRIGHT", mtframe, "TOPRIGHT", -15, -80)
	mtaddscript:Disable()
	mtaddscript:SetScript("OnClick",
		function(this)
			if not MT.insertspecial then return end
			local script = MT:FindScript(ddvalues[MT.insertspecial])
			local s = format("%s%s", MT.slash, script[2])
			if script[3] == "raidtarget" then s = format("%s%s", MT.slash, format("%s %s %s", script[2], MT.markertarget or "target", MT.targetmarker or 1))
			elseif script[3] == "buff" then
				local chan = string.lower(MT.channel or "raid")
				s = format("%s%s%s", MT.slash, script[2], (chan == "raid") and "" or format(" %s", chan)) end
			local l = strlenutf8(s)
			local ls = strlenutf8(mtmscrollchild:GetText())
			if (ls + l) > 255 then
				StaticPopupDialogs["MACROTOOLKIT_TOOLONG"].text = format(L["Not enough space. Command requires %d characters (%d available)"], l, 255 - ls)
				StaticPopup_Show("MACROTOOLKIT_TOOLONG")
			else
				if ls + l + 1 < 256 then s = format("%s\n", s) end
				mtmscrollchild:SetFocus()
				mtmscrollchild:Insert(s)
				local m, e = MT:FormatMacro(mtmscrollchild:GetText())
				mtmfscrollchild:SetText(m)
			end
		end)

	local mtseltarget, mtmarkerdd, mtchan
	local mtscriptdd = AceGUI:Create("Dropdown")
	mtscriptdd.frame:SetParent(mtaddscript)
	mtscriptdd.label:SetTextColor(1, 1, 1, 1)
	mtscriptdd:SetList(ddvalues)
	mtscriptdd:SetWidth(200)
	mtscriptdd:SetLabel(format("%s:", L["Insert special"]))
	mtscriptdd:SetCallback("OnValueChanged", 
		function(info, name, key)
			MT.insertspecial = key
			if MT:FindScript(ddvalues[key])[3] == "raidtarget" then
				mtseltarget.frame:Show()
				mtmarkerdd.frame:Show()
				mtseltarget.label:SetTextColor(1, 1, 1, 1)
				mtmarkerdd.label:SetTextColor(1, 1, 1, 1)
			else
				mtseltarget.frame:Hide()
				mtmarkerdd.frame:Hide()
			end
			if MT:FindScript(ddvalues[key])[3] == "buff" then
				mtchan.frame:Show()
				mtchan.label:SetTextColor(1, 1, 1, 1)
			else mtchan.frame:Hide() end
			mtaddscript:Enable()
		end)
	mtscriptdd:SetPoint("TOPLEFT", mtscrolltop, "TOPRIGHT", 0, 0)

	local mtcon = CreateFrame("Button", "MacroToolkitConditions", mtframe, "UIPanelButtonTemplate")
	mtcon:SetSize(80, 22)
	mtcon:SetText(L["Conditions"])
	mtcon:SetPoint("BOTTOMLEFT", mtscriptdd.frame, "TOPLEFT", 0, 7)
	mtcon:SetScript("OnClick",
		function()
			if not MT.MTBF then MT.MTBF = MT:CreateBuilderFrame() end
			MT.MTBF:Show()
			mtframe:Hide()
		end)

	local mtopt = CreateFrame("Button", "MacroToolkitOptionsButton", mtframe, "UIPanelButtonTemplate")
	mtopt:SetSize(80, 22)
	mtopt:SetText(_G.MAIN_MENU)
	mtopt:SetPoint("LEFT", mtcon, "RIGHT", 14, 0)
	mtopt:SetScript("OnClick", function() if MT.MTPF then MT.MTPF:Hide() end InterfaceOptionsFrame_OpenToCategory(MT.OptionsFrame) InterfaceOptionsFrame_OpenToCategory(MT.OptionsFrame) end)

	local mtchannels = {[_G.CHAT] =_G.CHAT, [_G.PARTY] =_G.PARTY, [_G.RAID] = _G.RAID}
	mtchan = AceGUI:Create("Dropdown")
	mtchan.frame:SetParent(mtframe)
	mtchan.label:SetTextColor(1, 1, 1, 1)
	mtchan:SetList(mtchannels)
	mtchan:SetWidth(100)
	mtchan:SetLabel(format("%s:", L["Report to"]))
	mtchan:SetCallback("OnValueChanged", function(info, name, key) MT.channel = key end)
	mtchan:SetPoint("TOPLEFT", mtscriptdd.frame, "BOTTOMLEFT", 0, -7)
	mtchan.frame:Hide()
	
	mtseltarget = AceGUI:Create("EditBox")
	mtseltarget.frame:SetParent(mtframe)
	mtseltarget.label:SetTextColor(1, 1, 1, 1)
	mtseltarget:SetWidth(100)
	mtseltarget:SetLabel(format("%s:", _G.TARGET))
	mtseltarget:SetCallback("OnTextChanged", function(info, name, text) MT.markertarget = text end)
	mtseltarget:SetPoint("TOPLEFT", mtscriptdd.frame, "BOTTOMLEFT", 0, -7)
	mtseltarget.frame:Hide()
	
	local mtmarkers = {}
	for m = 1, 8 do mtmarkers[m] = format("%s0|t", _G.ICON_LIST[_G.ICON_TAG_LIST[format("rt%d", m)]]) end
	mtmarkerdd = AceGUI:Create("Dropdown")
	mtmarkerdd.frame:SetParent(mtframe)
	mtmarkerdd.label:SetTextColor(1, 1, 1, 1)
	mtmarkerdd:SetList(mtmarkers)
	mtmarkerdd:SetWidth(100)
	mtmarkerdd:SetLabel(format("%s:", L["Raid marker"]))
	mtmarkerdd:SetCallback("OnValueChanged", function(info, name, key) MT.targetmarker = key end)
	mtmarkerdd:SetPoint("LEFT", mtseltarget.frame, "RIGHT", 20, 0)
	mtmarkerdd.frame:Hide()
	
	local mtaddslot = CreateFrame("Button", "MacroToolkitAddSlot", mtframe, "UIPanelButtonTemplate")
	mtaddslot:SetText(_G.KEY_INSERT)
	mtaddslot:SetSize(80, 22)
	mtaddslot:SetPoint("BOTTOMLEFT", mtscrollbot, "BOTTOMRIGHT", 208, 7)
	mtaddslot:Disable()
	mtaddslot:SetScript("OnClick",
		function(this)
			if not MT.insertslot then return end
			local slot = tostring(MT.insertslot)
			local l = strlenutf8(slot)
			local ls = strlenutf8(mtmscrollchild:GetText())
			if ls + l > 255 then
				MT.specialchars = l
				StaticPopup_Show("MACROTOOLKIT_TOOLONG")
			else
				mtmscrollchild:SetFocus()
				mtmscrollchild:Insert(slot)
				local m, e = MT:FormatMacro(mtmscrollchild:GetText())
				mtmfscrollchild:SetText(m)
			end
		end)
		
	local mtslotdd = AceGUI:Create("Dropdown")
	mtslotdd.frame:SetParent(mtaddslot)
	mtslotdd.label:SetTextColor(1, 1, 1, 1)
	mtslotdd:SetList(MT.slots)
	mtslotdd:SetWidth(200)
	mtslotdd:SetLabel(format("%s:", L["Insert slot"]))
	mtslotdd:SetCallback("OnValueChanged", function(info, name, key) MT.insertslot = key; mtaddslot:Enable() end)
	mtslotdd:SetPoint("BOTTOMLEFT", mtscrollbot, "BOTTOMRIGHT", 0, 5)

	local mtbackup = CreateFrame("Button", "MacroToolkitBackup", mtframe, "UIPanelButtonTemplate")
	mtbackup:SetText(L["Backup"])
	mtbackup:SetSize(80, 22)
	mtbackup:SetPoint("TOPLEFT", mtsavebutton, "TOPRIGHT", 20, 0)
	mtbackup:SetScript("OnClick", function() MT:GetBackupName() end)

	local mtbl = mtbackup:CreateFontString("MacroToolkitBL", "ARTWORK", "GameFontNormalSmall")
	mtbl:SetPoint("TOPLEFT", mtbackup, "BOTTOMLEFT", 2, -12)
	mtbl:SetTextColor(0.6, 0.6, 0.6, 1)

	local mtrestore = CreateFrame("Button", "MacroToolkitRestore", mtbackup, "UIPanelButtonTemplate")
	mtrestore:SetText(L["Restore"])
	mtrestore:SetSize(80, 22)
	mtrestore:SetPoint("LEFT", mtbackup, "RIGHT", 18, 0)
	mtrestore:SetScript("OnClick", function() if not MT.MTRF then MT.MTRF = MT:CreateRestoreFrame() end; MT.MTRF:Show() end)

	local mtclear = CreateFrame("Button", "MacroToolkitClear", mtframe, "UIPanelButtonTemplate")
	mtclear:SetText(_G.CLEAR_ALL)
	mtclear:SetSize(80, 22)
	mtclear:SetPoint("TOPLEFT", mtrestore, "TOPRIGHT", 18, 0)
	mtclear:SetScript("OnClick",
		function()
			local tab = PanelTemplates_GetSelectedTab(mtframe)
			local mtype = _G[format("MacroToolkitFrameTab%d", tab)]:GetText()
			StaticPopupDialogs.MACROTOOLKIT_DELETEBACKUP.text = format("|cffeedd82%s|r\n\n|cffff0000%s|r\n\n%s", mtype, L["Delete all macros"], L["Are you sure? This operation cannot be undone."])
			StaticPopupDialogs.MACROTOOLKIT_DELETEBACKUP.OnAccept = function() MT:ClearAllMacros() end
			StaticPopup_Show("MACROTOOLKIT_DELETEBACKUP")
		end)

	local mtshare = CreateFrame("Button", "MacroToolkitShare", mtframe, "UIPanelButtonTemplate")
	mtshare:SetText(_G.SHARE_QUEST_ABBREV)
	mtshare:SetSize(80, 22)
	mtshare:SetPoint("TOPRIGHT", mtclear, "BOTTOMRIGHT", 0, -15)
	mtshare:SetScript("OnClick",
		function()
			if not mtframe.selectedMacro then return end
			local tab = PanelTemplates_GetSelectedTab(mtframe)
			local name = (tab == 3) and MT.db.global.extra[tostring(mtframe.selectedMacro)].name or GetMacroInfo(mtframe.selectedMacro)
			if not MT.SP then MT.SP = MT:CreateSharePopup() end
			MT.SP.title:SetFormattedText("|cffeedd82 %s|r\n\n%s", name, L["Share with"])
			MT.SP:Show()
		end)

	local mtbrokericon = CreateFrame("Frame", "MacroToolkitBrokerIcon", mtframe)
	mtbrokericon:SetSize(32, 16)
	MT.brokericon = mtbrokericon:CreateTexture(nil, "ARTWORK")
	MT.brokericon:SetPoint("TOPLEFT", mtbrokericon, "TOPLEFT")
	MT.brokericon:SetPoint("BOTTOMRIGHT", mtbrokericon, "BOTTOMLEFT", 16, 0)
	mtbrokericon:SetPoint("RIGHT", mtcancelbutton, "LEFT", -15, -6)
	mtbrokericon:SetScript("OnLeave", GameTooltip_Hide)
	local mtbbutton = CreateFrame("Button", "MacroToolkitBrokerButton", mtbrokericon)
	mtbbutton:SetSize(16, 16)
	mtbbutton:SetPoint("LEFT", MT.brokericon, "RIGHT")
	mtbbutton:SetScript("OnLeave", GameTooltip_Hide)
	mtbrokericon:Hide()
	
	local mterroricon = CreateFrame("Frame", "MacroToolkitErrorIcon", mtframe)
	mterroricon:SetSize(16, 16)
	local mteit = mterroricon:CreateTexture(nil, "ARTWORK")
	mteit:SetTexture("Interface\\DialogFrame\\DialogIcon-AlertNew-16")
	mteit:SetAllPoints()
	mterroricon:SetPoint("RIGHT", mtsavebutton, "LEFT", -5, 0)
	mterroricon:SetScript("OnLeave", GameTooltip_Hide)

	local mtbind = CreateFrame("Button", "MacroToolkitBind", mtframe, "UIPanelButtonTemplate")
	mtbind:SetText(_G.KEY_BINDINGS_MAC)
	mtbind:SetSize(80, 22)
	mtbind:SetFrameLevel(lvl)
	mtbind:SetPoint("LEFT", mtshorten, "RIGHT", 10, 0)
	mtbind:SetScript("OnClick", function() if not MT.MTKF then MT.MTKF = MT:CreateBindingFrame() end; MT.MTKF:Show() end)

	MT:UpdateInterfaceOptions()
	tinsert(UISpecialFrames, "MacroToolkitFrame")
	return mtframe
end

function MT:UpdateIcon(this, justicon)
	--this is proving difficult to get working properly, so disabled for the time being
	return
	
	--[[
	local index, icon = select(3, string.find(this:GetName(), "MTSB(%d+)"))
	--index = MT:GetExMacroIndex(index)
	if not index then return end
	local macro, isspell, item = this:GetAttribute("macrotext"), false, ""
	--local isdynamic = this:GetAttribute("dynamic")
	--if not justicon and not isdynamic then return end
	local mtext = {strsplit("\n", macro)}
	local showtext
	if mtext[1] then
		if strsub(mtext[1], 1, 6) == "#show " then showtext = strsub(mtext[1], 7)
		elseif strsub(mtext[1], 1, 1) == "#showtooltip " then showtext = strsub(mtext[1], 14) end
	end
	if showtext then
		showtext = strtrim(showtext)
		if showtext ~= "" then
			showtext = SecureCmdOptionParse(showtext)
			if showtext and showtext ~= "" then
				local num = tonumber(showtext)
				local sicon, iicon
				if not num then
					sicon = GetSpellTexture(showtext)
					iicon = GetItemIcon(showtext)
				end
				if not justicon then
					if num then
						local name = GetItemInfo(GetInventoryItemLink("player", num))
						if name then SetMacroItem(index, name) end
					elseif sicon then SetMacroSpell(index, showtext)
					elseif iicon then SetMacroItem(index, showtext)	end
					return
				elseif num then
					if num then return GetInventoryItemTexture("player", num)
					else return sicon or iicon end
				end
						
			end
			return nil
		end
	end
 
	for _, mline in ipairs(mtext) do
		if mline then
			local cmd = select(3, MT:ParseMacro(mline))
			if MT:IsCast(cmd) or MT:IsCastSequence(cmd) then
				local spell, target = SecureCmdOptionParse(mline)
				if MT:IsCastSequence(cmd) then
					if spell then
						local idx, it, sp = QueryCastSequence(spell)
						spell = sp or it
						if spell then if string.sub(spell, 1, 1) == "!" then spell = string.sub(spell, 2) end end
					end
				end
				if spell then
					icon = select(3, GetSpellInfo(spell))
					if icon then
						if not justicon then SetMacroSpell(index, spell, target) end
						isspell = true
						break
					elseif item == "" then
						item = spell
					end
				end
			end
		end
	end
	if not isspell then
		icon = GetItemIcon(item)
		if not justicon then SetMacroItem(index, item) end
	end
	if justicon then return icon end
	]]--
end

function MT:CreateSecureFrames()
	for b = 1, _G.MAX_ACCOUNT_MACROS + _G.MAX_CHARACTER_MACROS do
		local frame = CreateFrame("Button", format("MTSB%d", b), nil, "SecureActionButtonTemplate, SecureHandlerBaseTemplate")
		_G[format("MTSB%d", b)] = _G[format("MTSB%d", b)]
		frame:SetID(b)
		frame:SetAttribute("type", "macro")
		frame:SetAttribute("macrotext", "")
		frame:SetAttribute("dynamic", false)
		frame.MTUpdateIcon = function(this) MT:UpdateIcon(this) end
		frame:WrapScript(frame, "OnClick", "self:CallMethod('MTUpdateIcon')")
	end
	--extra macros
	for b = 1001, 1000 + _G.MAX_ACCOUNT_MACROS do
		local frame = CreateFrame("Button", format("MTSB%d", b), nil, "SecureActionButtonTemplate, SecureHandlerBaseTemplate")
		_G[format("MTSB%d", b)] = _G[format("MTSB%d", b)]
		frame:SetID(b)
		frame:SetAttribute("type", "macro")
		frame:SetAttribute("macrotext", "")
	end
end