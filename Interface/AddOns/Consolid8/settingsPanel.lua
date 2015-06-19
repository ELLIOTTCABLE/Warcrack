--[[Consolid8, a World of Warcraft chat frame addon
	Copyright 2015 Harry Cutts

	This work by Harry Cutts is licensed under a
	Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
	To read this license, please see http://creativecommons.org/licenses/by-nc-sa/3.0/ .
]]--

local addOnName, L = ...	-- Name and locale table

Consolid8 = Consolid8 or {}
local settings
local panel, itemPopup

function Consolid8.ResetItemsTable()
	if not settings then settings = Consolid8_Settings end
	local loc = GetLocale()
	if loc == "enGB" or loc == "enUS" then	-- Use English-localised default table
		settings.countItems = {
			["Linen Cloth"]			= true,
			["Wool Cloth"]			= true,
			["Silk Cloth"]			= true,
			["Mageweave Cloth"]		= true,
			["Runecloth"]			= true,
			["Felcloth"]			= true,
			["Mooncloth"]			= true,
			["Netherweave Cloth"]	= true,
			["Frostweave Cloth"]	= true,
			["Embersilk Cloth"]		= true,
			["Mark of Kil'jaeden"]	= true,
			["Relic of Ulduar"]		= true,
			["Vrykul Bones"]		= true
		}
		return true

	else	-- Generate localised default table from item IDs
		local defaultIDs = {
			2589,	-- Linen Cloth
			2592,	-- Wool Cloth
			4306,	-- Silk Cloth
			4338,	-- Mageweave Cloth
			14047,	-- Runecloth
			14256,	-- Felcloth
			14342,	-- Mooncloth
			21877,	-- Netherweave Cloth
			33470,	-- Frostweave Cloth
			53010,	-- Embersilk Cloth
			29425,	-- Mark of Kil'jaeden
			42780,	-- Relic of Ulduar
			43089,	-- Vrykul Bones
		}
		local countItems = { }
		local queries = 0	-- The number of GetItemInfo queries still to be returned

		-- Create a frame to be called when the asynchronous querys are completed
		local callbackFrame = CreateFrame("Frame")
		callbackFrame:RegisterEvent("GET_ITEM_INFO_RECEIVED")
		callbackFrame:SetScript("OnEvent", function(self)
			queries = queries - 1
			if queries == 0 then	-- if all the queries have been returned, loop through the IDs again
				for i = 1, #defaultIDs do
					local name = GetItemInfo(defaultIDs[i])
					if name then
						countItems[name] = true
					end
				end
				-- Self-destruct
				self:UnregisterEvent("GET_ITEM_INFO_RECEIVED")
				self:SetScript("OnEvent", nil)
				callbackFrame = nil
			end
		end)

		-- Loop through item IDs, retrieving names for those available and requesting the others
		for i = 1, #defaultIDs do
			local name = GetItemInfo(defaultIDs[i])
			if name then
				countItems[name] = true
			else	-- item not in cache
				queries = queries + 1
			end
		end

		if queries == 0 then
			-- Remove the callback frame, as it is unneeded.
			callbackFrame:UnregisterEvent("GET_ITEM_INFO_RECEIVED")
			callbackFrame:SetScript("OnEvent", nil)
			callbackFrame = nil
		end

		settings.countItems = countItems
	end
end

function Consolid8.AddCountItem(name)
	if not settings then settings = Consolid8_Settings end
	settings.countItems[name] = true
end

function Consolid8.RemoveCountItem(name)
	if not settings then settings = Consolid8_Settings end
	settings.countItems[name] = nil
end

-- Thanks to Slakah of WoWInterface.com for this function
local function ConcatKeys(tbl, key, ...)
	local newKey, newValue = next(tbl, key)
	if not newValue then return strjoin("\n", ...) end
	return ConcatKeys(tbl, newKey, newKey, ...)
end

local function UpdateSettingsDisplays()
	if not panel then return end
	panel.lootCB:SetChecked(settings.loot)
	panel.skillCB:SetChecked(settings.skill)
	panel.autoCB:SetChecked(settings.auto)
	panel.visibleCB:SetChecked(settings.visible)
end

local function RegisterSettingsPanel()
	-- Creates the settings panel.
	--[[ Design:
		On the left of the panel is a scroll frame listing counted item names, with add and remove buttons below it.
			The scroll frame stretches from top to bottom on the left side, with room for the two buttons between the
			bottom of the scroll frame and the bottom of the panel.
		On the right are four check buttons with font strings, which enable or disable loot and skill message handling,
			automatic reporting, and toggle the visibility of the button.
	]]--
	-- Note: TitanPanel dividers
	-- favourites list highlight texture: Interface\QuestFrame\UI-QuestLogTitleHighlight
	if not settings then settings = Consolid8_Settings end

	panel = CreateFrame("Frame", nil, UIParent)
	panel.name = addOnName

	do	-- Item list --
		-- Add Button
		local addItemB = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
		addItemB:SetPoint("BOTTOMLEFT", 5, 5)
		addItemB:SetText(L["ADD"])
		addItemB:SetWidth(122); addItemB:SetHeight(22)

		-- Remove Button
		local remItemB = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
		remItemB:SetPoint("TOPLEFT", addItemB, "TOPRIGHT", 6, 0)
		remItemB:SetText(L["REMOVE"])
		remItemB:SetWidth(122); remItemB:SetHeight(22)

		-- countItems SF
		local itemsSF = CreateFrame("ScrollFrame", "Consolid8OptionsSF", panel, "UIPanelScrollFrameTemplate")
		itemsSF:SetPoint("TOPLEFT", panel, "TOPLEFT", 0, 0)
		itemsSF:SetPoint("BOTTOMLEFT", addItemB, "TOPLEFT", 0, 5)
		itemsSF:SetWidth(250)
		itemsSF:SetBackdrop({	-- Tooltip
				bgFile = [[Interface\Tooltips\UI-Tooltip-Background]], 
				edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
				tile = true, tileSize = 16, edgeSize = 16,
				insets = { left = 4, right = 4, top = 4, bottom = 4 }
			})
		itemsSF:SetBackdropColor(0, 0, 0)
		panel.itemsSF = itemsSF

		-- scroll child
		local scrollChild = CreateFrame("Frame", nil, itemsSF)
		itemsSF.scrollChild = scrollChild
		local countItemsFS = scrollChild:CreateFontString(nil, nil, "GameFontNormalLeft")
		countItemsFS:SetText(ConcatKeys(settings.countItems))
		countItemsFS:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 5, -5)

		-- Item popup
		if not StaticPopupDialogs.Consolid8ItemPopup then
			itemPopup = {
				button1 = ACCEPT, button2 = CANCEL, hasEditBox = 1,
				text = L["ENTER_ITEM_NAME"],

				-- The accept button is only enabled by the following two scripts if the user has entered something.
				OnShow = function(self) return self.button1:Disable() end,

				EditBoxOnTextChanged = function(self, data)
					if self:GetText() ~= "" then
						return self:GetParent().button1:Enable()	-- self:GetParent() is the dialog
					else
						return self:GetParent().button1:Disable()
					end
				end,

				OnAccept = function(self)
					self.callback(self.editBox:GetText())					-- Make callback
					countItemsFS:SetText(ConcatKeys(settings.countItems))	-- Refresh list
				end,

				whileDead = 1, hideOnEscape = 1, timeout = 0,

				Show = function(self, callback)	-- To be called by my code. Do not confuse with OnShow.
					local dialog = StaticPopup_Show("Consolid8ItemPopup")
					dialog.callback = callback
					return dialog
				end,
			}
			StaticPopupDialogs.Consolid8ItemPopup = itemPopup
		end

		scrollChild:SetWidth(250)
		scrollChild:SetHeight(countItemsFS:GetHeight())
		itemsSF:SetScrollChild(scrollChild)

		-- Add/Remove button scripts
		addItemB:SetScript("OnClick", function(self) return itemPopup:Show(Consolid8.AddCountItem)		end)
		remItemB:SetScript("OnClick", function(self) return itemPopup:Show(Consolid8.RemoveCountItem)	end)
	end

	do	-- Check Buttons and Reset Position button --
		local function CreateCheckButton(str, checked, func)
			-- Returns: a CheckButton frame with the specified label and check state. Clicking the CheckButton sends the check
			--	state to func.
			local cb = CreateFrame("CheckButton", nil, panel, "Consolid8_CBTemplate")
			cb:SetText(str)
			cb:SetChecked(checked)
			cb:SetScript("OnClick", function(self) return func(self:GetChecked()) end)
			return cb
		end

		-- Loot setting CB
		local lootCB = CreateCheckButton(LOOT, settings.loot, Consolid8.SetLootSetting)
		lootCB:SetPoint("TOPLEFT", panel.itemsSF, "TOPRIGHT", 20, 0)
		panel.lootCB = lootCB

		-- Tradeskill setting CB
		local skillCB = CreateCheckButton(TRADESKILLS, settings.skill, Consolid8.SetSkillSetting)
		skillCB:SetPoint("TOPLEFT",	lootCB, "BOTTOMLEFT", 0, -5)
		panel.skillCB = skillCB

		-- Report setting CB
		local autoCB = CreateCheckButton(L["AUTO"], settings.auto, Consolid8.SetReportSetting)
		autoCB:SetPoint("TOPLEFT", skillCB, "BOTTOMLEFT", 0, -5)
		panel.autoCB = autoCB

		-- Visible setting CB
		local visibleCB = CreateCheckButton(L["SHOW"], settings.visible, Consolid8.SetVisibleSetting)
		visibleCB:SetPoint("TOPLEFT", autoCB, "BOTTOMLEFT", 0, -5)
		panel.visibleCB = visibleCB

		-- Reset Position Button
		local resetPosB = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
		resetPosB:SetPoint("TOPLEFT", visibleCB, "BOTTOMLEFT", 0, -5)
		resetPosB:SetText(L["RESET_POS"])
		resetPosB:SetWidth(122); resetPosB:SetHeight(22)
		resetPosB:SetScript("OnClick", function(self)
			Consolid8_Frame:SetUserPlaced(false)							-- Remove user placement setting data
			Consolid8_Frame:ClearAllPoints()
			Consolid8_Frame:SetPoint("BOTTOM", FriendsMicroButton, "TOP")	-- Reset the anchor
		end)
	end

	InterfaceOptions_AddCategory(panel)
end

-- Script to load the interface options panel when the user opens the interface options for the first time
local oldOnShow = InterfaceOptionsFrame:GetScript("OnShow")
InterfaceOptionsFrame:SetScript("OnShow", function(...)
	if not panel then
		RegisterSettingsPanel()
	else
		UpdateSettingsDisplays()
	end
	return oldOnShow(...)
end)
