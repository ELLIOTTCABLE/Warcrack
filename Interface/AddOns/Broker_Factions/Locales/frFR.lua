--[[
************************************************************************
Project				: Broker_Factions
Author				: zhinjio
Project Revision	: 3.2.5-release
Project Date		: 20110515000702

File				: Locales\frFR.lua
Commit Author		: zhinjio
Commit Revision		: 4
Commit Date			: 20110503035214
************************************************************************
Description	:
	French translation strings
TODO		:
************************************************************************
--]]
local MODNAME = "BFactions"
local L = LibStub:GetLibrary("AceLocale-3.0"):NewLocale( MODNAME, "frFR" )
if not L then return end

L["%s to go"] = "%s restant"
L["Activates and displays a scrolling slider bar, for the tooltip."] = "Active et affiche une barre de défilement pour le tooltip."
L["Appends a '+' label suffix to collapsed faction headers (assuming collapsed headers are shown)."] = "Ajoute un '+' aux titres des groupes de factions compactés (dans le cas où ces titres sont affichés)."
L["Appends faction standing, to the button label."] = "Ajoute le niveau de réputation de la faction au texte du bouton."
L["Appends percentage values to the button label."] = "Ajoute le pourcentage du niveau de réputation au texte du bouton."
L["Appends raw numbers in the form of (xxx/xxxx), to the button label."] = "Ajoute le nombre de points sous la forme (xxx/xxxx) au texte du bouton."
L["Appends remaining reputation to reach the next standing, to the button label."] = "Ajoute la réputation manquante pour atteindre le prochain niveau au texte du bouton."
L["Appends session reputation gains in the form of [xxx], to the button label."] = "Ajoute les gains de réputation de la session sous la forme [xxx] au texte du bouton."
-- L["Author : "] = "Author : "
L["Auto faction watch on reputation gains"] = "Affichage auto de la faction selon gains de réput"
L["Automatically sets the faction watched on the button/block to the last faction you gained reputation with."] = "Sélection automatique de la faction selon le dernier gain de réputation."
-- L["Build Date : "] = "Build Date : "
L["Button"] = "Bouton"
L["Change color of percentages/raw numbers/'to go' according to faction reputation standing."] = "Change la couleur des chiffres (pourcentage/nombres/manquant) en fonction de la réputation de la faction."
-- L["Click header lines to expand/contract"] = "Click header lines to expand/contract"
L["Colorize faction statistics"] = "Colorer les stats de la faction"
L["Ctrl+Left Click"] = "Ctrl-clic-gauche"
-- L["DISPLAY_DEBUG_DESC"] = "Checked to display DEBUG information"
-- L["DISPLAY_HIDEEXALTED_DESC"] = "Check to hide Exalted factions in the tooltip"
-- L["DISPLAY_OPTIONS_DESC"] = "Options that change the way data is displayed in the tooltip"
-- L["DISPLAY_SHOWCOLLAPSED_DESC"] = "Check to display collapsed headers"
-- L["DISPLAY_SHOWGAINS_DESC"] = "Check to display session gains"
-- L["DISPLAY_SHOWHINTS_DESC"] = "Check to display tooltip hints"
-- L["DISPLAY_SHOWPERC_DESC"] = "Check to display percentage complete"
-- L["DISPLAY_SHOWRAW_DESC"] = "Check to display raw values"
-- L["DISPLAY_SHOWREMAIN_DESC"] = "Check to display remaining rep to next level"
-- L["Database Version : "] = "Database Version : "
-- L["Database upgraded to %s"] = "Database upgraded to %s"
-- L["Display Debug"] = "Display Debug"
-- L["Display Options"] = "Display Options"
-- L["Draws the icon on the minimap."] = "Draws the icon on the minimap."
L["Enable Scrolling"] = "Activer le défilement"
-- L["Exalted"] = "Exalted"
L["Faction"] = "Faction"
L["Faction Monitoring"] = "Surveiller la réputation de :"
L["Faction index not yet initialized !"] = "Index de faction pas encore initialisé !"
-- L["Friendly"] = "Friendly"
-- L["GENERAL_INFO_DESC"] = "Version and author information"
L["General"] = "Général"
-- L["General Information"] = "General Information"
-- L["Hated"] = "Hated"
-- L["Helpful Translators (thank you) : %s"] = "Helpful Translators (thank you) : %s"
L["Hidden Faction"] = "Faction cachée"
L["Hide Exalted Factions"] = "Cacher les factions exaltées"
-- L["Hide Hint Text"] = "Hide Hint Text"
L["Hide Monitored Faction"] = "Cacher la faction surveillée"
L["Hides faction text from the button."] = "Cacher le texte de la faction surveillée."
L["Hides factions with Exalted standing, from the tooltip."] = "Cacher dans le tooltip les factions exaltées."
-- L["Hides the tooltip information/hint text."] = "Hides the tooltip information/hint text."
-- L["Honored"] = "Honored"
-- L["Hostile"] = "Hostile"
L["Ignore Exalted factions"] = "Ignorer les factions exaltées"
L["Ignore negative reputation gains"] = "Ignorer les gains de réputation négatifs"
-- L["Inactive"] = "Inactive"
L["Inactive Faction"] = "Faction inactive"
L["Inserts a new tooltip column, showing faction standing."] = "Ajoute une colonne montrant le niveau de réputation de la faction."
L["Inserts a new tooltip column, showing remaining reputation to reach the next standing."] = "Ajoute une colonne montrant la réputation manquante pour atteindre le prochain niveau."
L["Inserts a new tooltip column, showing reputation percentage values."] = "Ajoute une colonne montrant le pourcentage du niveau de réputation."
L["Inserts a new tooltip column, showing reputation raw numbers in the form of 'xxx/xxxx'."] = "Ajoute une colonne montrant le nombre de points sous la forme 'xxx/xxxx'."
L["Inserts a new tooltip column, showing session reputation gains in the form of 'xxx'."] = "Ajoute une colonne montrant les gains de réputation de la session sous la forme 'xxx'."
-- L["Left Click"] = "Left Click"
-- L["Left-click faction lines to set watched faction"] = "Left-click faction lines to set watched faction"
-- L["MINIMAP_OPTIONS_DESC"] = "Options regarding the minimap icon"
-- L["MISCDISPLAY_OPTIONS_DESC"] = "Other options"
L["Minimalistic LDB plugin that allows simple faction reputation monitoring."] = "Plugin LDB minimaliste qui permet un affichage simple des réputations."
-- L["Minimap Icon Options"] = "Minimap Icon Options"
-- L["Miscellaneous Display Options"] = "Miscellaneous Display Options"
L["Move the slider to adjust scaling for the tooltip."] = "Déplacez le curseur pour ajuster l'échelle du tooltip."
-- L["Neutral"] = "Neutral"
L["No Faction"] = "Pas de faction"
L["Raw"] = "Quantité"
-- L["Remaining"] = "Remaining"
-- L["Rep"] = "Rep"
L["Reputation with (.*) decreased"] = "Réputation auprès |2 (.*) baissée"
L["Reputation with (.*) increased"] = "Réputation auprès |2 (.*) augmentée"
L["Reset Session Gains"] = "Réinitialiser les gains de la session"
L["Resets the reputation session gain counters."] = "Réinitialiser les compteurs de réputation de gains de la session."
-- L["Revered"] = "Revered"
-- L["Right Click"] = "Right Click"
-- L["Right-click for Configuration"] = "Right-click for Configuration"
-- L["Select Faction to Watch"] = "Select Faction to Watch"
L["Select a faction to watch on the button/block."] = "Sélectionnez une faction à afficher sur le bouton/bloc."
L["Session"] = "Session"
L["Sets the faction watched on the button/block to the faction set in the character's reputation tab."] = "Afficher la même faction que celle sélectionnée dans l'onglet Réputation."
L["Sets the tooltip maximum height, after which it will be scrollable."] = "Ajuste la hauteur maximum du tooltip au-delà de laquelle il y aura une barre de défilement."
L["Shift+Left Click"] = "Shift-clic-gauche"
L["Show Collapsed Header Suffix"] = "Afficher un suffixe"
L["Show Collapsed Headers"] = "Afficher les titres compactés"
-- L["Show Hint Lines"] = "Show Hint Lines"
-- L["Show Minimap Icon"] = "Show Minimap Icon"
-- L["Show Percentage"] = "Show Percentage"
L["Show Percentages"] = "Afficher les pourcentages"
L["Show Raw Numbers"] = "Afficher les chiffres bruts"
-- L["Show Raw Values"] = "Show Raw Values"
-- L["Show Remaining"] = "Show Remaining"
L["Show Reputation To Go"] = "Afficher la réputation restante"
L["Show Session Gains"] = "Afficher les gains de la session"
L["Show Standing"] = "Afficher le niveau de réputation"
-- L["Show Text"] = "Show Text"
L["Status"] = "Statut"
-- L["TEXT_FACTIONWATCH_DESC"] = "Select the faction to display on the LDB Display"
-- L["TEXT_OPTIONS_DESC"] = "Options regarding the text on the LDB Display"
-- L["TEXT_SHOWGAINS_DESC"] = "Check to show session gains on the LDB Display"
-- L["TEXT_SHOWPERC_DESC"] = "Check to show percentage on the LDB Display"
-- L["TEXT_SHOWRAW_DESC"] = "Check to show raw values on the LDB Display"
-- L["TEXT_SHOWREMAIN_DESC"] = "Check to show remaining reputation on the LDB Display"
-- L["TEXT_SHOW_DESC"] = "Check to show text on the LDB Display"
-- L["TOOLTIPDISPLAY_OPTIONS_DESC"] = "Options regarding what is displayed in the tooltip"
-- L["TOOLTIP_DELAY_DESC"] = "Time (in seconds) that the tooltip will remain after moving mouse away"
-- L["TOOLTIP_SCALE_DESC"] = "Slide to change the scale of the tooltip"
-- L["Text Options"] = "Text Options"
L["To Go"] = "Restant"
L["Toggles display of collapsed faction headers (normally hidden), on the tooltip."] = "Affiche les titres des groupes de faction compactés (normalement cachés)."
L["Tooltip"] = "Tooltip"
-- L["Tooltip Auto-hide Delay"] = "Tooltip Auto-hide Delay"
-- L["Tooltip Display Options"] = "Tooltip Display Options"
L["Tooltip Maximum Height"] = "Hauteur maximum du tooltip"
L["Tooltip Scale"] = "Echelle du tooltip"
L["Turning this option on will cause the button/block not to auto-switch to a faction you are exalted with, when reputation with it, is modified."] = "Activer cette option empêchera le bouton/bloc de changer automatiquement pour une faction déjà exaltée."
L["Turning this option on will cause the button/block not to auto-switch to a faction, when getting negative reputation with it."] = "Activer cette option fera que le texte du bouton/bloc ne changera pas pour la faction envers laquelle on perd de la réputation."
-- L["Unfriendly"] = "Unfriendly"
L["Unknown Faction"] = "Faction inconnue"
L["Use Blizzard's faction watch"] = "Afficher la faction de l'onglet Réputation"
-- L["Values"] = "Values"
-- L["Version : "] = "Version : "
L["You are now (%a+) with (.*)%."] = "Vous êtes maintenant (%a+) auprès |2 (.*)%."
-- L["on faction header to expand or collapse it."] = "on faction header to expand or collapse it."
-- L["on faction name to watch on the button/block."] = "on faction name to watch on the button/block."
-- L["on plugin to open Blizzard's Reputation tab."] = "on plugin to open Blizzard's Reputation tab."
-- L["on plugin to open Configuration Menu."] = "on plugin to open Configuration Menu."
L["to paste Reputation info into chat."] = "pour coller l'info de réputation dans le chat."
L["to toggle Reputation bar watch."] = "pour afficher la barre de réputation."


--[[
************************************************************************
CHANGELOG:

Date : 04/05/11
	initial version
************************************************************************
]]--