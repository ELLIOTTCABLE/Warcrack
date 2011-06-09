-- Auditor by Alarisha
-- Distribution restricted to Curse.com and WoWInterface.com

AuditorBroker = LibStub("AceAddon-3.0"):NewAddon("Broker_Auditor")

--[[ DECLARE LIBS ]]--

local addon = AuditorBroker
local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
local QTC = LibStub('LibQTip-1.0')
local icon =  LibStub("LibDBIcon-1.0")

--[[ LOCALE ]]--

local L = BROKER_AUDITOR_LOCALS

--[[ LOCALS ]]--

local pairs = pairs
local strgsub = string.gsub
local wipe = wipe

local cashStyles = {
	["Full"] = L.FullStyle,
	["Short"] = L.ShortStyle,
	["Condensed"] = L.CondStyle,
}

local barCashStyles = {
	["Full"] = L.FullStyle,
	["Short"] = L.ShortStyle,
	["Condensed"] = L.CondStyle,
	["Graphical"] = L.GraphStyle,
}

local auditorHDay = { "6days", "5days", "4days", "3days", "2days", "1days", "0days" }
local auditorLogMode = { "loot", "merch", "quest", "trade", "mail", "ah", "train", "taxi", "repairs", "other", "reconciliation", "guildbank", "reforge", "guildcontrib", "lfg" }
local auditorTimeframe = { "session", "day", "week", "total" }
local cashIn, cashOut, names = {}, {}, {}
local allTotal, netIn, netOut, netTotal, charCount, subHolder, sessionHours, realmWealth, sessionProfit, text, total
local charToPurge = "NoOne"
local style, absurdStyle, cycleDir
local absurdIndex = 1
local gC = "|cff00FF00" -- Green
local yC = "|cffFFCC00" -- Golden
local eC = "|r" -- End
local tooltip
local DO

do
	for name in pairs(Auditor.db.realm.chars) do
		names[name] = name
	end
end

--[[ DB DEFAULTS ]]--

local defaults = {
	profile = {
		hideCharTotals = false,
		hideDetails = false,
		hideSummary = false,
		hideHourly = false,
		hideTotalInBar = false,
		hideNetTotal = true,
		hideCharacterInBar = false,
		showCombined = false,
		absurdDetail = false,
		cashFormat = { Bar = "Full", toolTip = "Full" },
		compactMode = true
	},
	global = {
		tipScale = 1,
		styleIndex = 1,
		LibDBIcon = { hide = false }
	}
}

--[[ POPUPS ]]--

StaticPopupDialogs["AUDBROKER_DATA_PURGE"] = {
	text = "",
	button1 = L.Popup_Yes,
	button2 = L.Popup_No,
	OnAccept = function() Auditor:PurgeData(charToPurge) end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
}

--[[ LOCAL FUNCTIONS]]--

local function IsFiltered(name)
	return Auditor.db.realm[name].hidden
end

local function ToggleFiltered(name)
	Auditor.db.realm[name].hidden = not Auditor.db.realm[name].hidden
end

local function CycleTimeframe(button)
	if addon.db.profile.showCombined == true then
		if button == "LeftButton" then cycleDir = 2 else cycleDir = -2 end
		addon.db.global.styleIndex = addon.db.global.styleIndex + cycleDir
		if addon.db.global.styleIndex > #auditorTimeframe then
			addon.db.global.styleIndex = 2
		elseif addon.db.global.styleIndex < 1 then
			addon.db.global.styleIndex = #auditorTimeframe
		end
	else
		if button == "LeftButton" then cycleDir = 1 else cycleDir = -1 end
		addon.db.global.styleIndex = addon.db.global.styleIndex + cycleDir
		if addon.db.global.styleIndex > #auditorTimeframe then
			addon.db.global.styleIndex = 1
		elseif addon.db.global.styleIndex < 1 then
			addon.db.global.styleIndex = #auditorTimeframe
		end
	end
end

local function CycleAbsurd(button)
	if button == "LeftButton" then cycleDir = 1 else cycleDir = -1 end
	absurdIndex = absurdIndex + cycleDir
	if absurdIndex > #auditorLogMode then
		absurdIndex = 1
	elseif absurdIndex < 1 then
		absurdIndex = #auditorLogMode
	end
end

--[[ OPTIONS ]]--

local options = {
	handler = addon,
	type = 'group',
	desc = L.Description,
	args = {
		basicDesc = {
			order = 1,
			type = 'description',
			name = "Cash auditing fun! Now with added Broker.",
		},
		characterToShow = {
			order = 2,
			type = 'select',
			name = L.CharShow,
			desc = L.CharShowDesc,
			get = function() return auditorFocus end,
			set = function(_, v) auditorFocus = v end,
			values = names,
		},
		timeframeDisplay = {
			order = 3,
			type = 'select',
			name = L.Timeframe,
			desc = L.TimeframeDesc,
			get = function() return addon.db.profile.style end,
			set = function(_, v) addon.db.profile.style = v end,
			values = function()
					if addon.db.profile.showCombined == true then
						u = {["day"] = L.day, ["total"] = L.total}
					else
						u = {["session"] = L.session, ["day"] = L.day, ["week"] = L.week, ["total"] = L.total}
					end
					return u
				end,
		},
		showCombinedTotals = {
			order = 4,
			type = 'toggle',
			name = L.ShowCombinedTotals,
			desc = L.ShowCombinedTotalsDesc,
			get = function() return addon.db.profile.showCombined end,
			set = function() addon.db.profile.showCombined = not addon.db.profile.showCombined end,
		},
		absurdDetail = {
			order = 5,
			type = 'toggle',
			name = L.Absurd,
			desc = L.AbsurdDesc,
			get = function() return addon.db.profile.absurdDetail end,
			set = function() addon.db.profile.absurdDetail = not addon.db.profile.absurdDetail end,
			disabled = function()
						if addon.db.profile.showCombined == true then
							addon.db.profile.absurdDetail = false
							return true
						else
							return false
						end
					end,
		},
		showMinimapIcon = {
			order = 6,
			type = 'toggle',
			name = "Minimap Icon",
			desc = "Toggle Minimap icon.",
			get = function() return not addon.db.global.LibDBIcon.hide end,
			set = function(_, v)
				addon.db.global.LibDBIcon.hide = not v
				if v then
					icon:Show("Broker_Auditor")
				else
					icon:Hide("Broker_Auditor")
				end
			end,
		},
		cashNotify = {
			order = 1,
			type = 'group',
			name = L.CashNotify,
			args = {
				cashNotifyDesc = {
					order = 1,
					type = 'description',
					name = L.CashNotifyDesc,
				},
				notifyAH = {
					type = 'toggle',
					name = L.AH,
					desc = L.AHDesc,
					get = function() return Auditor.db.realm.notifyAH end,
					set = function() Auditor.db.realm.notifyAH = not Auditor.db.realm.notifyAH end,
				},
				notifyMailbox = {
					type = 'toggle',
					name = L.Mailbox,
					desc = L.MailboxDesc,
					get = function() return Auditor.db.realm.notifyMailbox end,
					set = function() Auditor.db.realm.notifyMailbox = not Auditor.db.realm.notifyMailbox end,
				},
				notifyVendor = {
					type = 'toggle',
					name = L.Vendor,
					desc = L.VendorDesc,
					get = function() return Auditor.db.realm.notifyVendor end,
					set = function() Auditor.db.realm.notifyVendor = not Auditor.db.realm.notifyVendor end,
				},
				notifyTrainer = {
					type = 'toggle',
					name = L.Trainer,
					desc = L.TrainerDesc,
					get = function() return Auditor.db.realm.notifyTrainer end,
					set = function() Auditor.db.realm.notifyTrainer = not Auditor.db.realm.notifyTrainer end,
				},
				notifyGuildbank = {
					type = 'toggle',
					name = L.Guildbank,
					desc = L.GuildbankDesc,
					get = function() return Auditor.db.realm.notifyGuildbank end,
					set = function() Auditor.db.realm.notifyGuildbank = not Auditor.db.realm.notifyGuildbank end,
				},
			}
		},
		merchOptions = {
			order = 2,
			type = 'group',
			name = L.MerchOptions,
			args = {
				merchOptionsDesc = {
					order = 1,
					type = 'description',
					name = L.MerchOptionsDesc,
				},
				autoRepair = {
					type = 'toggle',
					name = L.AutoRepair,
					desc = L.AutoRepairDesc,
					get = function() return Auditor.db.profile.autoRepair end,
					set = function() Auditor.db.profile.autoRepair = not Auditor.db.profile.autoRepair end,
				},
				guildRepair = {
					type = 'toggle',
					name = L.GuildRepair,
					desc = L.GuildRepairDesc,
					get = function() return Auditor.db.profile.guildRepair end,
					set = function() Auditor.db.profile.guildRepair = not Auditor.db.profile.guildRepair end,
				},
				autoSell = {
					type = 'toggle',
					name = L.AutoSell,
					desc = L.AutoSellDesc,
					get = function() return Auditor.db.realm.sellGreys end,
					set = function() Auditor.db.realm.sellGreys = not Auditor.db.realm.sellGreys end,
				},
			}
		},
		moneyFormat = {
			order = 3,
			type = 'group',
			name = L.MoneyFormat,
			args = {
				moneyFormatDesc = {
					order = 1,
					type = 'description',
					name = L.MoneyFormatDesc,
				},
				barFormat = {
					order = 2,
					type = 'select',
					name = L.BrokerDisplay,
					desc = L.BrokerDisplayDesc,
					get = function() return addon.db.profile.cashFormat.Bar end,
					set = function(_, v) addon.db.profile.cashFormat.Bar = v; addon:UpdateBrokerText() end,
					values = barCashStyles,
				},
				tooltipFormat = {
					order = 3,
					type = 'select',
					name = L.TooltipDisplay,
					desc = L.TooltipDisplayDesc,
					get = function() return addon.db.profile.cashFormat.toolTip end,
					set = function(_, v) addon.db.profile.cashFormat.toolTip = v; addon:UpdateBrokerText() end,
					values = cashStyles,
				},
				showTotalInBar = {
					type = 'toggle',
					name = L.ShowTotalInBar,
					desc = L.ShowTotalInBarDesc,
					get = function() return not addon.db.profile.hideTotalInBar end,
					set = function() addon.db.profile.hideTotalInBar = not addon.db.profile.hideTotalInBar; addon:UpdateBrokerText() end,
				},
				showCharacterInBar = {
					type = 'toggle',
					name = L.ShowCharacterInBar,
					desc = L.ShowCharacterInBarDesc,
					get = function() return not addon.db.profile.hideCharacterInBar end,
					set = function() addon.db.profile.hideCharacterInBar = not addon.db.profile.hideCharacterInBar; addon:UpdateBrokerText() end,
				},
				showNetInBar = {
					type = 'toggle',
					name = L.ShowNetInBar,
					desc = L.ShowNetInBarDesc,
					get = function() return not addon.db.profile.hideNetTotal end,
					set = function() addon.db.profile.hideNetTotal = not addon.db.profile.hideNetTotal; addon:UpdateBrokerText() end,
				},
			}
		},
		timeOptions = {
			order = 4,
			type = 'group',
			name = L.TimeOffset,
			args = {
				timeOptionsDesc = {
					order = 1,
					type = 'description',
					name = L.TimeOffsetDesc,
				},
				enableOffset = {
					type = 'toggle',
					name = L.EnableOffset,
					desc = L.EnableOffsetDesc,
					get = function() return Auditor.db.realm.useOffset end,
					set = function() Auditor.db.realm.useOffset = not Auditor.db.realm.useOffset end,
				},
				timeOffset = {
					type = 'range',
					name = L.TimeOffset,
					desc = L.TimeOffsetDesc,
					get = function() return Auditor.db.realm.timeOffset end,
					set = function(_, timeOffset)
								Auditor.db.realm.timeOffset = timeOffset
								local dateTable = date("*t")
								for name in pairs(Auditor.db.realm.chars) do
									Auditor.db.realm[name].historical = nil
									Auditor:DataReset("session", name)
									Auditor:DataReset("day", name)
									Auditor:DataReset("week", name)
									Auditor.db.realm[name].timeDate.timeDate = time{year = dateTable.year, day = dateTable.day, month = dateTable.month, hour = 0} + (Auditor.db.realm.timeOffset * 3600)
									Auditor:NewCharDB(name)
								end
							end,
					min = -16,
					max = 16,
					step = 1,
					disabled = function()
								if Auditor.db.realm.useOffset == false then
									return true
								else
									return false
								end
							end,
				},
				printResetTime = {
					order = 3,
					type = 'execute',
					name = L.PrintResetTime,
					desc = L.PrintResetTimeDesc,
					func = function() Auditor:PrintResetTime() end,
				},
			}
		},
		tipDisplay = {
			order = 5,
			type = 'group',
			name = L.TipDisplay,
			args = {
				tipDisplayDesc = {
					order = 1,
					type = 'description',
					name = L.TipDisplayDesc,
				},
				compactMode = {
					type = 'toggle',
					name = L.CompactMode,
					desc = L.CompactModeDesc,
					get = function() return addon.db.profile.compactMode end,
					set = function() addon.db.profile.compactMode = not addon.db.profile.compactMode end,
				},
				showDetails = {
					type = 'toggle',
					name = L.ShowDetails,
					desc = L.ShowDetailsDesc,
					get = function() return not addon.db.profile.hideDetails end,
					set = function() addon.db.profile.hideDetails = not addon.db.profile.hideDetails end,
				},
				showHourly = {
					type = 'toggle',
					name = L.ShowHourly,
					desc = L.ShowHourlyDesc,
					get = function() return not addon.db.profile.hideHourly end,
					set = function() addon.db.profile.hideHourly = not addon.db.profile.hideHourly end,
				},
				showSummary = {
					type = 'toggle',
					name = L.ShowSummary,
					desc = L.ShowSummaryDesc,
					get = function() return not addon.db.profile.hideSummary end,
					set = function() addon.db.profile.hideSummary = not addon.db.profile.hideSummary end,
				},
				showTotals = {
					type = 'toggle',
					name = L.ShowTotals,
					desc = L.ShowTotalsDesc,
					get = function() return not addon.db.profile.hideCharTotals end,
					set = function() addon.db.profile.hideCharTotals = not addon.db.profile.hideCharTotals end,
				},
				tipScale = {
					order = 2,
					type = "range",
					name = L.TipScale,
					desc = L.TipScaleDesc,
					min = 0.5, max = 1.5, step = 0.01,
					get = function() return addon.db.global.tipScale end,
					set = function(_, scale) addon.db.global.tipScale = scale end,
				},
			},
		},
		resetSession = {
			order = 9,
			type = 'execute',
			name = L.RSession,
			desc = L.RSessionDesc,
			func = function() Auditor:DataReset("session");	addon:OpenMenu() end,
		},
		dataManipulationHeader = {
			order = 7,
			type = 'header',
			name = "Data Manipulation",
		},
		optionsHeader = {
			order = 10,
			type = 'header',
			name = "Other Options",
		},
		purge = {
			order = 8,
			type = 'select',
			name = L.Purge,
			desc = L.PurgeDesc,
			set = function(_, name) charToPurge = name; StaticPopupDialogs["AUDBROKER_DATA_PURGE"].text = L.Popup_Purge..name..L.Popup_Purge2..name.."."; StaticPopup_Show("AUDBROKER_DATA_PURGE") end,
			values = names,
		},
		filterGroup = {
			order = 2,
			type = 'group',
			name = L.Filter,
			args = {
				filterDisplayDesc = {
					order = 1,
					type = 'description',
					name = L.FilterDesc,
				},
				filters = {
					type = 'multiselect',
					name = "",
					get  = function(_, name) return IsFiltered(name) end,
					set  = function(_, name) ToggleFiltered(name); addon:UpdateBrokerText() end,
					values = names,
				},
			},
		}
	}
}

--[[ HANDLERS ]]--

local function HandlerFunc(_, name, button)
	if name == "timeframe" then
		CycleTimeframe(button)
	elseif name == "absurdSource" then
		CycleAbsurd(button)
	elseif name == "cashflow" then
		addon.db.profile.hideDetails = not addon.db.profile.hideDetails
	elseif name == "summary" then
		addon.db.profile.hideSummary = not addon.db.profile.hideSummary
	elseif name == "characters" then
		addon.db.profile.hideCharTotals = not addon.db.profile.hideCharTotals
	elseif name == "total" then
		addon.db.profile.showCombined = not addon.db.profile.showCombined
		addon.db.profile.absurdDetail = false
	elseif auditorLogMode[name] and addon.db.profile.absurdDetail == false then
		absurdIndex = name
		addon.db.profile.showCombined = false
		addon.db.profile.absurdDetail = true
	elseif auditorTimeframe[name] and addon.db.profile.absurdDetail == true then
		addon.db.global.styleIndex = name
		addon.db.profile.absurdDetail = false
	else
		if name == nil then
			name = auditorFocus
		end
		auditorFocus = name
		addon.db.profile.showCombined = false
	end
	addon:ShowTooltip()
end

--[[ STARTUP ]]--

function addon:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("BrokerAuditorDB", defaults)
	options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	LibStub("AceConfig-3.0"):RegisterOptionsTable("Auditor", options)
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Auditor", "Auditor")
	
	DO = ldb:NewDataObject("Broker_Auditor", {
		type = "data source",
		icon = "Interface\\Addons\\Broker_Auditor\\icon.blp",
		label = "Auditor",
		text = "Auditor",
		OnClick = function(frame, button)
				if button == "RightButton" then
					InterfaceOptionsFrame_OpenToCategory("Auditor")
				end
			end,
		OnEnter = function(frame)
				tooltip = QTC:Acquire("Broker_AuditorTooltip", 4, "LEFT", "LEFT", "CENTER","RIGHT")
				tooltip:SmartAnchorTo(frame)
				tooltip:SetAutoHideDelay(0.25, frame)
				addon:ShowTooltip()
			end,
		OnLeave = function()
				return
			end,
	})
	icon:Register("Broker_Auditor", DO, self.db.global.LibDBIcon) -- Minimap
end

function addon:OnEnable()
	addon:UpdateBrokerText()
end

function addon:UpdateBrokerText()
	local profile = addon.db.profile
	realmWealth, sessionProfit, text = 0, 0, nil
	if profile.cashFormat.Bar == "Graphical" then
		text = GetCoinTextureString(GetMoney())
	else
		if profile.hideCharacterInBar == false then
			text = Auditor:MoneyStyle(GetMoney(), false, true)
		end
		if profile.hideTotalInBar == false then
			for name,charWealth in pairs(Auditor.db.realm.chars) do
				if not IsFiltered(name) == true then
					realmWealth = realmWealth + charWealth
				end
			end
			if text then
				text = text.." /"..Auditor:MoneyStyle(realmWealth, false, true)
			else
				text = Auditor:MoneyStyle(realmWealth, false, true)
			end
		end
		if profile.hideNetTotal == false then
			for i = 1, #auditorLogMode do
				if auditorLogMode[i] ~= "guildcontrib" then
					sessionProfit = sessionProfit + Auditor.db.realm[auditorPlayer].data[auditorLogMode[i]].session.incomings - Auditor.db.realm[auditorPlayer].data[auditorLogMode[i]].session.outgoings
				end	
			end
			if sessionProfit > 0 then
				sessionProfit = Auditor:MoneyStyle(sessionProfit, true, true)
			elseif sessionProfit < 0 then
				sessionProfit = strgsub((Auditor:MoneyStyle(sessionProfit, true, true)), "-", "")
			else
				sessionProfit = " - "
			end
			if text then
				text = text.." ("..sessionProfit..")"
			else
				text = sessionProfit
			end
		end
	end
	DO.text = text
end

--[[ TOOLTIP FUNCTIONS ]]--

function addon:ShowTooltip()
	tooltip:Clear()
	tooltip:SetScale(addon.db.global.tipScale or 1)

	self:UpdateBrokerText()
	local headerFont = CreateFont("auditorHeaderFont")
	auditorHeaderFont:CopyFontObject(GameTooltipHeaderText)
	auditorHeaderFont:SetFont(auditorHeaderFont:GetFont(), 15)

	wipe(cashIn) -- Set variables
	wipe(cashOut)
	allTotal, netIn, netOut, netTotal, charCount, subHolder = 0, 0, 0, 0, 0, 0
	sessionHours = ((time() - auditorSessionTime) / 3600)
	style = auditorTimeframe[addon.db.global.styleIndex]
	absurdStyle = auditorLogMode[absurdIndex]
	
	if addon.db.profile.showCombined == true then -- Retrieve Cash Data
		if addon.db.global.styleIndex == 1 or addon.db.global.styleIndex == 3 then -- Force Day mode if it is not already in a compatible display mode
			addon.db.global.styleIndex = 2
			style = auditorTimeframe[addon.db.global.styleIndex]
		end
		if style == "day" then
			for name in pairs(Auditor.db.realm.chars) do
				if not IsFiltered(name) == true then
					if Auditor.db.realm[name].timeDate.niceDate == Auditor.db.realm[auditorPlayer].timeDate.niceDate then
						for i = 1, #auditorLogMode do
							if not cashIn[i] then cashIn[i], cashOut[i] = 0, 0 end
							cashIn[i] = cashIn[i] + Auditor.db.realm[name].data[auditorLogMode[i]][style].incomings
							cashOut[i] = cashOut[i] + Auditor.db.realm[name].data[auditorLogMode[i]][style].outgoings
							if auditorLogMode[i] ~= "guildcontrib" then
								netIn = netIn + Auditor.db.realm[name].data[auditorLogMode[i]][style].incomings
								netOut = netOut + Auditor.db.realm[name].data[auditorLogMode[i]][style].outgoings
								netTotal = netTotal + Auditor.db.realm[name].data[auditorLogMode[i]][style].incomings - Auditor.db.realm[name].data[auditorLogMode[i]][style].outgoings
							end	
						end
						charCount = charCount + 1
					end
				end
			end
		else
			for name in pairs(Auditor.db.realm.chars) do
				if not IsFiltered(name) == true then
					for i = 1, #auditorLogMode do
						if not cashIn[i] then cashIn[i], cashOut[i] = 0, 0 end
						cashIn[i] = cashIn[i] + Auditor.db.realm[name].data[auditorLogMode[i]][style].incomings
						cashOut[i] = cashOut[i] + Auditor.db.realm[name].data[auditorLogMode[i]][style].outgoings
						if auditorLogMode[i] ~= "guildcontrib" then
							netIn = netIn + Auditor.db.realm[name].data[auditorLogMode[i]][style].incomings
							netOut = netOut + Auditor.db.realm[name].data[auditorLogMode[i]][style].outgoings
							netTotal = netTotal + Auditor.db.realm[name].data[auditorLogMode[i]][style].incomings - Auditor.db.realm[name].data[auditorLogMode[i]][style].outgoings
						end
					end
					charCount = charCount + 1
				end
			end
		end
	else -- Single char
		for i = 1, #auditorLogMode do
			cashIn[i] = Auditor.db.realm[auditorFocus].data[auditorLogMode[i]][style].incomings
			cashOut[i] = Auditor.db.realm[auditorFocus].data[auditorLogMode[i]][style].outgoings
			if auditorLogMode[i] ~= "guildcontrib" then
				netIn = netIn + Auditor.db.realm[auditorFocus].data[auditorLogMode[i]][style].incomings
				netOut = netOut + Auditor.db.realm[auditorFocus].data[auditorLogMode[i]][style].outgoings
				netTotal = netTotal + Auditor.db.realm[auditorFocus].data[auditorLogMode[i]][style].incomings - Auditor.db.realm[auditorFocus].data[auditorLogMode[i]][style].outgoings
			end
		end
	end

	local y = tooltip:AddLine()
	tooltip:SetCell(y, 1, "Auditor", auditorHeaderFont, "CENTER", 4)
	
	if addon.db.profile.showCombined == true then -- Showing Combined
		local y = tooltip:AddLine()
		tooltip:SetCell(y, 1, "Combined :: "..charCount.." Characters", "CENTER", 4)
	elseif auditorFocus == auditorPlayer then -- Showing current char
		local y = tooltip:AddLine()
		tooltip:SetCell(y, 1, auditorFocus.." :: "..L.LoggedOn, "CENTER", 4)
	else -- Showing some other char
		local y = tooltip:AddLine()
		tooltip:SetCell(y, 1, auditorFocus.." :: "..Auditor.db.realm[auditorFocus].timeDate.niceDate, "CENTER", 4)
	end
	tooltip:AddLine(" ")

	--[[ NORMAL ]]--

	if self.db.profile.absurdDetail == false then
		--[[ TIMEFRAME ]]--
		local y = tooltip:AddLine()
		tooltip:SetCell(y, 1, "|TInterface\\Buttons\\UI-PlusButton-Up:18:18:1:0|t")
		tooltip:SetCellScript(y, 1, "OnMouseDown", HandlerFunc, "timeframe")
		tooltip:SetCell(y, 2, gC..L.Timeframe..eC, "LEFT")
		tooltip:SetCell(y, 3, yC..L[style]..eC, "RIGHT", 2)

		--[[ CASHFLOW ]]--
		tooltip:AddLine(" ")
		local y = tooltip:AddLine()
		tooltip:SetCell(y, 1, format("|TInterface\\Buttons\\UI-%sButton-Up:18:18:1:0|t", addon.db.profile.hideDetails and "Plus" or "Minus"))
		tooltip:SetCellScript(y, 1, "OnMouseDown", HandlerFunc, "cashflow")
		tooltip:SetCell(y, 2, gC..L.Cashflow..eC, "LEFT")

		if addon.db.profile.hideDetails == false then
			if netTotal ~= 0 then
				tooltip:AddLine("", L.Source, L.Incomings, L.Outgoings)
			else
				local y = tooltip:AddLine()
				tooltip:SetCell(y, 2, L.NoTrans, "LEFT", 2)
			end
			for i = 1, #auditorLogMode do -- Sources, incomings, outgoings
				if addon.db.profile.compactMode == true then -- Compact Mode
					if cashIn[i] ~= 0 or cashOut[i] ~= 0 then
						local y = tooltip:AddLine()
						tooltip:SetCell(y, 2, yC..L[auditorLogMode[i]]..":|r", 1)
						tooltip:SetCellScript(y, 2, "OnMouseDown", HandlerFunc, i)
						tooltip:SetCell(y, 3, Auditor:MoneyStyle(cashIn[i]), "CENTER")
						tooltip:SetCell(y, 4, Auditor:MoneyStyle(cashOut[i]), "RIGHT")
					end
				else
					local y = tooltip:AddLine()
					tooltip:SetCell(y, 2, yC..L[auditorLogMode[i]]..":|r", 1)
					tooltip:SetCellScript(y, 2, "OnMouseDown", HandlerFunc, i)
					tooltip:SetCell(y, 3, Auditor:MoneyStyle(cashIn[i]), "CENTER")
					tooltip:SetCell(y, 4, Auditor:MoneyStyle(cashOut[i]), "RIGHT")
				end
			end
		end

		--[[ SUMMARY ]]--
		tooltip:AddLine(" ")
		local y = tooltip:AddLine()
		tooltip:SetCell(y, 1, format("|TInterface\\Buttons\\UI-%sButton-Up:18:18:1:0|t", addon.db.profile.hideSummary and "Plus" or "Minus"))
		tooltip:SetCellScript(y, 1, "OnMouseDown", HandlerFunc, "summary")
		tooltip:SetCell(y, 2, gC..L.Summary..eC, "LEFT")

		if addon.db.profile.hideSummary == false then
			tooltip:AddLine("", yC..L.Incomings..":|r", "", Auditor:MoneyStyle(netIn, true))
			subHolder = strgsub((Auditor:MoneyStyle((netOut * -1), true)), "-", "")
			tooltip:AddLine("", yC..L.Outgoings..":|r", "", subHolder)

			if netTotal >= 0 then
				tooltip:AddLine("", yC..L.NetProfit..":|r", "", Auditor:MoneyStyle(netTotal, true))
				-- Gold per hour
				if (addon.db.profile.hideHourly == false) and (style == "session") and (auditorFocus == auditorPlayer) then
					tooltip:AddLine("", yC..L.GainPerHour..":|r", "", Auditor:MoneyStyle((netTotal/sessionHours), true))
				end
			else
				subHolder = strgsub((Auditor:MoneyStyle(netTotal, true)), "-", "")
				tooltip:AddLine("", yC..L.NetLoss..":|r", "", subHolder)
				-- Gold per hour
				if (addon.db.profile.hideHourly == false) and (style == "session") and (auditorFocus == auditorPlayer) then
					subHolder = strgsub((Auditor:MoneyStyle((netTotal/sessionHours), true)), "-", "")
					tooltip:AddLine("", yC..L.LossPerHour..":|r", "", subHolder)
				end
			end
		end

	--[[ ABSURD ]]--
	else
		local y = tooltip:AddLine()
		tooltip:SetCell(y, 1, "|TInterface\\Buttons\\UI-PlusButton-Up:18:18:1:0|t")
		tooltip:SetCellScript(y, 1, "OnMouseDown", HandlerFunc, "absurdSource")
		tooltip:SetCell(y, 2, gC..L.Source..eC, "LEFT")
		tooltip:SetCell(y, 3, yC..L[absurdStyle]..eC, "RIGHT", 2)
		tooltip:AddLine(" ")
		tooltip:AddLine("", gC..L.Absurd..eC)
		tooltip:AddLine("", L.Timeframe, L.Incomings, L.Outgoings)
		local y = tooltip:AddLine()
		tooltip:SetCell(y, 2, yC..L.Absd_Session..eC, 1)
		tooltip:SetCellScript(y, 2, "OnMouseDown", HandlerFunc, 1)
		tooltip:SetCell(y, 3, Auditor:MoneyStyle(Auditor.db.realm[auditorFocus].data[absurdStyle]["session"].incomings), "CENTER")
		tooltip:SetCell(y, 4, Auditor:MoneyStyle(Auditor.db.realm[auditorFocus].data[absurdStyle]["session"].outgoings), "RIGHT")
		local y = tooltip:AddLine()
		tooltip:SetCell(y, 2, yC..L.Absd_1..eC, 1)
		tooltip:SetCellScript(y, 2, "OnMouseDown", HandlerFunc, 2)
		tooltip:SetCell(y, 3, Auditor:MoneyStyle(Auditor.db.realm[auditorFocus].data[absurdStyle]["day"].incomings), "CENTER")
		tooltip:SetCell(y, 4, Auditor:MoneyStyle(Auditor.db.realm[auditorFocus].data[absurdStyle]["day"].outgoings), "RIGHT")
		for i = 2, #auditorHDay do
			tooltip:AddLine("", yC..L["Absd_"..i]..eC, Auditor:MoneyStyle(Auditor.db.realm[auditorFocus].historical[auditorHDay[(8-i)]][absurdStyle].incomings), Auditor:MoneyStyle(Auditor.db.realm[auditorFocus].historical[auditorHDay[(8-i)]][absurdStyle].outgoings))
		end
		local y = tooltip:AddLine()
		tooltip:SetCell(y, 2, yC..L.Absd_Week..eC, 1)
		tooltip:SetCellScript(y, 2, "OnMouseDown", HandlerFunc, 3)
		tooltip:SetCell(y, 3, Auditor:MoneyStyle(Auditor.db.realm[auditorFocus].data[absurdStyle]["week"].incomings), "CENTER")
		tooltip:SetCell(y, 4, Auditor:MoneyStyle(Auditor.db.realm[auditorFocus].data[absurdStyle]["week"].outgoings), "RIGHT")
		local y = tooltip:AddLine()
		tooltip:SetCell(y, 2, yC..L.Absd_Total..eC, 1)
		tooltip:SetCellScript(y, 2, "OnMouseDown", HandlerFunc, 4)
		tooltip:SetCell(y, 3, Auditor:MoneyStyle(Auditor.db.realm[auditorFocus].data[absurdStyle]["total"].incomings), "CENTER")
		tooltip:SetCell(y, 4, Auditor:MoneyStyle(Auditor.db.realm[auditorFocus].data[absurdStyle]["total"].outgoings), "RIGHT")
	end

	--[[ CHARACTER TOTALS ]]--
	tooltip:AddLine(" ")
	local y = tooltip:AddLine()
	tooltip:SetCell(y, 1, format("|TInterface\\Buttons\\UI-%sButton-Up:18:18:1:0|t", addon.db.profile.hideCharTotals and "Plus" or "Minus"))
	tooltip:SetCellScript(y, 1, "OnMouseDown", HandlerFunc, "characters")
	tooltip:SetCell(y, 2, gC..L.Characters..eC, "LEFT")
	if addon.db.profile.hideCharTotals == false then
		total = 0
		if next(Auditor.db.realm.chars) ~= UnitName("player") or next(Auditor.db.realm.chars, UnitName("player")) then
			local t = {}
			for name in pairs(Auditor.db.realm.chars) do
				table.insert(t, name)
			end
			if not self.sort_func then
				self.sort_func = function(alpha, bravo)
					return Auditor.db.realm.chars[alpha] < Auditor.db.realm.chars[bravo]
				end
			end
			table.sort(t, self.sort_func)
			for _,name in pairs(t) do
				if not IsFiltered(name) == true then
					local value = Auditor.db.realm.chars[name]
					if name == auditorFocus and not addon.db.profile.showCombined then
						local y = tooltip:AddLine()
						tooltip:SetCell(y, 1, "|TInterface\\Buttons\\UI-GroupLoot-Coin-Up:17:17:1:0|t", "LEFT")
						tooltip:SetCell(y, 2, yC..name..":|r")
						tooltip:SetCellScript(y, 2, "OnMouseDown", HandlerFunc, name)
						tooltip:SetCell(y, 3, Auditor.db.realm[name].timeDate.niceDate, "CENTER")
						tooltip:SetCell(y, 4, Auditor:MoneyStyle(value), "RIGHT")
					else
						local y = tooltip:AddLine()
						tooltip:SetCell(y, 2, yC..name..":|r")
						tooltip:SetCellScript(y, 2, "OnMouseDown", HandlerFunc, name)
						tooltip:SetCell(y, 3, Auditor.db.realm[name].timeDate.niceDate, "CENTER")
						tooltip:SetCell(y, 4, Auditor:MoneyStyle(value), "RIGHT")
					end
					total = total + value
				end
			end
		else
			total = GetMoney()
		end
		--[[ TOTAL ]]--
		if addon.db.profile.showCombined == true then
			local y = tooltip:AddLine()
			tooltip:SetCell(y, 1, "|TInterface\\Buttons\\UI-GroupLoot-Coin-Up:17:17:1:0|t", "LEFT")
			tooltip:SetCell(y, 2, yC..L.NetTotal..":|r")
			tooltip:SetCellScript(y, 2, "OnMouseDown", HandlerFunc, "total")
			tooltip:SetCell(y, 3, Auditor:MoneyStyle(total), "RIGHT", 2)
		else
			local y = tooltip:AddLine()
			tooltip:SetCell(y, 2, yC..L.NetTotal..":|r")
			tooltip:SetCellScript(y, 2, "OnMouseDown", HandlerFunc, "total")
			tooltip:SetCell(y, 3, Auditor:MoneyStyle(total), "RIGHT", 2)
		end
	end
	tooltip:Show()
end
