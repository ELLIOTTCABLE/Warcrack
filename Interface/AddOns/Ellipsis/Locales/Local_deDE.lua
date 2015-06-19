-- German locals from Eltorrato@Kil'jaeden
local L = LibStub("AceLocale-3.0"):NewLocale("Ellipsis", "deDE", false)

if not L then return end -- abort if not using these locals

L.UpdatingDatabase = 'Datenbank wird aktualisiert...'

L.Targets = 'Ziele'
L.Prominence = 'Wichtige Ziele'
L.Cooldowns = 'Cooldowns'

L.TimeStringSecTenth = '%.1fs'
L.TimeStringSec = '%ds'
L.TimeStringMinSec = '%dm %ds'
L.TimeStringMin = '%dm'
L.TimeStringHour = '%dhr'

L.LeftClickToAnnounce = 'Links Klick zum posten.'
L.RightClickToCancel = 'Rechts-Klick bricht Timer ab.'
L.ShiftRightClickToBlock = 'Shift + Rechts Klick um den Spruch zu unterdr\195\188cken.'
L.CtrlRightClickToDestroyTotem = 'Strg + Rechts Klick zerst\195\182rt das Totem'

L.DNTWontTrack = 'Timer f\195\188r %s wird nun nicht mehr von Ellipsis bobachtet.'
L.CDDNTWontTrack = 'Cooldowns f\195\188r %s werden nun nicht mehr von Ellipsis beobachtet.'

L.EllipsisOptionsNotEnabled = 'Bitte aktivieren sie das Ellipsis_Options Addon um die Konfiguration vorzunehmen.'

L.NotifyExpiredTimer = '%s ist bei %s ABGELAUFEN!'
L.NotifyBrokenTimer = '%s wurde bei %s UNTERBROCHEN!'
L.NotifyCDExpiredTimer = 'Der Cooldown von %s wurde erreicht!'

L.TimerAnnounceAoeGhost = 'Mein %s ist abgelaufen.'
L.TimerAnnounceAoeActive = 'Mein %s l\195\164uft ab in %d:%02d.'

L.TimerAnnounceNormalGhost = 'Mein %s auf %s ist abgelaufen.'
L.TimerAnnounceNormalActive = 'Mein %s auf %s l\195\164uft in %d:%02d ab.'

L.Shocks = 'Schock'
L.Traps = 'Fallen'

L.SearchPatternCooldown = 'Abklingzeit'
L.SearchPatternRecharge = 'aufladen'

L.CDTimerAnnouncePet = "Der Cooldown des Pets %s endet in %d:%02d."
L.CDTimerAnnounceSpellItem = 'Mein %s Cooldown endet in %d:%02d.'

L.TimeRemaining = 'Verbleibende Zeit: %d:%02d'

L.Potions = 'Tr\195\164nke'
L.HealthstonesGems = 'Gesundheitssteine und Mana Gems'
L.Soulstones = 'Seelensteine'

L.ManaPotion = 'Manatrank$'
L.HealingPotion = 'Heiltrank$'
L.ProtPotion = 'Schutztrank$'
L.Healthstone = 'Gesundheitsstein$'
L.FelBlossom = '^Teufelsbl\195\188te$'
L.NightmareSeed = '^Alptraumsaat$'
L.FlameCap = '^Flammenkappe$'
L.Soulstone = 'Seelenstein$'
L.ManaAgate = '^Manaachat$'
L.ManaJade = '^Manajadestein$'
L.ManaCitrine = '^Manacitrin$'
L.ManaRuby = '^Manarubin$'
L.ManaEmerald = '^Manasmaragd$'
L.ManaSapphire = '^Manasaphir$'
