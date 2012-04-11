--[[
************************************************************************
Project				: Broker_Factions
Author				: torhal
Project Revision	: 3.2.6-release
Project Date		: 20111012085757

File				: Locales\enUS.lua
Commit Author		: zhinjio
Commit Revision		: 4
Commit Date			: 20110503035214
************************************************************************
Description	:
	English translation strings
TODO		:
************************************************************************
--]]
local MODNAME = "BFactions"
local L = LibStub:GetLibrary("AceLocale-3.0"):NewLocale( MODNAME, "enUS", true )
if not L then return end

L["%s to go"] = true
L["Activates and displays a scrolling slider bar, for the tooltip."] = true
L["Appends a '+' label suffix to collapsed faction headers (assuming collapsed headers are shown)."] = true
L["Appends faction standing, to the button label."] = true
L["Appends percentage values to the button label."] = true
L["Appends raw numbers in the form of (xxx/xxxx), to the button label."] = true
L["Appends remaining reputation to reach the next standing, to the button label."] = true
L["Appends session reputation gains in the form of [xxx], to the button label."] = true
L["Author : "] = true
L["Auto faction watch on reputation gains"] = true
L["Automatically sets the faction watched on the button/block to the last faction you gained reputation with."] = true
L["Build Date : "] = true
L["Button"] = true
L["Change color of percentages/raw numbers/'to go' according to faction reputation standing."] = true
L["Click header lines to expand/contract"] = true
L["Colorize faction statistics"] = true
L["Ctrl+Left Click"] = true
L["DISPLAY_DEBUG_DESC"] = "Checked to display DEBUG information"
L["DISPLAY_HIDEEXALTED_DESC"] = "Check to hide Exalted factions in the tooltip"
L["DISPLAY_OPTIONS_DESC"] = "Options that change the way data is displayed in the tooltip"
L["DISPLAY_SHOWCOLLAPSED_DESC"] = "Check to display collapsed headers"
L["DISPLAY_SHOWGAINS_DESC"] = "Check to display session gains"
L["DISPLAY_SHOWHINTS_DESC"] = "Check to display tooltip hints"
L["DISPLAY_SHOWPERC_DESC"] = "Check to display percentage complete"
L["DISPLAY_SHOWRAW_DESC"] = "Check to display raw values"
L["DISPLAY_SHOWREMAIN_DESC"] = "Check to display remaining rep to next level"
L["Database Version : "] = true
L["Database upgraded to %s"] = true
L["Display Debug"] = true
L["Display Options"] = true
L["Draws the icon on the minimap."] = true
L["Enable Scrolling"] = true
L["Exalted"] = true
L["Faction"] = true
L["Faction Monitoring"] = true
L["Faction index not yet initialized !"] = true
L["Friendly"] = true
L["GENERAL_INFO_DESC"] = "Version and author information"
L["General"] = true
L["General Information"] = true
L["Hated"] = true
L["Helpful Translators (thank you) : %s"] = true
L["Hidden Faction"] = true
L["Hide Exalted Factions"] = true
L["Hide Hint Text"] = true
L["Hide Monitored Faction"] = true
L["Hides faction text from the button."] = true
L["Hides factions with Exalted standing, from the tooltip."] = true
L["Hides the tooltip information/hint text."] = true
L["Honored"] = true
L["Hostile"] = true
L["Ignore Exalted factions"] = true
L["Ignore negative reputation gains"] = true
L["Inactive"] = true
L["Inactive Faction"] = true
L["Inserts a new tooltip column, showing faction standing."] = true
L["Inserts a new tooltip column, showing remaining reputation to reach the next standing."] = true
L["Inserts a new tooltip column, showing reputation percentage values."] = true
L["Inserts a new tooltip column, showing reputation raw numbers in the form of 'xxx/xxxx'."] = true
L["Inserts a new tooltip column, showing session reputation gains in the form of 'xxx'."] = true
L["Left Click"] = true
L["Left-click faction lines to set watched faction"] = true
L["MINIMAP_OPTIONS_DESC"] = "Options regarding the minimap icon"
L["MISCDISPLAY_OPTIONS_DESC"] = "Other options"
L["Minimalistic LDB plugin that allows simple faction reputation monitoring."] = true
L["Minimap Icon Options"] = true
L["Miscellaneous Display Options"] = true
L["Move the slider to adjust scaling for the tooltip."] = true
L["Neutral"] = true
L["No Faction"] = true
L["Raw"] = true
L["Remaining"] = true
L["Rep"] = true
L["Reputation with (.*) decreased"] = true
L["Reputation with (.*) increased"] = true
L["Reset Session Gains"] = true
L["Resets the reputation session gain counters."] = true
L["Revered"] = true
L["Right Click"] = true
L["Right-click for Configuration"] = true
L["Select Faction to Watch"] = true
L["Select a faction to watch on the button/block."] = true
L["Session"] = true
L["Sets the faction watched on the button/block to the faction set in the character's reputation tab."] = true
L["Sets the tooltip maximum height, after which it will be scrollable."] = true
L["Shift+Left Click"] = true
L["Show Collapsed Header Suffix"] = true
L["Show Collapsed Headers"] = true
L["Show Hint Lines"] = true
L["Show Minimap Icon"] = true
L["Show Percentage"] = true
L["Show Percentages"] = true
L["Show Raw Numbers"] = true
L["Show Raw Values"] = true
L["Show Remaining"] = true
L["Show Reputation To Go"] = true
L["Show Session Gains"] = true
L["Show Standing"] = true
L["Show Text"] = true
L["Status"] = true
L["TEXT_FACTIONWATCH_DESC"] = "Select the faction to display on the LDB Display"
L["TEXT_OPTIONS_DESC"] = "Options regarding the text on the LDB Display"
L["TEXT_SHOWGAINS_DESC"] = "Check to show session gains on the LDB Display"
L["TEXT_SHOWPERC_DESC"] = "Check to show percentage on the LDB Display"
L["TEXT_SHOWRAW_DESC"] = "Check to show raw values on the LDB Display"
L["TEXT_SHOWREMAIN_DESC"] = "Check to show remaining reputation on the LDB Display"
L["TEXT_SHOW_DESC"] = "Check to show text on the LDB Display"
L["TOOLTIPDISPLAY_OPTIONS_DESC"] = "Options regarding what is displayed in the tooltip"
L["TOOLTIP_DELAY_DESC"] = "Time (in seconds) that the tooltip will remain after moving mouse away"
L["TOOLTIP_SCALE_DESC"] = "Slide to change the scale of the tooltip"
L["Text Options"] = true
L["To Go"] = true
L["Toggles display of collapsed faction headers (normally hidden), on the tooltip."] = true
L["Tooltip"] = true
L["Tooltip Auto-hide Delay"] = true
L["Tooltip Display Options"] = true
L["Tooltip Maximum Height"] = true
L["Tooltip Scale"] = true
L["Turning this option on will cause the button/block not to auto-switch to a faction you are exalted with, when reputation with it, is modified."] = true
L["Turning this option on will cause the button/block not to auto-switch to a faction, when getting negative reputation with it."] = true
L["Unfriendly"] = true
L["Unknown Faction"] = true
L["Use Blizzard's faction watch"] = true
L["Values"] = true
L["Version : "] = true
L["You are now (%a+) with (.*)%."] = true
L["on faction header to expand or collapse it."] = true
L["on faction name to watch on the button/block."] = true
L["on plugin to open Blizzard's Reputation tab."] = true
L["on plugin to open Configuration Menu."] = true
L["to paste Reputation info into chat."] = true
L["to toggle Reputation bar watch."] = true


--[[
************************************************************************
CHANGELOG:

Date : 4/5/11
	initial version
************************************************************************
]]--