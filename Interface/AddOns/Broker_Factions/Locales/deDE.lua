--[[
************************************************************************
Project				: Broker_Factions
Author				: zhinjio
Project Revision	: 3.2.5-release
Project Date		: 20110515000702

File				: Locales\deDE.lua
Commit Author		: zhinjio
Commit Revision		: 4
Commit Date			: 20110503035214
************************************************************************
Description	:
	German translation strings
TODO		:
************************************************************************
--]]
local MODNAME = "BFactions"
local L = LibStub:GetLibrary("AceLocale-3.0"):NewLocale( MODNAME, "deDE" )
if not L then return end

L["%s to go"] = "%s verbleibend"
L["Activates and displays a scrolling slider bar, for the tooltip."] = "Aktiviert und zeigt eine Schiebereglerleiste für den Tooltip an."
-- L["Appends a '+' label suffix to collapsed faction headers (assuming collapsed headers are shown)."] = "Appends a '+' label suffix to collapsed faction headers (assuming collapsed headers are shown)."
-- L["Appends faction standing, to the button label."] = "Appends faction standing, to the button label."
-- L["Appends percentage values to the button label."] = "Appends percentage values to the button label."
-- L["Appends raw numbers in the form of (xxx/xxxx), to the button label."] = "Appends raw numbers in the form of (xxx/xxxx), to the button label."
-- L["Appends remaining reputation to reach the next standing, to the button label."] = "Appends remaining reputation to reach the next standing, to the button label."
-- L["Appends session reputation gains in the form of [xxx], to the button label."] = "Appends session reputation gains in the form of [xxx], to the button label."
L["Author : "] = "Author : " -- Needs review
L["Auto faction watch on reputation gains"] = "Automatischer Fraktionswechsel bei Rufzuwachs"
L["Automatically sets the faction watched on the button/block to the last faction you gained reputation with."] = "Setzt automatisch die am Schalter/Block angezeigte Fraktion auf jene, bei der zuletzt Ruf erworben wurde"
L["Build Date : "] = "Versions Datum:" -- Needs review
L["Button"] = "Schalter"
L["Change color of percentages/raw numbers/'to go' according to faction reputation standing."] = "Verändert die Farbe der prozentualen / nummerischen / verbleibendenen Werteanzeige, gemäß des aktuellen Fraktionsrufes"
-- L["Click header lines to expand/contract"] = "Click header lines to expand/contract"
L["Colorize faction statistics"] = "Färbe Fraktionsstatistiken ein"
L["Ctrl+Left Click"] = "Ctrl+Links Klick"
L["DISPLAY_DEBUG_DESC"] = "Aktivieren um DEBUG Informationen anzuzeigen" -- Needs review
L["DISPLAY_HIDEEXALTED_DESC"] = "Aktivieren, um Ehrfürchitige Fraktionen 'nicht' anzuzeigen." -- Needs review
L["DISPLAY_OPTIONS_DESC"] = "Optionen, um die Datenanzeige im Tooltip zu verändern" -- Needs review
L["DISPLAY_SHOWCOLLAPSED_DESC"] = "Aktivieren um zusammengeklappte Überschriften anzuzeigen." -- Needs review
L["DISPLAY_SHOWGAINS_DESC"] = "Aktivieren um Sitzungszuwachs anzuzeigen" -- Needs review
L["DISPLAY_SHOWHINTS_DESC"] = "Aktivieren, um Tooltiphinweise anzuzeigen" -- Needs review
L["DISPLAY_SHOWPERC_DESC"] = "Aktivieren, um den bisher erreichten Prozentsatz anzuzeigen" -- Needs review
L["DISPLAY_SHOWRAW_DESC"] = "Aktivieren, um nummerische Werte anzuzeigen." -- Needs review
L["DISPLAY_SHOWREMAIN_DESC"] = "Aktivieren, um verbleibenden Ruf bis zum nächsten Stufenaufstieg anzuzeigen." -- Needs review
L["Database Version : "] = "Datenbank Version :" -- Needs review
L["Database upgraded to %s"] = "Datenbank aktualisiert auf %s" -- Needs review
L["Display Debug"] = "Zeige Debug an" -- Needs review
L["Display Options"] = "Anzeige Optionen" -- Needs review
L["Draws the icon on the minimap."] = "Stellt das Symbol an der Minimap dar." -- Needs review
L["Enable Scrolling"] = "Scrollen aktivieren"
L["Exalted"] = "Ehrfürchtig" -- Needs review
L["Faction"] = "Fraktion"
L["Faction Monitoring"] = "Fraktionsüberwachung"
L["Faction index not yet initialized !"] = "Fraktionsindex noch nicht initialisiert"
L["Friendly"] = "Freundlich" -- Needs review
L["GENERAL_INFO_DESC"] = "versions und Author Informationen" -- Needs review
L["General"] = "Allgemein"
L["General Information"] = "Allgemeine Informationen" -- Needs review
L["Hated"] = "Hasserfüllt" -- Needs review
L["Helpful Translators (thank you) : %s"] = "Hilfreiche Übersetzer (vielen Dank) : %s" -- Needs review
L["Hidden Faction"] = "Verborgene Fraktion"
L["Hide Exalted Factions"] = "Ehrfürchtige Fraktionen verbergen"
L["Hide Hint Text"] = "Hinweistext verbergen"
L["Hide Monitored Faction"] = "Überwachte Fraktion verbergen"
L["Hides faction text from the button."] = "Fraktionstext am Schalter verbergen"
L["Hides factions with Exalted standing, from the tooltip."] = "Verbirgt Fraktionen, mit der Rufstufe 'Ehrfürchtig', im Tooltip"
L["Hides the tooltip information/hint text."] = "Verbirgt den Tooltipinfo/-hinweistext"
L["Honored"] = "Wohlwollend" -- Needs review
L["Hostile"] = "Feindselig" -- Needs review
L["Ignore Exalted factions"] = "Ignoriere ehrfürchtige Fraktionen"
L["Ignore negative reputation gains"] = "Ignoriere negativen Rufzuwachs"
L["Inactive"] = "Inaktiv" -- Needs review
L["Inactive Faction"] = "Inaktive Fraktion"
L["Inserts a new tooltip column, showing faction standing."] = "Fügt eine neue Tooltipspalte hinzu, die den aktuellen Fraktionsruf anzeigt."
L["Inserts a new tooltip column, showing remaining reputation to reach the next standing."] = "Fügt eine neue Tooltipspalte hinzu, die den noch benötigten Rufzuwachs, bis zur nächsten Stufe, anzeigt."
L["Inserts a new tooltip column, showing reputation percentage values."] = "Fügt eine neue Tooltipspalte hinzu, die den Ruf in Prozenten anzeigt."
L["Inserts a new tooltip column, showing reputation raw numbers in the form of 'xxx/xxxx'."] = "Fügt eine neue Tooltipspalte hinzu, die den Ruf in ganzen Zahlen  (z.B.: 0000/3000) anzeigt."
L["Inserts a new tooltip column, showing session reputation gains in the form of 'xxx'."] = "Fügt eine neue Tooltipspalte hinzu, die den Rufzuwachs der aktuellen Sitzung (z.b.: 256) anzeigt."
L["Left Click"] = "Linksklick"
-- L["Left-click faction lines to set watched faction"] = "Left-click faction lines to set watched faction"
L["MINIMAP_OPTIONS_DESC"] = "Optionen für das Minimapsymbol" -- Needs review
L["MISCDISPLAY_OPTIONS_DESC"] = "Weitere Optionen" -- Needs review
L["Minimalistic LDB plugin that allows simple faction reputation monitoring."] = "Einfaches LDB plugin zur Überwachung des Rufs bei Fraktionen."
L["Minimap Icon Options"] = "Minimapsymbol Optionen" -- Needs review
L["Miscellaneous Display Options"] = "Verschiedene Anzeigeoptionen" -- Needs review
L["Move the slider to adjust scaling for the tooltip."] = "Schiebeschalter bewegen um den Tooltip zu skalieren."
L["Neutral"] = "Neutral" -- Needs review
L["No Faction"] = "Keine Fraktion"
L["Raw"] = "Direkt"
L["Remaining"] = "Verbleibend" -- Needs review
L["Rep"] = "Ruf" -- Needs review
L["Reputation with (.*) decreased"] = "Euer Ruf bei der Fraktion ['-](.*)['-] hat sich verschlechtert"
L["Reputation with (.*) increased"] = "Euer Ruf bei der Fraktion ['-](.*)['-] hat sich verbessert"
L["Reset Session Gains"] = "Sitzungszuwachs zurücksetzen"
L["Resets the reputation session gain counters."] = "Setzt den Rufzuwachs der aktuellen Sitzung zurück."
L["Revered"] = "Respektvoll" -- Needs review
L["Right Click"] = "Rechtsklick"
-- L["Right-click for Configuration"] = "Right-click for Configuration"
L["Select Faction to Watch"] = "Fraktionsüberwachung" -- Needs review
L["Select a faction to watch on the button/block."] = "Fraktion zur Anzeige auf dem Schalter/Block auswählen"
L["Session"] = "Sitzung"
L["Sets the faction watched on the button/block to the faction set in the character's reputation tab."] = "Setzt die überwachte Fraktion auf die Anzeige im Ruffenster des Characters"
L["Sets the tooltip maximum height, after which it will be scrollable."] = "Bestimmt die maximal Höhe des Tooltips, damit dieser scrollbar wird."
L["Shift+Left Click"] = "Shift+Linksklick" -- Needs review
L["Show Collapsed Header Suffix"] = "Zeige eingeklappte Überschriften Suffix"
L["Show Collapsed Headers"] = "Zeige eingeklappte Überschriften"
L["Show Hint Lines"] = "Hinweise anzeigen" -- Needs review
L["Show Minimap Icon"] = "Minmapsymbol anzeigen" -- Needs review
L["Show Percentage"] = "Prozent" -- Needs review
L["Show Percentages"] = "Prozente anzeigen"
L["Show Raw Numbers"] = "Numerische Werte anzeigen"
L["Show Raw Values"] = "Nummerische Werte" -- Needs review
L["Show Remaining"] = "Verbleibend" -- Needs review
L["Show Reputation To Go"] = "Verbleibender Ruf"
L["Show Session Gains"] = "Zuwachs per Sitzung"
L["Show Standing"] = "Rang anzeigen"
L["Show Text"] = "Zeige Text" -- Needs review
L["Status"] = "Status" -- Needs review
L["TEXT_FACTIONWATCH_DESC"] = "Wähle eine Fraktion, um sie auf dem LDB anzeigen zu lassen" -- Needs review
L["TEXT_OPTIONS_DESC"] = "Optionen bezüglich des Textes auf der LDB Anzeige" -- Needs review
L["TEXT_SHOWGAINS_DESC"] = "Aktivieren, um den Rufzuwachs pro Sitzung auf dem LDB anzuzeigen" -- Needs review
L["TEXT_SHOWPERC_DESC"] = "Aktivieren, um gesammelten Ruf in Prozenten anzuzeigen" -- Needs review
L["TEXT_SHOWRAW_DESC"] = "Aktivieren, um nummerische Werte auf dem LDB anzuzeigen" -- Needs review
L["TEXT_SHOWREMAIN_DESC"] = "Aktivieren, um den verbleibenden Ruf auf dem LDB anzuzeigen" -- Needs review
L["TEXT_SHOW_DESC"] = "Aktivieren, um den Text auf dem LDB anzuzeigen" -- Needs review
L["TOOLTIPDISPLAY_OPTIONS_DESC"] = "Optionen bezüglich dessen, was im Tooltip angezeigt werden soll." -- Needs review
L["TOOLTIP_DELAY_DESC"] = "Zeit (in Sekunden) die der Tooltip noch angezeigt wird, nachdem die Maus wegbewegt wurde." -- Needs review
L["TOOLTIP_SCALE_DESC"] = "Bewegen um den Tooltip zu skalieren." -- Needs review
L["Text Options"] = "Text Optionen" -- Needs review
L["To Go"] = "Offen"
L["Toggles display of collapsed faction headers (normally hidden), on the tooltip."] = "Schaltet die Anzeige von eingeklappten Fraktionsüberschriften (Voreinstellung: Versteckt), im Tooltip ein."
L["Tooltip"] = "Tooltip"
L["Tooltip Auto-hide Delay"] = "Tooltip Ausblendverzögerung" -- Needs review
L["Tooltip Display Options"] = "Tooltip Anzeigeoptionen" -- Needs review
L["Tooltip Maximum Height"] = "Toooltip Max. Höhe"
L["Tooltip Scale"] = "Tooltipskalierung"
-- L["Turning this option on will cause the button/block not to auto-switch to a faction you are exalted with, when reputation with it, is modified."] = "Turning this option on will cause the button/block not to auto-switch to a faction you are exalted with, when reputation with it, is modified."
-- L["Turning this option on will cause the button/block not to auto-switch to a faction, when getting negative reputation with it."] = "Turning this option on will cause the button/block not to auto-switch to a faction, when getting negative reputation with it."
L["Unfriendly"] = "Unfreundlich" -- Needs review
L["Unknown Faction"] = "Unbekannte Fraktion"
L["Use Blizzard's faction watch"] = "Blizzard's Fraktionsüberwachung verwenden"
L["Values"] = "Menge" -- Needs review
L["Version : "] = "Version : " -- Needs review
L["You are now (%a+) with (.*)%."] = "Die Fraktion (.*) ist Euch gegenüber jetzt (.*) eingestellt"
L["on faction header to expand or collapse it."] = "auf die Fraktionsüberschrift, zum ein-/ausklappen" -- Needs review
L["on faction name to watch on the button/block."] = "auf den Fraktionsnamen, um ihn auf dem Schalter/Block anzuzeigen" -- Needs review
L["on plugin to open Blizzard's Reputation tab."] = "auf das Plugin, um die Blizzard Rufanzeige zu öffnen." -- Needs review
L["on plugin to open Configuration Menu."] = "auf das Plugin, um die Optionen zu öffnen." -- Needs review
L["to paste Reputation info into chat."] = "Ruf in die Chatbox einfügen."
L["to toggle Reputation bar watch."] = "Rufleiste zuschalten." -- Needs review


--[[
************************************************************************
CHANGELOG:

Date : 04/05/11
	initial version
************************************************************************
]]--