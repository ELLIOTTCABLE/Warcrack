local gframe;
if (GridFrame and GridFrame.InitialConfigFunction) then -- for < r1293
	gframe = GridFrame;
elseif Grid and Grid.modules and Grid.modules.GridFrame then  -- now eat THIS you nasty ace2!
	gframe = Grid.modules.GridFrame;
end

if gframe then
	-- create a popup (hell can't I just use the same that blizz are using :-/)
	local gum = CreateFrame("Frame","GUM", UIParent,"UIDropDownMenuTemplate");
	local unit = "player";
	UIDropDownMenu_Initialize(gum, nil, "MENU");
	local function init_player(self)
		UnitPopup_ShowMenu(gum, "SELF", unit, nil, UnitInRaid(u));
	end
	local function init_pet(self)
		UnitPopup_ShowMenu(gum, "PET", unit, nil, UnitPlayerOrPetInRaid(u));
	end
	local function init_party(self)
		UnitPopup_ShowMenu(gum, "PARTY", unit, nil, UnitInParty(u));
	end
	local function init_raid(self)
		UnitPopup_ShowMenu(gum, "RAID_PLAYER", unit, nil, UnitInRaid(u));
	end
	local function init_raidpet(self)
		UnitPopup_ShowMenu(gum, "RAID_TARGET_ICON", unit, nil, UnitPlayerOrPetInRaid(u));
	end
	-- posthook this into the grid button register function
	hooksecurefunc(gframe, "InitialConfigFunction", function(frame)
		if not frame.menu then
			--[[
			frame:SetAttribute("_showmenu", "print(self,'yay, menu!?'); self:SetAttribute('type1', 'focus');");
			if not frame:GetAttribute("type2") then
				frame:SetAttribute("type2", "showmenu");
			end
			if true then return; end
			--]]
			frame.menu = function(self)
				if UIDROPDOWNMENU_MAXBUTTONS < 24 then
					--print("UIDROPDOWNMENU_MAXBUTTONS < 39");
					local toggle;
					if not WorldMapFrame:IsVisible() then
						ToggleFrame(WorldMapFrame);
						toggle = true;
					end
					SetMapZoom(2);
					if toggle then
						ToggleFrame(WorldMapFrame);
					end
				else
					--print("UIDROPDOWNMENU_MAXBUTTONS ==",UIDROPDOWNMENU_MAXBUTTONS);
				end
				
				unit = self.unit or "player"; -- see line 11
				if UnitIsUnit(unit, "player") then   -- this is the player himself, show own menu
					UIDropDownMenu_Initialize(gum, init_player, "MENU");
				elseif UnitIsUnit(unit, "pet") then  -- player's pet
					UIDropDownMenu_Initialize(gum, init_pet, "MENU");
				elseif UnitIsPlayer(unit) then       -- other PC
					if UnitPlayerOrPetInParty(unit) and not UnitPlayerOrPetInRaid(unit) then
						UIDropDownMenu_Initialize(gum, init_party, "MENU");
					else
						UIDropDownMenu_Initialize(gum, init_raid, "MENU");
					end
				elseif UnitPlayerOrPetInRaid(unit) or UnitPlayerOrPetInParty(unit) then
					UIDropDownMenu_Initialize(gum, init_raidpet, "MENU");
				else
					return; -- don't show dropdown
				end
				ToggleDropDownMenu(1, nil, gum, self:GetName(), 0, 0);
			end
			--frame:HookScript("OnAttributeChanged", attschanged);
			if not frame:GetAttribute("type2") then
				frame:SetAttribute("type2", "menu");
			end
		end
	end);
else
	DEFAULT_CHAT_FRAME:AddMessage("|cFFFF5555Can't load GridUnitMenu, you may "
		.."be using an incompatible (new?) version of Grid, please contact the "
		.."developer on the GridUnitMenu page or via PM on wow.curse.com!\n"
		.."Sorry.|r");
end	
-- /run UnitPopup_ShowMenu(GridLayoutHeader1UnitButton1, "SELF", "player", "Calden", UnitInRaid("player"))

