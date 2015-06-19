local _, T = ...
if T.Mark ~= 50 then return end
local G, L, EV = T.Garrison, T.L, T.Evie

local summaryTab = CreateFrame("Frame", nil, GarrisonMissionFrame, "GarrisonMissionBaseFrameTemplate") do
	summaryTab:Hide()
	summaryTab:SetSize(580, 565)
	summaryTab:SetPoint("TOPRIGHT", -35, -64)
	local t = summaryTab:CreateTexture(nil, "BORDER", nil, 3)
	t:SetAtlas("GarrMission_FollowerPageHeaderBG")
	t:SetPoint("TOPLEFT", 0, -5)
	t:SetPoint("BOTTOMRIGHT", summaryTab, "TOPRIGHT", 0, -58)
	t = summaryTab:CreateFontString(nil, "ARTWORK", "GameFontHighlightHuge")
	t:SetPoint("TOPLEFT", 16, -21)
	t:SetText(L"Follower Summary")
	summaryTab.NumFollowers = GarrisonMissionFrame.FollowerTab.NumFollowers
	local function syncState()
		summaryTab.accessButton:SetChecked(summaryTab:IsShown())
	end
	summaryTab:SetScript("OnShow", function(self)
		self.NumFollowers:SetParent(self)
		GarrisonMissionFrame.FollowerTab:Hide()
		GarrisonMissionFrame.selectedFollower = nil
		GarrisonFollowerList_Update(GarrisonMissionFrame)
		self.matrix:Sync()
		self.affin:Sync()
		self.stats:Sync()
		C_Timer.After(0, syncState)
	end)
	GarrisonMissionFrame.FollowerTab:HookScript("OnShow", function(self)
		self.NumFollowers:SetParent(self)
		if summaryTab:IsShown() then
			summaryTab:Hide()
			C_Timer.After(0, syncState)
		end
	end)
	GarrisonMissionFrame.SummaryTab = summaryTab
end
local matrix = CreateFrame("Frame", nil, summaryTab) do
	local rowHeaders, columnHeaders, grid = {}, {}, {}
	matrix:SetSize(350, 418)
	matrix:SetPoint("TOPLEFT", 16, -100)
	matrix:SetBackdrop({edgeFile="Interface/Tooltips/UI-Tooltip-Border", bgFile="Interface/DialogFrame/UI-DialogBox-Background-Dark", tile=true, edgeSize=16, tileSize=16, insets={left=3,right=3,bottom=3,top=3}})
	matrix:SetBackdropBorderColor(1, 0.75, 0.25)
	local title = matrix:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("BOTTOM", matrix, "TOP", 0, 3)
	title:SetText(L"Counter and Trait Combinations")

	local function MB_Animate(self, elapsed)
		local et, s, g = (self.elapsed or 0) + elapsed, self.start, self.goal
		if et >= 0.35 then
			self:SetScript("OnUpdate", nil)
			self.bg:SetSize(self.goal, self.goal)
			self.goal, self.elapsed = nil
			return
		end
		self.elapsed = et
		local ps = s + (g-s)*sin(257*et)
		self.bg:SetSize(ps, ps)
		self.text:SetAlpha((ps-14)/16)
	end
	local function MB_OnHide(self)
		self:SetScript("OnUpdate", nil)
		self:SetScript("OnHide", nil)
		self.goal, self.elapsed = nil
		self.bg:SetSize(14, 14)
		self.text:SetAlpha(0)
		if GameTooltip:IsOwned(self) then
			GameTooltip:Hide()
		end
	end
	local function MB_OnEnter(self, _, skipTooltip)
		local id = self:GetID()
		local c = id % 10
		local r = 1 + (id - c) / 10
		local rid, cid = rowHeaders[r].id, columnHeaders[c].id
		if self.hasFollowers or rid ~= cid then
			self:SetScript("OnHide", MB_OnHide)
			self.start, self.goal, self.elapsed = self.bg:GetWidth(), 30, 0
			self:SetScript("OnUpdate", MB_Animate)
			self:SetScript("OnHide", MB_OnHide)
			if skipTooltip ~= "skip" then
				GameTooltip:SetOwner(self, "ANCHOR_NONE")
				GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMRIGHT", 3, -3)
				if rowHeaders[r].isTrait then
					G.SetCounterTraitTip(GameTooltip, cid, rid)
				else
					G.SetCounterComboTip(GameTooltip, rid, cid)
				end
				GameTooltip:Show()
			end
		end
	end
	local function MB_OnLeave(self)
		self.start, self.goal, self.elapsed = self.bg:GetWidth(), 14, 0
		self:SetScript("OnUpdate", MB_Animate)
		self:SetScript("OnHide", MB_OnHide)
		if GameTooltip:IsOwned(self) then
			GameTooltip:Hide()
		end
	end
	local function MB_OnClick(self)
		local id, p = self:GetID(), (IsAltKeyDown() or not self.hasFollowers) and "+" or ""
		local c = id % 10
		local r = 1 + (id - c) / 10
		local q = (rowHeaders[r].isTrait and "" or p) .. rowHeaders[r].name .. ";" .. p .. columnHeaders[c].name
		local sb = GarrisonMissionFrameFollowers.SearchBox:IsVisible() and GarrisonMissionFrameFollowers.SearchBox or
		           GarrisonLandingPage.FollowerList.SearchBox:IsVisible() and GarrisonLandingPage.FollowerList.SearchBox
		sb:SetText(q)
		sb.clearText = q
	end
	local eb = CreateFrame("Button", nil, matrix) do
		eb:SetPoint("TOPLEFT", 5, -5)
		eb:SetSize(32, 32)
		eb:RegisterForClicks("RightButtonUp")
		eb:SetScript("OnClick", function(self)
			local f = self.mode and MB_OnLeave or MB_OnEnter
			self.mode = not self.mode
			for k,v in pairs(grid) do
				f(v, nil, "skip")
			end
		end)
		eb:SetScript("OnLeave", function(self)
			if self.mode then
				self:Click()
			end
		end)
	end
	local traits = {79, 256}
	for k=1,9+#traits do
		local name, ico, id, isTrait
		if k > 9 then
			id, isTrait = traits[k-9], true
			name, ico = C_Garrison.GetFollowerAbilityName(traits[k-9]), C_Garrison.GetFollowerAbilityIcon(traits[k-9])
		else
			id, name, ico = G.GetMechanicInfo(k > 4 and k+1 or k)
		end
		for i=1,k > 9 and 1 or 2 do
			local b = T.CreateMechanicButton(matrix)
			b:SetSize(32, 32)
			b:SetPoint("TOPLEFT", i > 1 and 34*k+5 or 5, i == 1 and -34*k-5 or -5)
			b.Icon:SetTexture(ico)
			b.id, b.name, b.isTrait = id, name, isTrait;
			(i == 1 and rowHeaders or columnHeaders)[k] = b
		end
		for j=1,9 do
			local b = CreateFrame("Button", nil, matrix, nil, k*10+j-10)
			b:SetSize(32, 32)
			b:SetPoint("TOPLEFT", 34*j+5, -34*k-5)
			b:SetNormalTexture("Interface\\CharacterFrame\\TempPortraitAlphaMaskSmall")
			b:SetNormalFontObject(GameFontNormalLargeOutline)
			b:SetText((k*10+j-10) % 24 + 1)
			b:SetScript("OnEnter", MB_OnEnter)
			b:SetScript("OnLeave", MB_OnLeave)
			b:SetScript("OnClick", MB_OnClick)
			local t = b:GetNormalTexture()
			t:SetDrawLayer("ARTWORK")
			t:ClearAllPoints()
			t:SetPoint("CENTER")
			t:SetSize(14, 14)
			t:SetVertexColor(0.15, 0.85, 0.15, 0.85)
			t, b.bg = b:GetFontString(), t
			t:SetTextColor(1,1,1)
			t:SetAlpha(0)
			b.text = t
			grid[b:GetID()] = b
		end
	end
	function matrix:Sync()
		local cti, di, tri, fi = G.GetCounterInfo(), G.GetDoubleCounters(), G.GetFollowerTraits(), G.GetFollowerInfo()
		for i=1,#rowHeaders do
			local r,c = rowHeaders[i], columnHeaders[i]
			local rid, rt = r.id, r.isTrait
			local ct = G.countFreeFollowers(rt and tri[rid] or cti[rid], fi) or 0
			ct = ct > 0 and ct or ""
			r.Count:SetText(ct)
			if c then
				c.Count:SetText(ct)
			end
			for j=1,#columnHeaders do
				local cid, c1, c2 = columnHeaders[j].id, grid[i*10+j-10], grid[j*10+i-10]
				local ca, ci, cr, br, bg, bb, ba, bt = 0, 0, 0
				if rt then
					local ct = tri[rid]
					for i=1,ct and #ct or 0 do
						local f = fi[ct[i]]
						if f then
							local found = false
							for k,v in pairs(f.counters) do
								found = found or v == cid
							end
							if not found then
								local st = T.SpecCounters[f.classSpec]
								for i=1,st and #st or 0 do
									if st[i] == cid then
										cr = cr + 1
									end
								end
							elseif f.status == GARRISON_FOLLOWER_INACTIVE then
								ci = ci + 1
							else
								ca = ca + 1
							end
						end
					end
				else
					local dkey = rid < cid and (rid * 100 + cid) or (cid * 100 + rid)
					local dk = di[dkey]
					for i=1,dk and #dk or 0 do
						local f = fi[dk[i]]
						if f.status == GARRISON_FOLLOWER_INACTIVE then
							ci = ci + 1
						else
							ca = ca + 1
						end
					end
					cr = di[-dkey] and #di[-dkey] or 0
				end
				if ca == ci and ci == 0 then
					br, bb, bg, ba, bt = 0.25,0.25,0.25, (rid == cid or cr == 0) and 0.20 or 1, cr > 0 and cr or ""
				elseif ca > 1 then
					br, bg, bb, ba, bt = 0.75, rt and 0.85 or 0.25, 0, 1, ca
				elseif ca > 0 and ci > 0 then
					br, bg, bb, ba, bt = 0, 0.4, 0, 1, ca
				elseif ca > 0 then
					br, bg, bb, ba, bt = 0, 0.95, 0, 1, ca
				elseif ci > 0 then
					br, bg, bb, ba, bt = 0.8, 0.78, 0.56, 1, ci
				end
				for i=1,rt and 1 or 2 do
					c1.bg:SetVertexColor(br, bg, bb, ba)
					c1:SetText(bt)
					c1.hasFollowers = (ca + ci) > 0
					c1 = c2
				end
			end
		end
	end
	summaryTab.matrix = matrix
end
local affin = CreateFrame("Frame", nil, summaryTab) do
	local rows = {}
	affin:SetSize(192, #T.UsableAffinities*26+9)
	affin:SetPoint("TOPLEFT", summaryTab.matrix, "TOPRIGHT", 6, 0)
	affin:SetBackdrop({edgeFile="Interface/Tooltips/UI-Tooltip-Border", bgFile="Interface/DialogFrame/UI-DialogBox-Background-Dark", tile=true, edgeSize=16, tileSize=16, insets={left=3,right=3,bottom=3,top=3}})
	affin:SetBackdropBorderColor(1, 0.75, 0.25)
	local title = affin:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("BOTTOM", affin, "TOP", 0, 3)
	title:SetText(L"Races")
	local mechanic_OnEnter
	local function race_OnEnter(self)
		mechanic_OnEnter(self)
		GameTooltip:ClearAllPoints()
		GameTooltip:SetPoint("TOPRIGHT", self, "TOPLEFT", -2, 2)
	end
	for i=1,#T.UsableAffinities do
		local b, aid = T.CreateMechanicButton(affin), T.UsableAffinities[i]
		b:SetSize(24, 24)
		b:SetPoint("TOPLEFT", 5, 21-i*26)
		local t = b:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
		t:ClearAllPoints()
		t:SetPoint("LEFT", 32, 0)
		b.Desc, rows[i], mechanic_OnEnter = t, b, b:GetScript("OnEnter")
		b:SetScript("OnEnter", race_OnEnter)
		b.Icon:SetTexture(C_Garrison.GetFollowerAbilityIcon(aid))
		b.id, b.isTrait, b.name = aid, true, C_Garrison.GetFollowerAbilityName(aid)
	end
	local function rowCmp(a, b)
		local ac, bc = a.s1, b.s1
		if ac == bc then
			ac, bc = a.s2, b.s2
		end
		return ac > bc
	end
	function affin:Sync()
		local ti, fi = G.GetFollowerTraits(), G.GetFollowerInfo()
		for i=1,#rows do
			local b = rows[i]
			local at = ti[b.id]
			local aft = at and at.affine ~= true and at.affine
			local cu, ca, ct = G.countFreeFollowers(at, fi), G.countFreeFollowers(aft, fi) or 0, aft and #aft or 0
			b.Count:SetText(cu > 0 and cu or "")
			local ot = "|cff808080" .. NONE
			if ca > 0 and ct > ca then
				ot = L("%d active"):format(ca) .. "; |cffccc78f" .. L("%d total"):format(ct)
			elseif ca > 0 then
				ot = L("%d active"):format(ca)
			elseif ct > 0 then
				ot = "|cffccc78f" .. L("%d total"):format(ct)
			end
			b.Desc:SetText(ot)
			b.s1, b.s2 = ca, ct-ca
		end
		table.sort(rows, rowCmp)
		for i=1,#rows do
			rows[i]:SetPoint("TOPLEFT", 5, 21-i*26)
		end
	end
	summaryTab.affin = affin
end
local stats = CreateFrame("Frame", nil, summaryTab) do
	local rows = {}
	stats:SetSize(192, 91)
	stats:SetPoint("BOTTOMLEFT", summaryTab.matrix, "BOTTOMRIGHT", 6, 0)
	stats:SetBackdrop({edgeFile="Interface/Tooltips/UI-Tooltip-Border", bgFile="Interface/DialogFrame/UI-DialogBox-Background-Dark", tile=true, edgeSize=16, tileSize=16, insets={left=3,right=3,bottom=3,top=3}})
	stats:SetBackdropBorderColor(1, 0.75, 0.25)
	local title = stats:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("BOTTOM", stats, "TOP", 0, 3)
	title:SetText(L"Statistics")
	for i=1,3 do
		local b = CreateFrame("Frame", nil, stats)
		b:SetSize(180, 24)
		b:SetPoint("TOPLEFT", 5, 18-i*26)
		local t = b:CreateTexture()
		t:SetPoint("LEFT")
		t:SetSize(24, 24)
		t, b.Icon = b:CreateFontString(nil, "OVERLAY", "GameFontHighlight"), t
		t:SetJustifyH("LEFT")
		t:SetPoint("TOPLEFT", 30, 0)
		t:SetPoint("BOTTOMRIGHT", -6, 0)
		rows[i], b.Text = b, t
	end
	rows[1].Icon:SetTexture("Interface\\Icons\\INV_Misc_GroupLooking")
	rows[2].Icon:SetTexture("Interface\\Icons\\INV_Misc_Coin_01")
	rows[3].Icon:SetTexture("Interface\\Icons\\INV_Mushroom_11")
	function stats:Sync()
		rows[1].Text:SetFormattedText(L"%d followers recruited", C_Garrison.GetNumFollowers())
		rows[2].Text:SetText(BreakUpLargeNumbers(floor(T.config.goldCollected/1e4)))
		local mt = "???"
		if T.config.moV > 1 then
			mt = math.floor(1000 + 250*(T.config.moC - T.config.moE)/T.config.moV^0.5 + 0.5)
			local qi = math.min(math.floor(mt/250-2.5), 5)
			mt = (qi > 0 and ITEM_QUALITY_COLORS[qi].hex or "") .. BreakUpLargeNumbers(mt)
		end
		rows[3].Text:SetText(mt)
	end
	summaryTab.stats = stats
end
local accessButton = CreateFrame("CheckButton", nil, GarrisonMissionFrame) do
	accessButton:SetSize(24, 24)
	accessButton:SetPushedTexture("Interface/Buttons/UI-QuickSlot-Depress")
	accessButton:SetHighlightTexture("Interface/Buttons/ButtonHilight-Square")
	accessButton:SetCheckedTexture("Interface/Buttons/CheckButtonHilight")
	accessButton:SetChecked(true)
	accessButton:Hide()
	local ico = accessButton:CreateTexture(nil, "ARTWORK")
	ico:SetAllPoints()
	ico:SetTexture("Interface/Icons/Achievement_Boss_CThun")
	accessButton:SetPoint("LEFT", GarrisonMissionFrameFollowers.SearchBox, "RIGHT", 15, 2)
	GarrisonMissionFrameTab2:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	GarrisonMissionFrameTab2:SetScript("OnClick", function(self, button)
		GarrisonMissionFrameTab_OnClick(self)
		if button == "RightButton" then
			summaryTab:Show()
		end
	end)
	hooksecurefunc("GarrisonFollowerPage_ShowFollower", function(self)
		if GarrisonMissionFrame.FollowerTab == self and self.followerID and summaryTab:IsShown() then
			local mf = T.GetMouseFocus()
			if mf and mf.id and mf.info and mf.GetButtonState and mf:GetButtonState() == "PUSHED" then
				GarrisonMissionFrame.FollowerTab:Show()
			end
		end
	end)
	function EV:MP_SHOW_MISSION_TAB(tab)
		local st = accessButton:GetChecked()
		accessButton:SetShown(tab == 2)
		if tab ~= 2 then
			summaryTab:Hide()
		elseif st then
			summaryTab:Show()
		end
	end
	accessButton:SetScript("OnClick", function(self)
		local nv = self:GetChecked()
		GarrisonMissionFrame[nv and "SummaryTab" or "FollowerTab"]:Show()
		self:GetScript("OnLeave")(self)
		if not nv then
			GarrisonMissionFrame.selectedFollower = GarrisonMissionFrame.FollowerTab.followerID
			GarrisonFollowerList_Update(GarrisonMissionFrame)
		end
	end)
	accessButton:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText(L"Follower Summary")
		GameTooltip:Show()
	end)
	accessButton:SetScript("OnLeave", function(self)
		if GameTooltip:IsOwned(self) then
			GameTooltip:Hide()
		end
	end)
	function EV:MP_FORCE_FOLLOWER_TAB(fid)
		accessButton:SetChecked(false)
		GarrisonMissionFrame.FollowerTab:Show()
		if fid and fid ~= GarrisonMissionFrame.selectedFollower then
			GarrisonMissionFrame.selectedFollower = fid
			GarrisonFollowerList_Update(GarrisonMissionFrame)
		end
	end
	summaryTab.accessButton = accessButton
end

GarrisonMissionFrame.SummaryTab:HookScript("OnShow", function(self)
	local mechanicsFrame = T.mechanicsFrame
	mechanicsFrame:SetParent(self)
	mechanicsFrame:ClearAllPoints()
	mechanicsFrame:SetPoint("LEFT", GarrisonMissionFrame.FollowerTab.NumFollowers, "RIGHT", 11, 0)
	mechanicsFrame:Show()
end)