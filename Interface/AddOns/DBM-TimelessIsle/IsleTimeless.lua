local mod	= DBM:NewMod("IsleTimeless", "DBM-TimelessIsle")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 27 $"):sub(12, -3))
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA"
)

--TODO, add a cauterize timer.
--TODO, add move warning for dread ship fire.

--Serpants
local warnFlameBreath			= mod:NewSpellAnnounce(147817, 3)
local warnFireBlossom			= mod:NewTargetAnnounce(147818, 3)
local warnLightningBreath		= mod:NewSpellAnnounce(147826, 3)
local warnStormBlossom			= mod:NewTargetAnnounce(147828, 3)
--Weaker Ordon
local warnCracklingBlow			= mod:NewSpellAnnounce(147674, 3, nil, false)--Spammy if filter is disabled, so optional warning dependant on number of mobs player is accustomed to pulling.
local warnFallingFlames			= mod:NewSpellAnnounce(147723, 3)
local warnBlazingBlow			= mod:NewSpellAnnounce(148003, 3, nil, false)--Spammy if filter is disabled, so optional warning dependant on number of mobs player is accustomed to pulling.
local warnBlazingCleave			= mod:NewCastAnnounce(147702, 3)
--Tougher Ordon
local warnConjurKiln			= mod:NewSpellAnnounce(148004, 3)
local warnConjurGolem			= mod:NewSpellAnnounce(148001, 3)
local warnFireStorm				= mod:NewSpellAnnounce(147998, 3)
local warnCauterize				= mod:NewSpellAnnounce(147997, 4)
--Rock Moss/Spelurk
local warnRenewingMists			= mod:NewSpellAnnounce(147769, 4)

--Serpants
local specWarnFireBlossom		= mod:NewSpecialWarningYou(147818)
local specWarnStormBlossom		= mod:NewSpecialWarningYou(147828)
--Spawns
local specWarnShip				= mod:NewSpecialWarning("specWarnShip", false)
local specWarnGolg				= mod:NewSpecialWarning("specWarnGolg")
--Frogs
local specWarnFrogToxin			= mod:NewSpecialWarningStack(147655, nil, 7)
--Weaker Ordon
local specWarnCracklingBlow		= mod:NewSpecialWarningMove(147674, false)
local specWarnFallingFlames		= mod:NewSpecialWarningSpell(147723, "-Tank", nil, nil, 2)
local specWarnBlazingCleave		= mod:NewSpecialWarningMove(147702, "-Tank")--Tanks stand in it on purpose so no need to warn them
--Tougher Ordon
local specWarnBlazingBlow		= mod:NewSpecialWarningMove(148003, false)
local specWarnConjurKiln		= mod:NewSpecialWarningSwitch(148004)
local specWarnConjurGolem		= mod:NewSpecialWarningSpell(148001, false)--Strat and class dependant. a tank doesn't care about these, but squishy mage may need to kite
local specWarnFireStorm			= mod:NewSpecialWarningSpell(147998, nil, nil, nil, 2)
local specWarnCauterize			= mod:NewSpecialWarningInterrupt(147997)
--Rock Moss/Spelurk
local specWarnRenewingMists		= mod:NewSpecialWarningInterrupt(147769)

mod:AddBoolOption("StrictFilter", true)--Only warn for current target/focus and nothing else. Otherwise you run risk of excessive spam when fighting near other groups fighting same mobs.
mod:RemoveOption("HealthFrame")

local GetCurrentMapAreaID, SetMapToCurrentZone = GetCurrentMapAreaID, SetMapToCurrentZone
local UnitAffectingCombat, UnitGUID = UnitAffectingCombat, UnitGUID
local currentZoneID = -1

local function zoneCode()
	if WorldMapFrame:IsVisible() then--World Map is open
		local Z = GetCurrentMapAreaID()
		SetMapToCurrentZone()
		currentZoneID = GetCurrentMapAreaID()
		if currentZone ~= Z then
			SetMapByID(Z)--Restore old map settings if they differed to what they were prior to forcing mapchange and user has map open.
		end
	else--Map is not open, no reason to go extra miles, just force map to right zone and get right info.
		SetMapToCurrentZone()
		currentZoneID = GetCurrentMapAreaID()--Get right info after we set map to right place.
	end
	if currentZoneID == 951 then
		mod:RegisterShortTermEvents(
			"CHAT_MSG_MONSTER_YELL",
			"SPELL_CAST_START 148003 148004 147997 148001 147998 147828 147826 147674 147723 147769 147702 147818 147817",
			"SPELL_AURA_APPLIED_DOSE 147655"
		)
	else
		mod:UnregisterShortTermEvents()
	end
end
zoneCode()--Make sure it runs on mod load

function mod:FireBlossomTarget(targetname, uId)
	if not targetname then return end
	warnFireBlossom:Show(targetname)
	if targetname == UnitName("player") then
		specWarnFireBlossom:Show()
	end
end

function mod:StormBlossomTarget(targetname, uId)
	if not targetname then return end
	warnStormBlossom:Show(targetname)
	if targetname == UnitName("player") then
		specWarnStormBlossom:Show()
	end
end

function mod:ZONE_CHANGED_NEW_AREA()
	zoneCode()
end

function mod:CHAT_MSG_MONSTER_YELL(msg, npc)
	if msg == L.shipSummon or msg:find(L.shipSummon) then
		specWarnShip:Show()
	elseif msg == L.golgSpawn or msg:find(L.golgSpawn) then
		specWarnGolg:Show()
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	local spellId = args.spellId
	if spellId == 147655 and args:IsPlayer() then
		specWarnFrogToxin:Show(args.amount or 1)
	end
end

function mod:SPELL_CAST_START(args)
	local sourceGUID = args.sourceGUID
	if self.Options.StrictFilter and (sourceGUID ~= UnitGUID("target") and sourceGUID ~= UnitGUID("focus")) then return end
	if not UnitAffectingCombat("player") then return end--secondary filter, if not using strict filter at least try a basic "is player in combat" filter.
	local spellId = args.spellId
	if spellId == 147997 then
		warnCauterize:Show()
		specWarnCauterize:Show(args.sourceName)
	elseif spellId == 148004 then
		warnConjurKiln:Show()
		specWarnConjurKiln:Show()
	elseif spellId == 147674 then
		warnCracklingBlow:Show()
		specWarnCracklingBlow:Show()
	elseif spellId == 148003 then
		warnBlazingBlow:Show()
		specWarnBlazingBlow:Show()
	elseif spellId == 148001 then
		warnConjurGolem:Show()
		specWarnConjurGolem:Show()
	elseif spellId == 147998 then
		warnFireStorm:Show()
		specWarnFireStorm:Show()
	elseif spellId == 147723 then
		warnFallingFlames:Show()
		specWarnFallingFlames:Show()
	elseif spellId == 147818 then
		self:BossTargetScanner(sourceGUID, "FireBlossomTarget", 0.02, 16)
	elseif spellId == 147828 then
		self:BossTargetScanner(73167, "StormBlossomTarget", 0.02, 16)
	elseif spellId == 147817 then
		warnFlameBreath:Show()
	elseif spellId == 147826 then
		warnLightningBreath:Show()
	elseif spellId == 147769 then
		warnRenewingMists:Show()
		specWarnRenewingMists:Show(args.sourceName)
	elseif spellId == 147702 then
		warnBlazingCleave:Show()
		specWarnBlazingCleave:Show()
	end
end
