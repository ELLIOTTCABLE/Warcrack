--[[ *******************************************************************
Project                 : TomTomPing
Description             : German translation file (deDE)
Author                  : 
Translator              : 
Revision                : $Rev: 1 $
********************************************************************* ]]

local MODNAME   = "TomTomPing"

local L = LibStub:GetLibrary("AceLocale-3.0"):NewLocale(MODNAME, "deDE")
if not L then return end

L["Target as destination"] = "Ziel als TTP-Ziel"
L["(Un)Stick current destination"] = "Fixieren/lösen des aktuellen Ziels"
L["Ping your position"] = "Ping auf eigener Position"
L["Release CrazyArrow"] = "CrazyArrow freigeben"
L["Set waypoint on current position"] = "Wegpunkt auf eigener Position"
L["Clear waypoint"] = "Wegpunkt freigeben"

L["None"] = "Nichts" 
L["Target"] = "Ziel"
L["Focus"] = "Fokus"
L["Mouseover"] = "Mouseover"
L["Mouseover-Click"] = "Mouseover-Klick" 
L["Waypoint"] = "Wegpunkt"

L["Messages"] = "Nachrichten"
L["Listen to remote TTP messages"] = "Auf entfernte TTP-Nachrichten hören"
L["DBM"] = "DBM"
L["Use Deadly Boss Mods"] = "Verwende Deadly Boss Mods"
L["Minimap Button"] = "Minimap Button"
L["Show Minimap Button"] = "Zeige Minimap Button"
L["Hide Hint"] = "Hinweis verstecken"
L["Hide usage hint in tooltip"] = "Benutzungshinweise im Tooltip verbergen"
L["Also check the key bindings!"] = "Tasten-Shortcuts vorhanden!"

L["Arrow"] = "Pfeil"
L["Arrow Display Settings"] = "Anzeigeeinstellungen Pfeil"
L["Time Precision"] = "Genauigkeit Zeit"
L["Positions after decimal point"] = "Nachkommastellen"
L["Range Precision"] = "Genauigkeit Entfernung"

L["Ping"] = "Ping"
L["Ping Settings"] = "Ping-Einstellungen"
L["Activate Ping"] = "Ping aktivieren"
L["Show arrow on ping"] = "Zeige Pfeil bei Ping-Ereignissen"
L["Duration"] = "Dauer"
L["Duration before fade out"] = "Zeitdauer bis zum Ausblenden"
L["Arrival Range"] = "Ankunftsentfernung"
L["Fade out when within distance"] = "Ausblenden wenn Ankunftsentfernung erreicht"

L["Targeting"] = "Pfeilziel"
L["Target Settings"] = "Zieleinstellungen für Pfeil"
L["Destination"] = "Ziel"
L["Select destination"] = "Pfeilziel wählen"
L["Range Check"] = "Entfernungstest"
L["Range check for healing"] = "Entfernungstest für Heilzauber"
L["Show Empty Destination"] = "Zeige leeres Ziel"
L["Show arrow when no destination is set"] = "Zeige Pfeil wenn keine Einheit gewählt"

L["Destination"] = "Ziel"
L["Type"] = "Typ"
L["Distance"] = "Entfernung"
L["Last Ping"] = "Letzter Ping"

L["Left-Click"] = "Linksklick"
L["Set target as destination"] = "Aktuelles Ziel als Pfeilziel"
L["Right-Click"] = "Rechtsklick"
L["Open options menu"] = "Öffne Einstellungsmenü"
L["Ctrl-Left-Click"] = "Strg-Linksklick"
L["Stick/unstick destination"] = "Fixieren/lösen des Ziels"
L["Ctrl-Right-Click"] = "Strg-Rechtsklick"
L["Release arrow"] = "Pfeil freigeben"
L["Shift-Left-Click"] = "Umschalt-Linksklick"
L["Ping at current location"] = "Ping auf aktuelle Position"
L["Alt-Left-Click"] = "Alt-Linksklick"
L["Set waypoint at current location"] = "Wegpunkt auf aktuelle Position"
L["Alt-Right-Click"] = "Alt-Rechtsklick"
L["Clear waypoint"] = "Wegpunkt freigeben"

L["Usage:"] = "Verwendung:"
L["/tomtomping arg"] = "/tomtomping arg"
L["/ttp arg"] = "/ttp arg"
L["Args:"] = "Argumente:"
L["target - use current target as arrow target"] = "target - aktuelles Ziel als Pfeilziel"
L["stick - make current arrow target sticky"] = "stick - fixieren/lösen des aktuellen Ziels"
L["clear - release the crazy arrow"] = "clear - Pfeil freigeben"
L["ping - ping on self"] = "ping - Ping auf eigene Position"
L["waypoint - set waypoint on self"] = "waypoint - Wegpunkt auf eigene Position"
L["wpclear - clear waypoint"] = "wpclear - Wegpunkt freigeben"
L["measure - init map size measurement (Move at least 20 yards!)"] = "measure - Kartenvermessung initialisieren (Bewege dich min. 20m!)"
L["version - display version information"] = "version - Versionsinformation anzeigen"
L["menu - display options menu"] = "menu - Optionsmenü anzeigen"
L["help - display this help"] = "help - diese Hilfe anzeigen"

L["Found TomTom: "] = "TomTom gefunden"
L["+++ TomTom outdated +++\nYou have to install TomTom Version 216\nor higher to run TomTomPing\nYours is: "] = "+++ TomTom veraltet +++\nDu musst TomTom Version 216 oder höher\ninstallieren um TomTomPin zu nutzen\n"
L["TomTom OK"] = "TomTom OK"
L["+++ TomTom missing +++\nYou have to install TomTom to run TomTomPing!"] = "+++ TomTom nicht vorhanden +++\nDu musst TomTom installieren um TomTomPing zu nutzen!"

L["Version"] = "Version"

L["yards"] = "meter"
L["s"] = "s"
L["Ping: "] = "Ping: "
L["Sticky"] = "Fixiert"
L["no target"] = "Kein Ziel"
L["no coords"] = "Keine Koordinaten"
L["other zone"] = "Andere Zone"

L["NO RANGE DATA FOUND\nType '/ttp measure' and then move 20 yards"] = "KEINE ENTFERNUNGSDATEN GEFUNDEN\nFühre '/ttp measure' aus und bewege dich 20m" 
L["No map coordinates present for this instance! Aborting measurement."] = "Keine Positionskoordinaten in dieser Instanz verfügbar! Breche Messung ab."
L["No reference point set. Please retry measurement."] = "Kein Referenzpunkt gesetzt. Führe Messung erneut aus!"
L["No range calculation. You have to move first!"] = "Entfernungsberechnung abgebrochen. Keine Bewegung erfolgt."
L["Map dimensions stored for %s[%i]: x, y = %f, %f"] = "Kartengröße gespeichert für %s[%i]: x, y = %f, %f"
