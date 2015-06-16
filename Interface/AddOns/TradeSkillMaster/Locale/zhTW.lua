-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                http://www.curse.com/addons/wow/tradeskill-master               --
--                                                                                --
--             A TradeSkillMaster Addon (http://tradeskillmaster.com)             --
--    All Rights Reserved* - Detailed license information included with addon.    --
-- ------------------------------------------------------------------------------ --

-- TradeSkillMaster Locale - zhTW
-- Please use the localization app on CurseForge to update this
-- http://wow.curseforge.com/addons/TradeSkill-Master/localization/

local L = LibStub("AceLocale-3.0"):NewLocale("TradeSkillMaster", "zhTW")
if not L then return end

L["Act on Scan Results"] = "根據掃描結果執行" -- Needs review
L["A custom price of %s for %s evaluates to %s."] = "%s的自定義價格為%s到%s。" -- Needs review
L["Add >>>"] = "添加 >>>"
L["Add Additional Operation"] = "添加新操作" -- Needs review
L["Add Items to this Group"] = "添加物品至該分組" -- Needs review
L["Additional error suppressed"] = "隱藏的其他錯誤"
L["Adjust Post Parameters"] = "調整上架參數" -- Needs review
L["Advanced Option Text"] = "高級選項文字" -- Needs review
L["Advanced topics..."] = "高級主題…" -- Needs review
L["A group is a collection of items which will be treated in a similar way by TSM's modules."] = "分組是一些被TSM模組以類似方法處理的所有物品的合集。" -- Needs review
L["All items with names containing the specified filter will be selected. This makes it easier to add/remove multiple items at a time."] = "所有名字包含特定過濾條件的物品都將被選中。這將使一次性添加/移除多個物品變得簡單。" -- Needs review
L["Allows for testing of custom prices."] = "允許測試自定義價格。"
L["Allows you to build a queue of crafts that will produce a profitable, see what materials you need to obtain, and actually craft the items."] = "允許你建立一個可盈利的專業技能物品佇列，查看你需要準備哪些材料并製造它們。"
L["Allows you to quickly and easily empty your mailbox as well as automatically send items to other characters with the single click of a button."] = "允許你快速、容易的清空你的郵箱，以及點擊一個按紐自動郵寄物品給其他角色。"
L["Allows you to use data from http://wowuction.com in other TSM modules and view its various price points in your item tooltips."] = "允許你在TSM其他模組中使用來自http://wowuction.com的數據，并可在滑鼠提示中查看物品各方面的價格。" -- Needs review
L["Along the bottom of the AH are various tabs. Click on the 'Auctioning' AH tab."] = "拍賣行介面底部的是各種相關的標籤頁。請點擊“拍賣”標籤。" -- Needs review
L["Along the bottom of the AH are various tabs. Click on the 'Shopping' AH tab."] = "拍賣行介面底部的是各種相關的標籤頁。請點擊“購買”標籤。" -- Needs review
L["Along the top of the TSM_Crafting window, click on the 'Professions' button."] = "請點擊TSM_Crafting窗口上方的“專業技能”按紐。" -- Needs review
L["Along the top of the TSM_Crafting window, click on the 'TSM Groups' button."] = "請點擊TSM_Crafting窗口上方的“TSM分組”按紐。" -- Needs review
L["Along top of the window, on the left side, click on the 'Groups' icon to open up the TSM group settings."] = "請點擊窗口左上方的“分組”圖標打開TSM分組設定。" -- Needs review
L["Along top of the window, on the left side, click on the 'Module Operations / Options' icon to open up the TSM module settings."] = "請點擊窗口左上方的“模組操作/選項”圖標打開TSM模組設定。" -- Needs review
L["Along top of the window, on the right side, click on the 'Crafting' icon to open up the TSM_Crafting page."] = "請點擊窗口右上方的“製造”圖標來打開TSM_Crafting頁面。" -- Needs review
L["Alt-Click to immediately buyout this auction."] = "Alt+點擊立即以直購價買下該拍賣品。" -- Needs review
L["A maximum of 1 convert() function is allowed."] = "最多只允許1個convert()函數。" -- Needs review
L["A maximum of 1 gold amount is allowed."] = "最多只允許1個金幣數量值。" -- Needs review
L["Any subgroups of this group will also be deleted, with all items being returned to the parent of this group or removed completely if this group has no parent."] = "所有該分組的子分組都將被刪除，同時分組內的所有物品移到父級分組，若沒有父級分組則刪除所有該分組包含的物品。" -- Needs review
L["Appearance Data"] = "外觀數據" -- Needs review
L["Application and Addon Developer:"] = "桌面程式以及插件開發人員：" -- Needs review
L["Applied %s to %s."] = "將%s應用到%s。" -- Needs review
L["Apply Operation to Group"] = "將操作應用到分組" -- Needs review
L["Are you sure you want to delete the selected profile?"] = "你確定要刪除選定的配置檔？" -- Needs review
L["A simple, fixed gold amount."] = "簡單的固定金幣數量值。" -- Needs review
L["Assign this operation to the group you previously created by clicking on the 'Yes' button in the popup that's now being shown."] = "點擊現在彈出的對話框中的“是”把該操作分配到你事先創建的分組。" -- Needs review
L["A TSM_Auctioning operation will allow you to set rules for how auctionings are posted/canceled/reset on the auction house. To create one for this group, scroll down to the 'Auctioning' section, and click on the 'Create Auctioning Operation' button."] = "TSM_Auctioning（拍賣）操作將允許你為如何在拍賣行進行上架/撤銷/重上架設定規則。下拉至“拍賣”部份，點擊“創建拍賣操作”按紐來為該分組創建一個拍賣操作。" -- Needs review
L["A TSM_Crafting operation will allow you automatically queue profitable items from the group you just made. To create one for this group, scroll down to the 'Crafting' section, and click on the 'Create Crafting Operation' button."] = "TSM_Crafting（製造）操作允許你將自建分組中的可盈利物品自動添加至製造序列。下拉至“製造”部份，點擊“創建製造操作”按紐來為該組創建一個製造操作。" -- Needs review
L["A TSM_Shopping operation will allow you to set a maximum price we want to pay for the items in the group you just made. To create one for this group, scroll down to the 'Shopping' section, and click on the 'Create Shopping Operation' button."] = "TSM_Shopping（購買）操作允許你為自建分組中的物品設定愿意支付的最大價格。下拉至“購買”部份，點擊“創建購買操作”按紐來為該組創建一個購買操作。" -- Needs review
L["At the top, switch to the 'Crafts' tab in order to view a list of crafts you can make."] = "在頂部切換至“製造”標籤頁以查看你可製作的專業技能物品列表。" -- Needs review
L["Auctionator - Auction Value"] = "Auctionator - 拍賣價格"
L["Auction Buyout:"] = "拍賣直購價：" -- Needs review
L["Auction Buyout: %s"] = "拍賣直購價：%s" -- Needs review
L["Auctioneer - Appraiser"] = "Auctioneer - 出價"
L["Auctioneer - Market Value"] = "Auctioneer - 市場價格"
L["Auctioneer - Minimum Buyout"] = "Auctioneer - 最小直購價"
L["Auction Frame Scale"] = "拍賣窗體比例"
L["Auction House Tab Settings"] = "拍賣行頁面設置"
L["Auction not found. Skipped."] = "未發現拍賣品，已跳過。" -- Needs review
L["Auctions"] = "拍賣"
L["Author(s):"] = "作者（們）："
L["BankUI"] = "銀行窗口" -- Needs review
L["Below are various ways you can set the value of the current editbox. Any combination of these methods is also supported."] = "你可以通過以下列出的多種方式設定該編輯框。也允許組合使用這些方式。" -- Needs review
L["Below are your currently available price sources. The %skey|r is what you would type into a custom price box."] = "以下列出的是當前可用的價格源。%s關鍵字|r是你應該輸入到自定義價格框中的文字。" -- Needs review
L["Below is a list of groups which this operation is currently applied to. Clicking on the 'Remove' button next to the group name will remove the operation from that group."] = "下面是當前受該操作所影響的所有分組的列表。點擊分組名稱旁的“移除”按紐使該操作不對其生效。" -- Needs review
L["Below, set the custom price that will be evaluated for this custom price source."] = "在下面為該自定義價格源設定如何計算自定義價格。" -- Needs review
L["Border Thickness (Requires Reload)"] = "邊框厚度（需重載）" -- Needs review
L["Buy from Vendor"] = "向商人購買" -- Needs review
L["Buy items from the AH"] = "從拍賣購買物品" -- Needs review
L["Buy materials for my TSM_Crafting queue"] = "為我的製造序列購買材料" -- Needs review
L["Canceling Auction: %d/%d"] = "撤銷拍賣：%d/%d" -- Needs review
L["Cancelled - Bags and bank are full"] = "已取消 - 背包和銀行已滿"
L["Cancelled - Bags and guildbank are full"] = "已取消 - 背包和公會銀行已滿"
L["Cancelled - Bags are full"] = "已取消 - 背包已滿"
L["Cancelled - Bank is full"] = "已取消 - 銀行已滿"
L["Cancelled - Guildbank is full"] = "已取消 - 公會銀行已滿"
L["Cancelled - You must be at a bank or guildbank"] = "已取消 - 您必須打開銀行或者公會銀行"
L["Cannot delete currently active profile!"] = "不能刪除當前使用的配置檔!"
L["Category Text 2 (Requires Reload)"] = "分類文字2（需重載）" -- Needs review
L["Category Text (Requires Reload)"] = "分類文字（需重載）" -- Needs review
L["|cffffff00DO NOT report this as an error to the developers.|r If you require assistance with this, make a post on the TSM forums instead."] = "|cffffff0不要把這個作為錯誤回報給開發者。|r如果你需要這個的更多幫助，可在TSM論壇發貼尋求指導。" -- Needs review
L[ [=[|cffffff00Important Note:|r You do not currently have any modules installed / enabled for TradeSkillMaster! |cff77ccffYou must download modules for TradeSkillMaster to have some useful functionality!|r

Please visit http://www.curse.com/addons/wow/tradeskill-master and check the project description for links to download modules.]=] ] = "|cffffff00重要資訊：|r 你沒有安裝/啟動任何TSM功能模塊! |cff77ccff你必須下載一些有用的TSM功能模塊!|r\\n\\n請查閱 http://www.curse.com/addons/wow/tradeskill-master 和下載功能模塊和模塊說明書。"
L["Changes how many rows are shown in the auction results tables."] = "設定在拍賣結果頁中顯示多少行結果。" -- Needs review
L["Changes the size of the auction frame. The size of the detached TSM auction frame will always be the same as the main auction frame."] = "改變拍賣行的窗體大小。分離的拍賣行窗體大小總是與主拍賣窗口一樣。"
L["Character Name on Other Account"] = "角色名稱位于其他賬號" -- Needs review
L["Chat Tab"] = "聊天標籤" -- Needs review
L["Check out our completely free, desktop application which has tons of features including deal notification emails, automatic updating of AuctionDB and WoWuction prices, automatic TSM setting backup, and more! You can find this app by going to %s."] = "請關注我們全新出品的完全免費的桌面應用！很多非常實用的精彩功能等您體驗：交易提醒郵件、自動更新AuctionDB和Wowuction價格、自動備份TSM配置文件等等…您可以在以下地址下載：%s" -- Needs review
L["Check this box to override this group's operation(s) for this module."] = "勾選后覆蓋父級分組操作設定" -- Needs review
L["Clear"] = "清除"
L["Clear Selection"] = "消除選擇" -- Needs review
L["Click on the Auctioning Tab"] = "點擊拍賣標籤" -- Needs review
L["Click on the Crafting Icon"] = "點擊“製造”圖標" -- Needs review
L["Click on the Groups Icon"] = "點擊“分組”圖標" -- Needs review
L["Click on the Module Operations / Options Icon"] = "點擊“模組操作/選項”圖標" -- Needs review
L["Click on the Shopping Tab"] = "點擊“購買”標籤" -- Needs review
L["Click on the 'Show Queue' button at the top of the TSM_Crafting window to show the queue if it's not already visible."] = "若製造序列當前沒有顯示，點擊TSM_Crafting上方的“顯示製造序列”按紐使其顯示出來。" -- Needs review
L["Click on the 'Start Sniper' button in the sidebar window."] = "點擊窗口側邊欄的“Start Sniper(o)”按紐。" -- Needs review
L["Click on the 'Start Vendor Search' button in the sidebar window."] = "點擊窗口側邊欄的\"Start Vendor Search(o)\"按紐。" -- Needs review
L["Click the button below to open the export frame for this group."] = "點擊下面按鈕打開分組導出介面" -- Needs review
L["Click this button to completely remove this operation from the specified group."] = "點擊該按紐將此操作從指定分組完全移除。" -- Needs review
L["Click this button to configure the currently selected operation."] = "點擊這個按鈕配置當前選中的操作"
L["Click this button to create a new operation for this module."] = "點擊該按紐為此模組創建新操作" -- Needs review
L["Click this button to show a frame for easily exporting the list of items which are in this group."] = "點擊該按紐顯示該組中所有物品的列表以便于導出。" -- Needs review
L["Co-Founder:"] = "公司創始人：" -- Needs review
L["Coins:"] = "金幣樣式：" -- Needs review
L["Color Group Names by Depth"] = "根據層級顯示分組名稱顏色" -- Needs review
L["Content - Backdrop"] = "內容 - 底色" -- Needs review
L["Content - Border"] = "內容 - 邊框"
L["Content Text - Disabled"] = "內容文字 - 禁用" -- Needs review
L["Content Text - Enabled"] = "內容文字 - 啟用"
L["Copy From"] = "複製自"
L["Copy the settings from one existing profile into the currently active profile."] = "將已存在配置檔中的設定複製到當前配置檔" -- Needs review
L["Craft Items from Queue"] = "從序列製造物品" -- Needs review
L["Craft items with my professions"] = "用我的專業技能製造物品" -- Needs review
L["Craft specific one-off items without making a queue"] = "不創建序列製造一次性物品" -- Needs review
L["Create a new empty profile."] = "創建一個新的配置檔" -- Needs review
L["Create a New Group"] = "創建一個新分組" -- Needs review
L["Create a new group by typing a name for the group into the 'Group Name' box and pressing the <Enter> key."] = "在“分組名稱”編輯框內為分組輸入一個名稱并按回車鍵創建一個新的分組。" -- Needs review
L["Create a new %s operation by typing a name for the operation into the 'Operation Name' box and pressing the <Enter> key."] = "在\"操作名稱\"編輯框內為操作輸入一個名稱并按回車鍵創建一個新的%s操作。" -- Needs review
L["Create a %s Operation %d/5"] = "創建一個%s操作%d/5" -- Needs review
L["Create New Subgroup"] = "新建子分組"
L["Create %s Operation"] = "創建%s操作" -- Needs review
L["Create the Craft"] = "生成一項製造" -- Needs review
L["Creating a relationship for this setting will cause the setting for this operation to be equal to the equivalent setting of another operation."] = "為此設定建立關聯,會使該操作的此設定等同於選定操作的此設定。"
L["Crystals"] = "水晶"
L["Current Profile:"] = "當前配置檔"
L["Custom Price for this Source"] = "為該源自定義價格" -- Needs review
L["Custom Price Source"] = "自定義價格源" -- Needs review
L["Custom Price Source Name"] = "自定義價格源名稱" -- Needs review
L["Custom Price Sources"] = "自定義價格源列表" -- Needs review
L["Custom price sources allow you to create more advanced custom prices throughout all of the TSM modules. Just as you can use the built-in price sources such as 'vendorsell' and 'vendorbuy' in your custom prices, you can use ones you make here (which themselves are custom prices)."] = "自定義價格源允許你創建更多高級自定義價格用于所有TSM模組。你可以在你的自定義價格源中使用多種內建的價格源例如“vendorsell”或“vendorbuy”等等。你可以在多個地方使用在這里創建的自定義價格源。" -- Needs review
L["Custom price sources to display in item tooltips:"] = "顯示在滑鼠提示的自定義價格源：" -- Needs review
L["Default"] = "默認"
L["Default BankUI Tab"] = "默認銀行介面標籤" -- Needs review
L["Default Group Tab"] = "默認分組標籤"
L["Default Tab"] = "默認標籤"
L["Default Tab (Open Auction House to Enable)"] = "默認標籤（打開拍賣行啟用）"
L["Delete a Profile"] = "刪除一個配置檔"
L["Delete Custom Price Source"] = "刪除自定義價格源" -- Needs review
L["Delete existing and unused profiles from the database to save space, and cleanup the SavedVariables file."] = "刪除已存在的無用配置檔來釋放空間，并清理SaveVariables文件。" -- Needs review
L["Delete Group"] = "刪除分組"
L["Delete Operation"] = "刪除操作"
L["Description:"] = "說明："
L["Deselect All Groups"] = "取消所有分組選定" -- Needs review
L["Deselects all items in both columns."] = "左右欄全部取消"
L["Disenchant source:"] = "分解價格來源：" -- Needs review
L["Disenchant Value"] = "分解價格"
L["Disenchant Value:"] = "分解價格：" -- Needs review
L["Disenchant Value x%s:"] = "分解價值x%s：" -- Needs review
L["Display disenchant value in tooltip."] = "在滑鼠提示中顯示分解價值。" -- Needs review
L["Display Group / Operation Info in Tooltips"] = "在滑鼠提示中顯示分組/操作資訊"
L["Display prices in tooltips as:"] = "滑鼠提示價格格式設定：" -- Needs review
L["Display vendor buy price in tooltip."] = "在滑鼠提示中顯示商人購買價格。" -- Needs review
L["Display vendor sell price in tooltip."] = "在滑鼠提示中顯示商人出售價格。" -- Needs review
L["Done"] = "完成"
L["Done!"] = "完成！" -- Needs review
L["Double-click to collapse this item and show only the cheapest auction."] = "雙擊折叠該物品并只顯示最便宜的拍賣品。" -- Needs review
L["Double-click to expand this item and show all the auctions."] = "雙擊展開該物品并顯示所有拍賣品。" -- Needs review
L["Duplicate Operation"] = "複製操作"
L["Duration:"] = "持續：" -- Needs review
L["Dust"] = "塵"
L["Embed TSM Tooltips"] = "將TSM滑鼠提示嵌入內建滑鼠提示" -- Needs review
L["Empty price string."] = "清空價格字串。" -- Needs review
L["Enter Filters and Start Scan"] = "輸入過濾條件并開始搜索(o)" -- Needs review
L["Enter Import String"] = "輸入導入字串(o)" -- Needs review
L["Error creating custom price source. Custom price source with name '%s' already exists."] = "創建自定義價格源出錯。名為“%s”的自定義價格源已存在。" -- Needs review
L["Error creating group. Group with name '%s' already exists."] = "創建分組失敗，名為“%s”的分組已存在。" -- Needs review
L["Error creating subgroup. Subgroup with name '%s' already exists."] = "創建子分組失敗，名為“%s”的子分組已存在。" -- Needs review
L["Error duplicating operation. Operation with name '%s' already exists."] = "複製“操作”失敗。名為“%s”的操作已存在。" -- Needs review
L["Error Info:"] = "錯誤資訊："
L["Error moving group. Group '%s' already exists."] = "移動分組失敗，分組“%s”已存在。" -- Needs review
L["Error moving group. You cannot move this group to one of its subgroups."] = "移動分組出錯。你不能將該分組移動到它的子分組。" -- Needs review
L["Error renaming custom price source. Custom price source with name '%s' already exists."] = "重命名自定義價格源失敗。名為“%s”的自定義價格源已存在。" -- Needs review
L["Error renaming group. Group with name '%s' already exists."] = "重命名分組失敗，名為“%s”的分組已存在。" -- Needs review
L["Error renaming operation. Operation with name '%s' already exists."] = "重命名操作失敗，名為“%s”的操作已存在。" -- Needs review
L["Essences"] = "精華"
L["Examples"] = "例子"
L["Existing Profiles"] = "已存在的配置檔" -- Needs review
L["Export Appearance Settings"] = "導出外觀設置" -- Needs review
L["Export Group Items"] = "導出分組物品"
L["Export Items in Group"] = "導出分組物品"
L["Export Operation"] = "導出“操作”" -- Needs review
L["Failed to parse gold amount."] = "無法解析金幣數額"
L["First, ensure your new group is selected in the group-tree and then click on the 'Restock Selected Groups' button at the bottom."] = "首先，確保你的新分組在分組列表中被選中，然后點擊“為選定分組補貨”按紐。" -- Needs review
L["First, ensure your new group is selected in the group-tree and then click on the 'Start Cancel Scan' button at the bottom of the tab."] = "首先，確保你的新分組在分組列表中被選中，然后點擊介面底部的“開始撤銷掃描”按紐。" -- Needs review
L["First, ensure your new group is selected in the group-tree and then click on the 'Start Post Scan' button at the bottom of the tab."] = "首先，確保你的新分組在分組列表中被選中，然後點擊介面底部的“開始上架掃描”按紐。" -- Needs review
L["First, ensure your new group is selected in the group-tree and then click on the 'Start Search' button at the bottom of the sidebar window."] = "首先，確保你的新分組在分組列表中被選中，然後點擊側邊欄底部的“開始搜索”按紐。" -- Needs review
L["First, log into a character on the same realm (and faction) on both accounts. Type the name of the OTHER character you are logged into in the box below. Once you have done this on both accounts, TSM will do the rest automatically. Once setup, syncing will automatically happen between the two accounts while on any character on the account (not only the one you entered during this setup)."] = "首先，登入需要同步的兩個帳號的角色，兩個帳號的角色必須是在同區域同陣營，並在下框中填入另一個角色的名字。在兩個帳號內都設置好後，剩下的由TSM自動完成。設置完畢後，同步帳號中任意角色（不僅僅是下框中輸入的）登入時，帳號間資訊都會自動同步。"
L["Fixed Gold Value"] = "固定金幣數額" -- Needs review
L["Forget Characters:"] = "遺忘角色：" -- Needs review
L["Frame Background - Backdrop"] = "介面背景 - 底色" -- Needs review
L["Frame Background - Border"] = "介面背景 - 邊框" -- Needs review
L["General Options"] = "常規選項"
L["General Settings"] = "常規設定"
L["Give the group a new name. A descriptive name will help you find this group later."] = "給該分組一個新名稱，一個描述性的名稱將方便您以后找到它。" -- Needs review
L["Give the new group a name. A descriptive name will help you find this group later."] = "為新分組命名，一個描述性的名稱將方便您以后找到它。" -- Needs review
L["Give this operation a new name. A descriptive name will help you find this operation later."] = "給該操作一個新名稱，一個描述性的名稱將方便您以后找到它。" -- Needs review
L["Give your new custom price source a name. This is what you will type in to custom prices and is case insensitive (everything will be saved as lower case)."] = "為新的自定義價格源命名。不區分大小寫，所有字符都將保存為小寫。" -- Needs review
L["Goblineer (by Sterling - The Consortium)"] = "Goblineer (by Sterling - The Consortium)"
L["Go to the Auction House and open it."] = "訪問拍賣行并打開拍賣介面" -- Needs review
L["Go to the 'Groups' Page"] = "轉至“分組”頁面" -- Needs review
L["Go to the 'Import/Export' Tab"] = "轉至“導入/導出\"標籤" -- Needs review
L["Go to the 'Items' Tab"] = "轉至\"物品\"標籤" -- Needs review
L["Go to the 'Operations' Tab"] = "轉至\"操作\"標籤" -- Needs review
L["Group:"] = "分組：" -- Needs review
L["Group(Base Item):"] = "分組（基本項）" -- Needs review
L["Group Item Data"] = "分組物品數據" -- Needs review
L["Group Items:"] = "分組物品：" -- Needs review
L["Group Name"] = "分組名稱"
L["Group names cannot contain %s characters."] = "分組名稱不能包含%s字符。" -- Needs review
L["Groups"] = "分組"
L["Help"] = "幫助" -- Needs review
L["Help / Options"] = "幫助/選項" -- Needs review
L["Here you can setup relationships between the settings of this operation and other operations for this module. For example, if you have a relationship set to OperationA for the stack size setting below, this operation's stack size setting will always be equal to OperationA's stack size setting."] = "你可以在這里為該模組設置此操作與其他操作的關聯性。例如，若你將下邊的“堆疊大小”關聯到“操作A”，那麼該操作中的“堆疊大小”參數將始終與“操作A”中的“堆疊大小”參數相等。" -- Needs review
L["Hide Minimap Icon"] = "隱藏小地圖圖標"
L["How would you like to craft?"] = "你希望如何進行製造？" -- Needs review
L["How would you like to create the group?"] = "你希望如何創建分組？" -- Needs review
L["How would you like to post?"] = "你希望如何上架（進行拍賣）？" -- Needs review
L["How would you like to shop?"] = "你希望如何購買？" -- Needs review
L["Icon Region"] = "圖標區域" -- Needs review
L["If checked, all tables listing auctions will display the bid as well as the buyout of the auctions. This will not take effect immediately and may require a reload."] = "若勾選，表格中列出的所有拍賣品將同時顯示競拍價與一口價。該功能重載介面后生效。"
L["If checked, any items you import that are already in a group will be moved out of their current group and into this group. Otherwise, they will simply be ignored."] = "若勾選，導入的物品如果已存在于一個分組內，則將它們移出原有分組并加入該分組。否則，它們將被忽略。" -- Needs review
L["If checked, group names will be colored based on their subgroup depth in group trees."] = "若勾選，分組名稱將基于它所處的分組樹中的深度進行著色。" -- Needs review
L["If checked, only items which are in the parent group of this group will be imported."] = "若勾選，只有存在于該分組的父級分組內的物品才會被導入。" -- Needs review
L["If checked, operations will be stored globally rather than by profile. TSM groups are always stored by profile. Note that if you have multiple profiles setup already with separate operation information, changing this will cause all but the current profile's operations to be lost."] = "若勾選，“操作”將改為全局保存而不是按配置檔保存。TSM分組則始終按配置檔保存。注意，如果你之前已在多個配置檔下設置了分開的“操作”設定，勾選此項將導致除當前配置檔外的其他所有配置檔的“操作”設定丟失。" -- Needs review
L["If checked, the disenchant value of the item will be shown. This value is calculated using the average market value of materials the item will disenchant into."] = "若勾選，物品的分解價值將被顯示。這個價值是由物品可被分解成的附魔材料的市場平均價格計算而來。" -- Needs review
L["If checked, the price of buying the item from a vendor is displayed."] = "若勾選，顯示從商人購買該物品的價格。" -- Needs review
L["If checked, the price of selling the item to a vendor displayed."] = "若勾選，顯示該物品賣給商人的價格。" -- Needs review
L["If checked, the structure of the subgroups will be included in the export. Otherwise, the items in this group (and all subgroups) will be exported as a flat list."] = "若勾選，在導出時也將包括子分組的層級結構。否則，該分組（包括子分組）的所有物品將按一個列表導出。" -- Needs review
L["If checked, this custom price will be displayed in item tooltips."] = "若勾選，這個自定義價格將顯示在滑鼠提示。" -- Needs review
L["If checked, TSM's tooltip lines will be embedded in the item tooltip. Otherwise, it will show as a separate box below the item's tooltip."] = "若勾選，TSM的滑鼠提示行將嵌入到內建滑鼠提示中，否則，將在內建滑鼠提示下方單獨顯示一個提示框。" -- Needs review
L["If checked, ungrouped items will be displayed in the left list of selection lists used to add items to subgroups. This allows you to add an ungrouped item directly to a subgroup rather than having to add to the parent group(s) first."] = "若勾選，未分組物品將會顯示在選擇列表的左側，以便添加物品至子分組。此項允許直接添加未分組物品至子分組，無需先添加至主分組。" -- Needs review
L["If checked, your bags will be automatically opened when you open the auction house."] = "若勾選，你的背包將會在你打開拍賣行時自動開啟。"
L["If there are no auctions currently posted for this item, simmply click the 'Post' button at the bottom of the AH window. Otherwise, select the auction you'd like to undercut first."] = "若當前拍賣行中沒有該物品在進行拍賣，直接點擊拍賣介面下方的“上架”按紐。否則，先選擇一個你想壓價的拍賣項。" -- Needs review
L["If you delete, rename, or transfer a character off the current faction/realm, you should remove it from TSM's list of characters using this dropdown."] = "如果你將一個角色刪除、重命名、轉服或轉陣營，你應該使用這個下拉選單將其從TSM列表中移除。" -- Needs review
L[ [=[If you'd like, you can adjust the value in the 'Minimum Profit' box in order to specify the minimum profit before Crafting will queue these items.

Once you're done adjusting this setting, click the button below.]=] ] = [=[如果你想，你可以在製造序列物品前通過調整“最小利潤”編輯框中的值來指定最小利潤。

如果你已經完成了該項操作的調整，點擊下面的按紐。]=] -- Needs review
L["If you have multiple profile set up with operations, enabling this will cause all but the current profile's operations to be irreversibly lost. Are you sure you want to continue?"] = "警告：如果你在多個配置檔下設定了“操作”選項，該操作會導致除了當前配置檔以外的所有配置檔中的“操作”選項永久性丟失。你確定要繼續嗎？" -- Needs review
L["If you open your bags and shift-click the item in your bags, it will be placed in Shopping's search bar. You may need to put your cursor in the search bar first. Alternatively, you can type the name of the item manually in the search bar and then hit enter or click the 'Search' button."] = "若你打開背包并按住Shift在背包中點擊物品，它會被填入購買介面的搜索欄（你可能需要先用滑鼠在搜索欄點一下）。另外，你也可以在搜索欄手動輸入物品名稱并點擊“搜索”按紐。" -- Needs review
L["Ignore Operation on Characters:"] = "在以下角色忽略該操作：" -- Needs review
L["Ignore Operation on Faction-Realms:"] = "在以下陣營-伺服器忽略該操作：" -- Needs review
L["Ignore Random Enchants on Ungrouped Items"] = "忽略隨機附魔的未分組物品"
L["I'll Go There Now!"] = "現在我要去那！"
L["I'm done."] = "我已完成。" -- Needs review
L["Import Appearance Settings"] = "導入外觀設定" -- Needs review
L["Import/Export"] = "導入/導出"
L["Import Items"] = "導入物品"
L["Import Operation Settings"] = "導入操作設定" -- Needs review
L["Import Preset TSM Theme"] = "導入預設TSM主題" -- Needs review
L["Import String"] = "導入字串" -- Needs review
L["Include Subgroup Structure in Export"] = "導出時包括子分組結構" -- Needs review
L["Installed Modules"] = "已安裝模組"
L["In the confirmation window, you can adjust the buyout price, stack sizes, and auction duration. Once you're done, click the 'Post' button to post your items to the AH."] = "在確認窗口，你可以調整直購價、堆疊大小和拍賣持續時間。當你完成設置，點擊“上架”按紐將你的物品上架至拍賣行。" -- Needs review
L["In the list on the left, select the top-level 'Groups' page."] = "在左邊的列表中，選擇頂部的“分組”頁面。" -- Needs review
L["Invalid appearance data."] = "無效的外觀數據。" -- Needs review
L["Invalid custom price."] = "無效的自定義價格。"
L["Invalid custom price for undercut amount. Using 1c instead."] = "無效的自定義壓價數額，已修正為1銅。" -- Needs review
L["Invalid filter."] = "無效的過濾條件。" -- Needs review
L["Invalid function."] = "無效函數。" -- Needs review
L["Invalid import string."] = "無效的導入字符串。" -- Needs review
L["Invalid item link."] = "無效的物品鏈接。"
L["Invalid operator at end of custom price."] = "無效的自定義價格運算符" -- Needs review
L["Invalid parameter to price source."] = "無效的自定義價格源參數。" -- Needs review
L["Invalid parent argument type. Expected table, got %s."] = "無效的父級參數類型。預期表格，得到%s。" -- Needs review
L["Invalid price source in convert."] = "轉換價格來源無效"
L["Invalid word: '%s'"] = "無效詞：“%s”" -- Needs review
L["Item"] = "物品"
L["Item Buyout: %s"] = "物品直購價：%s" -- Needs review
L["Item Level"] = "物品等級"
L["Item links may only be used as parameters to price sources."] = "物品鏈接只能作為價格源的參數。" -- Needs review
L["Item not found in bags. Skipping"] = "未在背包中找到物品，跳過" -- Needs review
L["Items"] = "物品"
L["Item Tooltip Text"] = "物品滑鼠提示文字" -- Needs review
L["Jaded (by Ravanys - The Consortium)"] = "Jaded (by Ravanys - The Consortium)"
L["Just incase you didn't read this the first time:"] = "以防您在第一時間沒有看到這個："
L[ [=[Just like the default profession UI, you can select what you want to craft from the list of crafts for this profession. Click on the one you want to craft.

Once you're done, click the button below.]=] ] = [=[像在內建專業介面中一樣，你可以在這個專業列表中選擇一項你想製造的物品。在一項你想製造的項目上點擊。

一旦你完成了操作，點擊下面的按紐。]=] -- Needs review
L["Keep Items in Parent Group"] = "將物品移至父級分組" -- Needs review
L["Keeps track of all your sales and purchases from the auction house allowing you to easily track your income and expenditures and make sure you're turning a profit."] = "保持追蹤你在拍賣行的所有銷售和購買將允許你輕松的追蹤你的收入與支出並確認你是否在創造利潤。" -- Needs review
L["Label Text - Disabled"] = "標籤文字 - 禁用"
L["Label Text - Enabled"] = "標籤文字 - 啟用"
L["Lead Developer and Co-Founder:"] = "開發人員領導及創始人："
L["Light (by Ravanys - The Consortium)"] = "Light (by Ravanys - The Consortium)"
L["Link Text 2 (Requires Reload)"] = "連結文字2（需重載）" -- Needs review
L["Link Text (Requires Reload)"] = "連結文字（需重載）" -- Needs review
L["Load Saved Theme"] = "載入保存的主題" -- Needs review
L["Look at what's profitable to craft and manually add things to a queue"] = "看看你有哪些製造可盈利，將其手動添加至序列" -- Needs review
L["Look for items which can be destroyed to get raw mats"] = "尋找可被分解成原材料的物品" -- Needs review
L["Look for items which can be vendored for a profit"] = "尋找可被賣給商人盈利的物品" -- Needs review
L["Looks like no items were added to the queue. This may be because you are already at or above your restock levels, or there is nothing profitable to queue."] = "看上去沒有物品被添加到序列。這可能是因為物品已經序列中或超過補貨上限，也可能是沒有可盈利物品。" -- Needs review
L["Looks like no items were found. You can either try searching for something else, or simply close the Assistant window if you're done."] = "看上去沒有物品被找到，你可以試試搜索別的物品，或者直接關閉幫助介面" -- Needs review
L["Looks like no items were imported. This might be because they are already in another group in which case you might consider checking the 'Move Already Grouped Items' box to force them to move to this group."] = "似乎沒有物品被導入。這可能是因為它們已經存在于其他分組中，這種情況下你可以考慮勾選“移動已有分組物品”選擇框來強制這些物品移動到該組。" -- Needs review
L["Looks like TradeSkillMaster has detected an error with your configuration. Please address this in order to ensure TSM remains functional."] = "TradeSkillMaster似乎在你的配置中檢測到了一個錯誤。請解決這個問題確保TSM正常工作。" -- Needs review
L["Looks like TradeSkillMaster has encountered an error. Please help the author fix this error by copying the entire error below and following the instructions for reporting bugs listed here (unless told elsewhere by the author):"] = "看起來TradeSkillMaster似乎發生了一個錯誤。請複製下方完整的錯誤資訊并按列在這里的方法（除非作者另外指定）反饋給作者以幫助作者解決這個問題："
L["Looks like TradeSkillMaster has encountered an error. Please help the author fix this error by following the instructions shown."] = "看起來TradeSkillMaster似乎發生了一個錯誤。請按照下列指示協助作者修正此問題。"
L["Loop detected in the following custom price:"] = "在以下自定義價格中循環檢測：" -- Needs review
L["Make a new group from an import list I have"] = "根據導入的物品列表創建新分組" -- Needs review
L["Make a new group from items in my bags"] = "根據背包中的物品創建新分組" -- Needs review
L["Make Auction Frame Movable"] = "使拍賣行窗體可拖曳移動"
L["Management"] = "管理"
L["Manages your inventory by allowing you to easily move stuff between your bags, bank, and guild bank."] = "允許你更輕鬆的在背包、銀行及公會銀行間移動貨物以管理你的庫存。"
L["% Market Value"] = "% 的市場價"
L["max %d"] = "最大%d" -- Needs review
L["Medium Text Size (Requires Reload)"] = "中等文本大小（需重載）" -- Needs review
L["Mills, prospects, and disenchants items at super speed!"] = "以超高速度分解裝備、探勘礦石以及研磨草藥!"
L["Misplaced comma"] = "錯誤的逗號分隔"
L["Module:"] = "模組："
L["Module Information:"] = "模組資訊：" -- Needs review
L["Module Operations / Options"] = "模組操作/選項"
L["Modules"] = "模組" -- Needs review
L["More Advanced Methods"] = "更多高級模式"
L["More advanced options are now designated by %sred text|r. Beginners are encourages to come back to these once they have a solid understanding of the basics."] = "更多高級選項現已用%s紅色文字|r標出。鼓勵初學者在有堅實基礎之后回來研究這些。" -- Needs review
L["Move Already Grouped Items"] = "移動已有分組物品" -- Needs review
L["Moved %s to %s."] = "移動%s到%s。" -- Needs review
L["Move Group"] = "移動分組"
L["Move to Top Level"] = "移動至最高級" -- Needs review
L["Multi-Account Settings"] = "多賬號設定" -- Needs review
L["My group is selected."] = "我的分組已選中。" -- Needs review
L["My new operation is selected."] = "我的新操作已選中。" -- Needs review
L["New"] = "新" -- Needs review
L["New Custom Price Source"] = "新自定義價格源" -- Needs review
L["New Group"] = "新分組" -- Needs review
L["New Group Name"] = "新分組名稱" -- Needs review
L["New Parent Group"] = "新父級分組" -- Needs review
L["New Subgroup Name"] = "新子分組名稱"
L["No Assistant guides available for the modules which you have installed."] = "你安裝的模組沒有助手指南可用。" -- Needs review
L["<No Group Selected>"] = "<沒有群組選擇>" -- Needs review
L["No modules are currently loaded.  Enable or download some for full functionality!"] = "目前沒有模組載入，請啟用或下載安裝模組以獲得完整功能。"
L["None of your groups have %s operations assigned. Type '/tsm' and click on the 'TradeSkillMaster Groups' button to assign operations to your TSM groups."] = "%s操作未分配到任何分組。輸入“/tsm”點擊“分組”按紐來給你的TSM分組分配操作。" -- Needs review
L["<No Operation>"] = "<沒有操作>"
L["<No Operation Selected>"] = "<沒有操作選擇>" -- Needs review
L["<No Relationship>"] = "<沒有關聯>"
L["Normal Text Size (Requires Reload)"] = "一般文字大小（需重載）" -- Needs review
L[ [=[Now that the scan is finished, you can look through the results shown in the log, and for each item, decide what action you want to take.

Once you're done, click on the button below.]=] ] = [=[現在掃描已經完成，你可以通過日誌檢視結果并基于每個物品決定你想得到什麽。

一旦你完成了操作，點擊下面的按紐。]=] -- Needs review
L["Number of Auction Result Rows (Requires Reload)"] = "拍賣結果行數（需重載）" -- Needs review
L["Only Import Items from Parent Group"] = "只從父級分組導入物品" -- Needs review
L["Open All Bags with Auction House"] = "在拍賣行開啟所有背包"
L["Open one of the professions which you would like to use to craft items."] = "打開一個你想用來製造物品的專業。" -- Needs review
L["Open the Auction House"] = "打開拍賣行" -- Needs review
L["Open the TSM Window"] = "打開TSM窗口" -- Needs review
L["Open up Your Profession"] = "打開你的專業" -- Needs review
L["Operation #%d"] = "操作 #%d"
L["Operation Management"] = "操作管理"
L["Operations"] = "操作"
L["Operations: %s"] = "操作：%s" -- Needs review
L["Options"] = "選項"
L["Override Module Operations"] = "覆蓋模組操作"
L["Parent Group Items:"] = "父級分組物品：" -- Needs review
L["Parent/Ungrouped Items:"] = "父級/未分組物品：" -- Needs review
L["Past Contributors:"] = "曾經有卓越貢獻的人："
L["Paste the exported items into this box and hit enter or press the 'Okay' button. The recommended format for the list of items is a comma separated list of itemIDs for general items. For battle pets, the entire battlepet string should be used. For randomly enchanted items, the format is <itemID>:<randomEnchant> (ex: 38472:-29)."] = "粘貼導出的物品到此框並按下回車或點擊確定按鈕。一般物品的推薦格式為輸入物品ID并用半角逗號隔開。對於戰鬥寵物，必須輸入戰寵全名。對於隨機附魔物品，格式為：<物品ID>:<隨機附魔> （例如：38472:-29）。" -- Needs review
L["Paste the exported operation settings into this box and hit enter or press the 'Okay' button. Imported settings will irreversibly replace existing settings for this operation."] = "黏貼導出的操作至該框并回車或點擊“確定”按紐。導入設定將替換該模組已存在的設定，該操作不可逆。" -- Needs review
L[ [=[Paste the list of items into the box below and hit enter or click on the 'Okay' button.

You can also paste an itemLink into the box below to add a specific item to this group.]=] ] = [=[將物品列表黏貼至下框後按回車或點擊“確定”按鈕

你也可以複製一個物品鏈結到下框來添加特定的物品至該組]=] -- Needs review
L["Paste your import string into the 'Import String' box and hit the <Enter> key to import the list of items."] = "黏貼你的導入字符串至“導入字符串”編輯框并回車來導入物品列表。" -- Needs review
L["Percent of Price Source"] = "價格源的百分比" -- Needs review
L["Performs scans of the auction house and calculates the market value of items as well as the minimum buyout. This information can be shown in items' tooltips as well as used by other modules."] = "執行拍賣行掃描并計算物品的市場價以及最小直購價。這些資訊可以顯示在物品的滑鼠提示以及其它可用模組。"
L["Per Item:"] = "每物品：" -- Needs review
L["Please select the group you'd like to use."] = "請選擇你想使用的分組。" -- Needs review
L["Please select the new operation you've created."] = "請選項你已創建的新操作。" -- Needs review
L["Please wait..."] = "請稍等…" -- Needs review
L["Post"] = "上架" -- Needs review
L["Post an Item"] = "上架一個物品" -- Needs review
L["Post items manually from my bags"] = "從我的背包手動上架物品" -- Needs review
L["Posts and cancels your auctions to / from the auction house according to pre-set rules. Also, this module can show you markets which are ripe for being reset for a profit."] = "根據預設規則從拍賣行上架或撤銷您的物品。也可提示您哪些拍賣可以撤銷并以更高價上架以獲取更高利潤。" -- Needs review
L["Post Your Items"] = "上架你的物品" -- Needs review
L["Price Per Item"] = "單件價格"
L["Price Per Stack"] = "每堆價格"
L["Price Per Target Item"] = "目標物品單價"
L["Prints out the available price sources for use in custom price boxes."] = "顯示可用的價格源，供制定自定義價格使用。" -- Needs review
L["Prints out the version numbers of all installed modules"] = "顯示所有已安裝模組的版本號"
L["Profiles"] = "配置檔"
L["Provides extra functionality that doesn't fit well in other modules."] = "提供一些額外的在其他模組上未實現的功能。" -- Needs review
L["Provides interfaces for efficiently searching for items on the auction house. When an item is found, it can easily be bought, canceled (if it's yours), or even posted from your bags."] = "在拍賣行提供更高效的物品搜索介面。當物品找到時可以輕鬆的購買、撤銷（如果是你的），甚至直接從背包發布。"
L["Purchasing Auction: %d/%d"] = "購買拍賣：%d/%d" -- Needs review
L["Queue Profitable Crafts"] = "添加可盈利物品至序列" -- Needs review
L["Quickly post my items at some pre-determined price"] = "根據一些預先確定好的價格快速上架我的物品。" -- Needs review
L["Region - Backdrop"] = "區域 - 底色" -- Needs review
L["Region - Border"] = "區域 - 邊框"
L["Remove"] = "移除" -- Needs review
L["<<< Remove"] = "<<< 移除"
L["Removed '%s' as a custom price source. Be sure to update any custom prices that were using this source."] = "移除%s自定義價格源。確保升級所有在使用該自定義價格源的自定義價格。" -- Needs review
L["<Remove Operation>"] = "<移除操作>"
L["Rename Custom Price Source"] = "重命名自定義價格源" -- Needs review
L["Rename Group"] = "重命名分組"
L["Rename Operation"] = "重命名操作"
L["Replace"] = "替換"
L["Reset Profile"] = "重置配置檔"
L["Resets the position, scale, and size of all applicable TSM and module frames."] = "重置所有TSM核心和模組的位置、比例和大小設定。" -- Needs review
L["Reset the current profile back to its default values, in case your configuration is broken, or you simply want to start over."] = "重置當前配置檔至初始值，請在您的配置出錯或僅僅想重新開始時使用。" -- Needs review
L["Resources:"] = "資源：" -- Needs review
L["Restart Assistant"] = "重啟助手向導" -- Needs review
L["Restore Default Colors"] = "重設默認配色"
L["Restores all the color settings below to their default values."] = "恢復下列所有顏色設定至預設值。" -- Needs review
L["Saved theme: %s."] = "保存主題：%s。" -- Needs review
L["Save Theme"] = "保存主題"
L["%sDrag%s to move this button"] = "%s拖曳%s 移動該按紐"
L["Searching for item..."] = "搜索物品…" -- Needs review
L["Search the AH for items to buy"] = "在拍賣行搜索物品來購買" -- Needs review
L["See instructions above this editbox."] = "查看此編輯框上的說明。" -- Needs review
L["Select a group from the list below and click 'OK' at the bottom."] = "從下面列表中選擇一個分組并點擊“確定”按紐。" -- Needs review
L["Select All Groups"] = "選擇所有分組"
L["Select an operation to apply to this group."] = "選擇一個操作應用至該分組。" -- Needs review
L["Select a %s operation using the dropdown above."] = "使用上面的下拉選單選擇一個%s操作。" -- Needs review
L["Select a theme from this dropdown to import one of the preset TSM themes."] = "從該下拉選單中選擇一個預設主題。" -- Needs review
L["Select a theme from this dropdown to import one of your saved TSM themes."] = "從該下拉選單選擇一個你已保存的主題導入。" -- Needs review
L["Select Existing Group"] = "選擇已有分組" -- Needs review
L["Select Group and Click Restock Button"] = "選擇分組并點擊補貨按紐" -- Needs review
L["Select Group and Start Scan"] = "選擇分組并開始掃描" -- Needs review
L["Select the Cancel Tab"] = "選擇“撤銷”標籤" -- Needs review
L["Select the 'Cancel' tab within the operation to set the canceling options for the TSM_Auctioning operation."] = "選擇操作內部的“撤銷”標籤為TSM_Auctioning操作設置撤銷選項。" -- Needs review
L["Select the Craft"] = "選擇“製造”" -- Needs review
L["Select the 'Crafts' Tab"] = "選擇“製造”標籤" -- Needs review
L["Select the 'General' Tab"] = "選擇“一般”標籤" -- Needs review
L["Select the 'General' tab within the operation to set the general options for the TSM_Shopping operation."] = "選擇操作內部的“一般”標籤為TSM_Shopping操作設置一般選項。" -- Needs review
L[ [=[Select the group you'd like to use. Once you have done this, click on the button below.

Currently Selected Group: %s]=] ] = [=[選擇你想使用的分組。一旦你完成了這個操作，點擊下面的按紐。

當前選擇的分組：%s]=] -- Needs review
L["Select the items you want to add in the left column and then click on the 'Add >>>' button at the top to add them to this group."] = "在左側列表中選擇你想添加的物品并頂部的點擊“添加>>>”按紐將它們添加至該組。" -- Needs review
L["Select the 'Operations' page from the list on the left of the TSM window."] = "在TSM窗口的左邊列表選擇“操作”頁面。" -- Needs review
L["Select the Options Page"] = "選擇“選項”頁面" -- Needs review
L["Select the 'Options' page to change general settings for TSM_Shopping"] = "選擇“選項“頁面為TSM_Shopping修改一般設定。" -- Needs review
L["Select the Post Tab"] = "選項“上架”標籤" -- Needs review
L["Select the 'Post' tab within the operation to set the posting options for the TSM_Auctioning operation."] = "選擇操作內部的“上架”標籤為TSM_Auctioning操作設定上架選項。" -- Needs review
L["Select the price source for calculating disenchant value."] = "選擇價格源以計算分解價格。" -- Needs review
L["Select the 'Shopping' tab to open up the settings for TSM_Shopping."] = "選擇“購買”頁面來打開TSM_Shopping的設定。" -- Needs review
L[ [=[Select your new operation in the list of operation along the left of the TSM window (if it's not selected automatically) and click on the button below.

Currently Selected Operation: %s]=] ] = [=[在TSM窗口左邊的操作列表中選擇你的新操作（如果它沒有被自動選中）并點擊下面的按紐。

當前選擇的操作：%s]=] -- Needs review
L["Seller"] = "賣家" -- Needs review
L["Sell items on the AH and manage my auctions"] = "在拍賣行拍賣物品并管理我的拍賣" -- Needs review
L["Sell to Vendor"] = "賣給商人" -- Needs review
L["Set All Relationships to Target"] = "設定所有關聯至目標"
L["Set a Maximum Price"] = "設置一個最高價格" -- Needs review
L["Set Auction Price Settings"] = "設置拍賣價格選項" -- Needs review
L["Set Auction Settings"] = "設置拍賣選項" -- Needs review
L["Set Cancel Settings"] = "設置撤銷選項" -- Needs review
L["Set Max Restock Quantity"] = "設置最大補貨數量" -- Needs review
L["Set Minimum Profit"] = "設置最小利潤" -- Needs review
L["Set Other Options"] = "設置其他選項" -- Needs review
L["Set Posting Price Settings"] = "設置上架價格選項" -- Needs review
L["Set Quick Posting Duration"] = "設置快速上架持續時間" -- Needs review
L["Set Quick Posting Price"] = "設置快速上架價格" -- Needs review
L["Sets all relationship dropdowns below to the operation selected."] = "將所有下面下拉選單中的關聯設置到選定的操作。" -- Needs review
L["Settings"] = "設置"
L["Setup account sync'ing with the account which '%s' is on."] = "帳戶'％s'正在建立同步中"
L["Set up TSM to automatically cancel undercut auctions"] = "設置TSM來自動撤銷被壓價的拍賣品" -- Needs review
L["Set up TSM to automatically post auctions"] = "設置TSM來自動上架拍賣品" -- Needs review
L["Set up TSM to automatically queue things to craft"] = "設置TSM來自動添加物品至製造序列" -- Needs review
L["Setup TSM to automatically reset specific markets"] = "設置TSM來自動重新上架指定的物品" -- Needs review
L["Set up TSM to find cheap items on the AH"] = "設置TSM來在拍賣行尋找便宜的物品" -- Needs review
L["Shards"] = "碎片"
L["Shift-Click an item in the sidebar window to immediately post it at your quick posting price."] = "在窗口邊欄中Shift+點擊一個物品，將以你的快速拍賣價格立即上架該物品。" -- Needs review
L["Shift-Click Item in Your Bags"] = "在背包中Shift+點擊物品" -- Needs review
L["Show Bids in Auction Results Table (Requires Reload)"] = "在拍賣結果顯示競標價（需重載）" -- Needs review
L["Show the 'Custom Filter' Sidebar Tab"] = "顯示“自定義過濾器”邊欄標籤" -- Needs review
L["Show the 'Other' Sidebar Tab"] = "顯示“其他”邊欄標籤" -- Needs review
L["Show the Queue"] = "顯示序列" -- Needs review
L["Show the 'Quick Posting' Sidebar Tab"] = "顯示“快速上架”邊欄標籤" -- Needs review
L["Show the 'TSM Groups' Sidebar Tab"] = "顯示“TSM分組”邊欄標籤" -- Needs review
L["Show Ungrouped Items for Adding to Subgroups"] = "顯示未分組物品以添加到子分組"
L["%s is a valid custom price but did not give a value for %s."] = "%s 是一個有效的自定義價格但沒有為 %s 給出一個值。"
L["%s is a valid custom price but %s is an invalid item."] = "%s 是一個有效的自定義價格但 %s 是一個無效的物品。"
L["%s is not a valid custom price and gave the following error: %s"] = "%s 不是一個有效的自定義價格,錯誤資訊: %s"
L["Skipping auction which no longer exists."] = "跳過不存在的拍賣。"
L["Slash Commands:"] = "斜線命令列表："
L["%sLeft-Click|r to select / deselect this group."] = "%s 左鍵點擊|r 選擇/取消選中該分組。"
L["%sLeft-Click%s to open the main window"] = "%s點擊%s 開啟主視窗"
L["Small Text Size (Requires Reload)"] = "小型文字大小（需重載）" -- Needs review
L["Snipe items as they are being posted to the AH"] = "在已上架至拍賣行的拍賣中狙擊物品" -- Needs review
L["Sniping Scan in Progress"] = "狙擊中" -- Needs review
L["%s operation(s):"] = "%s 操作:"
L["Sources"] = "來源" -- Needs review
L["%sRight-Click|r to collapse / expand this group."] = "%s 右鍵點擊|r 回收/展開這個分組。"
L["Stack Size"] = "堆疊大小"
L["stacks of"] = "堆疊的"
L["Start a Destroy Search"] = "開始分解搜索" -- Needs review
L["Start Sniper"] = "開始狙擊" -- Needs review
L["Start Vendor Search"] = "開始商人搜索" -- Needs review
L["Status / Credits"] = "狀態 / 鳴謝" -- Needs review
L["Store Operations Globally"] = "全局保存操作"
L["Subgroup Items:"] = "子分組物品：" -- Needs review
L["Subgroups contain a subset of the items in their parent groups and can be used to further refine how different items are treated by TSM's modules."] = "子分組內的物品是其上級分組物品的一部分,可以由TSM模組更一步細化處理。"
L["Successfully imported %d items to %s."] = "成功導入%s物品至%s。" -- Needs review
L["Successfully imported operation settings."] = "成功導入操作設定" -- Needs review
L["Switch to Destroy Mode"] = "切換至分解模式" -- Needs review
L["Switch to New Custom Price Source After Creation"] = "創建完成后切換至新自定義價格源" -- Needs review
L["Switch to New Group After Creation"] = "創建後切換至新分組" -- Needs review
L["Switch to the 'Professions' Tab"] = "切換至\"專業\"標籤" -- Needs review
L["Switch to the 'TSM Groups' Tab"] = "切換至\"TSM分組\"標籤" -- Needs review
L["Target Operation"] = "目標操作"
L["Testers (Special Thanks):"] = "測試人員（特別感謝）："
L["Text:"] = "文字式樣：" -- Needs review
L["The default tab shown in the 'BankUI' frame."] = "銀行介面默認顯示的標籤頁"
L["The final set of posting settings are under the 'Posting Price Settings' header. These define the price ranges which Auctioning will post your items within. Read the tooltips of the individual settings to see what they do and set them appropriately."] = "最后的上架設定位于“拍賣價格設定”標題的下方。這些設定定義了你將上架的物品的價格範圍。閱讀它們的滑鼠提示來了解它們是做什麽的并適當的設定這些選項。" -- Needs review
L["The first set of posting settings are under the 'Auction Settings' header. These control things like stack size and auction duration. Read the tooltips of the individual settings to see what they do and set them appropriately."] = "上架選項首先需要設定的內容位于“拍賣設定”標題的下方。這些設定包括了像堆疊大小和持續時間等。閱讀它們的滑鼠提示來了解它們是做什麽的并適當的設定這些選項。" -- Needs review
L["The Functional Gold Maker (by Xsinthis - The Golden Crusade)"] = "The Functional Gold Maker (by Xsinthis - The Golden Crusade)" -- Needs review
L[ [=[The 'Maxium Auction Price (per item)' is the most you want to pay for the items you've added to your group. If you're not sure what to set this to and have TSM_AuctionDB installed (and it contains data from recent scans), you could try '90% dbmarket' for this option.

Once you're done adjusting this setting, click the button below.]=] ] = [=[“最高拍賣價格（每物品）”是指你愿意為被你添加至分組中的物品所支付的最大金額。如果你不確定如何設定該選項或者你已安裝TSM_AuctionDB（并含有最近的掃描數據），你可以試試將此選項設定為“90% dbmarket”。

一旦你完成了設定，點擊下面的按紐。]=] -- Needs review
L[ [=[The 'Max Restock Quantity' defines how many of each item you want to restock up to when using the restock queue, taking your inventory into account.

Once you're done adjusting this setting, click the button below.]=] ] = [=[“最大補貨數量”定義了當你進行補貨操作時每物品的補貨后持有量，包括你賬號內所有庫存。

一旦你完成了設定，點擊下面的按紐。]=] -- Needs review
L["Theme Name"] = "主題名稱"
L["Theme name is empty."] = "主題名為空。" -- Needs review
L["The name can ONLY contain letters. No spaces, numbers, or special characters."] = "名稱只能包括字母！不能有空格、數字或特殊字符。" -- Needs review
L["There are no visible banks."] = "当前未打开银行。" -- Needs review
L["There is only one price level and seller for this item."] = "目前該物品只有一個價格和賣家。" -- Needs review
L["The second set of posting settings are under the 'Auction Price Settings' header. These include the percentage of the buyout which the bid will be set to, and how much you want to undercut by. Read the tooltips of the individual settings to see what they do and set them appropriately."] = "上架設定的第二項內容位于“拍賣價格設定”標題的下方。這些設定包括了競標價占直購價的百分比以及你壓價的金額等。請閱讀它們的滑鼠提示了解它們是做什麽的并適當的設定這些選項。" -- Needs review
L["These settings control when TSM_Auctioning will cancel your auctions. Read the tooltips of the individual settings to see what they do and set them appropriately."] = "這些設定控制TSM_Auctioning（拍賣助手）如何撤銷你的拍賣品。請閱讀它們的滑鼠提示了解它們是做什麽的并適當的設定這些選項。" -- Needs review
L[ [=[The 'Sniper' feature will constantly search the last page of the AH which shows items as they are being posted. This does not search existing auctions, but lets you buy items which are posted cheaply right as they are posted and buy them before anybody else can.

You can adjust the settings for what auctions are shown in TSM_Shopping's options.

Click the button below when you're done reading this.]=] ] = [=[狙擊手功能將不斷掃描拍賣行的最后一頁那些剛剛被上架的物品而不是掃描現有的拍賣。它可以讓你買到比現有拍賣更便宜的物品，但你購買之前任何人都能購買這些物品。

你可以調整TSM_Shopping的選項來設定哪些拍賣品將顯示在這里。

若你讀完了這項指南，請點擊下面的按紐。]=] -- Needs review
L["This allows you to export your appearance settings to share with others."] = "這讓你匯出你的外觀設定來分享給其他人。"
L["This allows you to import appearance settings which other people have exported."] = "允許你匯入其他人匯出得外觀。"
L["This dropdown determines the default tab when you visit a group."] = "该下拉选单决定当你查看分组时默认显示的标签。" -- Needs review
L["This group already has operations. Would you like to add another one or replace the last one?"] = "該分組已經擁有操作，您希望新增一個操作還是取代之前的操作?"
L["This group already has the max number of operation. Would you like to replace the last one?"] = "該分組已經擁有最大數量的操作了，您希望取代之前的操作嗎?"
L["This operation will be ignored when you're on any character which is checked in this dropdown."] = "當你登陸在此下拉選單中選中的角色時，此操作將被忽略。" -- Needs review
L["This option sets which tab TSM and its modules will use for printing chat messages."] = "該選項設定了TSM核心和模組將使用哪個聊天窗口輸出資訊。" -- Needs review
L["Time Left"] = "離開時間"
L["Title"] = "標題"
L["Toggles the bankui"] = "切換銀行介面" -- Needs review
L["Tooltip Options"] = "滑鼠提示選項"
L["Tracks and manages your inventory across multiple characters including your bags, bank, and guild bank."] = "追蹤與管理你的背包，存取多個角色，包括你的背包，銀行，公會銀行。"
L["TradeSkillMaster Error Window"] = "TradeSkillMaster錯誤視窗"
L["TradeSkillMaster Info:"] = "TradeSkillMaster 資訊："
L["TradeSkillMaster Team"] = "TradeSkillMaster團隊"
L["TSM Appearance Options"] = "TSM外觀設定"
L["TSM Assistant"] = "TSM助手向導" -- Needs review
L["TSM Classic (by Jim Younkin - Power Word: Gold)"] = "TSM Classic (by Jim Younkin - Power Word: Gold)"
L["TSMDeck (by Jim Younkin - Power Word: Gold)"] = "TSMDeck (by Jim Younkin - Power Word: Gold)"
L["/tsm help|r - Shows this help listing"] = "/tsm help|r - 顯示幫助列表"
L["TSM Info / Help"] = "TSM資訊/幫助"
L["/tsm|r - opens the main TSM window."] = "/tsm|r - 開啟TSM主視窗。"
L["TSM Status / Options"] = "TSM 狀態/選項"
L["TSM Version Info:"] = "TSM版本資訊:"
L["TUJ GE - Market Average"] = "TUJ GE - 市場平均價"
L["TUJ GE - Market Median"] = "TUJ GE - 市場中位價"
L["TUJ RE - Market Price"] = "TUJ RE - 市場價"
L["TUJ RE - Mean"] = "TUJ RE - 平均值"
L["Type a raw material you would like to obtain via destroying in the search bar and start the search. For example: 'Ink of Dreams' or 'Spirit Dust'."] = "在搜索框中輸入一個你想要通過分解（包括研磨和勘探）獲得的原材料并開始搜索。例如：“夢境墨水”或“靈魂之塵”。" -- Needs review
L["Type in the name of a new operation you wish to create with the same settings as this operation."] = "輸入您希望按此操作設定創建的新操作名稱。" -- Needs review
L["Type '/tsm' or click on the minimap icon to open the main TSM window."] = "輸入“/tsm”或點擊小地圖圖標打開TSM主視窗。" -- Needs review
L["Type '/tsm sources' to print out all available price sources."] = "輸入“/tsm sources”顯示所有可用價格源。" -- Needs review
L["Unbalanced parentheses."] = "缺少括弧。" -- Needs review
L["Underneath the 'Posting Options' header, there are two settings which control the Quick Posting feature of TSM_Shopping. The first one is the duration which Quick Posting should use when posting your items to the AH. Change this to your preferred duration for Quick Posting."] = "在“上架選項”標題的下方，這里有兩個設定可以控制TSM_Shopping的快速上架功能。第一個是快速上架功能在上架您的物品時設定的持續時間。將此項調整為您更偏好的持續時間。" -- Needs review
L["Underneath the 'Posting Options' header, there are two settings which control the Quick Posting feature of TSM_Shopping. The second one is the price at which the Quick Posting will post items to the AH. This should generally not be a fixed gold value, since it will apply to every item. Change this setting to what you'd like to post items at with Quick Posting."] = "在“上架選項”標題的下方，這里有兩個設定可以控制TSM_Shopping的快速上架功能。第二項設定是快速上架功能在上架您的物品時設定的價格。該設定一般不是一個固定的金幣數額，因為該設定會應用于每一個物品。您可按您的意願調整此選項。" -- Needs review
L["Underneath the serach bar at the top of the 'Shopping' AH tab are a handful of buttons which change what's displayed in the sidebar window. Click on the 'Custom Filter' one."] = "在“購買”拍賣標籤的頂部，搜索框的下方，有幾個按紐可以改變邊欄的顯示內容。點擊“自定義過濾器“按紐。" -- Needs review
L["Underneath the serach bar at the top of the 'Shopping' AH tab are a handful of buttons which change what's displayed in the sidebar window. Click on the 'Other' one."] = "在“購買”拍賣標籤的頂部，搜索框的下方，有幾個按紐可以改變邊欄的顯示內容。點擊“其他“按紐。" -- Needs review
L["Underneath the serach bar at the top of the 'Shopping' AH tab are a handful of buttons which change what's displayed in the sidebar window. Click on the 'TSM Groups' one."] = "在“購買”拍賣標籤的頂部，搜索框的下方，有幾個按紐可以改變邊欄的顯示內容。點擊“TSM分組“按紐。" -- Needs review
L["Under the search bar, on the left, you can switch between normal and destroy mode for TSM_Shopping. Switch to 'Destroy Mode' now."] = "在搜索框下方左側，你可以在一般模式和分解模式之間進行切換。現在請切換至分解模式。" -- Needs review
L["Ungrouped Items:"] = "未分組物品：" -- Needs review
L["Usage: /tsm price <ItemLink> <Price String>"] = "用法：/tsm price <ItemLink(物品鏈接)> <Price String(價格)>" -- Needs review
L["Use an existing group"] = "使用一個已存在的分組" -- Needs review
L["Use a subset of items from an existing group by creating a subgroup"] = "通過創建子分組可以使用一個已存在分組的子集" -- Needs review
L["Use the button below to delete this group. Any subgroups of this group will also be deleted, with all items being returned to the parent of this group or removed completely if this group has no parent."] = "使用下面的按鈕刪除該分組。其子組也將被刪除，所有物品清單將添加到其上級分組，如果沒有上級分組，這些物品清單將被移除。" -- Needs review
L["Use the editbox below to give this group a new name."] = "通過編輯框給該組一個新名字" -- Needs review
L["Use the group box below to move this group and all subgroups of this group. Moving a group will cause all items in the group (and its subgroups) to be removed from its current parent group and added to the new parent group."] = "使用下面的分組框來移動該組（包括其子分組）。移動組將使該組（包括其子分組）的物品列表從舊的上級組移動到新的上級組上。" -- Needs review
L["Use the options below to change and tweak the appearance of TSM."] = "使用以下設定改變並調整TSM的外觀。"
L["Use the tabs above to select the module for which you'd like to configure operations and general options."] = "使用上面的標籤選擇你想配置操作和一般選項的模組" -- Needs review
L["Use the tabs above to select the module for which you'd like to configure tooltip options."] = "選擇上面的標籤來配置滑鼠提示上的各模組資訊。"
L["Using our website you can get help with TSM, suggest features, and give feedback."] = "訪問我們的網站可以獲得TSM的幫助，也可提供您的建議功能，或提供反饋。" -- Needs review
L["Various modules can sync their data between multiple accounts automatically whenever you're logged into both accounts."] = "當你登入多個賬號時，各模組的數據會在多賬號間自動同步。" -- Needs review
L["Vendor Buy Price:"] = "商人購買價格：" -- Needs review
L["Vendor Buy Price x%s:"] = "商人購買價格 x%s：" -- Needs review
L["Vendor Sell Price:"] = "賣給商人價格：" -- Needs review
L["Vendor Sell Price x%s:"] = "商人出售價格 x%s：" -- Needs review
L["Version:"] = "版本："
L["View current auctions and choose what price to post at"] = "查看當前拍賣并選擇上架價格" -- Needs review
L["View Operation Options"] = "查看操作設定" -- Needs review
L["Visit %s for information about the different TradeSkillMaster modules as well as download links."] = "訪問%s查看TradeSkillMaster不同模組的資訊以及下載鏈接。" -- Needs review
L["Waiting for Scan to Finish"] = "等待掃描完成" -- Needs review
L["Web Master and Addon Developer:"] = "網站管理人及插件開發者："
L["We will add a %s operation to this group through its 'Operations' tab. Click on that tab now."] = "我們現在將通過該分組的“操作”標籤添加一個%s操作至該分組。現在點擊“操作”標籤。" -- Needs review
L["We will add items to this group through its 'Items' tab. Click on that tab now."] = "我們現在將通過該分組的“物品”標籤添加物品至該分組。現在點擊“物品”標籤。" -- Needs review
L["We will import items into this group using the import list you have."] = "我們現在將通過你已有的物品列表導入物品至該分組。" -- Needs review
L["What do you want to do?"] = "你打算做些什麽？" -- Needs review
L[ [=[When checked, random enchants will be ignored for ungrouped items.

NB: This will not affect parent group items that were already added with random enchants

If you have this checked when adding an ungrouped randomly enchanted item, it will act as all possible random enchants of that item.]=] ] = [=[若勾選，未分組的隨機附魔物品將被忽略。
提示：這不會影響已添加至父級分組的隨機附魔物品。
如果你在添加一個未分組的隨機附魔物品之前已經勾選了該選項，它將代表所有該物品的隨機附魔物品。

（譯者舉例：如果添加“雄鷹之阿曼尼外套”之前勾選此項，將只顯示“阿曼尼外套”，它代表所有該物品可能的附魔比如“靈猴之阿曼尼外套、野熊之阿曼尼外套等等，該選項在管理隨機附魔物品時非常有用。）]=] -- Needs review
L["When clicked, makes this group a top-level group with no parent."] = "當點擊時，使該分組變成最高級組，不再從屬其他分組。" -- Needs review
L["Would you like to add this new operation to %s?"] = "您想將該新操作分配至%s嗎？" -- Needs review
L["Wrong number of item links."] = "錯誤的物品鏈接ID。" -- Needs review
L["You appear to be attempting to import an operation from a different module."] = "你似乎在嘗試從一個不同的模組中導入操作。" -- Needs review
L["You can change the active database profile, so you can have different settings for every character."] = "您可以改變資料庫配置檔,所以您可以為每一個角色做不同設置。"
L[ [=[You can craft items either by clicking on rows in the queue which are green (meaning you can craft all) or blue (meaning you can craft some) or by clicking on the 'Craft Next' button at the bottom.

Click on the button below when you're done reading this. There is another guide which tells you how to buy mats required for your queue.]=] ] = [=[你可以通過點擊序列中的一行來進行製造，綠色代表該項所有都可製造，藍色代表該項你只能製造一部份，或者直接點擊底部的“製造下一個”按紐。

當你閱讀完該資訊時點擊以下的按紐。將有另一個助手向導告訴你如何購買序列中所需要的原材料。]=] -- Needs review
L["You can either create a new profile by entering a name in the editbox, or choose one of the already exisiting profiles."] = "您可以在編輯框內輸入新名字來創建一個新的配置檔,或者選擇一個已有的配置檔。"
L["You can hold shift while clicking this button to remove the items from ALL groups rather than keeping them in the parent group (if one exists)."] = "你可以按住Shift點擊這個按紐來從所有分組中移除該物品而不是讓它們留在父級分組（如果存在）中。" -- Needs review
L[ [=[You can look through the tooltips of the other options to see what they do and decide if you want to change their values for this operation.

Once you're done, click on the button below.]=] ] = [=[你可以看看其他選項的滑鼠提示來了解它們的作用并決定如何改變它們的值。

當你完成時，點擊下面的按紐。]=] -- Needs review
L["You cannot create a profile with an empty name."] = "您不能創建一個沒有名字的配置檔。"
L["You cannot use %s as part of this custom price."] = "你不能使用%s作為自定義價格的一部份。" -- Needs review
L[ [=[You can now use the buttons near the bottom of the TSM_Crafting window to create this craft.

Once you're done, click the button below.]=] ] = "你現在可以使用TSM_Crafting窗口底部的按紐來創建這項製造。" -- Needs review
L[ [=[You can use the filters at the top of the page to narrow down your search and click on a column to sort by that column. Then, left-click on a row to add one of that item to the queue, and right-click to remove one.

Once you're done adding items to the queue, click the button below.]=] ] = [=[你可以通過頂部的過濾條件縮小查找範圍或點擊一列使其根據那一列排序。然后，在某一行點擊添加製造項，右鍵移除。

當你向序列中添加完物品，點擊下面的按紐。]=] -- Needs review
L[ [=[You can use this sidebar window to help build AH searches. You can also type the filter directly in the search bar at the top of the AH window.

Enter your filter and start the search.]=] ] = [=[你可以使用這個側邊欄窗口幫你建立拍賣搜索。你也可以直接在拍賣行介面的頂部搜索框中輸入過濾條件。

輸入你的過濾條件并開始搜索。]=] -- Needs review
L["You currently don't have any groups setup. Type '/tsm' and click on the 'TradeSkillMaster Groups' button to setup TSM groups."] = "您目前還沒有任何分組設置。輸入'/tsm' 點擊“TSM分組(groups)”標籤來設置TSM分組。"
L["You have closed the bankui. Use '/tsm bankui' to view again."] = "您已經關閉了銀行介面。輸入'/tsm bankui'再次查看。"
L["You have successfully completed this guide. If you require further assistance, visit out our website:"] = "你已成功完成此向導。如果你需要更多幫助，請訪問我們的網站：" -- Needs review
