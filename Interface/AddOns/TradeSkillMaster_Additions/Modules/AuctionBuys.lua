-- ------------------------------------------------------------------------------ --
--                           TradeSkillMaster_Additions                           --
--           http://www.curse.com/addons/wow/tradeskillmaster_additions           --
--                                                                                --
--             A TradeSkillMaster Addon (http://tradeskillmaster.com)             --
--    All Rights Reserved* - Detailed license information included with addon.    --
-- ------------------------------------------------------------------------------ --

-- load the parent file (TSM) into a local variable and register this file as a module
local TSM = select(2, ...)
local AuctionBuys = TSM:NewModule("AuctionBuys", "AceEvent-3.0", "AceHook-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("TradeSkillMaster_Additions") -- loads the localization table
local lastPurchase = nil

function AuctionBuys:OnEnable()
	AuctionBuys:Hook("PlaceAuctionBid", AuctionBuys.OnAuctionBidPlaced, true)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", AuctionBuys.FilterSystemMsg)
end

function AuctionBuys:OnDisable()
	-- do disable stuff
	AuctionBuys:UnhookAll()
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_SYSTEM", AuctionBuys.FilterSystemMsg)
end

function AuctionBuys.OnAuctionBidPlaced(_, index, amountPaid)
	local link = GetAuctionItemLink("list", index)
	local name, _, count, _, _, _, _, _, _, buyout = GetAuctionItemInfo("list", index)
	if amountPaid == buyout then
		lastPurchase = {name=name, link=link, count=count, buyout=buyout, buyout=buyout}
	end
end

local prevLineID, prevLineResult
function AuctionBuys.FilterSystemMsg(_, _, msg, ...)
	local lineID = select(10, ...)
	if lineID ~= prevLineID then
		prevLineID = lineID
		prevLineResult = nil
		if not lastPurchase or msg ~= format(ERR_AUCTION_WON_S, lastPurchase.name) then return end
		
		prevLineResult = format(L["You won an auction for %sx%d for %s"], lastPurchase.link, lastPurchase.count, TSMAPI:FormatTextMoney(lastPurchase.buyout, "|cffffffff"))
		return nil, prevLineResult, ...
	end
end