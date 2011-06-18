local SHOW_ACCOUNTBOUND = true

local BoETextColor = {.3, 1, .3}
local BoEText = "BoE"
local BoATextColor = {.9, .8, .5}
local BoAText = "BoA"

function UpdateAllItems()
	for i = 1, 13 do
		local bagFrame = getglobal("ContainerFrame"..i);
		if (bagFrame) then
			local bagIndex = bagFrame:GetID();
			if (bagFrame:IsVisible()) then
				for itemIndex = 1, GetContainerNumSlots(bagIndex) do
					local BindingTheoryFontString = getglobal(bagFrame:GetName() .. "Item" .. itemIndex .. "BindingTheoryText");
					if(not BindingTheoryFontString) then
						local itemButton = getglobal(bagFrame:GetName() .. "Item" .. itemIndex);
						itemButton:CreateFontString(bagFrame:GetName() .. "Item" .. itemIndex .. "BindingTheoryText", "OVERLAY");
						BindingTheoryFontString = getglobal(bagFrame:GetName() .. "Item" .. itemIndex .. "BindingTheoryText");
						BindingTheoryFontString:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE");
						BindingTheoryFontString:SetPoint("BOTTOMRIGHT", itemButton, "BOTTOMRIGHT", -1, 3);
					end
					BindingTheoryFontString:SetText("");
					BindingTheoryScanningTooltip:ClearLines();
					BindingTheoryScanningTooltip:SetBagItem(bagIndex, GetContainerNumSlots(bagIndex) - itemIndex + 1);
					for i=1,BindingTheoryScanningTooltip:NumLines() do
						local lineText = getglobal("BindingTheoryScanningTooltipTextLeft" .. i):GetText();
						if (IsEquippableItem(GetContainerItemLink(bagIndex, GetContainerNumSlots(bagIndex) - itemIndex + 1)) and lineText == ITEM_BIND_ON_EQUIP) then
							BindingTheoryFontString:SetText(BoEText);
							BindingTheoryFontString:SetTextColor(unpack(BoETextColor));
							break;
						elseif (SHOW_ACCOUNTBOUND and (lineText == ITEM_ACCOUNTBOUND or lineText == ITEM_BNETACCOUNTBOUND)) then
							BindingTheoryFontString:SetText(BoAText);
							BindingTheoryFontString:SetTextColor(unpack(BoATextColor));
							break;
						end
					end
				end
			end
		end
	end
	
	local bankFrame = getglobal("BankFrame");
	if(bankFrame:IsVisible()) then
		for bankIndex = 1, 28 do
			local BindingTheoryFontString = getglobal("BankFrameItem" .. bankIndex .. "BindingTheoryText");
			if(not BindingTheoryFontString) then
				local itemButton = getglobal("BankFrameItem" .. bankIndex);
				itemButton:CreateFontString("BankFrameItem" .. bankIndex .. "BindingTheoryText", "OVERLAY");
				BindingTheoryFontString = getglobal("BankFrameItem" .. bankIndex .. "BindingTheoryText");
				BindingTheoryFontString:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE");
				BindingTheoryFontString:SetPoint("BOTTOMRIGHT", itemButton, "BOTTOMRIGHT", -1, 3);
			end
			BindingTheoryFontString:SetText("");
			BindingTheoryScanningTooltip:ClearLines();
			BindingTheoryScanningTooltip:SetInventoryItem("player", BankButtonIDToInvSlotID(bankIndex, false));
			for i=1,BindingTheoryScanningTooltip:NumLines() do
				local lineText = getglobal("BindingTheoryScanningTooltipTextLeft" .. i):GetText();
				if (IsEquippableItem(GetContainerItemLink(-1, 29 - bankIndex)) and lineText == ITEM_BIND_ON_EQUIP) then
					BindingTheoryFontString:SetText(BoEText);
					BindingTheoryFontString:SetTextColor(unpack(BoETextColor));
					break;
				elseif (SHOW_ACCOUNTBOUND and (lineText == ITEM_ACCOUNTBOUND or lineText == ITEM_BNETACCOUNTBOUND)) then
					BindingTheoryFontString:SetText(BoAText);
					BindingTheoryFontString:SetTextColor(unpack(BoATextColor));
					break;
				end
			end
		end
	end
end

local BindingTheoryScanningTooltip = CreateFrame( "GameTooltip", "BindingTheoryScanningTooltip" );
BindingTheoryScanningTooltip:SetOwner( WorldFrame, "ANCHOR_NONE" );
BindingTheoryScanningTooltip:AddFontStrings(
    BindingTheoryScanningTooltip:CreateFontString( "$parentTextLeft1", nil, "GameTooltipText" ),
    BindingTheoryScanningTooltip:CreateFontString( "$parentTextRight1", nil, "GameTooltipText" ) );

local BindingTheoryFrame = CreateFrame("FRAME", "BindingTheoryFrame");
BindingTheoryFrame:RegisterEvent("BAG_UPDATE");
BindingTheoryFrame:RegisterEvent("PLAYERBANKSLOTS_CHANGED");
BindingTheoryFrame:RegisterEvent("PLAYERBANKBAGSLOTS_CHANGED");
BindingTheoryFrame:SetScript("OnEvent", UpdateAllItems);
for i = 1, 13 do
	getglobal("ContainerFrame"..i):HookScript("OnShow", UpdateAllItems);
end
getglobal("BankFrame"):HookScript("OnShow", UpdateAllItems);