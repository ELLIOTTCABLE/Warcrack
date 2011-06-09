local addonName = "Altoholic"
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local PETS_PER_PAGE = 12

local selectedID
local currentPetType
local currentPage
local currentPetName

addon.Pets = {}

local ns = addon.Pets		-- ns = namespace

function ns:OnEnter(frame)
	local id = frame.spellID
	if id then 
		AltoTooltip:SetOwner(frame, "ANCHOR_LEFT");
		AltoTooltip:ClearLines();
		AltoTooltip:SetHyperlink("spell:" ..id);
		AltoTooltip:Show();
	end
end

function ns:OnClick(frame, button)
	if frame.spellID and ( button == "LeftButton" ) and ( IsShiftKeyDown() ) then
		local chat = ChatEdit_GetLastActiveWindow()
		if chat:IsShown() then
			local link = DataStore:GetCompanionLink(frame.spellID)
			if link then
				chat:Insert(link)
			end
		end
	end

	frame:SetChecked(true);

	local offset = (currentPage-1) * PETS_PER_PAGE
	selectedID = offset + frame:GetID()
	ns:UpdatePets()
end

-- ** Single pet view **
local function SetPage(pageNum)
	currentPage = pageNum
	
	local character = addon.Tabs.Characters:GetAltKey()
	local pets = DataStore:GetPets(character, currentPetType)
	
	if currentPage == 1 then
		AltoholicFramePetsNormalPrevPage:Disable()
	else
		AltoholicFramePetsNormalPrevPage:Enable()
	end
	
	local maxPages = 1
	if pets then
		maxPages = ceil(DataStore:GetNumPets(pets) / PETS_PER_PAGE)
		if maxPages == 0 then
			maxPages = 1
		end
	end
	
	if currentPage == maxPages then
		AltoholicFramePetsNormalNextPage:Disable()
	else
		AltoholicFramePetsNormalNextPage:Enable()
	end
	
	AltoholicFramePetsNormal_PageNumber:SetText(format(MERCHANT_PAGE_NUMBER, currentPage, maxPages ))
	ns:UpdatePets()
end

function ns:GoToPreviousPage()
	SetPage(currentPage - 1)
end

function ns:GoToNextPage()
	SetPage(currentPage + 1)
end

function ns:SetSinglePetView(petType)
	selectedID = 1
	currentPetType = petType
	
	AltoholicFramePetsNormal:Show()
	AltoholicFramePetsAllInOne:Hide()
	AltoholicFramePets:Show()
	
	SetPage(1)
end

function ns:UpdatePets()
	local DS = DataStore
	local character = addon.Tabs.Characters:GetAltKey()
	local pets = DataStore:GetPets(character, currentPetType)
	
	local num = DataStore:GetNumPets(pets)
	
	if currentPetType == "MOUNT" then
		AltoholicTabCharactersStatus:SetText(format("%s|r / %s", DataStore:GetColoredCharacterName(character), format(MOUNTS .. " %s(%d)", GREEN, num)))
	else
		AltoholicTabCharactersStatus:SetText(format("%s|r / %s", DataStore:GetColoredCharacterName(character), format(COMPANIONS .. " %s(%d)", GREEN, num)))
	end
	
	if not pets or (num == 0) then		-- added this test as simply addressing the table seems to make it grow, I'd assume this is due to AceDB magic value ['*'].
		for i = 1, PETS_PER_PAGE do
			local button = _G["AltoholicFramePetsNormal_Button" .. i];
		
			if currentPetType == "MOUNT" then
				button:SetDisabledTexture([[Interface\PetPaperDollFrame\UI-PetFrame-Slots-Mounts]])
			else
				button:SetDisabledTexture([[Interface\PetPaperDollFrame\UI-PetFrame-Slots-Companions]])
			end
			button:Disable();
			button:SetChecked(false);
		end
		return
	end
	
	local offset = (currentPage-1) * PETS_PER_PAGE
	
	for i = 1, PETS_PER_PAGE do
		local index = offset + i
		local button = _G["AltoholicFramePetsNormal_Button" .. i];
		
		local modelID, name, spellID, icon = DataStore:GetPetInfo(pets, index)
		
		if icon and spellID then						-- if there's a pet  .. texture & enable it
			button:SetNormalTexture(icon);	
			button:Enable()
			button.spellID = spellID 
		else
			button.spellID = nil
			if currentPetType == "MOUNT" then
				button:SetDisabledTexture([[Interface\PetPaperDollFrame\UI-PetFrame-Slots-Mounts]])
			else
				button:SetDisabledTexture([[Interface\PetPaperDollFrame\UI-PetFrame-Slots-Companions]])
			end
			button:Disable();
		end

		modelID = tonumber(modelID)
		if selectedID and (index == selectedID) and modelID then
			button:SetChecked(true);		-- check only if it's the selected button and it has a model id
			AltoholicFramePetsNormal_PetName:SetText(name)
			AltoholicFramePetsNormal_ModelFrame:SetCreature(modelID);
		else
			button:SetChecked(false);
		end
	end
end

-- ** All in one view **
local function SortPets(a, b)
	local textA = GetSpellInfo(a) or ""
	local textB = GetSpellInfo(b) or ""
	return textA < textB
end

function ns:SetAllInOneView(petType)
	currentPetType = petType
	AltoholicFramePetsNormal:Hide()
	AltoholicFramePetsAllInOne:Show()
	AltoholicFramePets:Show()
	
	if petType == "MOUNT" then
		table.sort(DataStore:GetMountList(), SortPets)
	else
		table.sort(DataStore:GetCompanionList(), SortPets)
	end
end

function ns:UpdatePetsAllInOne()
	local VisibleLines = 8
	local frame = "AltoholicFramePetsAllInOne"
	local entry = frame.."Entry"
		
	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	local petList

	if currentPetType == "CRITTER" then
		petList = DataStore:GetCompanionList()
	elseif currentPetType == "MOUNT" then
		petList = DataStore:GetMountList()
	end
	
	local realm, account = addon.Tabs.Characters:GetRealm()
	local character

	for i=1, VisibleLines do
		local line = i + offset
		if line <= #petList then	-- if the line is visible
			local spellID

			spellID = petList[line]
			
			local petName, _, petTexture = GetSpellInfo(spellID)
			
			if petName then
				_G[entry..i.."Name"]:SetText(WHITE .. petName)
				_G[entry..i.."Name"]:SetJustifyH("LEFT")
				_G[entry..i.."Name"]:SetPoint("TOPLEFT", 15, 0)
			end
			
			for j = 1, 10 do
				local itemName = entry.. i .. "Item" .. j;
				local itemButton = _G[itemName]
				local itemTexture = _G[itemName .. "_Background"]
				
				character = addon:GetOption(format("Tabs.Characters.%s.%s.Column%d", account, realm, j))
				if character then
					itemButton:SetScript("OnEnter", function(self) ns:OnEnter(self) end)
					itemTexture:SetTexture(petTexture)
					
					if DataStore:IsPetKnown(character, currentPetType, spellID) then
						itemTexture:SetVertexColor(1.0, 1.0, 1.0);
						_G[itemName .. "Name"]:SetText("\124TInterface\\RaidFrame\\ReadyCheck-Ready:14\124t")
					else
						itemTexture:SetVertexColor(0.4, 0.4, 0.4);
						_G[itemName .. "Name"]:SetText("\124TInterface\\RaidFrame\\ReadyCheck-NotReady:14\124t")
					end
					itemButton.spellID = spellID
					itemButton:Show()
				else
					itemButton.spellID = nil
					itemButton:Hide()
				end
			end

			_G[ entry..i ]:Show()
		else
			_G[ entry..i ]:Hide()
		end
	end

	FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], #petList, VisibleLines, 41);
end



local function ScanHunter()
	-- this is a specific function to scan hunter pet talents
	--	DEFAULT_CHAT_FRAME:AddMessage("Scanning Pet " .. currentPetName)
end

function ns:OnChange()
	-- this event is triggered too often for our needs, some filtering is required  to avoid scanning pet data too often
	if arg1 ~= "player" then return end
	
	local name = UnitName("pet")
	if not name or name == UNKNOWN then	return end		-- if there's a usable pet name ..
	
	if not currentPetName then		-- not set ? initial scan
		currentPetName = name
		ScanHunter()
	elseif currentPetName ~= name then	-- already set, has it changed ? re-scan
		currentPetName = name
		ScanHunter()
	end
end

addon:RegisterEvent("UNIT_PET", addon.Pets.OnChange);