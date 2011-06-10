--[[--------------------------------------------------------------------
	Grid Localization
	zhTW | Traditional Chinese | 繁體中文
----------------------------------------------------------------------]]

if GetLocale() ~= "zhTW" then return end

local _, Grid = ...
local L = { }
Grid.L = L

------------------------------------------------------------------------
--	GridCore

L["Debug"] = "除錯"
L["Debugging"] = "除錯"
L["Hide minimap icon"] = "隱藏小地圖按鈕"
L["Module debugging menu."] = "除錯模組設定。"
L["Toggle debugging for %s."] = "啟用/禁用 %s 的除錯訊息。"

------------------------------------------------------------------------
--	GridFrame

L["Adjust the font outline."] = "調整字體描邊。"
L["Adjust the font settings"] = "調整字型。"
L["Adjust the font size."] = "調整字型大小。"
L["Adjust the height of each unit's frame."] = "為每一個單位框架調整高度。"
L["Adjust the size of the border indicators."] = "調整邊框提示器大小"
L["Adjust the size of the center icon's border."] = "調整中央圖示的邊框大小"
L["Adjust the size of the center icon."] = "調整中央圖示大小。"
L["Adjust the size of the corner indicators."] = "調整角落提示器的大小。"
L["Adjust the texture of each unit's frame."] = "調整每一個單位框架的材質。"
L["Adjust the width of each unit's frame."] = "為每一個單位框架調整寬度。"
L["Always"] = "總是"
L["Bar Options"] = "動作條選項"
L["Border"] = "邊框"
L["Border Size"] = "邊框大小"
L["Bottom Left Corner"] = "左下角"
L["Bottom Right Corner"] = "右下角"
L["Center Icon"] = "中央圖示"
L["Center Text"] = "中央文字"
L["Center Text 2"] = "中央文字2"
L["Center Text Length"] = "中央文字長度"
L["Corner Size"] = "角落提示器大小"
L["Enable %s"] = "啟用%s"
L["Enable %s indicator"] = "啟用%s提示器"
L["Enable Mouseover Highlight"] = "啟用滑鼠懸停高亮"
L["Font"] = "字型設定"
L["Font Outline"] = "字體描邊"
L["Font Shadow"] = "字體陰影"
L["Font Size"] = "字型大小"
L["Frame"] = "框架"
L["Frame Alpha"] = "框架透明度"
L["Frame Height"] = "框架高度"
L["Frame Texture"] = "框架材質"
L["Frame Width"] = "框架寬度"
L["Healing Bar"] = "治療條"
L["Healing Bar Opacity"] = "治療條透明度"
L["Health Bar"] = "生命力條"
L["Health Bar Color"] = "生命力條顏色"
L["Horizontal"] = "水平"
L["Icon Border Size"] = "圖示邊框大小"
L["Icon Cooldown Frame"] = "圖示冷卻時間框架"
L["Icon Options"] = "圖示選項"
L["Icon Size"] = "圖示大小"
L["Icon Stack Text"] = "圖示堆疊文字"
L["Indicators"] = "提示器"
L["Invert Bar Color"] = "調換顏色"
L["Never"] = "永不"
L["None"] = "無"
L["Number of characters to show on Center Text indicator."] = "中央文字提示器所顯示的文字長度。"
L["OOC"] = "戰鬥外"
L["Options for %s indicator."] = "%s提示器的設定選項。"
L["Options for GridFrame."] = "GridFrame 設定選項。"
-- L["Options for assigning statuses to indicators."] = ""
-- L["Options related to bar indicators."] = ""
-- L["Options related to icon indicators."] = ""
-- L["Options related to text indicators."] = ""
L["Orientation of Frame"] = "框架排列方式"
L["Orientation of Text"] = "文字排列方式"
L["Set frame orientation."] = "設定框架排列方式。"
L["Set frame text orientation."] = "設定框架中文字排列方式。"
L["Sets the opacity of the healing bar."] = "設定治療條的透明度。"
L["Show Tooltip"] = "顯示提示訊息"
L["Show unit tooltip.  Choose 'Always', 'Never', or 'OOC'."] = "顯示單位框架的提示訊息。選擇「總是」，「永不」或「戰鬥外」。"
L["Statuses"] = "狀態"
L["Swap foreground/background colors on bars."] = "調換提示條背景與前景之顏色。"
L["Text Options"] = "文字選項"
L["Thick"] = "粗體"
L["Thin"] = "細體"
-- L["Throttle Updates"] = ""
-- L["Throttle updates on group changes. This option may cause delays in updating frames, so you should only enable it if you're experiencing temporary freezes or lockups when people join or leave your group."] = ""
L["Toggle center icon's cooldown frame."] = "啟用/禁用圖示的冷卻時間框架。"
L["Toggle center icon's stack count text."] = "啟用/禁用圖示的堆疊計數文字。"
L["Toggle mouseover highlight."] = "啟用/禁用滑鼠懸停高亮。"
L["Toggle status display."] = "啟用/禁用顯示狀態。"
L["Toggle the %s indicator."] = "啟用/禁用%s提示器。"
-- L["Toggle the font drop shadow effect."] = ""
L["Top Left Corner"] = "左上角"
L["Top Right Corner"] = "右上角"
L["Vertical"] = "垂直"

------------------------------------------------------------------------
--	GridLayout

L["10 Player Raid Layout"] = "10人團隊模式"
L["25 Player Raid Layout"] = "25人團隊模式"
L["Adjust Grid scale."] = "調整 Grid 縮放比例。"
L["Adjust background color and alpha."] = "調整背景顏色與透明度。"
L["Adjust border color and alpha."] = "調整邊框顏色與透明度。"
L["Adjust frame padding."] = "調整框架間距。"
L["Adjust frame spacing."] = "調整外框架空間。"
L["Advanced"] = "進階"
L["Advanced options."] = "進階選項。"
L["Allows mouse click through the Grid Frame."] = "允許透過滑鼠點擊 Grid 框架。"
L["Alt-Click to permanantly hide this tab."] = "Alt-單擊總是隱藏此標簽。。"
L["Arena Layout"] = "競技場版面編排"
L["Background color"] = "背景"
L["Battleground Layout"] = "戰場版面編排"
L["Beast"] = "野獸"
L["Border Texture"] = "邊框材質"
L["Border color"] = "邊框"
L["Bottom"] = "下"
L["Bottom Left"] = "左下"
L["Bottom Right"] = "右下"
L["By Creature Type"] = "依生物類型"
L["By Owner Class"] = "依玩家職業"
L["Center"] = "中"
L["Choose the layout border texture."] = "選擇版面編排的邊框材質"
L["Clamped to screen"] = "限制框架於視窗內"
L["Class colors"] = "職業顏色"
L["Click through the Grid Frame"] = "透過點擊 Grid 框架"
L["Color for %s."] = "%s的顏色"
L["Color of pet unit creature types."] = "玩家召喚之寵物的顏色。"
L["Color of player unit classes."] = "玩家職業的顏色。"
L["Color of unknown units or pets."] = "未知單位或寵物的顏色。"
L["Color options for class and pets."] = "職業與寵物的顏色選項。"
L["Colors"] = "顏色"
L["Creature type colors"] = "召喚類型的顏色"
L["Demon"] = "惡魔"
L["Do not show the tab when Grid is unlocked."] = "當未鎖定 Grid 時不顯示標簽。"
L["Drag this tab to move Grid."] = "拖動此標簽移動 Grid。"
L["Dragonkin"] = "龍類"
L["Elemental"] = "元素生物"
L["Fallback colors"] = "備用顏色"
L["Frame lock"] = "鎖定框架"
L["Group Anchor"] = "小組錨點"
L["Hide tab"] = "隱藏標簽"
L["Horizontal groups"] = "橫向顯示小組"
L["Humanoid"] = "人形生物"
L["Layout"] = "版面編排"
L["Layout Anchor"] = "版面編排錨點"
L["Left"] = "左"
L["Lock Grid to hide this tab."] = "鎖定 Grid 隱藏此標簽。"
L["Locks/unlocks the grid for movement."] = "鎖定/解鎖 Grid 框架。"
L["Not specified"] = "未指定"
L["Options for GridLayout."] = "Grid版面設定選項。"
L["Padding"] = "間距"
L["Party Layout"] = "隊伍版面編排"
L["Pet color"] = "寵物顏色"
L["Pet coloring"] = "寵物配色"
L["Reset Position"] = "重設位置"
L["Resets the layout frame's position and anchor."] = "重設版面位置和錨點。"
L["Right"] = "右"
L["Scale"] = "縮放比例"
L["Select which layout to use when in a 10 player raid."] = "選擇10人團隊模式面板編排"
L["Select which layout to use when in a 25 player raid."] = "選擇25人團隊模式面板編排"
L["Select which layout to use when in a battleground."] = "選擇戰場版面編排方式。"
L["Select which layout to use when in a party."] = "選擇隊伍版面編排方式。"
L["Select which layout to use when in an arena."] = "選擇競技場版面編排方式。"
L["Select which layout to use when not in a party."] = "選擇單人版面編排方式。"
L["Set the color of pet units."] = "設定寵物使用的顏色"
L["Set the coloring strategy of pet units."] = "設定寵物的配色方案。"
L["Sets where Grid is anchored relative to the screen."] = "設定 Grid 的版面位置錨點。"
L["Sets where groups are anchored relative to the layout frame."] = "設定版面編排中的小組錨點。"
L["Show Frame"] = "顯示框架"
L["Solo Layout"] = "單人版面編排"
L["Spacing"] = "空間"
L["Switch between horizontal/vertical groups."] = "轉換橫向/垂直顯示小組。"
L["The color of unknown pets."] = "未知寵物的顏色。"
L["The color of unknown units."] = "未知單位的顏色。"
L["Toggle whether to permit movement out of screen."] = "啟用/禁用框架於視窗內限制，避免拖曳出視窗外。"
L["Top"] = "上"
L["Top Left"] = "左上"
L["Top Right"] = "右上"
L["Undead"] = "不死生物"
L["Unknown Pet"] = "未知寵物"
L["Unknown Unit"] = "未知單位"
L["Using Fallback color"] = "使用備用顏色"

------------------------------------------------------------------------
--	GridLayoutLayouts

L["By Class 10"] = "10人以職業排列"
L["By Class 10 w/Pets"] = "10人以職業/寵物排列"
L["By Class 25"] = "25人以職業排列"
L["By Class 25 w/Pets"] = "25人以職業/寵物排列"
L["By Group 10"] = "10人團隊"
L["By Group 10 w/Pets"] = "10人團隊及寵物"
L["By Group 15"] = "15人團隊"
L["By Group 15 w/Pets"] = "15人團隊及寵物"
L["By Group 25"] = "25人團隊"
L["By Group 25 w/Pets"] = "25人團隊及寵物"
L["By Group 25 w/Tanks"] = "25人團隊及坦克"
L["By Group 40"] = "40人團隊"
L["By Group 40 w/Pets"] = "40人團隊及寵物"
L["By Group 5"] = "5人團隊"
L["By Group 5 w/Pets"] = "5人團隊及寵物"
L["None"] = "無"

------------------------------------------------------------------------
--	GridLDB

L["Click to toggle the frame lock."] = "點擊切換框架鎖定。"
L["Right-Click to open the options menu."] = "右鍵-點擊 開啟選單。"

------------------------------------------------------------------------
--	GridRoster


------------------------------------------------------------------------
--	GridStatus

L["Color"] = "顏色"
L["Color for %s"] = "%s的顏色"
L["Enable"] = "啟用"
L["Options for %s."] = "%s 設定選項。"
L["Priority"] = "優先程度"
L["Priority for %s"] = "%s的優先程度"
L["Range filter"] = "距離過濾"
L["Range filter for %s"] = "%s的距離過濾"
L["Reset class colors"] = "重置職業顔色"
L["Reset class colors to defaults."] = "重置職業顔色為默認"
L["Status"] = "狀態"
L["Status: %s"] = "狀態: %s"
L["Text"] = "文字"
L["Text to display on text indicators"] = "顯示文字於文字提示器上"

------------------------------------------------------------------------
--	GridStatusAggro

L["Aggro"] = "仇恨"
L["Aggro alert"] = "仇恨警告"
L["Aggro color"] = "仇恨的顏色"
L["Color for Aggro."] = "獲得仇恨時的顏色"
L["Color for High Threat."] = "高仇恨時的顏色。"
L["Color for Tanking."] = "坦克時的顏色。"
L["High"] = "高"
L["High Threat color"] = "高仇恨的顏色"
L["Show more detailed threat levels."] = "顯示更詳細的仇恨值"
L["Tank"] = "坦克"
L["Tanking color"] = "坦克的顏色"
L["Threat"] = "仇恨"

------------------------------------------------------------------------
--	GridStatusAuras

L["<buff name>"] = "<增益名稱>"
L["<debuff name>"] = "<減益名稱>"
L["Add new Buff"] = "增加新的增益"
L["Add new Debuff"] = "增加新的減益"
L["Adds a new buff to the status module"] = "增加一個新的增益至狀態模組中"
L["Adds a new debuff to the status module"] = "增加一個新的減益至狀態模組中"
L["Auras"] = "光環"
L["Buff: %s"] = "增益: %s"
L["Class Filter"] = "職業過濾"
L["Curse"] = "詛咒"
L["Debuff type: %s"] = "減益類型: %s"
L["Debuff: %s"] = "減益: %s"
L["Delete (De)buff"] = "刪除增/減益"
L["Deletes an existing debuff from the status module"] = "刪除狀態模組內已有的增/減益"
L["Disease"] = "疾病"
L["Display status only if the buff is not active."] = "當缺少增益時提示。"
L["Display status only if the buff was cast by you."] = "顯示只有你所施放的增益。"
L["Ghost"] = "鬼魂"
L["Magic"] = "魔法"
L["Poison"] = "毒"
L["Remove %s from the menu"] = "從選單中刪除%s"
L["Show duration"] = "顯示持續時間"
L["Show if mine"] = "顯示我的"
L["Show if missing"] = "顯示缺少"
L["Show on %s."] = "在%s上顯示。"
L["Show status for the selected classes."] = "顯示選定職業的狀態。"
L["Show the time remaining, for use with the center icon cooldown."] = "在圖示中顯示持續時間。"

------------------------------------------------------------------------
--	GridStatusHeals

L["Heals"] = "治療"
L["Ignore Self"] = "忽略自己"
L["Ignore heals cast by you."] = "忽略自己施放的治療法術。"
L["Incoming heals"] = "治療中"
L["Minimum Value"] = "最小值"
-- L["Only show incoming heals greater than this amount."] = ""

------------------------------------------------------------------------
--	GridStatusHealth

L["Color deficit based on class."] = "損失生命力值根據不同的職業著色。"
L["Color health based on class."] = "生命力顏色根據不同的職業著色。"
L["DEAD"] = "死亡"
L["Death warning"] = "死亡警報"
L["FD"] = "假死"
L["Feign Death warning"] = "假死警報"
L["Health"] = "生命力"
L["Health deficit"] = "損失生命力"
L["Health threshold"] = "生命力臨界點"
L["Low HP"] = "生命力不足"
L["Low HP threshold"] = "生命力不足臨界點"
L["Low HP warning"] = "生命力不足警報"
L["Offline"] = "離線"
L["Offline warning"] = "斷線警報"
L["Only show deficit above % damage."] = "當損失生命力超過總生命力某個百分比時顯示損失生命力值。"
L["Set the HP % for the low HP warning."] = "設定當生命力低於臨界點時警告。"
L["Show dead as full health"] = "顯示死亡為生命力全滿"
L["Treat dead units as being full health."] = "把死亡玩家的生命力顯示成全滿。"
L["Unit health"] = "單位生命力"
L["Use class color"] = "使用職業顏色"

------------------------------------------------------------------------
--	GridStatusMana

L["Low Mana"] = "法力不足"
L["Low Mana warning"] = "法力不足警報"
L["Mana"] = "法力"
L["Mana threshold"] = "法力不足臨界點"
L["Set the percentage for the low mana warning."] = "設定當法力低於臨界點時警告。"

------------------------------------------------------------------------
--	GridStatusName

L["Color by class"] = "使用職業顏色"
L["Unit Name"] = "名字"

------------------------------------------------------------------------
--	GridStatusRange

L["Out of Range"] = "超出射程"
L["Range"] = "距離"
L["Range check frequency"] = "距離檢測頻率"
L["Seconds between range checks"] = "設定程式多少秒檢測一次距離"

------------------------------------------------------------------------
--	GridStatusReadyCheck

L["?"] = "？"
L["AFK"] = "暫離"
L["AFK color"] = "暫離的顏色"
L["Color for AFK."] = "暫離的顏色"
L["Color for Not Ready."] = "尚未就緒的顏色"
L["Color for Ready."] = "就緒的顏色"
L["Color for Waiting."] = "等待中的顏色"
L["Delay"] = "延遲"
L["Not Ready color"] = "尚未就緒的顏色"
L["R"] = "是"
L["Ready Check"] = "檢查就緒"
L["Ready color"] = "就緒的顏色"
L["Set the delay until ready check results are cleared."] = "設定檢查就續結果清除的延遲。"
L["Waiting color"] = "等待中的顏色"
L["X"] = "否"

------------------------------------------------------------------------
--	GridStatusTarget

L["Target"] = "目標"
L["Your Target"] = "你的目標"

------------------------------------------------------------------------
--	GridStatusVehicle

L["Driving"] = "操作"
L["In Vehicle"] = "載具上"

------------------------------------------------------------------------
--	GridStatusVoiceComm

L["Talking"] = "說話中"
L["Voice Chat"] = "語音"
