
--[[
	QuestSpam Filter
		By Myrilandell of Lothar
		
		This file contains the code for 
			* Options Panel GUI
]]

local indented = false;

------------------------------------------------------------------------------------
----------- SLASH COMMANDS & RELATED FUNCTIONS ----------
------------------------------------------------------------------------------------

-- When the player types "/procwatcher" or "/pw", open the ProcWatcher GUI
function QSF_addon.commandParser(msg)
	InterfaceOptionsFrame_OpenToCategory(QSF_addon.panel);
end

SLASH_QuestSpamFilter1 = "/questspamfilter";
SLASH_QuestSpamFilter2 = "/qsf"; -- A shortcut or alias
SlashCmdList["QuestSpamFilter"] = QSF_addon.commandParser;







------------------------------------------------------------------------------------
-------------------- Interface Frame and Options -------------------------
------------------------------------------------------------------------------------

--[[ Create a frame to use as the panel ]] --
QSF_addon.panel = CreateFrame("FRAME", "QuestSpamFilterInterfacePanel"); -- the frame that will be used for the interface panel
QSF_addon.panel.name = "QuestSpamFilter |cff7FFF7F v" .. QSF_addon.version .. "|r";

-- [[ Add the panels to the Interface Options ]] --
InterfaceOptions_AddCategory(QSF_addon.panel);



-- [[ When the player clicks okay, set the current value to the new setting ]] --
QSF_addon.panel.okay =
function (self)
	-- Update the Panel graphics to reflect the new changes
	QSF_addon.UpdateGraphics();
end

-- If the checkbox is checked, set the saved variable varName to true, otherwise it's false
function QSF_addon.checkBoxes(checked, varLoc, varName)
	if (checked == 1) then varLoc[varName] = true;
	else varLoc[varName] = false;
	end
	
	QSF_addon.UpdateGraphics();
end

local uniquealizer = 1;
function QSF_addon.createBorder(xloc, yloc, width, height)
	uniquealizer = uniquealizer + 1;
	local borderframe = CreateFrame("Frame", "QSF_addonborder_frame_0" .. uniquealizer, QSF_addon.panel);
	borderframe:SetPoint("TOPLEFT", QSF_addon.panel, "TOPLEFT", xloc, yloc);
	borderframe:SetWidth(width);
	borderframe:SetHeight(height);
	borderframe:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 4, right = 4, top = 4, bottom = 4 }});
	borderframe:SetBackdropColor(0,0,0,.75); -- very dark background
	borderframe:SetBackdropBorderColor(1, 1, 1, 1); -- white border
	
	return borderframe;
end



	QSF_addon.class = { ["x"] = 10, ["y"] = -10, };
	local c = {
		 [1] = { ["x"] = 5, ["y"] = -15, },
		 [2] = { ["x"] = 190, ["y"] = -15, },
		 [3] = { ["x"] = 5, ["y"] = -35, },		--	 1	2
		 [4] = { ["x"] = 190, ["y"] = -35, },	--	 3	4
		 [5] = { ["x"] = 5, ["y"] = -55, },		--	 5	6
		 [6] = { ["x"] = 190, ["y"] = -55, },	--	 7	8
		 [7] = { ["x"] = 5, ["y"] = -75, },		--	 9	10
		 [8] = { ["x"] = 190, ["y"] = -75, },	--	11	12
		 [9] = { ["x"] = 5, ["y"] = -95, },		--	...
		[10] = { ["x"] = 190, ["y"] = -95, },
		[11] = { ["x"] = 5, ["y"] = -115, },
		[12] = { ["x"] = 190, ["y"] = -115, },
		[13] = { ["x"] = 5, ["y"] = -135, },
		[14] = { ["x"] = 190, ["y"] = -135, },
		[15] = { ["x"] = 5, ["y"] = -155, },
		[16] = { ["x"] = 190, ["y"] = -155, },
	};
	
	QSF_addon.group1Label = QSF_addon.panel:CreateFontString("QSF_addon.group1LabelFontString");
	QSF_addon.group1Label:SetPoint("TOPLEFT", QSF_addon.class["x"], QSF_addon.class["y"]);
	QSF_addon.group1Label:SetFontObject("GameFontNormal");
	QSF_addon.group1Label:SetText("Display Options");
			
	--  Check Boxes --
		-- addself - determines whether to add yourself to the "Already On" table
			QSF_addon.addselfChkBtn = CreateFrame("CheckButton", "QSF_addonaddself_ChkBtn", QSF_addon.panel, "ChatConfigCheckButtonTemplate");
			QSF_addon.addselfChkBtn:SetPoint("TOPLEFT", QSF_addon.class["x"]+c[1]["x"], QSF_addon.class["y"]+c[1]["y"]);
			QSF_addonaddself_ChkBtnText:SetText("Add Self");
			QSF_addon.addselfChkBtn.tooltip = "If this is checked, the \"Already On\" listing will include yourself.";
			QSF_addon.addselfChkBtn:SetScript("OnClick",
				function()
					QSF_addon.checkBoxes(QSF_addon.addselfChkBtn:GetChecked(), QuestSpamFilter_SVO, "addself");
					
					if ((QuestSpamFilter_SVO["addself"] == true) and (QSF_addon.alreadyon[1] == nil)) then
						QSF_addon.alreadyon[1] = GetUnitName("player");
					elseif (QSF_addon.alreadyon[1] == GetUnitName("player")) then
						QSF_addon.alreadyon[1] = nil;
					end
				end
			);
			
		-- singleLine - determines whether to start the consolidated list on the same line as its title, or on a new line
			QSF_addon.singleLineChkBtn = CreateFrame("CheckButton", "QSF_addonsingleLine_ChkBtn", QSF_addon.panel, "ChatConfigCheckButtonTemplate");
			QSF_addon.singleLineChkBtn:SetPoint("TOPLEFT", QSF_addon.class["x"]+c[2]["x"], QSF_addon.class["y"]+c[2]["y"]);
			QSF_addonsingleLine_ChkBtnText:SetText("Single Line");
			QSF_addon.singleLineChkBtn.tooltip = "If this is checked, the listings will start on the same line as the title of the group.";
			QSF_addon.singleLineChkBtn:SetScript("OnClick", 
				function() 
					QSF_addon.checkBoxes(QSF_addon.singleLineChkBtn:GetChecked(), QuestSpamFilter_SVO, "singleLine");
					
					if (QuestSpamFilter_SVO["singleLine"] == true) then QuestSpamFilter_SVO["joinchar"] = " ";
					elseif (indented == true) then QuestSpamFilter_SVO["joinchar"] = "\n";
					else QuestSpamFilter_SVO["joinchar"] = "\n   ";
					end
				end
			);
			
		-- colorize - determines whether to color the names of party members as QSF prints them
			QSF_addon.colorizeChkBtn = CreateFrame("CheckButton", "QSF_addoncolorize_ChkBtn", QSF_addon.panel, "ChatConfigCheckButtonTemplate");
			QSF_addon.colorizeChkBtn:SetPoint("TOPLEFT", QSF_addon.class["x"]+c[3]["x"], QSF_addon.class["y"]+c[3]["y"]);
			QSF_addoncolorize_ChkBtnText:SetText("Colorize");
			QSF_addon.colorizeChkBtn.tooltip = "If this is checked, the players will colored by their class.";
			QSF_addon.colorizeChkBtn:SetScript("OnClick", 
				function() 
					QSF_addon.checkBoxes(QSF_addon.colorizeChkBtn:GetChecked(), QuestSpamFilter_SVO, "colorize");
				end
			);
			
	-- Sliders --			
		-- minTime - determines when a buff becomes considered "low time"
			-- minimum = .01
			-- maximum = 3
			QSF_addon.minTime_borderframe = QSF_addon.createBorder(QSF_addon.class["x"]+c[5]["x"], QSF_addon.class["y"]+c[5]["y"], 184, 50);
			
			QSF_addon.minTimeSlider = CreateFrame("Slider", "QSF_addonminTime_Slider", QSF_addon.minTime_borderframe, "OptionsSliderTemplate");
			QSF_addon.minTimeSlider:SetPoint("TOPLEFT", 8, -18);
			QSF_addon.minTimeSlider:SetMinMaxValues(.01, 3);
			QSF_addon.minTimeSlider:SetValueStep(.1);
			QSF_addon.minTimeSlider:SetOrientation("HORIZONTAL");
			QSF_addonminTime_SliderLow:SetText(.01);
			QSF_addonminTime_SliderHigh:SetText(3);
			QSF_addonminTime_SliderText:SetText("Consolidate Time");
			QSF_addon.minTimeSlider.tooltipText = "This slider determines how long to wait to print the consolidated summary. The longer you wait, the more likely you are to filter all the Quest Spam. The less time you wait, the more spam you will get, but the summary will come up quicker. If you find you are still getting spam, increase the time.\nCurrently waiting 1 second.";
			
			QSF_addon.minTimeSliderText = QSF_addon.minTime_borderframe:CreateFontString("QSF_addon.minTimeSliderTextFontString");
			QSF_addon.minTimeSliderText:SetPoint("TOPLEFT", 158, -18);
			QSF_addon.minTimeSliderText:SetFontObject("GameFontNormal");
			QSF_addon.minTimeSliderText:SetText("1");
			
			QSF_addon.minTimeSlider:SetScript("OnValueChanged",
				function ()
					QuestSpamFilter_SVO["minTime"] = floor(QSF_addon.minTimeSlider:GetValue()*10)/10;
					QSF_addon.minTimeSlider.tooltipText = "This slider determines how long to wait to print the consolidated summary. The longer you wait, the more likely you are to filter all the Quest Spam. The less time you wait, the more spam you will get, but the summary will come up quicker. If you find you are still getting spam, increase the time.\nCurrently waiting" .. QuestSpamFilter_SVO["minTime"] .. " second.";
					QSF_addon.minTimeSliderText:SetText(QuestSpamFilter_SVO["minTime"]);
				end
			);


-- Updates the Panel graphics to reflect the actual state of the saved variables
--	It became cumbersome to maintain the Filter of buttons and such per click
function QSF_addon.UpdateGraphics()
		indented = ((DEFAULT_CHAT_FRAME:GetIndentedWordWrap() == 1) or false);

		--  Check Boxes --
			-- addself - determines whether to add yourself to the "Already On" table
				QSF_addon.addselfChkBtn:SetChecked(QuestSpamFilter_SVO["addself"]);
				
			-- singleLine - determines whether to start the consolidated list on the same line as its title, or on a new line
				QSF_addon.singleLineChkBtn:SetChecked(QuestSpamFilter_SVO["singleLine"]);
				
			-- colorize - determines whether to color the names of party members as QSF prints them
				QSF_addon.colorizeChkBtn:SetChecked(QuestSpamFilter_SVO["colorize"]);
				
		-- Sliders --
			-- minTime - determines how large the font used by the warning frame will be
				QSF_addon.minTimeSlider:SetValue(QuestSpamFilter_SVO["minTime"]);
end


-- Register VARIABLES_LOADED so the options are initialized properly
QSF_addon.frame:RegisterEvent("VARIABLES_LOADED");
QSF_addon.frame:SetScript("OnEvent", QSF_addon.UpdateGraphics);

