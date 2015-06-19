local addonName = ...
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local addonList = {
	"Altoholic",
	"Altoholic_Summary",
	"Altoholic_Characters",
	"Altoholic_Search",
	"Altoholic_Guild",
	"Altoholic_Achievements",
	"Altoholic_Agenda",
	"Altoholic_Grids",
}

local url1 = "http://wow.curse.com/downloads/wow-addons/details/altoholic.aspx"
local url2 = "http://www.wowinterface.com/downloads/info8533-Altoholic.html"
local url3 = "http://wow.curseforge.com/addons/altoholic/localization/"

local help = {
	{	name = "General",
		questions = {
			"How do I remove a character that has been renamed/transfered/deleted?",
			"Does Altoholic support command line options?",
			"My minimap icon is gone, how do I get it back?",
			"What are the official homepages?",
			"What is this 'DataStore' thing? Why so many directories?",
			"I am developper, I want to know more about DataStore",
			"Does the add-on support FuBar?",
			"What is the add-on's memory footprint?",
			"Where have my suggestions gone?",
		},
		answers = {
			"Go into the 'Account Summary', mouse over the character, right-click it to get the contextual menu, and select 'Delete this Alt'.",
			"Type /alto or /altoholic to get the list of command line options.",
			"Go into Altoholic's main option panel, and check 'Show Minimap Icon'.\nYou can also type /alto show.",
			format("%s%s\n%s\n%s", "The add-on is only released on these two sites, it is recommended NOT TO get it through other means:", colors.green, url1, url2 ),
			"DataStore and its modules take care of storing data for client add-ons; Altoholic itself now only stores very little information. The main purpose of the numerous directories is to offer split databases, instead of one massive database containing all the information required by the add-on.",
			"Refer to DataStore's own help topic for more information.",
			"Not anymore. Instead, it supports LibDataBroker (aka LDB), if you really want FuBar, use Broker2FuBar.",
			"For 10 characters and 1 guild bank, the add-on takes around 4-5mb on my machine. Note that due to its name, the add-on is one of the first in the alphabet, and often gets credited of the memory/cpu usage of its libraries.",
			"Development is an iterative process, and I review parts of the add-on constantly. Depending on my spare time, some suggestions might take longer than others to make it into the add-on. Be patient, the add-on is still far from being complete.",
		}
	},
	{	name = "Containers",
		questions = {
			"Do I have to open all my bags to let the add-on know about their content?",
			"What about my bank? .. and my guild bank?",
			"Will the content of my bags be visible in the tooltip? Can I configure that?",
		},
		answers = {
			"No. This happens silently and does not require any action from your part.",
			"You have to open your bank in order to let the add-on read its content. Same goes for the guild bank, except that the add-on can only read it tab per tab, so make sure to open them all.",
			"Yes. There are several tooltip options that can be set to specify what you want to see or not."
		}
	},
	{	name = "Professions",
		questions = {
			"Do I have to open all professions manually?",
		},
		answers = {
			"Yes. Some advanced features require that you open the tradeskill pane once per profession.",
		}
	},
	{	name = "Mails",
		questions = {
			"Can Altoholic read my mails without being at the mailbox?",
			"Altoholic marks all my mails as read, how can I avoid that?",
			"My mailbox is full, can Altoholic read beyond the list of visible mails?",
		},
		answers = {
			"No. This is a restriction imposed by Blizzard. Your character must physically be at a mailbox to retrieve your mails.",
			"Go into the 'Options -> DataStore -> DataStore_Mails' and disable 'Scan mail body'.",
			"No. You will have to clear your mailbox to release mails that are queued server-side.",
		}
	},
	{	name = "Localization",
		questions = {
			"I found a bad translation, how can I help fixing it?",
		},
		answers = {
			format("Use the CurseForge localization tool, at %s|r.", colors.green..url3),
		}
	},
}	

local support = {
	{	name = "Reporting Bugs",
		questions = {
			"I found an error, how/where do I report it?",
			"What should I do before reporting?",
			"I just upgraded to the latest version, and there are so many Lua errors, what the..??",
			"I have multiple Lua errors at login, should I report them all?",
		},
		answers = {
			"Both Curse and WoWInterface have a ticket section, I also read comments and respond as often as I materially can, so feel free to report in one of these places.",
			format("%s\n\n%s\n%s\n%s\n%s\n%s\n", 
				"A few things:",
				colors.green.."1)|r Make sure you have the latest version of the add-on.\n",
				colors.green.."2)|r If you suspect a conflict with another add-on, try to reproduce the issue with only Altoholic enabled. As the add-on deals with a lot of things, a conflict is always possible.\n",
				colors.green.."3)|r Make sure your issue has not been reported by someone else.\n",
				colors.green.."4)|r Never, ever, report that 'it does not work', this is the most useless sentence in the world! Be specific about what does not work.\n",
				colors.green.."5)|r DO NOT copy the entire add-on list from Swatter. While conflicts are possible, they are the exception rather than the rule."
			),
			"I'm just human, I make mistakes. But because I'm human, I fix them too, so be patient. This is a project that I develop in my spare time, and it fluctuates a lot.",
			"No. Only the first error you will get is relevant, it means that something failed during the initialization process of the add-on, or of a library, and this is likely to cause several subsequent errors that are more often than not irrelevant.",
		}
	},
	{	name = "Live support",
		questions = {
			"Is there an IRC channel where I could get live support?",
		},
		answers = {
			format("Yes. Join the %s#altoholic|r IRC channel on Freenode : %sirc://irc.freenode.net:6667/|r", colors.white, colors.green),
		}
	},
}

-- this content will be subject to frequent changes, do not bother translating it !!
local whatsnew = {
	{	name = "6.1.006 Changes",
		bulletedList = {
			"Updated list of archaeology projects with WoD projects. I apparently messed up and lost the file that contained the update in 6.1.001, it's now ok.",
			"Moved several UI templates to their own folder.",
			"Completely rewrote the Blizzard's DropDownMenu widget to use my own version.",
			"Account Summary -> The amount of uncollected garrison resources now appears in yellow when resources exceed 300, and in red when they exceed 450.",
			"Account Summary -> Added icons with drop-down menus to filter your list of alts by faction, level, profession and class.",
			"Account Summary -> Fixed the expand/collapse button that did not work anymore after the complete rewrite of the pane.",
			"Achievements lists updated ! (Thanks Bluemage29 for your help !!)",
			"Fixed a Lua error when viewing the Guild tab with an character not in a guild.",
		},
	},
	{	name = "6.1.005 Changes",
		bulletedList = {
			"The garrison mission tooltip now shows a red exclamation mark '!' when no missions are active.",
			"In the account summary, the last column used to sort the view is now remembered, and is restored when you log in again.",
			"Character's tab: fixed a lua error when mousing over the professions' icon of a character that does not have 2 professions.",
			"Account Summary: modified the garrison followers pane to show followers at iLvl 675 and a column for their weapon/armor iLvl.",
		},
	},
	{	name = "6.1.004 Changes",
		bulletedList = {
			"Fixed sorting the account summary by 'Last Online' where the order was sometimes incorrect.",
			"Added an option to show the tooltip counters without details (no 'equipped', 'bank', ..). Disabled by default.",
			"No longer wiping the list of followers before scanning them.",
			"Added a tooltip to the garrison resources in the account summary, it now shows when resources were last collected, and when you will reach the maximum of uncollected resources.",
			"Fixed incorrect tooltip after multiple searches in the search tab.",
			"DataStore_Garrisons: Some clean-up to properly report active missions.",
			"The garrison mission tooltip that shows a '*' when missions are complete now shows it in red if all active missions are complete.",
		},
	},
	{	name = "6.1.003 Changes",
		bulletedList = {
			"Fixed a few lua errors in the account summary tab.",
			"Added Draenor LFR dungeons to the Grids->Dungeon Finder pane.",
		},
	},
	{	name = "6.1.002 Changes",
		bulletedList = {
			"Updated scanning of currencies (honor points), total no longer needs to be divided by 100 since 6.1.",
			"Updated the garrison followers pane in the account summary to show followers with an iLvl greater than 660.",
			"DataStore Characters: updated GetRestXPRate() to account for Pandaren extra rest xp.",
			"Fixed Auction House scanning, and cleaning of expired auctions.",
			"The summary tab has been fully rewritten so that all 6 panes use the same frames. ",
		},
	},
	{	name = "6.1.001 Changes",
		bulletedList = {
			"Added support for Garrison missions ! Warnings are not in yet, but available and active missions are now visible in the characters' tab.",
			"Note: Active missions can only be correctly tracked if the mission is started with this version of Altoholic, so currently active missions will be visible, but their expiration will not.",
			"Fixed the spam of mail expiry warnings, this time for good (hopefully ! feedback appreciated on this one!).",
			"Now refreshing the follower's pane immediately when the followers' list is updated.",
			"Updated list of followers not recruited at the inn.",
			"Updated list of archaeology projects with WoD projects.",
			"Cleaned up the .pkgmeta of DataStore modules, my sources tell me this should prevent some problems with the Curse Client :) (Thanks Myrroddin !)",
			"Removed 'already known/could be learned by' information from tooltips for companions, as they have been account-wide for a while.",
			"More code cleanup.",
		},
	},
	{	name = "6.0.004 Changes",
		bulletedList = {
			"A massive code cleanup was performed in the XML frames",
			"Many options were not saved correctly, this has been fixed, as a result, these options have been reset (tooltip options, etc..).",
			"This options bug had, among others, impact on the account sharing feature that couldn't be launched anymore, Thanks Elfana for helping me on this !",
			"DataStore_Garrisons: Fixed scanning collection of garrison cache resources. It could occasionally be wrongly reset when getting resources from other sources.",
			"DataStore_Garrisons: Followers are now stored based on their id's, instead of their names. You will have to check your missions' table again with your alts to update follower information.",
			"DataStore_Garrisons: added a slider to configure when the reporting for uncollected resources should happen (350 -> 475).",
			"Grids -> Garrison Followers: added a drop down list to filter followers on whether they are collected, not collected, and if they were recruited at the inn or not.",
			"Garrison blueprints now appear in red if already known, I applied the same rule as for BOP recipes from Garrison trainers, thus any BOP item with 'Already known' will appear red in a merchant frame.",
			"DataStore_Agenda: fixed another Lua error at logon introduced with previous fix. (Thanks again SpareSimian!)",
			"DataStore_Mails: added an option to report mails about to expire to the chat frame, in addition to the already existing dialog box. This will allow you to see on which alt the mail can be found. Please keep me informed if you detect real bugs thanks to this.",
		},
	},
	{	name = "6.0.003 Changes",
		bulletedList = {
			"DataStore_Garrisons: fixed a bug where saved buildings are deleted from the DB.",
			"Added tracking of uncollected garrison resources. They can be seen in the currency pane of the account summary.",
			"Added a warning when uncollected garrison resources are >400 on a given alt. There is an option to disable this warning if you want to.",
			"Added Garrison-related achievements, now listed in a proper way in the achievements' tab.",
			"Recipes bought at garrison trainers now appear in red if they are BOP and already known.",
			"Removed mounts from the addon, as they have been account-wide for a while now. The icon is still there as a placeholder in the grids tab though.",
			"DataStore_Pets: removed all mount-related functions and data tables.",
			"DataStore_Mails: fixed a bug where the addon kept complaining about old mails about to expire. This one is long overdue, thanks to Wispor and Elfana for helping me on this one !",
			"Fixed 'Player not found' message. (Bug 779 / Thanks Phinar !)",
			"DataStore_Achievements: fixed an error caused by achievements with invalid id (as returned by the game's API). (Bug 792 / Thanks SpareSimian)",
			"DataStore_Agenda: fixed a Lua error at logon. (Bug 792 also / Thanks SpareSimian)",
		},
	},
	{	name = "6.0.002 Changes",
		bulletedList = {
			"New DataStore module : DataStore_Garrisons ! You have to visit the missions table to scan followers.",
			"Grids tab: added a pane for Garrison followers.",
			"Grids tab: added a pane for Garrison buildings.",
			"DataStore_Containers: now scanning the reagent bank at logon.",
			"Account Summary : updated the currency pane to remove valor and justice tokens, and replace them with garrison resources, apexis crystals, and seals of tempered fate.",
			"Account Summary : added a pane for Garrison followers.",
			"Fixed a Lua error when talking to an enchanting follower in the garrison.",
			"Fixed professions not being scanned entirely since 6.0 (Thanks Myrrodin & CKaotic), I did revert the part about followers though, to use IsNPCCrafting() instead.",
			"A lot of minor fixes.",
		},
	},
	{	name = "6.0.001 Changes",
		bulletedList = {
			"Added a pane in the Grids tab to track LFR lockouts across alts.",
			"Added support for the new void storage tab + reagent bank.",
			"Updated achievement lists.",
			"Updated tradeskills data (Grids tab)",
			"Fixed WoD related issues.",
			"DataStore_Reputations: fixed WoD compatibility.",
			"DataStore_Reputations: LibBabble-Factions is back.",
			"DataStore_Talents: talents & glyph scanning is temporarily fully disabled. UI is still missing too, sorry about that.",
			"DataStore_Quests: fixed WoD compatibility.",
			"DataStore_Containers: Added support for the new void storage tab.",
			"DataStore_Containers: Added support for the new reagent bank.",
			"LibCraftInfo: updated for WoD.",
			"LibCraftLevels: updated for WoD.",
			"LibCraftReagent: updated for WoD.",
			"Currencies pane: removed unrequired tooltip.",
		},
	},
	{	name = "Earlier changes",
		textLines = {
			"Refer to |cFF00FF00changelog.txt",
		},
	},
}

function addon:GetOption(name)
	if addon.db and addon.db.global and addon.db.global.options then
		return addon.db.global.options[name]
	end
end

function addon:SetOption(name, value)
	if addon.db and addon.db.global and addon.db.global.options then 
		addon.db.global.options[name] = value
	end
end

function addon:ToggleOption(frame, option)
	local value
	
	if frame then
		value = frame:GetChecked() and true or false
	else
		value = not addon:GetOption(option)
	end
	
	addon:SetOption(option, value)
end

function addon:SetupOptions()
	-- create categories in Blizzard's options panel
	
	DataStore:AddOptionCategory(AltoholicGeneralOptions, addonName)
	LibStub("LibAboutPanel").new(addonName, addonName);
	DataStore:AddOptionCategory(AltoholicHelp, HELP_LABEL, addonName)
	DataStore:AddOptionCategory(AltoholicSupport, "Getting support", addonName)
	DataStore:AddOptionCategory(AltoholicWhatsNew, "What's new?", addonName)
	DataStore:AddOptionCategory(AltoholicMemoryOptions, L["Memory used"], addonName)
	DataStore:AddOptionCategory(AltoholicSearchOptions, SEARCH, addonName)
	DataStore:AddOptionCategory(AltoholicMailOptions, MAIL_LABEL, addonName)
	DataStore:AddOptionCategory(AltoholicMiscOptions, MISCELLANEOUS, addonName)
	DataStore:AddOptionCategory(AltoholicAccountSharingOptions, L["Account Sharing"], addonName)
	DataStore:AddOptionCategory(AltoholicSharedContent, "Shared Content", addonName)
	DataStore:AddOptionCategory(AltoholicTooltipOptions, L["Tooltip"], addonName)
	DataStore:AddOptionCategory(AltoholicCalendarOptions, L["Calendar"], addonName)

	DataStore:SetupInfoPanel(help, AltoholicHelp_Text)
	DataStore:SetupInfoPanel(support, AltoholicSupport_Text)
	DataStore:SetupInfoPanel(whatsnew, AltoholicWhatsNew_Text)
	
	help = nil
	support = nil
	whatsnew = nil
	
	local value
	local f = AltoholicGeneralOptions
	
	-- ** General **
	f.Title:SetText(colors.teal..format("%s %s", addonName, addon.Version))
	f.ShowRestXP150pc.Text:SetText(L["Max rest XP displayed as 150%"])
	f.BankAutoUpdate.Text:SetText(L["Automatically authorize guild bank updates"])
	f.BankAutoUpdate.tooltip = format("%s%s%s",
		L["|cFFFFFFFFWhen |cFF00FF00enabled|cFFFFFFFF, this option will allow other Altoholic users\nto update their guild bank information with yours automatically.\n\n"],
		L["When |cFFFF0000disabled|cFFFFFFFF, your confirmation will be\nrequired before sending any information.\n\n"],
		L["Security hint: disable this if you have officer rights\non guild bank tabs that may not be viewed by everyone,\nand authorize requests manually"])
	
	f.ClampWindowToScreen.Text:SetText(L["Clamp window to screen"])
	
	L["|cFFFFFFFFWhen |cFF00FF00enabled|cFFFFFFFF, this option will allow other Altoholic users\nto update their guild bank information with yours automatically.\n\n"] = nil
	L["When |cFFFF0000disabled|cFFFFFFFF, your confirmation will be\nrequired before sending any information.\n\n"] = nil
	L["Security hint: disable this if you have officer rights\non guild bank tabs that may not be viewed by everyone,\nand authorize requests manually"] = nil
	L["Max rest XP displayed as 150%"] = nil
	L["Automatically authorize guild bank updates"] = nil
	
	value = AltoholicGeneralOptions_SliderAngle:GetValue()
	AltoholicGeneralOptions_SliderAngle.tooltipText = L["Move to change the angle of the minimap icon"]
	AltoholicGeneralOptions_SliderAngleLow:SetText("1");
	AltoholicGeneralOptions_SliderAngleHigh:SetText("360"); 
	AltoholicGeneralOptions_SliderAngleText:SetText(format("%s (%s)", L["Minimap Icon Angle"], value))
	L["Move to change the angle of the minimap icon"] = nil
	
	value = AltoholicGeneralOptions_SliderRadius:GetValue()
	AltoholicGeneralOptions_SliderRadius.tooltipText = L["Move to change the radius of the minimap icon"]; 
	AltoholicGeneralOptions_SliderRadiusLow:SetText("1");
	AltoholicGeneralOptions_SliderRadiusHigh:SetText("200"); 
	AltoholicGeneralOptions_SliderRadiusText:SetText(format("%s (%s)", L["Minimap Icon Radius"], value))
	L["Move to change the radius of the minimap icon"] = nil
	
	f = AltoholicGeneralOptions
	f.ShowMinimapIcon.Text:SetText(L["Show Minimap Icon"])
	L["Show Minimap Icon"] = nil
	
	value = AltoholicGeneralOptions_SliderAlpha:GetValue()
	AltoholicGeneralOptions_SliderAlphaLow:SetText("0.1");
	AltoholicGeneralOptions_SliderAlphaHigh:SetText("1.0"); 
	AltoholicGeneralOptions_SliderAlphaText:SetText(format("%s (%1.2f)", L["Transparency"], value));
	
	-- ** Memory **
	AltoholicMemoryOptions_AddonsText:SetText(colors.orange..ADDONS)
	local list = ""
	for index, module in ipairs(addonList) do
		list = format("%s%s:\n", list, module)
	end

	list = format("%s\n%s", list, format("%s:", L["Memory used"]))
	
	AltoholicMemoryOptions_AddonsList:SetText(list)
	
	-- ** Search **
	f = AltoholicSearchOptions
	f.ItemInfoAutoQuery.Text:SetText(L["AutoQuery server |cFFFF0000(disconnection risk)"])
	f.ItemInfoAutoQuery.tooltip = format("%s%s%s%s",
		L["|cFFFFFFFFIf an item not in the local item cache\nis encountered while searching loot tables,\nAltoholic will attempt to query the server for 5 new items.\n\n"],
		L["This will gradually improve the consistency of the searches,\nas more items are available in the item cache.\n\n"],
		L["There is a risk of disconnection if the queried item\nis a loot from a high level dungeon.\n\n"],
		L["|cFF00FF00Disable|r to avoid this risk"])	
	
	f.IncludeNoMinLevel.Text:SetText(L["Include items without level requirement"])
	f.IncludeMailboxItems.Text:SetText(L["Include mailboxes"])
	f.IncludeGuildBankItems.Text:SetText(L["Include guild bank(s)"])
	f.IncludeKnownRecipes.Text:SetText(L["Include known recipes"])
	L["AutoQuery server |cFFFF0000(disconnection risk)"] = nil
	L["Sort loots in descending order"] = nil
	L["Include items without level requirement"] = nil
	L["Include mailboxes"] = nil
	L["Include guild bank(s)"] = nil
	L["Include known recipes"] = nil
	
	-- ** Mail **
	value = AltoholicMailOptions_SliderTimeToNextWarning:GetValue()
	AltoholicMailOptions_SliderTimeToNextWarning.tooltipText = L["TIME_TO_NEXT_WARNING_TOOLTIP"]
	AltoholicMailOptions_SliderTimeToNextWarningLow:SetText("1");
	AltoholicMailOptions_SliderTimeToNextWarningHigh:SetText("12"); 
	AltoholicMailOptions_SliderTimeToNextWarningText:SetText(format("%s (%s)", L["TIME_TO_NEXT_WARNING_TEXT"], format(D_HOURS, value)))

	f = AltoholicMailOptions
	f.GuildMailWarning.Text:SetText(L["New mail notification"])
	f.GuildMailWarning.tooltip = format("%s",	L["Be informed when a guildmate sends a mail to one of my alts.\n\nMail content is directly visible without having to reconnect the character"])
	f.AutoCompleteRecipient.Text:SetText("Auto-complete recipient name" )
	L["New mail notification"] = nil

	f = AltoholicMiscOptions
	f.AHColorCoding.Text:SetText(L["Use color-coding for recipes at the AH"])
	f.VendorColorCoding.Text:SetText(L["Use color-coding for recipes at vendors"])
				
	-- ** Account Sharing **
	f = AltoholicAccountSharingOptions
	f.Text1:SetText(colors.white.."Authorizations")
	f.Text2:SetText(colors.white..L["Character"])
	f.IconNever:SetText("\124TInterface\\RaidFrame\\ReadyCheck-NotReady:14\124t")
	f.IconAsk:SetText("\124TInterface\\RaidFrame\\ReadyCheck-Waiting:14\124t")
	f.IconAuto:SetText("\124TInterface\\RaidFrame\\ReadyCheck-Ready:14\124t")
	f.IsEnabled.Text:SetText(L["Account Sharing Enabled"])
	f.IsEnabled.tooltip = format("%s%s%s%s",
		L["|cFFFFFFFFWhen |cFF00FF00enabled|cFFFFFFFF, this option will allow other Altoholic users\nto send you account sharing requests.\n"],
		L["Your confirmation will still be required any time someone requests your information.\n\n"],
		L["When |cFFFF0000disabled|cFFFFFFFF, all requests will be automatically rejected.\n\n"],
		L["Security hint: Only enable this when you actually need to transfer data,\ndisable otherwise"])

	L["Account Sharing Enabled"] = nil
	L["|cFFFFFFFFWhen |cFF00FF00enabled|cFFFFFFFF, this option will allow other Altoholic users\nto send you account sharing requests.\n"] = nil
	L["Your confirmation will still be required any time someone requests your information.\n\n"] = nil
	L["When |cFFFF0000disabled|cFFFFFFFF, all requests will be automatically rejected.\n\n"] = nil
	L["Security hint: Only enable this when you actually need to transfer data,\ndisable otherwise"] = nil

	AltoholicAccountSharingOptions_InfoButton.tooltip = format("%s\n%s\n\n%s", 
	
	colors.white.."This list allows you to automate responses to account sharing requests.",
	"You can choose to automatically accept or reject requests, or be asked when a request comes in.",
	"If account sharing is totally disabled, this list will be ignored, and all requests will be rejected." )
	
	
	-- ** Shared Content **
	AltoholicSharedContentText1:SetText(colors.white.."Shared Content")
	AltoholicSharedContent_SharedContentInfoButton.tooltip = format("%s\n%s", 
		colors.white.."Select the content that will be visible to players who send you",
		"account sharing requests.")
	
	
	-- ** Tooltip **
	f = AltoholicTooltipOptions
	f.ShowItemSource.Text:SetText(L["Show item source"])
	f.ShowItemCount.Text:SetText(L["Show item count per character"])
	f.ShowSimpleCount.Text:SetText(L["Show item count without details"])
	f.ShowTotalItemCount.Text:SetText(L["Show total item count"])
	f.ShowKnownRecipes.Text:SetText(L["Show recipes already known/learnable by"])
	f.ShowItemID.Text:SetText(L["Show item ID and item level"])
	f.ShowGatheringNodesCount.Text:SetText(L["Show counters on gathering nodes"])
	f.ShowCrossFactionCount.Text:SetText(L["Show counters for both factions"])
	f.ShowMergedRealmsCount.Text:SetText(L["Show counters for connected realms"])
	f.ShowAllAccountsCount.Text:SetText(L["Show counters for all accounts"])
	f.ShowGuildBankCount.Text:SetText(L["Show guild bank count"])
	f.IncludeGuildBankInTotal.Text:SetText(L["Include guild bank count in the total count"])
	f.ShowGuildBankCountPerTab.Text:SetText(L["Detailed guild bank count"])
	L["Show item source"] = nil
	L["Show item count per character"] = nil
	L["Show item count without details"] = nil
	L["Show total item count"] = nil
	L["Show guild bank count"] = nil
	L["Show already known/learnable by"] = nil
	L["Show recipes already known/learnable by"] = nil
	L["Show item ID and item level"] = nil
	L["Show counters on gathering nodes"] = nil
	L["Show counters for both factions"] = nil
	L["Show counters for all accounts"] = nil
	L["Include guild bank count in the total count"] = nil
	
	-- ** Calendar **
	f = AltoholicCalendarOptions
	f.WeekStartsOnMonday.Text:SetText(L["Week starts on Monday"])
	f.UseDialogBoxForWarnings.Text:SetText(L["Display warnings in a dialog box"])
	f.WarningsEnabled.Text:SetText(L["Disable warnings"])
	L["Week starts on Monday"] = nil
	L["Warn %d minutes before an event starts"] = nil
	L["Display warnings in a dialog box"] = nil
	
	for i = 1, 4 do 
		addon:DDM_Initialize(_G["AltoholicCalendarOptions_WarningType"..i], Altoholic.Events.WarningType_Initialize)
	end
	UIDropDownMenu_SetText(AltoholicCalendarOptions_WarningType1, "Profession Cooldowns")
	UIDropDownMenu_SetText(AltoholicCalendarOptions_WarningType2, "Dungeon Resets")
	UIDropDownMenu_SetText(AltoholicCalendarOptions_WarningType3, "Calendar Events")
	UIDropDownMenu_SetText(AltoholicCalendarOptions_WarningType4, "Item Timers")
end

function addon:RestoreOptionsToUI()
	local O = Altoholic.db.global.options
	
	local f = AltoholicGeneralOptions
	
	f.ShowRestXP150pc:SetChecked(O["UI.Tabs.Summary.ShowRestXP150pc"])
	f.BankAutoUpdate:SetChecked(O["UI.Tabs.Guild.BankAutoUpdate"])
	f.ClampWindowToScreen:SetChecked(O["UI.ClampWindowToScreen"])

	AltoholicGeneralOptions_SliderAngle:SetValue(O["UI.Minimap.IconAngle"])
	AltoholicGeneralOptions_SliderRadius:SetValue(O["UI.Minimap.IconRadius"])
	f.ShowMinimapIcon:SetChecked(O["UI.Minimap.ShowIcon"])
	AltoholicGeneralOptions_SliderScale:SetValue(O["UI.Scale"])
	AltoholicFrame:SetScale(O["UI.Scale"])
	AltoholicGeneralOptions_SliderAlpha:SetValue(O["UI.Transparency"])

	-- set communication handlers according to user settings.
	if O["UI.AccountSharing.IsEnabled"] then
		Altoholic.Comm.Sharing:SetMessageHandler("ActiveHandler")
	else
		Altoholic.Comm.Sharing:SetMessageHandler("EmptyHandler")
	end
	
	
	f = AltoholicSearchOptions
	
	f.ItemInfoAutoQuery:SetChecked(O["UI.Tabs.Search.ItemInfoAutoQuery"])
	f.IncludeNoMinLevel:SetChecked(O["UI.Tabs.Search.IncludeNoMinLevel"])
	f.IncludeMailboxItems:SetChecked(O["UI.Tabs.Search.IncludeMailboxItems"])
	f.IncludeGuildBankItems:SetChecked(O["UI.Tabs.Search.IncludeGuildBankItems"])
	f.IncludeKnownRecipes:SetChecked(O["UI.Tabs.Search.IncludeKnownRecipes"])

	AltoholicSearchOptionsLootInfo:SetText(colors.green .. O.TotalLoots .. "|r " .. L["Loots"] .. " / " .. colors.green .. O.UnknownLoots .. "|r " .. L["Unknown"])
	AltoholicSearchOptionsLootInfo:SetText(format("%s%s|r %s / %s%s|r %s", colors.green, O.TotalLoots, L["Loots"], colors.green, O.UnknownLoots, L["Unknown"]))
	
	f = AltoholicMailOptions
	AltoholicMailOptions_SliderTimeToNextWarning:SetValue(O["UI.Mail.TimeToNextWarning"])
	f.GuildMailWarning:SetChecked(O["UI.Mail.GuildMailWarning"])
	f.AutoCompleteRecipient:SetChecked(O["UI.Mail.AutoCompleteRecipient"])
	
	f = AltoholicMiscOptions
	f.AHColorCoding:SetChecked(O["UI.AHColorCoding"])
	f.VendorColorCoding:SetChecked(O["UI.VendorColorCoding"])
	
	f = AltoholicAccountSharingOptions
	f.IsEnabled:SetChecked(O["UI.AccountSharing.IsEnabled"])
	
	f = AltoholicTooltipOptions
	f.ShowItemSource:SetChecked(O["UI.Tooltip.ShowItemSource"])
	f.ShowItemCount:SetChecked(O["UI.Tooltip.ShowItemCount"])
	f.ShowTotalItemCount:SetChecked(O["UI.Tooltip.ShowTotalItemCount"])
	f.ShowKnownRecipes:SetChecked(O["UI.Tooltip.ShowKnownRecipes"])
	f.ShowItemID:SetChecked(O["UI.Tooltip.ShowItemID"])
	f.ShowGatheringNodesCount:SetChecked(O["UI.Tooltip.ShowGatheringNodesCount"])
	f.ShowCrossFactionCount:SetChecked(O["UI.Tooltip.ShowCrossFactionCount"])
	f.ShowMergedRealmsCount:SetChecked(O["UI.Tooltip.ShowMergedRealmsCount"])
	f.ShowAllAccountsCount:SetChecked(O["UI.Tooltip.ShowAllAccountsCount"])
	f.ShowGuildBankCount:SetChecked(O["UI.Tooltip.ShowGuildBankCount"])
	f.IncludeGuildBankInTotal:SetChecked(O["UI.Tooltip.IncludeGuildBankInTotal"])
	f.ShowGuildBankCountPerTab:SetChecked(O["UI.Tooltip.ShowGuildBankCountPerTab"])
	
	f = AltoholicCalendarOptions
	f.WeekStartsOnMonday:SetChecked(O["UI.Calendar.WeekStartsOnMonday"])
	f.UseDialogBoxForWarnings:SetChecked(O["UI.Calendar.UseDialogBoxForWarnings"])
	f.WarningsEnabled:SetChecked(O["UI.Calendar.WarningsEnabled"])
end

function addon:UpdateMinimapIconCoords()
	-- Thanks to Atlas for this code, modified to fit this addon's requirements though
	local xPos, yPos = GetCursorPosition() 
	local left, bottom = Minimap:GetLeft(), Minimap:GetBottom() 

	xPos = left - xPos/UIParent:GetScale() + 70 
	yPos = yPos/UIParent:GetScale() - bottom - 70 

	local iconAngle = math.deg(math.atan2(yPos, xPos))
	if(iconAngle < 0) then
		iconAngle = iconAngle + 360
	end
	
	addon:SetOption("UI.Minimap.IconAngle", iconAngle)
	AltoholicGeneralOptions_SliderAngle:SetValue(iconAngle)
end

function addon:MoveMinimapIcon()
	local radius = addon:GetOption("UI.Minimap.IconRadius")
	local angle = addon:GetOption("UI.Minimap.IconAngle")
	
	AltoholicMinimapButton:SetPoint( "TOPLEFT", "Minimap", "TOPLEFT", 54 - (radius * cos(angle)), (radius * sin(angle)) - 55 );
end

function addon:UpdateMyMemoryUsage()
	DataStore:UpdateMemoryUsage(addonList, AltoholicMemoryOptions, format("%s:", L["Memory used"]))
end

local function ResizeScrollFrame(frame, width, height)
	-- just a small wrapper, nothing generic in here.
	
	local name = frame:GetName()
	_G[name]:SetWidth(width-45)
	_G[name.."_ScrollFrame"]:SetWidth(width-45)
	_G[name]:SetHeight(height-30)
	_G[name.."_ScrollFrame"]:SetHeight(height-30)
	_G[name.."_Text"]:SetWidth(width-80)
end

local OnSizeUpdate = {	-- custom resize functions
	AltoholicHelp = ResizeScrollFrame,
	AltoholicSupport = ResizeScrollFrame,
	AltoholicWhatsNew = ResizeScrollFrame,
}

local OptionsPanelWidth, OptionsPanelHeight
local lastOptionsPanelWidth = 0
local lastOptionsPanelHeight = 0

function addon:OnUpdate(self, mandatoryResize)
	OptionsPanelWidth = InterfaceOptionsFramePanelContainer:GetWidth()
	OptionsPanelHeight = InterfaceOptionsFramePanelContainer:GetHeight()
	
	if not mandatoryResize then -- if resize is not mandatory, allow exit
		if OptionsPanelWidth == lastOptionsPanelWidth and OptionsPanelHeight == lastOptionsPanelHeight then return end		-- no size change ? exit
	end
		
	lastOptionsPanelWidth = OptionsPanelWidth
	lastOptionsPanelHeight = OptionsPanelHeight
	
	local frameName = self:GetName()
	if frameName and OnSizeUpdate[frameName] then
		OnSizeUpdate[frameName](self, OptionsPanelWidth, OptionsPanelHeight)
	end
end
