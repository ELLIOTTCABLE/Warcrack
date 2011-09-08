local config = CreateFrame("Frame");

ExplorerCoordsConfig = config;
function config:SetDefaultConfig()
	ExplorerCoords_Config = {};
	ExplorerCoords_Config.ShowWorldMap = 1;
	ExplorerCoords_Config.ShowMiniMap = 0;
	config.ShowOnMainMap:SetChecked(1);
	config.ShowOnMiniMap:SetChecked(0);
	config.ShowMissingCoords:SetChecked(0);
end

function config:SetCurrentConfig()
	config.ShowOnMainMap:SetChecked(ExplorerCoords_Config.ShowWorldMap);
	config.ShowOnMiniMap:SetChecked(ExplorerCoords_Config.ShowMiniMap);
	config.ShowMissingCoords:SetChecked(ExplorerCoords_Config.ShowMissingCoords);
end

function config:ChangeState()
	
	 ExplorerCoords_Config[self.id] = self:GetChecked() or 0;
	if(self.id == "ShowWorldMap") then
		if(self:GetChecked() == 1) then
			ExplorerCoordsFrame:RegisterEvent("WORLD_MAP_UPDATE");
		else
			ExplorerCoordsFrame:UnregisterEvent("WORLD_MAP_UPDATE");
			ExplorerCoords_ClearNotes("world");
		end
	elseif(self.id == "ShowMiniMap") then
		if(self:GetChecked() == 1) then
			ExplorerCoordsFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA");
			ExplorerCoords_UpdateMap("mini");
		else
			ExplorerCoordsFrame:UnregisterEvent("ZONE_CHANGED_NEW_AREA");
			ExplorerCoords_ClearNotes("mini");
		end
	end
end

function config:Init()

	config.name = "Explorer Coords";
	
 
 local ShowOnMainMap = CreateFrame( "CheckButton", "ShowOnMainMapCheckBox", config, "InterfaceOptionsCheckButtonTemplate" );
	config.ShowOnMainMap = ShowOnMainMap;
	ShowOnMainMap.id = "ShowWorldMap";
	ShowOnMainMap:SetPoint( "TOPLEFT", 16, -16 );
	ShowOnMainMap:SetScript("onClick",config.ChangeState);
	_G[ ShowOnMainMap:GetName().."Text" ]:SetText( EXPLORER_COORD_OPTION_WORLDMAP );
 
  local ShowOnMiniMap = CreateFrame( "CheckButton", "ShowOnMiniMapCheckBox", config, "InterfaceOptionsCheckButtonTemplate" );
    config.ShowOnMiniMap = ShowOnMiniMap;
	ShowOnMiniMap.id = "ShowMiniMap";
	ShowOnMiniMap:SetPoint( "TOPLEFT", ShowOnMainMap, "BOTTOMLEFT", 0, -16);
	ShowOnMiniMap:SetScript("onClick",config.ChangeState);
	_G[ ShowOnMiniMap:GetName().."Text" ]:SetText( EXPLORER_COORD_OPTION_MINIMAP );
	
	local ShowMissingCoords = CreateFrame( "CheckButton", "ShowMissingCoordsCheckBox", config, "InterfaceOptionsCheckButtonTemplate" );
    config.ShowMissingCoords = ShowMissingCoords;
	ShowMissingCoords.id = "ShowMissingCoords";
	ShowMissingCoords:SetPoint( "TOPLEFT", ShowOnMiniMap, "BOTTOMLEFT", 0, -16);
	ShowMissingCoords:SetScript("onClick",config.ChangeState);
	_G[ ShowMissingCoords:GetName().."Text" ]:SetText( EXPLORER_COORD_SHOW_MISSING );

	
 
 InterfaceOptions_AddCategory(config);
 
 if not (ExplorerCoords_Config) then
   config:SetDefaultConfig();
 else
   config:SetCurrentConfig();
 end
 if (ExplorerCoords_Config.ShowMiniMap == 1) then
	ExplorerCoordsFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	ExplorerCoords_UpdateMap("mini");
 end
 if (ExplorerCoords_Config.ShowWorldMap == 1) then
	ExplorerCoordsFrame:RegisterEvent("WORLD_MAP_UPDATE");
 end
 

end