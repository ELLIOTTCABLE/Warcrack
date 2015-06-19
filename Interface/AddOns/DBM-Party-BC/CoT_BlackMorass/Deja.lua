local mod	= DBM:NewMod(552, "DBM-Party-BC", 12, 255)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 561 $"):sub(12, -3))
mod:SetCreatureID(17879)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 38539 31472",
	"SPELL_AURA_APPLIED 31467"
)

local specwarnArcaneDischarge	= mod:NewSpecialWarningRun(38539, nil, nil, nil, 4)
local specwarnTimeLapse			= mod:NewSpecialWarningDispel(31467, "Healer")

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(38539, 31472) then
		specwarnArcaneDischarge:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 31467 then
		specwarnTimeLapse:Show(args.destName)
	end
end
