-- German Locals from Eltorrato@Kil'jaeden
local L = LibStub("AceLocale-3.0"):NewLocale("Ellipsis_Options", "deDE", false)

if not L then return end -- abort if not using these locals

local mustShow = 'Immer anzuzeigende Ziele:\n |cff67b1e9Kein Ziel|r - f\195\188r AoEs\n |cff67b1e9Spieler|r - wenn beobachtet\n |cff67b1e9Pet|r - wenn beobachtet'

L.Lock = 'Fixieren'
L.LockDesc = 'Fixiert das UI, versteckt die Greifer der |cff67b1e9Ziele|r und |cff67b1e9Bekannte Ziele|r, sichert vor unabsichtlichem Verschieben.'

L.SampleTimers = 'Test'
L.SampleTimersDesc = 'Erstellt ein Set von Beispiel Auren und Cooldown Timer um die Einstellungen beurteilen zu k\195\182nnen.\n\nNochmaliges Klicken des Knopfes setzt die Timer zur\195\188ck, ein Klick mit gedr\195\188ckter Shift-Taste l\195\182scht das Test Set.'
L.SampleTarget = 'Beispiel Ziel %d'
L.SampleTimer = 'Beispiel Timer %d'

-- Display (Base)
L.Display = 'Anzeigeoptionen'
L.DisplayDesc = 'Konfiguriert die Grundeinstellungen der Anzeige.'

L.Tooltips = 'Tooltips'
L.TooltipsDesc = 'Zeigt Tooltip-Inforamtionen wenn die Maus sich \195\188ber die Timer oder Auren bewegt.'

L.Clickable = 'Klickbare Timer'
L.ClickableDesc = 'Erm\195\182glicht das Anklicken der Auren und Timerbalken um sie im Chat zu posten oder vom Tracking zu entfernen.'

L.AuraAlpha = 'Alpha - Auren'
L.AuraAlphaDesc = 'Beeinflusst die Transparenz der Auren.'

L.AuraScale = 'Skalierung - Auren'
L.AuraScaleDesc = 'Legt die relative Skalierung der Auren fest.'

L.AuraWidth = 'Auren Breite'
L.AuraWidthDesc = 'Legt die Breite (in Pixel) der Auren fest; Dies gilt sowohl f\195\188r die Ziel Indentifikatoren als auch f\195\188r die Timer.'

L.CDAlpha = 'Alpha - Cooldowns'
L.CDAlphaDesc = 'Legt die Transparenz der Cooldownbalken und Timer fest.'

L.CDScale = 'Skalierung - Cooldowns'
L.CDScaleDesc = 'Legt die Skalierung der Cooldownbalken und Timer, relativ zur Basis des UI fest.'

-- Display (Targets 1)
L.DisplayTarget1 = 'Aura Ziel 1'
L.DisplayTargetDesc = 'Konfiguration der Zielaura Optionen.'

L.ConfigTargetDisplay = 'Zielanzeige Konfiguration'
L.ConfigTargetDisplayDesc = "Konfiguriert die Anzeige der Zielauren unabh\195\164ngig der 'Immer anzuzeigende Ziele', welche immer angezeigt werden, wenn Timer auf dem Ziel liegen. Bei den unteren Optionen gilt: f\195\188r die ersten vier, Ziel und Fokus werden priorisiert wenn sie existieren und Timer besitzen; die letzten drei, keine Ziele werden gezeig, wenn einer der Eintr\195\164ge (Ziel, Fokus oder Beides) existiert.\n\nAlle (Keine Priorit\195\164t)\nStandard Sortierung.\n\nAlle (Ziel Priorit\195\164t)\nZiel am Anfang der Liste.\n\nAlle (Fokus Priorit\195\164t)\nFokus am Anfang der Liste.\n\nAlle (Priorit\195\164t Beide)\nZiel am Anfang der Liste, gefolgt vom Fokus.\n\nNur Ziel\nZeige nur Ziel, wenn vorhanden.\n\nNur Fokus\nZeige nur Fokus, wenn vorhanden.\n\nZiel & Fokus\nZeige nur Ziel und Fokus, wenn vorhanden.\n\n" .. mustShow

L.ConfigTargetDisplayAll = 'Alle (Keine Priorit\195\164t)'
L.ConfigTargetDisplayAllBoth = 'Alle (Priorit\195\164t Beide)'
L.ConfigTargetDisplayAllFocus = 'Alle (Fokus Priorit\195\164t)'
L.ConfigTargetDisplayAllTarget = 'Alle (Ziel Priorit\195\164t)'
L.ConfigTargetDisplayBoth = 'Ziel & Fokus'
L.ConfigTargetDisplayFocus = 'Nur Fokus'
L.ConfigTargetDisplayTarget = 'Nur Ziel'

L.ShowNumTargets = 'Maximale Ziele'
L.ShowNumTargetsDesc = "Legt das Maximum an Zielauren fest (anderst als die 'Immer anzuzeigende Ziele').\n\nDiese Einstellung wird ignoriert, wenn 'Nur Ziel', 'Nur Fokus' oder 'Ziel & Fokus' eingestellt ist.\n\n" .. mustShow

L.TargetFont = 'Ziel Font'
L.TargetFontDesc = 'Legt den Zeichensatz der Zielauren fest.'

L.TargetFontHeight = 'Ziel Font Gr\195\182\195\159e'
L.TargetFontHeightDesc = 'Legt die Gr\195\182\195\159e des Zeichensatzes der Zielauren fest.'

L.TargetPadding = 'Ziel Abstand'
L.TargetPaddingDesc = 'Legt den Abstand (in Pixel) zwischen den Zielauren fest.'

L.GrowTargets = 'Ziel Anwachsen'
L.GrowTargetsDesc = 'Legt die Richtung fest, in der die Zielauren relativ zur ersten Aura anwachsen.'

L.GrowUP = 'auf'
L.GrowDOWN = 'ab'
L.GrowLEFT = 'links'
L.GrowRIGHT = 'rechts'

-- Display (Targets 2)
L.DisplayTarget2 = 'Aura Ziel 2'

L.ShowLevel = 'Zege Level'
L.ShowLevelDesc = 'Zeigt den Level der Gegner im Auratext.'

L.ShowClassColours = 'Zeige Klassenfarben'
L.ShowClassColoursDesc = 'Zeigt den Auratext in den definierten Klassenfarben.\n\nHinweis: Wenn aktiv, werden die Ziel Textfarben ignoriert.'

L.ShowRaidIcons = 'Zeige Raid Icons'
L.ShowRaidIconsDesc = 'Zeigt die Raid Icons im Zielauratext.'

L.ProminentTargetsHeader = 'Wichtige Ziele'
L.ProminentTargetsDesc = 'Die folgenden Zielauren k\195\182nnen als wichtig deklariert werden, was bedeutet, sie erscheien unter dem |cff67b1e9Wichtige Ziele|r Anker an statt unter den normalen |cff67b1e9Ziele|r Anker. Dies erlaubt wichtige Timer von den anderen zu trennen.'

L.ProminentItemsDesc = 'Markiere diese Zielaura als wichtig, um sie unter der |cff67b1e9Wichtige Ziele|r Anker an zu zeigen.'

L.ProminentNoTarget = 'Kein Ziel (AoEs)'
L.ProminentPlayer = 'Spieler'
L.ProminentPet = 'Pet'

-- Display (Timers 1)
L.DisplayTimer1 = 'Aura Timer 1'
L.DisplayTimerDesc = 'Konfiguriert die Timer Optionen.'

L.SortTimerMethod = 'Timer Sortierung'
L.SortTimerMethodDesc = 'Legt die Sortierreihenfolge der aktiven Timer f\195\188r eine Zielaura fest.'
L.SortTimerMethod1 = 'Alphabetisch (aufst)'
L.SortTimerMethod2 = 'Alphabetisch (abst)'
L.SortTimerMethod3 = 'Verbleibende Zeit (aufst)'
L.SortTimerMethod4 = 'Verbelibende Zeit (abst)'
L.SortTimerMethod5 = 'Keine Sortierung'

L.TimerFormat = 'Zeit Anzeigeformat'
L.TimerFormatDesc = 'Legt das Format der Restlaufzeit der Aura Timer fest.\n\nAls Beispiel seien drei Stellen gegeben, dies sind die Minuten, die Sekunden und (optional) die Zehntel Sekunden.\n\n## - 1:09  |  9  |  9.4\n\n0:## - 1:09  |  0:09  |  0:09.4\n\n##s - 1m 9s  |  9s  |  9.4s\n\n##s gerundet - 1m  |  9s  |  9.4s'
L.TimerFormat1 = '##'
L.TimerFormat2 = '0:##'
L.TimerFormat3 = '##s'
L.TimerFormat4 = '##s gerundet'

L.ShowTenths = 'Zeige Zehntel'
L.ShowTenthsDesc = 'Zeigt Zehntelsekunden an, wenn ein Timer den 10 Sekunden Countdown erreicht.'

L.Mode = 'Timer Modus'
L.ModeDesc = 'Legt den Modus der Aura Timer (Buff und DeBuff) fest..\n\nIm Balken-Modus erscheinen im Timerbalken die Spruchicons, der Name des Zaubers und der Timer Text.\n\nIm Icon-Modus wird nur das Spruchicon mit dem Timer Text angezeigt.'
L.ModeBars = 'Balken'
L.ModeIcons = 'Icons'

L.GrowTimers = 'Anwachsen der Timer'
L.GrowTimersDesc = 'Legt die Richtung fest, in der die Timerliste des Ziels, in Relation zum ersten Eintrag, anw\195\164chst.'

L.GhostShow = 'Geister Timer'
L.GhostShowDesc = 'Bestimmt ob Geister Timer angezeigt werden. Sie werden erstellt, wenn ein Timer abgelaufen ist um auf das Ende hin zu weisen.\n\nWenn deaktiviert, verschwinden die Timer einfach nach Ablauf der Zeit.'

L.GhostDuration = 'Geister Timer Dauer'
L.GhostDurationDesc = 'Legt die Dauer (in Sekunden) der Geister Timer, fest. '

-- Display (Timers 2)
L.DisplayTimer2 = 'Aura Timer 2'

L.BarHeight = 'Balken H\195\182he'
L.BarHeightDesc = "Legt die H\195\182he (in Pixel) der Timerbalken im 'Balkenmodus' fest."

L.IconHeight = 'Icon H\195\182he'
L.IconHeightDesc = "Legt die H\195\182he (in Pixel) der Icons im 'Iconmodus' fest.\n\nHinweis: Bestimmt auch die Breite der Icons, da sie quadratisch sind."

L.TimerPadding = 'Timer Abstand'
L.TimerPaddingDesc = 'Legt den Abstand (in Pixel) der Eintr\195\164ge der Timer fest.'

L.Texture = 'Timer Textur'
L.TextureDesc = "Legt die Textur der Timer im 'Balkenmudus' fest."

L.TimerFont = 'Timer Font'
L.TimerFontDesc = "Legt den Zeichensatz der Timertexte fest. Dies betrifft die Timer- (in beiden Modi) und die Spruchanzeige im 'Balkenmudus'."

L.TimerFontHeight = 'Timer Font H\195\182he'
L.TimerFontHeightDesc = 'Legt die H\195\182he des Zeichensatzes der Timertexte fest.'

L.ShowStackInName = 'Stapelz\195\164hler'
L.ShowStackInNameDesc = "Zeigt den Stapelz\195\164hler f\195\188r einen bestimmten Zauber (z.B. Lifebloom) im Zaubertext als Nummer, anstatt \195\188ber dem Icon liegend.\n\nHinweis: Aktiverung dieser Funktion versteckt den Stapelz\195\164hler im 'Icon Modus', da in diesem Modus der Zaubertext nicht angezeigt wird."

-- Display (Cooldowns 1)
L.DisplayCooldown1 = 'Cooldowns 1'
L.DisplayCooldownDesc = 'Konfiguriert die Cooldown Optionen.'

L.CDHorizontal = 'Horizontale Balken'
L.CDHorizontalDesc = 'Legt die Anzeige der Cooldown Balken in horizontaler oder vertikaler Ausrichtung fest.'

L.CDHideWhenNone = 'Vertecken...'
L.CDHideWhenNoneDesc = 'Erm\195\182glicht den Cooldownbalken zu verstecken, wenn keine aktive Cooldowns vorliegen. Wenn deaktiv, ist der Balken immer sichtbar.'

L.CDLength = 'Balken L\195\164nge'
L.CDLengthDesc = 'Legt die L\195\164nge (in Pixel) der Cooldownbalken fest.\n\nHinweis: Dies bestimmt die H\195\182he im Vertikalmodus.'

L.CDThickness = 'Balken Breite'
L.CDThicknessDesc = 'Legt die Breite (in Pixel) der Cooldownbalken fest.'

L.CDTimeDetail = 'Detailierte Zeit'
L.CDTimeDetailDesc = 'Bestimmt, ob eine datailierte Zeitachse (in welchen Abst\195\164nden Zeitmarken gesetzt sind) im Cooldownbalken angezeit wird.'

L.CDMaxTimeDisplay = 'Maximale angezeigte Zeit'
L.CDMaxTimeDisplayDesc = 'Bestimmt das Maximum (in Sekunden) der Cooldown Zeitskala.\n\nHinweis: Cooldowns mit einer h\195\182heren Dauer bleiben am Ende des Balkens stehen, bis die Cooldownzeit dem Berich der Zeitskala entspricht.'

L.CDFontHeight = 'Zeitskala Font H\195\182he'
L.CDFontHeightDesc = 'Legt die H\195\182he des Zeichensatzes der Zeitskala fest.'

-- Display (Cooldowns 2)
L.DisplayCooldown2 = 'Cooldowns 2'

L.CDTexture = 'Balken Textur'
L.CDTextureDesc = 'Bestimmt die verwendetet Textur der Cooldownbalken.'

L.CDShowOffsetTags = 'Ziege Offset Zeiger'
L.CDShowOffsetTagsDesc = 'Wenn ein Cooldowntimer einen Offset gr\195\182\195\159er als die H\195\164lfte der Breite des Cooldown Balkens besitzt, wird ein Zeiger vom Balken zum Icon generiert. Deaktiviern der Option verstckt die Zeiger und l\195\164sst die Icons an ihrer Offsetposition sich bewegen.'

L.CDOffset1 = 'Offset: Zauber'
L.CDOffset1Desc = 'Legt den Offset der Cooldowntimer der Zauber fest.\n\nPositiv: Positioniert das Icon \195\188ber, bzw. rechts vom Balken.\n\nNegativ: Positioniert das Icon unter, bzw. links vom Balken.'

L.CDOffset3 = 'Offset: Items'
L.CDOffset3Desc = 'Legt den Offset der Austattung und Item Timer fest.\n\nPositiv: Positioniert das Icon \195\188ber, bzw. rechts vom Balken.\n\nNegativ: Positioniert das Icon unter, bzw. links vom Balken.'

L.CDOffset2 = 'Offset: Pet'
L.CDOffset2Desc = 'Legt den Offset der Petf\195\164higkeiten fest.\n\nPositiv: Positioniert das Icon \195\188ber, bzw. rechts vom Balken.\n\nNegativ: Positioniert das Icon unter, bzw. links vom Balken.'

-- Display (Colours)
L.DisplayColours = 'Farben'
L.DisplayColoursDesc = 'Konfiguriert die GUI Farben.'

L.ColourTimerDesc = 'Aura Farben:'

L.ColourBackground = 'Timer Hintergrund'
L.ColourBackgroundDesc = 'Bestimmt die Farbe des Hintergrunds der aktiven, herunterz\195\164hlenden Timer.\n\nHinweis: Die Farbe kann auch transparent gew\195\164hlt werden.'

L.ColourGhost = 'Geister Timer'
L.ColourGhostDesc = 'Bestimmt die Farbe der Geister Timer.'

L.ColourTargetText = 'Ziel Indentifikation'
L.ColourTargetTextDesc = 'Bestimmt die Farbe der Ziel Indentifikation.'

L.ColourTimerText = 'Timer Text'
L.ColourTimerTextDesc = 'Bestimmt die Farbe des Timertextes (beide, Zauber und verbleibende Zeit).'

L.ColourCDDesc = 'Cooldown Farben:'

L.ColourCDBar = 'Haupt Balken'
L.ColourCDBarDesc = 'Bestimmt die Farbe des Haupt-Cooldown Balkens.\n\nHinweis: Die Farbe kann auch transparent gew\195\164hlt werden.'

L.ColourCDBorder = 'Balken Rand'
L.ColourCDBorderDesc = 'Bestimmt die Farbe des Randes des Haupt-Cooldown Balkens.\n\nHinweis: Die Farbe kann auch transparent gew\195\164hlt werden.'

L.ColourCDBackdrop = 'Balken Hintergrund'
L.ColourCDBackdropDesc = "Bestimmt die Farbe des Hintergrundes der Haupt-Cooldown Balkens. Diese kommt nur zum tragen, wenn der Balken teilweise oder total transparent ist.\n\nHinweis: Die Farbe kann auch transparent gew\195\164hlt werden."

L.ColourCDText = 'Zeitskala Text'
L.ColourCDTextDesc = "Bestimmt die Farbe der Cooldown Balken Zeitskala."

L.ColourCD1 = 'Offset Zeiger: Zauber'
L.ColourCD1Desc = 'Bestimmt die Farbe des Zauber Offset Zeigers.\n\nHinweis: Nur sichtbar, wenn ein Offset f\195\188r Zaubertimer existiert.'

L.ColourCD3 = 'Offset Zeiger: Items'
L.ColourCD3Desc = 'Bestimmt die Farbe des Ausstattungs und Item Offset Zeigers.\n\nHinweis: Nur sichtbar, wenn ein Offset f\195\188r Itemtimer existiert.'

L.ColourCD2 = 'Offset Zeiger: Pet'
L.ColourCD2Desc = 'Bestimmt die Farbe der Pet F\195\164higkeiten Offset Zeigers.\n\nHinweis: Nur sichtbar, wenn ein Offset f\195\188r Petf\195\164higkeiten Timer existiert.'

-- Aura Tracking
L.AuraTracking = 'Auren \195\188berwachung'
L.AuraTrackingDesc = 'Konfiguriert die \195\188berwachung der Auren.'

L.TrackBuffs = 'Buffs'
L.TrackBuffsDesc = '\195\188berwachung der Buffs die gewirkt werden k\195\182nnen.'

L.TrackDebuffs = 'Debuffs'
L.TrackDebuffsDesc = '\195\188berwachung der DeBuffs die gewirkt werden k\195\182nnen.'

L.TrackPlayer = 'Spieler Buffs'
L.TrackPlayerDesc = '\195\188berwachung der Buffs, die auf sich selbst gewirkt werden.'

L.TrackPet = 'Pet Buffs'
L.TrackPetDesc = '\195\188berwachung der Buffs, die auf das Pet gewirkt werden k\195\182nnen.'

L.MaxAuraDuration = 'Maximale Aura Dauer'
L.MaxAuraDurationDesc = 'Legt die maximale Aura Dauer (in Minuten), die von Ellipsis boabachtet wird, fest.\n\nBei 0 wird jegliche Dauer beobachtet.'

L.DNTAdd = "Zur 'Ignorieren Liste' hinzuf\195\188gen"
L.DNTAddDesc = "F\195\188gt Zauber zur 'Ignorieren Liste' hinzu, um von der Beobachtung durch Ellipsis ausgeschlossen zu werden."

L.DNTList = 'Ignorieren Liste'
L.DNTListDesc = "Eine Auflistung der Zauber, die in der 'Ignorieren Liste' aufgenommen sind. Bei Auswahl aus der DropDown Box kann ein Eintag gel\195\182scht werden."

L.DNTWillTrack = 'Timer f\195\188r %s wird nun von Ellipsis beobachtet.'

-- Cooldown Tracking
L.CooldownTracking = 'Cooldown \195\188berwachung'
L.CooldownTrackingDesc = 'Konfiguriert die Coldown \195\188berwachung.'

L.TrackCooldownsFor = '\195\188berwachung der Cooldowns f\195\188r...'

L.CDSpell = 'Zauber'
L.CDSpellDesc = '\195\188berwachung der Zauber Cooldowns.'

L.CDItem = 'Items'
L.CDItemDesc = '\195\188berwachung der Ausr\195\188stung und Item Cooldown.'

L.CDPet = 'Pet F\195\164higkeiten'
L.CDPetDesc = "Enable tracking of your pet's ability cooldowns."

L.CDMaxDuration = 'Maximale CD Dauer'
L.CDMaxDurationDesc = 'Legt die maximale Cooldown Dauer (in Minuten), die von Ellipsis boabachtet wird, fest.\n\nBei 0 wird jegliche Dauer beobachtet.'

L.CDDNTAddDesc = "F\195\188gt Cooldown zur 'Ignorieren Liste' hinzu, um von der Beobachtung durch Ellipsis ausgeschlossen zu werden."

L.CDDNTListDesc = "Listet die Cooldowns in der 'Ignorieren Liste' auf und erlaubt das Entfernen durch Klick auf einen Eintrag in der DropDown Box"

L.CDDNTWillTrack = 'Cooldowns f\195\188r %s werden nun von Ellipsis beobachtet.'

-- Output (Audio)
L.OutputAudio = 'Ausgabe (Audio)'
L.OutputAudioDesc = 'Konfiguriert die akustische Ausgabe.'

L.OAPlaySounds = 'Aktiv'
L.OAPlaySoundsDesc = 'Aktiviert die Audio Benachrichtigung bei Timer Auslauf.'

L.OAPlaySoundsOn = 'Spielt Sounds bei...'

L.OAExpiredDesc = 'Spielt Sound bei normalem Timer Ablauf.'
L.OABrokenDesc = 'Spielt Sound bei vorzeitigem Timer Abbruch.'
L.OACDExpiredDesc = 'Spielt Sound bei Cooldown Timer Ablauf.'

-- Output (Visual)
L.OutputVisual = 'Ausgabe (Visuell)'
L.OutputVisualDesc = 'Konfiguriert die optische Ausgabe.'

L.OVOutputTo = 'Ausgabe auf'
L.OVOutputToDesc = 'Konfiguriert den optischen Ausgabe Bereich.'

L.OVNotifyOn = 'Benachrichtigung bei...'

L.OVNotifyExpireDesc = 'Anzeige einer Nachricht bei normalem Ablauf eines Timers.'
L.OVNotifyBreakDesc = 'Anzeige einer Nachricht bei vorzeitigen Abbruch eines Timers.'
L.OVNotifyCDExpireDesc = 'Anzeige einer Nachricht bei Ablauf eines Cooldown Timers.'

-- Output (Common To Both)
L.OAVExpired = 'Aura Timer abgelaufen'
L.OAVBroken = 'Aura Timer abgebrochen'
L.OAVCDExpired = 'Cooldown Timer errecht'

-- Advanced
L.Advanced = 'Erweitert'
L.AdvancedDesc = 'Konfiguriert die Erweiterten Optionen.\n\nF\195\188r Erfahrene Benutzer.'

L.AdvancedWarning = "Diese Optionen bieten 'Low Level' Einstellungen  f\195\188r die \195\188berwachungsfunktionen von Ellipsis. Seien sie sich sicher was sie tun, bevor sie hier etwas \195\164ndern."

L.TimerUpdateRate = 'Timer Update Rate'
L.TimerUpdateRateDesc = "Legt fest, wie oft (in Sekunden) die Timeranzeige erneuert wird. Dies beinhaltet beides, Timer Text und Balken Fortschritt\n\nNiedrigere Werte bedeuten h\195\182heren Resourcenverbrauch und weichere Balkenbewegungen. H\195\182here dagegen verlangen weniger Resourcen, jedoch ist die Bewegung der Balken eher sprunghaft.\n\nNormalwerte: 0.05 - 0.15 Sekunden"

L.SecondaryScan = 'Zweites Abtasten'
L.SecondaryScanDesc = 'Aktiviert das zweite Abtasten, wenn man in sich in einer Gruppe oder einem Raid befindet. Es werden die Mitglieder der Gruppe jede Sekunde (Standardeinstellung) nach dem Zustand ihrer Auren abgefragt, um besser auf abgebrochene Timer reagieren zu k\195\182nnen. Das ist nur f\195\188r die DeBuff Timer notwendig, da die Buffs ihrer Gruppe vom prim\195\164ren Prozess in echtzeit erfasst werden.'

L.SecondaryScanRate = 'Zweite Abtast Rate'
L.SecondaryScanRateDesc = 'Legt fest, wieviel Zeit (in Sekunden) zwischen den zweiten Abtastprozesse verstreichen soll.\n\nNiedrige Werte liefern bessere Ergebnisse auf Kosten eines erh\195\182ten Rsourcen Verbrauchs. H\195\182here dagegen reduzieren den Resourcenhunger bei gleichzeitig ungenauere Aussagen \195\188ber abgebrochene Timer.\n\nNormlwerte: 1.0 - 1.5 Sekunden'
