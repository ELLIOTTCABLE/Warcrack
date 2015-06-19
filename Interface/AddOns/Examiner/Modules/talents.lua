local ex = Examiner;
local cfg;

-- Module
local mod = ex:CreateModule("Talent",TALENTS);
mod.help = "The Inspected Player's Talent Specialization";
--mod.page = CreateFrame("Frame",nil,ex);
mod:CreatePage(false,SPECIALIZATION);
mod:HasButton(true);
mod.canCache = true;
mod.details = ex:CreateDetailObject();

-- Constants
local TALENT_BUTTON_SIZE = 28;
local TALENT_BUTTON_SPACING = 7;

-- Variables
local talentGroup;

--------------------------------------------------------------------------------------------------------
--                                           Module Scripts                                           --
--------------------------------------------------------------------------------------------------------

-- OnInspect
function mod:OnInitialize()
	cfg = ex.cfg;
end

-- OnInspect
function mod:OnInspect(unit)
--	if (ex.isSelf) then
--		isInspect = nil;
--		self:HasData(true);
--		self:InitTalents();
--	end
end

-- OnInspectReady
function mod:OnInspectReady(unit)
	talentGroup = ex.isSelf and GetActiveSpecGroup() or nil;
	self:HasData(ex.canInspect);
	self:InitTalents();
end

-- OnCacheLoaded
function mod:OnCacheLoaded(entry,unit)
	self:HasData(nil);
	if (entry.talentSpec) then
		self.details:Clear();
		self.details:Add("Talents");
		self.details:Add("Specialization",entry.talentSpec or UNKNOWN);
		if (entry.talentPoints or entry.talents) then
			self.details:Add("Points",entry.talentPoints or entry.talents); -- Az: backward compatibility with old cache entries
		end
		self.details:Update();
	end
end

-- OnCache
function mod:OnCache(entry,unit)
	if (self:CanCache()) and (self.hasData) then
		entry.talentSpec = self.talentSpec;
		entry.talentPoints = self.talentPoints;
		entry.level = ex.info.level;	-- Az: What was this for again?
	end
end

-- OnClearInspect
function mod:OnClearInspect()
	self:HasData(nil);
	self.details:Clear();
	self:ClearObjects();
end

--------------------------------------------------------------------------------------------------------
--                                                Menu                                                --
--------------------------------------------------------------------------------------------------------

-- Menu Init Items
--function mod.MenuInit(parent,list)
--	local group = GetActiveTalentGroup(true);
--	local _, _, _, _, p1 = GetTalentTabInfo(1,isInspect,nil,2);
--	local _, _, _, _, p2 = GetTalentTabInfo(2,isInspect,nil,2);
--	local _, _, _, _, p3 = GetTalentTabInfo(3,isInspect,nil,2);
--	local noSecondary = (p1 + p2 + p3 == 0);
--	list[1].text = "Shown Spec"; list[1].header = 1;
--	list[2].text = "Active"; list[2].value = nil; list[2].checked = (cfg.shownSpec == nil);
--	list[3].text = (group == 1 and "|cff80ff80" or "").."Primary"; list[3].value = 1; list[3].checked = (cfg.shownSpec == 1);
--	list[4].text = (group == 2 and "|cff80ff80" or noSecondary and "|cffff8080" or "").."Secondary"; list[4].value = 2; list[4].checked = (cfg.shownSpec == 2);
--end

-- Menu Select Item
--function mod.MenuSelect(parent,entry)
--	cfg.shownSpec = entry.value;
--	if (mod:IsShown()) then
--		mod:UpdateTalents();
--	end
--end

--------------------------------------------------------------------------------------------------------
--                                      Talent Button Functions                                       --
--------------------------------------------------------------------------------------------------------

-- Talent OnEnter
local function TalentButton_OnEnter(self,motion)
	local classDisplayName, class, classID = UnitClass(INSPECTED_UNIT);
	GameTooltip:SetOwner(self,"ANCHOR_RIGHT");
	GameTooltip:SetTalent(self.id,true,talentGroup,ex.unit,classID);
end

-- Create Talent Row
function CreateTalentRow(parent,tier)
	local row = CreateFrame("Frame",nil,parent);
	row:SetWidth(parent:GetWidth() - 32);
	row:SetHeight(TALENT_BUTTON_SIZE + TALENT_BUTTON_SPACING);
	row:SetPoint("TOPLEFT",16,-tier * (TALENT_BUTTON_SIZE + TALENT_BUTTON_SPACING));

--	local backdrop = { bgFile = "Interface\\Buttons\\WHITE8X8", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 4, right = 4, top = 4, bottom = 4 } };
--	row:SetBackdrop(backdrop);
--	row:SetBackdropColor(0,0,0.8);

	row.levelText = row:CreateFontString(nil,"OVERLAY","GameFontNormal");
	row.levelText:SetPoint("LEFT",16,0);

	for i = 1, NUM_TALENT_COLUMNS do
		local btn = CreateFrame("Button",nil,row);
		btn:SetWidth(TALENT_BUTTON_SIZE);
		btn:SetHeight(TALENT_BUTTON_SIZE);
		btn:SetPoint("LEFT",i * (TALENT_BUTTON_SIZE + TALENT_BUTTON_SPACING) + 32,0);
		btn:SetScript("OnEnter",TalentButton_OnEnter);
		btn:SetScript("OnLeave",ex.HideGTT);

		btn.icon = btn:CreateTexture(nil,"BORDER");
		btn.icon:SetPoint("TOPLEFT",1,-1);
		btn.icon:SetPoint("BOTTOMRIGHT",-1,1);
		btn.icon:SetTexCoord(0.07,0.93,0.07,0.93);

		btn.id = (tier - 1) * 3 + i;

		row["talent"..i] = btn;
	end

	parent["row"..tier] = row;
end

--------------------------------------------------------------------------------------------------------
--                                           Widget Creation                                          --
--------------------------------------------------------------------------------------------------------

-- OnShow
local function OnShow(self)
--	mod:UpdateTalents();
	ex.model:Hide();
	ex.details:Hide();
	ex.guild:Hide();
	ex:ShowBackground(true);
end

-- OnHide
local function OnHide(self)
	ex.model:Show();
	ex.details:Show();
	ex.guild:Show();
	ex:ShowBackground();
	ex:SetBackgroundTexture();
end

-- Talent Page
--mod.page:SetWidth(320);
--mod.page:SetHeight(354);
--mod.page:SetPoint("BOTTOM",-11,10);
--mod.page:Hide();
--mod.page:SetScript("OnShow",OnShow);
--mod.page:SetScript("OnHide",OnHide);
--local backdrop = { bgFile = "Interface\\Buttons\\WHITE8X8", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 4, right = 4, top = 4, bottom = 4 } };
--mod.page:SetBackdrop(backdrop);

-- Create Tier Frames
for i = 1, MAX_TALENT_TIERS do
	CreateTalentRow(mod.page,i);
end

--------------------------------------------------------------------------------------------------------
--                                             Functions                                              --
--------------------------------------------------------------------------------------------------------

-- Initialize Talents
function mod:InitTalents()
	local _, class, classID = UnitClass(ex.unit);	-- Az: classID not used anymore, remove?
	-- Background
--	local background = "WarriorProtection";
--	ex:SetBackgroundTexture("Interface\\TalentFrame\\"..background.."-");
	-- Update Widgets
	for tier = 1, MAX_TALENT_TIERS do
		-- Set Levels (these are different for deathknights)
		local talentLevel = CLASS_TALENT_LEVELS[class] or CLASS_TALENT_LEVELS["DEFAULT"];
		local group = mod.page["row"..tier];
		group.levelText:SetText(talentLevel[tier]);
		group:Show();
		-- Set Talents
		for column = 1, NUM_TALENT_COLUMNS do
			local talentID, name, iconTexture, selected, available = GetTalentInfo(tier,column,talentGroup,true,ex.unit);	-- always inspect mode
			local talent = group["talent"..column];
			talent.icon:SetTexture(iconTexture);
			talent.icon:SetDesaturated(not selected);
		end
	end
	-- Spec Name
	local specID = GetInspectSpecialization(ex.unit);
	local _, specName = GetSpecializationInfoByID(specID);
	self.talentSpec = specName or NO.." "..SPECIALIZATION;
	mod.page.header:SetText(self.talentSpec);
	-- Details
	self.details:Clear();
	self.details:Add("Talents");
	self.details:Add("Specialization",self.talentSpec or UNKNOWN);
	self.details:Update();
end

-- Clear Objects
function mod:ClearObjects()
	self.page.header:SetText("");
	for tier = 1, MAX_TALENT_TIERS do
		local group = self.page["row"..tier];
		group:Hide();
	end
end