--[[
	Localization.lua
		Translations for Combuctor

	English: Default language
--]]

local L = LibStub("AceLocale-3.0"):NewLocale("Combuctor", "enUS", true)

L.Updated = 'Updated to v%s'

--binding actions
L.ToggleInventory = "Toggle Inventory"
L.ToggleBank = "Toggle Bank"

--frame titles
L.InventoryTitle = "%s's Inventory"
L.BankTitle = "%s's Bank"

--tooltips
L.Inventory = 'Inventory'
L.Bank = 'Bank'
L.TotalOnRealm = 'Total on %s'
L.ClickToPurchase = '<Click> to purchase'
L.Bags = 'Bags'
L.BagToggle = '<Left-Click> to toggle the bag display'
L.InventoryToggle = '<Right-Click> to toggle your inventory'
L.BankToggle = '<Right-Click> to toggle your bank'
L.MoveTip = '<Left-Drag> to move'
L.ResetPositionTip = '<Alt-Right-Click> to make the frame act as an interface panel'

--default sets (need to be here because of a flaw in how I save things
--these are automatically localized (aka, don't translate them :)
do
	L.All = ALL
	L.Weapon, L.Armor, L.Container, L.Consumable, L.Glyph, L.TradeGood, L.Recipe, L.Gem, L.Misc, L.Quest = GetAuctionItemClasses()
	L.Trinket = _G['INVTYPE_TRINKET']
	L.Devices, L.Explosives = select(10, GetAuctionItemSubClasses(6))
	L.SimpleGem = select(8, GetAuctionItemSubClasses(7))
end

L.Normal = 'Normal'
L.Equipment = 'Equipment'
L.Trade = 'Trade'
L.Ammo = 'Ammo'
L.Shards = 'Shards'
L.SoulShard = 'Soul Shard'
L.Usable = 'Usable'