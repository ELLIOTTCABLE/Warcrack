--[[
************************************************************************
Project				: Broker_Factions
Author				: zhinjio
Project Revision	: 3.2.5-release
Project Date		: 20110515000702

File				: Locales\zhTW.lua
Commit Author		: zhinjio
Commit Revision		: 4
Commit Date			: 20110503035214
************************************************************************
Description	:
	Traditional Chinese translation strings
TODO		:
************************************************************************
--]]
local MODNAME = "BFactions"
local L = LibStub:GetLibrary("AceLocale-3.0"):NewLocale( MODNAME, "zhTW" )
if not L then return end

L["%s to go"] = "尚欠 %s"
L["Activates and displays a scrolling slider bar, for the tooltip."] = "開啟鼠標提示側欄的滾動條"
L["Appends a '+' label suffix to collapsed faction headers (assuming collapsed headers are shown)."] = "在最小化的右側添加添加一個『+』符號 (當顯示最小化的陣營標題開啟時此選項有效)"
L["Appends faction standing, to the button label."] = "在按鈕中顯示陣營關係"
L["Appends percentage values to the button label."] = "在按鈕中顯示聲望百分比數值"
L["Appends raw numbers in the form of (xxx/xxxx), to the button label."] = "以 (xxx/xxxx) 的格式在按鈕中顯示聲望的具體數值"
L["Appends remaining reputation to reach the next standing, to the button label."] = "在按鈕中顯示達到下一關係所需獲得的聲望數"
L["Appends session reputation gains in the form of [xxx], to the button label."] = "以 [xxx] 的格式在按鈕中顯示當前區間獲得的聲望總量"
L["Author : "] = "作者 : " -- Needs review
L["Auto faction watch on reputation gains"] = "自動監視獲得聲望的陣營"
L["Automatically sets the faction watched on the button/block to the last faction you gained reputation with."] = "自動監視你最近獲得聲望的陣營，將它顯示在你的按鈕/模組上"
L["Build Date : "] = "建立日期 : " -- Needs review
L["Button"] = "按鈕顯示設置"
L["Change color of percentages/raw numbers/'to go' according to faction reputation standing."] = "根據陣營聲望的高低彩色化顯示百分比、精確數值以及『尚欠』文字"
-- L["Click header lines to expand/contract"] = "Click header lines to expand/contract"
L["Colorize faction statistics"] = "彩色化陣營狀態信息"
L["Ctrl+Left Click"] = "Ctrl+左鍵"
-- L["DISPLAY_DEBUG_DESC"] = "Checked to display DEBUG information"
-- L["DISPLAY_HIDEEXALTED_DESC"] = "Check to hide Exalted factions in the tooltip"
-- L["DISPLAY_OPTIONS_DESC"] = "Options that change the way data is displayed in the tooltip"
-- L["DISPLAY_SHOWCOLLAPSED_DESC"] = "Check to display collapsed headers"
-- L["DISPLAY_SHOWGAINS_DESC"] = "Check to display session gains"
-- L["DISPLAY_SHOWHINTS_DESC"] = "Check to display tooltip hints"
-- L["DISPLAY_SHOWPERC_DESC"] = "Check to display percentage complete"
-- L["DISPLAY_SHOWRAW_DESC"] = "Check to display raw values"
-- L["DISPLAY_SHOWREMAIN_DESC"] = "Check to display remaining rep to next level"
L["Database Version : "] = "資料庫版本 : " -- Needs review
L["Database upgraded to %s"] = "資料庫升級到 %s" -- Needs review
L["Display Debug"] = "顯示偵錯" -- Needs review
L["Display Options"] = "顯示選項" -- Needs review
L["Draws the icon on the minimap."] = "標記圖示在小地圖上" -- Needs review
L["Enable Scrolling"] = "開啟滾動"
L["Exalted"] = "崇拜" -- Needs review
L["Faction"] = "陣營"
L["Faction Monitoring"] = "聲望監視"
L["Faction index not yet initialized !"] = "陣營索引尚未初始化!"
L["Friendly"] = "友好" -- Needs review
L["GENERAL_INFO_DESC"] = "版本和作者資訊" -- Needs review
L["General"] = "常規"
L["General Information"] = "綜合資訊" -- Needs review
L["Hated"] = "仇恨" -- Needs review
L["Helpful Translators (thank you) : %s"] = "協助翻譯者 (感謝你們) : %s" -- Needs review
L["Hidden Faction"] = "隱藏陣營"
L["Hide Exalted Factions"] = "隱藏已崇拜聲望"
L["Hide Hint Text"] = "隱藏提示文字"
L["Hide Monitored Faction"] = "隱藏被監視陣營"
L["Hides faction text from the button."] = "從按鈕中隱藏陣營文字"
L["Hides factions with Exalted standing, from the tooltip."] = "隱藏鼠標提示中已崇拜的聲望"
L["Hides the tooltip information/hint text."] = "隱藏滑鼠提示信息/提示文字"
L["Honored"] = "尊敬" -- Needs review
L["Hostile"] = "敵對" -- Needs review
L["Ignore Exalted factions"] = "忽略已崇拜聲望"
L["Ignore negative reputation gains"] = "忽略聲望降低的陣營"
-- L["Inactive"] = "Inactive"
L["Inactive Faction"] = "閒置陣營"
L["Inserts a new tooltip column, showing faction standing."] = "在鼠標提示中顯示陣營關係"
L["Inserts a new tooltip column, showing remaining reputation to reach the next standing."] = "在鼠標提示中顯示達到下一關係所需獲得的聲望數"
L["Inserts a new tooltip column, showing reputation percentage values."] = "在鼠標提示中顯示聲望百分比數值"
L["Inserts a new tooltip column, showing reputation raw numbers in the form of 'xxx/xxxx'."] = "以『xxx/xxxx』的格式在鼠標提示中顯示聲望的具體數值"
L["Inserts a new tooltip column, showing session reputation gains in the form of 'xxx'."] = "以『xxx』的格式在鼠標提示中顯示當前區間獲得的聲望總量"
L["Left Click"] = "左鍵"
-- L["Left-click faction lines to set watched faction"] = "Left-click faction lines to set watched faction"
L["MINIMAP_OPTIONS_DESC"] = "關於小地圖圖示選項" -- Needs review
L["MISCDISPLAY_OPTIONS_DESC"] = "其他選項" -- Needs review
L["Minimalistic LDB plugin that allows simple faction reputation monitoring."] = "Broker Factions 是一款簡潔的監視陣營聲望的 LDB 插件。"
L["Minimap Icon Options"] = "小地圖圖示選項" -- Needs review
L["Miscellaneous Display Options"] = "雜項顯示選項" -- Needs review
L["Move the slider to adjust scaling for the tooltip."] = "移動邊緣來調整鼠標提示大小"
L["Neutral"] = "中立" -- Needs review
L["No Faction"] = "無陣營"
L["Raw"] = "數值"
-- L["Remaining"] = "Remaining"
-- L["Rep"] = "Rep"
L["Reputation with (.*) decreased"] = "你(.+)的聲望提高了(%d+)點。"
L["Reputation with (.*) increased"] = "你(.+)的聲望降低了(%d+)點。"
L["Reset Session Gains"] = "重置區間獲得聲望數"
L["Resets the reputation session gain counters."] = "重置區間獲得聲望數量的計數器"
L["Revered"] = "崇敬" -- Needs review
L["Right Click"] = "右鍵"
-- L["Right-click for Configuration"] = "Right-click for Configuration"
-- L["Select Faction to Watch"] = "Select Faction to Watch"
L["Select a faction to watch on the button/block."] = "選擇一個陣營來顯示在你的按鈕/模組上。"
L["Session"] = "區間獲得"
L["Sets the faction watched on the button/block to the faction set in the character's reputation tab."] = "自動從角色的聲望面板中選擇當前監視的陣營來顯示在按鈕/模組上"
L["Sets the tooltip maximum height, after which it will be scrollable."] = "設置鼠標提示的最大高度，超過此高度將會變為滾動"
L["Shift+Left Click"] = "Shift+左鍵"
L["Show Collapsed Header Suffix"] = "顯示最小化陣營後綴"
L["Show Collapsed Headers"] = "顯示最小化的陣營標題"
-- L["Show Hint Lines"] = "Show Hint Lines"
L["Show Minimap Icon"] = "顯示小地圖圖示" -- Needs review
L["Show Percentage"] = "顯示百分比" -- Needs review
L["Show Percentages"] = "顯示百分比"
L["Show Raw Numbers"] = "顯示精確數值"
-- L["Show Raw Values"] = "Show Raw Values"
L["Show Remaining"] = "顯示剩餘" -- Needs review
L["Show Reputation To Go"] = "顯示剩餘聲望"
L["Show Session Gains"] = "顯示區間獲得聲望數"
L["Show Standing"] = "顯示陣營關係"
-- L["Show Text"] = "Show Text"
L["Status"] = "狀態"
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
L["To Go"] = "尚欠"
L["Toggles display of collapsed faction headers (normally hidden), on the tooltip."] = "在鼠標提示中切換是否顯示被折叠起來的陣營"
L["Tooltip"] = "鼠標提示設置"
-- L["Tooltip Auto-hide Delay"] = "Tooltip Auto-hide Delay"
L["Tooltip Display Options"] = "工具提示顯示選項" -- Needs review
L["Tooltip Maximum Height"] = "鼠標提示最大高度"
L["Tooltip Scale"] = "鼠標提示縮放"
L["Turning this option on will cause the button/block not to auto-switch to a faction you are exalted with, when reputation with it, is modified."] = "當此選項開啟時自動忽略已崇拜聲望，此時不會在你的按鈕/模組上自動切換至這個聲望"
L["Turning this option on will cause the button/block not to auto-switch to a faction, when getting negative reputation with it."] = "이 當此選項開啟時自動忽略聲望降低的陣營，此時不會在你的按鈕/模組上自動切換至這個聲望"
L["Unfriendly"] = "不友好" -- Needs review
L["Unknown Faction"] = "未知陣營"
L["Use Blizzard's faction watch"] = "使用 Blizzard 自帶陣營監視系統"
-- L["Values"] = "Values"
L["Version : "] = "版本 : " -- Needs review
L["You are now (%a+) with (.*)%."] = "你在(.+)中的聲望達到了(.+)。"
L["on faction header to expand or collapse it."] = "點擊可以展開/收起聲望標題"
L["on faction name to watch on the button/block."] = "點擊聲望名在按鈕/信息條中監視"
L["on plugin to open Blizzard's Reputation tab."] = "點擊插件打開默認聲望面板"
L["on plugin to open Configuration Menu."] = "點擊插件打開配置菜單"
L["to paste Reputation info into chat."] = "粘貼當前聲望信息至聊天框"
L["to toggle Reputation bar watch."] = "切換聲望監視條"


--[[
************************************************************************
CHANGELOG:

Date : 04/05/11
	initial version
************************************************************************
]]--