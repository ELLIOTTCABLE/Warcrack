--[[
************************************************************************
Project				: Broker_Factions
Author				: torhal
Project Revision	: 3.2.6-release
Project Date		: 20111012085757

File				: Locales\zhCN.lua
Commit Author		: zhinjio
Commit Revision		: 4
Commit Date			: 20110503035214
************************************************************************
Description	:
	Simplified Chinese translation strings
TODO		:
************************************************************************
--]]
local MODNAME = "BFactions"
local L = LibStub:GetLibrary("AceLocale-3.0"):NewLocale( MODNAME, "zhCN" )
if not L then return end

L["%s to go"] = "尚欠 %s"
L["Activates and displays a scrolling slider bar, for the tooltip."] = "开启鼠标提示的侧栏滚动条"
L["Appends a '+' label suffix to collapsed faction headers (assuming collapsed headers are shown)."] = "在最小化的右側添加添加一个“+”符号 (当显示最小化的阵营标题开启时此选项有效)"
L["Appends faction standing, to the button label."] = "在按钮中显示阵营关系"
L["Appends percentage values to the button label."] = "在按钮中显示声望百分比数值"
L["Appends raw numbers in the form of (xxx/xxxx), to the button label."] = "以 (xxx/xxxx) 的格式在按钮中显示声望的具体数值"
L["Appends remaining reputation to reach the next standing, to the button label."] = "在按钮中显示达到下一关系所需获得的声望数"
L["Appends session reputation gains in the form of [xxx], to the button label."] = "以 [xxx] 的格式在按钮中显示当前区间获得的声望总量"
L["Author : "] = "作者:" -- Needs review
L["Auto faction watch on reputation gains"] = "自动监视获得声望的阵营"
L["Automatically sets the faction watched on the button/block to the last faction you gained reputation with."] = "自动监视你最近获得声望的阵营，将它显示在你的按钮/模组上"
L["Build Date : "] = "建立日期 : " -- Needs review
L["Button"] = "按钮显示设置"
L["Change color of percentages/raw numbers/'to go' according to faction reputation standing."] = "根据阵营声望的高低彩色化显示百分比、精确数值以及“尚欠”文字"
-- L["Click header lines to expand/contract"] = "Click header lines to expand/contract"
L["Colorize faction statistics"] = "彩色化阵营状态信息"
L["Ctrl+Left Click"] = "Ctrl+左鍵"
L["DISPLAY_DEBUG_DESC"] = "检查以显示调试信息" -- Needs review
-- L["DISPLAY_HIDEEXALTED_DESC"] = "Check to hide Exalted factions in the tooltip"
L["DISPLAY_OPTIONS_DESC"] = "设置使改变的数值显示于提示栏" -- Needs review
L["DISPLAY_SHOWCOLLAPSED_DESC"] = "检查以显示collapsed headers" -- Needs review
L["DISPLAY_SHOWGAINS_DESC"] = "检查以显示session收益" -- Needs review
L["DISPLAY_SHOWHINTS_DESC"] = "检查以显示提示栏" -- Needs review
L["DISPLAY_SHOWPERC_DESC"] = "检查以显示完成百分比" -- Needs review
L["DISPLAY_SHOWRAW_DESC"] = "检查以显示原始数值" -- Needs review
L["DISPLAY_SHOWREMAIN_DESC"] = "检查以显示到达下一等级所需声望" -- Needs review
-- L["Database Version : "] = "Database Version : "
-- L["Database upgraded to %s"] = "Database upgraded to %s"
-- L["Display Debug"] = "Display Debug"
-- L["Display Options"] = "Display Options"
-- L["Draws the icon on the minimap."] = "Draws the icon on the minimap."
L["Enable Scrolling"] = "开启滚动"
-- L["Exalted"] = "Exalted"
L["Faction"] = "阵营"
L["Faction Monitoring"] = "声望监视"
L["Faction index not yet initialized !"] = "阵营索引尚未初始化!"
-- L["Friendly"] = "Friendly"
-- L["GENERAL_INFO_DESC"] = "Version and author information"
L["General"] = "常规"
-- L["General Information"] = "General Information"
-- L["Hated"] = "Hated"
-- L["Helpful Translators (thank you) : %s"] = "Helpful Translators (thank you) : %s"
L["Hidden Faction"] = "隐藏阵营"
L["Hide Exalted Factions"] = "隐藏已崇拜声望"
L["Hide Hint Text"] = "隐藏提示文字"
L["Hide Monitored Faction"] = "隐藏被监视阵营"
L["Hides faction text from the button."] = "从按钮中隐藏阵营文字"
L["Hides factions with Exalted standing, from the tooltip."] = "隐藏鼠标提示中已崇拜的声望"
L["Hides the tooltip information/hint text."] = "隐藏鼠标提示信息/提示文字"
-- L["Honored"] = "Honored"
-- L["Hostile"] = "Hostile"
L["Ignore Exalted factions"] = "忽略已崇拜声望"
L["Ignore negative reputation gains"] = "忽略声望降低的阵营"
-- L["Inactive"] = "Inactive"
L["Inactive Faction"] = "闲置阵营"
L["Inserts a new tooltip column, showing faction standing."] = "在鼠标提示中显示阵营关系"
L["Inserts a new tooltip column, showing remaining reputation to reach the next standing."] = "在鼠标提示中显示达到下一关系所需获得的声望数"
L["Inserts a new tooltip column, showing reputation percentage values."] = "在鼠标提示中显示声望百分比数值"
L["Inserts a new tooltip column, showing reputation raw numbers in the form of 'xxx/xxxx'."] = "以“xxx/xxxx”的格式在鼠标提示中显示声望的具体数值"
L["Inserts a new tooltip column, showing session reputation gains in the form of 'xxx'."] = "以“xxx”的格式在鼠标提示中显示当前区间获得的声望总量"
L["Left Click"] = "左鍵"
-- L["Left-click faction lines to set watched faction"] = "Left-click faction lines to set watched faction"
-- L["MINIMAP_OPTIONS_DESC"] = "Options regarding the minimap icon"
-- L["MISCDISPLAY_OPTIONS_DESC"] = "Other options"
L["Minimalistic LDB plugin that allows simple faction reputation monitoring."] = "Broker Factions 是一款简洁的监视阵营声望的 LDB 插件。"
-- L["Minimap Icon Options"] = "Minimap Icon Options"
-- L["Miscellaneous Display Options"] = "Miscellaneous Display Options"
L["Move the slider to adjust scaling for the tooltip."] = "移动边缘来調整鼠标提示大小"
-- L["Neutral"] = "Neutral"
L["No Faction"] = "无阵营"
L["Raw"] = "数值"
-- L["Remaining"] = "Remaining"
-- L["Rep"] = "Rep"
L["Reputation with (.*) decreased"] = "你在(.+)中的声望值提高了(%d+)点。"
L["Reputation with (.*) increased"] = "你在(.+)中的声望值降低了(%d+)点。"
L["Reset Session Gains"] = "重置区间获得声望数"
L["Resets the reputation session gain counters."] = "重置区间获得声望数量的计数器"
-- L["Revered"] = "Revered"
L["Right Click"] = "右鍵"
-- L["Right-click for Configuration"] = "Right-click for Configuration"
-- L["Select Faction to Watch"] = "Select Faction to Watch"
L["Select a faction to watch on the button/block."] = "选择一个阵营来显示在你的按钮/模组上。"
L["Session"] = "区间获得"
L["Sets the faction watched on the button/block to the faction set in the character's reputation tab."] = "自动从角色的声望面板中选择当前监视的阵营来显示在按钮/模组上"
L["Sets the tooltip maximum height, after which it will be scrollable."] = "设置鼠标提示的最大高度，超过此高度将会变为滚动"
L["Shift+Left Click"] = "Shift+左鍵"
L["Show Collapsed Header Suffix"] = "显示最小化阵营后缀"
L["Show Collapsed Headers"] = "显示最小化的阵营标题"
-- L["Show Hint Lines"] = "Show Hint Lines"
-- L["Show Minimap Icon"] = "Show Minimap Icon"
-- L["Show Percentage"] = "Show Percentage"
L["Show Percentages"] = "显示百分比"
L["Show Raw Numbers"] = "显示精确数值"
-- L["Show Raw Values"] = "Show Raw Values"
-- L["Show Remaining"] = "Show Remaining"
L["Show Reputation To Go"] = "显示剩餘声望"
L["Show Session Gains"] = "显示区间获得声望数"
L["Show Standing"] = "显示阵营关系"
-- L["Show Text"] = "Show Text"
L["Status"] = "状态"
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
L["Toggles display of collapsed faction headers (normally hidden), on the tooltip."] = "在鼠标提示中切换是否显示被折叠起來的阵营"
L["Tooltip"] = "鼠标提示设置"
-- L["Tooltip Auto-hide Delay"] = "Tooltip Auto-hide Delay"
-- L["Tooltip Display Options"] = "Tooltip Display Options"
L["Tooltip Maximum Height"] = "鼠标提示最大高度"
L["Tooltip Scale"] = "鼠标提示縮放"
L["Turning this option on will cause the button/block not to auto-switch to a faction you are exalted with, when reputation with it, is modified."] = "当此选项开启时自动忽略已崇拜声望，此时不会在你的按钮/模組上自动切换至这个声望"
L["Turning this option on will cause the button/block not to auto-switch to a faction, when getting negative reputation with it."] = "이 当此选项开启时自动忽略声望降低的阵营，此时不会在你的按钮/模組上自动切换至这个声望"
-- L["Unfriendly"] = "Unfriendly"
L["Unknown Faction"] = "未知阵营"
L["Use Blizzard's faction watch"] = "使用 Blizzard 自带阵营监视系統"
-- L["Values"] = "Values"
-- L["Version : "] = "Version : "
L["You are now (%a+) with (.*)%."] = "你在(.+)中的声望达到了(.+)。"
L["on faction header to expand or collapse it."] = "点击可以展开/收起声望标题"
L["on faction name to watch on the button/block."] = "点击声望名在按钮/信息条中监视"
L["on plugin to open Blizzard's Reputation tab."] = "点击插件打开默认声望面板"
L["on plugin to open Configuration Menu."] = "点击插件打开配置菜单"
L["to paste Reputation info into chat."] = "粘贴当前声望信息至聊天框"
L["to toggle Reputation bar watch."] = "切换声望监视条"


--[[
************************************************************************
CHANGELOG:

Date : 04/05/11
	initial version
************************************************************************
]]--