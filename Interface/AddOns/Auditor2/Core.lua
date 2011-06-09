-- Auditor by Alarisha
-- Distribution restricted to Curse.com and WoWInterface.com

Auditor = DongleStub("Dongle-1.2"):New("Auditor")

--[[ LOCALE ]]--

local L = AUDITOR2_LOCALS

--[[ DECLARE LOCALS ]]--

local addon = Auditor
local pairs = pairs
local strgsub = string.gsub
local wipe = wipe
local auditorCurrentMoney, auditorLastMoney = nil, nil
local auditorMode = ""
local subHolder
local auditorHDay = { "6days", "5days", "4days", "3days", "2days", "1days", "0days" }
local auditorLogMode = { "loot", "merch", "quest", "trade", "mail", "ah", "train", "taxi", "repairs", "other", "reconciliation", "guildbank", "reforge", "guildcontrib", "lfg" }
local auditorTimeframe = { "session", "day", "week", "total" }

local COPPER_ABBR, SILVER_ABBR, GOLD_ABBR
local GOLD, SILVER, COPPER = GOLD, SILVER, COPPER

if not COPPER and COPPER_AMOUNT then
	GOLD = GOLD_AMOUNT:gsub("%s*%%d%s*", "")
	SILVER = SILVER_AMOUNT:gsub("%s*%%d%s*", "")
	COPPER = COPPER_AMOUNT:gsub("%s*%%d%s*", "")
end

if (COPPER:byte(1) or 128) > 127 then
	COPPER_ABBR = COPPER
	SILVER_ABBR = SILVER
	GOLD_ABBR = GOLD
else
	COPPER_ABBR = COPPER:sub(1, 1):lower()
	SILVER_ABBR = SILVER:sub(1, 1):lower()
	GOLD_ABBR = GOLD:sub(1, 1):lower()
end

local COLOR_WHITE, COLOR_GREEN, COLOR_RED = "ffffff", "00ff00", "ff0000"
local COLOR_COPPER, COLOR_SILVER, COLOR_GOLD = "eda55f", "c7c7cf", "ffd700"
local inf = 1/0
local auditorCN_cash, auditorCN_oldCash, auditorCN_gain, auditorCN_spend = 0, 0, 0, 0
local auditorCN_open, auditorCN_mode = false, nil

--[[ DB DEFAULTS ]]--

local defaults = {
	profile = {
		autoRepair = false,
		guildRepair = false,
	},
	realm = {
		sellGreys = false,
		notifyVendor = true,
		notifyMailbox = true,
		notifyAH = true,
		notifyGuildbank = true,
		notifyTrainer = true,
		notifyReforge = true,
		timeOffset = 0,
		useOffset = false
	},
}

function addon:Initialize()
	addon.db = addon:InitializeDB("Auditor2DB", defaults)
	auditorPlayer = UnitName("player")
	auditorSessionTime = time()
	auditorFocus = auditorPlayer
	if not addon.db.realm[auditorPlayer] then addon:NewCharDB() end -- Create DB for char if it doesn't exist
	addon:UpgradeCategories() -- Add any new categories
end

--[[ LOCAL MAIN FUNCTIONS ]]--

local function CashNotify()
	auditorCN_open = false
	if auditorCN_gain > 0 then
		addon:Print(L.Gained..addon:MoneyStyle(auditorCN_gain, true)..auditorCN_mode)
	end
	if auditorCN_spend > 0 then
		subHolder = strgsub((addon:MoneyStyle((auditorCN_spend * -1), true)), "-", "")
		addon:Print(L.Spent..subHolder..auditorCN_mode)
	end
	local diff = auditorCN_gain - auditorCN_spend
	if diff ~= 0 and auditorCN_gain > 0 and auditorCN_spend > 0 then
		subHolder = strgsub((addon:MoneyStyle((auditorCN_gain - auditorCN_spend), true)), "-", "")
		addon:Print(L.Change..subHolder..auditorCN_mode)
	end
	-- Spank variables
	auditorCN_gain = 0
	auditorCN_spend = 0
end

local function AutoRepairPlease()
	local repairCost = GetRepairAllCost()
	local currentMoney = GetMoney()
	if repairCost > 0 then
		if addon.db.profile.guildRepair and IsInGuild() then
			local guildMoney = GetGuildBankWithdrawMoney()
			if guildMoney == -1 then
				guildMoney = GetGuildBankMoney()
			end
			if guildMoney > repairCost then
				RepairAllItems(1)
				addon.db.realm[auditorPlayer].guildRepairsTally = addon.db.realm[auditorPlayer].guildRepairsTally + repairCost
				subHolder = strgsub((addon:MoneyStyle((repairCost * -1), true)), "-", "")
				addon:Print(L.GuildRepairSuccessful..subHolder)
				addon:Print(L.GuildTally..addon:MoneyStyle(addon.db.realm[auditorPlayer].guildRepairsTally))
				return
			else
				addon:Print(L.GuildRepairFailed)
			end
		end
		if (currentMoney > repairCost) then
			auditorMode = "repairs"
			RepairAllItems()
		else
			addon:Print(L.InsufficientFunds)
		end
	end
end

local function SellGreys()
	auditorMode = "merch"
	for bag=0,4 do
		for slot=0,GetContainerNumSlots(bag) do
			local link = GetContainerItemLink(bag, slot)
			if link and select(3, GetItemInfo(link)) == 0 then
				ShowMerchantSellCursor(1)
				UseContainerItem(bag, slot)
			end
		end
	end
end

local function ReconcileData() -- Reconcile data if Auditor and reality don't sync
	auditorCurrentMoney = GetMoney() -- Set current cash
	auditorLastMoney = auditorCurrentMoney
	auditorCN_cash = auditorCurrentMoney
	local data = addon.db.realm[auditorPlayer].data
	local historical = addon.db.realm[auditorPlayer].historical
	addon.db.realm.chars[auditorPlayer] = auditorCurrentMoney
	data.totals.incomings, data.totals.outgoings = 0, 0
	for _, logmode in pairs(auditorLogMode) do -- Add up total incomings and outgoings according to Auditor
		if logmode ~= "guildcontrib" then
			data.totals.incomings = data.totals.incomings + data[logmode]["total"].incomings
			data.totals.outgoings = data.totals.outgoings + data[logmode]["total"].outgoings
		end
	end
	data.totals.actual = data.totals.incomings - data.totals.outgoings
	if data.totals.actual ~= auditorCurrentMoney then -- Does Auditor's data sync with reality? If not, make it so
		local diff = auditorCurrentMoney - data.totals.actual
		if diff > 0 then
			for _,logmode in pairs(auditorTimeframe) do
				if logmode ~= "guildcontrib" then
					data["reconciliation"][logmode].incomings = data["reconciliation"][logmode].incomings + diff
				end
			end
			historical[auditorHDay[7]]["reconciliation"].incomings = data["reconciliation"]["day"].incomings
			data.totals.incomings = data.totals.incomings + diff
		elseif diff < 0 then
			diff = diff * -1;
			for _,logmode in pairs(auditorTimeframe) do
				if logmode ~= "guildcontrib" then
					data["reconciliation"][logmode].outgoings = data["reconciliation"][logmode].outgoings + diff
				end
			end
			historical[auditorHDay[7]]["reconciliation"].outgoings = data["reconciliation"]["day"].outgoings
			data.totals.outgoings = data.totals.outgoings + diff
		end
		data.totals.actual = auditorCurrentMoney
		addon:Print(L.Reconciled..auditorPlayer)
	end
end

local function UpdateTimeFrame() -- Check if Auditor should reset
	local dateTable = date("*t")
	local timeDiff = time{year = dateTable.year, day = dateTable.day, month = dateTable.month, hour = dateTable.hour, min = dateTable.min, sec = dateTable.sec} - addon.db.realm[auditorPlayer].timeDate.timeDate
	local daysPassedSinceLogin = math.floor(timeDiff / 86400)
	addon.db.realm[auditorPlayer].timeDate.niceDate = date("%d %b '%y") -- Keep date current
	if daysPassedSinceLogin ~= 0 then -- If we haven't logged in for a week, then we need to clear the historical days data and the week data
		if daysPassedSinceLogin > 6 then
			addon.db.realm[auditorPlayer].historical = nil
			addon:NewCharDB()
			addon:DataReset("day")
			addon:DataReset("week")
		else -- Begin the Truffle Shuffle!
			addon:DataReset("week")
			while daysPassedSinceLogin > 0 do
				for i = 1, 6 do
					for _,logmode in pairs(auditorLogMode) do
						addon.db.realm[auditorPlayer].historical[auditorHDay[i]][logmode].incomings = addon.db.realm[auditorPlayer].historical[auditorHDay[i+1]][logmode].incomings
						addon.db.realm[auditorPlayer].historical[auditorHDay[i]][logmode].outgoings = addon.db.realm[auditorPlayer].historical[auditorHDay[i+1]][logmode].outgoings
					end
				end
				for _,logmode in pairs(auditorLogMode) do
					addon.db.realm[auditorPlayer].historical[auditorHDay[7]][logmode] = {incomings = 0, outgoings = 0}
				end
				daysPassedSinceLogin = daysPassedSinceLogin - 1
			end
			for _,hday in pairs(auditorHDay) do
				for _,logmode in pairs(auditorLogMode) do
					addon.db.realm[auditorPlayer].data[logmode]["week"].incomings = addon.db.realm[auditorPlayer].data[logmode]["week"].incomings + addon.db.realm[auditorPlayer].historical[hday][logmode].incomings
					addon.db.realm[auditorPlayer].data[logmode]["week"].outgoings = addon.db.realm[auditorPlayer].data[logmode]["week"].outgoings + addon.db.realm[auditorPlayer].historical[hday][logmode].outgoings
				end
			end
		end
		addon:DataReset("day") -- Lastly, if the date has changed, obviously we need to clear out the day's data.
		addon.db.realm[auditorPlayer].timeDate.timeDate = time{year = dateTable.year, day = dateTable.day, month = dateTable.month, hour = 0} + (addon.db.realm.timeOffset * 3600) -- Time offset crap. Amfg, I hate this stuff. It's retarded.
	end
end

local function UpdateFigures() -- Main money data allocation function
	auditorCurrentMoney = GetMoney()
	addon.db.realm[auditorPlayer].data.totals.actual = auditorCurrentMoney
	addon.db.realm.chars[auditorPlayer] = auditorCurrentMoney
	local diff = auditorCurrentMoney - auditorLastMoney
	auditorLastMoney = auditorCurrentMoney
	if (diff == 0 or diff == nil) then
		return
	end
	local data = addon.db.realm[auditorPlayer].data
	local historical = addon.db.realm[auditorPlayer].historical
	if auditorMode == "" then -- Deals with random cash from an obfuscated source
		auditorMode = "other"
	end
	if diff > 0 then
		if (auditorMode == "taxi" or auditorMode == "train" or auditorMode == "repairs") then -- Prevention of incomings to categories that can't have incomings
			auditorMode = "other"
		end
		for _,logmode in pairs(auditorTimeframe) do
			data[auditorMode][logmode].incomings = data[auditorMode][logmode].incomings + diff
		end
		data.totals.incomings = data.totals.incomings + diff
		historical[auditorHDay[7]][auditorMode].incomings = data[auditorMode]["day"].incomings
	elseif diff < 0 then
		if (auditorMode == "loot") then -- Prevention of outgoings to categories that can't have outgoings
			auditorMode = "other"
		end
		diff = diff * -1
		for _,logmode in pairs(auditorTimeframe) do
			data[auditorMode][logmode].outgoings = data[auditorMode][logmode].outgoings + diff
		end
		data.totals.outgoings = data.totals.outgoings + diff
		historical[auditorHDay[7]][auditorMode].outgoings = data[auditorMode]["day"].outgoings
	end
	if auditorMode == "repairs" then -- Reset in case we just repaired and are still at a merchant
		if addon.db.profile.autoRepair == true then
			subHolder = strgsub((addon:MoneyStyle((diff * -1), true)), "-", "")
			addon:Print(L.RepairSuccessful..subHolder)
		end
		auditorMode = "merch"
	end
end

local function CashNotifyUpdate()
	auditorCN_oldCash, auditorCN_cash = auditorCN_cash, GetMoney()
	local diff = auditorCN_cash - auditorCN_oldCash
	if auditorCN_open == true then
		if diff > 0 then
			auditorCN_gain = auditorCN_gain + diff
		elseif diff < 0 then
			auditorCN_spend = auditorCN_spend - diff
		end
	end
end

local function ShareMoneyScan(msg) 
	local GOLD_SCAN_AMOUNT = strgsub(GOLD_AMOUNT, "%%d", "(%%d+)")
	local SILVER_SCAN_AMOUNT = strgsub(SILVER_AMOUNT, "%%d", "(%%d+)")
	local COPPER_SCAN_AMOUNT = strgsub(COPPER_AMOUNT, "%%d", "(%%d+)")
	local copper = string.match(msg, COPPER_SCAN_AMOUNT)
	local silver = string.match(msg, SILVER_SCAN_AMOUNT)
	local gold = string.match(msg, GOLD_SCAN_AMOUNT)
	local money = (gold or 0) * 10000 + (silver or 0) * 100 + (copper or 0)
	
	local guildLevel = GetGuildLevel()
	local guildMultiplier -- Guild contributions
	if guildLevel > 15 then
		guildMultiplier = 0.1
	elseif guildLevel > 4 then
		guildMultiplier = 0.05
	else
		guildMultiplier = 0
	end
	local guildContrib = math.floor((money*guildMultiplier)+0.5)
		
	if guildContrib > 0 then
		local auditorMode = "guildcontrib"
		local data = addon.db.realm[auditorPlayer].data
		local historical = addon.db.realm[auditorPlayer].historical
		
		for _,logmode in pairs(auditorTimeframe) do
				data[auditorMode][logmode].incomings = data[auditorMode][logmode].incomings + guildContrib
		end
		
		historical[auditorHDay[7]][auditorMode].incomings = data[auditorMode]["day"].incomings
	end
	
	local oldMode = auditorMode 
	if not auditorLastMoney then auditorLastMoney = 0 end
	auditorLastMoney = auditorLastMoney - money -- Force a money update with calculated amount
	auditorMode = "loot"
	UpdateFigures()
	auditorMode = oldMode
	auditorLastMoney = auditorLastMoney + money -- Stop cash allocation troubles
end

--[[ LOCAL EVENT FUNCTIONS ]]--

local f = CreateFrame("Frame")
f:RegisterEvent("MERCHANT_SHOW")
f:RegisterEvent("MERCHANT_CLOSED")
f:RegisterEvent("BANKFRAME_OPENED")
f:RegisterEvent("BANKFRAME_CLOSED")
f:RegisterEvent("GUILDBANKFRAME_OPENED")
f:RegisterEvent("GUILDBANKFRAME_CLOSED")
f:RegisterEvent("QUEST_COMPLETE")
f:RegisterEvent("LOOT_OPENED")
f:RegisterEvent("TAXIMAP_OPENED")
f:RegisterEvent("TRADE_SHOW")
f:RegisterEvent("TRADE_CLOSE")
f:RegisterEvent("MAIL_SHOW")
f:RegisterEvent("MAIL_CLOSED")
f:RegisterEvent("TRAINER_SHOW")
f:RegisterEvent("TRAINER_CLOSED")
f:RegisterEvent("AUCTION_HOUSE_SHOW")
f:RegisterEvent("AUCTION_HOUSE_CLOSED")
f:RegisterEvent("CHAT_MSG_MONEY")
f:RegisterEvent("PLAYER_MONEY")
f:RegisterEvent("CONFIRM_TALENT_WIPE")
f:RegisterEvent("FORGE_MASTER_OPENED")
f:RegisterEvent("FORGE_MASTER_CLOSED")
f:RegisterEvent("LFG_COMPLETION_REWARD")
f:SetScript("OnEvent", function(self, event, arg1, arg2)
	if event == "PLAYER_MONEY" then
		UpdateTimeFrame()
		UpdateFigures()
		CashNotifyUpdate()
		if (AuditorBroker) then AuditorBroker:UpdateBrokerText() end
	elseif event == "CHAT_MSG_MONEY" then
		ShareMoneyScan(arg1)
	elseif event == "LOOT_OPENED" then
		auditorMode = "loot"
	elseif event == "MERCHANT_SHOW" then
		if CanMerchantRepair() and addon.db.profile.autoRepair == true then
			AutoRepairPlease()
		end
		if auditorMode ~= "repairs" then
			auditorMode = "merch"
		end
		if addon.db.realm.notifyVendor == true then
			auditorCN_open = true
			auditorCN_gain = 0
			auditorCN_spend = 0
			auditorCN_mode = L.Vendor
		end
		if addon.db.realm.sellGreys == true then
			addon:ScheduleTimer("AUDITOR_SELLGREYS_DELAY", SellGreys, 2)
		end
	elseif event == "MERCHANT_CLOSED" or event == "FORGE_MASTER_CLOSED" or event == "GUILDBANKFRAME_CLOSED" or event == "MAIL_CLOSED" or event == "TRAINER_CLOSED" or event == "AUCTION_HOUSE_CLOSED" then
		auditorMode = ""
		CashNotify()
	elseif event == "QUEST_COMPLETE" then
		auditorMode = "quest"
	elseif event == "TAXIMAP_OPENED" then
		auditorMode = "taxi"
	elseif event == "TRADE_SHOW" then
		auditorMode = "trade"
	elseif event == "BANKFRAME_OPENED" then
		auditorMode = "merch"
	elseif event == "FORGE_MASTER_OPENED" then
		auditorMode = "reforge"
		if addon.db.realm.notifyReforge == true then
			auditorCN_open = true
			auditorCN_gain = 0
			auditorCN_spend = 0
			auditorCN_mode = L.Reforge
		end
	elseif event == "TRADE_CLOSE" or event == "BANKFRAME_CLOSED" then
		auditorMode = ""
	elseif event == "MAIL_SHOW" then
		auditorMode = "mail"
		if addon.db.realm.notifyMailbox == true then
			auditorCN_open = true
			auditorCN_gain = 0
			auditorCN_spend = 0
			auditorCN_mode = L.Mailbox
		end
	elseif event == "TRAINER_SHOW" then
		auditorMode = "train"
		if addon.db.realm.notifyTrainer == true then
			auditorCN_open = true
			auditorCN_gain = 0
			auditorCN_spend = 0
			auditorCN_mode = L.Trainer
		end
	elseif event == "AUCTION_HOUSE_SHOW" then
		auditorMode = "ah"
		if addon.db.realm.notifyAH == true then
			auditorCN_open = true
			auditorCN_gain = 0
			auditorCN_spend = 0
			auditorCN_mode = L.AH
		end
	elseif event == "GUILDBANKFRAME_OPENED" then
		auditorMode = "guildbank"
		if addon.db.realm.notifyGuildbank == true then
			auditorCN_open = true
			auditorCN_gain = 0
			auditorCN_spend = 0
			auditorCN_mode = L.Guildbank
		end
	elseif event == "CONFIRM_TALENT_WIPE" then
		auditorMode = "train"
	elseif event == "LFG_COMPLETION_REWARD" then
		auditorMode = "lfg"
	else
	end
end)

--[[ STARTUP ]]--

function addon:Enable()
	hooksecurefunc("RepairAllItems", function() addon:RepairAllItems() end)
	hooksecurefunc("CursorHasItem", function() addon:CursorHasItem() end)
	hooksecurefunc("TakeInboxMoney", function(...) addon:TakeInboxMoney(...) end)
	UpdateTimeFrame() -- Data housekeeping
	addon:DataReset("session") -- Clear out last session's data
	ReconcileData()
	if (AuditorBroker) then AuditorBroker:UpdateBrokerText() end
end

--[[ DB MANIPULATION ]]--

function addon:DataReset(timeFrame, char)
	local charToReset = ""
	if char ~= nil then
		charToReset = char
	else
		charToReset = auditorPlayer
	end
	for _,logmode in pairs(auditorLogMode) do
			addon.db.realm[charToReset].data[logmode][timeFrame] = {incomings = 0, outgoings = 0}
	end
	if timeFrame == "session" then -- Reset time for gold per hour
		auditorSessionTime = time()
	end
end

function addon:PurgeData(name)
	auditorFocus = auditorPlayer
	addon.db.realm[name] = nil
	addon.db.realm.chars[name] = nil
	if auditorPlayer == name then
		addon:NewCharDB() -- Create DB for Char
		ReconcileData() -- Reconcile DB with reality
	end
	ReloadUI()
end

function addon:NewCharDB(arg)
	if arg == nil then arg = auditorPlayer end
	if not addon.db.realm[arg] then -- Normal
		addon.db.realm[arg] = { data = { totals = {incomings = 0, outgoings = 0, actual = 0}}, timeDate = {niceDate = date("%d %b '%y"), timeDate = (math.floor((time() + (addon.db.realm.timeOffset * 3600)) / 86400)) * 86400}}
		for _,logmode in pairs(auditorLogMode) do
			addon.db.realm[arg].data[logmode] = {}
			for _,timeframe in pairs(auditorTimeframe) do
				addon.db.realm[arg].data[logmode][timeframe] = {incomings = 0, outgoings = 0}
			end
		end
	end	
	if not addon.db.realm[arg].historical then -- Historical
		addon.db.realm[arg].historical = {}
		for _,hday in pairs(auditorHDay) do
			addon.db.realm[arg].historical[hday] = {}
			for _,logmode in pairs(auditorLogMode) do
				addon.db.realm[arg].historical[hday][logmode] = {incomings = 0, outgoings = 0}
			end
		end
	end
	if not addon.db.realm.chars then -- Character totals
		addon.db.realm.chars = {}
	end
	if not addon.db.realm.chars[arg] then
		addon.db.realm.chars[arg] = 0
	end
	if not addon.db.realm[arg].guildRepairsTally then -- Guild repairs tally
		addon.db.realm[arg].guildRepairsTally = 0
	end
end

function addon:UpgradeCategories()
	for charParse,_ in pairs (addon.db.realm.chars) do
		for _,logmode in pairs(auditorLogMode) do -- If I've added a new category
			if not addon.db.realm[charParse].data[logmode] then
				addon.db.realm[charParse].data[logmode] = {}
				for _,timeframe in pairs(auditorTimeframe) do
					addon.db.realm[charParse].data[logmode][timeframe] = {incomings = 0, outgoings = 0}
				end
			end
		end
		
		if not addon.db.realm[charParse].historical then -- Historical
			addon.db.realm[charParse].historical = {}
			for _,hday in pairs(auditorHDay) do
				addon.db.realm[charParse].historical[hday] = {}
				for _,logmode in pairs(auditorLogMode) do
					addon.db.realm[charParse].historical[hday][logmode] = {incomings = 0, outgoings = 0}
				end
			end
		else
			for _,hday in pairs(auditorHDay) do
				for _,logmode in pairs(auditorLogMode) do
					if not addon.db.realm[charParse].historical[hday][logmode] then
						addon.db.realm[charParse].historical[hday][logmode] = {incomings = 0, outgoings = 0}
					end
				end
			end
		end
	end
end

--[[ HOOK FUNCTIONS ]]--

function addon:RepairAllItems()
	auditorMode = "repairs"
end

function addon:CursorHasItem()
	if InRepairMode() then
		auditorMode = "repairs"
	end
end

function addon:TakeInboxMoney(mailIndex)
	local _, _, sender, _, _, _, _, _, _, _, _, _= GetInboxHeaderInfo(mailIndex)
	if sender ~= nil then
		if strfind(sender, L.AuctionHouse) then
			auditorMode = "ah"
		else
			auditorMode = "mail"
		end
	else
		auditorMode = "mail"
	end
end

--[[ UTILITY FUNCTIONS ]]--

function addon:PrintResetTime()
	addon:Print(date("Auditor will reset at %H:%M (24hr clock), on %A, %d %b '%y (local time).", addon.db.realm[auditorPlayer].timeDate.timeDate + 86400))
end

local function FormatMoneyFull(value, colored)
	local gold = abs(value / 10000)
	local silver = abs(mod(value / 100, 100))
	local copper = abs(mod(value, 100))
	local negl = ""
	local color = COLOR_WHITE
	if value > 0 then
		if colored then
			color = COLOR_GREEN
		end
	elseif value < 0 then
		negl = "-"
		if colored then
			color = COLOR_RED
		end
	end
	if value == inf or value == -inf then
		return format("|cff%s%s|r", color, value)
	elseif value ~= value then
		return format("|cff%s0|r|cff%s%s|r", COLOR_WHITE, COLOR_COPPER, COPPER_ABBR)
	elseif value >= 10000 or value <= -10000 then
		return format("|cff%s%s%d|r|cff%s%s|r |cff%s%d|r|cff%s%s|r |cff%s%d|r|cff%s%s|r", color, negl, gold, COLOR_GOLD, GOLD_ABBR, color, silver, COLOR_SILVER, SILVER_ABBR, color, copper, COLOR_COPPER, COPPER_ABBR)
	elseif value >= 100 or value <= -100 then
		return format("|cff%s%s%d|r|cff%s%s|r |cff%s%d|r|cff%s%s|r", color, negl, silver, COLOR_SILVER, SILVER_ABBR, color, copper, COLOR_COPPER, COPPER_ABBR)
	else
		return format("|cff%s%s%d|r|cff%s%s|r", color, negl, copper, COLOR_COPPER, COPPER_ABBR)
	end
	
end

local function FormatMoneyShort(value, colored)
	local color = COLOR_WHITE
	if colored then
		if value > 0 then
			color = COLOR_GREEN
		elseif value < 0 then
			color = COLOR_RED
		end
	end
	if value == inf or value == -inf then
		return format("|cff%s%s|r", color, value)
	elseif value ~= value then
		return format("|cff%s0|r|cff%s%s|r", COLOR_WHITE, COLOR_COPPER, COPPER_ABBR)
	elseif value >= 10000 or value <= -10000 then
		return format("|cff%s%.1f|r|cff%s%s|r", color, value / 10000, COLOR_GOLD, GOLD_ABBR)
	elseif value >= 100 or value <= -100 then
		return format("|cff%s%.1f|r|cff%s%s|r", color, value / 100, COLOR_SILVER, SILVER_ABBR)
	else
		return format("|cff%s%d|r|cff%s%s|r", color, value, COLOR_COPPER, COPPER_ABBR)
	end
end

local function FormatMoneyCondensed(value, colored)
	local negl = ""
	local negr = ""
	if value < 0 then
		if colored then
			negl = "|cffff0000-(|r"
			negr = "|cffff0000)|r"
		else
			negl = "-("
			negr = ")"
		end
	end
	local gold = floor(math.abs(value) / 10000)
	local silver = mod(floor(math.abs(value) / 100), 100)
	local copper = mod(floor(math.abs(value)), 100)
	if value == inf or value == -inf then
		return format("%s|cff%s%s|r%s", negl, COLOR_COPPER, math.abs(value), negr)
	elseif value ~= value then
		return format("|cff%s0|r", COLOR_COPPER)
	elseif gold ~= 0 then
		return format("%s|cff%s%d|r.|cff%s%02d|r.|cff%s%02d|r%s", negl, COLOR_GOLD, gold, COLOR_SILVER, silver, COLOR_COPPER, copper, negr)
	elseif silver ~= 0 then
		return format("%s|cff%s%d|r.|cff%s%02d|r%s", negl, COLOR_SILVER, silver, COLOR_COPPER, copper, negr)
	else
		return format("%s|cff%s%d|r%s", negl, COLOR_COPPER, copper, negr)
	end
	
end

function addon:MoneyStyle(value, colored, bar)
	local cashFormat = AuditorBroker.db.profile.cashFormat
	if bar == true then
		if cashFormat.Bar == "Full" then
			return FormatMoneyFull(value, colored)
		elseif cashFormat.Bar == "Short" then
			return FormatMoneyShort(value, colored)
		else
			return FormatMoneyCondensed(value, colored)
		end
	else
		if cashFormat.toolTip == "Full" then
			return FormatMoneyFull(value, colored)
		elseif cashFormat.toolTip == "Short" then
			return FormatMoneyShort(value, colored)
		else
			return FormatMoneyCondensed(value, colored)
		end
	end
end
