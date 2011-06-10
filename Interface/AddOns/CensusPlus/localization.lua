--[[
	CensusPlus for World of Warcraft(tm).
	
	Copyright 2005 - 2006 Cooper Sellers and WarcraftRealms.com

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
CENSUSPlusFemale = { };

CENSUSPlus_BUTTON_TEXT      = "Census+";
CENSUSPlus_BUTTON_SUBTEXT   = "Realm Census";
CENSUSPlus_BUTTON_TIP       = "Click here to show or hide Census+.";
CENSUSPlus_HELP             = " Use /censusplus to open and close the Census+ UI.";

CENSUSPlus_MSG1             = " Loaded - type /censusplus or /census+ to open main window";
CENSUSPlus_MSG2             = "Use /censusdate to set today's date in the format of MM-DD-YYYY, ie. 12-25-2004";

CENSUSPlus_UPLOAD           = "Be sure to upload your CensusPlus data to www.WarcraftRealms.com!";
CENSUSPlus_SETTINGDATE      = "Setting date to => ";
CENSUSPlus_PAUSE            = "Pause";
CENSUSPlus_UNPAUSE          = "Un-Pause";
CENSUSPlus_STOP             = "Stop";
CENSUSPlus_PRUNE			= "Prune";

CENSUSPlus_TAKECENSUS       = "Take a census of players \ncurrently online on this server \nand in this faction";
CENSUSPlus_PURGEDATABASE    = "Purge the database of all data";
CENSUSPlus_PAUSECENSUS      = "Pause the current census";
CENSUSPlus_UNPAUSECENSUS    = "Un-Pause the current census";
CENSUSPlus_STOPCENSUS       = "Stop the currently active CensusPlus";
CENSUSPlus_PRUNECENSUS		= "Prune the database by removing characters not seen in 30 days.";

CENSUSPlus_PRUNEINFO		= "Pruned %d characters.";

CENSUSPlus_PURGEMSG         = "Purged character database.";
CENSUSPlus_ISINPROGRESS     = "A CensusPlus is in progress, try again later";
CENSUSPlus_TAKINGONLINE     = "Taking census of characters online...";
CENSUSPlus_PLZUPDATEDATE    = "Please use /censusdate to set today's date for more more accurate data.  Format /censusdate MM-DD-YYYY, example, /censusdate 12-25-2004";
CENSUSPlus_NOCENSUS         = "A Census is not currently in progress";
CENSUSPlus_FINISHED         = "Finished Taking data. Found %s new characters and saw %s. Took %s.";
CENSUSPlus_TOOMANY          = "WARNING: Too many characters matching: %s";
CENSUSPlus_WAITING          = "Waiting to send who request...";
CENSUSPlus_SENDING          = "Sending /who %s";
CENSUSPlus_PROCESSING       = "Processing %s characters.";

CENSUSPlus_REALMNAME        = "Realm: %s";
CENSUSPlus_REALMUNKNOWN     = "Realm: Unknown";
CENSUSPlus_FACTION          = "Faction: %s";
CENSUSPlus_FACTIONUNKNOWN   = "Faction: Unknown";
CENSUSPlus_LOCALE           = "Locale : %s";
CENSUSPlus_LOCALEUNKNOWN    = "Locale : Unknown";
CENSUSPlus_TOTALCHAR        = "Total Characters: %d";
CENSUSPlus_TOTALCHAR_0      = "Total Characters: 0";
CENSUSPlus_TOTALCHARXP      = "XP Factor: %d";
CENSUSPlus_TOTALCHARXP_0    = "XP Factor: 0";
CENSUSPlus_SCAN_PROGRESS    = "Scan Progress: %d queries in the queue - %s";
CENSUSPlus_SCAN_PROGRESS_0  = "No Scan In Progress";
CENSUSPlus_AUTOCLOSEWHO     = "Automatically Close Who";
CENSUSPlus_SHOWMINI         = "Show Mini On Start";
CENSUSPlus_UNGUILDED        = "(Unguilded)";
CENSUSPlus_TAKE             = "Take";
CENSUSPlus_TOPGUILD         = "Top Guilds By XP";
CENSUSPlus_RACE             = "Races";
CENSUSPlus_CLASS            = "Classes";
CENSUSPlus_LEVEL            = "Levels";
CENSUSPlus_PURGE            = "Purge";
CENSUSPlus_MAXXED			= "MAXXED!";

CENSUSPlus_MAXIMIZE         = "Maximize the CensusPlus Window";
CENSUSPlus_MINIMIZE         = "Minimize the CensusPlus Window";
CENSUSPlus_BUTTON_MINIMIZE  = "Minimize";

CENSUSPlus_DRUID            = "Druid";
CENSUSPlus_HUNTER           = "Hunter";
CENSUSPlus_MAGE             = "Mage";
CENSUSPlus_PRIEST           = "Priest";
CENSUSPlus_ROGUE            = "Rogue";
CENSUSPlus_WARLOCK          = "Warlock";
CENSUSPlus_WARRIOR          = "Warrior";
CENSUSPlus_SHAMAN           = "Shaman";
CENSUSPlus_PALADIN          = "Paladin";
CENSUSPlus_DEATHKNIGHT		= "Death Knight";

CENSUSPlus_DWARF            = "Dwarf";
CENSUSPlus_GNOME            = "Gnome";
CENSUSPlus_HUMAN            = "Human";
CENSUSPlus_NIGHTELF         = "Night Elf";
CENSUSPlus_ORC              = "Orc";
CENSUSPlus_TAUREN           = "Tauren";
CENSUSPlus_TROLL            = "Troll";
CENSUSPlus_UNDEAD           = "Undead";
CENSUSPlus_DRAENEI          = "Draenei";
CENSUSPlus_BLOODELF         = "Blood Elf";
CENSUSPlus_WORGEN			= "Worgen";
CENSUSPlus_GOBLIN			= "Goblin";

CENSUSPlus_WarsongGulch     = "Warsong Gulch";  
CENSUSPlus_AlteracValley    = "Alterac Valley";
CENSUSPlus_ArathiBasin		= "Arathi Basin";
CENSUSPlus_EyeOfTheStorm    = "Eye of the Storm";

CENSUSPLUS_US_LOCALE		= "Select if you play on US Servers";
CENSUSPLUS_EU_LOCALE		= "Select if you play on EURO Servers";
CENSUSPLUS_LOCALE_SELECT	= "Select if you play on US or EURO servers";

CENSUSPlus_BUTTON_OPTIONS	= "Options";
CENSUSPlus_OPTIONS_HEADER	= "Census+ Options";
CENSUSPlus_ISINBG			= "You are currently in a Battleground so a Census cannot be taken";
CENSUS_OPTIONS_BUTPOS		= "Button Position";
CENSUS_OPTIONS_BUTSHOW      = "Show Minimap Button";
CENSUS_OPTIONS_AUTOCENSUS   = "Auto-Census";
CENSUS_OPTIONS_THISPROFILE  = "Collect Profile for this Char";
CENSUS_OPTIONS_AUTOSTART    = "Auto-Start";
CENSUS_OPTIONS_VERBOSE      = "Verbose";
CENSUS_OPTIONS_SOUND_ON_COMPLETE = "Play Sound When Done";
CENSUS_OPTIONS_LOG_BARS		= "Logarithmic Level Bars";

CENSUSPlus_AUTOSTART_TOOLTIP = "Enable Census+ to start automatically";
CENSUSPlus_VERBOSE_TOOLTIP  = "Deselect to stop the spam!";
CENSUSPlus_AUTOCENSUS_TOOLTIP = "Enable Census+ to run automatically while playing";
CENSUSPlus_THISPROFILE_TOOLTIP = "Collect profile data for this character to upload to WarcraftRealms.com";

CENSUSPlus_BUTTON_CHARACTERS = "Show Chars";
CENSUSPlus_Characters		= "Characters";

CENSUS_BUTTON_TOOLTIP		= "Open CensusPlus";


--|cff979797[11:19:12]|r|c00000000|r |cffd8d8d8[|r|Hplayer:Rollee:93|h|cffd8d83f1|r:|cfffff468Rollee|r|h|cffd8d8d8]|r: Level 1 Troll Rogue - Durotar
--|Hplayer:Rollee|h[Rollee]|h: Level 1 Troll Rogue - Durotar
CENSUS_SINGLE_MATCH_PATTERN = "(.+)%: (%a+) (%d+) (.+) %- (.+)";

CENSUS_LEVEL_NO_GUILD = "%[(.+)%: Level (%d+) (%a+) (%a+) %- (.+)";
CENSUS_LEVEL_W_GUILD  = "%[(.+)%: Level (%d+) (%a+) (%a+) %<(.+)%> %- (.+)";
CENSUS_LEVEL_W_GUILD_2  = "%[(.+)%: Level (%d+) (%a+) (%a+) (%a+) %<(.+)%> %- (.+)";
CENSUS_LEVEL_NO_GUILD_2  = "%[(.+)%: Level (%d+) (%a+) (%a+) (%a+) %- (.+)";

CENSUSPlus_CANCEL			= "Cancel";

CENSUSPlus_OVERRIDE			 = "Census in progress, submitting override";
CENSUSPlus_OVERRIDE_COMPLETE = "Override complete resuming census";
CENSUSPlus_OVERRIDE_COMPLETE_BUT_PAUSED = "Override complete, but census has been paused";

CENSUSPlus_PURGE_LOCAL_CONFIRM = "Are you sure you wish to PURGE your local database?";
CENSUSPlus_OVERRIDE_COMPLET_PAUSED = "Override complete but Census has been paused, Click to Continue";

CENSUSPlus_YES			= "Yes";
CENSUSPlus_NO			= "No";
CENSUSPlus_CONTINUE		= "Continue";

if ( GetLocale() == "frFR" ) then
    -- Traduit par Juki <Unskilled>
    
    CENSUSPlus_BUTTON_TEXT      = "Census+";
    CENSUSPlus_BUTTON_SUBTEXT   = "Stats serveur";
    CENSUSPlus_BUTTON_TIP       = "Cliquez ici pour montrer ou masquer Census+.";
    CENSUSPlus_HELP             = " Utilisez /censusplus pour ouvrir et fermer Census+.";
    
    CENSUSPlus_MSG1             = " Chargée - Tapez /censusplus ou /census+ pour ouvrir la fenêtre principale";
    CENSUSPlus_MSG2             = "Utilisez /censusdate pour configurer la date du jour dans le format MM-DD-YYYY, ie.12-25-2004";

    CENSUSPlus_UPLOAD           = "";
    CENSUSPlus_UPLOAD2          = "";
    CENSUSPlus_SETTINGDATE      = "Mise à jour de la date => ";
    CENSUSPlus_PAUSE            = "Pause";
    CENSUSPlus_UNPAUSE          = "Reprendre";
    CENSUSPlus_STOP             = "Stop";
    
    CENSUSPlus_TAKECENSUS       = "Faire un recensement des joueurs \nactuellement en ligne sur ce serveur \net dans cette faction";
    CENSUSPlus_PURGEDATABASE    = "Supprime la base de donnée concernant.";
    CENSUSPlus_PAUSECENSUS      = "Mettre en pause le recensement en cours";
    CENSUSPlus_STOPCENSUS       = "Arrêter le recensement en cours"
    
    CENSUSPlus_PURGEMSG         = "Base de donnée supprimée.";
    CENSUSPlus_ISINPROGRESS     = "Un recensement est en cours, veuillez patienter";
    CENSUSPlus_TAKINGONLINE     = "Recensement des joueurs en cours ...";
    CENSUSPlus_PLZUPDATEDATE    = "SVP utilisez /censusdate pour configurer la date du jour pour des données plus précises. Format /censusdate MM-DD-YYYY, exemple, /censusdate 12-25-2004";
    CENSUSPlus_NOCENSUS         = "Aucun recensement en cours";
    CENSUSPlus_FINISHED         = "Recensement terminé. %s nouveaux personnages et %s mis à jour.";
    CENSUSPlus_TOOMANY          = "ERREUR: Trop de joueurs correspondants à : %s";
    CENSUSPlus_WAITING          = "En attente de lancement de requête /who ...";
    CENSUSPlus_SENDING          = "Envoi de requête /who %s";
    CENSUSPlus_PROCESSING       = "Analyse de %s personnages.";
    
    CENSUSPlus_REALMNAME        = "Serveur : %s";
    CENSUSPlus_REALMUNKNOWN     = "Serveur : Inconnu";
    CENSUSPlus_FACTION          = "Faction : %s";
    CENSUSPlus_FACTIONUNKNOWN   = "Faction : Inconnu";
    CENSUSPlus_TOTALCHAR        = "Nombre de personnages : %d";
    CENSUSPlus_TOTALCHAR_0      = "Nombre de personnages : 0";
    CENSUSPlus_AUTOCLOSEWHO     = "Fermeture auto du /Who";
    CENSUSPlus_SHOWMINI         = "Montrer Mini au démarrage";
    CENSUSPlus_UNGUILDED        = "(Sans Guilde)";
    CENSUSPlus_TAKE             = "Recenser";
    CENSUSPlus_TOPGUILD         = "Meilleures guildes par XP";
    CENSUSPlus_RACE             = "Races";
    CENSUSPlus_CLASS            = "Classes";
    CENSUSPlus_LEVEL            = "Niveaux";
    CENSUSPlus_PURGE            = "Mettre à Zero"; 
    
    CENSUSPlus_MAXIMIZE         = "Agrandir la fenêtre CensusPlus";
    CENSUSPlus_MINIMIZE         = "Réduire la fenêtre CensusPlus";
    CENSUSPlus_BUTTON_MINIMIZE  = "Réduire";
        
    CENSUSPlus_HORDE            = "Horde";
    CENSUSPlus_ALLIANCE         = "Alliance";

    CENSUSPlus_DRUID            = "Druide";
    CENSUSPlusFemale["Druidesse"] = "Druide"; 
    CENSUSPlus_HUNTER           = "Chasseur";
    CENSUSPlusFemale["Chasseresse"] = "Chasseur"; 
    CENSUSPlus_MAGE             = "Mage";
    CENSUSPlus_PRIEST           = "Prêtre";
    CENSUSPlusFemale["Prêtresse"] = "Prêtre"; 
    CENSUSPlus_ROGUE            = "Voleur";
    CENSUSPlusFemale["Voleuse"] = "Voleur"; 
    CENSUSPlus_WARLOCK          = "Démoniste";
    CENSUSPlus_WARRIOR          = "Guerrier";
    CENSUSPlusFemale["Guerrière"] = "Guerrier"; 
    CENSUSPlus_SHAMAN           = "Chaman";
    CENSUSPlusFemale["Chamane"] = "Chaman"; 
    CENSUSPlus_PALADIN          = "Paladin";
	CENSUSPlus_DEATHKNIGHT		= "Chevalier de la mort";	

 
    CENSUSPlus_DWARF            = "Nain";
    CENSUSPlusFemale["Naine"]   = "Nain";
    CENSUSPlus_GNOME            = "Gnome";
    CENSUSPlus_HUMAN            = "Humain";
    CENSUSPlus_NIGHTELF         = "Elfe de la nuit";
    CENSUSPlus_ORC              = "Orc";
    CENSUSPlusFemale["Orque"]   = "Orc";
    CENSUSPlus_TAUREN           = "Tauren";
    CENSUSPlusFemale["Taurène"] = "Tauren";
    CENSUSPlus_TROLL            = "Troll";
    CENSUSPlusFemale["Trollesse"] = "Troll";
    CENSUSPlus_UNDEAD           = "Mort-vivant";
    CENSUSPlusFemale["Morte-vivante"] = "Mort-vivant";
	CENSUSPlus_DRAENEI          = "Draeneï";
	CENSUSPlus_BLOODELF         = "Elfe de sang";
    
	CENSUSPlus_WarsongGulch     = "Goulet des Warsong";  
	CENSUSPlus_AlteracValley    = "Vallée d'Alterac";
	CENSUSPlus_ArathiBasin		= "Bassin d'Arathi";
	CENSUSPlus_EyeOfTheStorm    = "Oeil du cyclone";
    
	CENSUSPLUS_US_LOCALE		= "Choisissez si vous jouez sur un serveur US";
	CENSUSPLUS_EU_LOCALE		= "Choisissez si vous jouez sur un serveur EURO";
    CENSUSPLUS_LOCALE_SELECT    = "Choisissez la localité de votre serveur";

	CENSUS_LEVEL_NO_GUILD = "%[(.+)%: Niveau (%d+) (%a+) (%a+) %- (.+)";
	CENSUS_LEVEL_W_GUILD  = "%[(.+)%: Niveau (%d+) (%a+) (%a+) %<(.+)%> %- (.+)";
	CENSUS_LEVEL_W_GUILD_2  = "%[(.+)%: Niveau (%d+) (%a+) (%a+) (%a+) %<(.+)%> %- (.+)";
	CENSUS_LEVEL_NO_GUILD_2  = "%[(.+)%: Niveau (%d+) (%a+) (%a+) (%a+) %- (.+)";
	
	
    
    
elseif ( GetLocale() == "deDE" ) then
    --  Thanks to MadMax-X for this German translation 
	CENSUSPlus_BUTTON_TEXT      = "Census+"; 
	CENSUSPlus_BUTTON_SUBTEXT   = "Realm Census"; 
	CENSUSPlus_BUTTON_TIP       = "Hier klicken um Census+ anzuzeigen oder zu verstecken."; 
	CENSUSPlus_HELP             = " Benutze /censusplus um die Census+ Oberfläche zu öffnen."; 

	CENSUSPlus_MSG1             = " Geladen - mit /censusplus or /census+ wird das Hauptfenster geöffnet"; 
	CENSUSPlus_MSG2             = "Mit /censusdate kann das aktuelle Datum im Format MM-DD-YYYY gesetzt werden, z.B. 12-25-2004"; 

	CENSUSPlus_UPLOAD           = "Lade deine CensusPlus Daten bei www.WarcraftRealms.com hoch!"; 
	CENSUSPlus_SETTINGDATE      = "Datum wird gesetzt => "; 
	CENSUSPlus_PAUSE            = "Pause"; 
	CENSUSPlus_UNPAUSE          = "Weiter"; 
	CENSUSPlus_STOP             = "Stop"; 

	CENSUSPlus_TAKECENSUS       = "Zähle alle aktiven \nSpieler deiner Fraktion \nauf diesem Server."; 
	CENSUSPlus_PURGEDATABASE    = "Lösche die Datenbank."; 
	CENSUSPlus_PAUSECENSUS      = "Pausiere die laufende Zählung"; 
	CENSUSPlus_STOPCENSUS       = "Stoppe die laufende Zählung"; 

	CENSUSPlus_PURGEMSG         = "Charakterdatenbank für Server %s und Fraktion %s gelöscht."; 
	CENSUSPlus_ISINPROGRESS     = "Es läuft schon eine Zählung, versuch es später nochmal"; 
	CENSUSPlus_TAKINGONLINE     = "Zählung der gerade aktiven Charaktere..."; 
	CENSUSPlus_PLZUPDATEDATE    = "Bitte benutze /censusdate um das aktuelle Datum zu setzen, damit die Auswertung genauer wird. (Format: /censusdate MM-DD-YYYY, z.B. /censusdate 12-25-2004"; 
	CENSUSPlus_NOCENSUS         = "Es läuft gerade keine Zählung"; 
	CENSUSPlus_FINISHED         = "Zählung beendet. %s neue Charactere gefunden und %s aktualisiert."; 
	CENSUSPlus_TOOMANY          = "FEHLER: Zu viele passende Charaktere: %s"; 
	CENSUSPlus_WAITING          = "Warte, um /who zu senden..."; 
	CENSUSPlus_SENDING          = "Sende /who %s"; 
	CENSUSPlus_PROCESSING       = "Verarbeite %s Charaktere."; 

	CENSUSPlus_REALMNAME        = "Server: %s"; 
	CENSUSPlus_REALMUNKNOWN     = "Server: Unbekannt"; 
	CENSUSPlus_FACTION          = "Fraktion: %s"; 
	CENSUSPlus_FACTIONUNKNOWN   = "Fraktion: Unbekannt"; 
	CENSUSPlus_TOTALCHAR        = "Gesamte Charaktere: %d"; 
	CENSUSPlus_TOTALCHAR_0      = "Gesamte Charaktere: 0"; 
	CENSUSPlus_AUTOCLOSEWHO     = "Schließe Who automatisch"; 
	CENSUSPlus_SHOWMINI         = "Mini-Button beim Start anzeigen"; 
	CENSUSPlus_UNGUILDED        = "(Gildenlos)"; 
	CENSUSPlus_TAKE             = "Zählen"; 
	CENSUSPlus_TOPGUILD         = "Top Gilden nach XP"; 
	CENSUSPlus_RACE             = "Rassen"; 
	CENSUSPlus_CLASS            = "Klassen"; 
	CENSUSPlus_LEVEL            = "Level"; 
	CENSUSPlus_PURGE            = "Löschen"; 

	CENSUSPlus_MAXIMIZE         = "Maximiere das CensusPlus Fenster"; 
	CENSUSPlus_MINIMIZE         = "Minimiere das CensusPlus Fenster"; 
	CENSUSPlus_BUTTON_MINIMIZE  = "Minimieren"; 

	CENSUSPlus_HORDE            = "Horde"; 
	CENSUSPlus_ALLIANCE         = "Alliance"; 

	CENSUSPlus_DRUID            = "Druide";
	CENSUSPlusFemale["Druidin"] = "Druide";
	CENSUSPlus_HUNTER           = "Jäger";
	CENSUSPlusFemale["Jägerin"] = "Jäger";
	CENSUSPlus_MAGE             = "Magier";
	CENSUSPlusFemale["Magierin"] = "Magier";
	CENSUSPlus_PRIEST           = "Priester";
	CENSUSPlusFemale["Priesterin"] = "Priester";
	CENSUSPlus_ROGUE            = "Schurke";
	CENSUSPlusFemale["Schurkin"] = "Schurke";
	CENSUSPlus_WARLOCK          = "Hexenmeister";
	CENSUSPlusFemale["Hexenmeisterin"] = "Hexenmeister";
	CENSUSPlus_WARRIOR          = "Krieger";
	CENSUSPlusFemale["Kriegerin"] = "Krieger";
	CENSUSPlus_SHAMAN           = "Schamane";
	CENSUSPlusFemale["Schamanin"] = "Schamane";
	CENSUSPlus_PALADIN          = "Paladin"; 
	CENSUSPlus_DEATHKNIGHT		= "Todesritter";		

	CENSUSPlus_DWARF            = "Zwerg"; 
	CENSUSPlus_GNOME            = "Gnom"; 
	CENSUSPlus_HUMAN            = "Mensch"; 
	CENSUSPlus_NIGHTELF         = "Nachtelf"; 
    CENSUSPlusFemale["Nachtelfe"]  = "Nachtelf"; 	
	CENSUSPlus_ORC              = "Orc"; 
	CENSUSPlus_TAUREN           = "Tauren"; 
	CENSUSPlus_TROLL            = "Troll"; 
	CENSUSPlus_UNDEAD           = "Untoter";   
    CENSUSPlusFemale["Untote"]  = "Untoter"; 	
	CENSUSPlus_DRAENEI          = "Draenei";
	CENSUSPlus_BLOODELF         = "Blutelf";
    CENSUSPlusFemale["Blutelfe"]  = "Blutelf"; 	
	
	CENSUSPlus_WarsongGulch     = "Kriegshymnenschlucht";  
	CENSUSPlus_AlteracValley    = "Alteractal";
	CENSUSPlus_ArathiBasin		= "Arathibecken";
	CENSUSPlus_EyeOfTheStorm    = "Auge des Sturms";

	CENSUSPLUS_US_LOCALE= "Auswählen, wenn du auf US-Servern spielst"; 
	CENSUSPLUS_EU_LOCALE= "Auswählen, wenn du auf EURO-Servern spielst"; 
	CENSUSPLUS_LOCALE_SELECT= "Wähle, ob du auf US oder EURO-Servern spielst";
	
	CENSUSPlus_BUTTON_OPTIONS   = "Optionen";
	CENSUSPlus_OPTIONS_HEADER   = "Census+ Optionen";
	CENSUSPlus_ISINBG	    = "Du befindest dich momentan auf einem Schlachtfeld und daher kann Census+ keine Abfrage duchführen.";
	CENSUS_OPTIONS_BUTPOS	    = "Button Position";
	CENSUS_OPTIONS_BUTSHOW	    = "Minimap-Button";
	CENSUS_OPTIONS_AUTOSTART    = "Autom. Starten";
	CENSUS_OPTIONS_VERBOSE      = "Verbose";
	CENSUS_OPTIONS_AUTOCENSUS   = "Autom. Zählen";
	CENSUS_OPTIONS_THISPROFILE  = "Profil nur diesen Charakter";
	CENSUS_OPTIONS_EXIT	    = "Schließen";

	CENSUS_BUTTON_TOOLTIP	    = "CensusPlus öffnen";

	CENSUS_LEVEL_NO_GUILD = "(.+): Stufe (%d+) (.+) (.+) - (.+)";
	CENSUS_LEVEL_W_GUILD  = "(.+): Stufe (%d+) (.+) (.+) <(.+)> - (.+)";
	
elseif ( GetLocale() == "esES" ) then
	--  Thanks to NeKRoMaNT  EU-Zul'jin   < contacto@nekromant.com> for the Spanish Translation
	CENSUSPlus_BUTTON_TEXT      = "Census+";
	CENSUSPlus_BUTTON_SUBTEXT   = "Estadísticas Servidor";
	CENSUSPlus_BUTTON_TIP       = "Pulsa aquí para mostrar u ocultar Census+.";
	CENSUSPlus_HELP             = " Usa /censusplus para abrir y cerrar la interfaz Census+.";

	CENSUSPlus_MSG1             = " operativo - Escribe /censusplus o /census+ para abrir la ventana principal";

	CENSUSPlus_UPLOAD           = "¡Asegúrate de enviar tus datos a www.WarcraftRealms.com!";
	CENSUSPlus_PAUSE            = "Pausa";
	CENSUSPlus_UNPAUSE          = "Continuar";
	CENSUSPlus_STOP             = "Detener";
	CENSUSPlus_PRUNE            = "Resetear";

	CENSUSPlus_TAKECENSUS       = "Realizar un censo de jugadores \nconectados en este servidor \ny en esta facción";
	CENSUSPlus_PURGEDATABASE    = "Purgar la base de datos.";
	CENSUSPlus_PAUSECENSUS      = "Pausar el censo actual";
	CENSUSPlus_UNPAUSECENSUS    = "Continuar el censo actual";
	CENSUSPlus_STOPCENSUS       = "Detener el censo actual";
	CENSUSPlus_PRUNECENSUS      = "Optimiza la base de datos borrando personajes sin censar en los últimos 30 días";

	CENSUSPlus_PURGEMSG         = "Base de datos de personajes purgada.";
	CENSUSPlus_ISINPROGRESS     = "Censo en progreso, vuelve a intentarlo mas tarde";
	CENSUSPlus_TAKINGONLINE     = "Realizando censo de personajes conectados...";
	CENSUSPlus_NOCENSUS         = "No hay ningún censo activo";
	CENSUSPlus_FINISHED         = "Se ha terminado de recoger datos. Encontrados %s nuevos personajes y %s actualizados. Duración %s.";
	CENSUSPlus_TOOMANY          = "AVISO: Demasiadas coincidencias: %s";
	CENSUSPlus_WAITING          = "Esperando a enviar petición /quien...";
	CENSUSPlus_SENDING          = "Enviando /quien %s";
	CENSUSPlus_PROCESSING       = "Procesando %s personajes.";

	CENSUSPlus_REALMNAME        = "Servidor: %s";
	CENSUSPlus_REALMUNKNOWN     = "ServidorReino: Desconocido";
	CENSUSPlus_FACTION          = "Facción: %s";
	CENSUSPlus_FACTIONUNKNOWN   = "Facción: Desconocida";
	CENSUSPlus_LOCALE           = "Región : %s";
	CENSUSPlus_LOCALEUNKNOWN    = "Región : Desconocida";
	CENSUSPlus_TOTALCHAR        = "Personajes Totales: %d";
	CENSUSPlus_TOTALCHAR_0      = "Personajes Totales: 0";
	CENSUSPlus_AUTOCLOSEWHO     = "Cerrar Quien Automático";
	CENSUSPlus_SHOWMINI         = "Minimizado al inicio";
	CENSUSPlus_UNGUILDED        = "(Sin Hermandad)";
	CENSUSPlus_TAKE             = "Comenzar";
	CENSUSPlus_TOPGUILD         = "Clanes por Experiencia";
	CENSUSPlus_RACE             = "Razas";
	CENSUSPlus_CLASS            = "Clases";
	CENSUSPlus_LEVEL            = "Niveles";
	CENSUSPlus_PURGE            = "Purgar";
	CENSUSPlus_MAXXED           = "MAXXED!";

	CENSUSPlus_MAXIMIZE         = "Maximizar la ventana de CensusPlus";
	CENSUSPlus_MINIMIZE         = "Minimizar la ventana de CensusPlus";
	CENSUSPlus_BUTTON_MINIMIZE  = "Minimizar";

	CENSUSPlus_HORDE            = "Horde";
	CENSUSPlus_ALLIANCE         = "Alliance";

	CENSUSPlus_DRUID            = "Druida";
	CENSUSPlus_HUNTER           = "Cazador";
	CENSUSPlus_MAGE             = "Mago";
	CENSUSPlus_PRIEST           = "Sacerdote";
	CENSUSPlus_ROGUE            = "Pícaro";
	CENSUSPlus_WARLOCK          = "Brujo";
	CENSUSPlus_WARRIOR          = "Guerrero";
	CENSUSPlus_SHAMAN           = "Chamán";
	CENSUSPlus_PALADIN          = "Paladín";
	CENSUSPlus_DEATHKNIGHT		= "Caballero de la Muerte";			

	CENSUSPlus_DWARF            = "Enano";
	CENSUSPlus_GNOME            = "Gnomo";
	CENSUSPlus_HUMAN            = "Humano";
	CENSUSPlus_NIGHTELF         = "Elfo de la noche";
	CENSUSPlus_ORC              = "Orco";
	CENSUSPlus_TAUREN           = "Tauren";
	CENSUSPlus_TROLL            = "Trol";
	CENSUSPlus_UNDEAD           = "No-muerto";
	CENSUSPlus_DRAENEI          = "Draenei";
	CENSUSPlus_BLOODELF         = "Elfo de sangre";
	
   CENSUSPlus_DRUID            = "Druida";
   CENSUSPlus_HUNTER           = "Cazador";
   CENSUSPlusFemale["Cazadora"] = "Cazador"; 
   CENSUSPlus_MAGE             = "Mago"; 
   CENSUSPlusFemale["Maga"] = "Mago"; 
   CENSUSPlus_PRIEST           = "Sacerdote"; 
   CENSUSPlusFemale["Sacerdotisa"] = "Sacerdote"; 
   CENSUSPlus_ROGUE            = "Pícaro"; 
   CENSUSPlusFemale["Pícara"] = "Pícaro"; 
   CENSUSPlus_WARLOCK          = "Brujo"; 
   CENSUSPlusFemale["Bruja"] = "Brujo"; 
   CENSUSPlus_WARRIOR          = "Guerrero"; 
   CENSUSPlusFemale["Guerrera"] = "Guerrero"; 
   CENSUSPlus_SHAMAN           = "Chamán";
   CENSUSPlus_PALADIN          = "Paladín";

   CENSUSPlus_DWARF            = "Enano"; 
   CENSUSPlusFemale["Enana"] = "Enano"; 
   CENSUSPlus_GNOME            = "Gnomo"; 
   CENSUSPlusFemale["Gnoma"] = "Gnomo"; 
   CENSUSPlus_HUMAN            = "Humano"; 
   CENSUSPlusFemale["Humana"] = "Humano"; 
   CENSUSPlus_NIGHTELF         = "Elfo de la noche"; 
   CENSUSPlusFemale["Elfa de la noche"] = "Elfo de la noche"; 
   CENSUSPlus_ORC              = "Orco";
   CENSUSPlus_TAUREN           = "Tauren"; 
   CENSUSPlus_TROLL            = "Trol";
   CENSUSPlus_UNDEAD           = "No-muerto"; 
   CENSUSPlusFemale["No-muerta"] = "No-muerto"; 
   CENSUSPlus_DRAENEI          = "Draenei";
   CENSUSPlus_BLOODELF         = "Elfo de sangre";
   CENSUSPlusFemale["Elfa de sangre"] = "Elfo de sangre"; 
   
 

	CENSUSPlus_WarsongGulch     = "Garganta Grito de Guerra"; 
	CENSUSPlus_AlteracValley    = "Valle de Alterac";
	CENSUSPlus_ArathiBasin      = "Cuenca de Arathi";
	CENSUSPlus_EyeOfTheStorm    = "Ojo de la Tormenta";
	
	CENSUSPlus_BUTTON_OPTIONS   = "Opciones";
	CENSUSPlus_OPTIONS_HEADER   = "Opciones Census+";
	CENSUS_OPTIONS_BUTPOS      = "Posición de botón";
	CENSUS_OPTIONS_BUTSHOW      = "Mostrar botón";

	CENSUSPlus_BUTTON_CHARACTERS = "Mostrar personajes";
	CENSUSPlus_Characters      = "Personajes";

	CENSUS_BUTTON_TOOLTIP      = "Abrir CensusPlus";

	CENSUS_LEVEL_NO_GUILD = "(.+): Nivel (%d+) (.+) (.+) - (.+)";
	CENSUS_LEVEL_W_GUILD  = "(.+): Nivel (%d+) (.+) (.+) <(.+)> - (.+)";

	CENSUSPlus_CANCEL         = "Cancelar"; 
elseif ( GetLocale() == "koKR" ) then
  -- This is Korean Locale, Translated by crezol --

CENSUSPlusFemale = { };

CENSUSPlus_BUTTON_TEXT      = "센서스+";
CENSUSPlus_BUTTON_SUBTEXT   = "서버 센서스";
CENSUSPlus_BUTTON_TIP       = "센서스+ 를 보이거나 숨기려면 클릭하십시오.";
CENSUSPlus_HELP             = " /censusplus 를 사용해 센서스+ UI 를 열거나 닫을 수 있습니다.";

CENSUSPlus_MSG1             = "센서스+ 로드됨 - /censusplus 나 /census+ 를 입력해 메인 창을 띄울 수 있습니다.";
CENSUSPlus_MSG2             = "/censusdate 를 사용해 오늘의 날짜를 설정하세요.(형식: MM-DD-YYYY, 예. 12-25-2004)";

CENSUSPlus_UPLOAD           = "www.WarcraftRealms.com 에서 센서스+ 업데이트를 확인하세요!";
CENSUSPlus_SETTINGDATE      = "날짜 변경 => ";
CENSUSPlus_PAUSE            = "일시중지";
CENSUSPlus_UNPAUSE          = "계속";
CENSUSPlus_STOP             = "중지";
CENSUSPlus_PRUNE			= "간략화";

CENSUSPlus_TAKECENSUS       = "현재 이 서버와 이 진영에 속한 \n플레이어를 센서스로 가져옵니다.";
CENSUSPlus_PURGEDATABASE    = "모든 데이터를 소거합니다.";
CENSUSPlus_PAUSECENSUS      = "현재 센서스를 일시중지 합니다.";
CENSUSPlus_UNPAUSECENSUS    = "일시중지된 센서스를 계속 진행합니다.";
CENSUSPlus_STOPCENSUS       = "활동중인 센서스+를 중지합니다.";
CENSUSPlus_PRUNECENSUS		= "30일동안 검색되지 않은 플레이어를 \n데이터베이스에서 제거해 간략화 합니다.";

CENSUSPlus_PRUNEINFO		= "%d 케릭터 간략화됨.";

CENSUSPlus_PURGEMSG         = "케릭터 데이터베이스가 소거되었습니다.";
CENSUSPlus_ISINPROGRESS     = "센서스+가 진행중입니다, 나중에 다시 시도하십시오.";
CENSUSPlus_TAKINGONLINE     = "온라인 상태의 케릭터를 센서스로 가져오는 중입니다...";
CENSUSPlus_PLZUPDATEDATE    = "좀더 정확한 데이터를 얻기 위해 /censusdate 를 사용해 오늘 날짜를 수정하십시오. (형식 /censusdate MM-DD-YYYY, 예, /censusdate 12-25-2004)";
CENSUSPlus_NOCENSUS         = "센서스가 현재 진행중이 아닙니다.";
CENSUSPlus_FINISHED         = "데이터 수집 완료. %s 의 새 케릭터가 검색되어 총 %s 케릭터를 확인했습니다. 소요 시간 :%s ";
CENSUSPlus_TOOMANY          = "경고: 너무 많은 케릭터 일치: %s";
CENSUSPlus_WAITING          = "누구 명령어를 보내기 위해 기다리는 중...";
CENSUSPlus_SENDING          = "검색중 : /누구 ";
CENSUSPlus_PROCESSING       = "%s 케릭터를 수집함.";

CENSUSPlus_REALMNAME        = "서버: %s";
CENSUSPlus_REALMUNKNOWN     = "서버: 알수없음";
CENSUSPlus_FACTION          = "진영: %s";
CENSUSPlus_FACTIONUNKNOWN   = "진영: 알수없음";
CENSUSPlus_LOCALE           = "Locale : %s";
CENSUSPlus_LOCALEUNKNOWN    = "Locale : 알수없음";
CENSUSPlus_TOTALCHAR        = "모든 케릭터: %d";
CENSUSPlus_TOTALCHAR_0      = "모든 케릭터: 0";
CENSUSPlus_TOTALCHARXP      = "XP 지수: %d";
CENSUSPlus_TOTALCHARXP_0    = "XP 지수: 0";
CENSUSPlus_SCAN_PROGRESS    = "검색 진행중: %d 개의 질의 대기중 - %s";
CENSUSPlus_SCAN_PROGRESS_0  = "진행중인 검색이 없습니다.";
CENSUSPlus_AUTOCLOSEWHO     = "누구 창 자동으로 닫기";
CENSUSPlus_SHOWMINI         = "시작시 최소화 보기";
CENSUSPlus_UNGUILDED        = "(길드없음)";
CENSUSPlus_TAKE             = "가져오기";
CENSUSPlus_TOPGUILD         = "XP 에 의한 길드 순위";
CENSUSPlus_RACE             = "종족";
CENSUSPlus_CLASS            = "직업";
CENSUSPlus_LEVEL            = "레벨";
CENSUSPlus_PURGE            = "소거";
CENSUSPlus_MAXXED			= "MAXXED!";

CENSUSPlus_MAXIMIZE         = "센서스+ 창 최대화";
CENSUSPlus_MINIMIZE         = "센서스+ 창 최소화";
CENSUSPlus_BUTTON_MINIMIZE  = "최소화";

CENSUSPlus_DRUID            = "드루이드";       
CENSUSPlus_HUNTER           = "사냥꾼";         
CENSUSPlus_MAGE             = "마법사";         
CENSUSPlus_PRIEST           = "사제";           
CENSUSPlus_ROGUE            = "도적";           
CENSUSPlus_WARLOCK          = "흑마법사";       
CENSUSPlus_WARRIOR          = "전사";           
CENSUSPlus_SHAMAN           = "주술사";         
CENSUSPlus_PALADIN          = "성기사";         
CENSUSPlus_DEATHKNIGHT		= "죽음의 기사";      
                                                
CENSUSPlus_DWARF            = "드워프";         
CENSUSPlus_GNOME            = "노움";           
CENSUSPlus_HUMAN            = "인간";           
CENSUSPlus_NIGHTELF         = "나이트 엘프";    
CENSUSPlus_ORC              = "오크";           
CENSUSPlus_TAUREN           = "타우렌";         
CENSUSPlus_TROLL            = "트롤";           
CENSUSPlus_UNDEAD           = "언데드";         
CENSUSPlus_DRAENEI          = "드레나이";       
CENSUSPlus_BLOODELF         = "블러드 엘프";    
                                                
CENSUSPlus_WarsongGulch     = "전쟁노래 협곡";  
CENSUSPlus_AlteracValley    = "알터렉 계곡";    
CENSUSPlus_ArathiBasin		= "아라시 분지";      
CENSUSPlus_EyeOfTheStorm    = "폭풍의 눈";      

CENSUSPLUS_US_LOCALE		= "Select if you play on US Servers";
CENSUSPLUS_EU_LOCALE		= "Select if you play on EURO Servers";
CENSUSPLUS_LOCALE_SELECT	= "Select if you play on US or EURO servers";

CENSUSPlus_BUTTON_OPTIONS	= "설정";
CENSUSPlus_OPTIONS_HEADER	= "센서스+ 설정";
CENSUSPlus_ISINBG			= "현재 전장에 있기 때문에 센서스가 작동하지 않습니다.";
CENSUS_OPTIONS_BUTPOS		= "버튼 위치";
CENSUS_OPTIONS_BUTSHOW      = "미니맵 버튼 보이기";
CENSUS_OPTIONS_AUTOCENSUS   = "자동-센서스";
CENSUS_OPTIONS_THISPROFILE  = "이 케릭터를 위해 프로필 모으기";
CENSUS_OPTIONS_AUTOSTART    = "자동-시작";
CENSUS_OPTIONS_VERBOSE      = "모두 알림";
CENSUS_OPTIONS_SOUND_ON_COMPLETE = "종료시 소리 재생";
CENSUS_OPTIONS_LOG_BARS		= "로그마틱 레벨 그래프";

CENSUSPlus_AUTOSTART_TOOLTIP = "자동으로 센서스+ 활성화";
CENSUSPlus_VERBOSE_TOOLTIP  = "스팸 메시지를 멈추려면 해제하세요!";
CENSUSPlus_AUTOCENSUS_TOOLTIP = "플레이 시 자동으로 센서스+ 검색 시작";
CENSUSPlus_THISPROFILE_TOOLTIP = "WarcraftRealms.com 에 업로드 하기 위해 이 케릭터의 프로필 데이터를 모읍니다.";

CENSUSPlus_BUTTON_CHARACTERS = "케릭터 보기";
CENSUSPlus_Characters		= "케릭터";

CENSUS_BUTTON_TOOLTIP		= "센서스+ 열기";


--|cff979797[11:19:12]|r|c00000000|r |cffd8d8d8[|r|Hplayer:Rollee:93|h|cffd8d83f1|r:|cfffff468Rollee|r|h|cffd8d8d8]|r: Level 1 Troll Rogue - Durotar
--|Hplayer:Rollee|h[Rollee]|h: Level 1 Troll Rogue - Durotar
CENSUS_SINGLE_MATCH_PATTERN = "(.+)%: (%a+) (%d+) (.+) %- (.+)";

CENSUS_LEVEL_NO_GUILD = "%[(.+)%: 레벨 (%d+) (%a+) (%a+) %- (.+)";
CENSUS_LEVEL_W_GUILD  = "%[(.+)%: 레벨 (%d+) (%a+) (%a+) %<(.+)%> %- (.+)";
CENSUS_LEVEL_W_GUILD_2  = "%[(.+)%: 레벨 (%d+) (%a+) (%a+) (%a+) %<(.+)%> %- (.+)";
CENSUS_LEVEL_NO_GUILD_2  = "%[(.+)%: 레벨 (%d+) (%a+) (%a+) (%a+) %- (.+)";

CENSUSPlus_CANCEL			= "취소";

CENSUSPlus_OVERRIDE			 = "센서스가 작업중입니다, 우선적으로 해당 명령을 수행합니다. 잠시만 기다려주세요.";
CENSUSPlus_OVERRIDE_COMPLETE = "우선 시행 완료, 센서스 검색을 재개합니다.";
CENSUSPlus_OVERRIDE_COMPLETE_BUT_PAUSED = "우선 시행 완료, 센서스 일시중지됨.";

CENSUSPlus_PURGE_LOCAL_CONFIRM = "정말로 로컬 데이터베이스의 모든 자료를 소거하겠습니까?";
CENSUSPlus_OVERRIDE_COMPLET_PAUSED = "우선 시행이 완료되었지만 센서스가 일시중지 되었습니다. 계속 버튼을 클릭하세요.";

CENSUSPlus_YES			= "예";
CENSUSPlus_NO			= "아니오";
CENSUSPlus_CONTINUE		= "계속";
	
end

