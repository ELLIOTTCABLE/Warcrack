--[[
	Color Guide:
	|cffffdd00		for Yellow
	|cffff6906		for Orange
	|cff999999		for Grey
	|cffffaa33		for Brownish Orange
--]]

TidyPlatesHubModes = {}
				
TidyPlatesHubModes.StyleModes = { 																-- Nameplate Style
				{ text = "Default (Health bars always visible)",  			
							--tooltipTitle = "Default", tooltipText = "Health bars always visible.", tooltipOnButton = true,	-- Tooltip Demo
						notCheckable = 1, } ,
				{ text = "|cffffaa33Text-Only Nameplate (No Health Bar)",		
						notCheckable = 1, } ,
				{ text = "Bars during Combat; |cffffaa33Text-Only while idle",		
						notCheckable = 1, } ,
				{ text = "Bars on Active/Damaged/Marked Units; |cffffaa33Text-Only on other units",		
						notCheckable = 1, } ,
				{ text = "Bars on Elite units; |cffffaa33Text-Only on Normal units", notCheckable = 1 } , 
				{ text = "Bars on Marked Units; |cffffaa33Text-Only on Unmarked Units", notCheckable = 1 } , 
				{ text = "Bars on Players; |cffffaa33Text-Only on NPCs", notCheckable = 1 } , 
				}						

TidyPlatesHubModes.TextModes = { { text = "None", notCheckable = 1 },
				{ text = "Percent Health", notCheckable = 1 } ,
				{ text = "Exact health", notCheckable = 1 } ,
				{ text = "Health Deficit", notCheckable = 1 } ,
				{ text = "Health Total & Percent", notCheckable = 1 } ,
				{ text = "Target Of", notCheckable = 1 } ,
				{ text = "Approximate Health", notCheckable = 1 } ,
				{ text = "Level", notCheckable = 1 } ,
				{ text = "Level and Health", notCheckable = 1 } ,
				}
				
TidyPlatesHubModes.RangeModes = { { text = "9 yards"} , 
				{ text = "15 yards" } ,
				{ text = "28 yards" } ,
				{ text = "40 yards" } ,
				}
				
TidyPlatesHubModes.DebuffModes = { 
				{ text = "Show All", notCheckable = 1 } ,
				{ text = "Show These... ", notCheckable = 1 } , 
				{ text = "Show All Mine ", notCheckable = 1 } , 
				{ text = "Show My... ", notCheckable = 1 } ,
				{ text = "By Prefix...", notCheckable = 1 } ,						
				}

TidyPlatesHubModes.ScaleModes = {
				{ text = "None", notCheckable = 1 } ,
				{ text = "By Elite", notCheckable = 1 } ,
				{ text = "By Target", notCheckable = 1 } ,
				{ text = "By Threat (Auto-Detect)", notCheckable = 1 } ,
				{ text = "By High Threat (Aggro Gained)", notCheckable = 1 } ,
				{ text = "By Low Threat (Aggro Lost)", notCheckable = 1 } ,
				{ text = "By Active Debuff Widget", notCheckable = 1 } ,
				{ text = "By Enemy", notCheckable = 1 } ,
				{ text = "By NPC", notCheckable = 1 } ,
				{ text = "By Raid Icon", notCheckable = 1 } ,
				{ text = "By Enemy Healer", notCheckable = 1 } ,
				{ text = "By Low Health", notCheckable = 1 } ,
				{ text = "By Boss", notCheckable = 1 } ,
				}
					
TidyPlatesHubModes.OpacityModes = {
				{ text = "None", notCheckable = 1 } ,
				{ text = "By Threat (Auto-Detect)", notCheckable = 1 } ,
				{ text = "By High Threat (Aggro Gained)", notCheckable = 1 } ,
				{ text = "By Low Threat (Aggro Lost)", notCheckable = 1 } ,
				{ text = "By Debuff Widget", notCheckable = 1 } ,
				{ text = "By Enemy", notCheckable = 1 } ,
				{ text = "By NPC", notCheckable = 1 } ,
				{ text = "By Raid Icon", notCheckable = 1 } ,
				{ text = "By Active/Damaged", notCheckable = 1 } ,
				{ text = "By Enemy Healer", notCheckable = 1 } ,
				{ text = "By Low Health", notCheckable = 1 } ,
				--{ text = "By Mouseover", notCheckable = 1 } ,
				}
					
TidyPlatesHubModes.HealthColorModes = {
				{ text = "None", notCheckable = 1 } ,
				{ text = "By Enemy Class", notCheckable = 1 } ,
				{ text = "By Threat (Detect Role, Swap Colors for Tanking)", notCheckable = 1 } ,
				{ text = "By Reaction", notCheckable = 1 } ,
				{ text = "By Level Color", notCheckable = 1 } ,
				{ text = "By Raid Icon", notCheckable = 1 } ,
				{ text = "By Health", notCheckable = 1 } ,
				{ text = "By Threat (Raw Aggro, No Color Swapping)", notCheckable = 1 } ,
				{ text = "By Friendly Class", notCheckable = 1 } ,
				}

TidyPlatesHubModes.NameColorModes = {
				{ text = "Default", notCheckable = 1 } ,
				{ text = "By Class", notCheckable = 1 } ,
				{ text = "By Threat (Detect Role, Swap Colors for Tanking)", notCheckable = 1 } ,
				{ text = "By Reaction", notCheckable = 1 } ,
				{ text = "By Level Color", notCheckable = 1 } ,
				{ text = "By Health", notCheckable = 1 } ,
				{ text = "By Elite/Bosss", notCheckable = 1 } ,
				{ text = "By Threat (Raw Aggro, No Color Swapping)", notCheckable = 1 } ,
				}
				
TidyPlatesHubModes.WarningGlowModes = {
				{ text = "None", notCheckable = 1 } ,
				{ text = "By Threat (Auto-Detect)", notCheckable = 1 } ,
				{ text = "By High Threat (Aggro Gained)", notCheckable = 1 } ,
				{ text = "By Low Threat (Aggro Lost)", notCheckable = 1 } ,
				{ text = "By Enemy Healer", notCheckable = 1 } ,
				}
					

				
TidyPlatesHubModes.TextPlateFieldModes = {
				{ text = "None", notCheckable = 1 } ,
				--{ text = "Health (Configure via, |cffff6906Text: |cffffdd00Optional Text Field|r)", notCheckable = 1 } ,
				{ text = "Health Percent", notCheckable = 1 } ,
				{ text = "Role, Guild or Level", notCheckable = 1 } ,
				{ text = "Role or Guild", notCheckable = 1 } ,
				{ text = "NPC Role", notCheckable = 1 } ,
				{ text = "Level", notCheckable = 1 } ,
				{ text = "All", notCheckable = 1 } ,
				}
				
TidyPlatesHubModes.ThreatModes = {
					{ text = "Tug-o-Threat", notCheckable = 1 } ,
					{ text = "Threat Wheel", notCheckable = 1 } ,
					}
					


--[[
local StyleModes = TidyPlatesHubModes.StyleModes
local TextModes = TidyPlatesHubModes.TextModes
local RangeModes = TidyPlatesHubModes.RangeModes
local DebuffModes = TidyPlatesHubModes.DebuffModes
local OpacityModes = TidyPlatesHubModes.OpacityModes
local ScaleModes = TidyPlatesHubModes.ScaleModes
local HealthColorModes = TidyPlatesHubModes.HealthColorModes
local WarningGlowModes = TidyPlatesHubModes.WarningGlowModes
local ThreatModes = TidyPlatesHubModes.ThreatModes
local NameColorModes = TidyPlatesHubModes.NameColorModes
--]]
					