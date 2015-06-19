--
--	Wholly
--	Written by scott@mithrandir.com
--
--	This was inspired by my need to replace EveryQuest with something that was more accurate.  The pins
--	was totally inspired by QuestHubber which I found when looking for a replacement for EveryQuest.  I
--	initially made a port of QuestHubber to QuestHubberGrail to make use of the Grail database, but now
--	I have integrated that work into this addon.  Many thanks for all the work put into QuestHubber.  I
--	was inspired to add a quest breadcrumb area from seeing one in Quest Completist.
--
--	Version History
--		001	Initial version.
--		002	Support for displaysDungeonQuests now works properly.
--			Added the ability for the panel tooltip to display questgivers.
--			Added the ability to click a quest in the panel to create a TomTom waypoint.
--			Map pins are only displayed for the proper dungeon level of the map.
--		003	Added a panel button to switch to the current zone.
--			Changed the Close button into a Sort button that switches between three different modes:
--				1. Alphabetical  2. Quest level, then alphabetical  3. Quest status, then alphabetical
--			Made map pins only have one pin per NPC, indicating the "best" color possible.
--			The entire zone dropdown button on the quest log panel now can be clicked to change zones.
--			Corrected a problem where someone running without LibStub would get a LUA error.
--			Corrected a localization issue.
--		004	Added the ability to display a basic quest prerequisite chain in the quest panel tooltip, requiring Grail 014 or later.
--			Added the ability to right-click a "prerequisite" quest in the panel to put a TomTom arrow to the first prerequisite quest.
--			Added Dungeons and Other menu items for map areas in the quest log panel.
--			The last-used sort preference is stored on a per-character basis.
--		005	Corrected the fix introduced in version 003 putting the LibDataBroker icon back in place.
--			Corrected a problem where the quest log tooltip would have an error if the questgiver was in a dungeon appearing in the zone.
--			Added the ability for the quest log tooltip to show that the questgiver should be killed (like the map pin tooltip).
--			The problem where map pins would not live update unless the quest log panel was opened has been fixed as long
--				as the Wholly check button appears on the map.
--			Added the ability to show quest breadcrumb information when the Quest Frame opens, showing a tooltip of breadcrumb
--				quests when the mouse enters the "breadcrumb area", and putting TomTom waypoints when clicking in it.
--		006	Added the new quest group "World Events" which has holiday quests in it, requiring Grail 015.
--			Added a tooltip to the Wholly check button on the map that indicates how many quests of each type are in the map.
--			Added a tooltip to the LibDataBroker icon that shows the quest log panel "map" selection and the quest count/type.
--			Added a tooltip to the quest log panel Zone button that shows the quest count/type.
--			Corrected the problem where the quest log panel and map pins were not live updating when quest givers inside dungeons checked.
--			Corrected the problem where an NPC that drops items that starts more than one quest does not display the information properly
--				in its tooltip.
--			Made it so the open World Map can be updated when crossing into a new zone.
--		007	Added the ability to show whether quests in the quest log are completed or failed.
--			Made it so right-clicking an "in log" quest will put in TomTom waypoints for the turn in locations, which requires Grail 016
--				for proper functioning since Grail 015 had a bug.
--			Made the strings for the preferences color quest information like it appears in the UI.
--			Made it so alt-clicking a log in the Wholly quest log selects the NPC that gives the quest or for the case of "in log" quests
--				the one to which the quest is turned in.
--		008	Split out Dungeons into dungeons in different continents, requiring Grail version 017.
--			Corrected a misspelling of the global game tooltip name.
--		009	Added localization for ptBR in anticipation of the Brazilian release.
--			Changed over to using Blizzard-defined strings for as many things as possible.
--			Corrected a problem that was causing the tooltip for creatures that needed to be killed to start a quest not to appear properly.
--			Added a few basic localizations.
--			Made the breadcrumb frame hide by default to attempt to eliminate an edge case.
--			Fixed a problem where button clicking behavior would never be set if the button was first entered while in combat.
--			Made prerequisite information appear as question marks instead of causing a LUA error in case the Grail data is lacking.
--		010	Made it so the color of the breadcrumb quest names match their current status.
--			The click areas to the right and bottom of the quest log window no longer extend past the window.
--			Added menu options for Class quests, Profession quests, Reputation quests, and Daily quests.  The Class and Profession quests will show all the quests in the system except for the class and professions that match the player.  For those, the quests are displayed using the normal filtering rules.  The Reputation quests follow the normal filtering rules except those that fail to be acceptable solely because of reputation will be displayed instead of following the display unobtainable filter.
--			Changed over to using Grail's StatusCode() vice Status(), and making use of more modern bit values, thereby requiring version 20.
--			Removed a few event types that are handled because Grail now does that.  Instead switched to using Grail's new Status notification.
--			The tooltips for quests in the panel show profession and reputation requirements as appropriate.
--			Corrected a problem where the quest panel may not update properly while in combat.
--		011	Made it so the breadcrumb warning will disappear properly when the user dismisses the quest frame.
--			Made it so Grail's support for Monks does not cause headaches when Monks are not available in the game.
--			Made it so Classes that do not have any class quests will not show up in the list.
--			Put in a feature to limit quests shown to those that count towards Loremaster, thereby requiring Grail version 21.
--			When the quest details appear the quest ID is shown in the top right, and it has a tooltip with useful quest information.
--			Changed the behavior of right-clicking a quest in the quest panel to put arrows to the turn in locations for all but prerequisite quests.
--			The tooltip information describing the quest shows failure reasons by changing to red categories that fail, and to orange categories that fail in prerequisite quests.
--			The quest tooltip information now indicates the first quest(s) in the prerequisite quest list as appropriate.
--			The preference to control displaying prerequisite quests in the tooltip has been removed.
--		012	Added the ability for the tooltip to display faction reputation changes that happen when a quest is turned in.
--			Grouped the Dungeons menu items under a single Dungeons menu item.
--			Added menu items for Reputation Changes quests, grouped by reputation.
--			Added menu items for Achievement quests, grouped by continent, requiring Grail 22.
--			Updated the TOC to support Interface 40300.
--			Fixed the map pin icons whose height Blizzard changed with the 4.3 release.
--		013	Fixes a problem where map pins would not appear and the quest ID would not appear in the Blizzard Quest Frame because the events were not set up properly because sometimes Blizzard sends events in a different order than expected.
--			Makes all the Wholly quest panel update calls ensure they are performed out of combat.
--			Updates Portuguese translation thanks to weslleih and htgome.
--			Fixes a problem where quests in the Blizzard log sometimes would not appear purple in the Wholly Quest Log.
--			Fixes a problem where holidays are not detected properly because of timing issues.
--		014	Fixes the problem where the NPC tooltip did not show the exclamation point properly (instead showing a different icon) when the NPC can start a quest.
--			Adds a search ability that allows searching for quests based on their titles.
--			Adds the ability to display player coordinates into a LibDataBroker feed.
--			Updates some localizations.
--			Fixes the problem where the panel would no longer update after a UI reload, requiring Grail 26.
--			Adds some more achievements to the menu that are world event related.
--			Makes it so quests in the Blizzard quest log will be colored purple in preference to other colors (like brown in case the player would no longer qualify getting the quest).
--			Makes it so the indicator for a completed repeatable quest will appear even if the quest is not colored blue.
--		015	Adds the filtered and total quest counts to the tooltip that tells the counts of the types of quests.  For the world map button tooltip the filtered quest count displays in red if the quest markers on the map are hidden.
--			Corrects a problem where lacking LibDataBroker would cause a LUA error associated with the player coordinates.
--			Fixes a cosmetic issue with the icon in the top left of the Wholly quest log panel to show the surrounding edge properly.
--			Changes the world map check box into a button that performs the same function.
--			Changes the classification of "weekly", "monthly" and "yearly" quests so they no longer appear as resettable quests, but as normal ones.
--			Adds a tooltip for the coordinates that shows the map area ID and name.
--		016	*** Requires Grail 28 or later ***
--			Adds the ability to color the achievement menu items based on whether they are complete.
--			Corrects the problem where the tooltip does not show the different names of the NPCs that can drop an item to start a quest.
--			Corrects the problem where alt-clicking a quest would not select the NPC properly if the NPC drops an item to start a quest.
--			Tracks multiple waypoints that are logically added as a group so when one is removed all of them are removed.
--			Updates some Portuguese localizations.
--			Adds the ability to show bugged information about a quest.
--			Adds a preference to consider bugged quests unobtainable.
--			Makes it select the closest waypoint when more than one is added at the same time.
--		017 *** Requires Grail 29 or later ***
--			Updates the preferences to allow more precise control of displayed quest types.
--			Creates the ability to control whether achievement and reputation change information is used.
--			Adds some Russian localization by freega3 but abused by me.
--          Adds basic structural support for the Italian localization.
--			Changes the presentation of prerequisite quest information to have all types unified in one location.
--		018	Adds some missing Italian UI keys.
--			Removes UI keys no longer used.
--			Fixes the icon that appears in the tooltip when an NPC drops an item that starts a quest.
--			Adds the ability to display item quest prerequisites.
--			Changes the priority of quest classification to ensure truly repeatable quests are never green.
--			Adds support for Cooking and Fishing achievements, present in Grail 31.
--			Adds support to display LightHeaded data by shift-left-click a quest in the Wholly quest panel.
--			Adds the ability to display abandoned and accepted quest prerequisites.
--		019	Adds German localization provided by polzi and aryl2mithril.
--			Adds French localization provided by deadse and Noeudtribal.
--			Corrects the problem where the preference to control holiday quests always was not working properly, requiring Grail 32.
--			Updates Russian localization provided by dartraiden.
--			Adds support for Just Another Day in Tol Barad achievements when Grail provides that data (starting in Grail 32).
--			Adds the ability to display all quests from the search menu.
--			Updates Portuguese localization provided by andrewalves.
--			Corrects a rare problem interacting with LDB.
--			Adds the ability to display quest prerequisites filtering through flag quests when Grail provides the functionality.
--		020	*** Requires Grail 33 or later ***
--			Corrects the problem where quests in the log that are no longer obtainable do not appear properly.
--			Adds the ability to show daily quests that are too high for the character as orange.
--			Adds Spanish localization provided by Trisquite.
--			Moves the Daily quests into the Other category.
--			Adds the experimental option to have a wide quest panel.
--		021 *** Requires Grail 34 or later ***
--			Makes it so Mists of Pandaria reputations can be handled.
--			Makes it so starter Pandarens no longer cause LUA errors.
--			Corrects the problem where removing all TomTom waypoints was not clearing them from Wholly's memory.
--			Corrects locations for Wholly informational frames placed on QuestFrame in MoP beta.
--			Updates the tooltip to better indicate when breadcrumb quests are problems for unobtainable quests.
--			Adds the ability to display profession prerequisites (in the prerequisites section vice its own for the few that need it).
--		022	*** Requires Grail 36 or later ***
--			Corrects the problem where NPC tooltips may not be updated until the world map is shown.
--			Changes how map pins are created so no work is done unless the WorldMapFrame is being shown.
--			Adds the ability to show that quests are Scenario or Legendary.
--			Changes the artwork on the right side of the wide panel.
--			Fixes the problem where the search panel was not attaching itself to the Wholly quest panel.
--			Updates some Korean localization provided by next96.
--			Makes it so Legendary quests appear orange while daily quests that are too high level appear dark blue.
--			Adds two new sort techniques, and also a tooltip for the sort button that describes the active sort technique.
--			Adds the ability to show an abbreviated quest count for each map area in the second scroll area of the wide quest panel, with optional live updates.
--			Fixes the problem where the Wholly world map button can appear above other frames.
--			Makes changing the selection in the first scroll view in the wide version of the Wholly quest panel, remove the selection in the second scroll view, thereby allowing the zone button to properly switch to the current zone.
--			Adds a Wholly quest tooltip for each of the quests in the Blizzard quest log.
--			Updates searching in the wide frame to select the newly sought term.
--		023	Updates some Korean localization provided by next96.
--			Updates some German localization provided by DirtyHarryGermany.
--			Updates from French localization provided by akirra83.
--			Adds support to indicate account-wide quests, starting with Grail 037 use.
--		024 *** Requires Grail 38 or later ***
--			Updates some Russian localization provided by dartraiden.
--			Adds support for quests that require skills as prerequisites, requiring Grail 038.
--			Updates some Italian localization provided by meygan.
--		025	*** Requires Grail 39 or later ***
--			Adds support to display quest required friendship levels.
--			Fixes the problem where NPC tooltips would not be updated (from changed addon data) upon reloading the UI.
--			Adds support to display prerequisites using Grail's newly added capabilities for OR within AND.
--			Adds support for quests that require lack of spells or spells ever being cast as prerequisites.
--			Adds a filter for Scenario quests.
--			Delays the creation of the dropdown menu until it is absolutely needed to attempt to minimize the taint in Blizzard's code.
--			Fixes an issue where considering bugged quests unobtainable would not filter as unobtainable properly.
--		026	*** Requires Grail 40 or later ***
--			Adds support for displaying special reputation requirements currently only used in Tillers quests.
--		027	*** Requires Grail 41 or later ***
--			Adds the ability to display requirements for spells that have ever been experienced.
--			Adds the ability to specify amounts above the minimum reputation level as provided in Grail 041 and later.
--			Updates some Traditional Chinese localization provided by machihchung and BNSSNB.
--			Adds the ability to display requirements from groups of quests, both turning in and accepting the quests.
--			Changes spell prerequisite failures to color red vice yellow.
--			Changes preference "Display holiday quests always" to become a "World Events" filter instead, making World Events always shown in their categories.
--			Changes world events titles to be brown (unobtainable) if they are not being celebrated currently.
--			Adds the ability to Ctrl-click any quest in the Wholly quest panel to add waypoints for EVERY quest in the panel.
--			Corrects the incorrect rendering of the wide panel that can happen on some systems.
--			Adds keybindings for toggling display of map pins and quests that need prerequsites, daily quests, repeatable quests, completed, and unobtainable quests.
--			Adds the ability to display maximum reputation requirements that are quest prerequisites.
--			Changes the maximum line count for the tooltip before the second is created, to be able to be overridden by WhollyDatabase.maximumTooltipLines value if it exists.
--			Adds the ability to Ctrl-Shift-click any quest in the Wholly quest panel to toggle whether the quest is ignored.
--			Adds the ability to filter quests that are marked ignored.
--		028	Switches to using Blizzard's IGNORED string instead of maintaining a localized version.
--			Adds basic support for putting pins on the Omega Map addon.
--			Changes the display of the requirement for a quest to ever have been completed to be green if true, and not the actual status of the quest.
--			Updates the TOC to support interface 50100.
--			Replaces the calls to Grail:IsQuestInQuestLog() with the status bit mask use since (1) we know whether the quest is in the log from its status, and (2) the call was causing Grail to use a lot of memory.
--		029	Adds support for Grail's T code prerequisites.
--			Adds Simplified Chinese localization provided by Sunteya.
--		030	Changes to use some newly added API Grail provides, *** requiring Grail 45 or later ***.
--			Updates some Spanish localization provided by Davidinmoral.
--			Updates some French localization provided by Noeudtribal.
--			Reputation values that are not to be exceeded now have "< " placed in front of the value name.
--			Allows the key binding for toggling open/close the Wholly panel to work in combat, though this function will need to be rebound once.
--			Fixes a map pin problem with the addon Mapster Enhanced.
--			Changes the faction prerequisites to color green, red or brown depending on whether the prerequisite is met, can be met with increase in reputation or is not obtainable because reputation is too high.
--			Adds support for Grail's new "Other" map area where oddball quests are located.
--			Adds support for Grail's new NPC location flags of created and mailbox.
--			Updates some Portuguese localization provided by marciobruno.
--			Adds Pet Battle achievements newly provided by Grail.
--		031	Updates some German localization provided by bigx2.
--			Updates some Russian localization provided by dartraiden.
--			Adds ability to display F code prerequisite information.
--		032 Fixes a problem where the Achievements were not working properly unless the UI was reloaded.
--			Adds the ability to display NPCs with prerequisites, *** requiring Grail 47 or later ***.
--			Makes the X code prerequisite display with ![Turned in].
--			Adds the ability to display phase prerequisite information.
--			Adds some Spanish translations based on input by Davidinmoral.
--		033	Adds a hidden default shouldNotRestoreDirectionalArrows that can be present in the WhollyDatabase saved variables to not reinstate directional arrows upon reloading.
--			Adds the ability to show when a quest is obsolete (removed) or pending.
--			Adds support for displaying Q prerequisites and for displaying pet "spells".
--			Changes the technique used to display reputation changes in the tooltip, *** requiring Grail 048 or later ***.
--			Adds support for Grail's new representation of prerequisite information.
--		034 Changes the tooltip code to allow for better displaying of longer entries.
--			Adds some Korean localization provided by next96.
--			Changes the Interface to 50300 to support the 5.3.0 Blizzard release.
--			Adds the ability to control the Grail-When loadable addon to record when quests are turned in.
--			Adds the ability to display when quests are turned in, and if the quest can be done more than once, the count of how many times done.
--			Updates support for Grail's new representation of prerequisite information.
--		035	Updates Chinese localizations by Isjyzjl.
--			Adds the ability to show equipped iLvl prerequisites.
--			Corrects the display problem with OR within AND prerequisites introduced in version 034.
--			Makes opening the preferences work even if Wholly causes the preferences to be opened the first time in a session.
--		036	Updates Russian localizations by dartraiden.
--			Removes the prerequisite population code in favor of API provided by Grail, requiring Grail 054 or later.
--		037	Fixes the problem where tooltips do not appear in non-English clients properly.
--		038	Fixes the problem where tooltips that show the currently equipped iLevel cause a Lua error.
--			Adds a preference to control whether tooltips appear in the Blizzard Quest Log.
--			Corrects the problem introdced by Blizzard in their 5.4.0 release when they decided to call API (IsForbidden()) before checking whether it exists.
--			Makes the attached Lightheaded frame work better with the wide panel mode.
--			Corrects a problem where a variable was leaking into the global namespace causing a prerequisite evaluation failure.
--			Attempts to make processing a little quicker by making local references to many Blizzard functions.
--		039	Fixes the problem where tooltips for map pins were not appearing correctly.
--			Fixes a Lua error with the non-wide Wholly quest panel's drop down menu.
--			Fixes a Lua error when Wholly is used for the first time (or has no saved variables file).
--			Adds a preference to control display of weekly quests.
--			Adds a color for weekly quests.
--			Enables quest colors to be stored in player preferences so users can changed them, albeit manually.
--			Fixes the problem where the keybindings or buttons not on the preference panel would not work the first time without the preference panel being opened.
--		040	Updates Russian localizations by dartraiden.
--			Adds a workaround to supress the panel that appears because of Blizzard's IsDisabledByParentalControls taint issue.
--			Updates Simplified Chinese localizations by dh0000.
--		041	Adds the capability to set the colors for each of the quest types.
--			Changes to use newer way Grail does things.
--		042	Updates Russian localizations by dartraiden.
--			Corrects the search function to use the new Grail quest structures.
--			Makes it so quests that are pending or obsolete do not appear when the option indicates unobtainable quests should not appear.
--			Changed display of profession requirements to only show failure as quest prerequisites now show profession requirements consistently.
--		043	Handles Grail's change in AZ quests to handle pre- and post-063 implementation.
--			Adds the ability to mark quests with arbitrary tags.
--		044 Corrects the Lua error that happens when attempting to tag a quest when no tag exists.
--			Fixes the map icons to look cleaner by Shenj.
--			Updates Russian localizations by vitasikxp.
--		045 Updates various localizations by Nimhfree.
--			Updates to support changes in WoD that Grail supports.  *** Requires Grail 065 or later. ***
--			Adds hidden WhollyDatabase preference ignoreReputationQuests that controls whether the Reputations section of quests appears in the Wholly panel.
--			Adds hidden WhollyDatabase preference displaysEmptyZones that controls whether map zones where no quests start are displayed.
--			Changes the Interface to 60000.
--		046	Regenerates installation package.
--		047	Updates Traditional Chinese localizations by machihchung.
--			Updates Portuguese localizations by DMoRiaM.
--			Updates French localizations by Dabeuliou;
--			Changes level for pins to display over Blizzard POIs.
--			Changes level for pins so yellow/grey pins display over other colors.
--			Changes default behavior to only show in tooltips faction changes available to the player, with hidden WhollyDatabase preference showsAllFactionReputations to override.
--		048	Fixes a problem where Wholly does not load properly when TomTom is not present.
--		049	Adds the ability to display quests that reward followers.
--			Updates some Korean localization provided by next96.
--			Updates some German localization provided by DirtyHarryGermany.
--		050	Adds support for garrison building requirements.
--			Updates Russian localization provided by dartraiden.
--			Updates German localization provided by DirtyHarryGermany.
--			Updates both Chinese localizations provided by FreedomL10n.
--
--	Known Issues
--
--			The quest log quest colors are not updated live (when the panel is open).
--
--	UTF-8 file
--

local format, pairs, tContains, tinsert, tonumber = format, pairs, tContains, tinsert, tonumber
local ipairs, print, strlen, tremove, type = ipairs, print, strlen, tremove, type
local strsplit, strfind, strformat, strsub, strgmatch = strsplit, string.find, string.format, string.sub, string.gmatch
local bitband = bit.band
local tablesort = table.sort
local mathmax, mathmin, sqrt = math.max, math.min, math.sqrt

local CloseDropDownMenus					= CloseDropDownMenus
local CreateFrame							= CreateFrame
local GetAchievementInfo					= GetAchievementInfo
local GetAddOnMetadata						= GetAddOnMetadata
local GetBuildInfo							= GetBuildInfo
local GetCurrentMapAreaID					= GetCurrentMapAreaID
local GetCurrentMapDungeonLevel				= GetCurrentMapDungeonLevel
local GetCursorPosition						= GetCursorPosition
local GetCVarBool							= GetCVarBool
local GetLocale								= GetLocale
local GetPlayerMapPosition					= GetPlayerMapPosition
local GetQuestID							= GetQuestID
local GetRealZoneText						= GetRealZoneText
local GetSpellInfo							= GetSpellInfo
local GetTitleText							= GetTitleText
local InCombatLockdown						= InCombatLockdown
local InterfaceOptions_AddCategory			= InterfaceOptions_AddCategory
local InterfaceOptionsFrame_OpenToCategory	= InterfaceOptionsFrame_OpenToCategory
local IsControlKeyDown						= IsControlKeyDown
local IsShiftKeyDown						= IsShiftKeyDown
local PlaySound								= PlaySound
local SetMapByID							= SetMapByID
local ToggleDropDownMenu					= ToggleDropDownMenu
local UIDropDownMenu_AddButton				= UIDropDownMenu_AddButton
local UIDropDownMenu_CreateInfo				= UIDropDownMenu_CreateInfo
local UIDropDownMenu_GetText				= UIDropDownMenu_GetText
local UIDropDownMenu_Initialize				= UIDropDownMenu_Initialize
local UIDropDownMenu_JustifyText			= UIDropDownMenu_JustifyText
local UIDropDownMenu_SetText				= UIDropDownMenu_SetText
local UIDropDownMenu_SetWidth				= UIDropDownMenu_SetWidth
local UIParentLoadAddOn						= UIParentLoadAddOn
local UnitIsPlayer							= UnitIsPlayer

local GameTooltip = GameTooltip
local UIErrorsFrame = UIErrorsFrame
local UIParent = UIParent
local QuestFrame = QuestFrame
local WorldMapFrame = WorldMapFrame

local GRAIL = nil	-- will be set in ADDON_LOADED

local directoryName, _ = ...
local versionFromToc = GetAddOnMetadata(directoryName, "Version")
local _, _, versionValueFromToc = strfind(versionFromToc, "(%d+)")
local Wholly_File_Version = tonumber(versionValueFromToc)
local requiredGrailVersion = 67

--	Set up the bindings to use the localized name Blizzard supplies.  Note that the Bindings.xml file cannot
--	just contain the TOGGLEQUESTLOG because then the entry for Wholly does not show up.  So, we use a version
--	named WHOLLY_TOGGLEQUESTLOG which maps to the same Global string, which works exactly as we want.
_G["BINDING_NAME_CLICK com_mithrandir_whollyFrameHiddenToggleButton:LeftButton"] = BINDING_NAME_TOGGLEQUESTLOG
--BINDING_NAME_WHOLLY_TOGGLEQUESTLOG = BINDING_NAME_TOGGLEQUESTLOG
BINDING_HEADER_WHOLLY = "Wholly"
BINDING_NAME_WHOLLY_TOGGLEMAPPINS = "Toggle map pins"
BINDING_NAME_WHOLLY_TOGGLESHOWNEEDSPREREQUISITES = "Toggle shows needs prerequisites"
BINDING_NAME_WHOLLY_TOGGLESHOWDAILIES = "Toggle shows dailies"
BINDING_NAME_WHOLLY_TOGGLESHOWWEEKLIES = "Toggle shows weeklies"
BINDING_NAME_WHOLLY_TOGGLESHOWREPEATABLES = "Toggle shows repeatables"
BINDING_NAME_WHOLLY_TOGGLESHOWUNOBTAINABLES = "Toggle shows unobtainables"
BINDING_NAME_WHOLLY_TOGGLESHOWCOMPLETED = "Toggle shows completed"

if nil == Wholly or Wholly.versionNumber < Wholly_File_Version then

	local function trim(s)
		local n = s:find"%S"
		return n and s:match(".*%S", n) or ""
	end

	WhollyDatabase = {}

	Wholly = {

		cachedMapCounts = {},
		cachedPanelQuests = {},		-- quests and their status for map area self.zoneInfo.panel.mapId
		cachedPinQuests = {},		-- quests and their status for map area self.zoneInfo.pins.mapId
		carboniteMapLoaded = false,
		carboniteNxMapOpen = nil,
		checkedGrailVersion = false,	-- used so the actual check can be simpler
		checkedNPCs = {},
		checkingNPCTechniqueNew = true,
		chooseClosestWaypoint = true,
		color = {
			['B'] = "FF996600",	-- brown	[unobtainable]
			['C'] = "FF00FF00",	-- green	[completed]
			['D'] = "FF0099CC",	-- daily	[repeatable]
			['G'] = "FFFFFF00",	-- yellow	[can accept]
			['H'] = "FF0000FF", -- blue		[daily + too high level]
			['I'] = "FFFF00FF",	-- purple	[in log]
			['K'] = "FF66CC66",	-- greenish	[weekly]
			['L'] = "FFFFFFFF",	-- white	[too high level]
			['P'] = "FFFF0000",	-- red		[does not meet prerequisites]
			['R'] = "FF0099CC",	-- daily	[true repeatable - used for question mark in pins]
			['U'] = "FF00FFFF",	-- bogus default[unknown]
			['W'] = "FF666666",	-- grey		[low-level can accept]
			['Y'] = "FFCC6600", -- orange	[legendary]
			},
		colorWells = {},
		configurationScript1 = function(self)
									Wholly:ScrollFrame_Update_WithCombatCheck()
									Wholly.pinsNeedFiltering = true
									Wholly:_UpdatePins()
								end,
		configurationScript2 = function(self)
									Wholly:_UpdatePins()
									if Wholly.tooltip:IsVisible() and Wholly.tooltip:GetOwner() == Wholly.mapFrame then
										Wholly.tooltip:ClearLines()
										Wholly.tooltip:AddLine(Wholly.mapCountLine)
									end
								end,
		configurationScript3 = function(self)
									Wholly:_DisplayMapFrame(self:GetChecked())
								end,
		configurationScript4 = function(self)
									Wholly:UpdateQuestCaches(true)
									Wholly:ScrollFrame_Update_WithCombatCheck()
									Wholly:_UpdatePins(true)
								end,
		configurationScript5 = function(self)
									Wholly:UpdateBreadcrumb(Wholly)
								end,
		configurationScript7 = function(self)
									Wholly:ScrollFrame_Update_WithCombatCheck()
								end,
		configurationScript8 = function(self)
									Wholly:UpdateCoordinateSystem()
								end,
		configurationScript9 = function(self)
									UIParentLoadAddOn("Grail-Achievements")
									Wholly:_InitializeLevelOneData()
								end,
		configurationScript10 = function(self)
									UIParentLoadAddOn("Grail-Reputations")
									Wholly:_InitializeLevelOneData()
								end,
		configurationScript11 = function(self)
									Wholly:ToggleCurrentFrame()
								end,
		configurationScript12 = function(self)
									Wholly:ScrollFrameTwo_Update()
								end,
		configurationScript13 = function(self)
								end,
		configurationScript14 = function(self)
									UIParentLoadAddOn("Grail-When")
								end,
		coordinates = nil,
		currentFrame = nil,
		currentMaximumTooltipLines = 50,
		currentTt = 0,
		debug = true,
		defaultMaximumTooltipLines = 50,
		dropdown = nil,
		dropdownText = nil,
		dungeonTest = {},

		eventDispatch = {
			['PLAYER_REGEN_ENABLED'] = function(self, frame)
				self:ScrollFrame_Update()
				frame:UnregisterEvent("PLAYER_REGEN_ENABLED")
			end,
			--	So in Blizzard's infinite wisdom it turns out that normal quests that just appear with the
			--	quest giver post a QUEST_DETAIL event, unless they are quests like the Candy Bucket quests
			--	which post a QUEST_COMPLETE event (even though they really are not complete until they are
			--	accepted).  And if there are more than one quest then QUEST_GREETING is posted, which also
			--	is posted if one were to decline one of the selected ones to return to the multiple choice
			--	frame again.  Therefore, it seems three events are required to ensure the breadcrumb panel
			--	is properly removed.
			['QUEST_ACCEPTED'] = function(self, frame)
				self:BreadcrumbUpdate(frame)
			end,
			['QUEST_COMPLETE'] = function(self, frame)
				self:BreadcrumbUpdate(frame, true)
			end,
			['QUEST_DETAIL'] = function(self, frame)
				self:BreadcrumbUpdate(frame)
			end,
			['QUEST_GREETING'] = function(self, frame)
				com_mithrandir_whollyQuestInfoFrameText:SetText("")
				com_mithrandir_whollyQuestInfoBuggedFrameText:SetText("")
				com_mithrandir_whollyBreadcrumbFrame:Hide()
			end,
			['QUEST_LOG_UPDATE'] = function(self, frame)	-- this is just here to record the tooltip information after a reload
				frame:UnregisterEvent("QUEST_LOG_UPDATE")

				-- This used to be in ADDON_LOADED but has been moved here because it was reported in 5.2.0
				-- that the Achievements were not appearing properly, and this turned out to be caused by a
				-- change that Blizzard seems to have done to make it so GetAchievementInfo() no longer has
				-- a proper title in its return values at that point.
				if WhollyDatabase.loadAchievementData then
					self.configurationScript9()
				end

				self:_RecordTooltipNPCs(GetCurrentMapAreaID())
			end,
			['QUEST_PROGRESS'] = function(self, frame)
				self:BreadcrumbUpdate(frame, true)
			end,
			['ADDON_LOADED'] = function(self, frame, arg1)
				if "Wholly" == arg1 then
					local WDB = WhollyDatabase
					local Grail = Grail
					local TomTom = TomTom

					if nil == WDB.defaultsLoaded then
						WDB = self:_LoadDefaults()
					end
					if nil == WDB.currentSortingMode then
						WDB.currentSortingMode = 1
					end
					if nil == WDB.closedHeaders then
						WDB.closedHeaders = {}
					end
					if nil == WDB.ignoredQuests then
						WDB.ignoredQuests = {}
					end

					-- Setup the colors, only setting those that do not already exist
					WDB.color = WDB.color or {}
					for code, colorCode in pairs(self.color) do
						WDB.color[code] = WDB.color[code] or colorCode
					end

					self:ConfigFrame_OnLoad(com_mithrandir_whollyConfigFrame)

					-- Now to be nicer to those that have used the addon before the current
					-- incarnation, newly added defaults will have their normal setting set
					-- as appropriate.
					if nil == WDB.version then		-- first loaded prior to version 006, so default options added in 006
						WDB.displaysHolidaysAlways = true		-- version 006
						WDB.updatesWorldMapOnZoneChange = true	-- version 006
						WDB.version = 6							-- just to make sure none of the other checks fails
					end
					if WDB.version < 7 then
						WDB.showsInLogQuestStatus = true			-- version 007
					end
					if WDB.version < 16 then
						WDB.showsAchievementCompletionColors = true	-- version 016
					end
					if WDB.version < 17 then
						-- transform old values into new ones as appropriate
						if WDB.showsDailyQuests then
							WDB.showsRepeatableQuests = true
						end
						WDB.loadAchievementData = true
						WDB.loadReputationData = true
					end
					if WDB.version < 27 then
						WDB.showsHolidayQuests = true
					end
					if WDB.version < 34 then
						WDB.loadDateData = true
					end
					if WDB.version < 38 then
						WDB.displaysBlizzardQuestTooltips = true
					end
					if WDB.version < 39 then
						WDB.showsWeeklyQuests = true
					end
					WDB.version = Wholly.versionNumber

					if WDB.maximumTooltipLines then
						self.currentMaximumTooltipLines = WDB.maximumTooltipLines
					else
						self.currentMaximumTooltipLines = self.defaultMaximumTooltipLines
					end

					self:_DisplayMapFrame(WDB.displaysMapFrame)
					Grail:RegisterObserver("Status", self._CallbackHandler)
					Grail:RegisterObserverQuestAbandon(self._CallbackHandler)
					Grail:RegisterObserver("WORLD_MAP_UPDATE", self._WorldMapUpdateHandler)

					-- Find out which "map area" is for the player's class
					for key, value in pairs(Grail.classMapping) do
						if Grail.playerClass == value then
							self.playerClassMap = Grail.classToMapAreaMapping['C'..key]
						end
					end

					self:UpdateCoordinateSystem()	-- installs OnUpdate script appropriately

					frame:RegisterEvent("PLAYER_ENTERING_WORLD")
					frame:RegisterEvent("QUEST_ACCEPTED")
					frame:RegisterEvent("QUEST_COMPLETE")			-- to clear the breadcrumb frame
					frame:RegisterEvent("QUEST_GREETING")			-- to clear the breadcrumb frame
					frame:RegisterEvent("QUEST_LOG_UPDATE")			-- just to be able update tooltips after reload UI
					frame:RegisterEvent("QUEST_PROGRESS")
					frame:RegisterEvent("WORLD_MAP_UPDATE")			-- this is for pins
					frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")	-- this is for the panel
					self:UpdateBreadcrumb()							-- sets up registration of events for breadcrumbs based on user preferences
					if not WDB.shouldNotRestoreDirectionalArrows then
						self:_ReinstateDirectionalArrows()
					end

					if WDB.loadReputationData then
						self.configurationScript10()
					end

					if WDB.loadDateData then
						self.configurationScript14()
					end

					-- We steal the TomTom:RemoveWaypoint() function because we want to override it ourselves
					if TomTom and TomTom.RemoveWaypoint then
						self.removeWaypointFunction = TomTom.RemoveWaypoint
						TomTom.RemoveWaypoint = function(self, uid)
							Wholly:_RemoveDirectionalArrows(uid)
							Wholly.removeWaypointFunction(TomTom, uid)
						end
					end
					if TomTom and TomTom.ClearAllWaypoints then
						self.clearAllWaypointsFunction = TomTom.ClearAllWaypoints
						TomTom.ClearAllWaypoints = function(self)
							Wholly:_RemoveAllDirectionalArrows()
							Wholly.clearAllWaypointsFunction(TomTom)
						end
					end
					-- We steal Carbonite's Nx.TTRemoveWaypoint() function because we need it to clear our waypoints
					if Nx and Nx.TTRemoveWaypoint then
						self.carboniteRemoveWaypointFunction = Nx.TTRemoveWaypoint
						Nx.TTRemoveWaypoint = function(self, uid)
							Wholly:_RemoveDirectionalArrows(uid)
							Wholly.carboniteRemoveWaypointFunction(Nx, uid)
						end
					end

					self.easyMenuFrame = CreateFrame("Frame", "com_mithrandir_whollyEasyMenu", self.currentFrame, "UIDropDownMenuTemplate")
					self.easyMenuFrame:Hide()
					StaticPopupDialogs["com_mithrandir_whollyTagDelete"] = {
						text = CONFIRM_COMPACT_UNIT_FRAME_PROFILE_DELETION,
						button1 = ACCEPT,
						button2 = CANCEL,
						OnAccept = function(self, tagName)
							WhollyDatabase.tags[tagName] = nil
							Wholly:ScrollFrameTwo_Update()
							end,
						timeout = 0,
						whileDead = true,
						hideOnEscape = true,
						preferredIndex = 3,
						}

					self:_InitializeLevelOneData()
					if WDB.useWidePanel then self:ToggleCurrentFrame() end

					--	Set up Carbonite support
					if Nx and Nx.Map then
						self.carboniteNxMapOpen = Nx.Map.Open
						Nx.Map.Open = function()
							self.carboniteNxMapOpen(Nx.Map)
							-- this is done this way because NxMap1 does not exist until Nx.Map.Open is called
							tinsert(self.supportedControlMaps, NxMap1)
							tinsert(self.supportedMaps, NxMap1)
							tinsert(self.supportedPOIMaps, NxMap1)
							self.carboniteMapLoaded = true
							end
					end

				end
			end,
			['WORLD_MAP_UPDATE'] = function(self, frame)
				Grail:_CoalesceDelayedNotification("WORLD_MAP_UPDATE", 0.1)
			end,
			['PLAYER_ENTERING_WORLD'] = function(self, frame)
				self.zoneInfo.map.mapId = GetCurrentMapAreaID()
				self.zoneInfo.map.dungeonLevel = GetCurrentMapDungeonLevel()
				self.zoneInfo.zone.mapId = self.zoneInfo.map.mapId
				self.zoneInfo.zone.dungeonLevel = self.zoneInfo.map.dungeonLevel
			end,
			['ZONE_CHANGED_NEW_AREA'] = function(self, frame)
				local mapWeSupportIsVisible = false
				local WDB = WhollyDatabase
				local Grail = Grail

				--	Blizzard sends out WORLD_MAP_UPDATE before it sends out ZONE_CHANGED_NEW_AREA
				--	and we really do not want both as we do our work here.  So, we remove our own
				--	delayed processing of WORLD_MAP_UPDATE in this case.  Normal ones we want our
				--	code to process, which are ones from the user clicking the map UI elements.
				Grail:_RemoveDelayedNotification("WORLD_MAP_UPDATE")

				--	Detect if any of the maps on which Wholly can put pins is currently visible because
				--	if none are, we do not need to worry about switching maps back.
				for _, mapFrame in pairs(self.supportedControlMaps) do
					if mapFrame and mapFrame:IsVisible() then
						mapWeSupportIsVisible = true
						break
					end
				end

				--	Blizzard default behavior is to leave the map alone if it is open, otherwise it will set
				--	the map to the new zone.  Wholly offers the ability to set the open map to the new zone
				--	based on a preference value.  Wholly is going to force the map to the new zone no matter
				--	what, and then reset it to the previous zone if the user does not want Wholly to change
				--	the open map.
				SetMapToCurrentZone()
				self.zoneInfo.zone.mapId = GetCurrentMapAreaID()
				self.zoneInfo.zone.dungeonLevel = GetCurrentMapDungeonLevel()

				if not WDB.updatesWorldMapOnZoneChange and mapWeSupportIsVisible then
					SetMapByID(self.zoneInfo.map.mapId)
					if 0 ~= self.zoneInfo.map.dungeonLevel then
						SetDungeonMapLevel(self.zoneInfo.map.dungeonLevel)
					end
				end
				self:UpdateQuestCaches(false, false, WDB.updatesPanelWhenZoneChanges, true)

				if self.checkingNPCTechniqueNew then
					--	When first entering a zone for the first time the NPCs need to be studied to see whether their
					--	tooltips need to be modified with quest information.
					local newMapId = self.zoneInfo.zone.mapId
					if not self.checkedNPCs[newMapId] then
						self:_RecordTooltipNPCs(newMapId)
					end
				end

				-- Now update open tooltips showing our quest count data
				if GameTooltip:IsVisible() then
					if GameTooltip:GetOwner() == com_mithrandir_whollyFrameSwitchZoneButton then
						GameTooltip:ClearLines()
						GameTooltip:AddLine(Wholly.panelCountLine)
					elseif GameTooltip:GetOwner() == self.ldbTooltipOwner then -- LibDataBroker tooltip
						GameTooltip:ClearLines()
						GameTooltip:AddLine("Wholly - " .. Wholly:_Dropdown_GetText() )
						GameTooltip:AddLine(Wholly.panelCountLine)
					elseif GameTooltip:GetOwner() == self.ldbCoordinatesTooltipOwner then -- LibDataBroker coordinates tooltip
						GameTooltip:ClearLines()
						local dungeonLevel = Wholly.zoneInfo.zone.dungeonLevel
						local dungeonIndicator = (dungeonLevel > 0) and "["..dungeonLevel.."]" or ""
						local mapAreaId = Wholly.zoneInfo.zone.mapId
						local mapAreaName = Grail:MapAreaName(mapAreaId) or "UNKNOWN"
						GameTooltip:AddLine(strformat("%d%s %s", mapAreaId, dungeonIndicator, mapAreaName))
					end
				elseif self.tooltip:IsVisible() then
					if self.tooltip:GetOwner() == self.mapFrame then
						self.tooltip:ClearLines()
						self.tooltip:AddLine(Wholly.mapCountLine)
					end
				end
			end,
			},
		filteredPanelQuests = {},	-- filtered table from cachedPanelQuests using current panel filters
		filteredPinQuests = {},		-- filtered table from cachedPinQuests using current pin filters
		initialUpdateProcessed = false,
		lastWhich = nil,
		lastPrerequisiteQuest = nil,
		lastUpdate = 0,
		ldbCoordinatesTooltipOwner = nil,
		ldbTooltipOwner = nil,
		levelOneCurrent = nil,
		levelOneData = nil,
		levelTwoCurrent = nil,
		levelTwoData = nil,
		mapFrame = nil,			-- the world map frame that contains the checkbox to toggle pins
		maximumSearchHistory = 10,
		npcs = {},
		onlyAddingTooltipToGameTooltip = false,
		pairedConfigurationButton = nil,-- configuration panel button that does the same thing as the world map button
		pairedCoordinatesButton = nil,	-- configuration panel button that does the same thing as the LDB coordinate button
		panelCountLine = "",
		pinsDisplayedLast = nil,
		pinsNeedFiltering = false,
		playerAliveReceived = false,
		playerClassMap = nil,
		preferenceButtons = {},			-- when each of the preference buttons gets created we put them in here to be able to access them if we want
		previousX = 0,
		previousY = 0,
		receivedCalendarUpdateEventList = false,
		pins = {},				-- the pins are contained in a structure that follows, where the first key is the parent frame of the pins contained
		--		pins = {
		--				[WorldMapDetailFrame] = {
		--										[npcs] = {},	-- each key is the NPC id, and the value is the actual pin
		--										[ids] = {},		-- each key is the id : NPC id, and the value is the actual pin
		--										},
		--				}
		removeWaypointFunction = nil,
		s = {
			-- Start of actual strings that need localization.
			['KILL_TO_START_FORMAT'] = "Kill to start [%s]",
			['DROP_TO_START_FORMAT'] = "Drops %s to start [%s]",
			['REQUIRES_FORMAT'] = "Wholly requires Grail version %s or later",
			['MUST_KILL_PIN_FORMAT'] = "%s [Kill]",
			['ESCORT'] = "Escort",
			['BREADCRUMB'] = "Breadcrumb quests:",
			['IS_BREADCRUMB'] = "Is breadcrumb quest for:",
			['PREREQUISITES'] = "Prerequisites:",
			['OTHER'] = "Other",
			['SINGLE_BREADCRUMB_FORMAT'] = "Breadcrumb quest available",
			['MULTIPLE_BREADCRUMB_FORMAT'] = "%d Breadcrumb quests available",
			['WORLD_EVENTS'] = "World Events",
			['REPUTATION_REQUIRED'] = "Reputation Required",
			['REPEATABLE'] = "Repeatable",
			['YEARLY'] = "Yearly",
			['GRAIL_NOT_HAVE'] = "|cFFFF0000Grail does not have this quest|r",
			['QUEST_ID'] = "Quest ID: ",
			['REQUIRED_LEVEL'] = "Required Level",
			['MAXIMUM_LEVEL_NONE'] = "None",
			['QUEST_TYPE_NORMAL'] = "Normal",
			['MAPAREA_NONE'] = "None",
			['LOREMASTER_AREA'] = "Loremaster Area",
			['FACTION_BOTH'] = "Both",
			['CLASS_NONE'] = "None",
			['CLASS_ANY'] = "Any",
			['GENDER_NONE'] = "None",
			['GENDER_BOTH'] = "Both",
			['GENDER'] = "Gender",
			['RACE_NONE'] = "None",
			['RACE_ANY'] = "Any",
			['HOLIDAYS_ONLY'] = "Available only during Holidays:",
			['SP_MESSAGE'] = "Special quest never enters Blizzard quest log",
			['INVALIDATE'] = "Invalidated by Quests:",
			['OAC'] = "On acceptance complete quests:",
			['OCC'] = "On completion of requirements complete quests:",
			['OTC'] = "On turn in complete quests:",
			['ENTER_ZONE'] = "Accepted when entering map area",
			['WHEN_KILL'] = "Accepted when killing:",
			['SEARCH_NEW'] = "New",
			['SEARCH_CLEAR'] = "Clear",
			['SEARCH_ALL_QUESTS'] = "All quests",
			['NEAR'] = "Near",
			['FIRST_PREREQUISITE'] = "First in Prerequisite Chain:",
			['BUGGED'] = "|cffff0000*** BUGGED ***|r",
			['IN_LOG'] = "In Log",
			['TURNED_IN'] = "Turned in",
			['EVER_COMPLETED'] = "Has ever been completed",
			['ITEM'] = "Item",
			['ITEM_LACK'] = "Item lack",
			['ABANDONED'] = "Abandoned",
			['NEVER_ABANDONED'] = "Never Abandoned",
			['ACCEPTED'] = "Accepted",
			['LEGENDARY'] = "Legendary",
			['ACCOUNT'] = "Account",
			['EVER_CAST'] = "Has ever cast",
			['EVER_EXPERIENCED'] = "Has ever experienced",
			['TAGS'] = "Tags",
			['TAGS_NEW'] = "New Tag",
			['TAGS_DELETE'] = "Delete Tag",
			['MAP'] = "Map",
			['PLOT'] = "Plot",
			['BUILDING'] = "Building",

			['BASE_QUESTS'] = "Base Quests",
			['COMPLETED'] = "Completed",
			['NEEDS_PREREQUISITES'] = "Needs prerequisites",
			['UNOBTAINABLE'] = "Unobtainable",
			['LOW_LEVEL'] = "Low-level",
			['HIGH_LEVEL'] = "High level",
			['TITLE_APPEARANCE'] = "Quest Title Appearance",
			['PREPEND_LEVEL'] = "Prepend quest level",
			['APPEND_LEVEL'] = "Append required level",
			['REPEATABLE_COMPLETED'] = "Show whether repeatable quests previously completed",
			['IN_LOG_STATUS'] = "Show status of quests in log",
			['MAP_PINS'] = "Display map pins for quest givers",
			['MAP_BUTTON'] = "Display button on world map",
			['MAP_DUNGEONS'] = "Display dungeon quests in outer map",
			['MAP_UPDATES'] = "Open world map updates when zones change",
			['OTHER_PREFERENCE'] = "Other",
			['PANEL_UPDATES'] = "Quest log panel updates when zones change",
			['SHOW_BREADCRUMB'] = "Display breadcrumb quest information on Quest Frame",
			['SHOW_LOREMASTER'] = "Show only Loremaster quests",
			['ENABLE_COORDINATES'] = "Enable player coordinates",
			['ACHIEVEMENT_COLORS'] = "Show achievement completion colors",
			['BUGGED_UNOBTAINABLE'] = "Bugged quests considered unobtainable",
			['BLIZZARD_TOOLTIP'] = "Tooltips appear on Blizzard Quest Log",
			['WIDE_PANEL'] = "Wide Wholly Quest Panel",
			['WIDE_SHOW'] = "Show",
			['QUEST_COUNTS'] = "Show quest counts",
			['LIVE_COUNTS'] = "Live quest count updates",
			['LOAD_DATA'] = "Load Data",
			['COMPLETION_DATES'] = "Completion Dates",
			},
		supportedControlMaps = { WorldMapFrame, OmegaMapFrame, },	-- the frame to check for visibility
		supportedMaps = { WorldMapDetailFrame, OmegaMapDetailFrame, },	-- the frame that is the parent of the pins
		supportedPOIMaps = { WorldMapPOIFrame, OmegaMapPOIFrame, },	-- the frame to use to set pin level, index from supportedMaps used to determine which to use
		tooltip = nil,
		updateDelay = 0.5,
		updateThreshold = 0.1,
		versionNumber = Wholly_File_Version,
		waypoints = {},
		zoneInfo = {
			["map"] = { ["mapId"] = 0, ["dungeonLevel"] = 0, },	-- this is what the world map is set to
			["panel"] = { ["mapId"] = 0, ["dungeonLevel"] = 0, },	-- this is what the Wholly panel is displaying
			["pins"] = { ["mapId"] = 0, ["dungeonLevel"] = 0, },	-- this is where the pins were last showing
			["zone"] = { ["mapId"] = 0, ["dungeonLevel"] = 0, },	-- this is where the player is
			},

		_AchievementName = function(self, mapID)
			local colorStart, colorEnd = "", ""
			local Grail = Grail
			local baseName = Grail:MapAreaName(mapID) or "UNKONWN"
			if WhollyDatabase.showsAchievementCompletionColors then
				local completed = Grail:AchievementComplete(mapID - Grail.mapAreaBaseAchievement)
				colorStart = completed and "|cff00ff00" or "|cffffff00"
				colorEnd = "|r"
			end
			return colorStart .. baseName .. colorEnd, baseName
		end,

		_AddDirectionalArrows = function(self, questTable, npcType, groupNumberToUse)
			local TomTom = TomTom
			if not TomTom or not TomTom.AddMFWaypoint then return end
			if nil == questTable or nil == npcType then return end
			local locations
			local WDB = WhollyDatabase
			local Grail = Grail

			if not groupNumberToUse then
				WDB.lastGrouping = WDB.lastGrouping or 0	-- initialize if needed
				WDB.lastGrouping = WDB.lastGrouping + 1
				WDB.waypointGrouping = WDB.waypointGrouping or {}
				WDB.waypointGrouping[WDB.lastGrouping] = {}
			end
			for _, questId in pairs(questTable) do
				if 'T' == npcType then
					locations = Grail:QuestLocationsTurnin(questId)
				else
					locations = Grail:QuestLocationsAccept(questId)
				end
				if nil ~= locations then
					local indexValue = questId .. npcType
					local t = {}
					for _, npc in pairs(locations) do
						if nil ~= npc.x then
							local npcName = self:_PrettyNPCString(npc.name, npc.kill, npc.realArea)
							local uid = TomTom:AddMFWaypoint(npc.mapArea, npc.mapLevel, npc.x/100, npc.y/100,
									{	persistent = false,
										title = npcName .. " - " .. self:_QuestName(questId),
									})
							tinsert(t, uid)
						end
					end
					if 0 < #t then
						local actualGroup = groupNumberToUse or WDB.lastGrouping
						self.waypoints[indexValue] = { grouping = actualGroup, uids = t }
						if not groupNumberToUse then
							tinsert(WDB.waypointGrouping[WDB.lastGrouping], indexValue)
						end
						if self.chooseClosestWaypoint and TomTom.SetClosestWaypoint and 1 < #t then
							TomTom:SetClosestWaypoint()
						end
					end
				end
			end
			if not groupNumberToUse and 0 == #(WDB.waypointGrouping[WDB.lastGrouping]) then
				WDB.waypointGrouping[WDB.lastGrouping] = nil
				WDB.lastGrouping = WDB.lastGrouping - 1
			end
		end,

		--	This adds a line to the "current" tooltip, creating a new one as needed.
		_AddLine = function(self, value, value2)
			if not self.onlyAddingTooltipToGameTooltip then
				local tt = self.tt[self.currentTt]
				if tt:NumLines() >= self.currentMaximumTooltipLines then
					local previousTt = tt
					self.currentTt = self.currentTt + 1
					tt = self.tt[self.currentTt]
					if nil == tt then
						tt = CreateFrame("GameTooltip", "com_mithrandir_WhollyOtherTooltip"..self.currentTt, GameTooltip, "GameTooltipTemplate")
						self.tt[self.currentTt] = tt
					end
					tt:SetOwner(previousTt, "ANCHOR_RIGHT")
					tt:ClearLines()
				end
				if nil ~= value2 then
					tt:AddDoubleLine(value, value2)
				else
					tt:AddLine(value)
				end
			else
				if nil ~= value2 then
					GameTooltip:AddDoubleLine(value, value2)
				else
					GameTooltip:AddLine(value)
				end
			end
		end,

		BreadcrumbClick = function(self, frame)
			local Grail = Grail
			local questId = self:_BreadcrumbQuestId()
			self:_AddDirectionalArrows(Grail:AvailableBreadcrumbs(questId), 'A')
		end,

		BreadcrumbEnter = function(self, frame)
			local Grail = Grail
			GameTooltip:SetOwner(frame, "ANCHOR_RIGHT")
			GameTooltip:ClearLines()
			local questId = self:_BreadcrumbQuestId()
			local breadcrumbs = Grail:AvailableBreadcrumbs(questId)
			if nil ~= breadcrumbs then
				GameTooltip:AddLine(self.s.BREADCRUMB)
				for i = 1, #breadcrumbs do
					GameTooltip:AddLine(self:_PrettyQuestString({ breadcrumbs[i], Grail:ClassificationOfQuestCode(breadcrumbs[i], nil, WhollyDatabase.buggedQuestsConsideredUnobtainable) }))
				end
				GameTooltip:Show()
			end
		end,

		_BreadcrumbQuestId = function(self)
			local questId = GetQuestID()
			local questName = GetTitleText()
			local Grail = Grail

			-- Check the make sure the questId we are attempting to use makes sense with the title, otherwise
			-- the questId is incorrect and we need to try to get it
			if questName ~= self:_QuestName(questId) then
				questId = Grail:QuestIdFromNPCOrName(questName, nil, true)
			end
			return questId
		end,

		BreadcrumbUpdate = function(self, frame, shouldHide)
			local questId = self:_BreadcrumbQuestId()
			com_mithrandir_whollyQuestInfoFrameText:SetText(questId)
			self:UpdateBuggedText(questId)
			if shouldHide then
				com_mithrandir_whollyBreadcrumbFrame:Hide()
			else
				self:ShowBreadcrumbInfo()
			end
		end,

		ButtonEnter = function(self, button, ...)
			local Grail = Grail
			local aliasQuestId = Grail:AliasQuestId(button.questId)
			local questIdToUse = aliasQuestId or button.questId
			self:_PopulateTooltipForQuest(button, questIdToUse, (questIdToUse ~= button.questId) and button.questId or nil)

			if not button.secureProcessed and not InCombatLockdown() then
				button:SetAttribute("type1", "click")
				button:SetAttribute("clickbutton", Wholly)
				button:SetAttribute("type2", "click")
				button:SetAttribute("shift-type1", "click")
				button:SetAttribute("ctrl-type1", "click")
				button:SetAttribute("ctrl-shift-type1", "click")
				button:SetAttribute("shift-type2", "click")
				button:SetAttribute("alt-type1", "macro")
				button.secureProcessed = true
			else
				-- TODO: Should attempt a delayed setting of this if not button.secureProcessed and InCombatLockdown()
			end

			if 'P' == button.statusCode then
				local controlTable = { ["result"] = {}, ["preq"] = nil, ["lastIndexUsed"] = 0, ["doMath"] = true }
				local lastIndexUsed = Grail._PreparePrerequisiteInfo(Grail:QuestPrerequisites(button.questId, true), controlTable)
				self.lastPrerequisites = controlTable.result
--				local lastIndexUsed = Grail:_PreparePrerequisiteInfo(Grail:QuestPrerequisites(button.questId, true), self.lastPrerequisites, nil, 0, true)
				local outputString
				local started = false
				local tempTable = {}
				for questId, value in pairs(self.lastPrerequisites) do
					tinsert(tempTable, questId)
					outputString = ""
					if not started then
						self:_AddLine(" ")
						self:_AddLine(self.s.FIRST_PREREQUISITE)
						started = true
					end
					for key, value2 in pairs(value) do
						if "" == outputString then
							outputString = "("..value2
						else
							outputString = outputString..","..value2
						end
					end
					outputString = outputString..") "
					self:_AddLine(outputString..self:_PrettyQuestString({ questId, Grail:ClassificationOfQuestCode(questId, nil, WhollyDatabase.buggedQuestsConsideredUnobtainable) }), questId)
				end
				self.lastPrerequisites = started and tempTable or nil
			else
				self.lastPrerequisites = nil
			end

			for i = 1, self.currentTt do
				self.tt[i]:Show()
			end
		end,

		ButtonPostClick = function(self, button)
			if button ~= self.clickingButton then print("Post click not from the same Pre click") end
			self.clickingButton = nil
		end,

		ButtonPreClick = function(self, button)
			self.clickingButton = button
		end,

		_WorldMapUpdateHandler = function(type, questId)
			Wholly.zoneInfo.map.mapId = GetCurrentMapAreaID()
			Wholly.zoneInfo.map.dungeonLevel = GetCurrentMapDungeonLevel()
			Wholly:_UpdatePins()
		end,

		_CallbackHandler = function(type, questId)
			local WDB = WhollyDatabase

			Wholly:UpdateQuestCaches(true)
			Wholly:_UpdatePins(true)
			if WDB.showQuestCounts and WDB.liveQuestCountUpdates then
				for mapId, ignoredCurrentString in pairs(Wholly.cachedMapCounts) do
					local questsInMap = Wholly:_ClassifyQuestsInMap(mapId) or {}
					Wholly.cachedMapCounts[mapId] = Wholly:_PrettyQuestCountString(questsInMap, nil, nil, true)
				end
				Wholly:ScrollFrameTwo_Update()
			end
		end,

		_CheckNPCTooltip = function(tooltip)
			if (not UnitIsPlayer("mouseover") or true) then
				-- check if this npc drops a quest item
				local id = Grail:GetNPCId(false, true)	-- only "mouseover" will be used
				local qs = id and Wholly.npcs[id] or nil
				if nil ~= qs then
					for _, questId in pairs(qs) do
						if Grail:CanAcceptQuest(questId) then
							local _, kindsOfNPC = Grail:IsTooltipNPC(id)
							if nil ~= kindsOfNPC then
								for i = 1, #(kindsOfNPC), 1 do
									local tooltipMessage = nil
									if kindsOfNPC[i][1] == Grail.NPC_TYPE_KILL then
										tooltipMessage = format(Wholly.s.KILL_TO_START_FORMAT, Wholly:_QuestName(questId))
									elseif kindsOfNPC[i][1] == Grail.NPC_TYPE_DROP then
										if Wholly:_DroppedItemMatchesQuest(kindsOfNPC[i][2], questId) then
											tooltipMessage = format(Wholly.s.DROP_TO_START_FORMAT, Grail:NPCName(kindsOfNPC[i][2]), Wholly:_QuestName(questId))
										end
									end
									if nil ~= tooltipMessage then
										local leftStr = format("|TInterface\\MINIMAP\\ObjectIcons:0:0:0:0:128:128:16:32:16:32|t %s", tooltipMessage)
										tooltip:AddLine(leftStr);
									end
								end
							end
							tooltip:Show();
						end
					end
				end
			end
		end,

		---
		--	Gets all the quests in the map area, then classifies them based on the current player.
		_ClassifyQuestsInMap = function(self, mapId)
			local retval = nil
			if nil ~= mapId and tonumber(mapId) then
				mapId = tonumber(mapId)
				local displaysHolidayQuestsAlways = false
				local WDB = WhollyDatabase
				local showsLoremasterOnly = WDB.showsLoremasterOnly
				if mapId >= Grail.mapAreaBaseHoliday and mapId <= Grail.mapAreaMaximumHoliday then displaysHolidayQuestsAlways = true end
				retval = {}
				local questsInMap = Grail:QuestsInMap(mapId, WDB.displaysDungeonQuests, showsLoremasterOnly) or {}
				for _,questId in pairs(questsInMap) do
					tinsert(retval, { questId, Grail:ClassificationOfQuestCode(questId, displaysHolidayQuestsAlways, WDB.buggedQuestsConsideredUnobtainable) })
				end
			end
			return retval
		end,

		--	Shift right-click	:	Tag quest
		--	Shift control-click	:	Ignore quest
		--	Shift left-click	:	Toggle LightHeaded (does nothing if LightHeaded not installed)
		--	Control click		:	Directional arrows for all quests in "map area"
		--	Right-click			:	Directional arrows for questgivers for first in prerequisites, or directional arrows to turn-in NPCs if no prerequisites
		--	Left-click			:	Directional arrows for questgivers
		-- This is named this way with this function signature because it is called from the SecureActionButtonTemplate exactly like this.
		Click = function(self, leftOrRight)
			local TomTom = TomTom
			if IsShiftKeyDown() and "RightButton" == leftOrRight then
				self:_TagProcess(self.clickingButton.questId)
				return
			end
			if IsShiftKeyDown() and IsControlKeyDown() then
				self:ToggleIgnoredQuest()
				self.configurationScript1()
				return
			end
			if IsShiftKeyDown() then
				if LightHeaded then self:ToggleLightHeaded() end
				return
			end
			if not TomTom or not TomTom.AddMFWaypoint then return end	-- technically _AddDirectionalArrows does this check, but why do the extra work if not needed?
			if IsControlKeyDown() then
				local questsInMap = self.filteredPanelQuests
				local numEntries = #questsInMap
				for i = 1, numEntries do
					self:_AddDirectionalArrows({questsInMap[i][1]}, 'A')
				end
				return
			end
			local button = self.clickingButton
			local questsToUse = {button.questId}
			local npcType = 'A'
			if "RightButton" == leftOrRight then
				if nil ~= self.lastPrerequisites then
					questsToUse = self.lastPrerequisites
				else
					npcType = 'T'
				end
			end
			self:_AddDirectionalArrows(questsToUse, npcType)
		end,

		_ColorCodeFromInfo = function(self, colorCode, r, g, b, a)
			local aString = Grail:_HexValue(a * 255, 2)
			local rString = Grail:_HexValue(r * 255, 2)
			local gString = Grail:_HexValue(g * 255, 2)
			local bString = Grail:_HexValue(b * 255, 2)
			WhollyDatabase.color[colorCode] = aString .. rString .. gString .. bString
		end,

		--	This takes the colorCode value "AARRGGBB" and returns the r, g, b, a as decimals
		_ColorInfoFromCode = function(self, colorCode)
			local colorString = WhollyDatabase.color[colorCode]
			local a = tonumber(strsub(colorString, 1, 2), 16) / 255
			local r = tonumber(strsub(colorString, 3, 4), 16) / 255
			local g = tonumber(strsub(colorString, 5, 6), 16) / 255
			local b = tonumber(strsub(colorString, 7, 8), 16) / 255
			return r, g, b, a
		end,

		--	This will update all the preference text that have associated color codes
		_ColorUpdateAllPreferenceText = function(self)
			for i = 1, #self.configuration do
				if nil ~= self.configuration[i][6] then
					self.colorWells[i].swatch:SetVertexColor(self:_ColorInfoFromCode(self.configuration[i][6]))
					self:_ColorUpdatePreferenceText(i)
				end
			end
		end,

		--	This will set the text for the preference
		_ColorUpdatePreferenceText = function(self, configIndex)
			local button = self.preferenceButtons[self.configuration[configIndex][2]]
			local colorCode
			if nil ~= button then
				local colorStart, colorEnd = "", ""
				colorCode = self.configuration[configIndex][6]
				if nil ~= colorCode then
					colorStart = "|c" .. WhollyDatabase.color[colorCode]
					colorEnd = "|r"
				end
				_G[button:GetName().."Text"]:SetText(colorStart .. self.configuration[configIndex][1] .. colorEnd)
			end
		end,

		--	This creates a color well associated with the colorCode
		_ColorWell = function(self, configIndex, panel)
			local well = CreateFrame("Button", nil, panel)
			well:EnableMouse(true)
			well:SetHeight(16)
			well:SetWidth(16)
			well:SetScript("OnClick", Wholly._ColorWell_OnClick)
			well.configIndex = configIndex
			local swatch = well:CreateTexture(nil, "OVERLAY")
			swatch:SetWidth(16)
			swatch:SetHeight(16)
			swatch:SetTexture("Interface\\ChatFrame\\ChatFrameColorSwatch")
			swatch:SetPoint("LEFT")
			well.swatch = swatch
			return well
		end,

		_ColorWell_Callback = function(self, frame, r, g, b, a, processingAlpha)
			frame.swatch:SetVertexColor(r, g, b, a)
			self:_ColorCodeFromInfo(self.configuration[frame.configIndex][6], r, g, b, a)
			self:_ColorUpdatePreferenceText(frame.configIndex)
		end,

		_ColorWell_OnClick = function(frame)
			HideUIPanel(ColorPickerFrame)
			ColorPickerFrame:SetFrameStrata("FULLSCREEN_DIALOG")
			ColorPickerFrame.func = function()
				local r, g, b = ColorPickerFrame:GetColorRGB()
				local a = 1 - OpacitySliderFrame:GetValue()
				Wholly:_ColorWell_Callback(frame, r, g, b, a)
			end
			ColorPickerFrame.hasOpacity = true
			ColorPickerFrame.opacityFunc = function()
				local r, g, b = ColorPickerFrame:GetColorRGB()
				local a = 1 - OpacitySliderFrame:GetValue()
				Wholly:_ColorWell_Callback(frame, r, g, b, a, true)
			end
			local r, g, b, a = Wholly:_ColorInfoFromCode(Wholly.configuration[frame.configIndex][6])
			ColorPickerFrame.opacity = 1 - a
			ColorPickerFrame:SetColorRGB(r, g, b)
			ColorPickerFrame.cancelFunc = function()
				Wholly:_ColorWell_Callback(frame, r, g, b, a, true)
			end
			ShowUIPanel(ColorPickerFrame)
		end,

		ConfigFrame_OnLoad = function(self, panel)
			panel.name = "Wholly"
			panel:Hide()
			InterfaceOptions_AddCategory(panel)
			local parent = panel:GetName()
			local indentLevel
			local lineLevel = 0
			local button
			local offset
			local wellOffset
			
			if not self.checkedGrailVersion then
				local errorMessage = format(self.s.REQUIRES_FORMAT, requiredGrailVersion)
				button = panel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
				offset = -5
				indentLevel = 0
				lineLevel = lineLevel + 1
				button:SetPoint("TOPLEFT", panel, "TOPLEFT", (indentLevel * 200) + 8, (lineLevel * -20) + 10 + offset)
				button:SetText(errorMessage)
				return 
			end

			for i = 1, #self.configuration do
				if self.configuration[i][2] then
					button = CreateFrame("CheckButton", parent.."Button"..i, panel, "InterfaceOptionsCheckButtonTemplate")
					offset = 0
				else
					button = panel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
					offset = -5
				end
				if self.configuration[i][4] then
					indentLevel = indentLevel + 1
				else
					indentLevel = 0
					lineLevel = lineLevel + 1
				end
				wellOffset = 0
				if self.configuration[i][6] then
					local well = self:_ColorWell(i, panel)
					well.swatch:SetVertexColor(self:_ColorInfoFromCode(self.configuration[i][6]))
					well:ClearAllPoints()
					well:SetPoint("TOPLEFT", panel, "TOPLEFT", (indentLevel * 200) + 6 , (lineLevel * -20) + 18 + offset)
					well:Show()
					self.colorWells[i] = well
				end
				if self.configuration[i][2] then wellOffset = 12 end
				button:SetPoint("TOPLEFT", panel, "TOPLEFT", (indentLevel * 200) + 8 + wellOffset, (lineLevel * -20) + 22 + offset)
				if self.configuration[i][2] then
					button:SetScript("OnClick", function(self)
													WhollyDatabase[Wholly.configuration[i][2]] = self:GetChecked()
													Wholly[Wholly.configuration[i][3]](self)
												end)
					if nil ~= self.configuration[i][5] then
						self[self.configuration[i][5]] = button
					end
					self.preferenceButtons[self.configuration[i][2]] = button
					self:_ColorUpdatePreferenceText(i)
				else
					button:SetText(self.configuration[i][1])
				end
			end
			
			button = panel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
			button:SetPoint("TOPLEFT", panel, "TOPLEFT", 6, -587)
			button:SetText(COLORS .. ':')
			local previousButton = button
			button = CreateFrame("Button", parent .. "ColorReset", panel, "UIPanelButtonTemplate")
			button:SetWidth(150)
			button:SetPoint("TOPLEFT", previousButton, "TOPRIGHT", 8, 5)
			_G[button:GetName().."Text"]:SetText(RESET_TO_DEFAULT)
			button:SetScript("OnClick", function(self) Wholly:_ResetColors() end)

			self:ConfigFrame_OnShow(panel)
		end,

		ConfigFrame_OnShow = function(self, panel)
			if not self.checkedGrailVersion then return end
			local parent = panel:GetName()
			for i = 1, #self.configuration do
				if self.configuration[i][2] then
					_G[parent.."Button"..i]:SetChecked(WhollyDatabase[self.configuration[i][2]])
				end
			end
		end,

		_DisplayMapFrame = function(self, shouldDisplay)
			if shouldDisplay then self.mapFrame:Show() else self.mapFrame:Hide() end
		end,

		_Distance = function(self, parentFrame, x1, y1, x2, y2)
			local distRatio = parentFrame:GetHeight() / parentFrame:GetWidth();
			return sqrt( (x1 - x2)^2 + ((y1 - y2)/distRatio)^2 );
		end,

		_Dropdown_AddButton = function(self, level, hasArrow, item)
			local info = UIDropDownMenu_CreateInfo()
			info.hasArrow = hasArrow
			info.notCheckable = true
			info.text = item.displayName
			info.value = item
			if not hasArrow then
				info.func = item.f		-- default to any menu provided function
				if nil == info.func then
					info.func = function()
						Wholly.zoneInfo.panel.mapId = item.mapID
						Wholly.zoneInfo.panel.dungeonLevel = 0
						Wholly._ForcePanelMapArea(Wholly)
						CloseDropDownMenus()
					end
				end
			end
			UIDropDownMenu_AddButton(info, level)
		end,

		_Dropdown_Create = function(self)
			local f = com_mithrandir_whollyFrame
			self.dropdown = CreateFrame("Button", f:GetName().."ZoneButton", f, "UIDropDownMenuTemplate")
			UIDropDownMenu_Initialize(self.dropdown, self.Dropdown_Initialize) -- took away "MENU" because no show with it
			self.dropdown:SetPoint("TOPLEFT", f, "TOPLEFT", 60, -40)
			UIDropDownMenu_SetWidth(self.dropdown, 240, 0)
			UIDropDownMenu_JustifyText(self.dropdown, "LEFT")
			-- By default, the dropdown has it clicking work with the little button on the right.  This makes it work for the whole button:
			self.dropdown:SetScript("OnClick", function(self) ToggleDropDownMenu(nil, nil, Wholly.dropdown) PlaySound("igMainMenuOptionCheckBoxOn") end)
		end,

		_Dropdown_GetText = function(self)
			if nil ~= self.dropdown then
				self.dropdownText = UIDropDownMenu_GetText(self.dropdown)
			end
			return self.dropdownText
		end,

		Dropdown_Initialize = function(self, level)
			local UIDROPDOWNMENU_MENU_VALUE = UIDROPDOWNMENU_MENU_VALUE
			level = level or 1
			if 1 == level then
				for k, v in pairs(Wholly.levelOneData) do
					Wholly:_Dropdown_AddButton(level, true, v)
				end
			elseif 2 == level then
				local children = UIDROPDOWNMENU_MENU_VALUE["children"]
				if nil ~= children then
					for k, v in pairs(children) do
						Wholly:_Dropdown_AddButton(level, true, v)
					end
				else
					Wholly:_SetLevelOneCurrent(UIDROPDOWNMENU_MENU_VALUE)
					Wholly:_InitializeLevelTwoData()
					for k, v in pairs(Wholly.levelTwoData) do
						Wholly:_Dropdown_AddButton(level, false, v)
					end
				end
			else	-- assumption is level 3 which is the highest we have
				Wholly:_SetLevelOneCurrent(UIDROPDOWNMENU_MENU_VALUE)
				Wholly:_InitializeLevelTwoData()
				for k, v in pairs(Wholly.levelTwoData) do
					Wholly:_Dropdown_AddButton(level, false, v)
				end
			end
		end,

		_Dropdown_SetText = function(self, newTitle)
			self.dropdownText = newTitle
			if nil ~= self.dropdown then
				UIDropDownMenu_SetText(self.dropdown, self.dropdownText)
			end
		end,

		_DroppedItemMatchesQuest = function(self, dropNPCCode, matchingQuestId)
			local retval = true
			local questCodes = Grail:CodesWithPrefixNPC(dropNPCCode, "Q:")
			if nil ~= questCodes then
				retval = false
				for i = 1, #questCodes do
					local quests = { strsplit(",", strsub(questCodes[i], 3)) }
					for j = 1, #quests do
						if tonumber(quests[j]) == tonumber(matchingQuestId) then retval = true end
					end
				end
			end
			return retval
		end,

		_FilterQuests = function(self, forPanel)
			local f = forPanel and self.filteredPanelQuests or self.filteredPinQuests
			f = {}
			local questsInMap = forPanel and self.cachedPanelQuests or self.cachedPinQuests
			local shouldAdd, statusCode, status

			--	We want to be able to force display of quests that are class or profession specific
			--	unless they are associated with the player.  In that case, the display of the quests
			--	obeys the same rules as the quests in a normal map area.
			local shouldForce = false
			local currentMapId = self.zoneInfo.panel.mapId
			if nil ~= currentMapId and currentMapId >= Grail.mapAreaBaseClass and currentMapId <= Grail.mapAreaMaximumProfession then
				shouldForce = true
				if self.playerClassMap == currentMapId then shouldForce = false end
				if currentMapId >= Grail.mapAreaBaseProfession then
					for key,value in pairs(Grail.professionToMapAreaMapping) do
						if value == currentMapId then
							local actualKey = key:sub(2, 2)
							if Grail:ProfessionExceeds(actualKey, 1) then -- indicates the profession is known
								shouldForce = false
							end
						end
					end
				end
			end
			local repuationQuest = false
			if nil ~= currentMapId and currentMapId > Grail.mapAreaBaseReputation and currentMapId <= Grail.mapAreaMaximumReputation then
				reputationQuest = true
			end

			local questId
			local WDB = WhollyDatabase
			local dealingWithHolidays = nil ~= currentMapId and currentMapId >= Grail.mapAreaBaseHoliday and currentMapId <= Grail.mapAreaMaximumHoliday and true or false
			local holidayModification = dealingWithHolidays and (Grail.bitMaskHoliday + Grail.bitMaskAncestorHoliday) or 0
			local buggedModification = WDB.buggedQuestsConsideredUnobtainable and Grail.bitMaskBugged or 0
			for i = 1, #questsInMap do
				statusCode = questsInMap[i][2]

				questId = questsInMap[i][1]
				status = Grail:StatusCode(questId)
				shouldAdd = false
				local questObsoleteOrPending = (Grail:IsQuestObsolete(questId) or Grail:IsQuestPending(questId))

				if Grail:CanAcceptQuest(questId, false, WDB.showsQuestsThatFailPrerequsites, true, true, dealingWithHolidays, WDB.buggedQuestsConsideredUnobtainable) or
					(WDB.showsCompletedQuests and Grail:IsQuestCompleted(questId) and 0 == bitband(status, Grail.bitMaskQuestFailureWithAncestor - (Grail.bitMaskAncestorReputation + Grail.bitMaskReputation) - holidayModification)) or
					0 < bitband(status, Grail.bitMaskInLog) or
					(WDB.showsUnobtainableQuests and (bitband(status, Grail.bitMaskQuestFailureWithAncestor - holidayModification + buggedModification) > 0 or questObsoleteOrPending)) then
					shouldAdd = true
				end

				if Grail:IsRepeatable(questId) and not WDB.showsRepeatableQuests then shouldAdd = false end
				if Grail:IsDaily(questId) and not WDB.showsDailyQuests then shouldAdd = false end
				if 0 < bitband(status, Grail.bitMaskInLog) and not WDB.showsQuestsInLog then shouldAdd = false end
				if Grail:IsLowLevel(questId) and not WDB.showsLowLevelQuests then shouldAdd = false end
				if bitband(status, Grail.bitMaskLevelTooLow) > 0 and not WDB.showsHighLevelQuests then shouldAdd = false end
				if Grail:IsScenario(questId) and not WDB.showsScenarioQuests then shouldAdd = false end
				if Grail:CodeHoliday(questId) ~= 0 and not WDB.showsHolidayQuests and not dealingWithHolidays then shouldAdd = false end
				if self:_IsIgnoredQuest(questId) and not WDB.showsIgnoredQuests then shouldAdd = false end
				if Grail:IsWeekly(questId) and not WDB.showsWeeklyQuests then shouldAdd = false end
				if questObsoleteOrPending and not WDB.showsUnobtainableQuests then shouldAdd = false end

				if not forPanel then
					if 'I' == statusCode or 'C' == statusCode then shouldAdd = false end
					if 'B' == statusCode then shouldAdd = false end
				end

				if shouldAdd then
					tinsert(f, questsInMap[i])
				end
			end
			if forPanel then self.filteredPanelQuests = f else self.filteredPinQuests = f end
			if not forPanel then
				self.mapCountLine = self:_PrettyQuestCountString(questsInMap, #(self.filteredPinQuests), true)
			else
				self.panelCountLine = self:_PrettyQuestCountString(questsInMap, #(self.filteredPanelQuests))
				if currentMapId and 0 ~= currentMapId then
					self.cachedMapCounts[currentMapId] = self:_PrettyQuestCountString(questsInMap, nil, nil, true)
				end
			end
		end,

		_FilterPanelQuests = function(self)
			self:_FilterQuests(true)
		end,

		_FilterPinQuests = function(self)
			self:_FilterQuests(false)
		end,

		_ForcePanelMapArea = function(self, ignoreForcingSelection)
			local currentMapId = self.zoneInfo.panel.mapId
			local mapAreaName = Grail:MapAreaName(currentMapId) or GetRealZoneText()	-- default to something if we do not support the zone
			if nil ~= mapAreaName then self:_Dropdown_SetText(mapAreaName) end
			self.cachedPanelQuests = self:_ClassifyQuestsInMap(currentMapId) or {}
			self:ScrollFrame_Update_WithCombatCheck()

			if not ignoreForcingSelection then
				local soughtIndex = Grail.continentIndexMapping[Grail.mapToContinentMapping[currentMapId]]
				if nil == soughtIndex then		-- assume it is a dungeon
					for mapId, continentTable in pairs(Grail.continents) do
						if tContains(continentTable.dungeons, currentMapId) then
							soughtIndex = 10 + Grail.continentIndexMapping[mapId]
						end
--					for i = 1, #(Grail.continents) do
--						if tContains(Grail.continents[i].dungeons, currentMapId) then
--							soughtIndex = 10 + i
--						end
					end
				end
				if nil == soughtIndex then		-- assume it is "Other"
					if tContains(Grail.otherMapping, currentMapId) then
						soughtIndex = 71
					end
				end
				if nil ~= soughtIndex then
					for i, v in pairs(self.levelOneData) do
						if v.index == soughtIndex then
							self:_SetLevelOneCurrent(v)
						end
					end
				else
					self:_SetLevelOneCurrent(nil)
				end
				self:ScrollFrameOne_Update()
				--	Now we create a bogus entry for the level two data
				self:_SetLevelTwoCurrent({ displayName = mapAreaName, mapID = currentMapId })
				self:ScrollFrameTwo_Update()
			end
		end,

		_GetMousePosition = function(self, parentFrame)
			local left, top = parentFrame:GetLeft(), parentFrame:GetTop();
			local width, height = parentFrame:GetWidth(), parentFrame:GetHeight();
			local scale = parentFrame:GetEffectiveScale();

			local x, y = GetCursorPosition();
			local cx = (x/scale - left) / width;
			local cy = (top - y/scale) / height;
	
			return mathmin(mathmax(cx, 0), 1), mathmin(mathmax(cy, 0), 1);
		end,

		_GetPin = function(self, npcId, parentFrame)
			self:_PinFrameSetup(parentFrame)
			if nil ~= self.pins[parentFrame]["npcs"][npcId] then return self.pins[parentFrame]["npcs"][npcId] end

			local pin = CreateFrame("Frame", nil, parentFrame);
			pin.originalParentFrame = parentFrame
			pin.npcId = npcId
			pin:SetWidth(16);
			pin:SetHeight(16);
			pin:EnableMouse(true);
			pin:SetScript("OnEnter", function(pin) self:ShowTooltip(pin) end)
			pin:SetScript("OnLeave", function() self:_HideTooltip() end)
			pin.SetType = function(self, texType)
				if self.texType == texType then return end -- don't need to make changes
				local colorString = WhollyDatabase.color[texType]
				local r = tonumber(strsub(colorString, 3, 4), 16) / 255
				local g = tonumber(strsub(colorString, 5, 6), 16) / 255
				local b = tonumber(strsub(colorString, 7, 8), 16) / 255

				self.texture = self:CreateTexture()
				-- WoD beta does not allow custom textures so we go back to the old way
				if Grail.blizzardRelease < 18505 or Grail.blizzardRelease >= 18663 then
					if 'R' == texType then
						self.texture:SetTexture("Interface\\Addons\\Wholly\\question")
					else
						self.texture:SetTexture("Interface\\Addons\\Wholly\\exclamation")
					end
					self.texture:SetVertexColor(r, g, b)
				else
					local width, height = 0.125, 0.125
					self.texture:SetTexture("Interface\\MINIMAP\\ObjectIcons.blp")
					self.texture:SetDesaturated(false)
					self.texture:SetVertexColor(1, 1, 1)
					if texType == "D" then
						self.texture:SetTexCoord(3*width, 4*width, 1*height, 2*height);
					elseif texType == "R" then
						self.texture:SetTexCoord(4*width, 5*width, 1*height, 2*height);
					elseif texType == "P" then
						self.texture:SetTexCoord(1*width, 2*width, 1*height, 2*height);
						self.texture:SetVertexColor(1.0, 0.0, 0.0);
					elseif texType == "Y" then
						self.texture:SetTexCoord(1*width, 2*width, 1*height, 2*height);
						self.texture:SetVertexColor(12/15, 6/15, 0.0);
					elseif texType == "H" then
						self.texture:SetTexCoord(1*width, 2*width, 1*height, 2*height);
						self.texture:SetVertexColor(0.0, 0.0, 1.0);
					elseif texType == "W" then
						self.texture:SetTexCoord(1*width, 2*width, 1*height, 2*height);
						self.texture:SetVertexColor(0.75, 0.75, 0.75);
					elseif texType == "L" then
						self.texture:SetTexCoord(1*width, 2*width, 1*height, 2*height);
						self.texture:SetDesaturated(1);
					else
						self.texture:SetTexCoord(1*width, 2*width, 1*height, 2*height);
					end
				end
				self.texture:SetAllPoints()
				self.texType = texType
			end

			pin.texType = 'U'
			self.pins[parentFrame]["npcs"][npcId] = pin
			return pin;
		end,

		_HideAllPins = function(self)
			for _, frame in pairs(self.supportedMaps) do
				if frame then
					self:_PinFrameSetup(frame)
					for i, v in pairs(self.pins[frame]["ids"]) do
						self:_HidePin(i, v)
					end
				end
			end
		end,

		_HidePin = function(self, id, pin)
			pin:Hide()
			local pinTable = self.pins[pin.originalParentFrame]
			pinTable["npcs"][pin.npcId] = nil
			pinTable["ids"][id] = nil
		end,

		_HideTooltip = function(self)
			self.tooltip:Hide()
		end,

		--	This will return a colored version of the holidayName if it is not celebrating the holiday currently.
		_HolidayName = function(self, holidayName)
			local colorStart, colorEnd = "", ""
			if not Grail:CelebratingHoliday(holidayName) then
				colorStart = "|cff996600"
				colorEnd = "|r"
			end
			return colorStart .. holidayName .. colorEnd, holidayName
		end,

		--	This routine will populate the data structure self.levelOneData with all of the items
		--	that are supposed to appear in the top-level dropdown or scroller.  Note that some of
		--	the items' appearances are controlled by preferences.
		_InitializeLevelOneData = function(self)
			--	each row will contain a displayName
			--	if the row is a header row, it will contain header (which is an integer so its status can be found in saved variables)
			--		and children which is a table of rows
			--	if the row is not a header row it will contain index (which is an integer used later to populate next level data)

			local WDB = WhollyDatabase
			local entries = {}
			local t1
			
			--	Basic continents
			for mapId, continentTable in pairs(Grail.continents) do
				tinsert(entries, { displayName = continentTable.name, index = Grail.continentIndexMapping[mapId] })
--			for i = 1, #(Grail.continents) do
--				tinsert(entries, { displayName = Grail.continents[i].name, index = i })
			end
			tablesort(entries, function(a, b) return a.displayName < b.displayName end)
			
			if Grail.blizzardRelease < 18505 then
			--	Dungeons
			t1 = { displayName = BUG_CATEGORY3, header = 1, children = {} }
			for mapId, continentTable in pairs(Grail.continents) do
				local i = Grail.continentIndexMapping[mapId]
				tinsert(t1.children, { displayName = continentTable.name, index = 10 + i, continent = i })
--			for i = 1, #(Grail.continents) do
--				tinsert(t1.children, { displayName = Grail.continents[i].name, index = 10 + i, continent = i })
			end
			tablesort(t1.children, function(a, b) return a.displayName < b.displayName end)
			tinsert(entries, t1)
			end

			tinsert(entries, { displayName = Wholly.s.WORLD_EVENTS, index = 21 })
			tinsert(entries, { displayName = CLASS, index = 22 })
			tinsert(entries, { displayName = TRADE_SKILLS, index = 23 })		-- Professions
			if not WDB.ignoreReputationQuests then
				tinsert(entries, { displayName = REPUTATION, index = 24 })
			end

			--	Achievements
			if WDB.loadAchievementData then
				t1 = { displayName = ACHIEVEMENTS, header = 2, children = {} }
				for mapId, continentTable in pairs(Grail.continents) do
					tinsert(t1.children, { displayName = continentTable.name, index = 30 + Grail.continentIndexMapping[mapId] })
--				for i = 1, #(Grail.continents) do
--					tinsert(t1.children, { displayName = Grail.continents[i].name, index = 30 + i })
				end
				tablesort(t1.children, function(a, b) return a.displayName < b.displayName end)
				local i = 0
				if nil ~= Grail.worldEventAchievements and nil ~= Grail.worldEventAchievements[Grail.playerFaction] then
					for holidayKey, _ in pairs(Grail.worldEventAchievements[Grail.playerFaction]) do
						i = i + 1
						tinsert(t1.children, { displayName = Grail.holidayMapping[holidayKey], index = 40 + i, holidayName = Grail.holidayMapping[holidayKey]})
					end
				end
				i = 0
				if nil ~= Grail.professionAchievements and nil ~= Grail.professionAchievements[Grail.playerFaction] then
					for professionKey, _ in pairs(Grail.professionAchievements[Grail.playerFaction]) do
						i = i + 1
						tinsert(t1.children, { displayName = Grail.professionMapping[professionKey], index = 50 + i, professionName = Grail.professionMapping[professionKey] })
					end
				end
				tinsert(t1.children, { displayName = BATTLE_PET_SOURCE_5, index = 74 })
				tinsert(t1.children, { displayName = Wholly.s.OTHER, index = 60 })
				tinsert(entries, t1)
			end

			--	Reputation Changes
			if WDB.loadReputationData then

				-- 15640 is the 5.0.1 release
				local _, release = GetBuildInfo()
				release = tonumber(release)

				t1 = { displayName = COMBAT_TEXT_SHOW_REPUTATION_TEXT, header = 3, children = {} }
				tinsert(t1.children, { displayName = EXPANSION_NAME0, index = 61 })
				tinsert(t1.children, { displayName = EXPANSION_NAME1, index = 62 })
				tinsert(t1.children, { displayName = EXPANSION_NAME2, index = 63 })
				tinsert(t1.children, { displayName = EXPANSION_NAME3, index = 64 })
				if release >= 15640 then
					tinsert(t1.children, { displayName = EXPANSION_NAME4, index = 65 })
				end
				if release >= 18505 then
					tinsert(t1.children, { displayName = EXPANSION_NAME5, index = 66 })
				end				
				tinsert(entries, t1)
			end

			tinsert(entries, { displayName = Wholly.s.FOLLOWERS, index = 71})
			tinsert(entries, { displayName = Wholly.s.OTHER, index = 72 })
			tinsert(entries, { displayName = SEARCH, index = 73 })
			tinsert(entries, { displayName = Wholly.s.TAGS, index = 75 })	-- note that 74 is the pet battles above

			self.levelOneData = entries			
		end,

		--	This routine will populate the data structure self.levelTwoData with all of the items
		--	that are supposed to appear in the next-level dropdown or scroller based on the level
		--	one selection.
		_InitializeLevelTwoData = function(self)
			local displaysEmptyZones = WhollyDatabase.displaysEmptyZones
			local t = {}
			local which = self.levelOneCurrent and self.levelOneCurrent.index or nil
			if nil == which then self.levelTwoData = t return end
			if 10 > which then				-- Basic continent
				local Z = Grail.continents[Grail.continentMapIds[which]].zones
--				local Z = Grail.continents[which].zones
				for i = 1, #Z do
					local t1 = {}
					t1.sortName = Z[i].name
					t1.mapID = Z[i].mapID
--local augmentation = ''
--if nil ~= Grail.indexedQuests[t1.mapID] then augmentation = augmentation .. ' (' .. #(Grail.indexedQuests[t1.mapID]) .. ')' else augmentation = augmentation .. ' (NIL)' end
--if nil ~= Grail.indexedQuestsExtra[t1.mapID] then augmentation = augmentation .. ' (' .. #(Grail.indexedQuestsExtra[t1.mapID]) .. ')' else augmentation = augmentation .. ' (NIL)' end
					t1.displayName = Z[i].name
--					.. ' ['.. Z[i].mapID .. ']' .. augmentation
					if displaysEmptyZones or (0 < (Grail.indexedQuests[t1.mapID] and #(Grail.indexedQuests[t1.mapID]) or 0)) or (0 < (Grail.indexedQuestsExtra[t1.mapID] and #(Grail.indexedQuestsExtra[t1.mapID]) or 0)) then
						tinsert(t, t1)
					end
				end
			elseif 20 > which then			-- Dungeons
				local mapAreas = Grail.continents[Grail.continentMapIds[self.levelOneCurrent.continent]].dungeons
--				local mapAreas = Grail.continents[self.levelOneCurrent.continent].dungeons
				for i = 1, #mapAreas do
					local t1 = {}
					t1.sortName = Grail:MapAreaName(mapAreas[i]) or "UNKNOWN"
					t1.displayName = t1.sortName
					t1.mapID = mapAreas[i]
					tinsert(t, t1)
				end
			elseif 21 == which then			-- World Events
				for code, name in pairs(Grail.holidayMapping) do
					local t1 = {}
					t1.sortName = name
					t1.displayName = self:_HolidayName(name)
					t1.mapID = Grail.holidayToMapAreaMapping['H'..code]
					tinsert(t, t1)
				end
			elseif 22 == which then		-- Class
				for code, englishName in pairs(Grail.classMapping) do
					local localizedGenderClassName = Grail:CreateClassNameLocalizedGenderized(englishName)
					local classColor = RAID_CLASS_COLORS[englishName]
					local mapId = Grail.classToMapAreaMapping['C'..code]
					if nil == classColor then
						classColor = { r = 0.0, g = 1.0, b = 150/255 }
						localizedGenderClassName = "Monk"
					end	-- need to do for Monk currently
					if nil ~= Grail:MapAreaName(mapId) then
						local t1 = {}
						t1.sortName = localizedGenderClassName
						t1.displayName = format("|cff%.2x%.2x%.2x%s|r", classColor.r*255, classColor.g*255, classColor.b*255, localizedGenderClassName)
						t1.mapID = mapId
						tinsert(t, t1)
					end
				end
			elseif 23 == which then		-- Professions
				for code, professionName in pairs(Grail.professionMapping) do
					local mapId = Grail.professionToMapAreaMapping['P'..code]
					if nil ~= Grail:MapAreaName(mapId) then
						local t1 = {}
						t1.sortName = professionName
						t1.displayName = professionName
						t1.mapID = mapId
						tinsert(t, t1)
					end
				end
			elseif 24 == which then		-- Reputations
				for reputationIndex, reputationName in pairs(Grail.reputationMapping) do
					local factionId = tonumber(reputationIndex, 16)
					local mapId = Grail.mapAreaBaseReputation + factionId
					if nil ~= Grail:MapAreaName(mapId) then
						local t1 = {}
						t1.sortName = reputationName
						t1.displayName = reputationName
						t1.mapID = mapId
						tinsert(t, t1)
					end
				end
			elseif 40 > which then		-- Continent Achievements
				local mapAreas = Grail.achievements[Grail.playerFaction] and Grail.achievements[Grail.playerFaction][which - 30] or {}
				for i = 1, #mapAreas do
					local t1 = {}
					t1.sortName = Grail:MapAreaName(mapAreas[i]) or "UNKONWN"
					t1.displayName = self:_AchievementName(mapAreas[i])
					t1.mapID = mapAreas[i]
					tinsert(t, t1)
				end
			elseif 50 > which then		-- Holiday Achievements
				local mapAreas = Grail.worldEventAchievements[Grail.playerFaction] and Grail.worldEventAchievements[Grail.playerFaction][Grail.reverseHolidayMapping[self.levelOneCurrent.holidayName]] or {}
				for i = 1, #mapAreas do
					local t1 = {}
					t1.sortName = Grail:MapAreaName(mapAreas[i]) or "UNKNOWN"
					t1.displayName = self:_AchievementName(mapAreas[i])
					t1.mapID = mapAreas[i]
					tinsert(t, t1)
				end
			elseif 60 > which then		-- Profession Achievements
				local mapAreas = Grail.professionAchievements[Grail.playerFaction] and Grail.professionAchievements[Grail.playerFaction][Grail.reverseProfessionMapping[self.levelOneCurrent.professionName]] or {}
				for i = 1, #mapAreas do
					local t1 = {}
					t1.sortName = Grail:MapAreaName(mapAreas[i]) or "UNKNOWN"
					t1.displayName = self:_AchievementName(mapAreas[i])
					t1.mapID = mapAreas[i]
					tinsert(t, t1)
				end
			elseif 60 == which then		-- Other Achievements
				-- 5 Dungeon Achievement
				local t1 = {}
				local mapID = Grail.mapAreaBaseAchievement + 4956
				t1.displayName, t1.sortName = self:_AchievementName(mapID)
				t1.mapID = mapID
				tinsert(t, t1)

				-- Just Another Day in Tol Barad Achievement
				t1 = {}
				mapID = Grail.mapAreaBaseAchievement + ("Alliance" == Grail.playerFaction and 5718 or 5719)
				t1.displayName, t1.sortName = self:_AchievementName(mapID)
				t1.mapID = mapID
				tinsert(t, t1)
			elseif 70 > which then		-- Reputation Changes
				local mapAreas = Grail.reputationExpansionMapping[which - 60]
				for i = 1, #mapAreas do
					local t1 = {}
					local mapID = Grail.mapAreaBaseReputationChange + mapAreas[i]
					local factionId = Grail:_HexValue(mapAreas[i], 3)
					t1.sortName = Grail.reputationMapping[factionId]
					t1.displayName = t1.sortName
					t1.mapID = mapID
					if nil ~= Grail.indexedQuests[mapID] and 0 ~= #(Grail.indexedQuests[mapID]) then
						tinsert(t, t1)
					end
				end
			elseif 71 == which then		-- Followers
				local followerInfo, followerName, qualityLevel
				for questId, followerId in pairs(Grail.followerMapping) do
					if Grail:MeetsRequirementFaction(questId) then
						followerInfo = C_Garrison.GetFollowerInfo(followerId)
						followerName = followerInfo.name
						qualityLevel = followerInfo.quality
						tinsert(t, { sortName = followerName, displayName = ITEM_QUALITY_COLORS[qualityLevel].hex..followerName.."|r", mapID = 0, f = function() Grail:SetMapAreaQuests(0, followerName, { questId }) Wholly.zoneInfo.panel.mapId = 0 Wholly._ForcePanelMapArea(Wholly, true) CloseDropDownMenus() end })
					end
				end
			elseif 72 == which then		-- Other
				for i = 1, #(Grail.otherMapping) do
					local t1 = {}
					local mapID = Grail.otherMapping[i]
					t1.sortName = Grail:MapAreaName(mapID) or "UNKNOWN"
					t1.displayName = t1.sortName
					t1.mapID = mapID
					tinsert(t, t1)
				end
				local mapAreaID = Grail.mapAreaBaseDaily
				local mapName = Grail:MapAreaName(mapAreaID) or "UNKNOWN"
				tinsert(t, { sortName = mapName, displayName = "|c" .. WhollyDatabase.color['D'] .. mapName .. "|r", mapID = mapAreaID })
				mapAreaID = Grail.mapAreaBaseOther
				mapName = Wholly.s.OTHER
				tinsert(t, { sortName = mapName, displayName = mapName, mapID = mapAreaID })
			elseif 73 == which then		-- Search
				-- We use sortName in a special way because we do not want these items sorted alphabetically
				local lastUsed = 1
				local WDB = WhollyDatabase

				tinsert(t, { sortName = 1, displayName = Wholly.s.SEARCH_NEW, f = function() Wholly._SearchFrameShow(Wholly, nil) Wholly.zoneInfo.panel.mapId = nil Wholly._SetLevelTwoCurrent(Wholly, nil) Wholly._ForcePanelMapArea(Wholly,true) CloseDropDownMenus() end })
				if WDB.searches and 0 < #(WDB.searches) then
					for i = 1, #(WDB.searches) do
						local shouldSelect = (i == #(WDB.searches)) and self.justAddedSearch
						tinsert(t, { sortName = i + 1, displayName = SEARCH .. ': ' .. WDB.searches[i], mapID = 0, selected = shouldSelect, f = function() Wholly.SearchForQuestNamesMatching(Wholly, WDB.searches[i]) Wholly.zoneInfo.panel.mapId = 0 Wholly._ForcePanelMapArea(Wholly, true) CloseDropDownMenus() end })
					end
					lastUsed = #(WDB.searches) + 2
					tinsert(t, { sortName = lastUsed, displayName = Wholly.s.SEARCH_CLEAR, f = function() WDB.searches = nil CloseDropDownMenus() Wholly.zoneInfo.panel.mapId = nil Wholly._SetLevelTwoCurrent(Wholly, nil) Wholly._ForcePanelMapArea(Wholly,true) Wholly.ScrollFrameTwo_Update(Wholly) end })
					self.justAddedSearch = nil
				end
				tinsert(t, { sortName = lastUsed + 1, displayName = Wholly.s.SEARCH_ALL_QUESTS, f = function() Wholly.SearchForAllQuests(Wholly) Wholly.zoneInfo.panel.mapId = 0 Wholly._ForcePanelMapArea(Wholly, true) CloseDropDownMenus() end })
			elseif 74 == which then		-- Pet Battle achievements
				local mapAreas = Grail.petBattleAchievements[Grail.playerFaction] or {}
				for i = 1, #mapAreas do
					local t1 = {}
					t1.sortName = Grail:MapAreaName(mapAreas[i]) or "UNKNOWN"
					t1.displayName = self:_AchievementName(mapAreas[i])
					t1.mapID = mapAreas[i]
					tinsert(t, t1)
				end
			elseif 75 == which then		-- Tags
				local WDB = WhollyDatabase
				tinsert(t, { sortName = " ", displayName = Wholly.s.TAGS_NEW, f = function() Wholly._SearchFrameShow(Wholly, true) Wholly.zoneInfo.panel.mapId = nil Wholly._SetLevelTwoCurrent(Wholly, nil) Wholly._ForcePanelMapArea(Wholly,true) CloseDropDownMenus() end })
				if WDB.tags then
					for tagName, _ in pairs(WDB.tags) do
						tinsert(t, { sortName = tagName, displayName = Wholly.s.TAGS .. ': ' .. tagName, mapID = 0, f = function() Wholly.SearchForQuestsWithTag(Wholly, tagName) Wholly.zoneInfo.panel.mapId = 0 Wholly._ForcePanelMapArea(Wholly, true) CloseDropDownMenus() end })
					end
					tinsert(t, { sortName = "  ", displayName = Wholly.s.TAGS_DELETE, f = function() Wholly._TagDelete(Wholly) Wholly.zoneInfo.panel.mapId = nil Wholly._SetLevelTwoCurrent(Wholly, nil) Wholly._ForcePanelMapArea(Wholly,true) end })
				end
			end
			tablesort(t, function(a, b) return a.sortName < b.sortName end)

			-- We want to make sure we retain the proper selection
			if nil ~= self.levelTwoCurrent then
				for i, v in pairs(t) do
					if v.displayName == self.levelTwoCurrent.displayName and v.mapID == self.levelTwoCurrent.mapID then
						v.selected = true
					end
				end
			end
			self.levelTwoData = t
			self.lastWhich = which
		end,

		--	Starting in Blizzard's 5.4 release the SECURE_ACTIONS.click routine now calls IsForbidden() on the delegate
		--	without first seeing if the delegate implements it.  Of course since Wholly did not implement it and is
		--	considered the delegate as it is the "clickbutton" attribute, Lua errors would happen for clicks.  Now it
		--	is implemented.
		IsForbidden = function(self)
			return false
		end,

		_IsIgnoredQuest = function(self, questId)
			return Grail:_IsQuestMarkedInDatabase(questId, WhollyDatabase.ignoredQuests)
		end,

		_LoadDefaults = function(self)
			local db = {}
			db.defaultsLoaded = true
			db.prependsQuestLevel = true
			db.appendRequiredLevel = true
			db.showsLowLevelQuests = true
			db.showsAnyPreviousRepeatableCompletions = true
			db.updatesPanelWhenZoneChanges = true
			db.displaysMapPins = true
			db.displaysMapFrame = true
			db.displaysDungeonQuests = true
			db.displaysBreadcrumbs = true
			db.displaysHolidaysAlways = true
			db.updatesWorldMapOnZoneChange = true
			db.showsInLogQuestStatus = true
			db.showsAchievementCompletionColors = true
			db.loadAchievementData = true
			db.loadReputationData = true
			db.showsHolidayQuests = true
			db.showsWeeklyQuests = true
			db.loadDataData = true
			db.version = Wholly.versionNumber
			WhollyDatabase = db
			return db
		end,

		_NPCInfoSection = function(self, heading, table, button, meetsCriteria)
			if nil == table then return end
			self:_AddLine(" ")
			self:_AddLine(heading)
			for _, npcId in pairs(table) do
				local locations = Grail:NPCLocations(npcId)
				if nil ~= locations then
					for _, npc in pairs(locations) do
						local locationString = npc.mapArea and Grail:MapAreaName(npc.mapArea) or ""
						if npc.near then
							locationString = locationString .. ' ' .. self.s.NEAR
						elseif npc.mailbox then
							locationString = locationString .. ' ' .. self.s.MAILBOX
						elseif npc.created then
							locationString = locationString .. ' ' .. self.s.CREATED_ITEMS
						elseif nil ~= npc.x then
							locationString = locationString .. strformat(' %.2f, %.2f', npc.x, npc.y)
						end
						local nameToUse = npc.name or "**"
						if npc.dropName then
							nameToUse = nameToUse .. " (" .. npc.dropName .. ')'
						end
						self:_AddLine(self:_PrettyNPCString(nameToUse, npc.kill, npc.realArea), locationString)
						if meetsCriteria then
							local desiredMacroValue = SLASH_TARGET1 .. ' ' .. (npc.name or "**")
							if button:GetAttribute("macrotext") ~= desiredMacroValue and not InCombatLockdown() then
								button:SetAttribute("macrotext", desiredMacroValue)
							end
						end
					end
				end
			end
		end,

		_NPCInfoSectionPrerequisites = function(self, heading, table, button, meetsCriteria)
			if nil == table then return end
			self:_AddLine(" ")
			self:_AddLine(heading)
			for npcId, preqTable in pairs(table) do
				local locations = Grail:NPCLocations(npcId)
				if nil ~= locations then
					for _, npc in pairs(locations) do
						local locationString = npc.mapArea and Grail:MapAreaName(npc.mapArea) or ""
						if npc.near then
							locationString = locationString .. ' ' .. self.s.NEAR
						elseif npc.mailbox then
							locationString = locationString .. ' ' .. self.s.MAILBOX
						elseif npc.created then
							locationString = locationString .. ' ' .. self.s.CREATED_ITEMS
						elseif nil ~= npc.x then
							locationString = locationString .. strformat(' %.2f, %.2f', npc.x, npc.y)
						end
						local nameToUse = npc.name
						if npc.dropName then
							nameToUse = nameToUse .. " (" .. npc.dropName .. ')'
						end
						self:_QuestInfoSection({self:_PrettyNPCString(nameToUse, npc.kill, npc.realArea), locationString}, preqTable)
						if meetsCriteria then
							local desiredMacroValue = self.s.SLASH_TARGET .. ' ' .. npc.name
							if button:GetAttribute("macrotext") ~= desiredMacroValue and not InCombatLockdown() then
								button:SetAttribute("macrotext", desiredMacroValue)
							end
						end
					end
				end
			end
		end,

		_OnEnterBlizzardQuestButton = function(blizzardQuestButton)
			if WhollyDatabase.displaysBlizzardQuestTooltips then
				local questId = blizzardQuestButton.questID
				Wholly.onlyAddingTooltipToGameTooltip = true
				Wholly:_PopulateTooltipForQuest(blizzardQuestButton, questId)
				Wholly.onlyAddingTooltipToGameTooltip = false
				GameTooltip:Show()
			end
		end,

		_OnEvent = function(self, frame, event, ...)
			if self.eventDispatch[event] then
				self.eventDispatch[event](self, frame, ...)
			end
		end,

		OnHide = function(self, frame)
		end,

		OnLoad = function(self, frame)
			GRAIL = Grail
			if not GRAIL or GRAIL.versionNumber < requiredGrailVersion then
				local errorMessage = format(self.s.REQUIRES_FORMAT, requiredGrailVersion)
				print(errorMessage)
				UIErrorsFrame:AddMessage(errorMessage)
				return 
			end
			self.checkedGrailVersion = true
			SlashCmdList["WHOLLY"] = function(msg)
				self:SlashCommand(frame, msg)
			end
			SLASH_WHOLLY1 = "/wholly"
			com_mithrandir_whollyFrameTitleText:SetText("Wholly ".. com_mithrandir_whollyFrameTitleText:GetText())
			com_mithrandir_whollyFrameWideTitleText:SetText("Wholly ".. com_mithrandir_whollyFrameWideTitleText:GetText())

			self.toggleButton = CreateFrame("Button", "com_mithrandir_whollyFrameHiddenToggleButton", com_mithrandir_whollyFrame, "SecureHandlerClickTemplate")
			self.toggleButton:SetAttribute("_onclick", [=[
				local parent = self:GetParent()
				if parent:IsShown() then
					parent:Hide()
				else
					parent:Show()
				end
				]=])

			self.currentFrame = com_mithrandir_whollyFrame

			-- The frame is not allowing button presses to things just on the outside of its bounds so we move the hit rect
			frame:SetHitRectInsets(0, 32, 0, 84)

			local LibStub = _G["LibStub"]
			if LibStub then
				local LDB = LibStub("LibDataBroker-1.1", true)
				if LDB then
					local launcher = LDB:NewDataObject("Wholly", { type="launcher", icon="Interface\\Icons\\INV_Misc_Book_07",
							OnClick = function(theFrame, button) if button == "RightButton" then Wholly:_OpenInterfaceOptions() else Wholly.currentFrame:Show() end end,
							OnTooltipShow = function(tooltip)
								Wholly:_ProcessInitialUpdate()
								Wholly.ldbTooltipOwner = tooltip:GetOwner()
								local dropdownValue = Wholly:_Dropdown_GetText()
								local printValue = dropdownValue or ""
								tooltip:AddLine("Wholly - " .. printValue )
								tooltip:AddLine(Wholly.panelCountLine)
								end, 
							})
					self.coordinates = LDB:NewDataObject("Wholly Coordinates", { type="data source", icon="Interface\\Icons\\INV_Misc_Map02", text="",
							OnClick = function(theFrame, button) Wholly.pairedCoordinatesButton:Click() end,
							OnTooltipShow = function(tooltip)
								Wholly.ldbCoordinatesTooltipOwner = tooltip:GetOwner()
								local dungeonLevel = Wholly.zoneInfo.zone.dungeonLevel
								local dungeonIndicator = (dungeonLevel > 0) and "["..dungeonLevel.."]" or ""
								local mapAreaId = Wholly.zoneInfo.zone.mapId
								local mapAreaName = GRAIL:MapAreaName(mapAreaId) or "UNKNOWN"
								tooltip:AddLine(strformat("%d%s %s", mapAreaId, dungeonIndicator, mapAreaName)) end,
							})
				end
			end

			self.tooltip = CreateFrame("GameTooltip", "com_mithrandir_WhollyTooltip", UIParent, "GameTooltipTemplate");
			self.tooltip:SetFrameStrata("TOOLTIP");
			self.tooltip.large = com_mithrandir_WhollyTooltipTextLeft1:GetFontObject();
			self.tooltip.small = com_mithrandir_WhollyTooltipTextLeft2:GetFontObject();
			self.tooltip.SetLastFont = function(self, fontObj, rightText)
				local txt = rightText and "Right" or "Left"
				_G[format("com_mithrandir_WhollyTooltipText%s%d", txt, self:NumLines())]:SetFont(fontObj:GetFont())
			end

			self.tt = { [1] = GameTooltip }

			local f = CreateFrame("Button", nil, WorldMapFrame, "UIPanelButtonTemplate")
			f:SetSize(100, 25)
			if nil == Gatherer_WorldMapDisplay then
				if Grail.blizzardRelease < 18505 then
					f:SetPoint("TOPLEFT", WorldMapPositioningGuide, "TOPLEFT", 4, -4)
				else
					f:SetPoint("TOPLEFT", WorldMapFrameTutorialButton, "TOPRIGHT", 0, -30)
				end
			else
				f:SetPoint("TOPLEFT", Gatherer_WorldMapDisplay, "TOPRIGHT", 4, 0)
			end
			f:SetToplevel(true)
			f:SetScale(0.7)
			f:SetText("Wholly")
			f:SetScript("OnShow", function(self)
									if nil == Gatherer_WorldMapDisplay then
										if Grail.blizzardRelease < 18505 then
											if not(GetCVarBool("miniWorldMap")) then
												f:SetPoint("TOPLEFT", WorldMapPositioningGuide, "TOPLEFT", 4, -4)
											else
												self:SetPoint("TOPLEFT", WorldMapTitleButton, "TOPLEFT", 8, -3)
											end
										else
											if TomTomWorldFrame and TomTomWorldFrame.Player then
												f:SetPoint("TOPLEFT", TomTomWorldFrame.Player, "TOPRIGHT", 10, 6)
											else
												f:SetPoint("TOPLEFT", WorldMapFrameTutorialButton, "TOPRIGHT", 0, -30)
											end
										end
									else
										self:SetPoint("TOPLEFT", Gatherer_WorldMapDisplay, "TOPRIGHT", 4, 0)
									end
								end)
			f:SetScript("OnEnter", function(self) local t = Wholly.tooltip t:ClearLines() t:SetOwner(self) t:AddLine(Wholly.mapCountLine) t:Show() t:ClearAllPoints() t:SetPoint("TOPLEFT", self, "BOTTOMRIGHT") end)
			f:SetScript("OnLeave", function(self) Wholly.tooltip:Hide() end)
			f:SetScript("OnClick", function(self) Wholly.pairedConfigurationButton:Click() end)
			f:Hide()
			self.mapFrame = f

			-- if the UI panel disappears (maximized WorldMapFrame) we need to change parents
			UIParent:HookScript("OnHide", function()
				self.tooltip:SetParent(WorldMapFrame);
				self.tooltip:SetFrameStrata("TOOLTIP");
			end)
			UIParent:HookScript("OnShow", function()
				self.tooltip:SetParent(UIParent);
				self.tooltip:SetFrameStrata("TOOLTIP");
			end)

			for _, frame in pairs(self.supportedControlMaps) do
				if frame then
					frame:HookScript("OnShow", function()
						Wholly:_UpdatePins()
					end)
				end
			end

			GameTooltip:HookScript("OnTooltipSetUnit", Wholly._CheckNPCTooltip)

			-- Code by Ashel from http://us.battle.net/wow/en/forum/topic/10388639018?page=2
			if not WhollyDatabase.taintFixed and GRAIL.blizzardRelease < 17644 then		-- this is an arbitrary version from the PTR where things are fixed
				UIParent:HookScript("OnEvent", function(s, e, a1, a2)
					if e:find("ACTION_FORBIDDEN") and ((a1 or "")..(a2 or "")):find("IsDisabledByParentalControls") then
						StaticPopup_Hide(e)
					end
				end)
			end

			-- Make it so the Blizzard quest log can display our tooltips
			if GRAIL.blizzardRelease < 18505 then	-- technically there were a few WoD releases before this
				local buttons = QuestLogScrollFrame.buttons
				local buttonCount = #buttons
				for i = 1, buttonCount do
					buttons[i]:HookScript("OnEnter", function(button)
						if WhollyDatabase.displaysBlizzardQuestTooltips then
							self:_PresentTooltipForBlizzardQuest(button)
						end
					end)
					buttons[i]:HookScript("OnLeave", function(button)
						if WhollyDatabase.displaysBlizzardQuestTooltips then
							for i = 1, self.currentTt do
								self.tt[i]:Hide()
							end
						end
					end)
				end
			else
				hooksecurefunc("QuestMapLogTitleButton_OnEnter", Wholly._OnEnterBlizzardQuestButton)
				-- Now since the Blizzard UI has probably created a quest frame before I get
				-- the chance to hook the function I need to go through all the quest frames
				-- and hook them too.
				local titles = QuestMapFrame.QuestsFrame.Contents.Titles
				for i = 1, #(titles) do
					titles[i]:HookScript("OnEnter", Wholly._OnEnterBlizzardQuestButton)
				end
			end

			-- Our frame positions are wrong for MoP, so we change them here.
			if GRAIL.blizzardRelease >= 15640 then
				com_mithrandir_whollyQuestInfoFrame:SetPoint("TOPRIGHT", QuestFrame, "TOPRIGHT", -15, -35)
				com_mithrandir_whollyQuestInfoBuggedFrame:SetPoint("TOPLEFT", QuestFrame, "TOPLEFT", 100, -35)
				com_mithrandir_whollyBreadcrumbFrame:SetPoint("TOPLEFT", QuestFrame, "BOTTOMLEFT", 16, -10)
			end

			local nf = CreateFrame("Frame")
			nf:SetScript("OnEvent", function(frame, event, ...) self:_OnEvent(frame, event, ...) end)
			nf:RegisterEvent("ADDON_LOADED")
			self.notificationFrame = nf

			if "deDE" == GetLocale() then
				com_mithrandir_whollyFramePreferencesButton:SetText("Einstellungen")
			end
			if "ruRU" == GetLocale() then
				com_mithrandir_whollyFrameSortButton:SetText("Сортировать")
			end

			com_mithrandir_whollyFrameSwitchZoneButton:SetText(self.s.MAP)
			com_mithrandir_whollyFrameWideSwitchZoneButton:SetText(self.s.MAP)
			if GRAIL.blizzardRelease < 18505 then
				com_mithrandir_whollyFrameWideReallySwitchZoneButton:Hide()
			end

		end,

		---
		--	The first time the panel is shown it is populated with the information from the current map area.
		OnShow = function(self, frame)
			self:_ProcessInitialUpdate()
			if nil == self.dropdown and self.currentFrame == com_mithrandir_whollyFrame then
				self:_Dropdown_Create()
				local mapAreaName = GRAIL:MapAreaName(self.zoneInfo.panel.mapId) or GetRealZoneText()	-- default to something if we do not support the zone
				if nil ~= mapAreaName then self:_Dropdown_SetText(mapAreaName) end
			end
			if WhollyDatabase.showsInLogQuestStatus then
				self:ScrollFrame_Update_WithCombatCheck()
			end
			self:ScrollFrameOne_Update()
			self:ScrollFrameTwo_Update()
		end,

		_OnUpdate = function(self, frame, elapsed)
			self.lastUpdate = self.lastUpdate + elapsed
			if self.lastUpdate < self.updateThreshold then return end
			local x, y = GetPlayerMapPosition('player')
			if self.previousX ~= x or self.previousY ~= y then
				if nil ~= self.coordinates then
					self.coordinates.text = strformat("%.2f, %.2f", x * 100, y * 100)
				end
				self.previousX = x
				self.previousY = y
			end
			self.lastUpdate = 0
		end,

		--	For some odd reason, if the options have never been opened they will default to opening to a Blizzard
		--	option and not the desired one.  So a brutal workaround is to call it twice, which seems to do the job.
		_OpenInterfaceOptions = function(self)
			InterfaceOptionsFrame_OpenToCategory("Wholly")
			InterfaceOptionsFrame_OpenToCategory("Wholly")
		end,

		_PinFrameSetup = function(self, frame)
			if nil == self.pins[frame] then
				self.pins[frame] = { ["npcs"] = {}, ["ids"] = {}, }
			end
		end,

		_PresentTooltipForBlizzardQuest = function(self, blizzardQuestButton)
			local questIndex = blizzardQuestButton:GetID()
			local questTitle, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily, questId, startEvent = Grail:GetQuestLogTitle(questIndex)
			if not isHeader then
				self:_PopulateTooltipForQuest(blizzardQuestButton, questId)
				for i = 1, self.currentTt do
					self.tt[i]:Show()
				end
			end
		end,

		_PrettyNPCString = function(self, npcName, mustKill, realAreaId)
			if mustKill then npcName = format(self.s.MUST_KILL_PIN_FORMAT, npcName) end
			if realAreaId then npcName = format("%s => %s", npcName, GRAIL:MapAreaName(realAreaId) or "UNKNOWN") end
			return npcName
		end,

		_PrettyQuestCountString = function(self, questTable, displayedCount, forMap, abbreviated)
			local WDB = WhollyDatabase
			local retval = ""
			local codesToUse = abbreviated and { 'G', 'W', 'L', 'Y', } or { 'G', 'W', 'L', 'Y', 'P', 'D', 'K', 'R', 'H', 'I', 'C', 'B', }
			local lastCode = abbreviated and 'P' or 'U'
			displayedCount = displayedCount or 0
			if nil ~= questTable then
				local totals = { ['B'] = 0, ['C'] = 0, ['D'] = 0, ['G'] = 0, ['H'] = 0, ['I'] = 0, ['K'] = 0, ['L'] = 0, ['P'] = 0, ['R'] = 0, ['U'] = 0, ['W'] = 0, ['Y'] = 0, }
				local code
				for i = 1, #questTable do
					code = questTable[i][2]
					totals[code] = totals[code] + 1
				end
				local colorCode
				for _,code in pairs(codesToUse) do
					colorCode = WDB.color[code]
					retval = retval .. "|c" .. colorCode .. totals[code] .. "|r/"
				end
				local displayStart, displayEnd = "", ""
				if forMap and not WhollyDatabase.displaysMapPins then
					displayStart, displayEnd = "|cffff0000", "|r"
				end
				retval = retval .. "|c" .. WDB.color[lastCode] .. totals[lastCode] .. "|r"
				if not abbreviated then
					retval = retval .. "  [" .. displayStart .. displayedCount .. displayEnd .. "/" .. #questTable .."]"
				end
			end
			return retval
		end,

		_PrettyQuestString = function(self, questTable)
			local WDB = WhollyDatabase
			local questId = questTable[1]
			local questCode, subcode, numeric = GRAIL:CodeParts(questId)
			local filterCode = questTable[2]
			local colorCode = WDB.color[filterCode]
			if questCode == 'I' or questCode == 'Y' then
				local name = GetSpellInfo(numeric)
				local negateString = (questCode == 'Y') and "!" or ""
				return format("|c%s%s|r %s[%s]", colorCode, name, negateString, self.s.SPELLS)
			elseif questCode == 'F' then
				return format("|c%s%s|r [%s]", colorCode, subcode == 'A' and self.s.ALLIANCE or self.s.HORDE, self.s.FACTION)
			elseif questCode == 'W' then
				local questTable = GRAIL.questStatusCache['G'][subcode] or {}
				return format("|c%s%d|r/%d", colorCode, numeric, #(questTable))
			elseif questCode == 'V' then
				local questTable = GRAIL.questStatusCache['G'][subcode] or {}
				return format("|c%s%d|r/%d [%s]", colorCode, numeric, #(questTable), self.s.ACCEPTED)
			elseif questCode == 'U' or questCode == 'T' then
				if 'U' == questCode and 'P' == filterCode then colorCode = WDB.color.B end
				return format("|c%s%s|r [%s]", colorCode, GRAIL.reputationMapping[subcode], self.s.REPUTATION_REQUIRED)
			elseif questCode == 'Z' then
				local name = GetSpellInfo(numeric)
				return format("|c%s%s|r [%s]", colorCode, name, self.s.EVER_CAST)
			elseif questCode == 'R' then
				local name = GetSpellInfo(numeric)
				return format("|c%s%s|r [%s]", colorCode, name, self.s.EVER_EXPERIENCED)
			elseif questCode == 'J' then
				local id, name = GetAchievementInfo(numeric)
				return format("|c%s%s|r [%s]", colorCode, name, self.s.ACHIEVEMENTS)
			elseif questCode == 'K' then
				local name = GRAIL:NPCName(numeric)
				return format("|c%s%s|r [%s]", colorCode, name, self.s.ITEM)
			elseif questCode == 'L' then
				local name = GRAIL:NPCName(numeric)
				return format("|c%s%s|r [%s]", colorCode, name, self.s.ITEM_LACK)
			elseif questCode == 'l' then
				return format("|c%s%s %d|r", colorCode, self.s.LEVEL, numeric)
			elseif questCode == 'P' then
				local meetsRequirement, actualSkillLevel = GRAIL:ProfessionExceeds(subcode, numeric)
				local levelCode
				if meetsRequirement then
					colorCode = WDB.color['C']
					levelCode = WDB.color['C']
				elseif actualSkillLevel ~= GRAIL.NO_SKILL then
					colorCode = WDB.color['C']
					levelCode = WDB.color['P']
				else
					colorCode = WDB.color['P']
					levelCode = WDB.color['P']
				end
				return format("|c%s%s|r |c%s%d|r [%s]", colorCode, GRAIL.professionMapping[subcode], levelCode, numeric, self.s.PROFESSIONS)
			elseif questCode == 'Q' then
				local skillName
				if numeric > 200000000 then
					skillName = GRAIL:NPCName(numeric)
				else
					skillName = GetSpellInfo(numeric)
				end
				return format("|c%s%s|r ![%s]", colorCode, skillName, self.s.SKILL)
			elseif questCode == 'S' then
				local skillName
				if numeric > 200000000 then
					skillName = GRAIL:NPCName(numeric)
				else
					skillName = GetSpellInfo(numeric)
				end
				return format("|c%s%s|r [%s]", colorCode, skillName, self.s.SKILL)
			elseif questCode == 'G' then
				local positive = (numeric < 0) and numeric * -1 or numeric
				local id, buildingName = C_Garrison.GetBuildingInfo(positive)
				local requiredPlotString = ''
				if '' ~= subcode then
					requiredPlotString = " " .. self.s.PLOT .. " " .. subcode
				end
				return format("|c%s%s%s|r [%s]", colorCode, buildingName, requiredPlotString, self.s.BUILDING)
			elseif questCode == '=' or questCode == '<' or questCode == '>' then
				local phaseLocation = GRAIL:MapAreaName(subcode) or "UNKNOWN"
				local phaseString = format(self.s.STAGE_FORMAT, numeric)
				return format("|c%s%s %s [%s]|r", colorCode, phaseLocation, questCode, phaseString)
			elseif questCode == 'i' or questCode == 'j' then
				local comparison = questCode == 'i' and ">=" or '<'
				return format("|c%s%s %s %s|r", colorCode, self.s.CURRENTLY_EQUIPPED, comparison, self.s.ILEVEL)
			else
				questId = numeric
				local typeString = ""
				local WDB = WhollyDatabase
				if questCode == 'B' then
					typeString = format(" [%s]", self.s.IN_LOG)
				elseif questCode == 'C' then
					typeString = format(" [%s, %s]", self.s.IN_LOG, self.s.TURNED_IN)
				elseif questCode == 'D' then
					typeString = format(" [%s]", self.s.COMPLETE)
				elseif questCode == 'e' then
					typeString = format(" ![%s, %s]", self.s.COMPLETE, self.s.TURNED_IN)
				elseif questCode == 'E' then
					typeString = format(" [%s, %s]", self.s.COMPLETE, self.s.TURNED_IN)
				elseif questCode == 'H' then
					typeString = format(" [%s]", self.s.EVER_COMPLETED)
				elseif questCode == 'M' then
					typeString = format(" [%s]", self.s.ABANDONED)
				elseif questCode == 'N' then
					typeString = format(" [%s]", self.s.NEVER_ABANDONED)
				elseif questCode == 'O' then
					typeString = format(" [%s]", self.s.ACCEPTED)
				elseif questCode == 'X' then
					typeString = format(" ![%s]", self.s.TURNED_IN)
				end
				local statusCode = GRAIL:StatusCode(questId)
				local questLevel = GRAIL:QuestLevel(questId)
				local questLevelString = WDB.prependsQuestLevel and format("[%s] ", questLevel or "??") or ""
				local requiredLevelString = ""
				if WDB.appendRequiredLevel then
					local success, _, questLevelNeeded, _ = GRAIL:MeetsRequirementLevel(questId)
					if bitband(statusCode, GRAIL.bitMaskLevelTooLow) > 0 then requiredLevelString = format(" [%s]", questLevelNeeded) end
				end
				local repeatableCompletedString = WDB.showsAnyPreviousRepeatableCompletions and bitband(statusCode, GRAIL.bitMaskResettableRepeatableCompleted) > 0 and "*" or ""
				return format("|c%s%s%s%s%s|r%s", colorCode, questLevelString, self:_QuestName(questId), repeatableCompletedString, requiredLevelString, typeString)
			end
		end,

		_ProcessInitialUpdate = function(self)
			if not self.initialUpdateProcessed then
				self.zoneInfo.panel.mapId = self.zoneInfo.zone.mapId
				self.zoneInfo.panel.dungeonLevel = self.zoneInfo.zone.dungeonLevel
				self:_ForcePanelMapArea()
				self.initialUpdateProcessed = true
			end
		end,

		_PopulateTooltipForQuest = function(self, frame, questId, aliasQuestId)
			local Grail = Grail
			self.currentTt = 1
			questId = tonumber(questId)
			if not self.onlyAddingTooltipToGameTooltip then
				self.tt[1]:SetOwner(frame, "ANCHOR_RIGHT")
				self.tt[1]:ClearLines()
			end
			if nil == questId then return end
			if not self.onlyAddingTooltipToGameTooltip then
				self.tt[1]:SetHyperlink(format("quest:%d", questId))
			end
			if not Grail:DoesQuestExist(questId) then self:_AddLine(" ") self:_AddLine(self.s.GRAIL_NOT_HAVE) return end

			local bugged = Grail:IsBugged(questId)
			if bugged then
				self:_AddLine(" ")
				self:_AddLine(self.s.BUGGED)
				self:_AddLine(bugged)
			end

			local obsolete = Grail:IsQuestObsolete(questId)
			if obsolete then
				self:_AddLine(" ")
				self:_AddLine("|cffff0000"..self.s.UNAVAILABLE.." ("..self.s.REMOVED..")|r", obsolete)
			end

			local pending = Grail:IsQuestPending(questId)
			if pending then
				self:_AddLine(" ")
				self:_AddLine("|cffff0000"..self.s.UNAVAILABLE.." ("..self.s.PENDING..")|r", pending)
			end

			if self.debug then
				self:_AddLine(" ")
				local aliasQuestString = aliasQuestId and " ("..aliasQuestId..")" or ""
				self:_AddLine(self.s.QUEST_ID ..questId..aliasQuestString)
			end

			local GWP = GrailWhenPlayer
			if nil ~= GWP then
				local when = GWP['when'][questId]
				if nil == when then
					if Grail:IsQuestCompleted(questId) or Grail:HasQuestEverBeenCompleted(questId) then
						when = self.s.TIME_UNKNOWN
					end
				end
				if nil ~= when then
					self:_AddLine(" ")
					when = "|cff00ff00" .. when .. "|r"
					local count = GWP['count'][questId]
					self:_AddLine(strformat(self.s.COMPLETED_FORMAT, when), count)
				end
			end

			questId = aliasQuestId or questId	-- remap to the alias now that the Blizzard interaction is done
			local obtainersCode = Grail:CodeObtainers(questId)
			local holidayCode = Grail:CodeHoliday(questId)
			local questLevel = Grail:QuestLevel(questId)
			local _, _, requiredLevel, notToExceedLevel = Grail:MeetsRequirementLevel(questId)
			local questType = self:_QuestTypeString(questId)
			local statusCode = Grail:StatusCode(questId)
			local normalColor, redColor, orangeColor, greenColor = "ffffd200", "ffff0000", "ffff9900", "ff00ff00"
			local colorCode

			self:_AddLine(" ")
			self:_AddLine(LEVEL, questLevel)
			self:_AddLine(self.s.REQUIRED_LEVEL, requiredLevel)
			if bitband(statusCode, Grail.bitMaskLevelTooHigh) > 0 then colorCode = redColor elseif bitband(statusCode, Grail.bitMaskAncestorLevelTooHigh) > 0 then colorCode = orangeColor else colorCode = normalColor end
			self:_AddLine("|c"..colorCode..self.s.MAX_LEVEL.."|r", (notToExceedLevel * Grail.bitMaskQuestMaxLevelOffset == Grail.bitMaskQuestMaxLevel) and self.s.MAXIMUM_LEVEL_NONE or notToExceedLevel)

			if "" == questType then questType = self.s.QUEST_TYPE_NORMAL end
			local len = strlen(questType)
			if len > 0 and ' ' == strsub(questType, len, len) then questType = strsub(questType, 1, len - 1) end
			self:_AddLine(TYPE, questType)

			local loremasterString = self.s.MAPAREA_NONE
			local loremasterMapArea = Grail:LoremasterMapArea(questId)
			if nil ~= loremasterMapArea then loremasterString = Grail:MapAreaName(loremasterMapArea) or "UNKNOWN" end
			self:_AddLine(self.s.LOREMASTER_AREA, loremasterString)

			self:_AddLine(" ")
			local factionString = FACTION_OTHER
			if Grail.bitMaskFactionAll == bitband(obtainersCode, Grail.bitMaskFactionAll) then
				factionString = self.s.FACTION_BOTH
			elseif 0 < bitband(obtainersCode, Grail.bitMaskFactionAlliance) then
				factionString = self.s.ALLIANCE
			elseif 0 < bitband(obtainersCode, Grail.bitMaskFactionHorde) then
				factionString = self.s.HORDE
			end
			if bitband(statusCode, Grail.bitMaskFaction) > 0 then colorCode = redColor elseif bitband(statusCode, Grail.bitMaskAncestorFaction) > 0 then colorCode = orangeColor else colorCode = normalColor end
			self:_AddLine("|c"..colorCode..self.s.FACTION.."|r", factionString)

			local classString
			if 0 == bitband(obtainersCode, Grail.bitMaskClassAll) then
				classString = self.s.CLASS_NONE
			elseif Grail.bitMaskClassAll == bitband(obtainersCode, Grail.bitMaskClassAll) then
				classString = self.s.CLASS_ANY
			else
				classString = ""
				for letterCode, bitValue in pairs(Grail.classToBitMapping) do
					if 0 < bitband(obtainersCode, bitValue) then
						local englishName = Grail.classMapping[letterCode]
						local localizedGenderClassName = Grail:CreateClassNameLocalizedGenderized(englishName)
						local classColor = RAID_CLASS_COLORS[englishName]
						classString = classString .. format("|cff%.2x%.2x%.2x%s|r ", classColor.r*255, classColor.g*255, classColor.b*255, localizedGenderClassName)
					end
				end
--				len = strlen(classString)
--				if 0 > len and ' ' == strsub(classString, len, len) then classString = strsub(classString, 1, len - 1) end
				trim(classString)
			end
			if bitband(statusCode, Grail.bitMaskClass) > 0 then colorCode = redColor elseif bitband(statusCode, Grail.bitMaskAncestorClass) > 0 then colorCode = orangeColor else colorCode = normalColor end
			self:_AddLine("|c"..colorCode..CLASS.."|r", classString)

			local genderString = self.s.GENDER_NONE
			if Grail.bitMaskGenderAll == bitband(obtainersCode, Grail.bitMaskGenderAll) then
				genderString = self.s.GENDER_BOTH
			elseif 0 < bitband(obtainersCode, Grail.bitMaskGenderMale) then
				genderString = self.s.MALE
			elseif 0 < bitband(obtainersCode, Grail.bitMaskGenderFemale) then
				genderString = self.s.FEMALE
			end
			if bitband(statusCode, Grail.bitMaskGender) > 0 then colorCode = redColor elseif bitband(statusCode, Grail.bitMaskAncestorGender) > 0 then colorCode = orangeColor else colorCode = normalColor end
			self:_AddLine("|c"..colorCode..self.s.GENDER .."|r", genderString)

			-- Note that race can show races of any faction, especially if the quest is marked just to exclude a specific race
			local raceString
			if 0 == bitband(obtainersCode, Grail.bitMaskRaceAll) then
				raceString = self.s.RACE_NONE
			elseif Grail.bitMaskRaceAll == bitband(obtainersCode, Grail.bitMaskRaceAll) then
				raceString = self.s.RACE_ANY
			else
				raceString = ""
				for letterCode, raceTable in pairs(Grail.races) do
					local bitValue = raceTable[4]
					if 0 < bitband(obtainersCode, bitValue) then
						local englishName = Grail.races[letterCode][1]
						local localizedGenderRaceName = Grail:CreateRaceNameLocalizedGenderized(englishName)
						raceString = raceString .. localizedGenderRaceName .. " "
					end
				end
--				len = strlen(raceString)
--				if 0 > len and ' ' == strsub(raceString, len, len) then raceString = strsub(raceString, 1, len - 1) end
				raceString = trim(raceString)
			end
			if bitband(statusCode, Grail.bitMaskRace) > 0 then colorCode = redColor elseif bitband(statusCode, Grail.bitMaskAncestorRace) > 0 then colorCode = orangeColor else colorCode = normalColor end
			self:_AddLine("|c"..colorCode..RACES.."|r", raceString)

			if 0 ~= holidayCode then
				self:_AddLine(" ")
				if bitband(statusCode, Grail.bitMaskHoliday) > 0 then colorCode = redColor elseif bitband(statusCode, Grail.bitMaskAncestorHoliday) > 0 then colorCode = orangeColor else colorCode = normalColor end
				self:_AddLine("|c"..colorCode..self.s.HOLIDAYS_ONLY.."|r")
				for letterCode, bitValue in pairs(Grail.holidayToBitMapping) do
					if 0 < bitband(holidayCode, bitValue) then
						self:_AddLine(Grail.holidayMapping[letterCode])
					end
				end
			end

--			if Grail.quests[questId]['SP'] then
			if bitband(Grail:CodeType(questId), Grail.bitMaskQuestSpecial) > 0 then
				self:_AddLine(" ")
				self:_AddLine(self.s.SP_MESSAGE)
			end

			if nil ~= Grail.quests[questId]['rep'] then
				self:_AddLine(" ")
				if bitband(statusCode, Grail.bitMaskReputation) > 0 then colorCode = redColor elseif bitband(statusCode, Grail.bitMaskAncestorReputation) > 0 then colorCode = orangeColor else colorCode = normalColor end
				self:_AddLine("|c"..colorCode..self.s.REPUTATION_REQUIRED.."|r")
				for reputationIndex, repTable in pairs(Grail.quests[questId]['rep']) do
					-- repTable can have 'min' and/or 'max'
					local repValue = repTable['min']
					local reputationString
					if nil ~= repValue then
						local _, reputationLevelName = Grail:ReputationNameAndLevelName(reputationIndex, repValue)
						if nil ~= reputationLevelName then
							local exceeds, earnedValue = Grail:_ReputationExceeds(Grail.reputationMapping[reputationIndex], repValue)
							reputationString = format(exceeds and "|cFF00FF00%s|r" or "|cFFFF0000%s|r", reputationLevelName)
							self:_AddLine(Grail.reputationMapping[reputationIndex], reputationString)
						end
					end
					repValue = repTable['max']
					if nil ~= repValue then
						local _, reputationLevelName = Grail:ReputationNameAndLevelName(reputationIndex, repValue)
						if nil ~= reputationLevelName then
							local exceeds, earnedValue = Grail:_ReputationExceeds(Grail.reputationMapping[reputationIndex], repValue)
							reputationString = format(not exceeds and "|cFF00FF00< %s|r" or "|cFFFF0000< %s|r", reputationLevelName)
							self:_AddLine(Grail.reputationMapping[reputationIndex], reputationString)
						end
					end
				end
			end

			-- Just give an indication that there is a Professions failure, but the user will need to look at prerequisites to see which professions.
			if bitband(statusCode, Grail.bitMaskProfession + Grail.bitMaskAncestorProfession) > 0 then
				self:_AddLine(" ")
				if bitband(statusCode, Grail.bitMaskProfession) > 0 then
					colorCode = redColor
				else
					colorCode = orangeColor
				end
				self:_AddLine("|c"..colorCode..self.s.PROFESSIONS..':'.."|r")
			end

			self:_QuestInfoSection(self.s.BREADCRUMB, Grail:QuestBreadcrumbs(questId))

--	At the moment the UI will show both invalidated and breadcrumb invalidated ancestors as orange.
			local breadcrumbColorCode
			if bitband(statusCode, Grail.bitMaskInvalidated) > 0 then
				if Grail:IsInvalidated(questId, true) then	-- still invalid ignoring breadcrumbs
					colorCode = redColor
					breadcrumbColorCode = normalColor
				else
					colorCode = normalColor
					breadcrumbColorCode = redColor
				end
			elseif bitband(statusCode, Grail.bitMaskAncestorInvalidated) > 0 then
				colorCode = orangeColor
				breadcrumbColorCode = orangeColor
			else
				breadcrumbColorCode = normalColor
				colorCode = normalColor
			end
			self:_QuestInfoSection("|c"..breadcrumbColorCode..self.s.IS_BREADCRUMB.."|r", Grail:QuestBreadcrumbsFor(questId))
			self:_QuestInfoSection("|c"..colorCode..self.s.INVALIDATE.."|r", Grail:QuestInvalidates(questId))

			local lastIndexUsed = 0
			if Grail.DisplayableQuestPrerequisites then
				lastIndexUsed = self:_QuestInfoSection(self.s.PREREQUISITES, Grail:DisplayableQuestPrerequisites(questId, true), lastIndexUsed)
			else
				lastIndexUsed = self:_QuestInfoSection(self.s.PREREQUISITES, Grail:QuestPrerequisites(questId, true), lastIndexUsed)
			end

			self:_QuestInfoSection(self.s.OAC, Grail:QuestOnAcceptCompletes(questId))
			self:_QuestInfoSection(self.s.OCC, Grail:QuestOnCompletionCompletes(questId))
			self:_QuestInfoTurninSection(self.s.OTC, Grail:QuestOnTurninCompletes(questId))
			if nil ~= Grail.quests[questId]['AZ'] then
				self:_AddLine(" ")
				if "table" == type(Grail.quests[questId]['AZ']) then
					for _, mapAreaId in pairs(Grail.quests[questId]['AZ']) do
						self:_AddLine(self.s.ENTER_ZONE, Grail:MapAreaName(mapAreaId) or "UNKNOWN")
					end
				else
					self:_AddLine(self.s.ENTER_ZONE, Grail:MapAreaName(Grail.quests[questId]['AZ']) or "UNKNOWN")
				end
			end

--			if nil ~= Grail.quests[questId][6] and 0 < #(Grail.quests[questId][6]) then
			local reputationCodes = Grail.questReputations[questId]
			if nil ~= reputationCodes then
				local reputationCount = strlen(reputationCodes) / 4
				self:_AddLine(" ")
				self:_AddLine(self.s.REPUTATION_CHANGES .. ':')
				local index, value
--				for _, repString in pairs(Grail.quests[questId][6]) do
				for i = 1, reputationCount do
					index, value = Grail:ReputationDecode(strsub(reputationCodes, i * 4 - 3, i * 4))
--				for _, repString in pairs(Grail.questReputations[questId]) do
--					index = strsub(repString, 1, 3)
--					value = tonumber(strsub(repString, 4))
					if value > 0 then
						colorCode = greenColor
					else
						colorCode = redColor
						value = -1 * value
					end
					if WhollyDatabase.showsAllFactionRepuations or Grail:FactionAvailable(index) then
						self:_AddLine(Grail.reputationMapping[index], "|c"..colorCode..value.."|r")
					end
				end
			end

			self:_NPCInfoSection(self.s.WHEN_KILL, Grail:QuestNPCKills(questId), frame, false)

			local possibleNPCs = Grail:QuestNPCPrerequisiteAccepts(questId)
			if nil ~= possibleNPCs then
				self:_NPCInfoSectionPrerequisites(self.s.QUEST_GIVERS..':', possibleNPCs, frame, ('I' ~= frame.statusCode))
			else
				self:_NPCInfoSection(self.s.QUEST_GIVERS..':', Grail:QuestNPCAccepts(questId), frame, ('I' ~= frame.statusCode))
			end

			possibleNPCs = Grail:QuestNPCPrerequisiteTurnins(questId)
			if nil ~= possibleNPCs then
				self:_NPCInfoSectionPrerequisites(self.s.TURN_IN..':', possibleNPCs, frame, ('I' ~= frame.statusCode))
			else
				self:_NPCInfoSection(self.s.TURN_IN..':', Grail:QuestNPCTurnins(questId), frame, ('I' == frame.statusCode))
			end

		end,

		QuestInfoEnter = function(self, frame)
			self:_PopulateTooltipForQuest(frame, self:_BreadcrumbQuestId())
			for i = 1, self.currentTt do
				self.tt[i]:Show()
			end
		end,

		_QuestInfoSection = function(self, heading, tableOrString, lastUsedIndex)
			if nil == tableOrString then return lastUsedIndex end
			local indentation
			if "table" == type(heading) then
				self:_AddLine(heading[1], heading[2])
				indentation = "   "
			else
				self:_AddLine(" ")
				self:_AddLine(heading)
				indentation = ""
			end
			local controlTable = { indentation = indentation, lastIndexUsed = lastIndexUsed, func = self._QuestInfoSectionSupport }
			Grail._ProcessCodeTable(tableOrString, controlTable)
			return controlTable.index
		end,

		_QuestInfoSectionSupport = function(controlTable)
			local self = Wholly
			local WDB = WhollyDatabase
			local innorItem, indentation, index, useIndex2, index2 = controlTable.innorItem, controlTable.indentation, controlTable.index, controlTable.useIndex2, controlTable.pipeIndex
			local commaCount, orIndex, pipeCount, pipeIndex = controlTable.commaCount, controlTable.orIndex, controlTable.pipeCount, controlTable.pipeIndex
--			local index2String = useIndex2 and ("("..index2..")") or ""
			local orString = (0 < commaCount) and "("..orIndex..")" or ""
			local pipeString = (0 < pipeCount) and "("..pipeIndex..")" or ""
			local code, subcode, numeric = Grail:CodeParts(innorItem)
			local classification = Grail:ClassificationOfQuestCode(innorItem, nil, WDB.buggedQuestsConsideredUnobtainable)
			local wSpecial = false
			if 'V' == code or 'W' == code then
				wSpecial, numeric = true, ''
			elseif 'T' == code or 'U' == code then
				local reputationName, reputationLevelName = Grail:ReputationNameAndLevelName(subcode, numeric)
				if 'U' == code then
					reputationLevelName = "< " .. reputationLevelName
				end
				numeric = format("|c%s%s|r", WDB.color[classification], reputationLevelName)
			elseif 'G' == code and Grail.GarrisonBuildingLevelString then
				numeric = Grail:GarrisonBuildingLevelString(numeric)
			end
			self:_AddLine(indentation..orString..pipeString..self:_PrettyQuestString({ innorItem, classification }), numeric)
			if wSpecial then
				local cacheTable = Grail.questStatusCache['G'][subcode]
				if cacheTable then
					for _, questId in pairs(cacheTable) do
						self:_AddLine(indentation.."    "..self:_PrettyQuestString({ questId, Grail:ClassificationOfQuestCode(questId, nil, WDB.buggedQuestsConsideredUnobtainable) }), questId)
					end
				else
					print("Grail error because no group quest cache for prerequisite code", innorItem)
				end
			end
		end,

		_QuestInfoTurninSection = function(self, heading, table)
			if nil == table then return end
			self:_AddLine(" ")
			self:_AddLine(heading)
			for key, value in pairs(table) do
				if "table" == type(value) and 2 == #value then
					self:_AddLine(Grail:NPCName(value[1]), self:_PrettyQuestString({ value[2], Grail:ClassificationOfQuestCode(value[2], nil, WhollyDatabase.buggedQuestsConsideredUnobtainable) }).." "..value[2])
				else
					self:_AddLine("Internal Error with OTC: ", value)
				end
			end
		end,

		_QuestName = function(self, questId)
			return Grail:QuestName(questId) or "NO NAME"
		end,

		_QuestTypeString = function(self, questId)
			local retval = ""
			local bitValue = Grail:CodeType(questId)
			if bitValue > 0 then
				if bitband(bitValue, Grail.bitMaskQuestRepeatable) > 0 then retval = retval .. self.s.REPEATABLE .. " " end
				if bitband(bitValue, Grail.bitMaskQuestDaily) > 0 then retval = retval .. self.s.DAILY .. " " end
				if bitband(bitValue, Grail.bitMaskQuestWeekly) > 0 then retval = retval .. self.s.WEEKLY .. " " end
				if bitband(bitValue, Grail.bitMaskQuestMonthly) > 0 then retval = retval .. self.s.MONTHLY .. " " end
				if bitband(bitValue, Grail.bitMaskQuestYearly) > 0 then retval = retval .. self.s.YEARLY .. " " end
				if bitband(bitValue, Grail.bitMaskQuestEscort) > 0 then retval = retval .. self.s.ESCORT .. " " end
				if bitband(bitValue, Grail.bitMaskQuestDungeon) > 0 then retval = retval .. self.s.DUNGEON .. " " end
				if bitband(bitValue, Grail.bitMaskQuestRaid) > 0 then retval = retval .. self.s.RAID .. " " end
				if bitband(bitValue, Grail.bitMaskQuestPVP) > 0 then retval = retval .. self.s.PVP .. " " end
				if bitband(bitValue, Grail.bitMaskQuestGroup) > 0 then retval = retval .. self.s.GROUP .. " " end
				if bitband(bitValue, Grail.bitMaskQuestHeroic) > 0 then retval = retval .. self.s.HEROIC .. " " end
				if bitband(bitValue, Grail.bitMaskQuestScenario) > 0 then retval = retval .. self.s.SCENARIO .. " " end
				if bitband(bitValue, Grail.bitMaskQuestLegendary) > 0 then retval = retval .. self.s.LEGENDARY .. " " end
				if Grail.bitMaskQuestAccountWide and bitband(bitValue, Grail.bitMaskQuestAccountWide) > 0 then retval = retval .. self.s.ACCOUNT .. " " end
			end
			return trim(retval)
		end,

		--	This records into the npcs table all those NPCs whose tooltips need to be augmented with quest information for the provided mapId.
		_RecordTooltipNPCs = function(self, mapId)
			local questsInMap = self:_ClassifyQuestsInMap(mapId) or {}
			local questId, locations

			for i = 1, #questsInMap do
				questId = questsInMap[i][1]
				locations = Grail:QuestLocationsAccept(questId, false, false, true, mapId, true)
				if nil ~= locations then
					for _, npc in pairs(locations) do
						local xcoord, ycoord, npcName, npcId = npc.x, npc.y, npc.name, npc.id
						if nil ~= xcoord then
							-- record the NPC as needing a tooltip note for the specific quest (it can be a redirect because an actual "NPC" may be the item that starts the quest)
							local shouldProcess, kindsOfNPC = Grail:IsTooltipNPC(npcId)
							if shouldProcess then
								for i = 1, #(kindsOfNPC), 1 do
									local npcIdToUse = npcId
									local shouldAdd = true
									if kindsOfNPC[i][1] == Grail.NPC_TYPE_DROP then
										shouldAdd = self:_DroppedItemMatchesQuest(kindsOfNPC[i][2], questId)
									end
									if kindsOfNPC[i][1] == Grail.NPC_TYPE_BY then npcIdToUse = tonumber(kindsOfNPC[i][2]) end
									if nil == self.npcs[npcIdToUse] then self.npcs[npcIdToUse] = {} end
									if shouldAdd and not tContains(self.npcs[npcIdToUse], questId) then tinsert(self.npcs[npcIdToUse], questId) end
								end
							end
						end
					end
				end
			end
			self.checkedNPCs[mapId] = true
		end,

		--	This walks through the persistent information about groups of waypoints and reinstates
		--	them since our directional arrows we do not have TomTom make persistent.
		_ReinstateDirectionalArrows = function(self)
			local WDB = WhollyDatabase
			if nil == WDB.waypointGrouping then return end
			for groupNumber, t in pairs(WDB.waypointGrouping) do
				if 0 == #t then
					WDB.waypointGrouping[groupNumber] = nil
				else
					local t1 = {}
					local npcType = 'A'
					local codeLen
					for _, code in pairs(t) do
						codeLen = strlen(code)
						tinsert(t1, strsub(code, 1, codeLen - 1))
						npcType = strsub(code, codeLen, codeLen)
					end
					self:_AddDirectionalArrows(t1, npcType, groupNumber)
				end
			end
		end,

		_RemoveAllDirectionalArrows = function(self)
			for code, t in pairs(self.waypoints) do
				WhollyDatabase.waypointGrouping[t.grouping] = nil
			end
			self.waypoints = {}
		end,

		--	This uses the TomTom sense of uid to remove that waypoint and any others that were added
		--	in the same grouping of waypoints.
		_RemoveDirectionalArrows = function(self, uid)
			local foundGrouping = nil
			local WDB = WhollyDatabase
			local TomTom = TomTom

			for code, t in pairs(self.waypoints) do
				if tContains(t.uids, uid) then
					foundGrouping = t.grouping
				end
			end
			if nil ~= foundGrouping then
				for _, code in pairs(WDB.waypointGrouping[foundGrouping]) do
					for _, uid in pairs(Wholly.waypoints[code].uids) do
						self.removeWaypointFunction(TomTom, uid)
					end
				end
				WDB.waypointGrouping[foundGrouping] = nil
			end
		end,

		_ResetColors = function(self)
			local WDB = WhollyDatabase
			WDB.color = {}
			for code, colorCode in pairs(self.color) do
				WDB.color[code] = colorCode
			end
			self:_ColorUpdateAllPreferenceText()
		end,

		ScrollFrame_OnLoad = function(self, frame)
			HybridScrollFrame_OnLoad(frame)
			frame.update = Wholly.ScrollFrame_Update_WithCombatCheck
			HybridScrollFrame_CreateButtons(frame, "com_mithrandir_whollyButtonTemplate")
		end,

		ScrollFrameOne_OnLoad = function(self, frame)
			HybridScrollFrame_OnLoad(frame)
			frame.update = Wholly.ScrollFrameOne_Update
			HybridScrollFrame_CreateButtons(frame, "com_mithrandir_whollyButtonOneTemplate")
		end,

		ScrollFrameTwo_OnLoad = function(self, frame)
			HybridScrollFrame_OnLoad(frame)
			frame.update = Wholly.ScrollFrameTwo_Update
			HybridScrollFrame_CreateButtons(frame, "com_mithrandir_whollyButtonTwoTemplate")
		end,

		ScrollFrame_Update_WithCombatCheck = function(self)
			if not InCombatLockdown() then
				Wholly:ScrollFrame_Update()
			else
				com_mithrandir_whollyFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
			end
		end,

		ScrollFrameOne_Update = function(self)
--			self = self or Wholly
			self = Wholly
			self:ScrollFrameGeneral_Update(self.levelOneData, com_mithrandir_whollyFrameWideScrollOneFrame)
		end,

		ScrollFrameTwo_Update = function(self)
--			self = self or Wholly
			self = Wholly
			self:_InitializeLevelTwoData()
			self:ScrollFrameGeneral_Update(self.levelTwoData, com_mithrandir_whollyFrameWideScrollTwoFrame)
		end,

		_SearchFrameShow = function(self, reallyTags)
			com_mithrandir_whollySearchFrame.processingTags = reallyTags
			local titleToUse = reallyTags and self.s.TAGS_NEW or SEARCH
			com_mithrandir_whollySearchFrameTitle:SetText(titleToUse)
			com_mithrandir_whollySearchFrame:Show()
		end,

		SetupScrollFrameButton = function(self, buttonIndex, numButtons, buttons, shownEntries, scrollOffset, item, isHeader, indent, scrollFrame)
			if shownEntries > scrollOffset and buttonIndex <= numButtons then
				local button = buttons[buttonIndex]
				local indentation = indent and "    " or ""
				button.normalText:SetText(indentation .. item.displayName)
				button.tag:SetText(self.cachedMapCounts[item.mapID])
				if WhollyDatabase.showQuestCounts then
					button.tag:Show()
				else
					button.tag:Hide()
				end
				if isHeader then
					if WhollyDatabase.closedHeaders[item.header] then
						button:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up")
					else
						button:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up")
					end
				else
					button:SetNormalTexture("")
				end
				button.item = item
				local f
				if scrollFrame == com_mithrandir_whollyFrameWideScrollOneFrame then
					f = com_mithrandir_whollyFrameWideScrollOneFrameLogHighlightFrame
				else
					f = com_mithrandir_whollyFrameWideScrollTwoFrameLogHighlightFrame
				end
				if item.selected then
					f:SetParent(button)
					f:SetPoint("TOPLEFT", button, "TOPLEFT", 0, 0)
					f:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0, 0)
					f:Show()
				else
					if f:GetParent() == button then
						f:Hide()
					end
				end
				button:Show()
				buttonIndex = buttonIndex + 1
			end
			return buttonIndex
		end,

		--	This technique uses marching through the data to update the buttons.
		--	This is done because some of our data may be closed, and in any case any of the headings
		--	that are open need to be processed differently.
		ScrollFrameGeneral_Update = function(self, items, frame)
			local numEntries = items and #items or 0
			local shownEntries = 0
			local buttons = frame.buttons
			local numButtons = #buttons
			local scrollOffset = HybridScrollFrame_GetOffset(frame)
			local buttonHeight = buttons[1]:GetHeight()
			local button, itemIndex
			local buttonIndex = 1

			--	Go through the data and put it into the buttons based on where the scrolling is within
			--	the data, and based on what headers are open or closed.
			for i = 1, numEntries do
				if items[i].header then		-- a header
					shownEntries = shownEntries + 1
					buttonIndex = self:SetupScrollFrameButton(buttonIndex, numButtons, buttons, shownEntries, scrollOffset, items[i], true, false, frame)
					if not WhollyDatabase.closedHeaders[items[i].header] then
						for j = 1, #(items[i].children) do
							shownEntries = shownEntries + 1
							buttonIndex = self:SetupScrollFrameButton(buttonIndex, numButtons, buttons, shownEntries, scrollOffset, items[i].children[j], false, true, frame)
						end
					end
				else						-- a normal entry
					shownEntries = shownEntries + 1
					buttonIndex = self:SetupScrollFrameButton(buttonIndex, numButtons, buttons, shownEntries, scrollOffset, items[i], false, false, frame)
				end
				
			end

			--	Now any remaining buttons in the UI should be hidden
			for i = buttonIndex, numButtons do
				buttons[i]:Hide()
			end

			--	How have the scroll frame update itself
			HybridScrollFrame_Update(frame, shownEntries * buttonHeight, numButtons * buttonHeight)
		end,

		ScrollFrame_Update = function(self)
			self = self or Wholly
			self:_FilterPanelQuests()
			local questsInMap = self.filteredPanelQuests
			local numEntries = #questsInMap
			local buttons = com_mithrandir_whollyFrameScrollFrame.buttons
			local numButtons = #buttons
			local scrollOffset = HybridScrollFrame_GetOffset(com_mithrandir_whollyFrameScrollFrame)
			local buttonHeight = buttons[1]:GetHeight();
			local button, questIndex, questId, questLevelString, requiredLevelString, colorCode, questLevel, filterCode, repeatableCompletedString
			local shouldShowTag

			tablesort(questsInMap, Wholly.SortingFunction)
			for i = 1, numButtons do
				button = buttons[i]
				questIndex = i + scrollOffset
				if questIndex <= numEntries then
					questId = questsInMap[questIndex][1]
					filterCode = questsInMap[questIndex][2]
					button.normalText:SetText(self:_PrettyQuestString(questsInMap[questIndex]))
					shouldShowTag = false
					if 'I' == filterCode and WhollyDatabase.showsInLogQuestStatus and WhollyDatabase.showsQuestsInLog then
						local questStatus = Grail:StatusCode(questId)
						local statusText = nil
						shouldShowTag = true
						if bitband(questStatus, Grail.bitMaskInLogComplete) > 0 then statusText = self.s.COMPLETE
						elseif bitband(questStatus, Grail.bitMaskInLogFailed) > 0 then statusText = self.s.FAILED
						else shouldShowTag = false
						end
						if nil ~= statusText then
							button.tag:SetText("(" .. statusText .. ")")
						end
					end
					if not shouldShowTag and self:_IsIgnoredQuest(questId) then
						button.tag:SetText("[" .. self.s.IGNORED .. "]")
						shouldShowTag = true
					end
					if shouldShowTag then button.tag:Show() else button.tag:Hide() end
					button.questId = questId
					button.statusCode = filterCode
					button:Show()
				else
					button:Hide()
				end
			end
			HybridScrollFrame_Update(com_mithrandir_whollyFrameScrollFrame, numEntries * buttonHeight, numButtons * buttonHeight)
		end,

		ScrollOneClick = function(self, button)
			if button.item.header then
				local which = button.item.header
				if WhollyDatabase.closedHeaders[which] then
					WhollyDatabase.closedHeaders[which] = nil
				else
					WhollyDatabase.closedHeaders[which] = true
				end
				self:ScrollFrameOne_Update()
			else
				if self.levelOneCurrent ~= button.item then
					self.zoneInfo.panel.mapId = nil
					self:_SetLevelTwoCurrent(nil)
					self:_ForcePanelMapArea(true)
				end
				self:_SetLevelOneCurrent(button.item)
				self:ScrollFrameOne_Update()
				self:ScrollFrameTwo_Update()
			end
		end,

		ScrollTwoClick = function(self, button)
			self:_SetLevelTwoCurrent(button.item)
			if button.item.f then
				button.item.f()
			else
				self.zoneInfo.panel.mapId = button.item.mapID
				self.zoneInfo.panel.dungeonLevel = 0
				self:_ForcePanelMapArea(true)
			end
			self:ScrollFrameTwo_Update()	-- to update selection
		end,

		SearchEntered = function(self)
			local searchText = com_mithrandir_whollySearchEditBox:GetText()
			com_mithrandir_whollySearchEditBox:SetText("")
			com_mithrandir_whollySearchFrame:Hide()

			-- Remove leading and trailing whitespace
			searchText = trim(searchText)

			if searchText and "" ~= searchText then
				if com_mithrandir_whollySearchFrame.processingTags then
					WhollyDatabase.tags = WhollyDatabase.tags or {}
					WhollyDatabase.tags[searchText] = WhollyDatabase.tags[searchText] or {}
				else
					if nil == WhollyDatabase.searches then WhollyDatabase.searches = {} end
					tinsert(WhollyDatabase.searches, searchText)
					if #(WhollyDatabase.searches) > self.maximumSearchHistory then
						tremove(WhollyDatabase.searches, 1)
					end
					self:SearchForQuestNamesMatching(searchText)
					self.zoneInfo.panel.mapId = 0
					self.justAddedSearch = true
				end
				self:_ForcePanelMapArea(true)
				self:ScrollFrameTwo_Update()
			end
		end,

		SearchForAllQuests = function(self)
			Grail:SetMapAreaQuests(0, SEARCH .. ' ' .. Wholly.s.SEARCH_ALL_QUESTS, Grail.questNames, true)
--			Grail.indexedQuests[0] = {}
--			Grail.mapAreaMapping[0] = SEARCH .. ' ' .. Wholly.s.SEARCH_ALL_QUESTS
--			for q, v in pairs(Grail.questNames) do
--				Grail:AddQuestToMapArea(q, 0)
--			end
		end,

		SearchForQuestNamesMatching = function(self, searchTerm)
			-- the searchTerm is broken up by spaces which are considered AND conditions
			local terms = { strsplit(" ", searchTerm) }
			local results = {}
			local started = false
			for i = 1, #terms do
				if terms[i] ~= "" then
					if not started then
						for qid, questName in pairs(Grail.questNames) do
							if strfind(questName, terms[i]) then tinsert(results, qid) end
						end
						started = true
					else
						local newResults = {}
						for _, q in pairs(results) do
							if strfind(Grail.questNames[q], terms[i]) then tinsert(newResults, q) end
						end
						results = newResults
					end
				end
			end
			-- clear the mapArea 0 because that is what we use for computed results
			Grail:SetMapAreaQuests(0, SEARCH .. ': ' .. searchTerm, results)
--			Grail.indexedQuests[0] = {}
--			Grail.mapAreaMapping[0] = SEARCH .. ': ' .. searchTerm
--			for _, q in pairs(results) do
--				Grail:AddQuestToMapArea(q, 0)
--			end
		end,

		SearchForQuestsWithTag = function(self, tagName)
			local results = {}
			local questId
			if WhollyDatabase.tags then
				for k, v in pairs(WhollyDatabase.tags[tagName]) do
					for i = 0, 31 do
						if bitband(v, 2^i) > 0 then
							questId = k * 32 + i + 1
							if not tContains(results, questId) then tinsert(results, questId) end
						end
					end
				end
			end
			Grail:SetMapAreaQuests(0, Wholly.s.TAGS .. ': ' .. tagName, results)
--			Grail.indexedQuests[0] = {}
--			Grail.mapAreaMapping[0] = Wholly.s.TAGS .. ': ' .. tagName
--			for _, q in pairs(results) do
--				Grail:AddQuestToMapArea(q, 0)
--			end
		end,

		-- This is really setting to the current map
		SetCurrentMapToPanel = function(self, frame)		-- called by pressing the Zone button in the UI
			self:UpdateQuestCaches(false, false, true)
			self:ZoneButtonEnter(frame)	-- need to update the tooltip which is showing
		end,

		SetCurrentZoneToPanel = function(self, frame)
			self:UpdateQuestCaches(false, false, true, true)
		end,

		_SetLevelOneCurrent = function(self, newValue)
			if self.levelOneCurrent ~= newValue then
				if self.levelOneCurrent ~= nil then
					self.levelOneCurrent.selected = nil
				end
				self.levelOneCurrent = newValue
				if newValue ~= nil then
					newValue.selected = true
				end
			end
		end,

		_SetLevelTwoCurrent = function(self, newValue)
			if self.levelTwoCurrent ~= newValue then
				if self.levelTwoCurrent ~= nil then
					self.levelTwoCurrent.selected = nil
				end
				self.levelTwoCurrent = newValue
				if newValue ~= nil then
					newValue.selected = true
				end
			end
		end,

		ShowBreadcrumbInfo = function(self)
			local questId = self:_BreadcrumbQuestId()
			local breadcrumbs = Grail:AvailableBreadcrumbs(questId)
			com_mithrandir_whollyBreadcrumbFrame:Hide()
			com_mithrandir_whollyQuestInfoFrameText:SetText(questId)
			self:UpdateBuggedText(questId)
			if nil ~= breadcrumbs then
				if 1 == #breadcrumbs then com_mithrandir_whollyBreadcrumbFrameMessage:SetText(self.s.SINGLE_BREADCRUMB_FORMAT)
				else com_mithrandir_whollyBreadcrumbFrameMessage:SetText(format(self.s.MULTIPLE_BREADCRUMB_FORMAT, #breadcrumbs))
				end
				com_mithrandir_whollyBreadcrumbFrame:Show()
			end
		end,

		ShowPin = function(self, questTable)
			local codeMapping = { ['G'] = 1, ['W'] = 2, ['D'] = 3, ['R'] = 4, ['K'] = 5, ['H'] = 6, ['Y'] = 7, ['P'] = 8, ['L'] = 9, ['U'] = 10 }
			local id = questTable[1]
			local code = questTable[2]
			if 'D' == code and Grail:IsRepeatable(id) then code = 'R' end
			local codeValue = codeMapping[code]					
			local locations = Grail:QuestLocationsAccept(id, false, false, true, self.zoneInfo.pins.mapId, true, self.zoneInfo.pins.dungeonLevel)
			if nil ~= locations then
				for _, npc in pairs(locations) do
					local xcoord, ycoord, npcName, npcId = npc.x, npc.y, npc.name, npc.id
					if nil ~= xcoord then

						if not self.checkingNPCTechniqueNew then
							-- record the NPC as needing a tooltip note for the specific quest (it can be a redirect because an actual "NPC" may be the item that starts the quest)
							local shouldProcess, kindsOfNPC = Grail:IsTooltipNPC(npcId)
							if shouldProcess then
								for i = 1, #(kindsOfNPC), 1 do
									local npcIdToUse = npcId
									local shouldAdd = true
									if kindsOfNPC[i][1] == Grail.NPC_TYPE_DROP then
										shouldAdd = self:_DroppedItemMatchesQuest(kindsOfNPC[i][2], id)
									end
									if kindsOfNPC[i][1] == Grail.NPC_TYPE_BY then npcIdToUse = tonumber(kindsOfNPC[i][2]) end
									if nil == self.npcs[npcIdToUse] then self.npcs[npcIdToUse] = {} end
									if shouldAdd and not tContains(self.npcs[npcIdToUse], id) then tinsert(self.npcs[npcIdToUse], id) end
								end
							end
						end

						for index, frame in pairs(self.supportedMaps) do
							if frame then
								local pin = self:_GetPin(npcId, frame)
								local pinValue = codeMapping[pin.texType]
								if codeValue < pinValue then
									pin:SetType(code)
								end						
								pin:ClearAllPoints()
								pin.questId = id
								if frame ~= NxMap1 then
									local baseFrameLevel = self.supportedPOIMaps[index]:GetFrameLevel()
									local releaseDelta = (Grail.blizzardRelease < 18505) and -1 or 1
									local pinTypeDelta = (pin.texType == 'G' or pin.texType == 'W') and 1 or 0
									pin:SetFrameLevel(baseFrameLevel + releaseDelta + pinTypeDelta)
									pin:SetPoint("CENTER", frame, "TOPLEFT", xcoord/100*frame:GetWidth(), -ycoord/100*frame:GetHeight())
									pin:Show()
								else
									Nx.MapAddIcon(pin.questId, self.zoneInfo.pins.mapId, xcoord, ycoord, nil, pin)	-- requires modified Carbonite to work properly
								end

								self.pins[frame]["ids"][id..":"..npcId] = pin
							end
						end
					end
				end
			end
		end,

		ShowTooltip = function(self, pin)
			local WDB = WhollyDatabase
			local listedQuests = {}
			self.tooltip:SetOwner(pin, "ANCHOR_RIGHT")
			self.tooltip:ClearLines()

			local parentFrame = pin:GetParent()
			-- find all quests in range of hover
			local mx, my = self:_GetMousePosition(parentFrame)
			local npcList = {}
			local npcNames = {}

			local questsInMap = self.filteredPinQuests
			local questId
			for i = 1, #questsInMap do
				questId = questsInMap[i][1]
				local locations = Grail:QuestLocationsAccept(questId, false, false, true, self.zoneInfo.pins.mapId, true, self.zoneInfo.pins.dungeonLevel)
				if nil ~= locations then
					for _, npc in pairs(locations) do
						if nil ~= npc.x then
							local dist = self:_Distance(parentFrame, mx, my, npc.x/100, npc.y/100)
							if dist <= 0.02 or (NxMap1 == parentFrame and npc.id == pin.npcId) then
								if not npcList[npc.id] then
									npcList[npc.id] = {}
									local nameToUse = npc.name
									if npc.dropName then
										nameToUse = nameToUse .. " (" .. npc.dropName .. ')'
									end
									npcNames[npc.id] = self:_PrettyNPCString(nameToUse, npc.kill, npc.realArea)
								end
								tinsert(npcList[npc.id], questsInMap[i])
							end
						end
					end
				end
			end

			local first = true
			for npc, questList in pairs(npcList) do
				if not first then
					self.tooltip:AddLine(" ")
				else
					first = false
				end
				for _, qt in ipairs(questList) do
					local leftStr = self:_PrettyQuestString(qt)
					local q = qt[1]
					local rightStr = self:_QuestTypeString(q)
					if strlen(rightStr) > 0 then rightStr = format("|c%s%s|r", WDB.color[qt[2]], rightStr) end

					-- check if already printed - this is for spam quests like the human starting area that haven't been labeled correctly
					if not questName or not listedQuests[questName] then
						self.tooltip:AddDoubleLine(leftStr, rightStr)
						self.tooltip:SetLastFont(self.tooltip.large)
						self.tooltip:SetLastFont(self.tooltip.small, true)
						if questName then listedQuests[questName] = true end
					end
				end
				self.tooltip:AddLine(npcNames[npc], 1, 1, 1, 1)
				self.tooltip:SetLastFont(self.tooltip.small)
			end
	
			self.tooltip:Show();
		end,

		SlashCommand = function(self, frame, msg)
			self:ToggleUI()
		end,

		Sort = function(self, frame)
			-- This is supposed to cycle through the supported sorting techniques and make the contents of the panel
			-- show the quests based on those techniques.
			-- 1 Quest alphabetical
			-- 2 Quest level (and then alphabetical)
			-- 3 Quest level, then type, then alphabetical
			-- 4 Quest type (and then alphabetical)
			-- 5 Quest type, then level, then alphabetical
			WhollyDatabase.currentSortingMode = WhollyDatabase.currentSortingMode + 1
			if (WhollyDatabase.currentSortingMode > 5) then WhollyDatabase.currentSortingMode = 1 end
			self:ScrollFrame_Update_WithCombatCheck()
			self:SortButtonEnter(frame)	-- to update the tooltip with the new sorting info
		end,

		SortButtonEnter = function(self, frame)
			local sortModes = {
				[1] = self.s.ALPHABETICAL,
				[2] = self.s.LEVEL..", "..self.s.ALPHABETICAL,
				[3] = self.s.LEVEL..", "..self.s.TYPE..", "..self.s.ALPHABETICAL,
				[4] = self.s.TYPE..", "..self.s.ALPHABETICAL,
				[5] = self.s.TYPE..", "..self.s.LEVEL..", "..self.s.ALPHABETICAL,
				}
			GameTooltip:ClearLines()
			GameTooltip:SetOwner(frame, "ANCHOR_RIGHT")
			GameTooltip:AddLine(sortModes[WhollyDatabase.currentSortingMode])
			GameTooltip:Show()
			GameTooltip:ClearAllPoints()
		end,

		SortingFunction = function(a, b)
			local retval = false
			if 1 == WhollyDatabase.currentSortingMode then
				retval = Wholly:_QuestName(a[1]) < Wholly:_QuestName(b[1])
			elseif 2 == WhollyDatabase.currentSortingMode then
				local aLevel, bLevel = Grail:QuestLevel(a[1]) or 1, Grail:QuestLevel(b[1]) or 1
				if aLevel == bLevel then
					retval = Wholly:_QuestName(a[1]) < Wholly:_QuestName(b[1])
				else
					retval = aLevel < bLevel
				end
			elseif 3 == WhollyDatabase.currentSortingMode then
				local aLevel, bLevel = Grail:QuestLevel(a[1]) or 1, Grail:QuestLevel(b[1]) or 1
				if aLevel == bLevel then
					local aCode, bCode = a[2], b[2]
					if aCode == bCode then
						retval = Wholly:_QuestName(a[1]) < Wholly:_QuestName(b[1])
					else
						retval = aCode < bCode
					end
				else
					retval = aLevel < bLevel
				end
			elseif 4 == WhollyDatabase.currentSortingMode then
				local aCode, bCode = a[2], b[2]
				if aCode == bCode then
					retval = Wholly:_QuestName(a[1]) < Wholly:_QuestName(b[1])
				else
					retval = aCode < bCode
				end
			elseif 5 == WhollyDatabase.currentSortingMode then
				local aCode, bCode = a[2], b[2]
				if aCode == bCode then
					local aLevel, bLevel = Grail:QuestLevel(a[1]) or 1, Grail:QuestLevel(b[1]) or 1
					if aLevel == bLevel then
						retval = Wholly:_QuestName(a[1]) < Wholly:_QuestName(b[1])
					else
						retval = aLevel < bLevel
					end
				else
					retval = aCode < bCode
				end
			end
			return retval
		end,

		_TagDelete = function(self)
			local menu = {}
			local menuItem
			if WhollyDatabase.tags then
				for tagName, questTable in pairs(WhollyDatabase.tags) do
					menuItem = { text = tagName, isNotRadio = true }
					menuItem.func = function(self, arg1, arg2, checked) Wholly:_TagDeleteConfirm(tagName) end
					tinsert(menu, menuItem)
				end
			end
 			tablesort(menu, function(a, b) return a.text < b.text end)
			tinsert(menu, 1, { text = Wholly.s.TAGS_DELETE, isTitle = true })
			EasyMenu(menu, self.easyMenuFrame, self.easyMenuFrame, 0, 0, "MENU")
		end,

		_TagDeleteConfirm = function(self, tagName)
			local dialog = StaticPopup_Show("com_mithrandir_whollyTagDelete", tagName)
			if dialog then dialog.data = tagName end
		end,

		_TagProcess = function(self, questId)
			local menu = {}
			local menuItem
			if WhollyDatabase.tags then
				for tagName, questTable in pairs(WhollyDatabase.tags) do
					menuItem = { text = tagName, isNotRadio = true }
					menuItem.checked = Grail:_IsQuestMarkedInDatabase(questId, questTable)
					menuItem.func = function(self, arg1, arg2, checked) Grail:_MarkQuestInDatabase(questId, WhollyDatabase.tags[tagName], checked) if Wholly.levelOneCurrent.index == 74 and Wholly.levelTwoCurrent.sortName == tagName then Wholly.SearchForQuestsWithTag(Wholly, tagName) Wholly.zoneInfo.panel.mapId = 0 Wholly._ForcePanelMapArea(Wholly, true) end end
					tinsert(menu, menuItem)
				end
			end
 			tablesort(menu, function(a, b) return a.text < b.text end)
			tinsert(menu, 1, { text = Wholly.s.TAGS .. ": " .. self:_QuestName(questId), isTitle = true })
			EasyMenu(menu, self.easyMenuFrame, self.easyMenuFrame, 0, 0, "MENU")
		end,

		ToggleCurrentFrame = function(self)
			local isShowing = self.currentFrame:IsShown()
			local x, y
			if isShowing then
				self.currentFrame:Hide()	-- Hide the current frame before we manipulate
			end
			if com_mithrandir_whollyFrame == self.currentFrame then
				self.currentFrame = com_mithrandir_whollyFrameWide
				x, y = 348, -75
			else
				self.currentFrame = com_mithrandir_whollyFrame
				x, y = 19, -75
			end
			self.toggleButton:ClearAllPoints()
			self.toggleButton:SetParent(self.currentFrame)
			com_mithrandir_whollyFrameScrollFrame:ClearAllPoints()
			com_mithrandir_whollyFrameScrollFrame:SetParent(self.currentFrame)
			com_mithrandir_whollyFrameScrollFrame:SetPoint("TOPLEFT", self.currentFrame, "TOPLEFT", x, y)
			if isShowing then
				self.currentFrame:Show()
			end
			com_mithrandir_whollySearchFrame:ClearAllPoints()
			com_mithrandir_whollySearchFrame:SetParent(self.currentFrame)
			com_mithrandir_whollySearchFrame:SetPoint("BOTTOMLEFT", self.currentFrame, "TOPLEFT", 64, -14)
			self.easyMenuFrame:ClearAllPoints()
			self.easyMenuFrame:SetParent(self.currentFrame)
			self.easyMenuFrame:SetPoint("LEFT", self.currentFrame, "RIGHT")
		end,

		ToggleIgnoredQuest = function(self)
			local desiredQuestId = self.clickingButton.questId
			Grail:_MarkQuestInDatabase(desiredQuestId, WhollyDatabase.ignoredQuests, self:_IsIgnoredQuest(desiredQuestId))
		end,

		ToggleLightHeaded = function(self)
			local desiredQuestId = self.clickingButton.questId
			if LightHeadedFrame:IsVisible() and LightHeadedFrameSub.qid == desiredQuestId then LightHeadedFrame:Hide() return end
			LightHeadedFrame:ClearAllPoints()
			LightHeadedFrame:SetParent(self.currentFrame)
			-- default to attaching on the right side
			local lhSide, whollySide, x, y = "LEFT", "RIGHT", -39, 31
			if self.currentFrame == com_mithrandir_whollyFrameWide then
				x = -8
				y = 0
			end
			LightHeadedFrame:SetPoint(lhSide, self.currentFrame, whollySide, x, y)
			LightHeadedFrame:Show()
			LightHeaded:UpdateFrame(desiredQuestId, 1)
		end,

		ToggleSwitch = function(self, key)
			local button = self.preferenceButtons[key]
			if nil ~= button then
				button:Click()
			end
		end,

		ToggleUI = function(self)
			if not self.currentFrame then print(format(self.s.REQUIRES_FORMAT, requiredGrailVersion)) return end
			if not InCombatLockdown() then
				if self.currentFrame:IsShown() then
					self.currentFrame:Hide()
				else
					self.currentFrame:Show()
				end
			end
		end,

		---
		--	Sets up the event monitoring to handle those associated with displaying breadcrumb information.
		UpdateBreadcrumb = function(self)
			if WhollyDatabase.displaysBreadcrumbs then
				self.notificationFrame:RegisterEvent("QUEST_DETAIL")
				if QuestFrame:IsVisible() then
					self:ShowBreadcrumbInfo()
				end
			else
				self.notificationFrame:UnregisterEvent("QUEST_DETAIL")
				com_mithrandir_whollyBreadcrumbFrame:Hide()
			end
		end,

		UpdateBuggedText = function(self, questId)
			local bugged = Grail:IsBugged(questId)
			if bugged then
				com_mithrandir_whollyQuestInfoBuggedFrameText:SetText(self.s.BUGGED)
			else
				com_mithrandir_whollyQuestInfoBuggedFrameText:SetText("")
			end
		end,

		UpdateCoordinateSystem = function(self)
			if WhollyDatabase.enablesPlayerCoordinates then
				self.notificationFrame:SetScript("OnUpdate", function(frame, ...) self:_OnUpdate(frame, ...) end)
			else
				self.notificationFrame:SetScript("OnUpdate", nil)
				if nil ~= self.coordinates then
					self.coordinates.text = ""
				end
				self.previousX = 0
			end
		end,

		_UpdatePins = function(self, forceUpdate)

			--	Set the current mapId to be something it cannot be normally to force an update
			if forceUpdate then
				self.zoneInfo.pins.mapId = -123
			end

			--	Only do work if the world map is visible
			local mapWeSupportIsVisible = false
			for _, frame in pairs(self.supportedControlMaps) do
				if frame and frame:IsVisible() then
					mapWeSupportIsVisible = true
					break
				end
			end
			if mapWeSupportIsVisible then

				local pinsShouldBeReclassified = (self.zoneInfo.pins.mapId ~= self.zoneInfo.map.mapId) or (self.zoneInfo.pins.dungeonLevel ~= self.zoneInfo.map.dungeonLevel)

				--	If we are not displaying pins or if anything has changed since we last displayed
				--	pins, we need to hide (remove from the map) all the current pins.
				if not WhollyDatabase.displaysMapPins or pinsShouldBeReclassified or self.pinsNeedFiltering then
					self:_HideAllPins()
				end

				--	If we are displaying pins and something has changed since we last displayed
				--	pins, we need to display all the current pins.
				if WhollyDatabase.displaysMapPins and (pinsShouldBeReclassified or self.pinsNeedFiltering or self.pinsDisplayedLast ~= WhollyDatabase.displaysMapPins) then
					self.zoneInfo.pins.mapId = self.zoneInfo.map.mapId
					self.zoneInfo.pins.dungeonLevel = self.zoneInfo.map.dungeonLevel
					if pinsShouldBeReclassified then
						self.cachedPinQuests = self:_ClassifyQuestsInMap(self.zoneInfo.pins.mapId) or {}
					end
					self:_FilterPinQuests()
					self.pinsNeedFiltering = false
					local questsInMap = self.filteredPinQuests
					for i = 1, #questsInMap do
						self:ShowPin(questsInMap[i])
					end
				else
					self.mapCountLine = ""		-- do not display a tooltip for pins we are not showing
				end

				self.pinsDisplayedLast = WhollyDatabase.displaysMapPins

			end

		end,

		UpdateQuestCaches = function(self, forceUpdate, setPinMap, setPanelMap, useCurrentZone)
			if not Grail:IsPrimed() then return end
			local masterTable = useCurrentZone and self.zoneInfo.zone or self.zoneInfo.map
			if masterTable.mapId ~= self.zoneInfo.panel.mapId or forceUpdate then
				if setPanelMap then
					self.zoneInfo.panel.mapId = masterTable.mapId
					self.zoneInfo.panel.dungeonLevel = masterTable.dungeonLevel
				end
				self:_ForcePanelMapArea(not setPanelMap)
			end
		end,

		--	This is called because we are hooking secure functions to call it
		_UserChangedMap = function(blizzardButton)
			Wholly.zoneInfo.map.mapId = GetCurrentMapAreaID()
			Wholly.zoneInfo.map.dungeonLevel = GetCurrentMapDungeonLevel()
			Wholly:_UpdatePins()
		end,

		ZoneButtonEnter = function(self, frame)
			GameTooltip:ClearLines()
			GameTooltip:SetOwner(frame, "ANCHOR_RIGHT")
			GameTooltip:AddLine(Wholly.panelCountLine)
			GameTooltip:Show()
			GameTooltip:ClearAllPoints()
		end,

		}

	local locale = GetLocale()
	local S = Wholly.s
	if "deDE" == locale then
		S["ABANDONED"] = "Abgebrochen"
		S["ACCEPTED"] = "Angenommen"
		S["ACHIEVEMENT_COLORS"] = "Zeige Farben je nach Erfolgs-Vervollständigung"
		S["APPEND_LEVEL"] = "Erforderliche Stufe anhängen"
		S["BASE_QUESTS"] = "Hauptquests"
		BINDING_NAME_WHOLLY_TOGGLEMAPPINS = "Kartenpunkte umschalten."
		BINDING_NAME_WHOLLY_TOGGLESHOWCOMPLETED = "An/aus Abgeschlossene anzeigen"
		BINDING_NAME_WHOLLY_TOGGLESHOWDAILIES = "An/aus Tagesquests anzeigen"
		BINDING_NAME_WHOLLY_TOGGLESHOWNEEDSPREREQUISITES = "Anforderungen Voraussetzungen anzeigen An/aus"
		BINDING_NAME_WHOLLY_TOGGLESHOWREPEATABLES = "An/aus Wiederholbare Quests anzeigen"
		BINDING_NAME_WHOLLY_TOGGLESHOWUNOBTAINABLES = "Anzeige \"Unerreichbares\" umschalten."
		BINDING_NAME_WHOLLY_TOGGLESHOWWEEKLIES = "An/aus Wochenquests anzeigen"
		S["BLIZZARD_TOOLTIP"] = "QuickInfos werden im Blizzard Quest Log angezeigt"
		S["BREADCRUMB"] = "Brotkrumen Quests:"
		S["BUGGED"] = "*** FEHLERHAFT ***"
		S["BUGGED_UNOBTAINABLE"] = "Fehlerhafte, wahrscheinlich unerfüllbare Quests"
		S["BUILDING"] = "Gebäude"
		S["CHRISTMAS_WEEK"] = "Weihnachtswoche (inkl. Winterhauchfest)"
		S["CLASS_ANY"] = "Jede"
		S["CLASS_NONE"] = "Keine"
		S["COMPLETED"] = "Abgeschlossen"
		S["COMPLETION_DATES"] = "Fertigstellungstermine"
		S["DROP_TO_START_FORMAT"] = "Dropt %s um [%s] zu starten"
		S["ENABLE_COORDINATES"] = "Anzeige der Spieler Koordinaten"
		S["ENTER_ZONE"] = "Annahme, wenn Kartenbereich erreicht wird"
		S["ESCORT"] = "Eskorte"
		S["EVER_CAST"] = "Wurde schon mal vom Spieler irgendwann benutzt."
		S["EVER_COMPLETED"] = "Wurde bereits einmal fertiggestellt"
		S["EVER_EXPERIENCED"] = "Wurde schon mal auf den Spieler irgendwann benutzt."
		S["FACTION_BOTH"] = "Beide"
		S["FIRST_PREREQUISITE"] = "Erster in einer Questreihe"
		S["GENDER"] = "Geschlecht"
		S["GENDER_BOTH"] = "Beide"
		S["GENDER_NONE"] = "Keins"
		S["GRAIL_NOT_HAVE"] = "Grail kennt diese Quest nicht"
		S["HIGH_LEVEL"] = "Hochstufig"
		S["HOLIDAYS_ONLY"] = "Verfügbar nur an Feiertagen:"
		S["IN_LOG"] = "Im Log"
		S["IN_LOG_STATUS"] = "Zeige Status der Quests im Log"
		S["INVALIDATE"] = "Ungültig durch Quests:"
		S["IS_BREADCRUMB"] = "Ist eine Brotkrumen Quest für:"
		S["ITEM"] = "Gegenstand"
		S["ITEM_LACK"] = "Gegenstand fehlt"
		S["KILL_TO_START_FORMAT"] = "Töte um [%s] zu starten"
		S["LIVE_COUNTS"] = "Direkte Quest Anzahl aktualisierung"
		S["LOAD_DATA"] = "Daten laden"
		S["LOREMASTER_AREA"] = "'Meister der Lehren' Bereich"
		S["LOW_LEVEL"] = "Niedrigstufig"
		S["MAP"] = "Karte"
		S["MAPAREA_NONE"] = "Keine"
		S["MAP_BUTTON"] = "Zeige Button auf Weltkarte"
		S["MAP_DUNGEONS"] = "Zeige Dungeon-Quests in Umgebungskarte"
		S["MAP_PINS"] = "Zeige Karten-Symbole für Questgeber an"
		S["MAP_UPDATES"] = "Weltkarte aktualisieren, wenn Zone wechselt"
		S["MAXIMUM_LEVEL_NONE"] = "Keine"
		S["MULTIPLE_BREADCRUMB_FORMAT"] = "%d Brotkrumen-Quests verfügbar"
		S["MUST_KILL_PIN_FORMAT"] = "%s [Kill]"
		S["NEAR"] = "Naher NPC"
		S["NEEDS_PREREQUISITES"] = "Benötigt Voraussetzungen"
		S["NEVER_ABANDONED"] = "Niemals abgebrochen"
		S["OAC"] = "Bei Annahme fertiggestellte Quests:"
		S["OCC"] = "Bei Erfüllung der Voraussetzungen fertiggestellte Quests:"
		S["OTC"] = "Beim Abgeben fertiggestellte Quests;"
		S["OTHER"] = "Andere"
		S["OTHER_PREFERENCE"] = "Sonstiges"
		S["PANEL_UPDATES"] = "Quest-Log aktualisieren, wenn Zone wechselt"
		S["PLOT"] = "Grundstück"
		S["PREPEND_LEVEL"] = "Queststufe voranstellen"
		S["PREREQUISITES"] = "Quests, die Vorraussetzung sind:"
		S["QUEST_COUNTS"] = "Zeige Quest Anzahl"
		S["QUEST_ID"] = "Quest ID:"
		S["QUEST_TYPE_NORMAL"] = "Normal"
		S["RACE_ANY"] = "Jede"
		S["RACE_NONE"] = "Keine"
		S["REPEATABLE"] = "Wiederholbar"
		S["REPEATABLE_COMPLETED"] = "Zeige ob wiederholbare Quests bereits fertiggestellt wurden"
		S["REPUTATION_REQUIRED"] = "Ruf erforderlich:"
		S["REQUIRED_LEVEL"] = "Benötigte Stufe:"
		S["REQUIRES_FORMAT"] = "Wholly benötigt Grail-Version %s oder neuer"
		S["SEARCH_ALL_QUESTS"] = "Alle Quests"
		S["SEARCH_CLEAR"] = "Suche löschen"
		S["SEARCH_NEW"] = "Neue Suche"
		S["SELF"] = "Selbst"
		S["SHOW_BREADCRUMB"] = "Zeige detaillierte Quest-Informationen im Questfenster"
		S["SHOW_LOREMASTER"] = "Zeige nur 'Meister der Lehren' Quests"
		S["SINGLE_BREADCRUMB_FORMAT"] = "Brotkrumen-Quest verfügbar"
		S["SP_MESSAGE"] = "Spezial-Quest taucht niemals in Blizzards Quest-Log auf"
		S["TAGS"] = "Tags"
		S["TAGS_DELETE"] = "Tag entfernen"
		S["TAGS_NEW"] = "Tag hinzufügen"
		S["TITLE_APPEARANCE"] = "Aussehen der Quests im Quest-Log"
		S["TURNED_IN"] = "Abgegeben"
		S["UNOBTAINABLE"] = "Unerfüllbar"
		S["WHEN_KILL"] = "Annahme beim Töten:"
		S["WIDE_PANEL"] = "Breites Wholly Quest Fenster"
		S["WIDE_SHOW"] = "Zeige"
		S["WORLD_EVENTS"] = "Weltereignisse"
		S["YEARLY"] = "Jährlich"
	elseif "esES" == locale then
		S["ABANDONED"] = "ABANDONADA"
		S["ACCEPTED"] = "ACEPTADA"
		S["ACHIEVEMENT_COLORS"] = "Mostrar colores de finalización de logros" -- Needs review
		S["APPEND_LEVEL"] = "Añadir nivel requerido" -- Needs review
		S["BASE_QUESTS"] = "Misiones base" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLEMAPPINS = "Mostrar/ocultar marcas en el mapa" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLESHOWCOMPLETED = "Mostrar/ocultar misiones completadas" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLESHOWDAILIES = "Mostrar/ocultar misiones diarias" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLESHOWNEEDSPREREQUISITES = "Mostrar/ocultar misiones con prerequisitos obligatorios" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLESHOWREPEATABLES = "Mostrar/ocultar misiones repetibles" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLESHOWUNOBTAINABLES = "Mostrar/ocultar misiones no obtenibles" -- Needs review
		S["BREADCRUMB"] = "Misiones de cadena" -- Needs review
		S["BUGGED"] = "*** ERROR ***" -- Needs review
		S["BUGGED_UNOBTAINABLE"] = "Misiones con errores consideradas imposibles" -- Needs review
		S["CHRISTMAS_WEEK"] = "Semana navideña" -- Needs review
		S["CLASS_ANY"] = "CLASE_TODOS"
		S["CLASS_NONE"] = "CLASE_NINGUNO"
		S["COMPLETED"] = "Completada" -- Needs review
		S["DROP_TO_START_FORMAT"] = "Deja caer %s para iniciar [%s]" -- Needs review
		S["ENABLE_COORDINATES"] = "Habilitar coordenadas del jugador" -- Needs review
		S["ENTER_ZONE"] = "Aceptada al entrar en mapa de la zona" -- Needs review
		S["ESCORT"] = "Escoltar" -- Needs review
		S["EVER_COMPLETED"] = "YA_COMPLETADA"
		S["FACTION_BOTH"] = "FACCION_AMBOS"
		S["FIRST_PREREQUISITE"] = "Primera en la cadena de prerequisitos:" -- Needs review
		S["GENDER"] = "Sexo" -- Needs review
		S["GENDER_BOTH"] = "SEXO_AMBOS"
		S["GENDER_NONE"] = "SEXO_NINGUNO"
		S["GRAIL_NOT_HAVE"] = "Grail no tiene esta misión" -- Needs review
		S["HIGH_LEVEL"] = "De nivel alto" -- Needs review
		S["HOLIDAYS_ONLY"] = "Solo disponible durante eventos festivos:" -- Needs review
		S["IN_LOG"] = "En el registro" -- Needs review
		S["IN_LOG_STATUS"] = "Mostrar estado de misión en registro" -- Needs review
		S["INVALIDATE"] = "Invalidado por misiones:" -- Needs review
		S["ITEM"] = "OBJETO"
		S["ITEM_LACK"] = "OBJETO_FALTA"
		S["KILL_TO_START_FORMAT"] = "Matar para iniciar [%s]" -- Needs review
		S["LOAD_DATA"] = "Cargar datos" -- Needs review
		S["LOREMASTER_AREA"] = "Zona de Maestro Cultural" -- Needs review
		S["LOW_LEVEL"] = "De nivel bajo" -- Needs review
		S["MAP"] = "Mapa" -- Needs review
		S["MAPAREA_NONE"] = "AREAMAPA_NINGUNO"
		S["MAP_BUTTON"] = "Mostrar botón en mapa del mundo" -- Needs review
		S["MAP_DUNGEONS"] = "Mostrar misiones de mazmorra en minimapa" -- Needs review
		S["MAP_PINS"] = "Mostrar marcas en el mapa para NPC de inicio de misión" -- Needs review
		S["MAP_UPDATES"] = "Actualizar mapa del mundo al cambiar de zona" -- Needs review
		S["MAXIMUM_LEVEL_NONE"] = "NIVEL_MAXIMO_NINGUNO"
		S["MULTIPLE_BREADCRUMB_FORMAT"] = "%d misiones de cadena disponibles" -- Needs review
		S["MUST_KILL_PIN_FORMAT"] = "%s [Matar]" -- Needs review
		S["NEAR"] = "Cerca" -- Needs review
		S["NEEDS_PREREQUISITES"] = "Prerequisitos obligatorios" -- Needs review
		S["NEVER_ABANDONED"] = "NUNCA_ABANDONADA"
		S["OAC"] = "Al aceptar completa misiones:" -- Needs review
		S["OCC"] = "Al cumplir los requisitos completa misiones:" -- Needs review
		S["OTC"] = "Al entregar completa misiones:" -- Needs review
		S["OTHER"] = "Otro" -- Needs review
		S["OTHER_PREFERENCE"] = "Sección_Otra" -- Needs review
		S["PANEL_UPDATES"] = "Actualizar registro de misiones al cambiar de zona" -- Needs review
		S["PREPEND_LEVEL"] = "Anteponer nivel de la búsqueda" -- Needs review
		S["PREREQUISITES"] = "Misiones previas" -- Needs review
		S["QUEST_ID"] = "ID de misión:" -- Needs review
		S["QUEST_TYPE_NORMAL"] = "TIPO_MISION_NORMAL"
		S["RACE_ANY"] = "RAZA_CUALQUIERA"
		S["RACE_NONE"] = "RAZA_NINGUNA"
		S["REPEATABLE"] = "Repetible" -- Needs review
		S["REPEATABLE_COMPLETED"] = "Mostrar si las misiones repetibles han sido completadas" -- Needs review
		S["REPUTATION_REQUIRED"] = "Reputación requerida:" -- Needs review
		S["REQUIRED_LEVEL"] = "Nivel requerido" -- Needs review
		S["REQUIRES_FORMAT"] = "Wholly requiere la versión %s o mas reciente de Grail" -- Needs review
		S["SEARCH_ALL_QUESTS"] = "BUSCAR_TODAS_MISIONES"
		S["SEARCH_CLEAR"] = "BUSQUEDA_LIMPIAR"
		S["SEARCH_NEW"] = "BUSQUEDA_NUEVA"
		S["SELF"] = "Auto" -- Needs review
		S["SHOW_BREADCRUMB"] = "Mostrar información de cadenas de misión en interfaz de misión" -- Needs review
		S["SHOW_LOREMASTER"] = "Solo mostrar misiones de Maestro Cultural" -- Needs review
		S["SINGLE_BREADCRUMB_FORMAT"] = "Cadenas de misiones disponibles" -- Needs review
		S["SP_MESSAGE"] = "Misión especial, no entra en registro de misiones de Blizzard" -- Needs review
		S["TAGS"] = "Etiquetas" -- Needs review
		S["TAGS_DELETE"] = "Eliminar Etiqueta" -- Needs review
		S["TAGS_NEW"] = "Añadir Etiqueta" -- Needs review
		S["TITLE_APPEARANCE"] = "Apariencia del título de misión" -- Needs review
		S["TURNED_IN"] = "Entregada" -- Needs review
		S["UNOBTAINABLE"] = "No obtenible" -- Needs review
		S["WHEN_KILL"] = "Aceptada al matar:" -- Needs review
		S["WIDE_SHOW"] = "Mostrar" -- Needs review
		S["WORLD_EVENTS"] = "Eventos del mundo" -- Needs review
		S["YEARLY"] = "Anualmente" -- Needs review
	elseif "esMX" == locale then
		S["ABANDONED"] = "ABANDONADO" -- Needs review
		S["ACCEPTED"] = "ACEPTADO" -- Needs review
		S["ACHIEVEMENT_COLORS"] = "Mostrar colores de competación de logros" -- Needs review
		S["APPEND_LEVEL"] = "Añadir nivel requerido" -- Needs review
		S["BASE_QUESTS"] = "Búsqueda Base" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLEMAPPINS = "Mostrar/ocultar marcas en el mapa" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLESHOWCOMPLETED = "Mostrar/ocultar misiones completadas" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLESHOWDAILIES = "Mostrar/ocultar misiones diarias" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLESHOWNEEDSPREREQUISITES = "Mostrar/ocultar misiones con prerequisitos obligatorios" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLESHOWREPEATABLES = "Mostrar/ocultar misiones repetibles" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLESHOWUNOBTAINABLES = "Mostrar/ocultar misiones no obtenibles" -- Needs review
		S["BREADCRUMB"] = "Búsquedas de senderos migas de pan" -- Needs review
		S["BUGGED"] = "*** ERROR ***" -- Needs review
		S["BUGGED_UNOBTAINABLE"] = "Búsquedas con errores se consideran no obtenibles" -- Needs review
		S["CHRISTMAS_WEEK"] = "Semana navideña" -- Needs review
		S["CLASS_ANY"] = "CLASE_TODOS" -- Needs review
		S["CLASS_NONE"] = "CLASE_NINGUNO" -- Needs review
		S["COMPLETED"] = "Completada" -- Needs review
		S["DROP_TO_START_FORMAT"] = "Deja caer %s para iniciar [%s]" -- Needs review
		S["ENABLE_COORDINATES"] = "Habilitar coordenadas del jugador" -- Needs review
		S["ENTER_ZONE"] = "Aceptado al entrar area del mapa" -- Needs review
		S["ESCORT"] = "Acompañar" -- Needs review
		S["EVER_COMPLETED"] = "YA_COMPLETADO" -- Needs review
		S["FACTION_BOTH"] = "FACCION_AMBOS" -- Needs review
		S["FIRST_PREREQUISITE"] = "Primero en la Cadena de Prerequisitos:" -- Needs review
		S["GENDER"] = "Sexo" -- Needs review
		S["GENDER_BOTH"] = "SEXO_AMBOS" -- Needs review
		S["GENDER_NONE"] = "SEXO_NINGUNO" -- Needs review
		S["GRAIL_NOT_HAVE"] = "Grail no tiene esta búsqueda" -- Needs review
		S["HIGH_LEVEL"] = "Nivel Alto" -- Needs review
		S["HOLIDAYS_ONLY"] = "Solo disponible durante feriados:" -- Needs review
		S["IN_LOG"] = "En el Registro" -- Needs review
		S["IN_LOG_STATUS"] = "Mostrar estatus de las búsquedas en el registro" -- Needs review
		S["INVALIDATE"] = "Hecho invalido por búsquedas:" -- Needs review
		S["ITEM"] = "ARTICULO" -- Needs review
		S["ITEM_LACK"] = "ARTICULO_FALTA" -- Needs review
		S["KILL_TO_START_FORMAT"] = "Matar para iniciar [%s]" -- Needs review
		S["LOAD_DATA"] = "Cargar Data" -- Needs review
		S["LOREMASTER_AREA"] = "Area del Maestro del Saber" -- Needs review
		S["LOW_LEVEL"] = "Nivel-bajo" -- Needs review
		S["MAP"] = "Mapa" -- Needs review
		S["MAPAREA_NONE"] = "AREADEMAPA_NINGUNO" -- Needs review
		S["MAP_BUTTON"] = "Demostrar botón en el mapa mundial" -- Needs review
		S["MAP_DUNGEONS"] = "Demostrar busqúedas de mazmorras en el mapa exterior" -- Needs review
		S["MAP_PINS"] = "Demostrar flechas para dadores de búsquedas" -- Needs review
		S["MAP_UPDATES"] = "Se actualiza el mapa mundial cuando se cambia de zona" -- Needs review
		S["MAXIMUM_LEVEL_NONE"] = "NIVEL_MAXIMO_NINGUNO" -- Needs review
		S["MULTIPLE_BREADCRUMB_FORMAT"] = "%d Búsquedas de sendero de migas de pan disponibles" -- Needs review
		S["MUST_KILL_PIN_FORMAT"] = "%s [Matar]" -- Needs review
		S["NEAR"] = "Cerca" -- Needs review
		S["NEEDS_PREREQUISITES"] = "Necesita prerequisitos" -- Needs review
		S["NEVER_ABANDONED"] = "NUNCA_ABANDONADO" -- Needs review
		S["OAC"] = "Al aceptar completa búsqueda:" -- Needs review
		S["OCC"] = "Al cumplir los requisitos completa búsquedas:" -- Needs review
		S["OTC"] = "Al entregar completa búsquedas:" -- Needs review
		S["OTHER"] = "Otro" -- Needs review
		S["OTHER_PREFERENCE"] = "Sección_Otra" -- Needs review
		S["PANEL_UPDATES"] = "Actualizar registro de búsquedas cuando se cambia de zona" -- Needs review
		S["PREPEND_LEVEL"] = "Anteponer nivel de la búsqueda" -- Needs review
		S["PREREQUISITES"] = "Búsquedas prerequisitas" -- Needs review
		S["QUEST_ID"] = "ID de Búsqueda:" -- Needs review
		S["QUEST_TYPE_NORMAL"] = "TIPO_BUSQEUDA_NORMAL" -- Needs review
		S["RACE_ANY"] = "RAZA_CUALQUIERA" -- Needs review
		S["RACE_NONE"] = "RAZA_NINGUNA" -- Needs review
		S["REPEATABLE"] = "Repetible" -- Needs review
		S["REPEATABLE_COMPLETED"] = "Mostrar si búsquedas repetibles han sido completadas" -- Needs review
		S["REPUTATION_REQUIRED"] = "Reputación Requerida:" -- Needs review
		S["REQUIRED_LEVEL"] = "Nivel Requerido" -- Needs review
		S["REQUIRES_FORMAT"] = "Wholly requiere la versión %s o mas reciente de Grail" -- Needs review
		S["SEARCH_ALL_QUESTS"] = "BUSCAR_TODAS_BUSQUEDAS" -- Needs review
		S["SEARCH_CLEAR"] = "BUSQUEDA_ACLARAR" -- Needs review
		S["SEARCH_NEW"] = "BUSQUEDA_NUEVA" -- Needs review
		S["SELF"] = "Auto" -- Needs review
		S["SHOW_BREADCRUMB"] = "Demostrar la información del sendero de la búsqueda en la Cuadra de la Búsqueda" -- Needs review
		S["SHOW_LOREMASTER"] = "Solo mostrar búsquedas del Maestro del Saber " -- Needs review
		S["SINGLE_BREADCRUMB_FORMAT"] = "Búsqueda de senderos migas de pan disponibles" -- Needs review
		S["SP_MESSAGE"] = "Búsqueda especial nunca entra al registro de búsquedas de Blizzard" -- Needs review
		S["TAGS"] = "Etiquetas" -- Needs review
		S["TAGS_DELETE"] = "Eliminar Etiqueta" -- Needs review
		S["TAGS_NEW"] = "Añadir Etiqueta" -- Needs review
		S["TITLE_APPEARANCE"] = "Apariencia del Título de Búsqueda" -- Needs review
		S["TURNED_IN"] = "Entregado" -- Needs review
		S["UNOBTAINABLE"] = "No obtenible" -- Needs review
		S["WHEN_KILL"] = "Aceptado al matar:" -- Needs review
		S["WORLD_EVENTS"] = "Eventos Mundiales" -- Needs review
		S["YEARLY"] = "Anualmente" -- Needs review
	elseif "frFR" == locale then
		S["ABANDONED"] = "Abandonnée"
		S["ACCEPTED"] = "Acceptée"
		S["ACHIEVEMENT_COLORS"] = "Afficher les couleurs de l'avancement de la progression des objectifs de hauts faits" -- Needs review
		S["APPEND_LEVEL"] = "Ajouter le niveau minimum requis après le nom de la quête" -- Needs review
		S["BASE_QUESTS"] = "Quêtes de base" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLEMAPPINS = "Afficher/cacher les icônes de la carte" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLESHOWCOMPLETED = "Afficher/cacher celles finies" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLESHOWDAILIES = "Afficher/cacher les journalières" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLESHOWNEEDSPREREQUISITES = "Afficher/cacher les quêtes nécessitants des prérequis" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLESHOWREPEATABLES = "Afficher/cacher les répétables" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLESHOWUNOBTAINABLES = "Afficher/cacher celles impossibles à obtenir" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLESHOWWEEKLIES = "Afficher/cacher les quêtes hebdomadaires" -- Needs review
		S["BLIZZARD_TOOLTIP"] = "Apparition des info-bulles sur le Journal de quêtes" -- Needs review
		S["BREADCRUMB"] = "Quêtes précédentes (suite de quêtes) :" -- Needs review
		S["BUGGED"] = "*** BOGUÉE ***" -- Needs review
		S["BUGGED_UNOBTAINABLE"] = "Quêtes boguées considérées comme impossibles à obtenir" -- Needs review
		S["CHRISTMAS_WEEK"] = "Vacances de Noël" -- Needs review
		S["CLASS_ANY"] = "Toutes" -- Needs review
		S["CLASS_NONE"] = "Aucune" -- Needs review
		S["COMPLETED"] = "Finies" -- Needs review
		S["COMPLETION_DATES"] = "Date de restitution" -- Needs review
		S["DROP_TO_START_FORMAT"] = "Ramasser %s (butin) pour commencer [%s]" -- Needs review
		S["ENABLE_COORDINATES"] = "Activer les coordonnées du joueur" -- Needs review
		S["ENTER_ZONE"] = "Acceptée lors de l'entrée dans la zone" -- Needs review
		S["ESCORT"] = "Escorte" -- Needs review
		S["EVER_CAST"] = "N'a jamais lancé " -- Needs review
		S["EVER_COMPLETED"] = "N'a jamais été effectuée" -- Needs review
		S["EVER_EXPERIENCED"] = "N'a jamais fait l'expérience de " -- Needs review
		S["FACTION_BOTH"] = "Les deux"
		S["FIRST_PREREQUISITE"] = "Première dans la suite de prérequis :" -- Needs review
		S["GENDER"] = "Sexe" -- Needs review
		S["GENDER_BOTH"] = "Les deux" -- Needs review
		S["GENDER_NONE"] = "Aucun" -- Needs review
		S["GRAIL_NOT_HAVE"] = "Grail n'a pas cette quête dans sa base de données" -- Needs review
		S["HIGH_LEVEL"] = "Haut niveau" -- Needs review
		S["HOLIDAYS_ONLY"] = "Disponible uniquement pendant un évènement mondial :" -- Needs review
		S["IN_LOG"] = "Dans le journal" -- Needs review
		S["IN_LOG_STATUS"] = "Afficher l'état des quêtes dans le journal" -- Needs review
		S["INVALIDATE"] = "Invalidée de par les quêtes :" -- Needs review
		S["IS_BREADCRUMB"] = "Quête suivante (suite) : " -- Needs review
		S["ITEM"] = "Objet"
		S["ITEM_LACK"] = "Objet manquant"
		S["KILL_TO_START_FORMAT"] = "Tuer pour commencer [%s]" -- Needs review
		S["LIVE_COUNTS"] = "Mise à jour en direct du compteur de quêtes" -- Needs review
		S["LOAD_DATA"] = "Chargement des données" -- Needs review
		S["LOREMASTER_AREA"] = "Zone de maître des traditions" -- Needs review
		S["LOW_LEVEL"] = "Bas niveau" -- Needs review
		S["MAP"] = "Carte" -- Needs review
		S["MAPAREA_NONE"] = "Aucun" -- Needs review
		S["MAP_BUTTON"] = "Afficher le bouton sur la carte du monde" -- Needs review
		S["MAP_DUNGEONS"] = "Afficher les quêtes de donjons sur la carte du monde" -- Needs review
		S["MAP_PINS"] = "Afficher les icônes ! des donneurs de quêtes sur la carte" -- Needs review
		S["MAP_UPDATES"] = "Mise à jour de la carte du monde lors d'un changement de zone" -- Needs review
		S["MAXIMUM_LEVEL_NONE"] = "Aucun" -- Needs review
		S["MULTIPLE_BREADCRUMB_FORMAT"] = "%d quêtes précédentes disponibles; (suite de quêtes)" -- Needs review
		S["MUST_KILL_PIN_FORMAT"] = "%s [Tuer]" -- Needs review
		S["NEAR"] = "Proche" -- Needs review
		S["NEEDS_PREREQUISITES"] = "Prérequis nécessaires" -- Needs review
		S["NEVER_ABANDONED"] = "Jamais abandonnée"
		S["OAC"] = "Quêtes complétées par acceptation :" -- Needs review
		S["OCC"] = "Quêtes complétées par objectifs atteints :" -- Needs review
		S["OTC"] = "Quêtes complétées de par être rendues :" -- Needs review
		S["OTHER"] = "Autres" -- Needs review
		S["OTHER_PREFERENCE"] = "Autres" -- Needs review
		S["PANEL_UPDATES"] = "Mise à jour du journal de quêtes lors d'un changement de zone" -- Needs review
		S["PREPEND_LEVEL"] = "Ajouter le niveau de la quête avant son nom" -- Needs review
		S["PREREQUISITES"] = "Quêtes préalables :" -- Needs review
		S["QUEST_COUNTS"] = "Montrer le nombre de quêtes" -- Needs review
		S["QUEST_ID"] = "ID de quête :" -- Needs review
		S["QUEST_TYPE_NORMAL"] = "Normal" -- Needs review
		S["RACE_ANY"] = "Toutes" -- Needs review
		S["RACE_NONE"] = "Aucune" -- Needs review
		S["REPEATABLE"] = "Répétable" -- Needs review
		S["REPEATABLE_COMPLETED"] = "Afficher si les quêtes répétables ont déjà été terminées auparavant" -- Needs review
		S["REPUTATION_REQUIRED"] = "Réputation nécessaire :" -- Needs review
		S["REQUIRED_LEVEL"] = "Niveau requis" -- Needs review
		S["REQUIRES_FORMAT"] = "Wholly nécessite Grail version %s ou ultérieure" -- Needs review
		S["SEARCH_ALL_QUESTS"] = "Toutes les quêtes"
		S["SEARCH_CLEAR"] = "Effacer"
		S["SEARCH_NEW"] = "Nouvelle"
		S["SELF"] = "Soi-même" -- Needs review
		S["SHOW_BREADCRUMB"] = "Afficher les informations d'une suite de quêtes dans le journal de quêtes" -- Needs review
		S["SHOW_LOREMASTER"] = "Afficher uniquement les quêtes comptant pour le haut fait de \"Maître des traditions\"" -- Needs review
		S["SINGLE_BREADCRUMB_FORMAT"] = "Quête précédente disponible (suite de quêtes)" -- Needs review
		S["SP_MESSAGE"] = "Certaines quêtes spéciales ne sont jamais affichées dans le journal de quêtes de Blizzard" -- Needs review
		S["TAGS"] = "Tags" -- Needs review
		S["TAGS_DELETE"] = "Supprimer le tag" -- Needs review
		S["TAGS_NEW"] = "Ajouter un tag" -- Needs review
		S["TITLE_APPEARANCE"] = "Apparence du titre des quêtes" -- Needs review
		S["TURNED_IN"] = "Rendue" -- Needs review
		S["UNOBTAINABLE"] = "Impossible à obtenir" -- Needs review
		S["WHEN_KILL"] = "Acceptée en tuant :" -- Needs review
		S["WIDE_PANEL"] = "Journal de quêtes Wholly large" -- Needs review
		S["WIDE_SHOW"] = "Afficher" -- Needs review
		S["WORLD_EVENTS"] = "Évènements mondiaux" -- Needs review
		S["YEARLY"] = "Annuelle" -- Needs review
    elseif "itIT" == locale then
		S["ABANDONED"] = "Abbandonata" -- Needs review
		S["ACCEPTED"] = "Accettata" -- Needs review
		S["ACHIEVEMENT_COLORS"] = "Visualizza il colore delle realizzazioni completate" -- Needs review
		S["APPEND_LEVEL"] = "Posponi livello richiesto" -- Needs review
		S["BASE_QUESTS"] = "Quest di base" -- Needs review
		S["BREADCRUMB"] = "Traccia Missioni" -- Needs review
		S["BUGGED"] = "Bug" -- Needs review
		S["BUGGED_UNOBTAINABLE"] = "Missioni buggate considerate non ottenibili" -- Needs review
		S["CHRISTMAS_WEEK"] = "Settimana di Natale" -- Needs review
		S["CLASS_ANY"] = "Qualsiasi" -- Needs review
		S["CLASS_NONE"] = "Nessuna" -- Needs review
		S["COMPLETED"] = "Completata" -- Needs review
		S["ENABLE_COORDINATES"] = "Attiva le coordinate del giocatore" -- Needs review
		S["ENTER_ZONE"] = "Accetta quando entri nell'area" -- Needs review
		S["ESCORT"] = "Scorta" -- Needs review
		S["EVER_COMPLETED"] = "Stata completata" -- Needs review
		S["FACTION_BOTH"] = "Entrambe" -- Needs review
		S["FIRST_PREREQUISITE"] = "In primo luogo nella catena dei prerequisiti:" -- Needs review
		S["GENDER"] = "Genere" -- Needs review
		S["GENDER_BOTH"] = "Entrambi" -- Needs review
		S["GENDER_NONE"] = "Nessun" -- Needs review
		S["GRAIL_NOT_HAVE"] = "Grail non dispone di questa ricerca" -- Needs review
		S["HIGH_LEVEL"] = "Di livello alto" -- Needs review
		S["HOLIDAYS_ONLY"] = "Disponibile solo durante le vacanze" -- Needs review
		S["IN_LOG"] = "Connettiti" -- Needs review
		S["IN_LOG_STATUS"] = "Mostra lo stato delle quest" -- Needs review
		S["INVALIDATE"] = "Missioni invalidate" -- Needs review
		S["ITEM"] = "Oggetto" -- Needs review
		S["ITEM_LACK"] = "Oggetto mancante" -- Needs review
		S["KILL_TO_START_FORMAT"] = "Uccidere per avviare [%s]" -- Needs review
		S["LIVE_COUNTS"] = "Aggiornamento conteggio missioni direttamente" -- Needs review
		S["LOAD_DATA"] = "Caricare i dati" -- Needs review
		S["LOREMASTER_AREA"] = "Loremaster Area" -- Needs review
		S["LOW_LEVEL"] = "Di livello basso" -- Needs review
		S["MAP"] = "Mappa" -- Needs review
		S["MAPAREA_NONE"] = "Nessuna" -- Needs review
		S["MAP_BUTTON"] = "Mostra pulsante mappa del mondo" -- Needs review
		S["MAP_DUNGEONS"] = "Mostra le quest nei dungeon sulla mappa esterna" -- Needs review
		S["MAP_PINS"] = "Mostra sulla mappa le quest da prendere" -- Needs review
		S["MAP_UPDATES"] = "Aggiorna la mappa quando cambio zona" -- Needs review
		S["MAXIMUM_LEVEL_NONE"] = "Nessun" -- Needs review
		S["MUST_KILL_PIN_FORMAT"] = "%s [Uccidere]" -- Needs review
		S["NEAR"] = "Vicino a" -- Needs review
		S["NEEDS_PREREQUISITES"] = "Prerequisiti richiesti" -- Needs review
		S["NEVER_ABANDONED"] = "Mai abbandonata" -- Needs review
		S["OCC"] = "Requisiti richiesti per completare la missione" -- Needs review
		S["OTHER"] = "altro" -- Needs review
		S["OTHER_PREFERENCE"] = "Altre" -- Needs review
		S["PANEL_UPDATES"] = "Aggiorna il pannello log quest quando cambia zona" -- Needs review
		S["PREPEND_LEVEL"] = "Anteponi Livello missioni" -- Needs review
		S["PREREQUISITES"] = "Prerequisiti missione" -- Needs review
		S["QUEST_COUNTS"] = "Mostra conteggio missioni" -- Needs review
		S["QUEST_ID"] = "ID Missione" -- Needs review
		S["QUEST_TYPE_NORMAL"] = "Normali" -- Needs review
		S["RACE_ANY"] = "Qualsiasi" -- Needs review
		S["RACE_NONE"] = "Nessuna" -- Needs review
		S["REPEATABLE"] = "Ripetibile" -- Needs review
		S["REPEATABLE_COMPLETED"] = "Visualizza se le missioni ripetibili precedentemente completate" -- Needs review
		S["REPUTATION_REQUIRED"] = "Reputazione richiesta" -- Needs review
		S["REQUIRED_LEVEL"] = "Livello Richiesto" -- Needs review
		S["REQUIRES_FORMAT"] = "Richiede interamente versione Grail %s o versione successiva" -- Needs review
		S["SEARCH_ALL_QUESTS"] = "Tutte le quest" -- Needs review
		S["SEARCH_CLEAR"] = "Cancella" -- Needs review
		S["SEARCH_NEW"] = "Nuova" -- Needs review
		S["SELF"] = "Se stesso" -- Needs review
		S["SHOW_BREADCRUMB"] = "Mostra informazioni sul percorso della missione sul Quest Frame" -- Needs review
		S["SHOW_LOREMASTER"] = "Mostra solo le missioni Loremaster" -- Needs review
		S["SINGLE_BREADCRUMB_FORMAT"] = "Cerca missioni disponibili" -- Needs review
		S["SP_MESSAGE"] = "Missione speciale mai entrata nel diario della Blizzard" -- Needs review
		S["TAGS"] = "Tag" -- Needs review
		S["TAGS_DELETE"] = "Rimuovi Tag" -- Needs review
		S["TAGS_NEW"] = "Aggiungi Tag" -- Needs review
		S["TITLE_APPEARANCE"] = "Mostra titolo quest" -- Needs review
		S["TURNED_IN"] = "Consegnata" -- Needs review
		S["UNOBTAINABLE"] = "Non ottenibile" -- Needs review
		S["WHEN_KILL"] = "Accetta quando uccidi" -- Needs review
		S["WIDE_PANEL"] = "Ingrandisci il pannello Wholly quest" -- Needs review
		S["WIDE_SHOW"] = "Mostra" -- Needs review
		S["WORLD_EVENTS"] = "Eventi mondiali" -- Needs review
		S["YEARLY"] = "Annuale" -- Needs review
	elseif "koKR" == locale then
		S["ABANDONED"] = "버림" -- Needs review
		S["ACCEPTED"] = "수락" -- Needs review
		S["ACHIEVEMENT_COLORS"] = "업적 완료 색상 표시" -- Needs review
		S["APPEND_LEVEL"] = "요구 레벨 표시" -- Needs review
		S["BASE_QUESTS"] = "퀘스트 일반" -- Needs review
-- 		BINDING_NAME_WHOLLY_TOGGLEMAPPINS = ""
-- 		BINDING_NAME_WHOLLY_TOGGLESHOWCOMPLETED = ""
-- 		BINDING_NAME_WHOLLY_TOGGLESHOWDAILIES = ""
-- 		BINDING_NAME_WHOLLY_TOGGLESHOWNEEDSPREREQUISITES = ""
-- 		BINDING_NAME_WHOLLY_TOGGLESHOWREPEATABLES = ""
-- 		BINDING_NAME_WHOLLY_TOGGLESHOWUNOBTAINABLES = ""
-- 		BINDING_NAME_WHOLLY_TOGGLESHOWWEEKLIES = ""
-- 		S["BLIZZARD_TOOLTIP"] = ""
		S["BREADCRUMB"] = "추가 목표 퀘스트:" -- Needs review
		S["BUGGED"] = "|cffff0000*** 오류 ***|r" -- Needs review
		S["BUGGED_UNOBTAINABLE"] = "불가능한 퀘스트는 오류로 결정" -- Needs review
		S["CHRISTMAS_WEEK"] = "한겨울 축제 주간" -- Needs review
		S["CLASS_ANY"] = "모두" -- Needs review
		S["CLASS_NONE"] = "없음" -- Needs review
		S["COMPLETED"] = "|cFF00FF00완료된 퀘스트|r" -- Needs review
-- 		S["COMPLETION_DATES"] = ""
-- 		S["DROP_TO_START_FORMAT"] = ""
		S["ENABLE_COORDINATES"] = "플레이어 캐릭터 좌표 사용" -- Needs review
		S["ENTER_ZONE"] = "지역에 진입할 떄 수락" -- Needs review
		S["ESCORT"] = "호위" -- Needs review
-- 		S["EVER_CAST"] = ""
		S["EVER_COMPLETED"] = "완료 되었습니다." -- Needs review
-- 		S["EVER_EXPERIENCED"] = ""
		S["FACTION_BOTH"] = "둘다" -- Needs review
-- 		S["FIRST_PREREQUISITE"] = ""
		S["GENDER"] = "성별" -- Needs review
		S["GENDER_BOTH"] = "없음" -- Needs review
		S["GENDER_NONE"] = "없음" -- Needs review
		S["GRAIL_NOT_HAVE"] = "Grail에 이 퀘스트가 없습니다." -- Needs review
		S["HIGH_LEVEL"] = "고레벨 퀘스트" -- Needs review
		S["HOLIDAYS_ONLY"] = "현재 가능한 이벤트:" -- Needs review
		S["IN_LOG"] = "|cFFFF00FF목록에 있는 퀘스트|r" -- Needs review
		S["IN_LOG_STATUS"] = "퀘스트 목록의 진행 표시" -- Needs review
		S["INVALIDATE"] = "퀘스트 무효화" -- Needs review
-- 		S["IS_BREADCRUMB"] = ""
		S["ITEM"] = "아이템" -- Needs review
-- 		S["ITEM_LACK"] = ""
-- 		S["KILL_TO_START_FORMAT"] = ""
		S["LIVE_COUNTS"] = "수행중인 퀘스트 갱신" -- Needs review
		S["LOAD_DATA"] = "데이터 불러오기" -- Needs review
		S["LOREMASTER_AREA"] = "Loremaster 애드온 지역" -- Needs review
		S["LOW_LEVEL"] = "|cFF666666저레벨 퀘스트|r" -- Needs review
		S["MAP"] = "지도에" -- Needs review
		S["MAPAREA_NONE"] = "없음" -- Needs review
		S["MAP_BUTTON"] = "세계지도에 버튼 표시" -- Needs review
		S["MAP_DUNGEONS"] = "지도에 던전 퀘스트 표시" -- Needs review
		S["MAP_PINS"] = "퀘스트 제고아를 지도에 표시" -- Needs review
		S["MAP_UPDATES"] = "지역 이동시 세계지도 갱신" -- Needs review
		S["MAXIMUM_LEVEL_NONE"] = "없음" -- Needs review
		S["MULTIPLE_BREADCRUMB_FORMAT"] = "%d 개의 추가 목표 퀘스트가 가능합니다." -- Needs review
		S["MUST_KILL_PIN_FORMAT"] = "%s [죽임]" -- Needs review
		S["NEAR"] = "근처" -- Needs review
		S["NEEDS_PREREQUISITES"] = "|cFFFF0000전제조건이 필요한 퀘스트|r" -- Needs review
		S["NEVER_ABANDONED"] = "버릴 수 없음" -- Needs review
		S["OAC"] = "접수 완료 퀘스트:" -- Needs review
		S["OCC"] = "목표 완료 퀘스트:" -- Needs review
-- 		S["OTC"] = ""
		S["OTHER"] = "기타" -- Needs review
		S["OTHER_PREFERENCE"] = "기타" -- Needs review
		S["PANEL_UPDATES"] = "지역 이동시 퀘스트 목록 갱신" -- Needs review
		S["PREPEND_LEVEL"] = "퀘스트 레벨 표시" -- Needs review
		S["PREREQUISITES"] = "퀘스트 조건:" -- Needs review
		S["QUEST_COUNTS"] = "퀘스트 숫자 표시" -- Needs review
		S["QUEST_ID"] = "퀘스트 ID:" -- Needs review
		S["QUEST_TYPE_NORMAL"] = "일반" -- Needs review
		S["RACE_ANY"] = "모두" -- Needs review
		S["RACE_NONE"] = "없음" -- Needs review
		S["REPEATABLE"] = "반복" -- Needs review
		S["REPEATABLE_COMPLETED"] = "완료한 반복 퀘스트 표시" -- Needs review
		S["REPUTATION_REQUIRED"] = "평판 요구 사항:" -- Needs review
		S["REQUIRED_LEVEL"] = "요구 레벨" -- Needs review
		S["REQUIRES_FORMAT"] = "Wholly 애드온은 Grail의 %s 버전 이상을 요구합니다." -- Needs review
		S["SEARCH_ALL_QUESTS"] = "모든 퀘스트" -- Needs review
		S["SEARCH_CLEAR"] = "초기화" -- Needs review
		S["SEARCH_NEW"] = "신규" -- Needs review
		S["SELF"] = "자신" -- Needs review
		S["SHOW_BREADCRUMB"] = "퀘스트 창에 여러 퀘스트 정보 표시" -- Needs review
		S["SHOW_LOREMASTER"] = "Loremaster 퀘스트만 표시" -- Needs review
		S["SINGLE_BREADCRUMB_FORMAT"] = "추가 목표 퀘스트가 가능합니다." -- Needs review
-- 		S["SP_MESSAGE"] = ""
		S["TAGS"] = "태그" -- Needs review
		S["TAGS_DELETE"] = "태그 삭제" -- Needs review
		S["TAGS_NEW"] = "태그 추가" -- Needs review
		S["TITLE_APPEARANCE"] = "퀘스트 제목 표시" -- Needs review
-- 		S["TURNED_IN"] = ""
		S["UNOBTAINABLE"] = "|cFF996600불가능한 퀘스트|r" -- Needs review
		S["WHEN_KILL"] = "죽일 때 수락:" -- Needs review
		S["WIDE_PANEL"] = "넓은 Wholly 퀘스트 목록" -- Needs review
		S["WIDE_SHOW"] = "표시" -- Needs review
		S["WORLD_EVENTS"] = "월드 이벤트" -- Needs review
		S["YEARLY"] = "연간" -- Needs review
	elseif "ptBR" == locale then
		S["ABANDONED"] = "Abandonada"
		S["ACCEPTED"] = "Aceita"
		S["ACHIEVEMENT_COLORS"] = "Mostrar cores para conquistas obtidas"
		S["APPEND_LEVEL"] = "Acrescentar nível requerido"
		S["BASE_QUESTS"] = "Missões-base"
		BINDING_NAME_WHOLLY_TOGGLEMAPPINS = "Liga/desliga marcadores de mapa"
		BINDING_NAME_WHOLLY_TOGGLESHOWCOMPLETED = "Alterna exibição das completas"
		BINDING_NAME_WHOLLY_TOGGLESHOWDAILIES = "Alterna exibição das diárias"
		BINDING_NAME_WHOLLY_TOGGLESHOWNEEDSPREREQUISITES = "Alterna exibição de pré-requisitos"
		BINDING_NAME_WHOLLY_TOGGLESHOWREPEATABLES = "Alterna exibição das repetíveis"
		BINDING_NAME_WHOLLY_TOGGLESHOWUNOBTAINABLES = "Alterna exibição das indisponíveis"
		BINDING_NAME_WHOLLY_TOGGLESHOWWEEKLIES = "Alterna exibição das semanais"
		S["BLIZZARD_TOOLTIP"] = "Dicas são exibidas no Registro de Missões da Blizzard"
		S["BREADCRUMB"] = "Missões em sequência:"
		S["BUGGED"] = "*** COM ERRO ***"
		S["BUGGED_UNOBTAINABLE"] = "Missões com erros consideradas indisponíveis"
		S["CHRISTMAS_WEEK"] = "Semana Natalina"
		S["CLASS_ANY"] = "Qualquer"
		S["CLASS_NONE"] = "Nenhuma"
		S["COMPLETED"] = "Completada"
		S["COMPLETION_DATES"] = "Esta opção serve para indicar se a carga do addon que grava quando missões são entregues está ativado."
		S["DROP_TO_START_FORMAT"] = "Saqueie %s para começar [%s]"
		S["ENABLE_COORDINATES"] = "Habilitar coordenadas do jogador"
		S["ENTER_ZONE"] = "Aceita quando entra na área do mapa"
		S["ESCORT"] = "Escolta"
		S["EVER_CAST"] = "Já foi lançado"
		S["EVER_COMPLETED"] = "Já foi concluída"
		S["EVER_EXPERIENCED"] = "Já experimentou"
		S["FACTION_BOTH"] = "Ambas"
		S["FIRST_PREREQUISITE"] = "Primeiro na cadeia de pré-requisitos:"
		S["GENDER"] = "Gênero"
		S["GENDER_BOTH"] = "Ambos"
		S["GENDER_NONE"] = "Nenhum"
		S["GRAIL_NOT_HAVE"] = "Grail não tem essa missão"
		S["HIGH_LEVEL"] = "Nível alto"
		S["HOLIDAYS_ONLY"] = "Disponível somente durante Comemorações"
		S["IN_LOG"] = "Em registro"
		S["IN_LOG_STATUS"] = "Exibir estado das missões no registro"
		S["INVALIDATE"] = "Invalidado pelas missões:"
		S["IS_BREADCRUMB"] = "É sequência de missão para:"
		S["ITEM"] = "Item"
		S["ITEM_LACK"] = "Falta de item"
		S["KILL_TO_START_FORMAT"] = "Mate para começar [%s]"
		S["LIVE_COUNTS"] = "Atualizações dinâmicas de contagem de missões"
		S["LOAD_DATA"] = "Carregar dados"
		S["LOREMASTER_AREA"] = "Área do Mestre Historiador"
		S["LOW_LEVEL"] = "Nível baixo"
		S["MAP"] = "Mapa"
		S["MAPAREA_NONE"] = "Nenhuma"
		S["MAP_BUTTON"] = "Exibir botão no mapa-múndi"
		S["MAP_DUNGEONS"] = "Exibir missões de masmorras no mapa externo"
		S["MAP_PINS"] = "Marcar recrutadores no mapa"
		S["MAP_UPDATES"] = "O mapa-múndi atualiza quando a zona muda"
		S["MAXIMUM_LEVEL_NONE"] = "Nenhum"
		S["MULTIPLE_BREADCRUMB_FORMAT"] = "%d Sequência de missões disponíveis"
		S["MUST_KILL_PIN_FORMAT"] = "%s [Matar]"
		S["NEAR"] = "Próximo"
		S["NEEDS_PREREQUISITES"] = "Pré-requisitos necessários"
		S["NEVER_ABANDONED"] = "Nunca abandonada"
		S["OAC"] = "MIssões que se completam ao aceitar:"
		S["OCC"] = "Missões que se completam ao se cumprir os requisitos:"
		S["OTC"] = "MIssões que se completam ao entregar:"
		S["OTHER"] = "Outro"
		S["OTHER_PREFERENCE"] = "Outras"
		S["PANEL_UPDATES"] = "Painel de registro das missões atualiza quando mudar de zona"
		S["PREPEND_LEVEL"] = "Prefixar nível das missões"
		S["PREREQUISITES"] = "Missões requeridas"
		S["QUEST_COUNTS"] = "Exibir contagem de missões"
		S["QUEST_ID"] = "ID da missão:"
		S["QUEST_TYPE_NORMAL"] = "Normal"
		S["RACE_ANY"] = "Qualquer"
		S["RACE_NONE"] = "Nenhuma"
		S["REPEATABLE"] = "Repetível"
		S["REPEATABLE_COMPLETED"] = "Mostrar se missões repetíveis já foram concluídas"
		S["REPUTATION_REQUIRED"] = "Requer reputação:"
		S["REQUIRED_LEVEL"] = "Nível Requerido"
		S["REQUIRES_FORMAT"] = "Wholly requer a versão %s do Grail ou maior"
		S["SEARCH_ALL_QUESTS"] = "Todas as missões"
		S["SEARCH_CLEAR"] = "Limpar"
		S["SEARCH_NEW"] = "Nova"
		S["SELF"] = "Por si só"
		S["SHOW_BREADCRUMB"] = "Mostrar informações de andamento na Janela de Missões"
		S["SHOW_LOREMASTER"] = "Exibir somente missões do Mestre Historiador"
		S["SINGLE_BREADCRUMB_FORMAT"] = "Sequência de missão disponivel"
		S["SP_MESSAGE"] = "Missões especiais nunca entram no registro de missões da Blizzard"
		S["TAGS"] = "Etiquetas"
		S["TAGS_DELETE"] = "Remover Etiqueta"
		S["TAGS_NEW"] = "Adicionar Etiqueta"
		S["TITLE_APPEARANCE"] = "Aparência do Título da Missão"
		S["TURNED_IN"] = "Entregue"
		S["UNOBTAINABLE"] = "Indisponível"
		S["WHEN_KILL"] = "Aceita quando matar:"
		S["WIDE_PANEL"] = "Painel largo de Missões do Whooly"
		S["WIDE_SHOW"] = "Exibir"
		S["WORLD_EVENTS"] = "Eventos Mundiais"
		S["YEARLY"] = "Anualmente"
	elseif "ruRU" == locale then
		S["ABANDONED"] = "Проваленный"
		S["ACCEPTED"] = "Принят"
		S["ACHIEVEMENT_COLORS"] = "Выделять цветом завершение достижения" -- Needs review
		S["APPEND_LEVEL"] = "Показывать требуемый уровень" -- Needs review
		S["BASE_QUESTS"] = "База заданий" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLEMAPPINS = "Переключить отображение меток на карте" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLESHOWCOMPLETED = "Переключить отображение завершенных" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLESHOWDAILIES = "Переключить отображение ежедневных" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLESHOWNEEDSPREREQUISITES = "Переключить отображение требующих предварительных" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLESHOWREPEATABLES = "Переключить отображение повторяющихся" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLESHOWUNOBTAINABLES = "Переключить отображение недоступных" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLESHOWWEEKLIES = "Отображение еженедельных заданий" -- Needs review
		S["BLIZZARD_TOOLTIP"] = "Показывать подсказки в журнале заданий" -- Needs review
		S["BREADCRUMB"] = "Путеводные задания:" -- Needs review
		S["BUGGED"] = "***ОШИБОЧНОЕ***" -- Needs review
		S["BUGGED_UNOBTAINABLE"] = "Считать ошибочные задания невозможными для получения" -- Needs review
		S["BUILDING"] = "Постройки" -- Needs review
		S["CHRISTMAS_WEEK"] = "Рождественская неделя" -- Needs review
		S["CLASS_ANY"] = "Любой"
		S["CLASS_NONE"] = "Нет"
		S["COMPLETED"] = "Завершенные" -- Needs review
		S["COMPLETION_DATES"] = "Даты завершения" -- Needs review
		S["DROP_TO_START_FORMAT"] = "Падает %s, начинает [%s]" -- Needs review
		S["ENABLE_COORDINATES"] = "Отображать координаты игрока" -- Needs review
		S["ENTER_ZONE"] = "Принимаемое при входе в игровую зону" -- Needs review
		S["ESCORT"] = "Сопровождение" -- Needs review
		S["EVER_CAST"] = "Когда-либо использовалось" -- Needs review
		S["EVER_COMPLETED"] = "Был выполнен"
		S["EVER_EXPERIENCED"] = "Когда-либо получено" -- Needs review
		S["FACTION_BOTH"] = "Обе"
		S["FIRST_PREREQUISITE"] = "Первое в цепочке предварительных:" -- Needs review
		S["GENDER"] = "Пол" -- Needs review
		S["GENDER_BOTH"] = "Оба"
		S["GENDER_NONE"] = "Нет"
		S["GRAIL_NOT_HAVE"] = "Этого задания нет в Grail" -- Needs review
		S["HIGH_LEVEL"] = "Высокого уровня" -- Needs review
		S["HOLIDAYS_ONLY"] = "Доступны только в праздничные дни:" -- Needs review
		S["IN_LOG"] = "Уже в журнале заданий" -- Needs review
		S["IN_LOG_STATUS"] = "Отображать в журнале статус заданий" -- Needs review
		S["INVALIDATE"] = "Недействительное задание из-за:" -- Needs review
		S["IS_BREADCRUMB"] = "Путеводное задание для:" -- Needs review
		S["ITEM"] = "Предмет"
		S["ITEM_LACK"] = "Предмет отсутствует"
		S["KILL_TO_START_FORMAT"] = "Убить, чтобы начать [%s]" -- Needs review
		S["LIVE_COUNTS"] = "Обновлять в реальном времени" -- Needs review
		S["LOAD_DATA"] = "Загрузка данных" -- Needs review
		S["LOREMASTER_AREA"] = "Хранитель мудрости" -- Needs review
		S["LOW_LEVEL"] = "Низкого уровня" -- Needs review
		S["MAP"] = "Карта" -- Needs review
		S["MAPAREA_NONE"] = "Нет"
		S["MAP_BUTTON"] = "Отображать кнопку на карте мира" -- Needs review
		S["MAP_DUNGEONS"] = "Показывать задания в подземельях на карте игровой зоны" -- Needs review
		S["MAP_PINS"] = "Показывать на карте мира метки тех, кто дает задания" -- Needs review
		S["MAP_UPDATES"] = "Обновлять карту мира при смене игровой зоны" -- Needs review
		S["MAXIMUM_LEVEL_NONE"] = "Нет"
		S["MULTIPLE_BREADCRUMB_FORMAT"] = "Доступно %d путеводных заданий" -- Needs review
		S["MUST_KILL_PIN_FORMAT"] = "%s [Убить]" -- Needs review
		S["NEAR"] = "Рядом" -- Needs review
		S["NEEDS_PREREQUISITES"] = "С предварительными" -- Needs review
		S["NEVER_ABANDONED"] = "Не отменялось" -- Needs review
		S["OAC"] = "Задания, завершаемые при принятии:" -- Needs review
		S["OCC"] = "Задания, завершаемые при выполнении условий:" -- Needs review
		S["OTC"] = "Задания, завершаемые при возвращении:" -- Needs review
		S["OTHER"] = "Другое" -- Needs review
		S["OTHER_PREFERENCE"] = "Прочие" -- Needs review
		S["PANEL_UPDATES"] = "Обновлять журнал заданий при смене игровой зоны" -- Needs review
		S["PLOT"] = "Участок" -- Needs review
		S["PREPEND_LEVEL"] = "Показывать уровень задания" -- Needs review
		S["PREREQUISITES"] = "Предварительные задания:" -- Needs review
		S["QUEST_COUNTS"] = "Показывать кол-во заданий" -- Needs review
		S["QUEST_ID"] = "ID задания:" -- Needs review
		S["QUEST_TYPE_NORMAL"] = "Обычный"
		S["RACE_ANY"] = "Любая"
		S["RACE_NONE"] = "Нет"
		S["REPEATABLE"] = "Повторяющиеся" -- Needs review
		S["REPEATABLE_COMPLETED"] = "Показывать ранее выполненные повторяемые задания" -- Needs review
		S["REPUTATION_REQUIRED"] = "Требуемая репутация" -- Needs review
		S["REQUIRED_LEVEL"] = "Требуемый уровень" -- Needs review
		S["REQUIRES_FORMAT"] = "Для работы Wholly требуется Grail версии %s или выше" -- Needs review
		S["SEARCH_ALL_QUESTS"] = "Все задания"
		S["SEARCH_CLEAR"] = "Очистить"
		S["SEARCH_NEW"] = "Новый"
		S["SELF"] = "Себя" -- Needs review
		S["SHOW_BREADCRUMB"] = "Показывать информацию о наличии путеводных заданий" -- Needs review
		S["SHOW_LOREMASTER"] = "Показывать лишь задания, необходимые для получения \"Хранителя мудрости\"" -- Needs review
		S["SINGLE_BREADCRUMB_FORMAT"] = "Доступно путеводное задание" -- Needs review
		S["SP_MESSAGE"] = "Особый квест никогда не попадает в журнал заданий Blizzard" -- Needs review
		S["TAGS"] = "Отмеченные" -- Needs review
		S["TAGS_DELETE"] = "Удалить Тег" -- Needs review
		S["TAGS_NEW"] = "Новый Тег" -- Needs review
		S["TITLE_APPEARANCE"] = "Название задания" -- Needs review
		S["TURNED_IN"] = "Условия выполнены" -- Needs review
		S["UNOBTAINABLE"] = "Недоступные" -- Needs review
		S["WHEN_KILL"] = "Принимаемые при убийстве:" -- Needs review
		S["WIDE_PANEL"] = "Широкая панель заданий Wholly" -- Needs review
		S["WIDE_SHOW"] = "Показывать" -- Needs review
		S["WORLD_EVENTS"] = "Игровые события" -- Needs review
		S["YEARLY"] = "Ежегодные" -- Needs review
	elseif "zhCN" == locale then
		S["ABANDONED"] = "放弃" -- Needs review
		S["ACCEPTED"] = "已接受" -- Needs review
		S["ACHIEVEMENT_COLORS"] = "显示成就完成颜色" -- Needs review
		S["APPEND_LEVEL"] = "显示需要等级" -- Needs review
		S["BASE_QUESTS"] = "基础任务" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLEMAPPINS = "开启地图标记" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLESHOWCOMPLETED = "显示已完成任务" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLESHOWDAILIES = "显示每日任务" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLESHOWNEEDSPREREQUISITES = "显示需要前置的任务" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLESHOWREPEATABLES = "显示重复任务" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLESHOWUNOBTAINABLES = "显示无法取得任务" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLESHOWWEEKLIES = "显示每周任务" -- Needs review
		S["BLIZZARD_TOOLTIP"] = "在游戏任务日志中显示提示信息" -- Needs review
		S["BREADCRUMB"] = "引导任务：" -- Needs review
		S["BUGGED"] = "|cffff0000*** 有问题的 ***|r" -- Needs review
		S["BUGGED_UNOBTAINABLE"] = "将有BUG的任务视为不可取得" -- Needs review
		S["BUILDING"] = "建筑" -- Needs review
		S["CHRISTMAS_WEEK"] = "圣诞周" -- Needs review
		S["CLASS_ANY"] = "任何职业" -- Needs review
		S["CLASS_NONE"] = "无" -- Needs review
		S["COMPLETED"] = "已完成" -- Needs review
		S["COMPLETION_DATES"] = "完成日期" -- Needs review
		S["DROP_TO_START_FORMAT"] = "掉落 %s 以开始 [%s]" -- Needs review
		S["ENABLE_COORDINATES"] = "启用显示玩家座标" -- Needs review
		S["ENTER_ZONE"] = "进入区域时取得" -- Needs review
		S["ESCORT"] = "护送" -- Needs review
		S["EVER_CAST"] = "曾经施放" -- Needs review
		S["EVER_COMPLETED"] = "代表一个任务从未完成过" -- Needs review
		S["EVER_EXPERIENCED"] = "有过经验" -- Needs review
		S["FACTION_BOTH"] = "联盟&部落" -- Needs review
		S["FIRST_PREREQUISITE"] = "前置任务链中的第一个：" -- Needs review
		S["GENDER"] = "性別" -- Needs review
		S["GENDER_BOTH"] = "男女皆可" -- Needs review
		S["GENDER_NONE"] = "无" -- Needs review
		S["GRAIL_NOT_HAVE"] = "|cFFFF0000Grail资料库内无此任务|r" -- Needs review
		S["HIGH_LEVEL"] = "高等级" -- Needs review
		S["HOLIDAYS_ONLY"] = "仅在节日时可取得：" -- Needs review
		S["IN_LOG"] = "已接" -- Needs review
		S["IN_LOG_STATUS"] = "在纪录中显示任务状态" -- Needs review
		S["INVALIDATE"] = "被以下任务停用：" -- Needs review
		S["IS_BREADCRUMB"] = "是下列任务的引导任务：" -- Needs review
		S["ITEM"] = "物品" -- Needs review
		S["ITEM_LACK"] = "缺少物品" -- Needs review
		S["KILL_TO_START_FORMAT"] = "击杀以开始 [%s]" -- Needs review
		S["LIVE_COUNTS"] = "即时更新计数" -- Needs review
		S["LOAD_DATA"] = "读取资料" -- Needs review
		S["LOREMASTER_AREA"] = "博学大师区域" -- Needs review
		S["LOW_LEVEL"] = "低等级" -- Needs review
		S["MAP"] = "地图" -- Needs review
		S["MAPAREA_NONE"] = "无" -- Needs review
		S["MAP_BUTTON"] = "在世界地图上显示按钮" -- Needs review
		S["MAP_DUNGEONS"] = "在外部地图显示副本任务" -- Needs review
		S["MAP_PINS"] = "在地图上显示任务给予者" -- Needs review
		S["MAP_UPDATES"] = "当区域变更时更新世界地图" -- Needs review
		S["MAXIMUM_LEVEL_NONE"] = "无" -- Needs review
		S["MULTIPLE_BREADCRUMB_FORMAT"] = "有 %d 个引导任务" -- Needs review
		S["MUST_KILL_PIN_FORMAT"] = "%s [击杀]" -- Needs review
		S["NEAR"] = "靠近" -- Needs review
		S["NEEDS_PREREQUISITES"] = "需要前置" -- Needs review
		S["NEVER_ABANDONED"] = "不可放弃" -- Needs review
		S["OAC"] = "接受时完成任务" -- Needs review
		S["OCC"] = "完成要求时完成任务" -- Needs review
		S["OTC"] = "缴交时完成任务" -- Needs review
		S["OTHER"] = "其他" -- Needs review
		S["OTHER_PREFERENCE"] = "其他" -- Needs review
		S["PANEL_UPDATES"] = "当变更区域时更新任务纪录视窗" -- Needs review
		S["PLOT"] = "空地" -- Needs review
		S["PREPEND_LEVEL"] = "显示任务等级" -- Needs review
		S["PREREQUISITES"] = "前置任务：" -- Needs review
		S["QUEST_COUNTS"] = "显示任务计数" -- Needs review
		S["QUEST_ID"] = "任务 ID：" -- Needs review
		S["QUEST_TYPE_NORMAL"] = "普通" -- Needs review
		S["RACE_ANY"] = "任何种族" -- Needs review
		S["RACE_NONE"] = "无" -- Needs review
		S["REPEATABLE"] = "可重复" -- Needs review
		S["REPEATABLE_COMPLETED"] = "显示已完成过的可重复任务" -- Needs review
		S["REPUTATION_REQUIRED"] = "声望要求：" -- Needs review
		S["REQUIRED_LEVEL"] = "等级要求" -- Needs review
		S["REQUIRES_FORMAT"] = "Wholly 需要 %s 或更新的 Grail版本" -- Needs review
		S["SEARCH_ALL_QUESTS"] = "所有任务" -- Needs review
		S["SEARCH_CLEAR"] = "清除" -- Needs review
		S["SEARCH_NEW"] = "新的" -- Needs review
		S["SELF"] = "自己" -- Needs review
		S["SHOW_BREADCRUMB"] = "在接受任务时如果跳过了引导任务，则显示警告" -- Needs review
		S["SHOW_LOREMASTER"] = "仅显示博学大师成就相关任务" -- Needs review
		S["SINGLE_BREADCRUMB_FORMAT"] = "可取得引导任务" -- Needs review
		S["SP_MESSAGE"] = "不会进入内建任务纪录的特殊任务" -- Needs review
		S["TAGS"] = "标记" -- Needs review
		S["TAGS_DELETE"] = "删除标记" -- Needs review
		S["TAGS_NEW"] = "添加标记" -- Needs review
		S["TITLE_APPEARANCE"] = "任务标题显示" -- Needs review
		S["TURNED_IN"] = "缴交" -- Needs review
		S["UNOBTAINABLE"] = "无法取得" -- Needs review
		S["WHEN_KILL"] = "击杀时取得：" -- Needs review
		S["WIDE_PANEL"] = "更宽的 Wholly 任务视窗" -- Needs review
		S["WIDE_SHOW"] = "显示" -- Needs review
		S["WORLD_EVENTS"] = "世界事件" -- Needs review
		S["YEARLY"] = "每年" -- Needs review
	elseif "zhTW" == locale then
		S["ABANDONED"] = "放棄" -- Needs review
		S["ACCEPTED"] = "已接受" -- Needs review
		S["ACHIEVEMENT_COLORS"] = "顯示成就完成顏色" -- Needs review
		S["APPEND_LEVEL"] = "顯示需要等級" -- Needs review
		S["BASE_QUESTS"] = "基礎任務" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLEMAPPINS = "開啟地圖標記" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLESHOWCOMPLETED = "顯示已完成任務" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLESHOWDAILIES = "顯示每日任務" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLESHOWNEEDSPREREQUISITES = "顯示需要前置的任務" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLESHOWREPEATABLES = "顯示重複任務" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLESHOWUNOBTAINABLES = "顯示無法取得任務" -- Needs review
		BINDING_NAME_WHOLLY_TOGGLESHOWWEEKLIES = "顯示每周任務" -- Needs review
		S["BLIZZARD_TOOLTIP"] = "在任務日誌顯示提示" -- Needs review
		S["BREADCRUMB"] = "後續任務：" -- Needs review
		S["BUGGED"] = "*** 有問題的 ***" -- Needs review
		S["BUGGED_UNOBTAINABLE"] = "將有BUG的任務視為不可取得" -- Needs review
		S["BUILDING"] = "建築" -- Needs review
		S["CHRISTMAS_WEEK"] = "聖誕週" -- Needs review
		S["CLASS_ANY"] = "任何職業" -- Needs review
		S["CLASS_NONE"] = "無" -- Needs review
		S["COMPLETED"] = "已完成" -- Needs review
		S["COMPLETION_DATES"] = "完成日期" -- Needs review
		S["DROP_TO_START_FORMAT"] = "掉落 %s 以開始  [%s]" -- Needs review
		S["ENABLE_COORDINATES"] = "啟用顯示玩家座標" -- Needs review
		S["ENTER_ZONE"] = "進入區域時取得" -- Needs review
		S["ESCORT"] = "護送" -- Needs review
		S["EVER_CAST"] = "曾經施放" -- Needs review
		S["EVER_COMPLETED"] = "代表一個任務從未完成過" -- Needs review
		S["EVER_EXPERIENCED"] = "有過經驗" -- Needs review
		S["FACTION_BOTH"] = "聯盟&部落" -- Needs review
		S["FIRST_PREREQUISITE"] = "前置任務鍊中的第一個：" -- Needs review
		S["GENDER"] = "性別" -- Needs review
		S["GENDER_BOTH"] = "男女皆可" -- Needs review
		S["GENDER_NONE"] = "無" -- Needs review
		S["GRAIL_NOT_HAVE"] = "Grail資料庫內無此任務" -- Needs review
		S["HIGH_LEVEL"] = "高等級" -- Needs review
		S["HOLIDAYS_ONLY"] = "僅在節日時可取得：" -- Needs review
		S["IN_LOG"] = "已接" -- Needs review
		S["IN_LOG_STATUS"] = "在紀錄中顯示任務狀態" -- Needs review
		S["INVALIDATE"] = "被以下任務停用：" -- Needs review
		S["IS_BREADCRUMB"] = "是下列的後續任務：" -- Needs review
		S["ITEM"] = "物品" -- Needs review
		S["ITEM_LACK"] = "缺少物品" -- Needs review
		S["KILL_TO_START_FORMAT"] = "擊殺以開始 [%s]" -- Needs review
		S["LIVE_COUNTS"] = "即時更新計數" -- Needs review
		S["LOAD_DATA"] = "讀取資料" -- Needs review
		S["LOREMASTER_AREA"] = "博學大師區域" -- Needs review
		S["LOW_LEVEL"] = "低等級" -- Needs review
		S["MAP"] = "地圖" -- Needs review
		S["MAPAREA_NONE"] = "無" -- Needs review
		S["MAP_BUTTON"] = "在世界地圖上顯示按鈕" -- Needs review
		S["MAP_DUNGEONS"] = "在外部地圖顯示副本任務" -- Needs review
		S["MAP_PINS"] = "在地圖上顯示任務給予者" -- Needs review
		S["MAP_UPDATES"] = "當區域變更時更新世界地圖" -- Needs review
		S["MAXIMUM_LEVEL_NONE"] = "無" -- Needs review
		S["MULTIPLE_BREADCRUMB_FORMAT"] = "有 %d 個後續任務" -- Needs review
		S["MUST_KILL_PIN_FORMAT"] = "%s [擊殺]" -- Needs review
		S["NEAR"] = "靠近" -- Needs review
		S["NEEDS_PREREQUISITES"] = "需要前置" -- Needs review
		S["NEVER_ABANDONED"] = "不可放棄" -- Needs review
		S["OAC"] = "接受時完成任務" -- Needs review
		S["OCC"] = "完成要求時完成任務" -- Needs review
		S["OTC"] = "繳交時完成任務" -- Needs review
		S["OTHER"] = "其他" -- Needs review
		S["OTHER_PREFERENCE"] = "其他" -- Needs review
		S["PANEL_UPDATES"] = "當變更區域時更新任務紀錄視窗" -- Needs review
		S["PLOT"] = "空地" -- Needs review
		S["PREPEND_LEVEL"] = "顯示任務等級" -- Needs review
		S["PREREQUISITES"] = "前置任務：" -- Needs review
		S["QUEST_COUNTS"] = "顯示任務計數" -- Needs review
		S["QUEST_ID"] = "任務 ID：" -- Needs review
		S["QUEST_TYPE_NORMAL"] = "普通" -- Needs review
		S["RACE_ANY"] = "任何種族" -- Needs review
		S["RACE_NONE"] = "無" -- Needs review
		S["REPEATABLE"] = "可重複" -- Needs review
		S["REPEATABLE_COMPLETED"] = "顯示已完成過的可重複任務" -- Needs review
		S["REPUTATION_REQUIRED"] = "聲望要求：" -- Needs review
		S["REQUIRED_LEVEL"] = "等級要求" -- Needs review
		S["REQUIRES_FORMAT"] = "Wholly 需要 %s 或更新的 Grail版本" -- Needs review
		S["SEARCH_ALL_QUESTS"] = "所有任務" -- Needs review
		S["SEARCH_CLEAR"] = "清除" -- Needs review
		S["SEARCH_NEW"] = "新的" -- Needs review
		S["SELF"] = "自己" -- Needs review
		S["SHOW_BREADCRUMB"] = "在任務提示中顯示後續任務資訊" -- Needs review
		S["SHOW_LOREMASTER"] = "僅顯示博學大師成就相關任務" -- Needs review
		S["SINGLE_BREADCRUMB_FORMAT"] = "可取得後續任務" -- Needs review
		S["SP_MESSAGE"] = "不會進入內建任務紀錄的特殊任務" -- Needs review
		S["TAGS"] = "標記" -- Needs review
		S["TAGS_DELETE"] = "刪除標記" -- Needs review
		S["TAGS_NEW"] = "加入標記" -- Needs review
		S["TITLE_APPEARANCE"] = "任務標題顯示" -- Needs review
		S["TURNED_IN"] = "繳交" -- Needs review
		S["UNOBTAINABLE"] = "無法取得" -- Needs review
		S["WHEN_KILL"] = "擊殺時取得：" -- Needs review
		S["WIDE_PANEL"] = "更寬的 Wholly 任務視窗" -- Needs review
		S["WIDE_SHOW"] = "顯示" -- Needs review
		S["WORLD_EVENTS"] = "世界事件" -- Needs review
		S["YEARLY"] = "每年" -- Needs review
	end

	-- The first group of these are actually taken from Blizzard's global
	-- variables that represent specific strings.  In other words, these
	-- do not need to be localized since Blizzard does the work for us.
	S['MAILBOX'] = MINIMAP_TRACKING_MAILBOX								-- "Mailbox"
	S['CREATED_ITEMS'] = NONEQUIPSLOT									-- "Created Items"
	S['SLASH_TARGET'] = SLASH_TARGET1									-- "/target"
	S['SPELLS'] = SPELLS												-- "Spells"
	S['FACTION'] = FACTION												-- "Faction"
	S['ALLIANCE'] = FACTION_ALLIANCE									-- "Alliance"
	S['HORDE'] = FACTION_HORDE											-- "Horde"
	S['ACHIEVEMENTS'] = ACHIEVEMENTS									-- "Achievements"
	S['PROFESSIONS'] = TRADE_SKILLS										-- "Professions"
	S['SKILL'] = SKILL													-- "Skill"
	S['STAGE_FORMAT'] = SCENARIO_STAGE									-- "Stage %d"
	S['CURRENTLY_EQUIPPED'] = CURRENTLY_EQUIPPED						-- "Currently Equipped"
	S['ILEVEL'] = ITEM_LEVEL_ABBR										-- "iLvl"
	S['UNAVAILABLE'] = UNAVAILABLE										-- "Unavailable"
	S['REMOVED'] = ACTION_SPELL_AURA_REMOVED							-- "removed"
	S['PENDING'] = PENDING_INVITE										-- "Pending"
	S['COMPLETED_FORMAT'] = DATE_COMPLETED								-- "Completed: %s"
	S['MAX_LEVEL'] = GUILD_RECRUITMENT_MAXLEVEL							-- "Max Level"
	S['FEMALE'] = FEMALE												-- "Female"
	S['MALE'] = MALE													-- "Male"
	S['REPUTATION_CHANGES'] = COMBAT_TEXT_SHOW_REPUTATION_TEXT			-- "Reputation Changes"
	S['QUEST_GIVERS'] = TUTORIAL_TITLE1									-- "Quest Givers"
	S['TURN_IN'] = TURN_IN_QUEST										-- "Turn in"
	S['DAILY'] = DAILY													-- "Daily"
	S['WEEKLY'] = CALENDAR_REPEAT_WEEKLY								-- "Weekly"
	S['MONTHLY'] = CALENDAR_REPEAT_MONTHLY								-- "Monthly"
	S['DUNGEON'] = CALENDAR_TYPE_DUNGEON								-- "Dungeon"
	S['RAID'] = CALENDAR_TYPE_RAID										-- "Raid"
	S['PVP'] = CALENDAR_TYPE_PVP										-- "PvP"
	S['GROUP'] = CHANNEL_CATEGORY_GROUP									-- "Group"
	S['HEROIC'] = PLAYER_DIFFICULTY2									-- "Heroic"
	S['SCENARIO'] = GUILD_CHALLENGE_TYPE4								-- "Scenario"
	S['IGNORED'] = IGNORED												-- "Ignored"
	S['FAILED'] = FAILED												-- "Failed"
	S['COMPLETE'] = COMPLETE											-- "Complete"
	S['ALPHABETICAL'] = COMPACT_UNIT_FRAME_PROFILE_SORTBY_ALPHABETICAL	-- "Alphabetical"
	S['LEVEL'] = LEVEL													-- "Level"
	S['TYPE'] = TYPE													-- "Type"
	S['TIME_UNKNOWN'] = TIME_UNKNOWN									-- "Unknown"
	S['FILTERS'] = FILTERS												-- "Filters"
	S['WORLD_MAP'] = WORLD_MAP											-- "World Map"
	S['FOLLOWERS'] = GARRISON_FOLLOWERS									-- "Followers"

	local C = Wholly.color
	Wholly.configuration = {
		{ S.BASE_QUESTS },
		{ S.COMPLETED, 'showsCompletedQuests', 'configurationScript1', nil, nil, 'C' },
		{ S.NEEDS_PREREQUISITES, 'showsQuestsThatFailPrerequsites', 'configurationScript1', true, nil, 'P' },
		{ S.UNOBTAINABLE, 'showsUnobtainableQuests', 'configurationScript1', true, nil, 'B' },
		{ S.FILTERS },
		{ S.REPEATABLE, 'showsRepeatableQuests', 'configurationScript1', nil, nil, 'R' },
		{ S.DAILY, 'showsDailyQuests', 'configurationScript1', true, nil, 'D' },
		{ S.IN_LOG, 'showsQuestsInLog', 'configurationScript1', true, nil, 'I' },
		{ S.LOW_LEVEL, 'showsLowLevelQuests', 'configurationScript1', nil, nil, 'W' },
		{ S.HIGH_LEVEL, 'showsHighLevelQuests', 'configurationScript1', true },
		{ S.SCENARIO, 'showsScenarioQuests', 'configurationScript1', true },
		{ S.WORLD_EVENTS, 'showsHolidayQuests', 'configurationScript1' },
		{ S.IGNORED, 'showsIgnoredQuests', 'configurationScript1', true },
		{ S.WEEKLY, 'showsWeeklyQuests', 'configurationScript1', true, nil, 'K' },
		{ S.TITLE_APPEARANCE },
		{ S.PREPEND_LEVEL, 'prependsQuestLevel', 'configurationScript1' },
		{ S.APPEND_LEVEL, 'appendRequiredLevel', 'configurationScript1' },
		{ S.REPEATABLE_COMPLETED, 'showsAnyPreviousRepeatableCompletions', 'configurationScript1' },
		{ S.IN_LOG_STATUS, 'showsInLogQuestStatus', 'configurationScript7' },
		{ S.WORLD_MAP },
		{ S.MAP_PINS, 'displaysMapPins', 'configurationScript2', nil, 'pairedConfigurationButton' },
		{ S.MAP_BUTTON, 'displaysMapFrame', 'configurationScript3' },
		{ S.MAP_DUNGEONS, 'displaysDungeonQuests', 'configurationScript4' },
		{ S.MAP_UPDATES, 'updatesWorldMapOnZoneChange', 'configurationScript1' },
		{ S.OTHER_PREFERENCE },
		{ S.PANEL_UPDATES, 'updatesPanelWhenZoneChanges', 'configurationScript1' },
		{ S.SHOW_BREADCRUMB, 'displaysBreadcrumbs', 'configurationScript5' },
		{ S.SHOW_LOREMASTER, 'showsLoremasterOnly', 'configurationScript4' },
		{ S.ENABLE_COORDINATES, 'enablesPlayerCoordinates', 'configurationScript8', nil, 'pairedCoordinatesButton' },
		{ S.ACHIEVEMENT_COLORS, 'showsAchievementCompletionColors', 'configurationScript1' },
		{ S.BUGGED_UNOBTAINABLE, 'buggedQuestsConsideredUnobtainable', 'configurationScript4' },
		{ S.BLIZZARD_TOOLTIP, 'displaysBlizzardQuestTooltips', 'configurationScript13' },
		{ S.WIDE_PANEL },
		{ S.WIDE_SHOW, 'useWidePanel', 'configurationScript11' },
		{ S.QUEST_COUNTS, 'showQuestCounts', 'configurationScript12', true },
		{ S.LIVE_COUNTS, 'liveQuestCountUpdates', 'configurationScript13', true },
		{ S.LOAD_DATA },
		{ S.ACHIEVEMENTS, 'loadAchievementData', 'configurationScript9' },
		{ S.REPUTATION_CHANGES, 'loadReputationData', 'configurationScript10', true },
		{ S.COMPLETION_DATES, 'loadDateData', 'configurationScript14', true },
		}

end
