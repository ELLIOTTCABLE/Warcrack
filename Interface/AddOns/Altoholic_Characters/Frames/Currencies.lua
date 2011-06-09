local addonName = "Altoholic"
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"

local view
local isViewValid

local currentTokenType

addon.Currencies = {}

local ns = addon.Currencies		-- ns = namespace

local function HashToSortedArray(hash)
	local array = {}		-- order them
	for k, _ in pairs(hash) do
		table.insert(array, k)
	end
	table.sort(array)
	return array
end

local function GetUsedHeaders()
	local realm, account = addon.Tabs.Characters:GetRealm()
	local DS = DataStore
	
	local usedHeaders = {}
	local isHeader, name, num

	for _, character in pairs(DS:GetCharacters(realm, account)) do	-- all alts on this realm
		num = DS:GetNumCurrencies(character) or 0
		
		for i = 1, num do
			isHeader, name = DS:GetCurrencyInfo(character, i)	-- save ech header found in the table
			if isHeader then
				usedHeaders[name] = true
			end
		end
	end
	
	return HashToSortedArray(usedHeaders)
end

local function GetUsedTokens(header)
	-- get the list of tokens found under a specific header, across all alts

	local realm, account = addon.Tabs.Characters:GetRealm()
	local DS = DataStore
	
	local tokens = {}
	local useData				-- use data for a specific header or not

	for _, character in pairs(DS:GetCharacters(realm, account)) do	-- all alts on this realm
		local num = DS:GetNumCurrencies(character) or 0
		for i = 1, num do
			local isHeader, name = DS:GetCurrencyInfo(character, i)
			
			if isHeader then
				if header and name ~= header then -- if a specific header (filter) was set, and it's not the one we chose, skip
					useData = nil
				else
					useData = true		-- we'll use data in this category
				end
			else
				if useData then		-- mark it as used
					tokens[name] = true
				end
			end
		end
	end
	
	return HashToSortedArray(tokens)
end

local function BuildView()
	view = GetUsedTokens(currentTokenType)
	isViewValid = true
end

local DDM_Add = addon.Helpers.DDM_AddWithArgs
local DDM_AddCloseMenu = addon.Helpers.DDM_AddCloseMenu

local function OnTokenChange(self, header)
	currentTokenType = header
	UIDropDownMenu_SetText(AltoholicFrameCurrencies_SelectCurrencies, currentTokenType)

	isViewValid = nil
	ns:Update()
end

local function OnTokensAllInOne(self)
	currentTokenType = nil
	UIDropDownMenu_SetText(AltoholicFrameCurrencies_SelectCurrencies, L["All-in-one"])

	isViewValid = nil
	ns:Update()
end

local function Currencies_UpdateEx(self, offset, entry, desc)
	if not isViewValid then
		BuildView()
	end
	
	local line
	local size = desc:GetSize()
	
	local DS = DataStore
	local realm, account = addon.Tabs.Characters:GetRealm()
	local character
	
	AltoholicTabCharactersStatus:SetText("")
	
	for i=1, desc.NumLines do
		line = i + offset
		if line <= size then
			local token = view[line]
		
			_G[entry..i.."Name"]:SetText(WHITE .. token)
			_G[entry..i.."Name"]:SetJustifyH("LEFT")
			_G[entry..i.."Name"]:SetPoint("TOPLEFT", 15, 0)
			
			for j = 1, 10 do	-- loop through the 10 alts
				local itemName = entry.. i .. "Item" .. j;
				local itemButton = _G[itemName]

				character = addon:GetOption(format("Tabs.Characters.%s.%s.Column%d", account, realm, j))
				if character then	-- if there's an alt in this column..
					local _, _, count, icon = DS:GetCurrencyInfoByName(character, token)
					itemButton.count = count
				
					if count then 
						local itemTexture = _G[itemName .. "_Background"]
						itemTexture:SetTexture(icon)
						itemTexture:SetVertexColor(0.5, 0.5, 0.5);	-- greyed out
						itemButton.key = character
						
						if count >= 100000 then
							count = format("%2.1fM", count/1000000)
						elseif count >= 10000 then
							count = format("%2.0fk", count/1000)
						elseif count >= 1000 then
							count = format("%2.1fk", count/1000)
						end
						
						_G[itemName .. "Name"]:SetText(GREEN..count)
						itemButton:Show()
					else
						itemButton.key = nil
						itemButton:Hide()
					end
				else
					itemButton:Hide()
				end
			end
			_G[ entry..i ]:SetID(line)
			_G[ entry..i ]:Show()
		end
	end
end

local CurrenciesScrollFrame_Desc = {
	NumLines = 8,
	LineHeight = 41,
	Frame = "AltoholicFrameCurrencies",
	GetSize = function() return #view end,
	Update = Currencies_UpdateEx,
}

local function DropDown_Initialize()
	for _, header in ipairs(GetUsedHeaders()) do		-- and add them to the DDM
		DDM_Add(header, nil, OnTokenChange, header)
	end
	DDM_Add(L["All-in-one"], nil, OnTokensAllInOne)
	DDM_AddCloseMenu()
end

function ns:Update()
	addon:ScrollFrameUpdate(CurrenciesScrollFrame_Desc)
end

function ns:OnEnter(frame)
	local character = frame.key
	if not character then return end
	
	AltoTooltip:SetOwner(frame, "ANCHOR_LEFT");
	AltoTooltip:ClearLines();
	AltoTooltip:AddLine(DataStore:GetColoredCharacterName(character));
	AltoTooltip:AddLine(view[frame:GetParent():GetID()], 1, 1, 1);
	AltoTooltip:AddLine(GREEN..frame.count);
	AltoTooltip:Show();
end

function ns:SelectCurrencies_OnLoad(frame)
	local headers = GetUsedHeaders()
	currentTokenType = headers[1]

	UIDropDownMenu_SetWidth(frame, 100) 
	UIDropDownMenu_SetButtonWidth(frame, 20)
	UIDropDownMenu_SetText(frame, currentTokenType)
	UIDropDownMenu_Initialize(frame, DropDown_Initialize)
end
