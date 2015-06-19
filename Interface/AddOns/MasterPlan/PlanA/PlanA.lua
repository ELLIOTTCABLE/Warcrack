local addonName, T = ...
local E, api, cdata = T.Evie, {}

local function gett(t, k, ...)
	if not k then
		return t
	elseif type(t[k]) ~= "table" then
		t[k] = {}
	end
	return gett(t[k], ...)
end

local CheckCacheWarning do
	local ag = GarrisonLandingPageMinimapButton:CreateAnimationGroup()
	ag:SetLooping("REPEAT")
	local tex = GarrisonLandingPageMinimapButton:CreateTexture(nil, "ARTWORK")
	tex:SetPoint("CENTER")
	tex:SetAtlas("GarrLanding-CircleGlow", true)
	tex:SetBlendMode("ADD")
	tex:SetAlpha(0)
	tex:SetVertexColor(1, 0, 0)
	GarrisonLandingPageMinimapButton.MPWarningTexture = tex
	local SCALE_MAX, SCALE_MIN = 1.1, 0.9
	local a = ag:CreateAnimation("Scale")
	a:SetToScale(SCALE_MAX, SCALE_MAX)
	a:SetStartDelay(5)
	a:SetDuration(1)
	a:SetOrder(1)
	a:SetChildKey("MPWarningTexture")
	a = ag:CreateAnimation("Scale")
	a:SetToScale(SCALE_MIN, SCALE_MIN)
	a:SetOrder(2)
	a:SetDuration(1)
	a:SetChildKey("MPWarningTexture")
	a = ag:CreateAnimation("Alpha")
	a:SetDuration(1)
	a:SetFromAlpha(0)
	a:SetToAlpha(1)
	a:SetStartDelay(5)
	a:SetOrder(1)
	a:SetChildKey("MPWarningTexture")
	a = ag:CreateAnimation("Alpha")
	a:SetDuration(1)
	a:SetFromAlpha(1)
	a:SetToAlpha(0)
	a:SetOrder(2)
	a:SetChildKey("MPWarningTexture")
	ag:SetScript("OnStop", function()
		tex:SetAlpha(0)
	end)
	local WARN_TIME, CAP_TIME, mute = 256000, 300000, false
	GarrisonLandingPageMinimapButton:HookScript("OnClick", function()
		mute = true
		ag:Stop()
	end)
	function CheckCacheWarning()
		local lct = C_Garrison.IsOnGarrisonMap() and cdata and cdata.lastCacheTime
		local td = lct and (time()-lct) or 0
		if td >= WARN_TIME then
			tex:SetVertexColor(1, td >= CAP_TIME and 0 or 0.35, 0)
			if not (mute or ag:IsPlaying()) then
				ag:Play()
			end
		else
			ag:Stop()
			mute = false
		end
	end
end

function E:ADDON_LOADED(addon)
	if addon ~= addonName then return end
	
	cdata = gett(_G, "MasterPlanAG", GetRealmName(), UnitName("player"))
	setmetatable(api, {__index={data=cdata}})
	CheckCacheWarning()

	return "remove"
end
function E:SHOW_LOOT_TOAST(rt, rl, _3, _4, _5, _6, source)
	if rt == "currency" and source == 10 and rl:match("currency:824") then
		cdata.lastCacheTime = time()
		CheckCacheWarning()
	end
end
E.ZONE_CHANGED = CheckCacheWarning

MasterPlanA = api