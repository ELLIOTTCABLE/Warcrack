--[[--------------------------------------------------------------------
	Grid Localization
	zhCN | Simplified Chinese | 简体中文
----------------------------------------------------------------------]]

if GetLocale() ~= "zhCN" then return end

local _, Grid = ...
local L = { }
Grid.L = L

------------------------------------------------------------------------
--	GridCore

L["Debug"] = "除错"
L["Debugging"] = "除错"
L["Hide minimap icon"] = "隐藏迷你地图按钮"
L["Module debugging menu."] = "除错模块配置。"
L["Toggle debugging for %s."] = "打开/关闭%s的除错。"

------------------------------------------------------------------------
--	GridFrame

L["Adjust the font outline."] = "调整字体描边。"
L["Adjust the font settings"] = "调整字体"
L["Adjust the font size."] = "调整字体尺寸。"
L["Adjust the height of each unit's frame."] = "调整个体框架的高度。"
L["Adjust the size of the border indicators."] = "调整外框指示的大小。"
L["Adjust the size of the center icon's border."] = "调整屏幕中心图标外框的大小。"
L["Adjust the size of the center icon."] = "调整中心图标的尺寸。"
L["Adjust the size of the corner indicators."] = "调整边角指示的大小。"
L["Adjust the texture of each unit's frame."] = "调整个体框架的材质。"
L["Adjust the width of each unit's frame."] = "调整个体框架的宽度。"
L["Always"] = "一直"
L["Bar Options"] = "条选项"
L["Border"] = "外框"
L["Border Size"] = "外框大小"
L["Bottom Left Corner"] = "左下角"
L["Bottom Right Corner"] = "右下角"
L["Center Icon"] = "中心图标"
L["Center Text"] = "中心文字"
L["Center Text 2"] = "中心文字2"
L["Center Text Length"] = "中间文字长度"
L["Corner Size"] = "边角指示大小"
L["Enable %s"] = "启用%s"
L["Enable %s indicator"] = "启用%s指示"
L["Enable Mouseover Highlight"] = "启用鼠标悬停高亮"
L["Font"] = "字体"
L["Font Outline"] = "字体描边"
L["Font Shadow"] = "字体阴影"
L["Font Size"] = "字体大小"
L["Frame"] = "框架"
L["Frame Alpha"] = "框架透明度"
L["Frame Height"] = "框架高度"
L["Frame Texture"] = "框架材质"
L["Frame Width"] = "框架宽度"
L["Healing Bar"] = "治疗条"
L["Healing Bar Opacity"] = "治疗条透明度"
L["Health Bar"] = "生命条"
L["Health Bar Color"] = "生命条颜色"
L["Horizontal"] = "水平"
L["Icon Border Size"] = "图标外框大小"
L["Icon Cooldown Frame"] = "图标冷却时间框架"
L["Icon Options"] = "图标选项"
L["Icon Size"] = "图标大小"
L["Icon Stack Text"] = "图标堆叠文字"
L["Indicators"] = "指示器"
L["Invert Bar Color"] = "反转颜色"
L["Never"] = "不显示"
L["None"] = "无"
L["Number of characters to show on Center Text indicator."] = "中间文字提示器所显示文字的长度。"
L["OOC"] = "非战斗"
L["Options for %s indicator."] = "%s提示器的选项。"
L["Options for GridFrame."] = "Grid 框架的选项。"
-- L["Options for assigning statuses to indicators."] = ""
L["Options related to bar indicators."] = "条指示器的选项"
L["Options related to icon indicators."] = "图标指示器的选项."
L["Options related to text indicators."] = "文字指示器的选项"
L["Orientation of Frame"] = "框架方向"
L["Orientation of Text"] = "文字方向"
L["Set frame orientation."] = "设置框架方向。"
L["Set frame text orientation."] = "设置文字方向。"
L["Sets the opacity of the healing bar."] = "设置治疗条的透明度。"
L["Show Tooltip"] = "显示提示信息"
L["Show unit tooltip.  Choose 'Always', 'Never', or 'OOC'."] = "显示单位框架的鼠标信息。选择“一直”，“不显示”或“非战斗”。"
L["Statuses"] = "状态"
L["Swap foreground/background colors on bars."] = "反转提示条上背景/前景的颜色。"
L["Text Options"] = "文字选项"
L["Thick"] = "粗"
L["Thin"] = "细"
-- L["Throttle Updates"] = ""
-- L["Throttle updates on group changes. This option may cause delays in updating frames, so you should only enable it if you're experiencing temporary freezes or lockups when people join or leave your group."] = ""
L["Toggle center icon's cooldown frame."] = "打开/关闭中心图标的冷却时间框架。"
L["Toggle center icon's stack count text."] = "打开/关闭中心图标的堆叠计数文字。"
L["Toggle mouseover highlight."] = "打开/关闭鼠标悬停高亮。"
L["Toggle status display."] = "打开/关闭显示状态。"
L["Toggle the %s indicator."] = "打开/关闭%s指示。"
L["Toggle the font drop shadow effect."] = "开启或关闭字体阴影效果."
L["Top Left Corner"] = "左上角"
L["Top Right Corner"] = "右上角"
L["Vertical"] = "竖直"

------------------------------------------------------------------------
--	GridLayout

L["10 Player Raid Layout"] = "10人团队布局"
L["25 Player Raid Layout"] = "25人团队布局"
L["Adjust Grid scale."] = "调整框架大小比率。"
L["Adjust background color and alpha."] = "调整背景颜色和透明度。"
L["Adjust border color and alpha."] = "调整外框的颜色和透明度。"
L["Adjust frame padding."] = "调整框架填白。"
L["Adjust frame spacing."] = "调整框架空隙。"
L["Advanced"] = "高级"
L["Advanced options."] = "高级选项。"
L["Allows mouse click through the Grid Frame."] = "是否允许透过 Grid 框体点击。"
L["Alt-Click to permanantly hide this tab."] = "Alt-单击总是隐藏此标签。"
L["Arena Layout"] = "竞技场布局"
L["Background color"] = "背景"
L["Battleground Layout"] = "战场布局"
L["Beast"] = "野兽"
L["Border Texture"] = "外框材质"
L["Border color"] = "外框"
L["Bottom"] = "底部"
L["Bottom Left"] = "左下"
L["Bottom Right"] = "右下"
L["By Creature Type"] = "以种类（野兽/恶魔/人型）"
L["By Owner Class"] = "以主人的职业颜色"
L["Center"] = "中心"
L["Choose the layout border texture."] = "选择外框材质布局。"
L["Clamped to screen"] = "保持在屏幕上"
L["Class colors"] = "职业颜色"
L["Click through the Grid Frame"] = "透过 Grid 框体点击"
L["Color for %s."] = "%s的颜色。"
L["Color of pet unit creature types."] = "宠物的生物种类的颜色。"
L["Color of player unit classes."] = "玩家职业颜色。"
L["Color of unknown units or pets."] = "未知单位/宠物颜色。"
L["Color options for class and pets."] = "玩家和宠物的颜色选项。"
L["Colors"] = "颜色"
L["Creature type colors"] = "生物种类颜色"
L["Demon"] = "恶魔"
L["Do not show the tab when Grid is unlocked."] = "当未锁定 Grid 时不显示标签。"
L["Drag this tab to move Grid."] = "拖动此标签移动 Grid。"
L["Dragonkin"] = "龙类"
L["Elemental"] = "元素"
L["Fallback colors"] = "已知颜色"
L["Frame lock"] = "锁定框架"
L["Group Anchor"] = "队伍锚点"
L["Hide tab"] = "隐藏标签"
L["Horizontal groups"] = "横向排列队伍"
L["Humanoid"] = "人型"
L["Layout"] = "布局"
L["Layout Anchor"] = "布局锚点"
L["Left"] = "左侧"
L["Lock Grid to hide this tab."] = "锁定 Grid 隐藏此标签。"
L["Locks/unlocks the grid for movement."] = "锁定/解锁 Grid 框体来让其移动。"
L["Not specified"] = "未分类"
L["Options for GridLayout."] = "Grid 布局的选项。"
L["Padding"] = "填白"
L["Party Layout"] = "小队布局"
L["Pet color"] = "宠物颜色"
L["Pet coloring"] = "宠物颜色"
L["Reset Position"] = "重置位置"
L["Resets the layout frame's position and anchor."] = "重置布局框架的位置和锚点。"
L["Right"] = "右侧"
L["Scale"] = "大小比率"
L["Select which layout to use when in a 10 player raid."] = "10人团队时所选择使用的布局。"
L["Select which layout to use when in a 25 player raid."] = "25人团队时所选择使用的布局。"
L["Select which layout to use when in a battleground."] = "在战场时所选择使用的布局。"
L["Select which layout to use when in a party."] = "在小队时所选择使用的布局。"
L["Select which layout to use when in an arena."] = "在竞技场时所选择使用的布局。"
L["Select which layout to use when not in a party."] = "没有小队时所选择使用的布局。"
L["Set the color of pet units."] = "设定宠物的颜色。"
L["Set the coloring strategy of pet units."] = "设置宠物颜色策略。"
L["Sets where Grid is anchored relative to the screen."] = "设置屏幕中 Grid 的锚点。"
L["Sets where groups are anchored relative to the layout frame."] = "设置布局中队伍的锚点。"
L["Show Frame"] = "显示框架"
L["Solo Layout"] = "单人布局"
L["Spacing"] = "空隙"
L["Switch between horizontal/vertical groups."] = "选择横向/竖向显示队伍。"
L["The color of unknown pets."] = "未知宠物的颜色。"
L["The color of unknown units."] = "未知单位颜色。"
L["Toggle whether to permit movement out of screen."] = "打开/关闭是否允许把窗口移到超出屏幕的位置。"
L["Top"] = "顶部"
L["Top Left"] = "左上"
L["Top Right"] = "右上"
L["Undead"] = "亡灵"
L["Unknown Pet"] = "未知宠物"
L["Unknown Unit"] = "未知单位"
L["Using Fallback color"] = "使用已知颜色"

------------------------------------------------------------------------
--	GridLayoutLayouts

L["By Class 10"] = "10人职业以及宠物"
L["By Class 10 w/Pets"] = "10人职业"
L["By Class 25"] = "25人职业以及宠物"
L["By Class 25 w/Pets"] = "25人职业"
L["By Group 10"] = "10人团队"
L["By Group 10 w/Pets"] = "10人团队以及宠物"
L["By Group 15"] = "15人团队"
L["By Group 15 w/Pets"] = "15人团队以及宠物"
L["By Group 25"] = "25人团队"
L["By Group 25 w/Pets"] = "25人团队以及宠物"
L["By Group 25 w/Tanks"] = "25人团队及坦克"
L["By Group 40"] = "40人团队"
L["By Group 40 w/Pets"] = "40人团队以及宠物"
L["By Group 5"] = "5人小队"
L["By Group 5 w/Pets"] = "5人小队以及宠物"
L["None"] = "无"

------------------------------------------------------------------------
--	GridLDB

L["Click to toggle the frame lock."] = "点击来锁定或解锁框体."
L["Right-Click to open the options menu."] = "右键点击打开选项菜单."

------------------------------------------------------------------------
--	GridRoster


------------------------------------------------------------------------
--	GridStatus

L["Color"] = "颜色"
L["Color for %s"] = "%s的颜色"
L["Enable"] = "启用"
L["Options for %s."] = "%s状态的选项。"
L["Priority"] = "优先度"
L["Priority for %s"] = "%s的优先度"
L["Range filter"] = "距离过滤"
L["Range filter for %s"] = "%s的距离过滤"
L["Reset class colors"] = "重置职业颜色"
L["Reset class colors to defaults."] = "重置职业颜色为默认。"
L["Status"] = "状态"
L["Status: %s"] = "状态：%s"
L["Text"] = "文字"
L["Text to display on text indicators"] = "在文字提示器上显示文字"

------------------------------------------------------------------------
--	GridStatusAggro

L["Aggro"] = "仇恨"
L["Aggro alert"] = "仇恨警报"
L["Aggro color"] = "仇恨颜色"
L["Color for Aggro."] = "获得仇恨时的颜色。"
L["Color for High Threat."] = "高威胁时的颜色。"
L["Color for Tanking."] = "坦克时的颜色。"
L["High"] = "高"
L["High Threat color"] = "高威胁颜色"
L["Show more detailed threat levels."] = "显示更多威胁分级。"
L["Tank"] = "坦克"
L["Tanking color"] = "坦克颜色"
L["Threat"] = "威胁"

------------------------------------------------------------------------
--	GridStatusAuras

L["<buff name>"] = "<增益名称>"
L["<debuff name>"] = "<减益名称>"
L["Add new Buff"] = "增加新的增益"
L["Add new Debuff"] = "增加新的减益"
L["Adds a new buff to the status module"] = "状态模组添加一个新的增益"
L["Adds a new debuff to the status module"] = "状态模组添加一个新的减益"
L["Auras"] = "光环"
L["Buff: %s"] = "增益：%s"
L["Class Filter"] = "职业过滤"
L["Curse"] = "诅咒"
L["Debuff type: %s"] = "减益类型：%s"
L["Debuff: %s"] = "减益：%s"
L["Delete (De)buff"] = "删除 增(减)益"
L["Deletes an existing debuff from the status module"] = "删除状态模组内已有的一个增（减）益"
L["Disease"] = "疾病"
L["Display status only if the buff is not active."] = "仅在增益缺少时才显示状态。"
L["Display status only if the buff was cast by you."] = "显示你施放增益时的状态。"
L["Ghost"] = "幽灵"
L["Magic"] = "魔法"
L["Poison"] = "毒药"
L["Remove %s from the menu"] = "从列表中移除%s"
L["Show duration"] = "显示持续效果"
L["Show if mine"] = "显示自身"
L["Show if missing"] = "缺少时显示"
L["Show on %s."] = "在%s上显示。"
L["Show status for the selected classes."] = "显示选定职业的状态。"
L["Show the time remaining, for use with the center icon cooldown."] = "显示的剩余时间，用于中心的图标冷却。"

------------------------------------------------------------------------
--	GridStatusHeals

L["Heals"] = "治疗"
L["Ignore Self"] = "忽略自己"
L["Ignore heals cast by you."] = "忽略对自己施放的治疗。"
L["Incoming heals"] = "正被治疗"
L["Minimum Value"] = "最低值"
L["Only show incoming heals greater than this amount."] = "仅显示大于这个数值的接受治疗."

------------------------------------------------------------------------
--	GridStatusHealth

L["Color deficit based on class."] = "用职业颜色来显示损失的血量。"
L["Color health based on class."] = "用职业颜色来显示血量。"
L["DEAD"] = "死"
L["Death warning"] = "死亡警报"
L["FD"] = "假"
L["Feign Death warning"] = "假死提示"
L["Health"] = "血量"
L["Health deficit"] = "损失的血量"
L["Health threshold"] = "血量临界点"
L["Low HP"] = "低"
L["Low HP threshold"] = "低血量临界点"
L["Low HP warning"] = "低血量警报"
L["Offline"] = "离"
L["Offline warning"] = "掉线警报"
L["Only show deficit above % damage."] = "只显示已经损失了%的血量。"
L["Set the HP % for the low HP warning."] = "设置低血量警报的临界点。"
L["Show dead as full health"] = "把死亡的显示为满血"
L["Treat dead units as being full health."] = "把死亡的显示为满血。"
L["Unit health"] = "血量"
L["Use class color"] = "使用职业颜色"

------------------------------------------------------------------------
--	GridStatusMana

L["Low Mana"] = "低法力"
L["Low Mana warning"] = "低法力警报"
L["Mana"] = "法力"
L["Mana threshold"] = "法力临界点"
L["Set the percentage for the low mana warning."] = "设置低法力警告的临界点。"

------------------------------------------------------------------------
--	GridStatusName

L["Color by class"] = "使用职业颜色"
L["Unit Name"] = "名字"

------------------------------------------------------------------------
--	GridStatusRange

L["Out of Range"] = "超出距离"
L["Range"] = "距离"
L["Range check frequency"] = "距离检测的频率"
L["Seconds between range checks"] = "多少秒检测一次距离"

------------------------------------------------------------------------
--	GridStatusReadyCheck

L["?"] = "？"
L["AFK"] = "暂离"
L["AFK color"] = "暂离颜色"
L["Color for AFK."] = "暂离时的颜色。"
L["Color for Not Ready."] = "未准备好时的颜色。"
L["Color for Ready."] = "已就绪时的颜色。"
L["Color for Waiting."] = "等待时的颜色。"
L["Delay"] = "延迟"
L["Not Ready color"] = "未准备好颜色"
L["R"] = "是"
L["Ready Check"] = "检查就绪"
L["Ready color"] = "就绪颜色"
L["Set the delay until ready check results are cleared."] = "设置准备就绪检查结果清除的延迟。"
L["Waiting color"] = "等待颜色"
L["X"] = "否"

------------------------------------------------------------------------
--	GridStatusTarget

L["Target"] = "目标"
L["Your Target"] = "你的目标"

------------------------------------------------------------------------
--	GridStatusVehicle

L["Driving"] = "驾驶中"
L["In Vehicle"] = "使用载具"

------------------------------------------------------------------------
--	GridStatusVoiceComm

L["Talking"] = "正在说话"
L["Voice Chat"] = "语音"
