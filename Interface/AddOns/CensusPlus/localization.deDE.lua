--[[
	CensusPlus for World of Warcraft(tm).
	
	Copyright 2005 - 2012 Cooper Sellers and WarcraftRealms.com

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GLP.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
]]
-- initial translations provided by Marani@curseforge   many phrases need translation .. and review.


if ( GetLocale() == "deDE" ) then
CENSUS_BUTTON_TOOLTIP = "CensusPlus öffnen"

CENSUS_OPTIONS_AUTOCENSUS = "Automatische Zählung"

CENSUS_OPTIONS_AUTOSTART = "Auto-Start"

-- Needs review
CENSUS_OPTIONS_BACKGROUND_TRANSPARENCY_TOOLTIP = "Hintergrund Transparenz einstellbar in 10 Schritten"

CENSUS_OPTIONS_BUTSHOW = "Symbol an der Minimap anzeigen"

CENSUS_OPTIONS_CCO_REMOVE_OVERRIDE = "Überschreiben entfernen"

CENSUS_OPTIONS_LOG_BARS = "Logarithmische Levelbalken"

CENSUS_OPTIONS_LOG_BARSTEXT = "Aktiviert die logarithmische Skalierung der Displaybalken."

CENSUS_OPTIONS_SOUNDFILE = "Wähle eine vom Benutzer bereitgestellte Sounddatei Nummer"

CENSUS_OPTIONS_SOUNDFILETEXT = "Wähle die gewünschte .mp3-oder .ogg-Audiodatei"

CENSUS_OPTIONS_SOUND_ON_COMPLETE = "Spiele bei Zählungsende Ton ab"

CENSUS_OPTIONS_SOUND_TOOLTIP = "Aktiviere den Ton und wähle eine Sound Datei"

CENSUS_OPTIONS_STEALTH = "Ruhe"

CENSUS_OPTIONS_STEALTH_TOOLTIP = "Ruhemodus - keine Chat Nachrichten, Ausführlicher Modus deaktiviert"

-- Needs review
CENSUS_OPTIONS_TIMER_TOOLTIP = "Setzt die Verzögerung zur letzten Zählung in Minuten"

CENSUS_OPTIONS_VERBOSE = "Ausführliche Ausgabe"

CENSUS_OPTIONS_VERBOSE_TOOLTIP = "Aktiviert den ausführlichen Modus, deaktiviert den Ruhe Modus."

CENSUSPLUS_ACCOUNT_WIDE = "Accountweit"

CENSUSPLUS_ACCOUNT_WIDE_ONLY_OPTIONS = "Nur accountweite Optionen"

CENSUSPLUS_AND = "und"

CENSUSPLUS_APANDAREN = "Pandaren"

CENSUSPLUS_AUTOCENSUS_DELAYTIME = "Wartezeit in Minuten"

CENSUSPLUS_AUTOCENSUSOFF = "Automatische Zählung: AUS"

CENSUSPLUS_AUTOCENSUSON = "Automatische Zählung: AN"

CENSUSPLUS_AUTOCENSUSTEXT = "Starte die Zählung nach einer initialen Wartezeit"

CENSUSPLUS_AUTOCENSUS_TOOLTIP = "Aktiviert die automatische Zählung von Census+ während des Spielens"

CENSUSPLUS_AUTOCLOSEWHO = "Schließe /wer automatisch"

CENSUSPLUS_AUTOSTARTTEXT = "Automatischer Start nach dem Login, wenn der Timer kleiner ist als "

CENSUSPLUS_BADLOCAL_1 = "Du scheinst eine US Census Version zu nutzen, obwohl deine Lokalisation auf Französisch, Deutsch oder Italienisch gestellt ist."

CENSUSPLUS_BADLOCAL_2 = "Bitte lade keine Daten auf WarcraftRealms bis dies behoben ist."

CENSUSPLUS_BADLOCAL_3 = "Ist dies nicht korrekt, so schildere bitte Bringoutyourdead auf www.WarcraftRealms.com deine Situation, damit er eine Korrektur vornehmen kann."

CENSUSPLUS_BLOODELF = "Blutelf"

CENSUSPLUS_BUTTON_CHARACTERS = "Zeige Charaktere"

CENSUSPLUS_BUTTON_OPTIONS = "Optionen"

CENSUSPLUS_CCO_OPTIONOVERRIDES = "Optionen Überschreibung nur für diesen Charakter"

CENSUSPLUS_CENSUSBUTTONANIMIOFF = "CensusButton Animation: AUS"

CENSUSPLUS_CENSUSBUTTONANIMION = "CensusButton Animation: AN"

CENSUSPLUS_CENSUSBUTTONANIMITEXT = "Census Button Animation"

CENSUSPLUS_CENSUSBUTTONSHOWNOFF = "CensusButton Modus: AUS"

CENSUSPLUS_CENSUSBUTTONSHOWNON = "CensusButton Modus: AN"

CENSUSPLUS_CHARACTERS = "Charaktere"

CENSUSPLUS_CLASS = "Klassen"

CENSUSPLUS_CMDERR_WHO2 = "/wer Kommando sollte sein: wer Name Level _ kein Name gefunden, Level ist optional"

CENSUSPLUS_CMDERR_WHO2NUM = "Wer-Kommando kann sein: wer Name _ Name darf keine Nummer enthalten"

CENSUSPLUS_CONNECTED = "Verknüpfte:"

CENSUSPLUS_CONNECTED2 = "Zusätzlich Verknüpfte:"

CENSUSPLUS_CONNECTEDREALMSFOUND = "Census+ hat die folgenden Verknüpften Realms gefunden"

CENSUSPLUS_DEATHKNIGHT = "Todesritter"

CENSUSPLUS_DRAENEI = "Draenei"

CENSUSPLUS_DRUID = "Druide"

CENSUSPLUS_DWARF = "Zwerg"

CENSUSPLUS_EU_LOCALE = "Auswählen, falls du auf einem EU Server spielst"

CENSUSPLUS_FACTION = "Fraktion: %s"

CENSUSPLUS_FACTIONUNKNOWN = "Fraktion: Unbekannt"

CENSUSPLUS_FINISHED = "Zählung beendet. Es wurden %s neue Charaktere gefunden und insgesamt %s erfasst. Dauer: %s"

CENSUSPLUS_FOUND = "gefunden"

CENSUSPLUS_FOUND_CAP = "Gefunden"

CENSUSPLUS_GETGUILD = "Klicke Realmnamen für Gildenanzeige"

CENSUSPLUS_GNOME = "Gnom"

CENSUSPLUS_GOBLIN = "Goblin"

CENSUSPLUS_GUILDREALM = "Gilden Realm"

CENSUSPLUS_HELP_0 = "ergänze eines der hier gelisteten Kommandos"

CENSUSPLUS_HELP_1 = "Schalte den ausführlichen Modus an/aus"

CENSUSPLUS_HELP_10 = "_ Census+ aktualisiert den Spieler nach einer erfolgreichen Zählung. Dies erfolgt automatisch im Anschluß."

CENSUSPLUS_HELP_11 = "_ Schalte Ruhemodus aus/an - Deaktiviert den ausführlichen Modus und alle CensusPlus Chat Nachrichten."

CENSUSPLUS_HELP_2 = "Öffnet das Optionen Fenster"

CENSUSPLUS_HELP_3 = "Starte eine Census Momentaufnahme"

CENSUSPLUS_HELP_4 = "_ Stoppt eine Census Momentaufnahme"

CENSUSPLUS_HELP_5 = "X _ Bereinigt die Datenbank, indem Charaktere entfernt werden die länger als X Tage nicht gesehen wurden - Standard X = 30"

CENSUSPLUS_HELP_6 = "X _ Bereinigt die Datenbank, indem Charaktere entfernt werden die länger als X Tage nicht gesehen wurden auf allen Servern mit Ausnahme von dem, auf dem du gerade aktiv bist. - Standard X = 0"

CENSUSPLUS_HELP_7 = "_ Zeigt Informationen zu den zutreffenden Namen."

CENSUSPLUS_HELP_8 = "_ Listet alle gildenlose Charaktere mit diesem bestimmten Level."

CENSUSPLUS_HELP_9 = "_ Setzt den Timer der automatischen Zählung auf X Minuten."

CENSUSPLUS_HPANDAREN = "Pandaren"

CENSUSPLUS_HUMAN = "Mensch"

CENSUSPLUS_HUNTER = "Jäger"

CENSUSPLUS_ISINBG = "Du befindest dich zur Zeit auf einem Schlachtfeld, daher kann keine Zählung durchgeführt werden"

CENSUSPLUS_ISINPROGRESS = "Eine Census+-Zählung wird gerade durchgeführt, versuche es später noch einmal"

CENSUSPLUS_LANGUAGECHANGED = "Client Sprache wurde geändert, Datenbank wird gelöscht."

CENSUSPLUS_LASTSEEN = "Zuletzt gesehen"

CENSUSPLUS_LASTSEEN_COLON = "Zuletzt gesehen: "

CENSUSPLUS_LEVEL = "Level"

CENSUSPLUS_LOCALE = "Lokalisierung: %s"

CENSUSPLUS_LOCALE_SELECT = "Auswählen, falls du auf einem US oder EU Server spielst"

CENSUSPLUS_LOCALEUNKNOWN = "Lokalisierung: Unbekannt"

CENSUSPLUS_MAGE = "Magier"

CENSUSPLUS_MAXXED = "MAXXED!"

CENSUSPLUS_MONK = "Mönch"

CENSUSPLUS_MSG1 = "Geladen - Mit /census, /census+ oder /censusplus werden mögliche Befehle angezeigt"

CENSUSPLUS_NIGHTELF = "Nachtelf"

CENSUSPLUS_NOCENSUS = "Es wird derzeit keine Zählung durchgeführt"

CENSUSPLUS_NOTINFACTION = "Neutrale Fraktion - Zählung nicht gestattet"

CENSUSPLUS_NOW = "jetzt"

CENSUSPLUS_OBSOLETEDATAFORMATTEXT = "Altes Datenbankformat gefunden, Datenbank wird gelöscht."

CENSUSPLUS_OPTIONS_CHATTYCONFIRM = "Chatty Optionen Bestätigungen - Auswählen um diese zu aktivieren"

CENSUSPLUS_OPTIONS_CHATTY_TOOLTIP = "Aktivieren um die aktuellen gesetzten Optionen im Chat zu sehen - Wird angezeigt wenn das Optionen Fenster geöffnet wird und bei vielen CensusPlus Optionen Änderungen."

CENSUSPLUS_OPTIONS_HEADER = "Census+ Optionen"

CENSUSPLUS_OPTIONS_OVERRIDE = "Überschreiben"

CENSUSPLUS_OR = "oder"

-- Needs review
CENSUSPLUS_ORC = "Orc"

CENSUSPLUS_PALADIN = "Paladin"

CENSUSPLUS_PAUSE = "Pause"

CENSUSPLUS_PAUSECENSUS = "Pausiert die akutuelle Zählung"

CENSUSPLUS_PLAYERS = "Spieler."

CENSUSPLUS_PLAYFINISHSOUNDNUM = "FertigSound Nummer"

-- Needs review
CENSUSPLUS_PLAYFINISHSOUNDOFF = "Spiele \"Zählung ist fertig\" Sound: AUS"

-- Needs review
CENSUSPLUS_PLAYFINISHSOUNDON = "Spiele \"Zählung ist fertig\" Sound: AN"

CENSUSPLUS_PRIEST = "Priester"

CENSUSPLUS_PROBLEMNAME = "Dieser Name ist proplematisch =>"

CENSUSPLUS_PROBLEMNAME_ACTION = ", Name übersprungen. Diese Nachricht wird nur einmal angezeigt."

CENSUSPLUS_PROCESSING = "Verarbeite %s Charaktere."

CENSUSPLUS_PRUNE = "Bereinigen"

CENSUSPLUS_PRUNECENSUS = "Bereinigt die Datenbank indem Charaktere entfernt werden, die die letzten 30 Tage nicht gesehen wurden."

CENSUSPLUS_PRUNEINFO = "%d Charaktere wurden entfernt."

CENSUSPLUS_PURGE = "Löschen"

CENSUSPLUS_PURGEDALL = "Alle Census Daten gelöscht"

CENSUSPLUS_PURGEDATABASE = "Löscht alle Daten in der Datenbank"

CENSUSPLUS_PURGE_LOCAL_CONFIRM = "Bist du sicher, dass du alle Daten in der lokalen Datenbank löschen möchtest?"

CENSUSPLUS_PURGEMSG = "Charakter Datenbank geleert."

CENSUSPLUS_RACE = "Rassen"

CENSUSPLUS_REALM = "Realm"

CENSUSPLUS_REALMNAME = "Realm:"

CENSUSPLUS_REALMUNKNOWN = "Realm: Unbekannt"

CENSUSPLUS_ROGUE = "Schurke"

CENSUSPLUS_SCAN_PROGRESS = "Fortschritt: %d Anfragen in der Warteschlange - %s"

CENSUSPLUS_SCAN_PROGRESS_0 = "Es findet aktuell keine Zählung statt"

CENSUSPLUS_SENDING = "Sende /wer %s"

CENSUSPLUS_SHAMAN = "Schamane"

CENSUSPLUS_STEALTHOFF = "Ruhe Modus: AUS"

CENSUSPLUS_STEALTHON = "Ruhe Modus: AN"

CENSUSPLUS_STOP = "Abbruch"

CENSUSPLUS_STOPCENSUS_TOOLTIP = "Breche die aktuelle Zählung ab"

CENSUSPLUS_TAKE = "Starten"

CENSUSPLUS_TAKECENSUS = [=[Zähle alle Charaktere,
die momentan auf diesem Server
in dieser Fraktion online sind]=]

CENSUSPLUS_TAKINGONLINE = "Eine Zählung der gerade aktiven Charaktere wird ausgeführt..."

CENSUSPLUS_TAUREN = "Tauren"

CENSUSPLUS_TEXT = "Census+"

CENSUSPLUS_TOOMANY = "WARNUNG: Zu viele passende Charaktere gefunden: %s"

CENSUSPLUS_TOOSLOW = "Aktualisierung zu langsam! Ist der Computer überlastet? Verbindungsprobleme?"

CENSUSPLUS_TOPGUILD = "Top Gilden nach XP"

CENSUSPLUS_TOTALCHAR = "Gesamtanzahl Charaktere: %d"

CENSUSPLUS_TOTALCHAR_0 = "Gesamtanzahl Charaktere: 0"

CENSUSPLUS_TOTALCHARXP = "XP Faktor: %d"

CENSUSPLUS_TOTALCHARXP_0 = "XP Factor: 0"

CENSUSPLUS_TRANSPARENCY = "Census Fenster Transparenz"

CENSUSPLUS_TROLL = "Troll"

-- Needs review
CENSUSPLUS_UNDEAD = "Untote"

CENSUSPLUS_UNGUILDED = "(Gildenlos)"

CENSUSPLUS_UNKNOWNRACE = "Eine unbekannte Rasse wurde gefunden ( "

CENSUSPLUS_UNKNOWNRACE_ACTION = " ), bitte informiere Bringoutyourdead auf WarcraftRealms.com darüber"

CENSUSPLUS_UNPAUSE = "Zusammenfassung"

CENSUSPLUS_UNPAUSECENSUS = "Fahre mit der aktuellen Zählung fort."

CENSUSPLUS_UPLOAD = "Vergiss nicht deine Census+ Daten bei www.WarcraftRealms.com hochzuladen!"

CENSUSPLUS_USAGE = "Benutzung:"

-- Needs review
CENSUSPLUS_USING_WHOLIB = "Benutze WhoLib"

CENSUSPLUS_US_LOCALE = "Auswählen, falls du auf einem US Server spielst"

CENSUSPLUS_VERBOSEOFF = "Ausführlicher Modus: AUS"

CENSUSPLUS_VERBOSEON = "Ausführlicher Modus: AN"

CENSUSPLUS_VERBOSE_TOOLTIP = "Entferne den Haken, um den Spam zu stoppen!"

CENSUSPLUS_WAITING = "Warte um Wer Anfrage zu senden..."

CENSUSPLUS_WARLOCK = "Hexenmeister"

CENSUSPLUS_WARRIOR = "Krieger"

CENSUSPLUS_WAS = "war"

CENSUSPLUS_WHOQUERY = "/wer Anfrage:"

CENSUSPLUS_WORGEN = "Worgen"

CENSUSPLUS_WRONGLOCAL_PURGE = "Die Gebietsschemaeinstellung wurde geändert. Die Datenbank wurd gelöscht."
end