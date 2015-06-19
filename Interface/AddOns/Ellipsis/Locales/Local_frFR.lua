-- French locals from Markam@Chants éternels
local L = LibStub("AceLocale-3.0"):NewLocale("Ellipsis", "frFR", false)

if not L then return end -- abort if not using these locals

L.UpdatingDatabase = "Mise \195\160 jour de la base de donn\195\169es vers une nouvelle version..."

L.Targets = "Cibles"
L.Prominence = "Cibles pro\195\169minentes"
L.Cooldowns = "Cooldowns"

L.TimeStringSecTenth = "%.1fs"
L.TimeStringSec = "%ds"
L.TimeStringMinSec = "%dm %ds"
L.TimeStringMin = "%dm"
L.TimeStringHour = "%dhr"

L.LeftClickToAnnounce = "Clic-gauche pour annoncer"
L.RightClickToCancel = 'Clic-droit pour annuler le timer.'
L.ShiftRightClickToBlock = 'Shift+Clic-droit pour bloquer ce sort.'
L.CtrlRightClickToDestroyTotem = 'Ctrl+Clic-droit pour détruire ce totem.'

L.DNTWontTrack = "Timers pour %s ne seront plus d\195\169tect\195\169s par Ellipsis."
L.CDDNTWontTrack = "Cooldowns pour %s ne seront plus d\195\169tect\195\169s par Ellipsis."

L.EllipsisOptionsNotEnabled = "Veuillez activer l'addon Ellipsis_Options pour configurer les options."

L.NotifyExpiredTimer = '%s a EXPIRE sur %s!'
L.NotifyBrokenTimer = '%s a CASSE sur %s!'
L.NotifyCDExpiredTimer = "Cooldown de %s termin\195\168!"

L.TimerAnnounceAoeGhost = "Mon %s a expir\195\169."
L.TimerAnnounceAoeActive = "Mon %s va expir\195\169 dans %d:%02d."

L.TimerAnnounceNormalGhost = "Mon %s a expir\195\169 sur %s."
L.TimerAnnounceNormalActive = "Mon %s va expirer sur %s dans %d:%02d."

L.Shocks = "Horions"
L.Traps = "Pi\195\168ges"

L.SearchPatternCooldown = "de recharge"
L.SearchPatternRecharge = "recharger"

L.CDTimerAnnouncePet = "Le cooldown de %s de mon familier se terminera dans %d:%02d."
L.CDTimerAnnounceSpellItem = "Le cooldown de mon  %s se terminera dans %d:%02d."

L.TimeRemaining = "Temps restant: %d:%02d"

L.Potions = "Potions"
L.HealthstonesGems = "Pierres de soin et Gemmes de mana"
L.Soulstones = "Pierres d'\195\162me"

L.ManaPotion = "Potion de mana$"
L.HealingPotion = "Potion de soin$"
L.ProtPotion = "Potion de protection$"
L.Healthstone = "Pierre de soin$"
L.FelBlossom = "^Gangrelys$"
L.NightmareSeed = "^Graine de cauchemardelle$"
L.FlameCap = "^Chapeflamme$"
L.Soulstone = "Pierre d'\195\162me$"
L.ManaAgate = "^Agate de mana$"
L.ManaJade = "^Jade de mana$"
L.ManaCitrine = "^Citrine de mana$"
L.ManaRuby = "^Rubis de mana$"
L.ManaEmerald = "^Emeraude de mana$"
L.ManaSapphire = "^Saphir de mana$"
