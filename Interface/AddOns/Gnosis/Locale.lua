-- Gnosis v4.49 last changed 2015-05-10T22:07:21Z
-- Locale.lua last changed 2015-05-10T22:07:21Z

Gnosis.LSet = {
	["default"] = "default (English)",
	["deDE"] = "deDE (Deutsch)",
	["frFR"] = "frFR (Français)",
	["koKR"] = "koKR (한국어/조선말)",
	["ruRU"] = "ruRU (русский язык)",
	["zhCN"] = "zhCN (简体中文)",
	["zhTW"] = "zhTW (繁体中文)",
}

function Gnosis:SetupLocale()
Gnosis.L = nil;
Gnosis.L = {};

if (self.s.strLocale == "deDE") then
-- deDE locale (german)
Gnosis.L["AddonName"] = "Gnosis"
Gnosis.L["BT_Castbar"] = "Zauberleiste"
Gnosis.L["BT_MSTimer"] = "Multi-Spell Timer"
Gnosis.L["CBSetFocus"] = "Fokus"
Gnosis.L["CBSetGCD"] = "GCD"
Gnosis.L["CBSetMirror"] = "Spiegel"
Gnosis.L["CBSetPet"] = "BegleiterFahrzeug"
Gnosis.L["CBSetPlayer"] = "Spieler"
Gnosis.L["CBSetSwing"] = "Schwung"
Gnosis.L["CBSetTarget"] = "Ziel"
Gnosis.L["CpyScriptFromEditBox"] = "Kopiere Daten aus Textbox (|cffffff7f%s|r)."
Gnosis.L["Horizontal"] = "Horizontal"
Gnosis.L["IfCCSetup"] = "Standard Leisten erstellen"
Gnosis.L["IfCCSString"] = [=[Gnosis kann allgemeine Leisten erstellen (für Spieler, Ziel, Fokus, Spiegel und Pet/Fahrzeug). Die so erstellten Leisten sind frei beweglich (Ziehen, während die linke Maustaste betätigt wird). Ein Rechtsklick öffnet das Konfigurationsmenü.
 
Wenn du fertig bist, solltest du die Bars sperren, um unbeabsichtigtes Verschieben zu verhindern. Die Blizzard Zauber- und Spiegelleiste wird deaktiviert. Zusätzlich kannst du einen "Globalen Zauberzeit Indikator", sowie einen "Schwung Timer" (Einhand Nahkampf, sowie Fernkampf einschließlich Zauberstab) erstellen, indem du den unteren Button betätigst. Das Chatkommando, um das Gnosis Menü aufzurufen ist "/gnosis".
]=]
Gnosis.L["IfCCTimers"] = "GCD/Schwung Timer erstellen"
Gnosis.L["IfConfigs"] = "Konfigurationen"
Gnosis.L["IfCWAction"] = "Button drücken, um das Fenster ohne Änderungen zu schließen"
Gnosis.L["IfLFConigs"] = "Ein oder mehrere gespeicherte Konfigurationen wurden gefunden. Du kannst Gnosis konfigurieren, in dem Du eine bereits vorhandene Konfiguration durch einen der unteren Buttons lädst (Der Name des Buttons entspricht der Konfiguration die anschließend geladen wird)."
Gnosis.L["IfNoCBs"] = "Keine Leisten gefunden"
Gnosis.L["IfOpenGUI"] = "Einstellungen öffnen"
Gnosis.L["Import"] = "Importieren"
Gnosis.L["ImportFromHyperlink"] = "Leisten Konfiguration importieren? Sollte die Leiste bereits existieren wird die aktuelle Konfiguration überschrieben."
Gnosis.L["ImportKeepPos"] = "Importieren, Position beibehalten"
Gnosis.L["MsgBlizCBIsDis"] = "Blizzard-Zauberleiste wurde bereits durch ein anderes Addon deaktiviert"
Gnosis.L["MsgBlizCBRestored"] = "Blizzard-Zauberleiste wiederhergestellt (siehe Konfiguration)"
Gnosis.L["MsgDis"] = "(deaktiviert)"
Gnosis.L["MsgDisBlizCB"] = "Blizzard-Zauberleiste deaktiviert (siehe Konfiguration)"
Gnosis.L["MsgDisMirrCB"] = "Blizzard-Spiegelleiste deaktiviert (siehe Konfiguration)"
Gnosis.L["MsgDisPetCB"] = "Blizzard Begleiter/Fahrzeugleiste deaktiviert (siehe Konfiguration)"
Gnosis.L["MsgEn"] = "(aktiviert)"
Gnosis.L["MsgLoaded"] = "geladen"
Gnosis.L["MsgMirrCBIsDis"] = "Standard-Spiegelleiste wurde bereits durch ein anderes Addon deaktiviert"
Gnosis.L["MsgMirrCBRestored"] = "Standard-Spiegelleiste wiederhergestellt (siehe Konfiguration)"
Gnosis.L["MsgPetCBIsDis"] = "Blizzard Begleiter/Fahrzeugleiste bereits durch ein anderes Addon deaktiviert"
Gnosis.L["MsgPetCBRestored"] = "Blizzard Begleiter/Fahrzeugleiste wiederhergestellt (siehe Konfiguration)"
Gnosis.L["No"] = "Nein"
Gnosis.L["NoImport"] = "Nicht importieren"
Gnosis.L["OptAddonDisabled_Name"] = "Addon deaktiviert, aktivieren um Zugriff auf Konfiguration zu erhalten."
Gnosis.L["OptAddonEnable_Desc"] = "Gnosis öffnen/schließen"
Gnosis.L["OptAddonEnable_Name"] = "Addon aktivieren"
Gnosis.L["OptBarXYcoordDesc"] = "x,y-Koordinaten"
Gnosis.L["OptBarXYcoordName"] = "Position: x, y"
Gnosis.L["OptCBActiveSpec"] = "Aktiviert für Talente"
Gnosis.L["OptCBAddListElem"] = "Eintrag hinzufügen"
Gnosis.L["OptCBAdjIcon"] = "Symbolposition anpassen (wenn freigegeben)"
Gnosis.L["OptCBAdjLatTextCoord"] = "Textpositon der Latenz anpassen"
Gnosis.L["OptCBAdjNamePos"] = "Position des Zaubernamens anpassen"
Gnosis.L["OptCBAlignName"] = "Zaubername anordnen"
Gnosis.L["OptCBAlignTime"] = "Zauberzeit anordnen"
Gnosis.L["OptCBAlignTimeCoord"] = "Position der Zauberzeit anpassen"
Gnosis.L["OptCBAlpha"] = "Transparenz der Leiste"
Gnosis.L["OptCBAnc"] = "Verankerung"
Gnosis.L["OptCBAncBarAncPnt"] = "Gnosis Leiste Ankerpunkt"
Gnosis.L["OptCBAncFrameAncPnt"] = "Ankerfenster Ankerpunkt"
Gnosis.L["OptCBAncFrameName"] = "Verankern an Fenster"
Gnosis.L["OptCBAncNoAnc"] = "Kein Anker"
Gnosis.L["OptCBAncOffset"] = "Verschiebung x,y"
Gnosis.L["OptCBAncToCursor"] = "An Cursor verankern"
Gnosis.L["OptCBAncToFrame"] = "An Fenster verankern"
Gnosis.L["OptCBAncType"] = "Ankertyp"
Gnosis.L["OptCBBarType"] = "Leistentyp"
Gnosis.L["OptCBBorderCol"] = "Rahmenfarbe"
Gnosis.L["OptCBBorderColInt"] = "Rahmenfarbe (nicht unterbrechbar)"
Gnosis.L["OptCBBorderSize"] = "Rahmengröße"
Gnosis.L["OptCBBorderTex_D"] = "Zusätzliche Rahmen-Textur. Tip: Icon freigeben und den normalen Rahmen auf Größe 0 setzen. Die zusätzliche Rahmen-Textur hat keinen Einfluss auf den Icon-Rahmen."
Gnosis.L["OptCBBorderTex_N"] = "Zusätzliche Rahmen-Textur"
Gnosis.L["OptCBBWListedSpells"] = "Zauber auf der Black-/Whitelist oder Timer Konfiguration"
Gnosis.L["OptCBCBBgCol"] = "Hintergrund"
Gnosis.L["OptCBCBColFail"] = "Zauberleiste (fehlgeschlagen)"
Gnosis.L["OptCBCBColInt"] = "Zauberleiste (unterbrochen)"
Gnosis.L["OptCBCBColor"] = "Zauberleiste"
Gnosis.L["OptCBCBNIColor"] = "Zauberleiste Farbe (nicht unterbrechbar)"
Gnosis.L["OptCBCBShColor"] = "Text Schattenfarbe"
Gnosis.L["OptCBCBSucColor"] = "Zauber erfolgreich (Farbe)"
Gnosis.L["OptCBCenterCB"] = "Leiste zentrieren"
Gnosis.L["OptCBChannelsAsNormal"] = "Behandle kanalisierte Zauber wie normale Zauber (inkl. Timer)"
Gnosis.L["OptCBCombatSelAlways"] = "in- und außerhalb eines Kampfes"
Gnosis.L["OptCBCombatSelInC"] = "nur im Kampf"
Gnosis.L["OptCBCombatSelOoC"] = "nur außerhalb eines Kampfes"
Gnosis.L["OptCBCombSel"] = "Zeige Zauberleiste während"
Gnosis.L["OptCBCopyCB_D"] = "Leiste kopieren, ein gültiger Name muss angegeben werden"
Gnosis.L["OptCBCopyCB_N"] = "Leiste kopieren"
Gnosis.L["OptCBEnCastSucDesc"] = "Farbe wechseln, wenn Zauber erfolgreich war"
Gnosis.L["OptCBEnCastSucName"] = "Farbwechsel bei erfolgreichem Zauber"
Gnosis.L["OptCBEnCB"] = "Leiste aktivieren"
Gnosis.L["OptCBEnList"] = "Aktiveren/Deaktivieren der Black-/Whitelist"
Gnosis.L["OptCBEnShCol"] = "Aktiviere Text Schattenfarbe"
Gnosis.L["OptCBExportBar"] = "Leiste exportieren"
Gnosis.L["OptCBExportBarChatlink_D"] = "Das Chat Eingabefenster muss bereits angezeigt werden."
Gnosis.L["OptCBExportBarChatlink_N"] = "Füge  Import-Verknüpfung in Chat ein"
Gnosis.L["OptCBExtendChannels_D"] = "Erweitert kanalisierte Zauber wenn der identische kanalisierte Zauber ausgeführt wird bevor der letzte Zauber vollständig abgeschlossen war."
Gnosis.L["OptCBExtendChannels_N"] = "Kanalisieren erweitern"
Gnosis.L["OptCBFadeout"] = "Ausblendzeit"
Gnosis.L["OptCBFillAtEnd"] = "Zauberleiste bei Zauberende auffüllen"
Gnosis.L["OptCBFixLatBox"] = "Fixierte Größe der nicht-Spieler Tick Box [in %]"
Gnosis.L["OptCBFont"] = "Schrift"
Gnosis.L["OptCBFontOutline"] = "Schrift Kontur"
Gnosis.L["OptCBFontSizeLat"] = "Latenz Schriftgröße (0=automatisch)"
Gnosis.L["OptCBFontSizeName"] = "Name Schriftgröße (0=automatisch)"
Gnosis.L["OptCBFontSizeTime"] = "Timer Schriftgröße (0=automatisch)"
Gnosis.L["OptCBForceLatAlign"] = "Latenzanordnung erzwingen"
Gnosis.L["OptCBFrameStrata"] = "Rahmenebene"
Gnosis.L["OptCBGroupSelAlways"] = "solo, in einer (Raid-)Gruppe (immer)"
Gnosis.L["OptCBGroupSelPartyNotRaid"] = "in Gruppe, nicht in einem Raid"
Gnosis.L["OptCBGroupSelRaid"] = "in einer Raidgruppe"
Gnosis.L["OptCBGroupSelSolo"] = "solo, nicht im Raid"
Gnosis.L["OptCBIconBorderSize"] = "Symbolrahmengröße (wenn freigegeben)"
Gnosis.L["OptCBInstanceSelAlways"] = "innerhalb oder außerhalb Instanz (immer)"
Gnosis.L["OptCBInstanceSelArena"] = "innerhalb Arena"
Gnosis.L["OptCBInstanceSelBattleground"] = "auf Schlachtfeld"
Gnosis.L["OptCBInstanceSelFiveMan"] = "innerhalb 5-Mann Instanz"
Gnosis.L["OptCBInstanceSelInside"] = "innerhalb Instanz"
Gnosis.L["OptCBInstanceSelOutside"] = "außerhalb Instanz"
Gnosis.L["OptCBInstanceSelRaid"] = "innerhalb Raid Instanz"
Gnosis.L["OptCBInvBarDir"] = "Leistenrichtung umdrehen"
Gnosis.L["OptCBLatBoxCol"] = "Latenzbox"
Gnosis.L["OptCBListBlack"] = "blacklist"
Gnosis.L["OptCBListNeither"] = "weder"
Gnosis.L["OptCBListWhite"] = "whitelist"
Gnosis.L["OptCBLockAll_D"] = "Alle Leisten festsetzen"
Gnosis.L["OptCBLockAll_N"] = "Festsetzen"
Gnosis.L["OptCBMaxLatBox"] = "Maximalgröße der Latenzbox [in %]"
Gnosis.L["OptCBNewCB_D"] = [=[Neue Leiste erstellen. Ein gültiger Namen muss angeben werden.

Halten der Shift-Taste erstellte eine Icon-artige Leiste.]=]
Gnosis.L["OptCBNewCB_N"] = "Neue Leiste"
Gnosis.L["OptCBNewCBName_D"] = "Name eingeben"
Gnosis.L["OptCBNewListElem_D"] = [=[Zauberleisten:
Zaubersprüche für die Black-/Whitelist hinzufügen.

Multi-Spell Timer:
Standardformat der Einträge: Kommandos [Optionen] : Typ

Weitere Informationen auf www.curse.com/addons/wow/gnosis und in den beiliegenden .pdf Dokumenten (WoW Ordner/Addons/Gnosis).]=]
Gnosis.L["OptCBNewListElem_N"] = "Zaubername eingeben zum Hinzufügen"
Gnosis.L["OptCBOrient"] = "Richtung"
Gnosis.L["OptCBRelSel"] = "Zeige Zauber von"
Gnosis.L["OptCBRelSelAll"] = "alle einheiten"
Gnosis.L["OptCBRelSelEnemy"] = "gegnerische einheiten"
Gnosis.L["OptCBRelSelFriendly"] = "freundliche einheiten"
Gnosis.L["OptCBRemCB"] = "Leiste entfernen"
Gnosis.L["OptCBRemListElem"] = "Aktuellen Eintrag entfernen"
Gnosis.L["OptCBRotIcon"] = "Symbol drehen (°)"
Gnosis.L["OptCBRotLatencyN"] = "Latenz drehen"
Gnosis.L["OptCBRotNameD"] = "Forciert freie Anordnung falls aktiviert"
Gnosis.L["OptCBRotNameN"] = "Namen drehen"
Gnosis.L["OptCBRotTimeN"] = "Zeit drehen"
Gnosis.L["OptCBScaleBar"] = "Skalierung der Leiste"
Gnosis.L["OptCBScaleIcon"] = "Skalierung des Zaubersymbols (wenn freigegeben)"
Gnosis.L["OptCBShowChanTicks"] = "Zeige kanalisierte Ticks"
Gnosis.L["OptCBShowIcon"] = "Zaubersymbol anzeigen"
Gnosis.L["OptCBShowLatBox"] = "Zeige Latenzbox"
Gnosis.L["OptCBShowShield"] = "Zeige Schild für nicht unterbrechbare Zauber"
Gnosis.L["OptCBShowSpark"] = "Zeige Castspark"
Gnosis.L["OptCBSizeGrp"] = "Leistenform und -aussehen"
Gnosis.L["OptCBSparkColor"] = "Farbe des Sparks"
Gnosis.L["OptCBSparkHeight"] = "Höhe des Sparks"
Gnosis.L["OptCBSparkWidth"] = "Breite des Sparks"
Gnosis.L["OptCBSWNC"] = "Zeige wenn nicht gezaubert wird"
Gnosis.L["OptCBTabColors"] = "Farben"
Gnosis.L["OptCBTabHide"] = "Leiste verstecken"
Gnosis.L["OptCBTabText"] = "Text"
Gnosis.L["OptCBTextAlignment"] = "Ausrichtung (Name zur Zeit)"
Gnosis.L["OptCBTextColLat"] = "Text (Latenz)"
Gnosis.L["OptCBTextColName"] = "Text (Name)"
Gnosis.L["OptCBTextColPB"] = "Text (unterbrochen)"
Gnosis.L["OptCBTextColTime"] = "Text (Zeit)"
Gnosis.L["OptCBTexture"] = "Textur der Zauberleiste"
Gnosis.L["OptCBUnit"] = "Einheit"
Gnosis.L["OptCBUnl_D"] = "Zauberleiste freigeben (dauerhaft angezeigt)"
Gnosis.L["OptCBUnl_N"] = "Leiste freigeben (verschiebbar)"
Gnosis.L["OptCBUnlockAll_D"] = "Alle Leisten freisetzen (bewegbar). Freigesetzte Leisten oder Leisten die für eine andere Talent-Spezifizierung konfiguriert sind werden auch nach dem freisetzen nicht sichtbar gemacht."
Gnosis.L["OptCBUnlockAll_N"] = "Freisetzen"
Gnosis.L["OptCBUnlockIcon_D"] = "Symbol von Leiste lösen"
Gnosis.L["OptCBUnlockIcon_N"] = "Symbol freigeben"
Gnosis.L["OptCBWordWrapD"] = "Erlaubt (automatischen) Zeilenumbruch"
Gnosis.L["OptCBWordWrapN"] = "Zeilenumbruch"
Gnosis.L["OptCHCastnameGrp"] = "Zaubernamen Optionen"
Gnosis.L["OptCHCasttimeGrp"] = "Zauberzeit Optionen"
Gnosis.L["OptClipWarn_Desc"] = "Warnen, wenn kurz vor dem Tick eines kanalisierten Zaubers unterbrochen wird (nicht AoE)."
Gnosis.L["OptClipWarn_Name"] = "Clipping Warnung [ms]"
Gnosis.L["OptCombTicks"] = "Ticks und Ausgabe im Kampftext kombinieren"
Gnosis.L["OptConfDelConf"] = "Konfiguration entfernen"
Gnosis.L["OptConfDelConfMBText"] = "Konfiguration |cffffff7f%s|r löschen?"
Gnosis.L["OptConfLoadCBs"] = "Lade Zauberleisten"
Gnosis.L["OptConfLoadChan"] = "Lade Kanalisierte Zauber"
Gnosis.L["OptConfLoadCT"] = "Lade Kampftext/Cliptest Einstellungen"
Gnosis.L["OptConfLoadMain"] = "Allgemeine Einstellungen laden"
Gnosis.L["OptConfName"] = "Konfigurationsname"
Gnosis.L["OptConfSave"] = "Konfiguration speichern"
Gnosis.L["OptConfStoreCBs"] = "Zauberleisten speichern"
Gnosis.L["OptConfStoreChan"] = "Kanalisierte Zauber speichern"
Gnosis.L["OptConfStoreCT"] = "Kampftext/Cliptest Einstellungen speichern"
Gnosis.L["OptConfStoreMain"] = "Allgemeine Einstellungen speichern"
Gnosis.L["OptConfUpdConf"] = "Konfiguraton aktualisieren"
Gnosis.L["OptConfUpdConfMBText"] = "Konfiguration |cffffff7f%s|r aktualisieren?"
Gnosis.L["OptCopytonewbarExists"] = "eine Zauberleiste mit diesem Namen existiert bereits"
Gnosis.L["OptCopytonewbarInvalidName"] = "Gültigen Namen für kopierte Zauberleiste eingeben"
Gnosis.L["OptCreateCBSet"] = "Schnellstart - Standard Zauberleisten erstellen"
Gnosis.L["OptCreatenewbarExists"] = "eine Zauberleiste mit diesem Namen existiert bereits"
Gnosis.L["OptCreatenewbarInvalidName"] = "Gültigen Namen für Zauberleiste eingeben"
Gnosis.L["OptCreateNewSpell"] = "Neuen Zauber erstellen"
Gnosis.L["OptCSFSClip"] = "Schriftgröße (clip, 0=standard)"
Gnosis.L["OptCSFSNonClip"] = "Schriftgröße (non clip, 0=standard)"
Gnosis.L["OptCSRemove"] = "Zauber entfernen"
Gnosis.L["OptCTO"] = "Kampftextausgabe"
Gnosis.L["OptCTO_Blizz"] = "Blizzard's schwebender Kampftext"
Gnosis.L["OptCTO_MSBT"] = "Mik's Scrolling Battle Text"
Gnosis.L["OptCTO_Parrot"] = "Parrot"
Gnosis.L["OptCTO_SCT"] = "Scrolling Combat Text"
Gnosis.L["OptEn"] = "Aktivieren"
Gnosis.L["OptEnAutoCreateOptons"] = "Optionsmenü beim Start automatisch erstellen"
Gnosis.L["OptEnClipTest"] = "Clip test aktivieren"
Gnosis.L["OptExportAllBars"] = "Alle Leisten exportieren"
Gnosis.L["OptFile"] = "Datei"
Gnosis.L["OptFirstStartFrame"] = "Einführungsfenster anzeigen"
Gnosis.L["OptFirstTickInst"] = "Erster Tick sofort"
Gnosis.L["OptFontEnShOffset"] = "Aktiviere spezifischen Schattenversatz"
Gnosis.L["OptFontResizeLongName"] = "Bei langen Namen Schriftgröße ändern"
Gnosis.L["OptFontShOffsetXYDesc"] = "Versatz zwischen Text und Textschatten"
Gnosis.L["OptFontShOffsetXYName"] = "Schattenversatz x, y"
Gnosis.L["OptHasteAddsTicks"] = "Zaubertempo fügt Ticks hinzu"
Gnosis.L["OptHeight"] = "Höhe"
Gnosis.L["OptHideAddonMsgs"] = "Gnosis Textmeldungen verstecken"
Gnosis.L["OptHideBlizzCB"] = "Blizzards Zauberleiste verstecken"
Gnosis.L["OptHidecasttime"] = "Verstecke verbleibende Zauberzeit"
Gnosis.L["OptHidecasttimeTotal"] = "Verstecke gesamte Zauberzeit"
Gnosis.L["OptHideMirrorCB"] = "Blizzards Spiegelleiste verstecken"
Gnosis.L["OptHideNonPlayerTicks"] = "Verstecke Ticks auf nicht-Spieler Zauberleisten"
Gnosis.L["OptHidePetCB"] = "Verstecke die Begleiter/Fahrzeug Zauberleiste von Blizzard"
Gnosis.L["OptHidepushbackTime"] = "Verstecke Zauberverzögerung"
Gnosis.L["OptImportBar"] = "Leiste(n) importieren"
Gnosis.L["OptLoadOptionsButtonDesc"] = "Das Optionsmenü wurde noch nicht generiert, um Gnosis' Speicherauslastung zu minimieren. Nach dem Erstellen kannst du auswählen die Optionen beim Start von WoW automatisch zu generieren."
Gnosis.L["OptLoadOptionsButtonName"] = "Optionsmenü erstellen..."
Gnosis.L["OptLocale"] = "Lokalisierung auswählen"
Gnosis.L["OptMergetradeskillDesc"] = "Gegenstandsherstellung durch Berufe zusammenführen (Nur Spieler-Zauberleiste)."
Gnosis.L["OptMergetradeskillName"] = "Gegenstandsherstellung zusammenführen"
Gnosis.L["OptMusic"] = "Musik"
Gnosis.L["OptNameFormatStringDesc"] = [=[Zeichenfolge eingeben, die als Name angezeigt werden soll

name: Zaubername
trunc<cnt>: Zaubername kürzen falls länger als cnt
abbr<cnt>:Zaubername kürzen (Akronym), falls länger als cnt
rank<text>: Text anzeigen, falls Rang verfügbar ist
misc: weitere Infos anzeigen, falls ohne Rang
arabic: Rang als arabische Zahl (z.B. 13)
roman: Rang als römische Zahl (z.B. XIII)
txr<text>: Text anzeigen, falls Rang-Info verfügbar ist
txm<text>: Text anzeigen, falls weitere Infos verfügbar sind
target: Name des Ziels anzeigen, falls verfügbar (nur Spieler)
tar<text>: Text anzeigen, falls Zielinformationen verfügbar sind (nur Spieler)
tar[text]: genau wie oben
who: Name der Zauber wirkenden Einheit anzeigen

col<r,g,b[,a]>: z.B. col<1.0,1.0,0.0>, um die Farbe zu verändern
col<school>: wobei Schule zu verstehen ist als Schatten, Arkan, ...
col<pre>: Farbe zur vorherigen ändern
col<class>: Farbe zur Klassenfarbe des Ziels ändern (falls verfügbar)
col<cpre>: zu vorheriger Farbe zurückkehren (falls Klassenfarbe des Ziels verfügbar ist)

tscur: verbleibende herstellbare Gegenstände des Handwerks anzeigen
tstot: Gesamtzahl herstellbarer Gegenstände des Handwerks anzeigen
txts<text>: Text anzeigen, falls Handwerksinformationen verfügbar sind

\n: neue Zeile erzwingen (falls Zeilenumbruch aktiviert)]=]
Gnosis.L["OptNameFormatStringName"] = "Nameformat"
Gnosis.L["OptNameFormatToggleDesc"] = "Ignoriert bei Aktivierung 'Zeige Zaubername' und 'Zeige Zauberrang'"
Gnosis.L["OptNameFormatToggleName"] = "Namenformats-Zeichenfolge aktivieren"
Gnosis.L["OptOutputString"] = "Ausgabe"
Gnosis.L["OptOutputStringDesc"] = [=[String als Kampftext-Ausgabe
 
spellname: Name des kanalisierten Zaubers
dmg: Menge des Schadens/der Heilung durch Kanalisierung
eh: Effektive Heilung (= Heilung-"Overheal")
oh: Overheal (Menge der Heilung über 100%)
dps: Schaden/Heilung pro Sekunde der Kanalisierung
target: Zielname der Kanalisierung
clipped: Information bei unbeabsichtigtem clip
cliptext<eigener Text>: Eigener Text, der "clipped" ersetzt
 
hits: Anzahl der Treffer
crits: Anzahl der kritischen Treffer
ticks: Anzahl der Ticks
tickscrits: Anzahl der Ticks und kritischen Treffer
 
folgende Identifier können den oberen Strings angehängt werden
hittext<eigener text>: Identifier für Treffer
crittext<eigener text>: Identifier für kritische Treffer
ticktext<eigener text>: Identifier für Ticks
 
col<r,g,b[,a]>: z.B. col<1.0,1.0,0.0> um Farbe zu ändern
col<school>: Zauberschule (Schatten,Arkan...)
col<pre>: zur vorherigen Farbe wechseln
col<class>: Farbe zur Ziel-Klassenfarbe ändern (falls verfügbar)
col<cpre>: zur vorherigen Farbe wechseln (falls Ziel-Klassenfarbe verfügbar ist)]=]
Gnosis.L["OptPFoC"] = "Spiele Datei nach Clip"
Gnosis.L["OptPlayFile"] = "Datei abspielen"
Gnosis.L["OptPlayMusic"] = "Musik abspielen"
Gnosis.L["OptPlaySnd"] = "Sound abspielen"
Gnosis.L["OptPlayTickSound_D"] = "Deaktiviert \"Clipping\"-Sound"
Gnosis.L["OptPlayTickSound_N"] = "Tick-Sound abspielen"
Gnosis.L["OptPMoC"] = "Bei Clip Musik abspielen"
Gnosis.L["OptPSoC"] = "Bei Clip Sound abspielen"
Gnosis.L["OptResetPlayerData"] = "Spielerdaten zurücksetzen (lädt Interface neu)"
Gnosis.L["OptResizeOptions"] = "Größe der Interface-Optionen zum Start verändern"
Gnosis.L["OptSaveconfigExists"] = "eine Konfiguration mit diesem Namen existiert bereits"
Gnosis.L["OptSaveconfigInvalidName"] = "kein Konfigurationsname eingegeben"
Gnosis.L["OptShowasminutesDesc"] = "Minuten anstatt den Sekunden anzeigen, wenn länger als 60s."
Gnosis.L["OptShowasminutesName"] = "Minuten anzeigen"
Gnosis.L["OptShowCastNameDesc"] = "Wird bei individuellem Nameformat nicht genutzt."
Gnosis.L["OptShowCastNameName"] = "Zaubername anzeigen"
Gnosis.L["OptShowCastRankDesc"] = "Wird bei individuellem Nameformat nicht genutzt."
Gnosis.L["OptShowCastRankName"] = "Zauberrang anzeigen"
Gnosis.L["OptShowPlayerLatency"] = "Latenz anzeigen (ms)"
Gnosis.L["OptShowSpellIcon"] = "Zaubersymbol anzeigen"
Gnosis.L["OptSnd"] = "Sound"
Gnosis.L["OptSpellIsAoE"] = "Zauber trifft mehrere Gegner"
Gnosis.L["OptSpellNameOrId"] = "Zaubername oder Zauber ID"
Gnosis.L["OptStickyClips"] = "Festgesetzte Klammern"
Gnosis.L["OptStrGapDesc"] = "Minimaler Abstand zwischen Zaubername und Zeit (legt Schriftverkleinerung fest)."
Gnosis.L["OptStrGapName"] = "Abstand (Name...Zeit)"
Gnosis.L["OptTablesUnloaded_Name"] = "Optionsmenü wurde noch nicht generiert"
Gnosis.L["OptTicksToShow"] = "Ticks anzeigen"
Gnosis.L["OptTimeFormatStringDesc"] = [=[Folgende strings sind möglich

r<x>: Verbleibende Zeit in Sekunden mit x Kommastellen
t<x>: Gesamtzeit in Sekunden mit x Kommastellen
p<x>: Zauberverzögerung in Sekunden mit x Kommastellen

füge s ein um das Vorzeichen, m um Zeiten über 60s in Minuten und a um höhere Genauigkeit unter einer Sekunde (r<0a>) anzeigen zu lassen
z.B. r<1m> oder p<2s>
füge p ein um den Wert in Prozent auszugeben
z.B. r<p>% / t<1p>%

col<r,g,b[,a]>: z.B. col<1.0,1.0,0.0> um die Farbe zu ändern
col<school>: Farbe der Zauberschule (Schatten, Arkan...)
col<pre>: zur vorherigen Farbe wechseln

\n: neue Zeile

Hinnweis: verwende col<r,g,b> um die Farbe der Zauberverzögerung ändern]=]
Gnosis.L["OptTimeFormatStringName"] = "Zeitformat"
Gnosis.L["OptTimeFormatToggleDesc"] = "Bei Aktivierung werden andere Optionen des Zeitformats ignoriert."
Gnosis.L["OptTimeFormatToggleName"] = "Individuelles Zeitformat"
Gnosis.L["OptTimerScanEveryN"] = "Multi-Spell Timer Leisten updaten alle [ms]"
Gnosis.L["OptTotTicks"] = "Gesamte Ticks"
Gnosis.L["OptWfCL_Desc"] = "Verzögere Ausgabe/Clip Test in ms um Kampftextverzögerung entgegenzuwirken."
Gnosis.L["OptWfCL_Name"] = "Warte auf Kampftext [ms]"
Gnosis.L["OptWidth"] = "Breite"
Gnosis.L["PasteScript"] = "Import Daten in die Edit-Box einfügen"
Gnosis.L["PremadeNfs1"] = "Zauber |cffff0000(Rang, etc., z.B. Stapel)|r (kombinierte Handelsgüter Herstellung)"
Gnosis.L["PremadeNfs2"] = "Zauber |cffff0000(Aura Effekt-Wert)|r"
Gnosis.L["PremadeNfs3"] = "|cffffff00Name der Einheit|r: Zauber"
Gnosis.L["PremadeTfs1"] = "|cffff0000Pushback|r Verbleibend / Total, z.B. |cffff0000+1.0|r 1.4 / 3.00"
Gnosis.L["PremadeTfs2"] = "|cffff0000Pushback|r Verbleibend / Total, wie oben, jedoch ohne Minutenanzeige"
Gnosis.L["PremadeTfs3"] = "Verbleibend / Total, höhere Genauigkeit, z.B. 1.45 / 3.000"
Gnosis.L["SelPremadeStr"] = "Vorgefertigte Optionen auswählen"
Gnosis.L["Strata_BACK"] = "Niedrigste"
Gnosis.L["Strata_DIALOG"] = "Höchste"
Gnosis.L["Strata_HIGH"] = "Höchste"
Gnosis.L["Strata_LOW"] = "Niedrig"
Gnosis.L["Strata_MEDIUM"] = "Mittel"
Gnosis.L["TabAdaptToCT"] = "An Zaubertyp orientieren"
Gnosis.L["TabCapBOTTOM"] = "UNTEN"
Gnosis.L["TabCapBOTTOMLEFT"] = "UNTEN LINKS"
Gnosis.L["TabCapBOTTOMRIGHT"] = "UNTEN RECHTS"
Gnosis.L["TabCapCENTER"] = "MITTE"
Gnosis.L["TabCapLEFT"] = "LINKS"
Gnosis.L["TabCapNONE"] = "KEINS"
Gnosis.L["TabCapRIGHT"] = "RECHTS"
Gnosis.L["TabCapTOP"] = "OBEN"
Gnosis.L["TabCapTOPLEFT"] = "OBEN LINKS"
Gnosis.L["TabCapTOPRIGHT"] = "OBEN RECHTS"
Gnosis.L["TabCastbars"] = "Leistenkonfiguration"
Gnosis.L["TabChanneledSpells"] = "Kanalisierte Zauber"
Gnosis.L["TabConfig"] = "Konfigurationen (Profile)"
Gnosis.L["TabCTClipTest"] = "Kampftext/Cliptest"
Gnosis.L["TabFreeAlign"] = "Freie Anordnung"
Gnosis.L["TabNameTime"] = "Name...Zeit"
Gnosis.L["TabTimeName"] = "Zeit...Name"
Gnosis.L["Vertical"] = "Vertikal"
Gnosis.L["Yes"] = "Ja"

elseif (self.s.strLocale == "zhCN") then
-- zhCN locale (simplified chinese)
Gnosis.L["AddonName"] = "Gnosis"
Gnosis.L["BT_Castbar"] = "施法条"
Gnosis.L["BT_MSTimer"] = "多法术计时器"
Gnosis.L["CBSetFocus"] = "焦点"
Gnosis.L["CBSetGCD"] = "公共CD"
Gnosis.L["CBSetMirror"] = "镜像"
Gnosis.L["CBSetPet"] = "宠物载具"
Gnosis.L["CBSetPlayer"] = "玩家"
Gnosis.L["CBSetSwing"] = "攻击"
Gnosis.L["CBSetTarget"] = "目标"
Gnosis.L["CpyScriptFromEditBox"] = "拷贝代码自编辑框 (|cffffff7f%s|r)."
Gnosis.L["Horizontal"] = "水平"
Gnosis.L["IfCCSetup"] = "创建普通格局"
Gnosis.L["IfCCSString"] = [=[Gnosis can create a common castbar setup for you (bars for Player, Target, Focus, Mirror and Pet/Vehicle). The created bars will be unlocked and can be moved by dragging while holding down the left mouse button. Right clicking the bars will call the castbar configuration gui.

You should lock the bars when you are finished with moving and customizing. Both blizzard castbar and mirror castbar will be deactivated. You can also create a "Global Cooldown Indicator" and a "Swing Timer" (one handed melee and range including wand) by pressing the button below. The slash command to call the Gnosis gui is "/gnosis".
]=] -- Requires localization
Gnosis.L["IfCCTimers"] = "创建公共CD/攻击计时器"
Gnosis.L["IfConfigs"] = "配置"
Gnosis.L["IfCWAction"] = "按下按钮后没有任何操作关闭框体" -- Needs review
Gnosis.L["IfLFConigs"] = [=[
One or more stored configurations have been found. You can setup Gnosis by loading from any existing configuration, just press any of the buttons below (button name is the name of the configuration that will be loaded).
]=] -- Requires localization
Gnosis.L["IfNoCBs"] = "没有找到施法条" -- Needs review
Gnosis.L["IfOpenGUI"] = "打开图形化配置界面"
Gnosis.L["Import"] = "导入"
Gnosis.L["ImportFromHyperlink"] = "Import bar configuration? If the bar already exists, it's configuration values will be overwritten." -- Requires localization
Gnosis.L["ImportKeepPos"] = "Import, keep position" -- Requires localization
Gnosis.L["MsgBlizCBIsDis"] = "暴雪施法条已经被其他插件所隐藏"
Gnosis.L["MsgBlizCBRestored"] = "暴雪施法条恢复 (详见图形配置界面选项)"
Gnosis.L["MsgDis"] = "(已禁用)"
Gnosis.L["MsgDisBlizCB"] = "禁用暴雪施法条 (详见图形配置界面选项)"
Gnosis.L["MsgDisMirrCB"] = "禁用默认镜像计时器 (详见图形配置界面选项)"
Gnosis.L["MsgDisPetCB"] = "禁用暴雪宠物/载具施法条 (见图形配置界面选项)"
Gnosis.L["MsgEn"] = "(已启用)"
Gnosis.L["MsgLoaded"] = "已加载"
Gnosis.L["MsgMirrCBIsDis"] = "默认镜像计时器已经被其他插件所隐藏"
Gnosis.L["MsgMirrCBRestored"] = "默认镜像计时器恢复 (详见图形配置界面选项)"
Gnosis.L["MsgPetCBIsDis"] = "暴雪宠物/载具施法条已被其他插件隐藏"
Gnosis.L["MsgPetCBRestored"] = "暴雪宠物/载具施法条已恢复 (见图形配置界面选项)"
Gnosis.L["No"] = "否"
Gnosis.L["NoImport"] = "不导入"
Gnosis.L["OptAddonDisabled_Name"] = "插件已禁用, 启用来访问当前配置标签."
Gnosis.L["OptAddonEnable_Desc"] = "开启或关闭 Gnosis"
Gnosis.L["OptAddonEnable_Name"] = "启用插件"
Gnosis.L["OptBarXYcoordDesc"] = "x,y-坐标"
Gnosis.L["OptBarXYcoordName"] = "施法条位置: x, y"
Gnosis.L["OptCBActiveSpec"] = "为天赋类型启用"
Gnosis.L["OptCBAddListElem"] = "增加条目"
Gnosis.L["OptCBAdjIcon"] = "调整图标位置 (当解锁时)"
Gnosis.L["OptCBAdjLatTextCoord"] = "调整延迟文字位置"
Gnosis.L["OptCBAdjNamePos"] = "调整名字位置"
Gnosis.L["OptCBAlignName"] = "对齐施法名"
Gnosis.L["OptCBAlignTime"] = "对齐施法时间"
Gnosis.L["OptCBAlignTimeCoord"] = "调整时间位置"
Gnosis.L["OptCBAlpha"] = "施法条透明度"
Gnosis.L["OptCBAnc"] = "锚点"
Gnosis.L["OptCBAncBarAncPnt"] = "Gnosis 施法条锚点定位"
Gnosis.L["OptCBAncFrameAncPnt"] = "锚点框体定位"
Gnosis.L["OptCBAncFrameName"] = "锚点到框体"
Gnosis.L["OptCBAncNoAnc"] = "没有锚点"
Gnosis.L["OptCBAncOffset"] = "偏移 x,y"
Gnosis.L["OptCBAncToCursor"] = "锚点到鼠标"
Gnosis.L["OptCBAncToFrame"] = "锚点到框体"
Gnosis.L["OptCBAncType"] = "锚点类型"
Gnosis.L["OptCBBarType"] = "条类型"
Gnosis.L["OptCBBorderCol"] = "边框颜色"
Gnosis.L["OptCBBorderColInt"] = "边框颜色 (不可打断)"
Gnosis.L["OptCBBorderSize"] = "边框大小"
Gnosis.L["OptCBBorderTex_D"] = "Additional border texture of fixed size. You might want to unlock the icon and reduce the normal border size to 0 when using additional border textures. This border texture will not affect the icon border." -- Requires localization
Gnosis.L["OptCBBorderTex_N"] = "额外边框材质" -- Needs review
Gnosis.L["OptCBBWListedSpells"] = "黑/白名单中列表的法术" -- Needs review
Gnosis.L["OptCBCBBgCol"] = "施法条背景颜色"
Gnosis.L["OptCBCBColFail"] = "施法条颜色 (失败)"
Gnosis.L["OptCBCBColInt"] = "施法条颜色 (打断)"
Gnosis.L["OptCBCBColor"] = "施法条颜色"
Gnosis.L["OptCBCBNIColor"] = "施法条颜色 (非可打断)" -- Needs review
Gnosis.L["OptCBCBShColor"] = "文字隐隐颜色"
Gnosis.L["OptCBCBSucColor"] = "施法成功 (施法条颜色)"
Gnosis.L["OptCBCenterCB"] = "居中施法条"
Gnosis.L["OptCBChannelsAsNormal"] = "Invert 'channeled' bar growth (most timer bars)" -- Requires localization
Gnosis.L["OptCBCombatSelAlways"] = "进入和脱离战斗"
Gnosis.L["OptCBCombatSelInC"] = "仅在战斗中"
Gnosis.L["OptCBCombatSelOoC"] = "仅脱离战斗"
Gnosis.L["OptCBCombSel"] = "显示施法条当"
Gnosis.L["OptCBCopyCB_D"] = "拷贝施法条, 请确保在新的施法条编辑框中输入一个可用的名字." -- Needs review
Gnosis.L["OptCBCopyCB_N"] = "拷贝施法条" -- Needs review
Gnosis.L["OptCBEnCastSucDesc"] = "当成功施法完成时候改变颜色"
Gnosis.L["OptCBEnCastSucName"] = "启用成功施法"
Gnosis.L["OptCBEnCB"] = "启用施法条" -- Needs review
Gnosis.L["OptCBEnList"] = "启用/禁用黑-白名单"
Gnosis.L["OptCBEnShCol"] = "启用文字阴影颜色"
Gnosis.L["OptCBExportBar"] = "导出施法条" -- Needs review
Gnosis.L["OptCBExportBarChatlink_D"] = "Requires the chat frame's edit box to be shown." -- Requires localization
Gnosis.L["OptCBExportBarChatlink_N"] = "Paste import link to chat" -- Requires localization
Gnosis.L["OptCBExtendChannels_D"] = "Extend channeled spell while chain-casting same spell if recast before the last channel ended." -- Requires localization
Gnosis.L["OptCBExtendChannels_N"] = "Extend channels" -- Requires localization
Gnosis.L["OptCBFadeout"] = "淡出时间"
Gnosis.L["OptCBFillAtEnd"] = "当施法结束时填充施法条"
Gnosis.L["OptCBFixLatBox"] = "非玩家跳数框精确尺寸 [% 施法条]"
Gnosis.L["OptCBFont"] = "字体"
Gnosis.L["OptCBFontOutline"] = "字体描边"
Gnosis.L["OptCBFontSizeLat"] = "延迟字体大小 (0=自动)"
Gnosis.L["OptCBFontSizeName"] = "名字字体大小 (0=自动)"
Gnosis.L["OptCBFontSizeTime"] = "时间字体大小 (0=自动)"
Gnosis.L["OptCBForceLatAlign"] = "强制延迟对齐"
Gnosis.L["OptCBFrameStrata"] = "框体层级"
Gnosis.L["OptCBGroupSelAlways"] = "独自战斗, 在队伍或团队 (总是)"
Gnosis.L["OptCBGroupSelPartyNotRaid"] = "在小队, 不在团队"
Gnosis.L["OptCBGroupSelRaid"] = "在团队队伍"
Gnosis.L["OptCBGroupSelSolo"] = "独自战斗, 不在团队"
Gnosis.L["OptCBIconBorderSize"] = "图标边框 (当解锁时)"
Gnosis.L["OptCBInstanceSelAlways"] = "inside or outside instance (always)" -- Requires localization
Gnosis.L["OptCBInstanceSelArena"] = "in arena" -- Requires localization
Gnosis.L["OptCBInstanceSelBattleground"] = "in battleground" -- Requires localization
Gnosis.L["OptCBInstanceSelFiveMan"] = "in 5-man instance" -- Requires localization
Gnosis.L["OptCBInstanceSelInside"] = "inside instance" -- Requires localization
Gnosis.L["OptCBInstanceSelOutside"] = "outside instance" -- Requires localization
Gnosis.L["OptCBInstanceSelRaid"] = "in raid instance" -- Requires localization
Gnosis.L["OptCBInvBarDir"] = "反转施法条方向"
Gnosis.L["OptCBLatBoxCol"] = "延迟框颜色"
Gnosis.L["OptCBListBlack"] = "黑名单"
Gnosis.L["OptCBListNeither"] = "都"
Gnosis.L["OptCBListWhite"] = "白名单"
Gnosis.L["OptCBLockAll_D"] = "Lock all bars" -- Requires localization
Gnosis.L["OptCBLockAll_N"] = "Lock" -- Requires localization
Gnosis.L["OptCBMaxLatBox"] = "延迟框最大尺寸 [% 施法条]"
Gnosis.L["OptCBNewCB_D"] = "创建新的施法条必须给出一个可用的施法条名" -- Needs review
Gnosis.L["OptCBNewCB_N"] = "新的施法条" -- Needs review
Gnosis.L["OptCBNewCBName_D"] = "创建新的施法条前请输入可用的施法条名字"
Gnosis.L["OptCBNewListElem_D"] = [=[Castbars:
Enter names of spells to black- or whitelist.

Multi-Spell Timer:
Basic format for every entry: cmds:spell/effect/item

More info @ Gnosis' description page at curse.com or in the .pdf which can be found in your WoW Folder/Addons/Gnosis (not yet done).]=] -- Needs review
Gnosis.L["OptCBNewListElem_N"] = "输入要添加的法术名"
Gnosis.L["OptCBOrient"] = "方向"
Gnosis.L["OptCBRelSel"] = "Show casts of" -- Requires localization
Gnosis.L["OptCBRelSelAll"] = "所有单位"
Gnosis.L["OptCBRelSelEnemy"] = "敌对单位"
Gnosis.L["OptCBRelSelFriendly"] = "友方单位"
Gnosis.L["OptCBRemCB"] = "移除施法条" -- Needs review
Gnosis.L["OptCBRemListElem"] = "移除当前条目"
Gnosis.L["OptCBRotIcon"] = "循环图标 (°)"
Gnosis.L["OptCBRotLatencyN"] = "循环延迟"
Gnosis.L["OptCBRotNameD"] = "当使用后强制自由对齐"
Gnosis.L["OptCBRotNameN"] = "循环名字"
Gnosis.L["OptCBRotTimeN"] = "循环时间"
Gnosis.L["OptCBScaleBar"] = "缩放施法条"
Gnosis.L["OptCBScaleIcon"] = "缩放图标 (当解锁时)"
Gnosis.L["OptCBShowChanTicks"] = "显示通道法术跳数"
Gnosis.L["OptCBShowIcon"] = "显示施法图标"
Gnosis.L["OptCBShowLatBox"] = "显示延迟框"
Gnosis.L["OptCBShowShield"] = "为不可打断施法显示盾形图标"
Gnosis.L["OptCBShowSpark"] = "显示施法条火花"
Gnosis.L["OptCBSizeGrp"] = "施法条外观和可见性"
Gnosis.L["OptCBSparkColor"] = "火花颜色"
Gnosis.L["OptCBSparkHeight"] = "火花高"
Gnosis.L["OptCBSparkWidth"] = "火花宽"
Gnosis.L["OptCBSWNC"] = "当不施法时也显示"
Gnosis.L["OptCBTabColors"] = "颜色"
Gnosis.L["OptCBTabHide"] = "隐藏施法条"
Gnosis.L["OptCBTabText"] = "文字"
Gnosis.L["OptCBTextAlignment"] = "对齐 (名字到时间)"
Gnosis.L["OptCBTextColLat"] = "文字颜色 (延迟)"
Gnosis.L["OptCBTextColName"] = "文字颜色 (名字)"
Gnosis.L["OptCBTextColPB"] = "文字颜色 (打退)"
Gnosis.L["OptCBTextColTime"] = "文字颜色 (时间)"
Gnosis.L["OptCBTexture"] = "施法条材质"
Gnosis.L["OptCBUnit"] = "单位"
Gnosis.L["OptCBUnl_D"] = "解锁施法条 (总是显示)"
Gnosis.L["OptCBUnl_N"] = "解锁施法条" -- Needs review
Gnosis.L["OptCBUnlockAll_D"] = "Unlock all bars. Disabled bars or bars selected for another talent specialization will be unlocked but will still not be visible." -- Requires localization
Gnosis.L["OptCBUnlockAll_N"] = "Unlock" -- Requires localization
Gnosis.L["OptCBUnlockIcon_D"] = "从施法条上解锁图标"
Gnosis.L["OptCBUnlockIcon_N"] = "解锁图标"
Gnosis.L["OptCBWordWrapD"] = "Allow text to wrap to additional lines" -- Requires localization
Gnosis.L["OptCBWordWrapN"] = "Allow word wrap" -- Requires localization
Gnosis.L["OptCHCastnameGrp"] = "施法名字选项"
Gnosis.L["OptCHCasttimeGrp"] = "施法时间选项"
Gnosis.L["OptClipWarn_Desc"] = "Warn when clipping shortly before channel tick occurs on non aoe channeled spells." -- Needs review
Gnosis.L["OptClipWarn_Name"] = "Clipping warning [ms]" -- Needs review
Gnosis.L["OptCombTicks"] = "合并跳数并通过战斗文字输出"
Gnosis.L["OptConfDelConf"] = "移除配置"
Gnosis.L["OptConfDelConfMBText"] = "确定要删除配置  |cffffff7f%s|r?"
Gnosis.L["OptConfLoadCBs"] = "加载施法条"
Gnosis.L["OptConfLoadChan"] = "加载通道法术"
Gnosis.L["OptConfLoadCT"] = "加载战斗文字/cliptest 设置"
Gnosis.L["OptConfLoadMain"] = "加载主标签设置"
Gnosis.L["OptConfName"] = "配置名字"
Gnosis.L["OptConfSave"] = "保存配置"
Gnosis.L["OptConfStoreCBs"] = "储存施法条"
Gnosis.L["OptConfStoreChan"] = "储存通道法术数据"
Gnosis.L["OptConfStoreCT"] = "储存战斗文字/cliptest 设置"
Gnosis.L["OptConfStoreMain"] = "储存插件主配置标签设置"
Gnosis.L["OptConfUpdConf"] = "更新配置"
Gnosis.L["OptConfUpdConfMBText"] = "确定要更新配置 |cffffff7f%s|r (来启用设定)?"
Gnosis.L["OptCopytonewbarExists"] = "施法条已经存在, 不能拷贝"
Gnosis.L["OptCopytonewbarInvalidName"] = "拷贝到一个新的施法条前请输入可用的施法条名字"
Gnosis.L["OptCreateCBSet"] = "创建基础施法条 (快速启动)"
Gnosis.L["OptCreatenewbarExists"] = "施法条已经存在, 不能创建"
Gnosis.L["OptCreatenewbarInvalidName"] = "创建新的施法条前请输入可用的施法条名字"
Gnosis.L["OptCreateNewSpell"] = "创建新的法术"
Gnosis.L["OptCSFSClip"] = "字体大小 (clip, 0=预设)"
Gnosis.L["OptCSFSNonClip"] = "字体大小 (non clip, 0=预设)"
Gnosis.L["OptCSRemove"] = "移除法术"
Gnosis.L["OptCTO"] = "战斗文字输出"
Gnosis.L["OptCTO_Blizz"] = "暴雪浮动战斗文字"
Gnosis.L["OptCTO_MSBT"] = "Mik's Scrolling Battle Text"
Gnosis.L["OptCTO_Parrot"] = "Parrot"
Gnosis.L["OptCTO_SCT"] = "Scrolling Combat Text"
Gnosis.L["OptEn"] = "启用"
Gnosis.L["OptEnAutoCreateOptons"] = "启动时自动创建选项表格"
Gnosis.L["OptEnClipTest"] = "Enable clip test" -- Needs review
Gnosis.L["OptExportAllBars"] = "Export all bars" -- Requires localization
Gnosis.L["OptFile"] = "File" -- Requires localization
Gnosis.L["OptFirstStartFrame"] = "打开初始开始框体"
Gnosis.L["OptFirstTickInst"] = "首跳为瞬发"
Gnosis.L["OptFontEnShOffset"] = "启用特殊阴影偏移"
Gnosis.L["OptFontResizeLongName"] = "重定义长字符大小"
Gnosis.L["OptFontShOffsetXYDesc"] = "配置文字和阴影文字之间的偏移量"
Gnosis.L["OptFontShOffsetXYName"] = "阴影偏移 x,y"
Gnosis.L["OptHasteAddsTicks"] = "法术急速增加跳数"
Gnosis.L["OptHeight"] = "高"
Gnosis.L["OptHideAddonMsgs"] = "隐藏 Gnosis 文字信息"
Gnosis.L["OptHideBlizzCB"] = "隐藏暴雪施法条"
Gnosis.L["OptHidecasttime"] = "隐藏剩余施法时间"
Gnosis.L["OptHidecasttimeTotal"] = "隐藏总施法时间"
Gnosis.L["OptHideMirrorCB"] = "隐藏暴雪镜像计时条"
Gnosis.L["OptHideNonPlayerTicks"] = "在非玩家施法条上隐藏跳数"
Gnosis.L["OptHidePetCB"] = "隐藏暴雪的宠物/载具施法条"
Gnosis.L["OptHidepushbackTime"] = "隐藏施法打退时间"
Gnosis.L["OptImportBar"] = "导入施法条 (重载界面)" -- Needs review
Gnosis.L["OptLoadOptionsButtonDesc"] = "Option tables have not yet been created to reduce Gnosis' memory footprint. After loading you can select to automatically create options tables the next time you start wow (or reload the ui)." -- Requires localization
Gnosis.L["OptLoadOptionsButtonName"] = "创建选项..."
Gnosis.L["OptLocale"] = "选择本地化文件"
Gnosis.L["OptMergetradeskillDesc"] = "合并交易技能 (仅玩家施法条)."
Gnosis.L["OptMergetradeskillName"] = "合并交易技能"
Gnosis.L["OptMusic"] = "音乐"
Gnosis.L["OptNameFormatStringDesc"] = [=[输入字符用来显示为名字

name: 法术名
abbr<cnt>: 缩写法术名如果字符长于一个数值, 除非和名字想通
rank<text>: 如果等级可用显示等级文字
misc: 如果没有等级则显示多种信息
arabic: 等级显示为阿拉伯数字 (e.g. 13)
roman: 等级显示为罗马数字 (e.g. XIII)
txr<text>: 如果等级信息可用显示等级文字
txm<text>: 如果多种信息可用显示多种信息文字
target: 如果可用显示目标名字 (仅玩家)
tar<text>: 如果目标信息可用显示目标信息文字 (仅玩家)
who: show name of casting unit

col<r,g,b[,a]>: e.g. col<1.0,1.0,0.0> 来改变颜色
col<school>: 法术伤害类型是暗影, 奥术...
col<pre>: 修改颜色为上一个

tscur: 显示剩余的商业技能物品计数
tstot: 显示总的商业技能物品计数
txts<text>: 如果商业技能信息可用显示文字

\n: force new line]=] -- Needs review
Gnosis.L["OptNameFormatStringName"] = "名字格式字符"
Gnosis.L["OptNameFormatToggleDesc"] = "如果启用则 '显示施法名' 和 '显示施法等级' 选项将被忽略."
Gnosis.L["OptNameFormatToggleName"] = "启用名字格式字符Enable name format string"
Gnosis.L["OptOutputString"] = "输出字符"
Gnosis.L["OptOutputStringDesc"] = [=[Enter string to show as combat text output

spellname: name of channeled spell
dmg: amount of dmg or heal done by channel
eh: effective heal (= heal-overheal)
oh: overheal
dps: dps or hps of channel
target: target name of channel
clipped: information whether unintentional clip occured
cliptext<your text>: text string that replaces clipped if needed

hits: number of hits
crits: number of crits
ticks: number of ticks
tickscrits: outputs number of ticks and crits

above use following identifiers which are added to the displayed numbers
hittext<your text>: identifier for hits
crittext<your text>: identifier for crits
ticktext<your text>: identifier for ticks

col<r,g,b[,a]>: e.g. col<1.0,1.0,0.0> to change color
col<school>: where school is shadow,arcane...
col<pre>: change color to previous one
col<class>: change color to target class color (if available)
col<cpre>: revert to previous color (if target class color is available)]=] -- Requires localization
Gnosis.L["OptPFoC"] = "Play file on clip" -- Requires localization
Gnosis.L["OptPlayFile"] = "Play custom file" -- Requires localization
Gnosis.L["OptPlayMusic"] = "播放音乐文件" -- Needs review
Gnosis.L["OptPlaySnd"] = "播放音效"
Gnosis.L["OptPlayTickSound_D"] = "Deactivates clipping sound." -- Requires localization
Gnosis.L["OptPlayTickSound_N"] = "播放跳数音效" -- Needs review
Gnosis.L["OptPMoC"] = "Play music on clip" -- Needs review
Gnosis.L["OptPSoC"] = "Play sound on clip" -- Needs review
Gnosis.L["OptResetPlayerData"] = "重置玩家数据 (重载界面)"
Gnosis.L["OptResizeOptions"] = "Resize interface options frame on startup" -- Requires localization
Gnosis.L["OptSaveconfigExists"] = "配置已经存在, 请首先删除或者改名"
Gnosis.L["OptSaveconfigInvalidName"] = "没有给出配置名"
Gnosis.L["OptShowasminutesDesc"] = "如果时间长于60秒则显示分钟."
Gnosis.L["OptShowasminutesName"] = "显示分钟"
Gnosis.L["OptShowCastNameDesc"] = "如果名字格式字符启用选项将不可用."
Gnosis.L["OptShowCastNameName"] = "显示施法名"
Gnosis.L["OptShowCastRankDesc"] = "如果名字格式字符启用选项将不可用."
Gnosis.L["OptShowCastRankName"] = "显示施法等级"
Gnosis.L["OptShowPlayerLatency"] = "显示玩家延迟 (ms)"
Gnosis.L["OptShowSpellIcon"] = "显示法术图标"
Gnosis.L["OptSnd"] = "音效"
Gnosis.L["OptSpellIsAoE"] = "法术命中多个目标"
Gnosis.L["OptSpellNameOrId"] = "法术名或法术ID"
Gnosis.L["OptStickyClips"] = "Sticky clips" -- Needs review
Gnosis.L["OptStrGapDesc"] = "施法名和时间之间的最小间隔 (来决定是否重定义长字符的大小)."
Gnosis.L["OptStrGapName"] = "间隔 (名字...时间)"
Gnosis.L["OptTablesUnloaded_Name"] = "选项表格还未被创建"
Gnosis.L["OptTicksToShow"] = "要显示的跳数"
Gnosis.L["OptTimeFormatStringDesc"] = [=[输入字符用来显示为时间

r<x>: 剩余时间用 X 个小数位按秒来显示
t<x>: 总时间用 X 个小数位按秒来显示
p<x>: 打退时间用 X 个小数位按秒来显示

增加 s 为施法吟唱 或 m 为显示时间 > 60秒的法术
e.g. r<1m> 或 p<2s>
add p to show value in percent
e.g. r<p>% / t<1p>%

col<r,g,b[,a]>: e.g. col<1.0,1.0,0.0> 来修改颜色
col<school>: 法术伤害类型是暗影, 奥术...
col<pre>: 修改颜色为上一个

\n: force new line

remark: 使用 col<r,g,b> 来修改法术打退的颜色如果需要的话]=] -- Needs review
Gnosis.L["OptTimeFormatStringName"] = "时间格式字符"
Gnosis.L["OptTimeFormatToggleDesc"] = "如果启用则所有其他时间格式选项将被忽略."
Gnosis.L["OptTimeFormatToggleName"] = "开启时间格式字符"
Gnosis.L["OptTimerScanEveryN"] = "每 [毫秒] 刷新计时器侦测"
Gnosis.L["OptTotTicks"] = "总跳数"
Gnosis.L["OptWfCL_Desc"] = "Delay output/clip test after output/clip test request for given time in ms to account for possible combat log delay." -- Needs review
Gnosis.L["OptWfCL_Name"] = "等待战斗记录 [ms]"
Gnosis.L["OptWidth"] = "宽"
Gnosis.L["PasteScript"] = "粘贴代码到编辑框." -- Needs review
Gnosis.L["PremadeNfs1"] = "cast |cffff0000(rank or misc, e.g. stacks)|r (tradeskill merge)" -- Requires localization
Gnosis.L["PremadeNfs2"] = "cast |cffff0000(aura effect value)|r" -- Requires localization
Gnosis.L["PremadeNfs3"] = "|cffffff00unit name|r: cast" -- Requires localization
Gnosis.L["PremadeTfs1"] = "|cffff0000pushback|r remaining / total, e.g. |cffff0000+1.0|r 1.4 / 3.00" -- Requires localization
Gnosis.L["PremadeTfs2"] = "|cffff0000pushback|r remaining / total, same as above but without minutes display" -- Requires localization
Gnosis.L["PremadeTfs3"] = "remaining / total, higher precision, e.g. 1.45 / 3.000" -- Requires localization
Gnosis.L["SelPremadeStr"] = "Select premade string" -- Requires localization
Gnosis.L["Strata_BACK"] = "最低"
Gnosis.L["Strata_DIALOG"] = "最高"
Gnosis.L["Strata_HIGH"] = "高"
Gnosis.L["Strata_LOW"] = "低"
Gnosis.L["Strata_MEDIUM"] = "中等"
Gnosis.L["TabAdaptToCT"] = "自适应施法类型"
Gnosis.L["TabCapBOTTOM"] = "底部" -- Needs review
Gnosis.L["TabCapBOTTOMLEFT"] = "底部左侧" -- Needs review
Gnosis.L["TabCapBOTTOMRIGHT"] = "底部右侧" -- Needs review
Gnosis.L["TabCapCENTER"] = "中"
Gnosis.L["TabCapLEFT"] = "左"
Gnosis.L["TabCapNONE"] = "无"
Gnosis.L["TabCapRIGHT"] = "右"
Gnosis.L["TabCapTOP"] = "TOP" -- Requires localization
Gnosis.L["TabCapTOPLEFT"] = "TOPLEFT" -- Requires localization
Gnosis.L["TabCapTOPRIGHT"] = "TOPRIGHT" -- Requires localization
Gnosis.L["TabCastbars"] = "施法条" -- Needs review
Gnosis.L["TabChanneledSpells"] = "通道法术"
Gnosis.L["TabConfig"] = "配置" -- Needs review
Gnosis.L["TabCTClipTest"] = "战斗文字/Cliptest"
Gnosis.L["TabFreeAlign"] = "自由对齐"
Gnosis.L["TabNameTime"] = "名字...时间"
Gnosis.L["TabTimeName"] = "时间...名字"
Gnosis.L["Vertical"] = "垂直"
Gnosis.L["Yes"] = "是"

elseif (self.s.strLocale == "zhTW") then
-- zhTW locale (traditional chinese)
Gnosis.L["AddonName"] = "Gnosis"
Gnosis.L["BT_Castbar"] = "施法條"
Gnosis.L["BT_MSTimer"] = "多法術時間"
Gnosis.L["CBSetFocus"] = "焦點"
Gnosis.L["CBSetGCD"] = "共用冷卻時間"
Gnosis.L["CBSetMirror"] = "鏡像"
Gnosis.L["CBSetPet"] = "寵物載具"
Gnosis.L["CBSetPlayer"] = "玩家"
Gnosis.L["CBSetSwing"] = "武器揮擊"
Gnosis.L["CBSetTarget"] = "目標"
Gnosis.L["CpyScriptFromEditBox"] = "從編輯框 (|cffffff7f%s|r) 複製腳本。"
Gnosis.L["Horizontal"] = "水平"
Gnosis.L["IfCCSetup"] = "產生泛用設定"
Gnosis.L["IfCCSString"] = [=[Gnosis 可以為您產生一個泛用的施法條設定方式 (包括 "player", "target", "focus", "mirror" , 還有 "pet=vehicle")。用此方法下產生之施法條可以用滑鼠左鍵拖曳其位置。 滑鼠右鍵則可以帶出施法條的選項視窗。 

您必須在設定好施法條位置以及其選項之後作"鎖定施法條"的動作。 此舉也會將遊戲預設的施法條停用。 您可以對UI中 "gcd", "gcd_reverse" 及 "*swing"的項目，設立共用冷卻時間以及武器揮擊的指示條。Gnosis 的對話框指令為 "/gnosis"。]=] -- Needs review
Gnosis.L["IfCCTimers"] = "產生 共用冷卻時間/武器揮擊 間隔指示條"
Gnosis.L["IfConfigs"] = "設定組態"
Gnosis.L["IfCWAction"] = "按下此按鈕，即不做任何動作並關閉視窗"
Gnosis.L["IfLFConigs"] = "搜尋到一個或者以上的設定好的組態，您可以讀取任何已存在的組態來設定Gnosis，下列按鈕即為設定好之組態(按鈕名稱為組態名稱)，按下按鈕即可用該名稱對應之組態來設定您的Gnosis。"
Gnosis.L["IfNoCBs"] = "沒有任何施法條" -- Needs review
Gnosis.L["IfOpenGUI"] = "開啟選項視窗"
Gnosis.L["Import"] = "匯入"
Gnosis.L["ImportFromHyperlink"] = "Import bar configuration? If the bar already exists, it's configuration values will be overwritten." -- Requires localization
Gnosis.L["ImportKeepPos"] = "Import, keep position" -- Requires localization
Gnosis.L["MsgBlizCBIsDis"] = "暴雪施法條已經被其他插件所隱藏"
Gnosis.L["MsgBlizCBRestored"] = "暴雪施法條恢復 (詳見圖形配置界面選項)"
Gnosis.L["MsgDis"] = "(已禁用)"
Gnosis.L["MsgDisBlizCB"] = "禁用暴雪施法條 (詳見圖形配置界面選項)"
Gnosis.L["MsgDisMirrCB"] = "禁用默認鏡像計時器 (詳見圖形配置界面選項)"
Gnosis.L["MsgDisPetCB"] = "禁用暴雪寵物/載具施法條 (見圖形選項介面)"
Gnosis.L["MsgEn"] = "(已啟用)"
Gnosis.L["MsgLoaded"] = "已加載"
Gnosis.L["MsgMirrCBIsDis"] = "默認鏡像計時器已經被其他插件所隱藏"
Gnosis.L["MsgMirrCBRestored"] = "默認鏡像計時器恢復 (詳見圖形配置界面選項)"
Gnosis.L["MsgPetCBIsDis"] = "暴雪寵物/載具施法條已被其他插件隱藏"
Gnosis.L["MsgPetCBRestored"] = "暴雪寵物/載具施法條已恢復 (見圖形選項介面)"
Gnosis.L["No"] = "否"
Gnosis.L["NoImport"] = "不要匯入"
Gnosis.L["OptAddonDisabled_Name"] = "插件已禁用, 啟用來訪問當前配置標簽."
Gnosis.L["OptAddonEnable_Desc"] = "開啟或關閉 Gnosis"
Gnosis.L["OptAddonEnable_Name"] = "啟用插件"
Gnosis.L["OptBarXYcoordDesc"] = "x,y-坐標"
Gnosis.L["OptBarXYcoordName"] = "施法條位置: x, y"
Gnosis.L["OptCBActiveSpec"] = "依天賦規則啟用"
Gnosis.L["OptCBAddListElem"] = "增加條目"
Gnosis.L["OptCBAdjIcon"] = "調整圖標位置 (當解鎖時)"
Gnosis.L["OptCBAdjLatTextCoord"] = "調整延遲文字位置"
Gnosis.L["OptCBAdjNamePos"] = "調整名字位置"
Gnosis.L["OptCBAlignName"] = "對齊施法名"
Gnosis.L["OptCBAlignTime"] = "對齊施法時間"
Gnosis.L["OptCBAlignTimeCoord"] = "調整時間位置"
Gnosis.L["OptCBAlpha"] = "施法條透明度"
Gnosis.L["OptCBAnc"] = "錨點"
Gnosis.L["OptCBAncBarAncPnt"] = "Gnosis施法條錨點定位"
Gnosis.L["OptCBAncFrameAncPnt"] = "錨點框體定位"
Gnosis.L["OptCBAncFrameName"] = "定位到框體"
Gnosis.L["OptCBAncNoAnc"] = "沒有錨點"
Gnosis.L["OptCBAncOffset"] = "偏移 X,Y"
Gnosis.L["OptCBAncToCursor"] = "定位到滑鼠"
Gnosis.L["OptCBAncToFrame"] = "定位到框體"
Gnosis.L["OptCBAncType"] = "錨點類型"
Gnosis.L["OptCBBarType"] = "Bartype" -- Requires localization
Gnosis.L["OptCBBorderCol"] = "邊框顏色"
Gnosis.L["OptCBBorderColInt"] = "邊框顏色 (不可打斷)"
Gnosis.L["OptCBBorderSize"] = "邊框大小"
Gnosis.L["OptCBBorderTex_D"] = "Additional border texture of fixed size. You might want to unlock the icon and reduce the normal border size to 0 when using additional border textures. This border texture will not affect the icon border." -- Requires localization
Gnosis.L["OptCBBorderTex_N"] = "附加的邊框材質"
Gnosis.L["OptCBBWListedSpells"] = "黑/白名單中列表的法術" -- Needs review
Gnosis.L["OptCBCBBgCol"] = "施法條背景顏色"
Gnosis.L["OptCBCBColFail"] = "施法條顏色 (失敗)"
Gnosis.L["OptCBCBColInt"] = "施法條顏色 (打斷)"
Gnosis.L["OptCBCBColor"] = "施法條顏色"
Gnosis.L["OptCBCBNIColor"] = "施法條顏色 (無法斷法)"
Gnosis.L["OptCBCBShColor"] = "文字陰影顏色"
Gnosis.L["OptCBCBSucColor"] = "施法成功 (施法條顏色)"
Gnosis.L["OptCBCenterCB"] = "居中施法條"
Gnosis.L["OptCBChannelsAsNormal"] = "Invert 'channeled' bar growth (most timer bars)" -- Requires localization
Gnosis.L["OptCBCombatSelAlways"] = "進入或離開戰鬥"
Gnosis.L["OptCBCombatSelInC"] = "僅進入戰鬥"
Gnosis.L["OptCBCombatSelOoC"] = "僅離開戰鬥"
Gnosis.L["OptCBCombSel"] = "當...時顯示施法條"
Gnosis.L["OptCBCopyCB_D"] = "拷貝施法條, 請確保在新的施法條編輯框中輸入壹個可用的名字." -- Needs review
Gnosis.L["OptCBCopyCB_N"] = "拷貝施法條" -- Needs review
Gnosis.L["OptCBEnCastSucDesc"] = "修改當施法成功結束後的顏色"
Gnosis.L["OptCBEnCastSucName"] = "啟用成功施法"
Gnosis.L["OptCBEnCB"] = "啟用施法條" -- Needs review
Gnosis.L["OptCBEnList"] = "啟用/禁用黑-白名單"
Gnosis.L["OptCBEnShCol"] = "啟用文字陰影顏色"
Gnosis.L["OptCBExportBar"] = "匯出施法條" -- Needs review
Gnosis.L["OptCBExportBarChatlink_D"] = "Requires the chat frame's edit box to be shown." -- Requires localization
Gnosis.L["OptCBExportBarChatlink_N"] = "Paste import link to chat" -- Requires localization
Gnosis.L["OptCBExtendChannels_D"] = "Extend channeled spell while chain-casting same spell if recast before the last channel ended." -- Requires localization
Gnosis.L["OptCBExtendChannels_N"] = "Extend channels" -- Requires localization
Gnosis.L["OptCBFadeout"] = "淡出時間"
Gnosis.L["OptCBFillAtEnd"] = "當施法結束時填充施法條"
Gnosis.L["OptCBFixLatBox"] = "非玩家跳數框精確尺寸 [% 施法條]"
Gnosis.L["OptCBFont"] = "字型"
Gnosis.L["OptCBFontOutline"] = "字型描邊"
Gnosis.L["OptCBFontSizeLat"] = "延遲字型大小 (0=自動)"
Gnosis.L["OptCBFontSizeName"] = "名字字型大小 (0=自動)"
Gnosis.L["OptCBFontSizeTime"] = "時間字型大小 (0=自動)"
Gnosis.L["OptCBForceLatAlign"] = "強制延遲對齊"
Gnosis.L["OptCBFrameStrata"] = "框體層級"
Gnosis.L["OptCBGroupSelAlways"] = "Solo, 在小隊或團隊 (總是)"
Gnosis.L["OptCBGroupSelPartyNotRaid"] = "在小隊, 不在團隊"
Gnosis.L["OptCBGroupSelRaid"] = "在團隊隊伍"
Gnosis.L["OptCBGroupSelSolo"] = "Solo, 不在團隊"
Gnosis.L["OptCBIconBorderSize"] = "圖標邊框 (當解鎖時)"
Gnosis.L["OptCBInstanceSelAlways"] = "inside or outside instance (always)" -- Requires localization
Gnosis.L["OptCBInstanceSelArena"] = "in arena" -- Requires localization
Gnosis.L["OptCBInstanceSelBattleground"] = "in battleground" -- Requires localization
Gnosis.L["OptCBInstanceSelFiveMan"] = "in 5-man instance" -- Requires localization
Gnosis.L["OptCBInstanceSelInside"] = "inside instance" -- Requires localization
Gnosis.L["OptCBInstanceSelOutside"] = "outside instance" -- Requires localization
Gnosis.L["OptCBInstanceSelRaid"] = "in raid instance" -- Requires localization
Gnosis.L["OptCBInvBarDir"] = "反轉施法條方向"
Gnosis.L["OptCBLatBoxCol"] = "延遲框顏色"
Gnosis.L["OptCBListBlack"] = "黑名單"
Gnosis.L["OptCBListNeither"] = "都"
Gnosis.L["OptCBListWhite"] = "白名單"
Gnosis.L["OptCBLockAll_D"] = "Lock all bars" -- Requires localization
Gnosis.L["OptCBLockAll_N"] = "Lock" -- Requires localization
Gnosis.L["OptCBMaxLatBox"] = "延遲框最大尺寸 [% 施法條]"
Gnosis.L["OptCBNewCB_D"] = "創建新的施法條必須給出壹個可用的施法條名" -- Needs review
Gnosis.L["OptCBNewCB_N"] = "新的施法條" -- Needs review
Gnosis.L["OptCBNewCBName_D"] = "創建新的施法條前請輸入可用的施法條名字"
Gnosis.L["OptCBNewListElem_D"] = [=[Castbars:
Enter names of spells to black- or whitelist.

Multi-Spell Timer:
Basic format for every entry: cmds:spell/effect/item

More info @ Gnosis' description page at curse.com or in the .pdf which can be found in your WoW Folder/Addons/Gnosis (not yet done).]=] -- Needs review
Gnosis.L["OptCBNewListElem_N"] = "輸入要添加的法術名字"
Gnosis.L["OptCBOrient"] = "方向"
Gnosis.L["OptCBRelSel"] = "Show casts of" -- Requires localization
Gnosis.L["OptCBRelSelAll"] = "所有單位"
Gnosis.L["OptCBRelSelEnemy"] = "敵對"
Gnosis.L["OptCBRelSelFriendly"] = "友方"
Gnosis.L["OptCBRemCB"] = "移除施法條" -- Needs review
Gnosis.L["OptCBRemListElem"] = "移除當前條目"
Gnosis.L["OptCBRotIcon"] = "旋轉圖示"
Gnosis.L["OptCBRotLatencyN"] = "Rotate latency" -- Requires localization
Gnosis.L["OptCBRotNameD"] = "Forces free alignment if used" -- Requires localization
Gnosis.L["OptCBRotNameN"] = "Rotate name" -- Requires localization
Gnosis.L["OptCBRotTimeN"] = "Rotate time" -- Requires localization
Gnosis.L["OptCBScaleBar"] = "縮放施法條"
Gnosis.L["OptCBScaleIcon"] = "縮放圖標 (當解鎖時)"
Gnosis.L["OptCBShowChanTicks"] = "顯示通道法術跳數"
Gnosis.L["OptCBShowIcon"] = "顯示施法圖標"
Gnosis.L["OptCBShowLatBox"] = "顯示延遲框"
Gnosis.L["OptCBShowShield"] = "顯示無法斷法的盾牌"
Gnosis.L["OptCBShowSpark"] = "顯示施法條火花"
Gnosis.L["OptCBSizeGrp"] = "施法條形狀和視覺效果"
Gnosis.L["OptCBSparkColor"] = "火花顏色"
Gnosis.L["OptCBSparkHeight"] = "火花高"
Gnosis.L["OptCBSparkWidth"] = "火花寬"
Gnosis.L["OptCBSWNC"] = "當不施法時也顯示"
Gnosis.L["OptCBTabColors"] = "顏色"
Gnosis.L["OptCBTabHide"] = "隱藏施法條"
Gnosis.L["OptCBTabText"] = "文字"
Gnosis.L["OptCBTextAlignment"] = "對齊 (名字到時間)"
Gnosis.L["OptCBTextColLat"] = "文字顏色 (延遲)"
Gnosis.L["OptCBTextColName"] = "文字顏色 (名字)"
Gnosis.L["OptCBTextColPB"] = "文字顏色 (打退)"
Gnosis.L["OptCBTextColTime"] = "文字顏色 (時間)"
Gnosis.L["OptCBTexture"] = "施法條材質"
Gnosis.L["OptCBUnit"] = "單位"
Gnosis.L["OptCBUnl_D"] = "解鎖施法條 (總是顯示)"
Gnosis.L["OptCBUnl_N"] = "解鎖施法條" -- Needs review
Gnosis.L["OptCBUnlockAll_D"] = "Unlock all bars. Disabled bars or bars selected for another talent specialization will be unlocked but will still not be visible." -- Requires localization
Gnosis.L["OptCBUnlockAll_N"] = "Unlock" -- Requires localization
Gnosis.L["OptCBUnlockIcon_D"] = "從施法條上解鎖圖標"
Gnosis.L["OptCBUnlockIcon_N"] = "解鎖圖標"
Gnosis.L["OptCBWordWrapD"] = "Allow text to wrap to additional lines" -- Requires localization
Gnosis.L["OptCBWordWrapN"] = "Allow word wrap" -- Requires localization
Gnosis.L["OptCHCastnameGrp"] = "施法名稱選項"
Gnosis.L["OptCHCasttimeGrp"] = "施法時間選項"
Gnosis.L["OptClipWarn_Desc"] = "在非範圍作用之引導法術的第一跳之前，發出即將截短之警示"
Gnosis.L["OptClipWarn_Name"] = "Clipping warning [ms]" -- Needs review
Gnosis.L["OptCombTicks"] = "合並跳數並通過戰鬥文字輸出"
Gnosis.L["OptConfDelConf"] = "移除配置"
Gnosis.L["OptConfDelConfMBText"] = "是否要刪除設置 |cffffff7f%s|r？"
Gnosis.L["OptConfLoadCBs"] = "加載施法條"
Gnosis.L["OptConfLoadChan"] = "加載通道法術"
Gnosis.L["OptConfLoadCT"] = "加載戰鬥文字/cliptest 設定"
Gnosis.L["OptConfLoadMain"] = "加載主標簽設定"
Gnosis.L["OptConfName"] = "配置名字"
Gnosis.L["OptConfSave"] = "保存配置"
Gnosis.L["OptConfStoreCBs"] = "儲存施法條"
Gnosis.L["OptConfStoreChan"] = "儲存通道法術數據"
Gnosis.L["OptConfStoreCT"] = "儲存戰鬥文字/cliptest 設定"
Gnosis.L["OptConfStoreMain"] = "儲存插件主配置標簽設定"
Gnosis.L["OptConfUpdConf"] = "更新設置"
Gnosis.L["OptConfUpdConfMBText"] = "Sure to update configuration |cffffff7f%s|r (to active settings)?" -- Requires localization
Gnosis.L["OptCopytonewbarExists"] = "施法條已經存在, 不能拷貝"
Gnosis.L["OptCopytonewbarInvalidName"] = "拷貝到壹個新的施法條前請輸入可用的施法條名字"
Gnosis.L["OptCreateCBSet"] = "創建基礎施法條 (快速啟動)"
Gnosis.L["OptCreatenewbarExists"] = "施法條已經存在, 不能創建"
Gnosis.L["OptCreatenewbarInvalidName"] = "創建新的施法條前請輸入可用的施法條名字"
Gnosis.L["OptCreateNewSpell"] = "創建新的法術"
Gnosis.L["OptCSFSClip"] = "字型大小 (clip, 0=預設)"
Gnosis.L["OptCSFSNonClip"] = "字型大小 (non clip, 0=預設)"
Gnosis.L["OptCSRemove"] = "移除法術"
Gnosis.L["OptCTO"] = "戰鬥文字輸出"
Gnosis.L["OptCTO_Blizz"] = "暴雪浮動戰鬥文字"
Gnosis.L["OptCTO_MSBT"] = "Mik's Scrolling Battle Text"
Gnosis.L["OptCTO_Parrot"] = "Parrot"
Gnosis.L["OptCTO_SCT"] = "Scrolling Combat Text"
Gnosis.L["OptEn"] = "啟用"
Gnosis.L["OptEnAutoCreateOptons"] = "初始時自動創建選項表格"
Gnosis.L["OptEnClipTest"] = "Enable clip test" -- Needs review
Gnosis.L["OptExportAllBars"] = "Export all bars" -- Requires localization
Gnosis.L["OptFile"] = "File" -- Requires localization
Gnosis.L["OptFirstStartFrame"] = "打開初始使用框體"
Gnosis.L["OptFirstTickInst"] = "首跳為瞬發"
Gnosis.L["OptFontEnShOffset"] = "啟用特殊陰影偏移"
Gnosis.L["OptFontResizeLongName"] = "重定義長字符大小"
Gnosis.L["OptFontShOffsetXYDesc"] = "設置文字和文字陰影之間的偏移"
Gnosis.L["OptFontShOffsetXYName"] = "陰影偏移 X,Y"
Gnosis.L["OptHasteAddsTicks"] = "法術急速應用到跳數"
Gnosis.L["OptHeight"] = "高"
Gnosis.L["OptHideAddonMsgs"] = "隱藏 Gnosis 文字信息"
Gnosis.L["OptHideBlizzCB"] = "隱藏暴雪施法條"
Gnosis.L["OptHidecasttime"] = "隱藏剩余施法時間"
Gnosis.L["OptHidecasttimeTotal"] = "隱藏總施法時間"
Gnosis.L["OptHideMirrorCB"] = "隱藏暴雪鏡像計時條"
Gnosis.L["OptHideNonPlayerTicks"] = "隱藏非玩家施法條的跳數"
Gnosis.L["OptHidePetCB"] = "隱藏暴雪寵物/載具施法條"
Gnosis.L["OptHidepushbackTime"] = "隱藏施法打退時間"
Gnosis.L["OptImportBar"] = "匯入施法條 (重載介面)" -- Needs review
Gnosis.L["OptLoadOptionsButtonDesc"] = "Option tables have not yet been created to reduce Gnosis' memory footprint. After loading you can select to automatically create options tables the next time you start wow (or reload the ui)." -- Requires localization
Gnosis.L["OptLoadOptionsButtonName"] = "創建選項..."
Gnosis.L["OptLocale"] = "選擇本地化檔案"
Gnosis.L["OptMergetradeskillDesc"] = "合並交易技能 (僅玩家施法條)."
Gnosis.L["OptMergetradeskillName"] = "合並交易技能"
Gnosis.L["OptMusic"] = "音樂"
Gnosis.L["OptNameFormatStringDesc"] = [=[輸入字符用來顯示為名字

name: 法術名
abbr<cnt>: 縮寫法術名如果字符長於壹個數值, 除非和名字想通
rank<text>: 如果等級可用顯示等級文字
misc: 如果沒有等級則顯示多種信息
arabic: 等級顯示為阿拉伯數字 (e.g. 13)
roman: 等級顯示為羅馬數字 (e.g. XIII)
txr<text>: 如果等級信息可用顯示等級文字
txm<text>: 如果多種信息可用顯示多種信息文字
target: 如果可用顯示目標名字 (僅玩家)
tar<text>: 如果目標信息可用顯示目標信息文字 (僅玩家)
who: show name of casting unit

col<r,g,b[,a]>: e.g. col<1.0,1.0,0.0> 來改變顏色
col<school>: 法術傷害類型是暗影, 奧術...
col<pre>: 修改顏色為上壹個

tscur: 顯示剩余的商業技能物品計數
tstot: 顯示總的商業技能物品計數
txts<text>: 如果商業技能信息可用顯示文字

\n: force new line]=] -- Needs review
Gnosis.L["OptNameFormatStringName"] = "名字格式字符"
Gnosis.L["OptNameFormatToggleDesc"] = "如果啟用則 '顯示施法名' 和 '顯示施法等級' 選項將被忽略."
Gnosis.L["OptNameFormatToggleName"] = "啟用名字格式字符Enable name format string"
Gnosis.L["OptOutputString"] = "輸出字符"
Gnosis.L["OptOutputStringDesc"] = [=[Enter string to show as combat text output

spellname: name of channeled spell
dmg: amount of dmg or heal done by channel
eh: effective heal (= heal-overheal)
oh: overheal
dps: dps or hps of channel
target: target name of channel
clipped: information whether unintentional clip occured
cliptext<your text>: text string that replaces clipped if needed

hits: number of hits
crits: number of crits
ticks: number of ticks
tickscrits: outputs number of ticks and crits

above use following identifiers which are added to the displayed numbers
hittext<your text>: identifier for hits
crittext<your text>: identifier for crits
ticktext<your text>: identifier for ticks

col<r,g,b[,a]>: e.g. col<1.0,1.0,0.0> to change color
col<school>: where school is shadow,arcane...
col<pre>: change color to previous one
col<class>: change color to target class color (if available)
col<cpre>: revert to previous color (if target class color is available)]=] -- Requires localization
Gnosis.L["OptPFoC"] = "Play file on clip" -- Requires localization
Gnosis.L["OptPlayFile"] = "Play custom file" -- Requires localization
Gnosis.L["OptPlayMusic"] = "播放音樂檔案" -- Needs review
Gnosis.L["OptPlaySnd"] = "播放音效"
Gnosis.L["OptPlayTickSound_D"] = "Deactivates clipping sound." -- Requires localization
Gnosis.L["OptPlayTickSound_N"] = "Play tick sound" -- Requires localization
Gnosis.L["OptPMoC"] = "Play music on clip" -- Needs review
Gnosis.L["OptPSoC"] = "Play sound on clip" -- Needs review
Gnosis.L["OptResetPlayerData"] = "重置玩家數據 (重載界面)"
Gnosis.L["OptResizeOptions"] = "Resize interface options frame on startup" -- Requires localization
Gnosis.L["OptSaveconfigExists"] = "配置已經存在, 請首先刪除或者改名"
Gnosis.L["OptSaveconfigInvalidName"] = "沒有給出配置名"
Gnosis.L["OptShowasminutesDesc"] = "如果時間長於60秒則顯示分鐘."
Gnosis.L["OptShowasminutesName"] = "顯示分鐘"
Gnosis.L["OptShowCastNameDesc"] = "如果名字格式字符啟用選項將不可用."
Gnosis.L["OptShowCastNameName"] = "顯示施法名"
Gnosis.L["OptShowCastRankDesc"] = "如果名字格式字符啟用選項將不可用."
Gnosis.L["OptShowCastRankName"] = "顯示施法等級"
Gnosis.L["OptShowPlayerLatency"] = "顯示玩家延遲 (ms)"
Gnosis.L["OptShowSpellIcon"] = "顯示法術圖標"
Gnosis.L["OptSnd"] = "音效"
Gnosis.L["OptSpellIsAoE"] = "法術命中多個目標"
Gnosis.L["OptSpellNameOrId"] = "法術名或法術ID"
Gnosis.L["OptStickyClips"] = "Sticky clips" -- Needs review
Gnosis.L["OptStrGapDesc"] = "施法名和時間之間的最小間隔 (來決定是否重定義長字符的大小)."
Gnosis.L["OptStrGapName"] = "間隔 (名字...時間)"
Gnosis.L["OptTablesUnloaded_Name"] = "Option tables not yet created" -- Requires localization
Gnosis.L["OptTicksToShow"] = "要顯示的跳數"
Gnosis.L["OptTimeFormatStringDesc"] = [=[輸入字符用來顯示為時間

r<x>: 剩余時間用 X 個小數位按秒來顯示
t<x>: 總時間用 X 個小數位按秒來顯示
p<x>: 打退時間用 X 個小數位按秒來顯示

增加 s 為施法吟唱 或 m 為顯示時間 > 60秒的法術
e.g. r<1m> 或 p<2s>
add p to show value in percent
e.g. r<p>% / t<1p>%

col<r,g,b[,a]>: e.g. col<1.0,1.0,0.0> 來修改顏色
col<school>: 法術傷害類型是暗影, 奧術...
col<pre>: 修改顏色為上壹個

\n: force new line

remark: 使用 col<r,g,b> 來修改法術打退的顏色如果需要的話]=] -- Needs review
Gnosis.L["OptTimeFormatStringName"] = "時間格式字符"
Gnosis.L["OptTimeFormatToggleDesc"] = "如果啟用則所有其他時間格式選項將被忽略."
Gnosis.L["OptTimeFormatToggleName"] = "開啟時間格式字符"
Gnosis.L["OptTimerScanEveryN"] = "定時掃描更新每隔 [ms]"
Gnosis.L["OptTotTicks"] = "總跳數"
Gnosis.L["OptWfCL_Desc"] = "Delay output/clip test after output/clip test request for given time in ms to account for possible combat log delay." -- Needs review
Gnosis.L["OptWfCL_Name"] = "等待戰鬥記錄 [ms]"
Gnosis.L["OptWidth"] = "寬"
Gnosis.L["PasteScript"] = "貼上腳本到編輯框" -- Needs review
Gnosis.L["PremadeNfs1"] = "cast |cffff0000(rank or misc, e.g. stacks)|r (tradeskill merge)" -- Requires localization
Gnosis.L["PremadeNfs2"] = "cast |cffff0000(aura effect value)|r" -- Requires localization
Gnosis.L["PremadeNfs3"] = "|cffffff00unit name|r: cast" -- Requires localization
Gnosis.L["PremadeTfs1"] = "|cffff0000pushback|r remaining / total, e.g. |cffff0000+1.0|r 1.4 / 3.00" -- Requires localization
Gnosis.L["PremadeTfs2"] = "|cffff0000pushback|r remaining / total, same as above but without minutes display" -- Requires localization
Gnosis.L["PremadeTfs3"] = "remaining / total, higher precision, e.g. 1.45 / 3.000" -- Requires localization
Gnosis.L["SelPremadeStr"] = "Select premade string" -- Requires localization
Gnosis.L["Strata_BACK"] = "最低"
Gnosis.L["Strata_DIALOG"] = "最高"
Gnosis.L["Strata_HIGH"] = "高"
Gnosis.L["Strata_LOW"] = "低"
Gnosis.L["Strata_MEDIUM"] = "中等"
Gnosis.L["TabAdaptToCT"] = "自適應施法類型"
Gnosis.L["TabCapBOTTOM"] = "底部"
Gnosis.L["TabCapBOTTOMLEFT"] = "左下"
Gnosis.L["TabCapBOTTOMRIGHT"] = "右下"
Gnosis.L["TabCapCENTER"] = "中"
Gnosis.L["TabCapLEFT"] = "左"
Gnosis.L["TabCapNONE"] = "無"
Gnosis.L["TabCapRIGHT"] = "右"
Gnosis.L["TabCapTOP"] = "頂部"
Gnosis.L["TabCapTOPLEFT"] = "左上"
Gnosis.L["TabCapTOPRIGHT"] = "右上"
Gnosis.L["TabCastbars"] = "施法條" -- Needs review
Gnosis.L["TabChanneledSpells"] = "通道法術"
Gnosis.L["TabConfig"] = "配置" -- Needs review
Gnosis.L["TabCTClipTest"] = "戰鬥文字/Cliptest"
Gnosis.L["TabFreeAlign"] = "自由對齊"
Gnosis.L["TabNameTime"] = "名字...時間"
Gnosis.L["TabTimeName"] = "時間...名字"
Gnosis.L["Vertical"] = "垂直"
Gnosis.L["Yes"] = "是"

elseif (self.s.strLocale == "koKR") then
-- zhTW locale (traditional chinese)
Gnosis.L["AddonName"] = "Gnosis"
Gnosis.L["BT_Castbar"] = "시전바"
Gnosis.L["BT_MSTimer"] = "다중-주문 타이머"
Gnosis.L["CBSetFocus"] = "주시 대상"
Gnosis.L["CBSetGCD"] = "GCD"
Gnosis.L["CBSetMirror"] = "미러"
Gnosis.L["CBSetPet"] = "소환수 차량"
Gnosis.L["CBSetPlayer"] = "플레이어"
Gnosis.L["CBSetSwing"] = "공격 속도"
Gnosis.L["CBSetTarget"] = "대상"
Gnosis.L["CpyScriptFromEditBox"] = "입력창에서 스크립트 복사하기 (|cffffff7f%s|r)."
Gnosis.L["Horizontal"] = "수평"
Gnosis.L["IfCCSetup"] = "일반 설정 생성"
Gnosis.L["IfCCSString"] = [=[Gnosis는 당신을 위해 일반 시전바 설정을 생성할 수 있습니다("플레이어", "대상", "주시 대상", "미러", "소환수=차량"을 위한 바). 생성된 바는 잠금이 해제된 상태이며 왼쪽 마우스 버튼을 누르고 있는 동안 드래그를 통해 이동시킬 수 있습니다. 바를 우-클릭하게 되면 시전바 설정 gui를 불러옵니다.

이동과 사용자 설정을 마친 후에는 바를 잠궈야 합니다. 블리자드 시전바와 미러 시전바 둘다 비활성화될 것입니다. 또한 아래 버튼을 누르면 "전역 재사용 대기시간 지시기"와 "기본 공격 타이머" (한 손 근접과 원거리 마법봉 포함)를 만들 수 있습니다. Gnosis gui를 불러 들이기 위한 슬래시 명령어는 "/gnosis" 입니다.]=]
Gnosis.L["IfCCTimers"] = "GCD/공격 속도 타이머 생성"
Gnosis.L["IfConfigs"] = "설정"
Gnosis.L["IfCWAction"] = "어떠한 행동도 취하지 않고 프레임을 닫으려면 버튼을 누르세요."
Gnosis.L["IfLFConigs"] = [=[
하나 혹은 그 이상의 저장된 설정을 찾았습니다. 이미 있는 설정을 불러와 Gnosis를 설정할 수 있습니다, 아래 버튼 중 해당되는 것을 누르세요 (버튼 이름은 불러들인 설정의 이름입니다).]=]
Gnosis.L["IfNoCBs"] = "시전바가 없습니다"
Gnosis.L["IfOpenGUI"] = "설정 GUI 열기"
Gnosis.L["Import"] = "가져오기"
Gnosis.L["ImportFromHyperlink"] = "바 설정을 불러옵니까? 이미 바가 있으면, 설정값이 덮어 씌워집니다."
Gnosis.L["ImportKeepPos"] = "불러오기, 위치 유지"
Gnosis.L["MsgBlizCBIsDis"] = "블리자드 시전바는 이미 다른 애드온에 의해 숨겨져 있습니다."
Gnosis.L["MsgBlizCBRestored"] = "블리자드 시전바가 복구되었습니다 (gui 옵션을 보세요)"
Gnosis.L["MsgDis"] = "(비활성)"
Gnosis.L["MsgDisBlizCB"] = "블리자드 시전바 비활성화 (gui 옵션을 보세요)"
Gnosis.L["MsgDisMirrCB"] = "기본 미러 시전바 비활성화 (gui 옵션을 보세요)"
Gnosis.L["MsgDisPetCB"] = "블리자드의 소환수/차량 시전바 비활성화 (gui 옵션을 보세요)"
Gnosis.L["MsgEn"] = "(활성)"
Gnosis.L["MsgLoaded"] = "불러옴"
Gnosis.L["MsgMirrCBIsDis"] = "기본 미러 시전바는 이미 다른 애드온에 의해 숨겨져 있습니다."
Gnosis.L["MsgMirrCBRestored"] = "기본 미러 시전바 복구 (gui 옵션을 보세요)"
Gnosis.L["MsgPetCBIsDis"] = "블리자드 소환수/차량 시전바는 이미 다른 애드온에 의해 숨겨져 있습니다"
Gnosis.L["MsgPetCBRestored"] = "블리자드 소환수/차량 시전바 복구 (gui 옵션을 보세요)"
Gnosis.L["No"] = "아니오"
Gnosis.L["NoImport"] = "가져오지 않기"
Gnosis.L["OptAddonDisabled_Name"] = "애드온 비활성, 현재 설정 탭에서 활성화 할 수 있습니다."
Gnosis.L["OptAddonEnable_Desc"] = "Gnosis 전환"
Gnosis.L["OptAddonEnable_Name"] = "애드온 활성"
Gnosis.L["OptBarXYcoordDesc"] = "x,y-좌표"
Gnosis.L["OptBarXYcoordName"] = "바 위치: x, y"
Gnosis.L["OptCBActiveSpec"] = "특성 옵션 활성화"
Gnosis.L["OptCBAddListElem"] = "등록 추가"
Gnosis.L["OptCBAdjIcon"] = "아이콘 위치 조절 (잠금을 해제한 경우에)"
Gnosis.L["OptCBAdjLatTextCoord"] = "지연률 문자 위치 조절"
Gnosis.L["OptCBAdjNamePos"] = "이름 위치 조절"
Gnosis.L["OptCBAlignName"] = "시전이름 정렬"
Gnosis.L["OptCBAlignTime"] = "시전시간 정렬"
Gnosis.L["OptCBAlignTimeCoord"] = "시간 위치 조절"
Gnosis.L["OptCBAlpha"] = "바 투명도"
Gnosis.L["OptCBAnc"] = "앵커 지정"
Gnosis.L["OptCBAncBarAncPnt"] = "Gnosis 바 앵커 지점"
Gnosis.L["OptCBAncFrameAncPnt"] = "앵커 프레임 앵커 지점"
Gnosis.L["OptCBAncFrameName"] = "프레임에 앵커"
Gnosis.L["OptCBAncNoAnc"] = "앵커 없음"
Gnosis.L["OptCBAncOffset"] = "x,y 좌표"
Gnosis.L["OptCBAncToCursor"] = "커서에 고정"
Gnosis.L["OptCBAncToFrame"] = "프레임에 앵커"
Gnosis.L["OptCBAncType"] = "앵커 유형"
Gnosis.L["OptCBBarType"] = "바 형식"
Gnosis.L["OptCBBorderCol"] = "테두리 색상"
Gnosis.L["OptCBBorderColInt"] = "테두리 색상 (차단 불가능한)"
Gnosis.L["OptCBBorderSize"] = "테두리 크기"
Gnosis.L["OptCBBorderTex_D"] = "고정된 크기의 테두리 텍스쳐를 추가합니다. 아이콘을 고정하지 않거나 기본 테두리 크기를 0으로 줄이기 위해 추가적인 테두리 텍스쳐를 사용할 수 있습니다. 이 테두리 텍스쳐는 아이콘 테두리에 영향을 주지 않습니다."
Gnosis.L["OptCBBorderTex_N"] = "추가적인 테두리 텍스쳐"
Gnosis.L["OptCBBWListedSpells"] = "차단/허용 주문 또는 타이머 설정"
Gnosis.L["OptCBCBBgCol"] = "시전바 배경 색상"
Gnosis.L["OptCBCBColFail"] = "시전바 색상 (실패)"
Gnosis.L["OptCBCBColInt"] = "시전바 색상 (차단된)"
Gnosis.L["OptCBCBColor"] = "시전바 색상"
Gnosis.L["OptCBCBNIColor"] = "시전바 색상 (차단 불가능 한)"
Gnosis.L["OptCBCBShColor"] = "문자 그림자 색상"
Gnosis.L["OptCBCBSucColor"] = "시전 성공 (시전바 색상)"
Gnosis.L["OptCBCenterCB"] = "시전바 중앙으로"
Gnosis.L["OptCBChannelsAsNormal"] = "'채널링'바 성장 방향 반대로 (대부분의 타이머 바)"
Gnosis.L["OptCBCombatSelAlways"] = "전투 중 혹은 전투 중이 아닐 때"
Gnosis.L["OptCBCombatSelInC"] = "전투 중일 때"
Gnosis.L["OptCBCombatSelOoC"] = "전투 중이 아닐 때"
Gnosis.L["OptCBCombSel"] = "시전바를 보일 상황"
Gnosis.L["OptCBCopyCB_D"] = "시전바를 복사합니다, 시전바 이름 입력창에 정확한 이름을 입력하세요."
Gnosis.L["OptCBCopyCB_N"] = "시전바 복사"
Gnosis.L["OptCBEnCastSucDesc"] = "시전이 성공하면 색상을 변경합니다"
Gnosis.L["OptCBEnCastSucName"] = "시전 성공 활성화"
Gnosis.L["OptCBEnCB"] = "시전바 활성"
Gnosis.L["OptCBEnList"] = "차단 혹은 허용목록 활성/비활성"
Gnosis.L["OptCBEnShCol"] = "문자 그림자 색상 사용"
Gnosis.L["OptCBExportBar"] = "시전바 내보내기"
Gnosis.L["OptCBExportBarChatlink_D"] = "대화 입력창이 표시되어 있어야 합니다."
Gnosis.L["OptCBExportBarChatlink_N"] = "불러오기 링크를 대화창에 붙여넣기"
Gnosis.L["OptCBExtendChannels_D"] = "시전 중인 채널링 주문이 끝나기 전에 같은 주문을 이어서 재시전하면 주문을 연장합니다."
Gnosis.L["OptCBExtendChannels_N"] = "채널링 주문 연장"
Gnosis.L["OptCBFadeout"] = "사라짐 시간"
Gnosis.L["OptCBFillAtEnd"] = "시전 후 바를 채우기"
Gnosis.L["OptCBFixLatBox"] = "비플레이어 틱 박스의 고정 크기 [바의 %]"
Gnosis.L["OptCBFont"] = "글꼴"
Gnosis.L["OptCBFontOutline"] = "글꼴 외곽선"
Gnosis.L["OptCBFontSizeLat"] = "지연률 글꼴 크기 (0=자동)"
Gnosis.L["OptCBFontSizeName"] = "이름 글꼴 크기 (0=자동)"
Gnosis.L["OptCBFontSizeTime"] = "타이머 글꼴 크기 (0=자동)"
Gnosis.L["OptCBForceLatAlign"] = "지연률 강제 정렬"
Gnosis.L["OptCBFrameStrata"] = "프레임 계층"
Gnosis.L["OptCBGroupSelAlways"] = "솔로잉, 파티나 공격대 시 (항상)"
Gnosis.L["OptCBGroupSelPartyNotRaid"] = "파티 시, 공격대 제외"
Gnosis.L["OptCBGroupSelRaid"] = "공격대 시"
Gnosis.L["OptCBGroupSelSolo"] = "솔로잉, 공격대 제외"
Gnosis.L["OptCBIconBorderSize"] = "아이콘 테두리 (잠금을 해제한 경우에)"
Gnosis.L["OptCBInstanceSelAlways"] = "인스턴스 내부 또는 외부 (항상)"
Gnosis.L["OptCBInstanceSelArena"] = "투기장"
Gnosis.L["OptCBInstanceSelBattleground"] = "전장"
Gnosis.L["OptCBInstanceSelFiveMan"] = "5인 인스턴스"
Gnosis.L["OptCBInstanceSelInside"] = "인스턴스 내부"
Gnosis.L["OptCBInstanceSelOutside"] = "인스턴스 외부"
Gnosis.L["OptCBInstanceSelRaid"] = "공격대 인스턴스"
Gnosis.L["OptCBInvBarDir"] = "바 방향 반대로"
Gnosis.L["OptCBLatBoxCol"] = "지연률 박스 색상"
Gnosis.L["OptCBListBlack"] = "차단목록"
Gnosis.L["OptCBListNeither"] = "둘 다 안함"
Gnosis.L["OptCBListWhite"] = "허용목록"
Gnosis.L["OptCBLockAll_D"] = "모든 바 잠금"
Gnosis.L["OptCBLockAll_N"] = "잠금"
Gnosis.L["OptCBMaxLatBox"] = "지연률 박스의 최대 크기 [바의 %]"
Gnosis.L["OptCBNewCB_D"] = [=[새로운 바를 만듭니다. 가까운 입력창에 유요한 이름을 입력하세요.

쉬프트 키를 누르고 클릭하면 아이콘 형식의 바를 만듭니다.]=]
Gnosis.L["OptCBNewCB_N"] = "새 (아이콘 형식)시전바"
Gnosis.L["OptCBNewCBName_D"] = "새 시전바를 생성하기 전에 이름을 입력하세요"
Gnosis.L["OptCBNewListElem_D"] = [=[시전바:
차단 혹은 허용할 주문의 이름을 입력하세요.

다중-주문 타이머:
항목의 기본 형식: cmds [options] : type

자세한 정보 @ curse.com의 Gnosis' 설명 페이지나 WoW 폴더/Addons/Gnosis에 있는 .pdf 파일들.]=]
Gnosis.L["OptCBNewListElem_N"] = "추가할 주문 이름 입력"
Gnosis.L["OptCBOrient"] = "방향"
Gnosis.L["OptCBRelSel"] = "시전 보이기 : "
Gnosis.L["OptCBRelSelAll"] = "모든 유닛"
Gnosis.L["OptCBRelSelEnemy"] = "적대적 유닛"
Gnosis.L["OptCBRelSelFriendly"] = "우호적 유닛"
Gnosis.L["OptCBRemCB"] = "시전바 제거"
Gnosis.L["OptCBRemListElem"] = "현재 등록 제거"
Gnosis.L["OptCBRotIcon"] = "아이콘 회전 (°)"
Gnosis.L["OptCBRotLatencyN"] = "지연시간 문자 회전"
Gnosis.L["OptCBRotNameD"] = "사용 시 강제 정렬"
Gnosis.L["OptCBRotNameN"] = "이름 문자 회전"
Gnosis.L["OptCBRotTimeN"] = "시간 문자 회전"
Gnosis.L["OptCBScaleBar"] = "바 크기"
Gnosis.L["OptCBScaleIcon"] = "아이콘 크기 (잠금을 해제 했을 때)"
Gnosis.L["OptCBShowChanTicks"] = "채널링 틱 보이기"
Gnosis.L["OptCBShowIcon"] = "시전 아이콘 보이기"
Gnosis.L["OptCBShowLatBox"] = "지연률 박스 보이기"
Gnosis.L["OptCBShowShield"] = "차단 불가 주문에 방패 표시"
Gnosis.L["OptCBShowSpark"] = "시전바 섬광 보이기"
Gnosis.L["OptCBSizeGrp"] = "바 모양과 외형"
Gnosis.L["OptCBSparkColor"] = "섬광 색상"
Gnosis.L["OptCBSparkHeight"] = "섬광 높이"
Gnosis.L["OptCBSparkWidth"] = "섬광 너비"
Gnosis.L["OptCBSWNC"] = "시전 중이 아닌 경우 보이기"
Gnosis.L["OptCBTabColors"] = "색상"
Gnosis.L["OptCBTabHide"] = "시전바 숨기기"
Gnosis.L["OptCBTabText"] = "문자"
Gnosis.L["OptCBTextAlignment"] = "정렬 (이름-시간)"
Gnosis.L["OptCBTextColLat"] = "문자 색상 (지연률)"
Gnosis.L["OptCBTextColName"] = "문자 색상 (이름)"
Gnosis.L["OptCBTextColPB"] = "문자 색상 (시전 밀림)"
Gnosis.L["OptCBTextColTime"] = "문자 색상 (시간)"
Gnosis.L["OptCBTexture"] = "시전바 텍스쳐"
Gnosis.L["OptCBUnit"] = "유닛"
Gnosis.L["OptCBUnl_D"] = "시전바 잠금 해제 (항상 보임)"
Gnosis.L["OptCBUnl_N"] = "시전바 잠금 해제 (이동가능)"
Gnosis.L["OptCBUnlockAll_D"] = "모든 바를 잠금해제 합니다. 비활성된 바 또는 다른 특성 전문화에 선택된 바들도 잠금해제 되지만 여전히 보이지 않습니다."
Gnosis.L["OptCBUnlockAll_N"] = "잠금해제"
Gnosis.L["OptCBUnlockIcon_D"] = "바에서 아이콘 잠금 해제"
Gnosis.L["OptCBUnlockIcon_N"] = "아이콘 잠금 해제"
Gnosis.L["OptCBWordWrapD"] = "줄을 추가해 문자 겹치기 허용"
Gnosis.L["OptCBWordWrapN"] = "문자 겹침 허용"
Gnosis.L["OptCHCastnameGrp"] = "시전이름 옵션"
Gnosis.L["OptCHCasttimeGrp"] = "시전시간 옵션"
Gnosis.L["OptClipWarn_Desc"] = "단일 채널링 주문이 틱 전에 시전이 끊어지면 경고합니다."
Gnosis.L["OptClipWarn_Name"] = "틱 끊김 경고 [ms]"
Gnosis.L["OptCombTicks"] = "틱을 합산해 전투 문자에 출력하기"
Gnosis.L["OptConfDelConf"] = "설정 제거"
Gnosis.L["OptConfDelConfMBText"] = "|cffffff7f%s|r 이 설정을 삭제하겠습니까?"
Gnosis.L["OptConfLoadCBs"] = "시전바 불러오기"
Gnosis.L["OptConfLoadChan"] = "채널링 주문 불러오기"
Gnosis.L["OptConfLoadCT"] = "전투문자/틱 끊김 설정 불러오기"
Gnosis.L["OptConfLoadMain"] = "메인 탭 설정 불러오기"
Gnosis.L["OptConfName"] = "설정 이름"
Gnosis.L["OptConfSave"] = "설정 저장"
Gnosis.L["OptConfStoreCBs"] = "시전바 저장"
Gnosis.L["OptConfStoreChan"] = "채널링 주문 자료 저장"
Gnosis.L["OptConfStoreCT"] = "전투문자/틱 끊김 설정 저장"
Gnosis.L["OptConfStoreMain"] = "애드온 메인 탭 설정 저장"
Gnosis.L["OptConfUpdConf"] = "설정 갱신"
Gnosis.L["OptConfUpdConfMBText"] = "|cffffff7f%s|r 설정을 갱신하겠습니까 (설정 활성화)?"
Gnosis.L["OptCopytonewbarExists"] = "바가 이미 있어, 주어진 이름으로 바를 복사할 수 없습니다."
Gnosis.L["OptCopytonewbarInvalidName"] = "새로운 바로 복사하기 전에 유효한 바 이름을 입력하세요."
Gnosis.L["OptCreateCBSet"] = "기본 시전바 세트 생성 (빠른 시작)"
Gnosis.L["OptCreatenewbarExists"] = "바가 이미 있어, 주어진 이름으로 바를 생성할 수 없습니다. "
Gnosis.L["OptCreatenewbarInvalidName"] = "새 바를 생성하기 전에 유효한 바 이름을 입력하세요."
Gnosis.L["OptCreateNewSpell"] = "새 주문 생성"
Gnosis.L["OptCSFSClip"] = "글꼴 크기 (틱 끊김, 0=기본)"
Gnosis.L["OptCSFSNonClip"] = "글꼴 크기 (틱 유지, 0=기본)"
Gnosis.L["OptCSRemove"] = "주문 제거"
Gnosis.L["OptCTO"] = "전투 문자 출력"
Gnosis.L["OptCTO_Blizz"] = "블리자드 기본 전투 문자"
Gnosis.L["OptCTO_MSBT"] = "Mik's Scrolling Battle Text(MSBT)"
Gnosis.L["OptCTO_Parrot"] = "Parrot"
Gnosis.L["OptCTO_SCT"] = "Scrolling Combat Text(SCT)"
Gnosis.L["OptEn"] = "활성"
Gnosis.L["OptEnAutoCreateOptons"] = "시작 시 자동으로 옵션 테이블 만들기"
Gnosis.L["OptEnClipTest"] = "틱 끊김 검사 활성"
Gnosis.L["OptExportAllBars"] = "모든 바 내보내기"
Gnosis.L["OptFile"] = "파일"
Gnosis.L["OptFirstStartFrame"] = "첫 시작 프레임 열기"
Gnosis.L["OptFirstTickInst"] = "시전과 동시에 첫 틱"
Gnosis.L["OptFontEnShOffset"] = "특정 그림자 좌표 사용"
Gnosis.L["OptFontResizeLongName"] = "긴 구문열 크기 조절"
Gnosis.L["OptFontShOffsetXYDesc"] = "문자와 문자 그림자 사이의 좌표 설정"
Gnosis.L["OptFontShOffsetXYName"] = "그림자 좌표 x, y"
Gnosis.L["OptHasteAddsTicks"] = "주문 가속 추가 틱"
Gnosis.L["OptHeight"] = "높이"
Gnosis.L["OptHideAddonMsgs"] = "Gnosis 문자 메시지 숨기기"
Gnosis.L["OptHideBlizzCB"] = "블리자드의 시전바 숨기기"
Gnosis.L["OptHidecasttime"] = "남은 시전시간 숨기기"
Gnosis.L["OptHidecasttimeTotal"] = "전체 시전시간 숨기기"
Gnosis.L["OptHideMirrorCB"] = "블리자드의 미러 시전바 숨기기"
Gnosis.L["OptHideNonPlayerTicks"] = "비 플레이어 시전바의 틱 숨기기"
Gnosis.L["OptHidePetCB"] = "블리자드의 소환수/차량 시전바 숨기기"
Gnosis.L["OptHidepushbackTime"] = "시전 밀림 시간 숨기기"
Gnosis.L["OptImportBar"] = "바 가져오기"
Gnosis.L["OptLoadOptionsButtonDesc"] = "Gnosis의 메모리 사용량을 줄이기 위해 옵션 테이블을 미리 만들지 않습니다. 옵션을 불러온 후 다음 wow 시작 시 자동으로 옵션 테이블을 만드는 옵션을 선택할 수 있습니다 (또는 UI 리로드)."
Gnosis.L["OptLoadOptionsButtonName"] = "옵션 만들기..."
Gnosis.L["OptLocale"] = "언어 지역 선택"
Gnosis.L["OptMergetradeskillDesc"] = "전문기술 병합 (플레이어 시전바에 한해)."
Gnosis.L["OptMergetradeskillName"] = "전문기술 병합"
Gnosis.L["OptMusic"] = "음악"
Gnosis.L["OptNameFormatStringDesc"] = [=[이름 구문 입력 방법

name: 주문이름
trunc<cnt>: cnt보다 길면 주문이름 줄이기
abbr<cnt>: 주문이름이 cnt보다 길면 줄여씁니다(두문자어)
rank<text>: 주문 레벨 표시가 가능하면 레벨을 표시합니다
misc: 주문 레벨이 없는 주문에 기타 정보를 표시합니다
arabic: 주문 레벨을 아라비아 숫자로 표시 (예. 13)
roman: 주문 레벨을 로마 숫자로 표시 (예. XIII)
txr<text>: 주문 레벨 정보가 있으면 표시합니다
txm<text>: 기타 정보가 있으면 표시합니다
target: 대상의 이름을 표시합니다 (플레이어만 해당)
tar<text>: 대상 정보가 있으면 표시합니다 (플레이어만 해당)
tar[text]: 위와 같음
who: 시전중인 개체 이름 보이기

col<r,g,b[,a]>: 예. col<1.0,1.0,0.0> 색상 바꾸기
col<school>: 주문 속성 별 표시...암흑,비전 등
col<pre>: 이전 색상으로 바꿉니다
col<class>: 대상의 직업 색상으로 바꿉니다 (가능 할 때만)
col<cpre>: 이전 색상으로 전환 (대상 직업 색상이 가능 할 때만)

tscur: 전문기술 제작시 남은 횟수를 표시합니다
tstot: 전문기술 제작시 총 횟수를 표시합니다
txts<text>: 전문기술 정보가 있으면 표시합니다

\n: 새로운 줄 만들기(문자 겹침이 활성화 되있을 때)]=]
Gnosis.L["OptNameFormatStringName"] = "이름 형식 문자열"
Gnosis.L["OptNameFormatToggleDesc"] = "활성화하면 '시전 이름 보이기'와 '시전 레벨 보이기' 설정은 무시됩니다."
Gnosis.L["OptNameFormatToggleName"] = "이름 형식 구문열 활성"
Gnosis.L["OptOutputString"] = "출력 구문열"
Gnosis.L["OptOutputStringDesc"] = [=[전투 문자 출력 구문 입력 방법

spellname: 채널링 주문의 이름
dmg: 주문의 데미지 양이나 치유량
eh: 유효 치유량 (=치유량-오버힐)
oh: 오버힐
dps: 주문의 dps나 hps
target: 주문 대상의 이름
clipped: 의도되지 않은 틱 끊김에 대한 정보
cliptext<문구>: 틱 끊김 대체 메시지

hits: 타격 횟수
crits: 극대화 횟수
ticks: 틱 횟수
tickscrits: 틱과 극대화 횟수 출력

위의 구문은 표시된 횟수의 식별을 위해 아래 구문을 사용합니다
hittext<문구>: 타격 식별
crittext<문구>: 극대화 식별
ticktext<문구>: 틱 식별

col<r,g,b[,a]>: 예. col<1.0,1.0,0.0> 색상 변경
col<school>: 주문 속성 색상(암흑,비전...)
col<pre>: 이전 색상으로 변경
col<class>: 대상 직업 색상으로 변경 (가능 할 때만)
col<cpre>: 이전 색상으로 변경 (대상 직업 색상이 가능 할 때만)]=]
Gnosis.L["OptPFoC"] = "틱 시전 시 파일 재생"
Gnosis.L["OptPlayFile"] = "사용자 파일 재생"
Gnosis.L["OptPlayMusic"] = "음악 파일 재생"
Gnosis.L["OptPlaySnd"] = "소리 재생"
Gnosis.L["OptPlayTickSound_D"] = "틱 끊김 소리 비활성화."
Gnosis.L["OptPlayTickSound_N"] = "틱 소리 재생"
Gnosis.L["OptPMoC"] = "틱 시전 시 음악 재생"
Gnosis.L["OptPSoC"] = "틱 시전 시 소리 재생"
Gnosis.L["OptResetPlayerData"] = "플레이어 자료 초기화 (인터페이스 재시작)"
Gnosis.L["OptResizeOptions"] = "시작 시 인터페이스 옵션 창 크기 조절"
Gnosis.L["OptSaveconfigExists"] = "설정이 이미 있습니다. 이전 것을 삭제하거나 이름을 변경하세요."
Gnosis.L["OptSaveconfigInvalidName"] = "주어진 설정 이름이 없습니다."
Gnosis.L["OptShowasminutesDesc"] = "60초 보다 길면 초 대신에 분 보이기"
Gnosis.L["OptShowasminutesName"] = "분 보이기"
Gnosis.L["OptShowCastNameDesc"] = "이름 형식 구문열이 활성화되면 옵션은 사용할 수 없습니다."
Gnosis.L["OptShowCastNameName"] = "시전 이름 보이기"
Gnosis.L["OptShowCastRankDesc"] = "이름 형식 구문열이 활성화되면 옵션은 사용할 수 없습니다."
Gnosis.L["OptShowCastRankName"] = "시전 레벨 보이기"
Gnosis.L["OptShowPlayerLatency"] = "플레이어 지연률(ms) 보이기"
Gnosis.L["OptShowSpellIcon"] = "주문 아이콘 보이기"
Gnosis.L["OptSnd"] = "소리"
Gnosis.L["OptSpellIsAoE"] = "광역 공격 주문"
Gnosis.L["OptSpellNameOrId"] = "주문 이름 혹은 주문 ID"
Gnosis.L["OptStickyClips"] = "틱 시전 고정"
Gnosis.L["OptStrGapDesc"] = "시전 이름과 시간 사이에 최소한의 공간 두기 (긴 형식의 문자열 조절을 결정합니다)."
Gnosis.L["OptStrGapName"] = "공간 (이름...시간)"
Gnosis.L["OptTablesUnloaded_Name"] = "아직 옵션 테이블이 만들어지지 않음"
Gnosis.L["OptTicksToShow"] = "보여줄 틱"
Gnosis.L["OptTimeFormatStringDesc"] = [=[시간 구문 입력 방법

r<x>: 남은 시간을 소숫점 x자리까지 표시
t<x>: 전체 시간을 소숫점 x자리까지 표시
p<x>: 시전 밀림 시간을 소숫점 x자리 까지 표시
c<x>: 전체 시간-남은 시간 => 전체 시간 쪽으로 계산

시간을 표시하기 위해 s 또는 m을 추가합니다 > 60초
예. r<1m> 또는 p<2s>
백분율 값 표시를 위해 p 추가합니다
예. r<p>% / t<1p>%

col<r,g,b[,a]>: 예. col<1.0,1.0,0.0> 색상 변경
col<school>: 주문 속성 색상(암흑, 비전..)
col<pre>: 이전의 색상으로 변경

\n: 새로운 줄 만들기

추신: 필요하다면 col<r,g,b>를 사용해 시전 밀린 주문의 색상을 바꾸세요.]=] -- Needs review
Gnosis.L["OptTimeFormatStringName"] = "시간 형식 구문열"
Gnosis.L["OptTimeFormatToggleDesc"] = "활성화하면 모든 다른 시간 형식화 옵션은 무시됩니다."
Gnosis.L["OptTimeFormatToggleName"] = "시간 형식 구문열 활성"
Gnosis.L["OptTimerScanEveryN"] = "타이머 갱신 주기 [ms]"
Gnosis.L["OptTotTicks"] = "전체 틱"
Gnosis.L["OptWfCL_Desc"] = "전투 로그 지연을 고려해 주어진 시간만큼 출력/틱 시전을 지연시킬 것을 요청합니다."
Gnosis.L["OptWfCL_Name"] = "전투 로그 대기 [ms]"
Gnosis.L["OptWidth"] = "너비"
Gnosis.L["PasteScript"] = "입력창에 스크립트 붙여넣기."
Gnosis.L["PremadeNfs1"] = "시전 |cffff0000(레벨 or 기타, 예. 중첩)|r (전문기술 병합)"
Gnosis.L["PremadeNfs2"] = "시전 |cffff0000(오라 효과 수치)|r"
Gnosis.L["PremadeNfs3"] = "|cffffff00개체 이름|r: 시전"
Gnosis.L["PremadeTfs1"] = "|cffff0000시전밀림|r 남은시간 / 전체시간, 예. |cffff0000+1.0|r 1.4 / 3.00"
Gnosis.L["PremadeTfs2"] = "|cffff0000시전밀림|r 남은시간 / 전체시간, 위와 동일하지만 분 표시없음"
Gnosis.L["PremadeTfs3"] = "남은시간 / 전체시간, 높은 정확도, 예. 1.45 / 3.000"
Gnosis.L["SelPremadeStr"] = "이미 만들어진 구문 선택"
Gnosis.L["Strata_BACK"] = "가장 낮음"
Gnosis.L["Strata_DIALOG"] = "가장 높음"
Gnosis.L["Strata_HIGH"] = "높음"
Gnosis.L["Strata_LOW"] = "낮음"
Gnosis.L["Strata_MEDIUM"] = "중간"
Gnosis.L["TabAdaptToCT"] = "시전 유형에 맞춤"
Gnosis.L["TabCapBOTTOM"] = "하단"
Gnosis.L["TabCapBOTTOMLEFT"] = "좌측하단"
Gnosis.L["TabCapBOTTOMRIGHT"] = "우측하단"
Gnosis.L["TabCapCENTER"] = "정중앙"
Gnosis.L["TabCapLEFT"] = "왼쪽"
Gnosis.L["TabCapNONE"] = "해당 없음"
Gnosis.L["TabCapRIGHT"] = "오른쪽"
Gnosis.L["TabCapTOP"] = "상단"
Gnosis.L["TabCapTOPLEFT"] = "좌측상단"
Gnosis.L["TabCapTOPRIGHT"] = "우측상단"
Gnosis.L["TabCastbars"] = "바 설정"
Gnosis.L["TabChanneledSpells"] = "채널링 주문"
Gnosis.L["TabConfig"] = "설정 (프로필)"
Gnosis.L["TabCTClipTest"] = "전투문자/틱 시전"
Gnosis.L["TabFreeAlign"] = "임의 정렬"
Gnosis.L["TabNameTime"] = "이름...시간"
Gnosis.L["TabTimeName"] = "시간...이름"
Gnosis.L["Vertical"] = "수직"
Gnosis.L["Yes"] = "네"

elseif (self.s.strLocale == "ruRU") then
-- ruRU locale (russian)
Gnosis.L["AddonName"] = "Gnosis"
Gnosis.L["BT_Castbar"] = "Полоса заклинаний" -- Needs review
Gnosis.L["BT_MSTimer"] = "Таймер мульти заклинаний" -- Needs review
Gnosis.L["CBSetFocus"] = "Фокус"
Gnosis.L["CBSetGCD"] = "ГКД" -- Needs review
Gnosis.L["CBSetMirror"] = "Зеркало"
Gnosis.L["CBSetPet"] = "Ездовой Питомец" -- Needs review
Gnosis.L["CBSetPlayer"] = "Игрок"
Gnosis.L["CBSetSwing"] = "Взмах"
Gnosis.L["CBSetTarget"] = "Цель"
Gnosis.L["CpyScriptFromEditBox"] = "Скопировать скрипт из окна редактирования (|cffffff7f%s|r)." -- Needs review
Gnosis.L["Horizontal"] = "Горизонтально"
Gnosis.L["IfCCSetup"] = "Создать обычный набор" -- Needs review
Gnosis.L["IfCCSString"] = [=[Gnosis может создать для вас обычный набор полос заклинаний (полосы для Игрока, Цели, Фокуса, Отображения и Питомца/Транспорта). Созданные полосы будут разблокированны и их можно двигать зажатой левой кнопкой мыши. Правая кнопка мыши вызовет настройки полосы заклинаний.

Вам нужно закрепить полосы после того как вы закончите их перемещение и модификацию. Полосы заклинаний и отображения Blizzard будут отключены. Вы также можете создать "Индикатор ГКД" и "Таймер Взмаха" (одноручное оружие ближнего боя и дальнего боя включая жезлы) нажав на кнопку внизу. Команда вызова меню Gnosis /gnosis]=] -- Needs review
Gnosis.L["IfCCTimers"] = "Создать таймер взмаха/GCD"
Gnosis.L["IfConfigs"] = "Конфигурации"
Gnosis.L["IfCWAction"] = "Нажмите на кнопку, чтобы закрыть фрейм без каких-либо действий"
Gnosis.L["IfLFConigs"] = "Были найденв одна или несколько сохраненных конфигураций. Вы можете настроить Gnosis сделав загрузку из уже существующей конфигурции нажав любую кнопку внизу (название кнопки соответсвует названию загружаемой конфигурации)." -- Needs review
Gnosis.L["IfNoCBs"] = "Полос заклинаний не найдено" -- Needs review
Gnosis.L["IfOpenGUI"] = "Открыть интерфейс настроек"
Gnosis.L["Import"] = "Импортировать" -- Needs review
Gnosis.L["ImportFromHyperlink"] = "Import bar configuration? If the bar already exists, it's configuration values will be overwritten." -- Requires localization
Gnosis.L["ImportKeepPos"] = "Import, keep position" -- Requires localization
Gnosis.L["MsgBlizCBIsDis"] = "полоса заклинаний уже скрыта другой модификацией" -- Needs review
Gnosis.L["MsgBlizCBRestored"] = "полоса заклинаний blizzard восстановлена (загляните в настройки)" -- Needs review
Gnosis.L["MsgDis"] = "(отключено)" -- Needs review
Gnosis.L["MsgDisBlizCB"] = "полоса заклинаний blizzard отключена (загляните в настройки)" -- Needs review
Gnosis.L["MsgDisMirrCB"] = "стандартная зеркальная полоса заклинаний отключена (загляните в настройки)" -- Needs review
Gnosis.L["MsgDisPetCB"] = "полоса питомца/транспорта Blizzard отключена (смотрите настройки)" -- Needs review
Gnosis.L["MsgEn"] = "(включено)" -- Needs review
Gnosis.L["MsgLoaded"] = "загружено" -- Needs review
Gnosis.L["MsgMirrCBIsDis"] = "стандартная зеркальная полоса заклинаний уже скрыта другой модификацией" -- Needs review
Gnosis.L["MsgMirrCBRestored"] = "стандартная зеркальная полоса заклинаний восстановлена (загляните в настройки)" -- Needs review
Gnosis.L["MsgPetCBIsDis"] = "полоса питомца/транспорта Blizzard уже скрыта другой модификацией" -- Needs review
Gnosis.L["MsgPetCBRestored"] = "полоса питомца/транспорта Blizzard восстановлена (смотрите настройки)" -- Needs review
Gnosis.L["No"] = "Нет" -- Needs review
Gnosis.L["NoImport"] = "Не импортировать" -- Needs review
Gnosis.L["OptAddonDisabled_Name"] = "Модификация отключена, для доступа к настройкам включите её."
Gnosis.L["OptAddonEnable_Desc"] = "Включить/выключить Gnosis"
Gnosis.L["OptAddonEnable_Name"] = "Включить"
Gnosis.L["OptBarXYcoordDesc"] = "Координаты - x,y"
Gnosis.L["OptBarXYcoordName"] = "Расположение полосы: x, y" -- Needs review
Gnosis.L["OptCBActiveSpec"] = "Включен при смене талантов" -- Needs review
Gnosis.L["OptCBAddListElem"] = "Добавить запись"
Gnosis.L["OptCBAdjIcon"] = "Регулировка позиции иконки (когда разблок.)"
Gnosis.L["OptCBAdjLatTextCoord"] = "Регулировка позиции текста задержки"
Gnosis.L["OptCBAdjNamePos"] = "Регулировка позиции названия" -- Needs review
Gnosis.L["OptCBAlignName"] = "Выравнивание названия заклинания" -- Needs review
Gnosis.L["OptCBAlignTime"] = "Выравнивание времени произнесения"
Gnosis.L["OptCBAlignTimeCoord"] = "Регулировка позиции времени"
Gnosis.L["OptCBAlpha"] = "Прозрачность полосы"
Gnosis.L["OptCBAnc"] = "Закрепить" -- Needs review
Gnosis.L["OptCBAncBarAncPnt"] = "Точка закрепления полосы Gnosis" -- Needs review
Gnosis.L["OptCBAncFrameAncPnt"] = "Закрепить точку закрепления фрейма" -- Needs review
Gnosis.L["OptCBAncFrameName"] = "Прикрепить к фрейму" -- Needs review
Gnosis.L["OptCBAncNoAnc"] = "Не закреплено" -- Needs review
Gnosis.L["OptCBAncOffset"] = "Отступ x, y" -- Needs review
Gnosis.L["OptCBAncToCursor"] = "Закрепить за курсором" -- Needs review
Gnosis.L["OptCBAncToFrame"] = "Прикрепить к фрейму" -- Needs review
Gnosis.L["OptCBAncType"] = "Тип фиксатора"
Gnosis.L["OptCBBarType"] = "Тип полосы" -- Needs review
Gnosis.L["OptCBBorderCol"] = "Цвет границы"
Gnosis.L["OptCBBorderColInt"] = "Цвет границы (не прерываемый)"
Gnosis.L["OptCBBorderSize"] = "Размер границы"
Gnosis.L["OptCBBorderTex_D"] = "Дополнительные текстуры границы фиксированного размера. Возможно вам понадобится разблокировать иконку и уменьшить обычный размер границы до 0 при использовании дополнительных текстур границы. Текстуры границы не меняют границы иконки." -- Needs review
Gnosis.L["OptCBBorderTex_N"] = "Дополнительные текстуры границы" -- Needs review
Gnosis.L["OptCBBWListedSpells"] = "Заклинания черного/белого списка или настройки таймера" -- Needs review
Gnosis.L["OptCBCBBgCol"] = "Цвет фона полосы заклинаний" -- Needs review
Gnosis.L["OptCBCBColFail"] = "Цвет полосы заклинаний (не удалось)" -- Needs review
Gnosis.L["OptCBCBColInt"] = "Цвет полосы заклинаний (прервано)" -- Needs review
Gnosis.L["OptCBCBColor"] = "Цвет полосы заклинаний" -- Needs review
Gnosis.L["OptCBCBNIColor"] = "Цвет полосы заклинаний (не прирываемые)" -- Needs review
Gnosis.L["OptCBCBShColor"] = "Цвет тени текста" -- Needs review
Gnosis.L["OptCBCBSucColor"] = "Успешное произнесение (цвет полосы)" -- Needs review
Gnosis.L["OptCBCenterCB"] = "Полоса заклинаний по центру" -- Needs review
Gnosis.L["OptCBChannelsAsNormal"] = "Считать потоковые заклинания обычными заклинаниями" -- Needs review
Gnosis.L["OptCBCombatSelAlways"] = "ао время и вне боя" -- Needs review
Gnosis.L["OptCBCombatSelInC"] = "только в бою"
Gnosis.L["OptCBCombatSelOoC"] = "только вне боя"
Gnosis.L["OptCBCombSel"] = "Показывать полосу заклинаний во время" -- Needs review
Gnosis.L["OptCBCopyCB_D"] = "Копировать полосу заклинаний, убедитесь в вводе правильного имени в окне Новая полоса заклинаний." -- Needs review
Gnosis.L["OptCBCopyCB_N"] = "Копировать полосу заклинаний" -- Needs review
Gnosis.L["OptCBEnCastSucDesc"] = "Изменить цвет после успешного произнесения" -- Needs review
Gnosis.L["OptCBEnCastSucName"] = "Включить успешное произнесение" -- Needs review
Gnosis.L["OptCBEnCB"] = "Включить полосу заклинаний" -- Needs review
Gnosis.L["OptCBEnList"] = "Включить черный- или белый список"
Gnosis.L["OptCBEnShCol"] = "Включить цвет тени текста" -- Needs review
Gnosis.L["OptCBExportBar"] = "Экспортировать полосу заклинаний" -- Needs review
Gnosis.L["OptCBExportBarChatlink_D"] = "Requires the chat frame's edit box to be shown." -- Requires localization
Gnosis.L["OptCBExportBarChatlink_N"] = "Paste import link to chat" -- Requires localization
Gnosis.L["OptCBExtendChannels_D"] = "Продлить потоковое заклинание во время повторного произнесения этого заклинания, если оно было совершено до завершения предыдущего заклинания" -- Needs review
Gnosis.L["OptCBExtendChannels_N"] = "Продлить потоковое заклинание" -- Needs review
Gnosis.L["OptCBFadeout"] = "Время исчезновения"
Gnosis.L["OptCBFillAtEnd"] = "Заполнение полосы к концу произнесения"
Gnosis.L["OptCBFixLatBox"] = "Фиксированный размер окна чужих тактов заклинаний [% полосы]" -- Needs review
Gnosis.L["OptCBFont"] = "Шрифт"
Gnosis.L["OptCBFontOutline"] = "Контур шрифта"
Gnosis.L["OptCBFontSizeLat"] = "Размер шрифта задержки (0=авто)"
Gnosis.L["OptCBFontSizeName"] = "Размер шрифта названия (0=авто)"
Gnosis.L["OptCBFontSizeTime"] = "Размер шрифта времени (0=авто)"
Gnosis.L["OptCBForceLatAlign"] = "Выравнивание задержки"
Gnosis.L["OptCBFrameStrata"] = "Слой фрейма"
Gnosis.L["OptCBGroupSelAlways"] = "соло, в группе или рейде (всегда)" -- Needs review
Gnosis.L["OptCBGroupSelPartyNotRaid"] = "в группе, но не в рейде" -- Needs review
Gnosis.L["OptCBGroupSelRaid"] = "в рейдовой группе" -- Needs review
Gnosis.L["OptCBGroupSelSolo"] = "соло, но не в рейде" -- Needs review
Gnosis.L["OptCBIconBorderSize"] = "Границы иконки (когда разблокировано)"
Gnosis.L["OptCBInstanceSelAlways"] = "inside or outside instance (always)" -- Requires localization
Gnosis.L["OptCBInstanceSelArena"] = "in arena" -- Requires localization
Gnosis.L["OptCBInstanceSelBattleground"] = "in battleground" -- Requires localization
Gnosis.L["OptCBInstanceSelFiveMan"] = "in 5-man instance" -- Requires localization
Gnosis.L["OptCBInstanceSelInside"] = "inside instance" -- Requires localization
Gnosis.L["OptCBInstanceSelOutside"] = "outside instance" -- Requires localization
Gnosis.L["OptCBInstanceSelRaid"] = "in raid instance" -- Requires localization
Gnosis.L["OptCBInvBarDir"] = "Обратить направление полос" -- Needs review
Gnosis.L["OptCBLatBoxCol"] = "Цвет блока задержки"
Gnosis.L["OptCBListBlack"] = "черный список"
Gnosis.L["OptCBListNeither"] = "никакой"
Gnosis.L["OptCBListWhite"] = "белый список"
Gnosis.L["OptCBLockAll_D"] = "Заблокировать все панели" -- Needs review
Gnosis.L["OptCBLockAll_N"] = "Заблокировать" -- Needs review
Gnosis.L["OptCBMaxLatBox"] = "Максимальный размер окна задержки [% полосы]" -- Needs review
Gnosis.L["OptCBNewCB_D"] = "Создание новой полоски заклинаний, должно быть задано допустимое название" -- Needs review
Gnosis.L["OptCBNewCB_N"] = "Новая полоска заклинаний" -- Needs review
Gnosis.L["OptCBNewCBName_D"] = "Введите название перед создание новой полоски заклинаний"
Gnosis.L["OptCBNewListElem_D"] = [=[Castbars:
Enter names of spells to black- or whitelist.

Multi-Spell Timer:
Basic format for every entry: cmds:spell/effect/item

More info @ Gnosis' description page at curse.com or in the .pdf which can be found in your WoW Folder/Addons/Gnosis (not yet done).]=] -- Needs review
Gnosis.L["OptCBNewListElem_N"] = "Введите название для добовления"
Gnosis.L["OptCBOrient"] = "Ориентация" -- Needs review
Gnosis.L["OptCBRelSel"] = "Показать произнесения" -- Needs review
Gnosis.L["OptCBRelSelAll"] = "все юниты" -- Needs review
Gnosis.L["OptCBRelSelEnemy"] = "вражеские юниты" -- Needs review
Gnosis.L["OptCBRelSelFriendly"] = "дружественные юниты" -- Needs review
Gnosis.L["OptCBRemCB"] = "Удалить полоску заклинаний" -- Needs review
Gnosis.L["OptCBRemListElem"] = "Удалить текущую запись"
Gnosis.L["OptCBRotIcon"] = "Повернуть иконку (°)"
Gnosis.L["OptCBRotLatencyN"] = "Повернуть задержку" -- Needs review
Gnosis.L["OptCBRotNameD"] = "Принудительное свободное выравнивание если задействовано" -- Needs review
Gnosis.L["OptCBRotNameN"] = "Повернуть имя" -- Needs review
Gnosis.L["OptCBRotTimeN"] = "Повернуть время" -- Needs review
Gnosis.L["OptCBScaleBar"] = "Масштаб полоски"
Gnosis.L["OptCBScaleIcon"] = "Масштаб иконки (когда разблок.)"
Gnosis.L["OptCBShowChanTicks"] = "Показать такт потокового закл."
Gnosis.L["OptCBShowIcon"] = "Показать иконку произнесения"
Gnosis.L["OptCBShowLatBox"] = "Показать блок задержки"
Gnosis.L["OptCBShowShield"] = "Показывать щит для не прерываемых заклинаний" -- Needs review
Gnosis.L["OptCBShowSpark"] = "Показать искру полоски заклинания"
Gnosis.L["OptCBSizeGrp"] = "Форма полосы и значков" -- Needs review
Gnosis.L["OptCBSparkColor"] = "Цвет искры"
Gnosis.L["OptCBSparkHeight"] = "Высота искры"
Gnosis.L["OptCBSparkWidth"] = "Ширина искры"
Gnosis.L["OptCBSWNC"] = "Показать когда неичего не произносится"
Gnosis.L["OptCBTabColors"] = "Цвета" -- Needs review
Gnosis.L["OptCBTabHide"] = "Скрыть полосу заклинаний" -- Needs review
Gnosis.L["OptCBTabText"] = "Текст" -- Needs review
Gnosis.L["OptCBTextAlignment"] = "Выравнивание (названия к времени)"
Gnosis.L["OptCBTextColLat"] = "Цвет текста (задержки)"
Gnosis.L["OptCBTextColName"] = "Цвет текста (названия)"
Gnosis.L["OptCBTextColPB"] = "Цвет текста (оттеснения)" -- Needs review
Gnosis.L["OptCBTextColTime"] = "Цвет текста (времени)"
Gnosis.L["OptCBTexture"] = "Текстура полоски заклинаний"
Gnosis.L["OptCBUnit"] = "Объект"
Gnosis.L["OptCBUnl_D"] = "Разблокировать полоску заклинаний (всегда показывать)"
Gnosis.L["OptCBUnl_N"] = "Разблок. полоску заклинаний" -- Needs review
Gnosis.L["OptCBUnlockAll_D"] = "Разблокировать все панели. Отключенные панели или панели выбранные для другого навыка специализации будут разблокированы, но останутся невидимы." -- Needs review
Gnosis.L["OptCBUnlockAll_N"] = "Разблокировать" -- Needs review
Gnosis.L["OptCBUnlockIcon_D"] = "Разблокировать иконку от полоски"
Gnosis.L["OptCBUnlockIcon_N"] = "Разблок. иконку"
Gnosis.L["OptCBWordWrapD"] = "Allow text to wrap to additional lines" -- Requires localization
Gnosis.L["OptCBWordWrapN"] = "Allow word wrap" -- Requires localization
Gnosis.L["OptCHCastnameGrp"] = "Опции названия произнесения" -- Needs review
Gnosis.L["OptCHCasttimeGrp"] = "Опции времени произнесения" -- Needs review
Gnosis.L["OptClipWarn_Desc"] = "Предупредить о обрывании перед тактом потокового заклинания на потоковых не AoE заклинаниях."
Gnosis.L["OptClipWarn_Name"] = "Предупреждение обрывания [мс]" -- Needs review
Gnosis.L["OptCombTicks"] = "Объединять такты и вывод через текст боя."
Gnosis.L["OptConfDelConf"] = "Удалить настройки"
Gnosis.L["OptConfDelConfMBText"] = "Вы уверены, что хотите удалить настройки |cffffff7f%s|r?" -- Needs review
Gnosis.L["OptConfLoadCBs"] = "Загрузить полоски заклинаний"
Gnosis.L["OptConfLoadChan"] = "Загрузить потоковые заклинания"
Gnosis.L["OptConfLoadCT"] = "Загрузить настройки текста боя/тест обрывания"
Gnosis.L["OptConfLoadMain"] = "Загрузить настройки основной вкладки"
Gnosis.L["OptConfName"] = "Название конфикурации"
Gnosis.L["OptConfSave"] = "Сохранить конфикурацию"
Gnosis.L["OptConfStoreCBs"] = "Сохранить полоски заклинаний"
Gnosis.L["OptConfStoreChan"] = "Сохранить данные потоковых заклинаний"
Gnosis.L["OptConfStoreCT"] = "Сохранить текст боя/тест обрывания"
Gnosis.L["OptConfStoreMain"] = "Сохранить настройки основной закладки модификации"
Gnosis.L["OptConfUpdConf"] = "Обновить натройки" -- Needs review
Gnosis.L["OptConfUpdConfMBText"] = "Вы уверены, что хотите обновить настройки |cffffff7f%s|r (чтобы включить установки)?" -- Needs review
Gnosis.L["OptCopytonewbarExists"] = "полоска уже существует, не может скопировать полоску и задать название"
Gnosis.L["OptCopytonewbarInvalidName"] = "введите допустимое название полоски перед копированием новой полоски"
Gnosis.L["OptCreateCBSet"] = "Создать базовый набор полоски (быстрое начало)"
Gnosis.L["OptCreatenewbarExists"] = "полоска уже существует, не можно создать полоски с задонным названием"
Gnosis.L["OptCreatenewbarInvalidName"] = "введите допустимое название полоски перед созданием новой"
Gnosis.L["OptCreateNewSpell"] = "Создать новое заклинание"
Gnosis.L["OptCSFSClip"] = "Размер шрифта (обрывание, 0=по умолчанию)"
Gnosis.L["OptCSFSNonClip"] = "Размер шрифта (без обрывания, 0=по умолчанию)"
Gnosis.L["OptCSRemove"] = "Удалить заклинание"
Gnosis.L["OptCTO"] = "Вывод текста боя"
Gnosis.L["OptCTO_Blizz"] = "Текст боя Blizzard"
Gnosis.L["OptCTO_MSBT"] = "Mik's Scrolling Battle Text"
Gnosis.L["OptCTO_Parrot"] = "Parrot"
Gnosis.L["OptCTO_SCT"] = "Scrolling Combat Text"
Gnosis.L["OptEn"] = "Включить"
Gnosis.L["OptEnAutoCreateOptons"] = "Автоматически создавать таблицы опций при запуске" -- Needs review
Gnosis.L["OptEnClipTest"] = "Включить тест обрывания"
Gnosis.L["OptExportAllBars"] = "Экспортировать все панели" -- Needs review
Gnosis.L["OptFile"] = "File" -- Requires localization
Gnosis.L["OptFirstStartFrame"] = "Открыть начальный фрейм" -- Needs review
Gnosis.L["OptFirstTickInst"] = "Первый такт, мгновенный"
Gnosis.L["OptFontEnShOffset"] = "Включить особый теневой отступ" -- Needs review
Gnosis.L["OptFontResizeLongName"] = "Изменить размер длинных строк"
Gnosis.L["OptFontShOffsetXYDesc"] = "Задать отступ между текстом и тенью текста" -- Needs review
Gnosis.L["OptFontShOffsetXYName"] = "Отступ тени x, y" -- Needs review
Gnosis.L["OptHasteAddsTicks"] = "Скорость заклинаний добавляет тики" -- Needs review
Gnosis.L["OptHeight"] = "Высота"
Gnosis.L["OptHideAddonMsgs"] = "Скрыть текстовые сообщения Gnosis'а"
Gnosis.L["OptHideBlizzCB"] = "Скрыть полоску заклинаний Blizzard"
Gnosis.L["OptHidecasttime"] = "Скрыть остаток времени" -- Needs review
Gnosis.L["OptHidecasttimeTotal"] = "Скрыть общее время" -- Needs review
Gnosis.L["OptHideMirrorCB"] = "Скрыть зеркало полоски заклинаний Blizzard"
Gnosis.L["OptHideNonPlayerTicks"] = "Скрыть тики на полосах заклинаний НПС" -- Needs review
Gnosis.L["OptHidePetCB"] = "Скрыть полосу питомца/транспорта Blizzard" -- Needs review
Gnosis.L["OptHidepushbackTime"] = "Скрытьвремя оттеснения" -- Needs review
Gnosis.L["OptImportBar"] = "Импортировать полосы (перезагружает интерфейс)" -- Needs review
Gnosis.L["OptLoadOptionsButtonDesc"] = "Таблицы опций для уменьшения занимаемой Gnosis памяти еще не созданы. После загрузки вы сможете выбрать автоматическое создание таблиц опций во время следующего запуска WoW (или перезагрузить интерфейс)." -- Needs review
Gnosis.L["OptLoadOptionsButtonName"] = "Создать опции..." -- Needs review
Gnosis.L["OptLocale"] = "Выберите локализацию"
Gnosis.L["OptMergetradeskillDesc"] = "Объединить ремесла (только полоска игрока)"
Gnosis.L["OptMergetradeskillName"] = "Объединить ремесла"
Gnosis.L["OptMusic"] = "Музыка"
Gnosis.L["OptNameFormatStringDesc"] = [=[Введите строку для показа в качестве названия

name: название заклинания
abbr<cnt>: сокращение названия заклинания если оно длинеее чем cnt, тоже что и название
rank<text>: показать уровень если доступен
misc: показать разную информацию если нет уровня
arabic: уровень арабскими цифрами (пример: 13)
roman: уровень римскими цифрами (пример: XIII)
txr<text>: показать текст, если доступна информация о уровне
txm<text>: показать текст, если доступна разная информация
target: показать название цели, если доступно (только игрок)
tar<text>: показать текст если доступна информация о цели (только игрок)
who: show name of casting unit

col<r,g,b[,a]>: Пример - col<1.0,1.0,0.0> изменяет цвет
col<school>: какая школа, темная магия, огонь...
col<pre>: изменить цвет на предыдущий

tscur: показать количество оставшихся предметов ремесла
tstot: показать общее количество предметов ремесла
txts<text>: показать текст если доступна информация о ремесле

\n: force new line]=] -- Needs review
Gnosis.L["OptNameFormatStringName"] = "Формат строк названия"
Gnosis.L["OptNameFormatToggleDesc"] = "Если включено 'Показать название заклинания' и 'Показать уровень заклинания' то выбор будет игнорироваться."
Gnosis.L["OptNameFormatToggleName"] = "Включить формат строк названия"
Gnosis.L["OptOutputString"] = "Строка вывода"
Gnosis.L["OptOutputStringDesc"] = [=[Введите строку для показа текста журнала боя
spellname: название потокового заклинания
dmg: количество урона или лечения совершенного потоковым заклинанием
eh: эффективное лечение
oh: избыточное лечение
dps: урон в сек. или лечение в сек. потокового заклинания
target: имя цели потокового заклинания
clipped: информация имел ли место случайный обрыв заклинания
cliptext <ваш текст>: строка текста, которая заменяет строку при обрыве, если необходимо

hits: количество попаданий
crits: количество критических попаданий
ticks: количество тактов
tickscrits: выводит количество тактов и критических попаданий

Выше используйте следующие обозначения, которые добавляются к выводимым значениям:
hittext<ваш текст>: обозначение для попаданий
crittext<ваш текст>: обозначение для критических попаданий
ticktext<ваш текст>: обозначение для тактов

col<r,g,b[,a]>: например col<1.0,1.0,0.0> чтобы изменить текст
col<школа>: где школа - Arcane (Тайной магии), Shadow (Темной магии) итд
col<pre>: изменить цвет на предыдущий
col<class>: изменить цвет на цвет класса (если доступно)
col<cpre>: вернуть прежние цвета (если цвет класса доступен)]=] -- Needs review
Gnosis.L["OptPFoC"] = "Play file on clip" -- Requires localization
Gnosis.L["OptPlayFile"] = "Play custom file" -- Requires localization
Gnosis.L["OptPlayMusic"] = "Проиграть файл музыки" -- Needs review
Gnosis.L["OptPlaySnd"] = "Приграть звук"
Gnosis.L["OptPlayTickSound_D"] = "Отключает звук обрывания" -- Needs review
Gnosis.L["OptPlayTickSound_N"] = "Включить звук обрывания" -- Needs review
Gnosis.L["OptPMoC"] = "Проиграть музыку при обрывании"
Gnosis.L["OptPSoC"] = "Проиграть звук при обрывании"
Gnosis.L["OptResetPlayerData"] = "Сброс данных игрока (перезагрузка интерфейса)"
Gnosis.L["OptResizeOptions"] = "Изменить размер рамки интерфейса опций в начале загрузки" -- Needs review
Gnosis.L["OptSaveconfigExists"] = "конфигурация уже существует, удалите или измените название"
Gnosis.L["OptSaveconfigInvalidName"] = "не задано название конфигурации"
Gnosis.L["OptShowasminutesDesc"] = "Показать минуты вместо секунд, если больше чем 60с."
Gnosis.L["OptShowasminutesName"] = "Показать минуты"
Gnosis.L["OptShowCastNameDesc"] = "Настройка не будет использоваться если включен формат строки названия."
Gnosis.L["OptShowCastNameName"] = "Показать название заклинания"
Gnosis.L["OptShowCastRankDesc"] = "Настройка не будет использоваться если включен формат строки названия."
Gnosis.L["OptShowCastRankName"] = "Показать уровень заклинания"
Gnosis.L["OptShowPlayerLatency"] = "Показать задержку игрока (мс)"
Gnosis.L["OptShowSpellIcon"] = "Показать иконку заклинания"
Gnosis.L["OptSnd"] = "Звук"
Gnosis.L["OptSpellIsAoE"] = "Попадание закл. по нескольким существам" -- Needs review
Gnosis.L["OptSpellNameOrId"] = "Название или ID заклинания"
Gnosis.L["OptStickyClips"] = "Фиксация обрывания"
Gnosis.L["OptStrGapDesc"] = "Минимальный промежуток между названием заклинания и временем (чтобы решить, нужно ли изменять размер длинной строки)." -- Needs review
Gnosis.L["OptStrGapName"] = "Промежуток (название..время)"
Gnosis.L["OptTablesUnloaded_Name"] = "Таблицы опций еще не созданы" -- Needs review
Gnosis.L["OptTicksToShow"] = "Показать такт" -- Needs review
Gnosis.L["OptTimeFormatStringDesc"] = [=[Введите строку для показа в качестве времени

r<x>: остаток времени в секундах с x десятичными
t<x>: общее время в секундах с x десятичными
p<x>: время оттеснения в секундах с x десятичными

add s for sing or m for displaying time > 60s in minutes
e.g. r<1m> or p<2s>
add p to show value in percent
e.g. r<p>% / t<1p>%

col<r,g,b[,a]>: Пример - col<1.0,1.0,0.0> изменяет цвет
col<school>: какая школа, темная магия, огонь...
col<pre>: изменить цвет на предыдущий

\n: force new line

remark: используйте col<r,g,b> чтобы изменить цвет оттеснения заклинания, если нужно]=] -- Needs review
Gnosis.L["OptTimeFormatStringName"] = "Строки формата времени"
Gnosis.L["OptTimeFormatToggleDesc"] = "Если включено, все другие настройки формата времени будут игнорироваться."
Gnosis.L["OptTimeFormatToggleName"] = "Включить строки формата времени" -- Needs review
Gnosis.L["OptTimerScanEveryN"] = "Сканировать изменения таймера каждые [ms]" -- Needs review
Gnosis.L["OptTotTicks"] = "Всего тактов" -- Needs review
Gnosis.L["OptWfCL_Desc"] = "Задержка вывода/теста обрывания, после вывода/теста обрывания, требуется заданное время в миллисекундах для учета возможных задержек в журнале боя." -- Needs review
Gnosis.L["OptWfCL_Name"] = "Ожидание журнала боя [мс]"
Gnosis.L["OptWidth"] = "Ширина"
Gnosis.L["PasteScript"] = "Вставьте скрипт в окно редактирования" -- Needs review
Gnosis.L["PremadeNfs1"] = "cast |cffff0000(rank or misc, e.g. stacks)|r (tradeskill merge)" -- Requires localization
Gnosis.L["PremadeNfs2"] = "Произнести |cffff0000(значение эффектра ауры)|r" -- Needs review
Gnosis.L["PremadeNfs3"] = "|cffffff00unit name|r: cast" -- Requires localization
Gnosis.L["PremadeTfs1"] = "|cffff0000pushback|r remaining / total, e.g. |cffff0000+1.0|r 1.4 / 3.00" -- Requires localization
Gnosis.L["PremadeTfs2"] = "|cffff0000pushback|r remaining / total, same as above but without minutes display" -- Requires localization
Gnosis.L["PremadeTfs3"] = "remaining / total, higher precision, e.g. 1.45 / 3.000" -- Requires localization
Gnosis.L["SelPremadeStr"] = "Выберите предварительно созданную строку" -- Needs review
Gnosis.L["Strata_BACK"] = "Нижний"
Gnosis.L["Strata_DIALOG"] = "Наивысший"
Gnosis.L["Strata_HIGH"] = "Высокий"
Gnosis.L["Strata_LOW"] = "Низкий"
Gnosis.L["Strata_MEDIUM"] = "Средний"
Gnosis.L["TabAdaptToCT"] = "Адаптировать к типу заклинания" -- Needs review
Gnosis.L["TabCapBOTTOM"] = "ВНИЗУ" -- Needs review
Gnosis.L["TabCapBOTTOMLEFT"] = "ВНИЗУ СЛЕВА" -- Needs review
Gnosis.L["TabCapBOTTOMRIGHT"] = "ВНИЗУ СПРАВА" -- Needs review
Gnosis.L["TabCapCENTER"] = "ЦЕНТР"
Gnosis.L["TabCapLEFT"] = "ЛЕВО"
Gnosis.L["TabCapNONE"] = "НЕТ" -- Needs review
Gnosis.L["TabCapRIGHT"] = "ПРАВО"
Gnosis.L["TabCapTOP"] = "ВВЕРХУ" -- Needs review
Gnosis.L["TabCapTOPLEFT"] = "ВВЕРХУ СЛЕВА" -- Needs review
Gnosis.L["TabCapTOPRIGHT"] = "ВВЕРХУ СПРАВА" -- Needs review
Gnosis.L["TabCastbars"] = "Полосы заклинаний" -- Needs review
Gnosis.L["TabChanneledSpells"] = "Потоковые заклинания"
Gnosis.L["TabConfig"] = "Настройки" -- Needs review
Gnosis.L["TabCTClipTest"] = "Текст боя/обрывания"
Gnosis.L["TabFreeAlign"] = "Свободное выравнивание"
Gnosis.L["TabNameTime"] = "Название...Время"
Gnosis.L["TabTimeName"] = "Время...Название"
Gnosis.L["Vertical"] = "Вертикально"
Gnosis.L["Yes"] = "Да" -- Needs review

elseif (self.s.strLocale == "frFR") then
-- frFR locale (french)
Gnosis.L["AddonName"] = "Gnosis"
Gnosis.L["BT_Castbar"] = "Castbar" -- Requires localization
Gnosis.L["BT_MSTimer"] = "Multi-Spell Timer" -- Requires localization
Gnosis.L["CBSetFocus"] = "Focus"
Gnosis.L["CBSetGCD"] = "GCD" -- Requires localization
Gnosis.L["CBSetMirror"] = "Miroir"
Gnosis.L["CBSetPet"] = "FamilierVehicule" -- Needs review
Gnosis.L["CBSetPlayer"] = "Joueur"
Gnosis.L["CBSetSwing"] = "Swing" -- Requires localization
Gnosis.L["CBSetTarget"] = "Cible"
Gnosis.L["CpyScriptFromEditBox"] = "Copy script from edit box (|cffffff7f%s|r)." -- Requires localization
Gnosis.L["Horizontal"] = "Horizontal" -- Requires localization
Gnosis.L["IfCCSetup"] = "Create common setup" -- Requires localization
Gnosis.L["IfCCSString"] = [=[Gnosis can create a common castbar setup for you (bars for Player, Target, Focus, Mirror and Pet/Vehicle). The created bars will be unlocked and can be moved by dragging while holding down the left mouse button. Right clicking the bars will call the castbar configuration gui.

You should lock the bars when you are finished with moving and customizing. Both blizzard castbar and mirror castbar will be deactivated. You can also create a "Global Cooldown Indicator" and a "Swing Timer" (one handed melee and range including wand) by pressing the button below. The slash command to call the Gnosis gui is "/gnosis".
]=] -- Requires localization
Gnosis.L["IfCCTimers"] = "Create GCD/Swing timers" -- Requires localization
Gnosis.L["IfConfigs"] = "Configurations" -- Requires localization
Gnosis.L["IfCWAction"] = "Press button to close frame without taking any action" -- Requires localization
Gnosis.L["IfLFConigs"] = [=[
One or more stored configurations have been found. You can setup Gnosis by loading from any existing configuration, just press any of the buttons below (button name is the name of the configuration that will be loaded).
]=] -- Requires localization
Gnosis.L["IfNoCBs"] = "No bars found" -- Requires localization
Gnosis.L["IfOpenGUI"] = "Open config GUI" -- Requires localization
Gnosis.L["Import"] = "Import" -- Requires localization
Gnosis.L["ImportFromHyperlink"] = "Import bar configuration? If the bar already exists, it's configuration values will be overwritten." -- Requires localization
Gnosis.L["ImportKeepPos"] = "Import, keep position" -- Requires localization
Gnosis.L["MsgBlizCBIsDis"] = "La barre de cast Blizzard est déjà cachée par un autre addon" -- Needs review
Gnosis.L["MsgBlizCBRestored"] = "Barre de cast de Blizzard rétablie (voir options interface)" -- Needs review
Gnosis.L["MsgDis"] = "(désactivé)" -- Needs review
Gnosis.L["MsgDisBlizCB"] = "Barre de cast de Blizzard désactivée (voir options interface)" -- Needs review
Gnosis.L["MsgDisMirrCB"] = "Barre miroir par défaut désactivée (voir options interface)" -- Needs review
Gnosis.L["MsgDisPetCB"] = "disabled blizzard pet/vehicle castbar (see gui options)" -- Requires localization
Gnosis.L["MsgEn"] = "(activé)" -- Needs review
Gnosis.L["MsgLoaded"] = "chargé" -- Needs review
Gnosis.L["MsgMirrCBIsDis"] = "La barre miroir par défaut est déjà masquée par un autre addon" -- Needs review
Gnosis.L["MsgMirrCBRestored"] = "Barre miroir par défaut rétablie (voir options interface)" -- Needs review
Gnosis.L["MsgPetCBIsDis"] = "blizzard pet/vehicle castbar already hidden by another addon" -- Requires localization
Gnosis.L["MsgPetCBRestored"] = "blizzard pet/vehicle castbar restored (see gui options)" -- Requires localization
Gnosis.L["No"] = "No" -- Requires localization
Gnosis.L["NoImport"] = "Don't import" -- Requires localization
Gnosis.L["OptAddonDisabled_Name"] = "Addon désactivé, activez-le pour accéder à l'onglet de configuration" -- Needs review
Gnosis.L["OptAddonEnable_Desc"] = "Activer Gnosis" -- Needs review
Gnosis.L["OptAddonEnable_Name"] = "Activer l'addon" -- Needs review
Gnosis.L["OptBarXYcoordDesc"] = "coordonées X,Y" -- Needs review
Gnosis.L["OptBarXYcoordName"] = "Position de la barre: X,Y" -- Needs review
Gnosis.L["OptCBActiveSpec"] = "Enabled for talent spec" -- Requires localization
Gnosis.L["OptCBAddListElem"] = "Ajouter une entrée" -- Needs review
Gnosis.L["OptCBAdjIcon"] = "Ajuster la position de l'icône (quand déverrouillé)" -- Needs review
Gnosis.L["OptCBAdjLatTextCoord"] = "Ajuster la position du texte de latence" -- Needs review
Gnosis.L["OptCBAdjNamePos"] = "Ajuster la position du nom" -- Needs review
Gnosis.L["OptCBAlignName"] = "Ajuster le nom de l'incantation" -- Needs review
Gnosis.L["OptCBAlignTime"] = "Ajuster le temps d'incantation" -- Needs review
Gnosis.L["OptCBAlignTimeCoord"] = "Ajuster la position du temps" -- Needs review
Gnosis.L["OptCBAlpha"] = "Alpha de la barre" -- Needs review
Gnosis.L["OptCBAnc"] = "Anchoring" -- Requires localization
Gnosis.L["OptCBAncBarAncPnt"] = "Gnosis bar anchor point" -- Requires localization
Gnosis.L["OptCBAncFrameAncPnt"] = "Anchor frame anchor point" -- Requires localization
Gnosis.L["OptCBAncFrameName"] = "Anchor to frame" -- Requires localization
Gnosis.L["OptCBAncNoAnc"] = "No anchor" -- Requires localization
Gnosis.L["OptCBAncOffset"] = "Offset x,y" -- Requires localization
Gnosis.L["OptCBAncToCursor"] = "Anchor to cursor" -- Requires localization
Gnosis.L["OptCBAncToFrame"] = "Anchor to frame" -- Requires localization
Gnosis.L["OptCBAncType"] = "Anchor type" -- Requires localization
Gnosis.L["OptCBBarType"] = "Bartype" -- Requires localization
Gnosis.L["OptCBBorderCol"] = "Couleur de la bordure" -- Needs review
Gnosis.L["OptCBBorderColInt"] = "Border color (non interruptible)" -- Requires localization
Gnosis.L["OptCBBorderSize"] = "Border size" -- Requires localization
Gnosis.L["OptCBBorderTex_D"] = "Additional border texture of fixed size. You might want to unlock the icon and reduce the normal border size to 0 when using additional border textures. This border texture will not affect the icon border." -- Requires localization
Gnosis.L["OptCBBorderTex_N"] = "Additional border texture" -- Requires localization
Gnosis.L["OptCBBWListedSpells"] = "Configuration des sorts et timers en liste noire/blanche" -- Needs review
Gnosis.L["OptCBCBBgCol"] = "Castbar background color" -- Requires localization
Gnosis.L["OptCBCBColFail"] = "Castbar color (failed)" -- Requires localization
Gnosis.L["OptCBCBColInt"] = "Castbar color (interrupted)" -- Requires localization
Gnosis.L["OptCBCBColor"] = "Castbar color" -- Requires localization
Gnosis.L["OptCBCBNIColor"] = "Castbar color (non interruptible)" -- Requires localization
Gnosis.L["OptCBCBShColor"] = "Text shadow color" -- Requires localization
Gnosis.L["OptCBCBSucColor"] = "Cast success (castbar color)" -- Requires localization
Gnosis.L["OptCBCenterCB"] = "Center bar" -- Requires localization
Gnosis.L["OptCBChannelsAsNormal"] = "Invert 'channeled' bar growth (most timer bars)" -- Requires localization
Gnosis.L["OptCBCombatSelAlways"] = "in and out of combat" -- Requires localization
Gnosis.L["OptCBCombatSelInC"] = "in combat only" -- Requires localization
Gnosis.L["OptCBCombatSelOoC"] = "out of combat only" -- Requires localization
Gnosis.L["OptCBCombSel"] = "Show castbar while" -- Requires localization
Gnosis.L["OptCBCopyCB_D"] = "Copy bar, make sure to enter valid name in new bar edit box." -- Requires localization
Gnosis.L["OptCBCopyCB_N"] = "Copy bar" -- Requires localization
Gnosis.L["OptCBEnCastSucDesc"] = "Change color when cast successfully finished" -- Requires localization
Gnosis.L["OptCBEnCastSucName"] = "Enable cast success" -- Requires localization
Gnosis.L["OptCBEnCB"] = "Enable bar" -- Requires localization
Gnosis.L["OptCBEnList"] = "Enable/disable black- or whitelist" -- Requires localization
Gnosis.L["OptCBEnShCol"] = "Enable text shadow color" -- Requires localization
Gnosis.L["OptCBExportBar"] = "Export bar" -- Requires localization
Gnosis.L["OptCBExportBarChatlink_D"] = "Requires the chat frame's edit box to be shown." -- Requires localization
Gnosis.L["OptCBExportBarChatlink_N"] = "Paste import link to chat" -- Requires localization
Gnosis.L["OptCBExtendChannels_D"] = "Extend channeled spell while chain-casting same spell if recast before the last channel ended." -- Requires localization
Gnosis.L["OptCBExtendChannels_N"] = "Extend channels" -- Requires localization
Gnosis.L["OptCBFadeout"] = "Fadeout time" -- Requires localization
Gnosis.L["OptCBFillAtEnd"] = "Fill bar up at castend" -- Requires localization
Gnosis.L["OptCBFixLatBox"] = "Fixed size of non player tick box [% of bar]" -- Requires localization
Gnosis.L["OptCBFont"] = "Font" -- Requires localization
Gnosis.L["OptCBFontOutline"] = "Font outline" -- Requires localization
Gnosis.L["OptCBFontSizeLat"] = "Latency font size (0=automatic)" -- Requires localization
Gnosis.L["OptCBFontSizeName"] = "Name font size (0=automatic)" -- Requires localization
Gnosis.L["OptCBFontSizeTime"] = "Timer font size (0=automatic)" -- Requires localization
Gnosis.L["OptCBForceLatAlign"] = "Force latency alignment" -- Requires localization
Gnosis.L["OptCBFrameStrata"] = "Frame strata" -- Requires localization
Gnosis.L["OptCBGroupSelAlways"] = "solo, in party or raid (always)" -- Requires localization
Gnosis.L["OptCBGroupSelPartyNotRaid"] = "in party, not in raid" -- Requires localization
Gnosis.L["OptCBGroupSelRaid"] = "in raid group" -- Requires localization
Gnosis.L["OptCBGroupSelSolo"] = "solo, not in raid" -- Requires localization
Gnosis.L["OptCBIconBorderSize"] = "Icon border (when unlocked)" -- Requires localization
Gnosis.L["OptCBInstanceSelAlways"] = "inside or outside instance (always)" -- Requires localization
Gnosis.L["OptCBInstanceSelArena"] = "in arena" -- Requires localization
Gnosis.L["OptCBInstanceSelBattleground"] = "in battleground" -- Requires localization
Gnosis.L["OptCBInstanceSelFiveMan"] = "in 5-man instance" -- Requires localization
Gnosis.L["OptCBInstanceSelInside"] = "inside instance" -- Requires localization
Gnosis.L["OptCBInstanceSelOutside"] = "outside instance" -- Requires localization
Gnosis.L["OptCBInstanceSelRaid"] = "in raid instance" -- Requires localization
Gnosis.L["OptCBInvBarDir"] = "Invert bar direction" -- Requires localization
Gnosis.L["OptCBLatBoxCol"] = "Latency box color" -- Requires localization
Gnosis.L["OptCBListBlack"] = "blacklist" -- Requires localization
Gnosis.L["OptCBListNeither"] = "neither" -- Requires localization
Gnosis.L["OptCBListWhite"] = "whitelist" -- Requires localization
Gnosis.L["OptCBLockAll_D"] = "Lock all bars" -- Requires localization
Gnosis.L["OptCBLockAll_N"] = "Lock" -- Requires localization
Gnosis.L["OptCBMaxLatBox"] = "Maximum size of latency box [% of bar]" -- Requires localization
Gnosis.L["OptCBNewCB_D"] = [=[Create new bar. Please enter a valid name in the adjacent edit box.

Holding the shift key will create an icon-like bar.]=] -- Requires localization
Gnosis.L["OptCBNewCB_N"] = "New (icon-like) bar" -- Requires localization
Gnosis.L["OptCBNewCBName_D"] = "Enter name before creating new castbar" -- Requires localization
Gnosis.L["OptCBNewListElem_D"] = [=[Castbars:
Enter names of spells to black- or whitelist.

Multi-Spell Timer:
Basic format for entries: cmds [options] : type

More info @ Gnosis' description page at curse.com and in the .pdf documents within your WoW Folder/Addons/Gnosis.]=] -- Requires localization
Gnosis.L["OptCBNewListElem_N"] = "Enter spell name to add" -- Requires localization
Gnosis.L["OptCBOrient"] = "Orientation" -- Requires localization
Gnosis.L["OptCBRelSel"] = "Show casts of" -- Requires localization
Gnosis.L["OptCBRelSelAll"] = "all units" -- Requires localization
Gnosis.L["OptCBRelSelEnemy"] = "enemy units" -- Requires localization
Gnosis.L["OptCBRelSelFriendly"] = "friendly units" -- Requires localization
Gnosis.L["OptCBRemCB"] = "Remove bar" -- Requires localization
Gnosis.L["OptCBRemListElem"] = "Remove current entry" -- Requires localization
Gnosis.L["OptCBRotIcon"] = "Rotate Icon (°)" -- Requires localization
Gnosis.L["OptCBRotLatencyN"] = "Rotate latency" -- Requires localization
Gnosis.L["OptCBRotNameD"] = "Forces free alignment if used" -- Requires localization
Gnosis.L["OptCBRotNameN"] = "Rotate name" -- Requires localization
Gnosis.L["OptCBRotTimeN"] = "Rotate time" -- Requires localization
Gnosis.L["OptCBScaleBar"] = "Scale bar" -- Requires localization
Gnosis.L["OptCBScaleIcon"] = "Scale icon (when unlocked)" -- Requires localization
Gnosis.L["OptCBShowChanTicks"] = "Show channeled ticks" -- Requires localization
Gnosis.L["OptCBShowIcon"] = "Show cast icon" -- Requires localization
Gnosis.L["OptCBShowLatBox"] = "Show latency box" -- Requires localization
Gnosis.L["OptCBShowShield"] = "Show shield for non-interruptible casts" -- Requires localization
Gnosis.L["OptCBShowSpark"] = "Show castbar spark" -- Requires localization
Gnosis.L["OptCBSizeGrp"] = "Bar shape and visuals" -- Requires localization
Gnosis.L["OptCBSparkColor"] = "Spark color" -- Requires localization
Gnosis.L["OptCBSparkHeight"] = "Spark height" -- Requires localization
Gnosis.L["OptCBSparkWidth"] = "Spark width" -- Requires localization
Gnosis.L["OptCBSWNC"] = "Show when not casting" -- Requires localization
Gnosis.L["OptCBTabColors"] = "Colors" -- Requires localization
Gnosis.L["OptCBTabHide"] = "Hide castbar" -- Requires localization
Gnosis.L["OptCBTabText"] = "Text" -- Requires localization
Gnosis.L["OptCBTextAlignment"] = "Alignment (name to time)" -- Requires localization
Gnosis.L["OptCBTextColLat"] = "Text color (latency)" -- Requires localization
Gnosis.L["OptCBTextColName"] = "Text color (name)" -- Requires localization
Gnosis.L["OptCBTextColPB"] = "Text color (pushback)" -- Requires localization
Gnosis.L["OptCBTextColTime"] = "Text color (time)" -- Requires localization
Gnosis.L["OptCBTexture"] = "Castbar texture" -- Requires localization
Gnosis.L["OptCBUnit"] = "Unit" -- Requires localization
Gnosis.L["OptCBUnl_D"] = "Unlock castbar (always shown)" -- Requires localization
Gnosis.L["OptCBUnl_N"] = "Unlock bar (movable)" -- Requires localization
Gnosis.L["OptCBUnlockAll_D"] = "Unlock all bars. Disabled bars or bars selected for another talent specialization will be unlocked but will still not be visible." -- Requires localization
Gnosis.L["OptCBUnlockAll_N"] = "Unlock" -- Requires localization
Gnosis.L["OptCBUnlockIcon_D"] = "Unlock icon from bar" -- Requires localization
Gnosis.L["OptCBUnlockIcon_N"] = "Unlock icon" -- Requires localization
Gnosis.L["OptCBWordWrapD"] = "Allow text to wrap to additional lines" -- Requires localization
Gnosis.L["OptCBWordWrapN"] = "Allow word wrap" -- Requires localization
Gnosis.L["OptCHCastnameGrp"] = "Castname options" -- Requires localization
Gnosis.L["OptCHCasttimeGrp"] = "Casttime options" -- Requires localization
Gnosis.L["OptClipWarn_Desc"] = "Warn when clipping shortly before channel tick occurs on non aoe channeled spells." -- Requires localization
Gnosis.L["OptClipWarn_Name"] = "Clipping warning [ms]" -- Requires localization
Gnosis.L["OptCombTicks"] = "Combine ticks and output via combat text" -- Requires localization
Gnosis.L["OptConfDelConf"] = "Remove config" -- Requires localization
Gnosis.L["OptConfDelConfMBText"] = "Sure to delete configuration |cffffff7f%s|r?" -- Requires localization
Gnosis.L["OptConfLoadCBs"] = "Load castbars" -- Requires localization
Gnosis.L["OptConfLoadChan"] = "Load channeled spells" -- Requires localization
Gnosis.L["OptConfLoadCT"] = "Load combattext/cliptest settings" -- Requires localization
Gnosis.L["OptConfLoadMain"] = "Load main tab settings" -- Requires localization
Gnosis.L["OptConfName"] = "Configuration name" -- Requires localization
Gnosis.L["OptConfSave"] = "Save configuration" -- Requires localization
Gnosis.L["OptConfStoreCBs"] = "Store castbars" -- Requires localization
Gnosis.L["OptConfStoreChan"] = "Store channeled spells data" -- Requires localization
Gnosis.L["OptConfStoreCT"] = "Store combattext/cliptest settings" -- Requires localization
Gnosis.L["OptConfStoreMain"] = "Store addon main config tab settings" -- Requires localization
Gnosis.L["OptConfUpdConf"] = "Update config" -- Requires localization
Gnosis.L["OptConfUpdConfMBText"] = "Sure to update configuration |cffffff7f%s|r (to active settings)?" -- Requires localization
Gnosis.L["OptCopytonewbarExists"] = "bar already exists, cannot copy bar to given name" -- Requires localization
Gnosis.L["OptCopytonewbarInvalidName"] = "enter valid bar name before copying to a new bar" -- Requires localization
Gnosis.L["OptCreateCBSet"] = "Create basic castbar set (quick start)" -- Requires localization
Gnosis.L["OptCreatenewbarExists"] = "bar already exists, cannot create bar with given name" -- Requires localization
Gnosis.L["OptCreatenewbarInvalidName"] = "enter valid bar name before creating new bar" -- Requires localization
Gnosis.L["OptCreateNewSpell"] = "Create new spell" -- Requires localization
Gnosis.L["OptCSFSClip"] = "Font size (clip, 0=default)" -- Requires localization
Gnosis.L["OptCSFSNonClip"] = "Font size (non clip, 0=default)" -- Requires localization
Gnosis.L["OptCSRemove"] = "Remove spell" -- Requires localization
Gnosis.L["OptCTO"] = "Combat text output" -- Requires localization
Gnosis.L["OptCTO_Blizz"] = "Blizzard's Floating Combat Text" -- Requires localization
Gnosis.L["OptCTO_MSBT"] = "Mik's Scrolling Battle Text" -- Requires localization
Gnosis.L["OptCTO_Parrot"] = "Parrot" -- Requires localization
Gnosis.L["OptCTO_SCT"] = "Scrolling Combat Text" -- Requires localization
Gnosis.L["OptEn"] = "Enable" -- Requires localization
Gnosis.L["OptEnAutoCreateOptons"] = "Automatically create option tables on startup" -- Requires localization
Gnosis.L["OptEnClipTest"] = "Enable clip test" -- Requires localization
Gnosis.L["OptExportAllBars"] = "Export all bars" -- Requires localization
Gnosis.L["OptFile"] = "File" -- Requires localization
Gnosis.L["OptFirstStartFrame"] = "Open first start frame" -- Requires localization
Gnosis.L["OptFirstTickInst"] = "First tick is instant" -- Requires localization
Gnosis.L["OptFontEnShOffset"] = "Enable specific shadow offset" -- Requires localization
Gnosis.L["OptFontResizeLongName"] = "Resize long strings" -- Requires localization
Gnosis.L["OptFontShOffsetXYDesc"] = "Setup offset between text and shadow of text" -- Requires localization
Gnosis.L["OptFontShOffsetXYName"] = "Shadow offset x, y" -- Requires localization
Gnosis.L["OptHasteAddsTicks"] = "Spell haste adds ticks" -- Requires localization
Gnosis.L["OptHeight"] = "Height" -- Requires localization
Gnosis.L["OptHideAddonMsgs"] = "Hide Gnosis text messages" -- Requires localization
Gnosis.L["OptHideBlizzCB"] = "Hide Blizzard's castbar" -- Requires localization
Gnosis.L["OptHidecasttime"] = "Hide casttime left" -- Requires localization
Gnosis.L["OptHidecasttimeTotal"] = "Hide casttime total" -- Requires localization
Gnosis.L["OptHideMirrorCB"] = "Hide Blizzard's mirror castbar" -- Requires localization
Gnosis.L["OptHideNonPlayerTicks"] = "Hide ticks on non player castbars" -- Requires localization
Gnosis.L["OptHidePetCB"] = "Hide Blizzard's pet/vehicle castbar" -- Requires localization
Gnosis.L["OptHidepushbackTime"] = "Hide pushback time" -- Requires localization
Gnosis.L["OptImportBar"] = "Import bar(s)" -- Requires localization
Gnosis.L["OptLoadOptionsButtonDesc"] = "Option tables have not yet been created to reduce Gnosis' memory footprint. After loading you can select to automatically create options tables the next time you start wow (or reload the ui)." -- Requires localization
Gnosis.L["OptLoadOptionsButtonName"] = "Create options..." -- Requires localization
Gnosis.L["OptLocale"] = "Select localization" -- Requires localization
Gnosis.L["OptMergetradeskillDesc"] = "Merge tradeskill (player castbar only)." -- Requires localization
Gnosis.L["OptMergetradeskillName"] = "Merge tradeskill" -- Requires localization
Gnosis.L["OptMusic"] = "Music" -- Requires localization
Gnosis.L["OptNameFormatStringDesc"] = [=[Enter string to show as name

name: spellname
trunc<cnt>: truncate spellname if longer than cnt
abbr<cnt>: abbreviated spellname (acronym) if longer than cnt
rank<text>: show text if rank available
misc: show miscellaneous info if non rank
arabic: rank as arabic numeral (e.g. 13)
roman: rank as roman numeral (e.g. XIII)
txr<text>: show text if rank info available
txm<text>: show text if misc info available
target: show target name if available (player only)
tar<text>: show text if target information avaiable (player only)
tar[text]: same as above
who: show name of casting unit

col<r,g,b[,a]>: e.g. col<1.0,1.0,0.0> to change color
col<school>: where school is shadow,arcane...
col<pre>: change color to previous one
col<class>: change color to target class color (if available)
col<cpre>: revert to previous color (if target class color is available)

tscur: show remaining tradeskill item count
tstot: show total tradeskill item count
txts<text>: show text if tradeskill information available

\n: force new line (if word wrap is enabled)]=] -- Requires localization
Gnosis.L["OptNameFormatStringName"] = "Name format string" -- Requires localization
Gnosis.L["OptNameFormatToggleDesc"] = "If enabled 'Show cast name' and 'Show cast rank' selections ignored." -- Requires localization
Gnosis.L["OptNameFormatToggleName"] = "Enable name format string" -- Requires localization
Gnosis.L["OptOutputString"] = "Output string" -- Requires localization
Gnosis.L["OptOutputStringDesc"] = [=[Enter string to show as combat text output

spellname: name of channeled spell
dmg: amount of dmg or heal done by channel
eh: effective heal (= heal-overheal)
oh: overheal
dps: dps or hps of channel
target: target name of channel
clipped: information whether unintentional clip occured
cliptext<your text>: text string that replaces clipped if needed

hits: number of hits
crits: number of crits
ticks: number of ticks
tickscrits: outputs number of ticks and crits

above use following identifiers which are added to the displayed numbers
hittext<your text>: identifier for hits
crittext<your text>: identifier for crits
ticktext<your text>: identifier for ticks

col<r,g,b[,a]>: e.g. col<1.0,1.0,0.0> to change color
col<school>: where school is shadow,arcane...
col<pre>: change color to previous one
col<class>: change color to target class color (if available)
col<cpre>: revert to previous color (if target class color is available)]=] -- Requires localization
Gnosis.L["OptPFoC"] = "Play file on clip" -- Requires localization
Gnosis.L["OptPlayFile"] = "Play custom file" -- Requires localization
Gnosis.L["OptPlayMusic"] = "Play music" -- Requires localization
Gnosis.L["OptPlaySnd"] = "Play sound" -- Requires localization
Gnosis.L["OptPlayTickSound_D"] = "Deactivates clipping sound." -- Requires localization
Gnosis.L["OptPlayTickSound_N"] = "Play tick sound" -- Requires localization
Gnosis.L["OptPMoC"] = "Play music on clip" -- Requires localization
Gnosis.L["OptPSoC"] = "Play sound on clip" -- Requires localization
Gnosis.L["OptResetPlayerData"] = "Reset player data (reloads interface)" -- Requires localization
Gnosis.L["OptResizeOptions"] = "Resize interface options frame on startup" -- Requires localization
Gnosis.L["OptSaveconfigExists"] = "configuration already exists, please delete first or change name" -- Requires localization
Gnosis.L["OptSaveconfigInvalidName"] = "no configuration name given" -- Requires localization
Gnosis.L["OptShowasminutesDesc"] = "Show minutes instead of seconds if longer than than 60s." -- Requires localization
Gnosis.L["OptShowasminutesName"] = "Show minutes" -- Requires localization
Gnosis.L["OptShowCastNameDesc"] = "Option not used if name format string enabled." -- Requires localization
Gnosis.L["OptShowCastNameName"] = "Show cast name" -- Requires localization
Gnosis.L["OptShowCastRankDesc"] = "Option not used if name format string enabled." -- Requires localization
Gnosis.L["OptShowCastRankName"] = "Show cast rank" -- Requires localization
Gnosis.L["OptShowPlayerLatency"] = "Show player latency (ms)" -- Requires localization
Gnosis.L["OptShowSpellIcon"] = "Show spell icon" -- Requires localization
Gnosis.L["OptSnd"] = "Sound" -- Requires localization
Gnosis.L["OptSpellIsAoE"] = "Spell hits multiple mobs" -- Requires localization
Gnosis.L["OptSpellNameOrId"] = "Spellname or Spell ID" -- Requires localization
Gnosis.L["OptStickyClips"] = "Sticky clips" -- Requires localization
Gnosis.L["OptStrGapDesc"] = "Minimal gap between castname and time strings (to decide whether to resize long string)." -- Requires localization
Gnosis.L["OptStrGapName"] = "Gap (name...time)" -- Requires localization
Gnosis.L["OptTablesUnloaded_Name"] = "Option tables not yet created" -- Requires localization
Gnosis.L["OptTicksToShow"] = "Ticks to show" -- Requires localization
Gnosis.L["OptTimeFormatStringDesc"] = [=[Enter string to show as time

r<x>: remaining with x decimals places
t<x>: total
p<x>: pushback time
c<x>: total-remaining

add s for sign, m for displaying time > 60s in minutes and a for higher precision when below one second remaining (r<0a>)
e.g. r<1m> or p<2s>
add p to show value in percent
e.g. r<p>% / t<1p>%

col<r,g,b[,a]>: e.g. col<1.0,1.0,0.0> to change color
col<school>: where school is shadow,arcane...
col<pre>: change color to previous one

\n: force new line

remark: use col<r,g,b> to change color of spell pushback if needed]=] -- Requires localization
Gnosis.L["OptTimeFormatStringName"] = "Time format string" -- Requires localization
Gnosis.L["OptTimeFormatToggleDesc"] = "If enabled all other time formatting options are ignored." -- Requires localization
Gnosis.L["OptTimeFormatToggleName"] = "Enable time format string" -- Requires localization
Gnosis.L["OptTimerScanEveryN"] = "Scan for timer updates every [ms]" -- Requires localization
Gnosis.L["OptTotTicks"] = "Total ticks" -- Requires localization
Gnosis.L["OptWfCL_Desc"] = "Delay output/clip test after output/clip test request for given time in ms to account for possible combat log delay." -- Requires localization
Gnosis.L["OptWfCL_Name"] = "Wait for combat log [ms]" -- Requires localization
Gnosis.L["OptWidth"] = "Width" -- Requires localization
Gnosis.L["PasteScript"] = "Paste import data into edit box." -- Requires localization
Gnosis.L["PremadeNfs1"] = "cast |cffff0000(rank or misc, e.g. stacks)|r (tradeskill merge)" -- Requires localization
Gnosis.L["PremadeNfs2"] = "cast |cffff0000(aura effect value)|r" -- Requires localization
Gnosis.L["PremadeNfs3"] = "|cffffff00unit name|r: cast" -- Requires localization
Gnosis.L["PremadeTfs1"] = "|cffff0000pushback|r remaining / total, e.g. |cffff0000+1.0|r 1.4 / 3.00" -- Requires localization
Gnosis.L["PremadeTfs2"] = "|cffff0000pushback|r remaining / total, same as above but without minutes display" -- Requires localization
Gnosis.L["PremadeTfs3"] = "remaining / total, higher precision, e.g. 1.45 / 3.000" -- Requires localization
Gnosis.L["SelPremadeStr"] = "Select premade string" -- Requires localization
Gnosis.L["Strata_BACK"] = "Lowest" -- Requires localization
Gnosis.L["Strata_DIALOG"] = "Highest" -- Requires localization
Gnosis.L["Strata_HIGH"] = "High" -- Requires localization
Gnosis.L["Strata_LOW"] = "Low" -- Requires localization
Gnosis.L["Strata_MEDIUM"] = "Medium" -- Requires localization
Gnosis.L["TabAdaptToCT"] = "Adapt to casttype" -- Requires localization
Gnosis.L["TabCapBOTTOM"] = "BOTTOM" -- Requires localization
Gnosis.L["TabCapBOTTOMLEFT"] = "BOTTOMLEFT" -- Requires localization
Gnosis.L["TabCapBOTTOMRIGHT"] = "BOTTOMRIGHT" -- Requires localization
Gnosis.L["TabCapCENTER"] = "CENTER" -- Requires localization
Gnosis.L["TabCapLEFT"] = "LEFT" -- Requires localization
Gnosis.L["TabCapNONE"] = "NONE" -- Requires localization
Gnosis.L["TabCapRIGHT"] = "RIGHT" -- Requires localization
Gnosis.L["TabCapTOP"] = "TOP" -- Requires localization
Gnosis.L["TabCapTOPLEFT"] = "TOPLEFT" -- Requires localization
Gnosis.L["TabCapTOPRIGHT"] = "TOPRIGHT" -- Requires localization
Gnosis.L["TabCastbars"] = "Bar Configuration" -- Requires localization
Gnosis.L["TabChanneledSpells"] = "Channeled Spells" -- Requires localization
Gnosis.L["TabConfig"] = "Configurations (Profiles)" -- Requires localization
Gnosis.L["TabCTClipTest"] = "Combattext/Cliptest" -- Requires localization
Gnosis.L["TabFreeAlign"] = "Free alignment" -- Requires localization
Gnosis.L["TabNameTime"] = "Name...Time" -- Requires localization
Gnosis.L["TabTimeName"] = "Time...Name" -- Requires localization
Gnosis.L["Vertical"] = "Vertical" -- Requires localization
Gnosis.L["Yes"] = "Yes" -- Requires localization

else
-- default locale (english)
Gnosis.L["AddonName"] = "Gnosis"
Gnosis.L["BT_Castbar"] = "Castbar"
Gnosis.L["BT_MSTimer"] = "Multi-Spell Timer"
Gnosis.L["CBSetFocus"] = "Focus"
Gnosis.L["CBSetGCD"] = "GCD"
Gnosis.L["CBSetMirror"] = "Mirror"
Gnosis.L["CBSetPet"] = "PetVehicle"
Gnosis.L["CBSetPlayer"] = "Player"
Gnosis.L["CBSetSwing"] = "Swing"
Gnosis.L["CBSetTarget"] = "Target"
Gnosis.L["CpyScriptFromEditBox"] = "Copy script from edit box (|cffffff7f%s|r)."
Gnosis.L["Horizontal"] = "Horizontal"
Gnosis.L["IfCCSetup"] = "Create common setup"
Gnosis.L["IfCCSString"] = [=[Gnosis can create a common castbar setup for you (bars for Player, Target, Focus, Mirror and Pet/Vehicle). The created bars will be unlocked and can be moved by dragging while holding down the left mouse button. Right clicking the bars will call the castbar configuration gui.

You should lock the bars when you are finished with moving and customizing. Both blizzard castbar and mirror castbar will be deactivated. You can also create a "Global Cooldown Indicator" and a "Swing Timer" (one handed melee and range including wand) by pressing the button below. The slash command to call the Gnosis gui is "/gnosis".
]=]
Gnosis.L["IfCCTimers"] = "Create GCD/Swing timers"
Gnosis.L["IfConfigs"] = "Configurations"
Gnosis.L["IfCWAction"] = "Press button to close frame without taking any action"
Gnosis.L["IfLFConigs"] = [=[
One or more stored configurations have been found. You can setup Gnosis by loading from any existing configuration, just press any of the buttons below (button name is the name of the configuration that will be loaded).
]=]
Gnosis.L["IfNoCBs"] = "No bars found"
Gnosis.L["IfOpenGUI"] = "Open config GUI"
Gnosis.L["Import"] = "Import"
Gnosis.L["ImportFromHyperlink"] = "Import bar configuration? If the bar already exists, it's configuration values will be overwritten."
Gnosis.L["ImportKeepPos"] = "Import, keep position"
Gnosis.L["MsgBlizCBIsDis"] = "blizzard castbar already hidden by another addon"
Gnosis.L["MsgBlizCBRestored"] = "blizzard castbar restored (see gui options)"
Gnosis.L["MsgDis"] = "(disabled)"
Gnosis.L["MsgDisBlizCB"] = "disabled blizzard castbar (see gui options)"
Gnosis.L["MsgDisMirrCB"] = "disabled default mirror castbar (see gui options)"
Gnosis.L["MsgDisPetCB"] = "disabled blizzard pet/vehicle castbar (see gui options)"
Gnosis.L["MsgEn"] = "(enabled)"
Gnosis.L["MsgLoaded"] = "loaded"
Gnosis.L["MsgMirrCBIsDis"] = "default mirror castbar already hidden by another addon"
Gnosis.L["MsgMirrCBRestored"] = "default mirror castbar restored (see gui options)"
Gnosis.L["MsgPetCBIsDis"] = "blizzard pet/vehicle castbar already hidden by another addon"
Gnosis.L["MsgPetCBRestored"] = "blizzard pet/vehicle castbar restored (see gui options)"
Gnosis.L["No"] = "No"
Gnosis.L["NoImport"] = "Don't import"
Gnosis.L["OptAddonDisabled_Name"] = "Addon disabled, enable to access current config tab."
Gnosis.L["OptAddonEnable_Desc"] = "Toggle Gnosis"
Gnosis.L["OptAddonEnable_Name"] = "Enable Addon"
Gnosis.L["OptBarXYcoordDesc"] = "x,y-coordinate"
Gnosis.L["OptBarXYcoordName"] = "Bar position: x, y"
Gnosis.L["OptCBActiveSpec"] = "Enabled for talent spec"
Gnosis.L["OptCBAddListElem"] = "Add entry"
Gnosis.L["OptCBAdjIcon"] = "Adjust icon position (when unlocked)"
Gnosis.L["OptCBAdjLatTextCoord"] = "Adjust latency text position"
Gnosis.L["OptCBAdjNamePos"] = "Adjust name position"
Gnosis.L["OptCBAlignName"] = "Align castname"
Gnosis.L["OptCBAlignTime"] = "Align casttime"
Gnosis.L["OptCBAlignTimeCoord"] = "Adjust time position"
Gnosis.L["OptCBAlpha"] = "Bar alpha"
Gnosis.L["OptCBAnc"] = "Anchoring"
Gnosis.L["OptCBAncBarAncPnt"] = "Gnosis bar anchor point"
Gnosis.L["OptCBAncFrameAncPnt"] = "Anchor frame anchor point"
Gnosis.L["OptCBAncFrameName"] = "Anchor to frame"
Gnosis.L["OptCBAncNoAnc"] = "No anchor"
Gnosis.L["OptCBAncOffset"] = "Offset x,y"
Gnosis.L["OptCBAncToCursor"] = "Anchor to cursor"
Gnosis.L["OptCBAncToFrame"] = "Anchor to frame"
Gnosis.L["OptCBAncType"] = "Anchor type"
Gnosis.L["OptCBBarType"] = "Bartype"
Gnosis.L["OptCBBorderCol"] = "Border color"
Gnosis.L["OptCBBorderColInt"] = "Border color (non interruptible)"
Gnosis.L["OptCBBorderSize"] = "Border size"
Gnosis.L["OptCBBorderTex_D"] = "Additional border texture of fixed size. You might want to unlock the icon and reduce the normal border size to 0 when using additional border textures. This border texture will not affect the icon border."
Gnosis.L["OptCBBorderTex_N"] = "Additional border texture"
Gnosis.L["OptCBBWListedSpells"] = "Black-/whitelisted spells or timer config"
Gnosis.L["OptCBCBBgCol"] = "Castbar background color"
Gnosis.L["OptCBCBColFail"] = "Castbar color (failed)"
Gnosis.L["OptCBCBColInt"] = "Castbar color (interrupted)"
Gnosis.L["OptCBCBColor"] = "Castbar color"
Gnosis.L["OptCBCBNIColor"] = "Castbar color (non interruptible)"
Gnosis.L["OptCBCBShColor"] = "Text shadow color"
Gnosis.L["OptCBCBSucColor"] = "Cast success (castbar color)"
Gnosis.L["OptCBCenterCB"] = "Center bar"
Gnosis.L["OptCBChannelsAsNormal"] = "Invert 'channeled' bar growth (most timer bars)"
Gnosis.L["OptCBCombatSelAlways"] = "in and out of combat"
Gnosis.L["OptCBCombatSelInC"] = "in combat only"
Gnosis.L["OptCBCombatSelOoC"] = "out of combat only"
Gnosis.L["OptCBCombSel"] = "Show castbar while"
Gnosis.L["OptCBCopyCB_D"] = "Copy bar, make sure to enter valid name in new bar edit box."
Gnosis.L["OptCBCopyCB_N"] = "Copy bar"
Gnosis.L["OptCBEnCastSucDesc"] = "Change color when cast successfully finished"
Gnosis.L["OptCBEnCastSucName"] = "Enable cast success"
Gnosis.L["OptCBEnCB"] = "Enable bar"
Gnosis.L["OptCBEnList"] = "Enable/disable black- or whitelist"
Gnosis.L["OptCBEnShCol"] = "Enable text shadow color"
Gnosis.L["OptCBExportBar"] = "Export bar"
Gnosis.L["OptCBExportBarChatlink_D"] = "Requires the chat frame's edit box to be shown."
Gnosis.L["OptCBExportBarChatlink_N"] = "Paste import link to chat"
Gnosis.L["OptCBExtendChannels_D"] = "Extend channeled spell while chain-casting same spell if recast before the last channel ended."
Gnosis.L["OptCBExtendChannels_N"] = "Extend channels"
Gnosis.L["OptCBFadeout"] = "Fadeout time"
Gnosis.L["OptCBFillAtEnd"] = "Fill bar up at castend"
Gnosis.L["OptCBFixLatBox"] = "Fixed size of non player tick box [% of bar]"
Gnosis.L["OptCBFont"] = "Font"
Gnosis.L["OptCBFontOutline"] = "Font outline"
Gnosis.L["OptCBFontSizeLat"] = "Latency font size (0=automatic)"
Gnosis.L["OptCBFontSizeName"] = "Name font size (0=automatic)"
Gnosis.L["OptCBFontSizeTime"] = "Timer font size (0=automatic)"
Gnosis.L["OptCBForceLatAlign"] = "Force latency alignment"
Gnosis.L["OptCBFrameStrata"] = "Frame strata"
Gnosis.L["OptCBGroupSelAlways"] = "solo, in party or raid (always)"
Gnosis.L["OptCBGroupSelPartyNotRaid"] = "in party, not in raid"
Gnosis.L["OptCBGroupSelRaid"] = "in raid group"
Gnosis.L["OptCBGroupSelSolo"] = "solo, not in raid"
Gnosis.L["OptCBIconBorderSize"] = "Icon border (when unlocked)"
Gnosis.L["OptCBInstanceSelAlways"] = "inside or outside instance (always)"
Gnosis.L["OptCBInstanceSelArena"] = "in arena"
Gnosis.L["OptCBInstanceSelBattleground"] = "in battleground"
Gnosis.L["OptCBInstanceSelFiveMan"] = "in 5-man instance"
Gnosis.L["OptCBInstanceSelInside"] = "inside instance"
Gnosis.L["OptCBInstanceSelOutside"] = "outside instance"
Gnosis.L["OptCBInstanceSelRaid"] = "in raid instance"
Gnosis.L["OptCBInvBarDir"] = "Invert bar direction"
Gnosis.L["OptCBLatBoxCol"] = "Latency box color"
Gnosis.L["OptCBListBlack"] = "blacklist"
Gnosis.L["OptCBListNeither"] = "neither"
Gnosis.L["OptCBListWhite"] = "whitelist"
Gnosis.L["OptCBLockAll_D"] = "Lock all bars"
Gnosis.L["OptCBLockAll_N"] = "Lock"
Gnosis.L["OptCBMaxLatBox"] = "Maximum size of latency box [% of bar]"
Gnosis.L["OptCBNewCB_D"] = [=[Create new bar. Please enter a valid name in the adjacent edit box.

Holding the shift key will create an icon-like bar.]=]
Gnosis.L["OptCBNewCB_N"] = "New (icon-like) bar"
Gnosis.L["OptCBNewCBName_D"] = "Enter name before creating new castbar"
Gnosis.L["OptCBNewListElem_D"] = [=[Castbars:
Enter names of spells to black- or whitelist.

Multi-Spell Timer:
Basic format for entries: cmds [options] : type

More info @ Gnosis' description page at curse.com and in the .pdf documents within your WoW Folder/Addons/Gnosis.]=]
Gnosis.L["OptCBNewListElem_N"] = "Enter spell name to add"
Gnosis.L["OptCBOrient"] = "Orientation"
Gnosis.L["OptCBRelSel"] = "Show casts of"
Gnosis.L["OptCBRelSelAll"] = "all units"
Gnosis.L["OptCBRelSelEnemy"] = "enemy units"
Gnosis.L["OptCBRelSelFriendly"] = "friendly units"
Gnosis.L["OptCBRemCB"] = "Remove bar"
Gnosis.L["OptCBRemListElem"] = "Remove current entry"
Gnosis.L["OptCBRotIcon"] = "Rotate Icon (°)"
Gnosis.L["OptCBRotLatencyN"] = "Rotate latency"
Gnosis.L["OptCBRotNameD"] = "Forces free alignment if used"
Gnosis.L["OptCBRotNameN"] = "Rotate name"
Gnosis.L["OptCBRotTimeN"] = "Rotate time"
Gnosis.L["OptCBScaleBar"] = "Scale bar"
Gnosis.L["OptCBScaleIcon"] = "Scale icon (when unlocked)"
Gnosis.L["OptCBShowChanTicks"] = "Show channeled ticks"
Gnosis.L["OptCBShowIcon"] = "Show cast icon"
Gnosis.L["OptCBShowLatBox"] = "Show latency box"
Gnosis.L["OptCBShowShield"] = "Show shield for non-interruptible casts"
Gnosis.L["OptCBShowSpark"] = "Show castbar spark"
Gnosis.L["OptCBSizeGrp"] = "Bar shape and visuals"
Gnosis.L["OptCBSparkColor"] = "Spark color"
Gnosis.L["OptCBSparkHeight"] = "Spark height"
Gnosis.L["OptCBSparkWidth"] = "Spark width"
Gnosis.L["OptCBSWNC"] = "Show when not casting"
Gnosis.L["OptCBTabColors"] = "Colors"
Gnosis.L["OptCBTabHide"] = "Hide castbar"
Gnosis.L["OptCBTabText"] = "Text"
Gnosis.L["OptCBTextAlignment"] = "Alignment (name to time)"
Gnosis.L["OptCBTextColLat"] = "Text color (latency)"
Gnosis.L["OptCBTextColName"] = "Text color (name)"
Gnosis.L["OptCBTextColPB"] = "Text color (pushback)"
Gnosis.L["OptCBTextColTime"] = "Text color (time)"
Gnosis.L["OptCBTexture"] = "Castbar texture"
Gnosis.L["OptCBUnit"] = "Unit"
Gnosis.L["OptCBUnl_D"] = "Unlock castbar (always shown)"
Gnosis.L["OptCBUnl_N"] = "Unlock bar (movable)"
Gnosis.L["OptCBUnlockAll_D"] = "Unlock all bars. Disabled bars or bars selected for another talent specialization will be unlocked but will still not be visible."
Gnosis.L["OptCBUnlockAll_N"] = "Unlock"
Gnosis.L["OptCBUnlockIcon_D"] = "Unlock icon from bar"
Gnosis.L["OptCBUnlockIcon_N"] = "Unlock icon"
Gnosis.L["OptCBWordWrapD"] = "Allow text to wrap to additional lines"
Gnosis.L["OptCBWordWrapN"] = "Allow word wrap"
Gnosis.L["OptCHCastnameGrp"] = "Castname options"
Gnosis.L["OptCHCasttimeGrp"] = "Casttime options"
Gnosis.L["OptClipWarn_Desc"] = "Warn when clipping shortly before channel tick occurs on non aoe channeled spells."
Gnosis.L["OptClipWarn_Name"] = "Clipping warning [ms]"
Gnosis.L["OptCombTicks"] = "Combine ticks and output via combat text"
Gnosis.L["OptConfDelConf"] = "Remove config"
Gnosis.L["OptConfDelConfMBText"] = "Sure to delete configuration |cffffff7f%s|r?"
Gnosis.L["OptConfLoadCBs"] = "Load castbars"
Gnosis.L["OptConfLoadChan"] = "Load channeled spells"
Gnosis.L["OptConfLoadCT"] = "Load combattext/cliptest settings"
Gnosis.L["OptConfLoadMain"] = "Load main tab settings"
Gnosis.L["OptConfName"] = "Configuration name"
Gnosis.L["OptConfSave"] = "Save configuration"
Gnosis.L["OptConfStoreCBs"] = "Store castbars"
Gnosis.L["OptConfStoreChan"] = "Store channeled spells data"
Gnosis.L["OptConfStoreCT"] = "Store combattext/cliptest settings"
Gnosis.L["OptConfStoreMain"] = "Store addon main config tab settings"
Gnosis.L["OptConfUpdConf"] = "Update config"
Gnosis.L["OptConfUpdConfMBText"] = "Sure to update configuration |cffffff7f%s|r (to active settings)?"
Gnosis.L["OptCopytonewbarExists"] = "bar already exists, cannot copy bar to given name"
Gnosis.L["OptCopytonewbarInvalidName"] = "enter valid bar name before copying to a new bar"
Gnosis.L["OptCreateCBSet"] = "Create basic castbar set (quick start)"
Gnosis.L["OptCreatenewbarExists"] = "bar already exists, cannot create bar with given name"
Gnosis.L["OptCreatenewbarInvalidName"] = "enter valid bar name before creating new bar"
Gnosis.L["OptCreateNewSpell"] = "Create new spell"
Gnosis.L["OptCSFSClip"] = "Font size (clip, 0=default)"
Gnosis.L["OptCSFSNonClip"] = "Font size (non clip, 0=default)"
Gnosis.L["OptCSRemove"] = "Remove spell"
Gnosis.L["OptCTO"] = "Combat text output"
Gnosis.L["OptCTO_Blizz"] = "Blizzard's Floating Combat Text"
Gnosis.L["OptCTO_MSBT"] = "Mik's Scrolling Battle Text"
Gnosis.L["OptCTO_Parrot"] = "Parrot"
Gnosis.L["OptCTO_SCT"] = "Scrolling Combat Text"
Gnosis.L["OptEn"] = "Enable"
Gnosis.L["OptEnAutoCreateOptons"] = "Automatically create option tables on startup"
Gnosis.L["OptEnClipTest"] = "Enable clip test"
Gnosis.L["OptExportAllBars"] = "Export all bars"
Gnosis.L["OptFile"] = "File"
Gnosis.L["OptFirstStartFrame"] = "Open first start frame"
Gnosis.L["OptFirstTickInst"] = "First tick is instant"
Gnosis.L["OptFontEnShOffset"] = "Enable specific shadow offset"
Gnosis.L["OptFontResizeLongName"] = "Resize long strings"
Gnosis.L["OptFontShOffsetXYDesc"] = "Setup offset between text and shadow of text"
Gnosis.L["OptFontShOffsetXYName"] = "Shadow offset x, y"
Gnosis.L["OptHasteAddsTicks"] = "Spell haste adds ticks"
Gnosis.L["OptHeight"] = "Height"
Gnosis.L["OptHideAddonMsgs"] = "Hide Gnosis text messages"
Gnosis.L["OptHideBlizzCB"] = "Hide Blizzard's castbar"
Gnosis.L["OptHidecasttime"] = "Hide casttime left"
Gnosis.L["OptHidecasttimeTotal"] = "Hide casttime total"
Gnosis.L["OptHideMirrorCB"] = "Hide Blizzard's mirror castbar"
Gnosis.L["OptHideNonPlayerTicks"] = "Hide ticks on non player castbars"
Gnosis.L["OptHidePetCB"] = "Hide Blizzard's pet/vehicle castbar"
Gnosis.L["OptHidepushbackTime"] = "Hide pushback time"
Gnosis.L["OptImportBar"] = "Import bar(s)"
Gnosis.L["OptLoadOptionsButtonDesc"] = "Option tables have not yet been created to reduce Gnosis' memory footprint. After loading you can select to automatically create options tables the next time you start wow (or reload the ui)."
Gnosis.L["OptLoadOptionsButtonName"] = "Create options..."
Gnosis.L["OptLocale"] = "Select localization"
Gnosis.L["OptMergetradeskillDesc"] = "Merge tradeskill (player castbar only)."
Gnosis.L["OptMergetradeskillName"] = "Merge tradeskill"
Gnosis.L["OptMusic"] = "Music"
Gnosis.L["OptNameFormatStringDesc"] = [=[Enter string to show as name

name: spellname
trunc<cnt>: truncate spellname if longer than cnt
abbr<cnt>: abbreviated spellname (acronym) if longer than cnt
rank<text>: show text if rank available
misc: show miscellaneous info if non rank
arabic: rank as arabic numeral (e.g. 13)
roman: rank as roman numeral (e.g. XIII)
txr<text>: show text if rank info available
txm<text>: show text if misc info available
target: show target name if available (player only)
tar<text>: show text if target information avaiable (player only)
tar[text]: same as above
who: show name of casting unit

col<r,g,b[,a]>: e.g. col<1.0,1.0,0.0> to change color
col<school>: where school is shadow,arcane...
col<pre>: change color to previous one
col<class>: change color to target class color (if available)
col<cpre>: revert to previous color (if target class color is available)

tscur: show remaining tradeskill item count
tstot: show total tradeskill item count
txts<text>: show text if tradeskill information available

\n: force new line (if word wrap is enabled)]=]
Gnosis.L["OptNameFormatStringName"] = "Name format string"
Gnosis.L["OptNameFormatToggleDesc"] = "If enabled 'Show cast name' and 'Show cast rank' selections ignored."
Gnosis.L["OptNameFormatToggleName"] = "Enable name format string"
Gnosis.L["OptOutputString"] = "Output string"
Gnosis.L["OptOutputStringDesc"] = [=[Enter string to show as combat text output

spellname: name of channeled spell
dmg: amount of dmg or heal done by channel
eh: effective heal (= heal-overheal)
oh: overheal
dps: dps or hps of channel
target: target name of channel
clipped: information whether unintentional clip occured
cliptext<your text>: text string that replaces clipped if needed

hits: number of hits
crits: number of crits
ticks: number of ticks
tickscrits: outputs number of ticks and crits

above use following identifiers which are added to the displayed numbers
hittext<your text>: identifier for hits
crittext<your text>: identifier for crits
ticktext<your text>: identifier for ticks

col<r,g,b[,a]>: e.g. col<1.0,1.0,0.0> to change color
col<school>: where school is shadow,arcane...
col<pre>: change color to previous one
col<class>: change color to target class color (if available)
col<cpre>: revert to previous color (if target class color is available)]=]
Gnosis.L["OptPFoC"] = "Play file on clip"
Gnosis.L["OptPlayFile"] = "Play custom file"
Gnosis.L["OptPlayMusic"] = "Play music"
Gnosis.L["OptPlaySnd"] = "Play sound"
Gnosis.L["OptPlayTickSound_D"] = "Deactivates clipping sound."
Gnosis.L["OptPlayTickSound_N"] = "Play tick sound"
Gnosis.L["OptPMoC"] = "Play music on clip"
Gnosis.L["OptPSoC"] = "Play sound on clip"
Gnosis.L["OptResetPlayerData"] = "Reset player data (reloads interface)"
Gnosis.L["OptResizeOptions"] = "Resize interface options frame on startup"
Gnosis.L["OptSaveconfigExists"] = "configuration already exists, please delete first or change name"
Gnosis.L["OptSaveconfigInvalidName"] = "no configuration name given"
Gnosis.L["OptShowasminutesDesc"] = "Show minutes instead of seconds if longer than than 60s."
Gnosis.L["OptShowasminutesName"] = "Show minutes"
Gnosis.L["OptShowCastNameDesc"] = "Option not used if name format string enabled."
Gnosis.L["OptShowCastNameName"] = "Show cast name"
Gnosis.L["OptShowCastRankDesc"] = "Option not used if name format string enabled."
Gnosis.L["OptShowCastRankName"] = "Show cast rank"
Gnosis.L["OptShowPlayerLatency"] = "Show player latency (ms)"
Gnosis.L["OptShowSpellIcon"] = "Show spell icon"
Gnosis.L["OptSnd"] = "Sound"
Gnosis.L["OptSpellIsAoE"] = "Spell hits multiple mobs"
Gnosis.L["OptSpellNameOrId"] = "Spellname or Spell ID"
Gnosis.L["OptStickyClips"] = "Sticky clips"
Gnosis.L["OptStrGapDesc"] = "Minimal gap between castname and time strings (to decide whether to resize long string)."
Gnosis.L["OptStrGapName"] = "Gap (name...time)"
Gnosis.L["OptTablesUnloaded_Name"] = "Option tables not yet created"
Gnosis.L["OptTicksToShow"] = "Ticks to show"
Gnosis.L["OptTimeFormatStringDesc"] = [=[Enter string to show as time

r<x>: remaining with x decimals places
t<x>: total
p<x>: pushback time
c<x>: total-remaining

add s for sign, m for displaying time > 60s in minutes and a for higher precision when below one second remaining (r<0a>)
e.g. r<1m> or p<2s>
add p to show value in percent
e.g. r<p>% / t<1p>%

col<r,g,b[,a]>: e.g. col<1.0,1.0,0.0> to change color
col<school>: where school is shadow,arcane...
col<pre>: change color to previous one

\n: force new line

remark: use col<r,g,b> to change color of spell pushback if needed]=]
Gnosis.L["OptTimeFormatStringName"] = "Time format string"
Gnosis.L["OptTimeFormatToggleDesc"] = "If enabled all other time formatting options are ignored."
Gnosis.L["OptTimeFormatToggleName"] = "Enable time format string"
Gnosis.L["OptTimerScanEveryN"] = "Scan for timer updates every [ms]"
Gnosis.L["OptTotTicks"] = "Total ticks"
Gnosis.L["OptWfCL_Desc"] = "Delay output/clip test after output/clip test request for given time in ms to account for possible combat log delay."
Gnosis.L["OptWfCL_Name"] = "Wait for combat log [ms]"
Gnosis.L["OptWidth"] = "Width"
Gnosis.L["PasteScript"] = "Paste import data into edit box."
Gnosis.L["PremadeNfs1"] = "cast |cffff0000(rank or misc, e.g. stacks)|r (tradeskill merge)"
Gnosis.L["PremadeNfs2"] = "cast |cffff0000(aura effect value)|r"
Gnosis.L["PremadeNfs3"] = "|cffffff00unit name|r: cast"
Gnosis.L["PremadeTfs1"] = "|cffff0000pushback|r remaining / total, e.g. |cffff0000+1.0|r 1.4 / 3.00"
Gnosis.L["PremadeTfs2"] = "|cffff0000pushback|r remaining / total, same as above but without minutes display"
Gnosis.L["PremadeTfs3"] = "remaining / total, higher precision, e.g. 1.45 / 3.000"
Gnosis.L["SelPremadeStr"] = "Select premade string"
Gnosis.L["Strata_BACK"] = "Lowest"
Gnosis.L["Strata_DIALOG"] = "Highest"
Gnosis.L["Strata_HIGH"] = "High"
Gnosis.L["Strata_LOW"] = "Low"
Gnosis.L["Strata_MEDIUM"] = "Medium"
Gnosis.L["TabAdaptToCT"] = "Adapt to casttype"
Gnosis.L["TabCapBOTTOM"] = "BOTTOM"
Gnosis.L["TabCapBOTTOMLEFT"] = "BOTTOMLEFT"
Gnosis.L["TabCapBOTTOMRIGHT"] = "BOTTOMRIGHT"
Gnosis.L["TabCapCENTER"] = "CENTER"
Gnosis.L["TabCapLEFT"] = "LEFT"
Gnosis.L["TabCapNONE"] = "NONE"
Gnosis.L["TabCapRIGHT"] = "RIGHT"
Gnosis.L["TabCapTOP"] = "TOP"
Gnosis.L["TabCapTOPLEFT"] = "TOPLEFT"
Gnosis.L["TabCapTOPRIGHT"] = "TOPRIGHT"
Gnosis.L["TabCastbars"] = "Bar Configuration"
Gnosis.L["TabChanneledSpells"] = "Channeled Spells"
Gnosis.L["TabConfig"] = "Configurations (Profiles)"
Gnosis.L["TabCTClipTest"] = "Combattext/Cliptest"
Gnosis.L["TabFreeAlign"] = "Free alignment"
Gnosis.L["TabNameTime"] = "Name...Time"
Gnosis.L["TabTimeName"] = "Time...Name"
Gnosis.L["Vertical"] = "Vertical"
Gnosis.L["Yes"] = "Yes"

end
end
