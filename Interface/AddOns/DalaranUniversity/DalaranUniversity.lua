
DalaranUniversity.NoSpawnTimeTab = {
-- values in minutes, when book cannot spawn
--  0  equals  last book spawn + 180 minutes
		{ -181 ,    0 }
-- considering the fact that the books are only despawnig 3 minutes after beeing read
--  and afterwards the 180 minutes canot spawn interval is startet:
-- On less populated servers with few book readers, only the 1. interval is a sure cannot spawn
--  (in developement in Wotlk, there were hundreds of book readers in Dalaran.
--   back then the books were read instantly after spawning and following intervals were correct)
, {   63 ,  183 }
, {  306 ,  366 }
, {  549 ,  549 }
};

DalaranUniversity.SpawnPossibleIntervall = function (diff)
-- "diff" in seconds
-- return[0]    the i'th NoSpawn interval, or the -i'th Spawn interval or -99 (unknown)
-- return[1..2] (no)SpawnIntervall time in minutes, relative to (last book spawn + 180 minutes)
--  return[1]   (no)SpawnIntervall Start
--  return[2]   (no)SpawnIntervall End
--  return[3]   given Difference "diff" in minutes
	local ret = -99;
	local retA = 0;
	local retB = 1;
	local retDiff = 1;
	local LastEndIntervall = DalaranUniversity.NoSpawnTimeTab[1][1] - 1 ;
	local diffMin = diff / 60;
	for i,arr in ipairs(DalaranUniversity.NoSpawnTimeTab) do
		--NoSpawnPossible
		if (arr[1] < diffMin and diffMin < arr[2]) then
			ret = i;
			retA = arr[1];
			retB = arr[2];
			retDiff = diffMin;
		end;
		if (LastEndIntervall <= diffMin and diffMin <= arr[1]) then
		--SpawnPossible between NoSpawnPossibleIntervall's
			retA = LastEndIntervall;
			retB = arr[1];
			retDiff = diffMin;
		end;
		LastEndIntervall = arr[2]
	end;
	return ret, retA, retB, retDiff;
end;


DalaranUniversity.Enums = {
	SPAWNEDAT = 1;
	SPAWNSAT = 2;
	
	AM = 1;
	PM = 2;
};
DalaranUniversity.Bars = {};
DalaranUniversity.Settings = {
	Spawn = DalaranUniversity.Enums.SPAWNEDAT;
	AMPM = DalaranUniversity.Enums.AM;
	Book = "";
	VersionNoticeShown = false;
};
DalaranUniversity_SavedSettings = {
	Window = {
		Hidden = false;
		Locked = false;
	};
	Muted = false;
	UseHL = true;
};

DalaranUniversity.VersionNotice = function()
	if (not DalaranUniversity.Settings.VersionNoticeShown) then
		DalaranUniversity.Settings.VersionNoticeShown = true;
		DEFAULT_CHAT_FRAME:AddMessage(DalaranUniversity.Translation.OutOfDate[1]);
		DEFAULT_CHAT_FRAME:AddMessage(DalaranUniversity.Translation.OutOfDate[2].." "..GetAddOnMetadata("DalaranUniversity", "Version"));
		DEFAULT_CHAT_FRAME:AddMessage(DalaranUniversity.Translation.OutOfDate[3].." "..DalaranUniversity.LatestVersion);
	end;
end;

DalaranUniversity.SetTime = {
	Button = {
		Set = {
			OnClick = function(self)
				local book = UIDropDownMenu_GetText(DalaranUniversity_SetTime_Book_DropDown);
				local utc = time(date("!*t"));
				local sd = date("!*t");
				sd.hour = tonumber(DalaranUniversity_SetTime_Hours:GetText());
				if (DalaranUniversity.Settings.AMPM == DalaranUniversity.Enums.PM and
					sd.hour ~= 12) then
					sd = date("*t", time(sd) + (12 * 60 * 60));
				elseif (DalaranUniversity.Settings.AMPM == DalaranUniversity.Enums.AM and
						sd.hour == 12) then
					sd = date("*t", time(sd) - (12 * 60 * 60));
				end;
				sd.min = tonumber(DalaranUniversity_SetTime_Minutes:GetText());
				if (difftime(time(sd), utc) < -(12 * 60 * 60)) then
					sd = date("*t", time(sd) + (24 * 60 * 60));
				elseif (difftime(time(sd), utc) > (12 * 60 * 60)) then
					sd = date("*t", time(sd) - (24 * 60 * 60));
				end;
				
				if (DalaranUniversity.Settings.Spawn == DalaranUniversity.Enums.SPAWNEDAT) then
					sd = date("*t", time(sd) + (3 * 60 * 60));
				end;

				if (HigherLearning_setTime ~= nil) then
					HigherLearning_setTime(book, format("%02d", sd.hour)..":"..format("%02d", sd.min));
					HigherLearning_triggerFrameRefresh();
				else
					DalaranUniversity.Bars[book].sd = date("*t", time(sd));
				end;
				DalaranUniversity.Antenna:SendPrioritizedCommMessage("BULK", "GLOBAL", "book", book, time(sd));

				self:GetParent():Hide();
			end;
		};
	};

	OnShow = function(self)
		local utc = time(date("!*t"));
		local sd = nil;
		local gd = date("!*t");
		gd.hour, gd.min = GetGameTime();
		if (difftime(time(gd), utc) < -(12 * 60 * 60)) then
			gd = date("*t", time(gd) + (24 * 60 * 60));
		elseif (difftime(time(gd), utc) > (12 * 60 * 60)) then
			gd = date("*t", time(gd) - (24 * 60 * 60));
		end;

		if (DalaranUniversity.Settings.Spawn == DalaranUniversity.Enums.SPAWNEDAT) then
			sd = date("*t", time(gd));
		else
			sd = date("*t", time(gd) + (3 * 60 * 60));
		end;

		DalaranUniversity_SetTime_Hours:SetText(date("%I", time(sd)));
		DalaranUniversity_SetTime_Minutes:SetText(date("%M", time(sd)));
		if (sd.hour < 12) then
			DalaranUniversity.Settings.AMPM = DalaranUniversity.Enums.AM;
			UIDropDownMenu_SetText(DalaranUniversity_SetTime_AMPM_DropDown, DalaranUniversity.Translation.Time.AM);
		else
			DalaranUniversity.Settings.AMPM = DalaranUniversity.Enums.PM;
			UIDropDownMenu_SetText(DalaranUniversity_SetTime_AMPM_DropDown, DalaranUniversity.Translation.Time.PM);
		end;

		DalaranUniversity_SetTime_Hours:SetFocus();
	end;

	OnLoad = function(self)
		local width = 0;
		local v = nil;

		UIDropDownMenu_Initialize(DalaranUniversity_SetTime_Spawn_DropDown, DalaranUniversity.SetTime.Spawn.DropDown.Initialize);

		DalaranUniversity_SetTime_DummyText:SetText(DalaranUniversity.Translation.SpawnedAt);
		width = DalaranUniversity_SetTime_DummyText:GetWidth();
		DalaranUniversity_SetTime_DummyText:SetText(DalaranUniversity.Translation.SpawnsAt);
		if (width < DalaranUniversity_SetTime_DummyText:GetWidth()) then
			width = DalaranUniversity_SetTime_DummyText:GetWidth();
		end;
		UIDropDownMenu_SetWidth(DalaranUniversity_SetTime_Spawn_DropDown, width + 20, 40);

		UIDropDownMenu_Initialize(DalaranUniversity_SetTime_AMPM_DropDown, DalaranUniversity.SetTime.AMPM.DropDown.Initialize);

		DalaranUniversity_SetTime_DummyText:SetText(DalaranUniversity.Translation.Time.AM);
		width = DalaranUniversity_SetTime_DummyText:GetWidth();
		DalaranUniversity_SetTime_DummyText:SetText(DalaranUniversity.Translation.Time.PM);
		if (width < DalaranUniversity_SetTime_DummyText:GetWidth()) then
			width = DalaranUniversity_SetTime_DummyText:GetWidth();
		end;
		UIDropDownMenu_SetWidth(DalaranUniversity_SetTime_AMPM_DropDown, width + 20, 40);

		UIDropDownMenu_Initialize(DalaranUniversity_SetTime_Book_DropDown, DalaranUniversity.SetTime.Book.DropDown.Initialize);

		width = 0;
		for _, v in pairs(DalaranUniversity.Translation.BarIds) do
			DalaranUniversity_SetTime_DummyText:SetText(v);
			if (width < DalaranUniversity_SetTime_DummyText:GetWidth()) then
				width = DalaranUniversity_SetTime_DummyText:GetWidth();
			end;
		end;
		UIDropDownMenu_SetWidth(DalaranUniversity_SetTime_Book_DropDown, width + 20, 40);

		DalaranUniversity_SetTime_Spawn_DropDown:SetPoint("LEFT", "DalaranUniversity_SetTime_Book_DropDown", "LEFT", DalaranUniversity_SetTime_Book_DropDown:GetWidth() - 20, 0);
		DalaranUniversity_SetTime_TimeSeparator:SetPoint("LEFT", "DalaranUniversity_SetTime_Hours", "RIGHT");
	end;

	Spawn = {
		DropDown = {
			Initialize = function(self)
				local info = UIDropDownMenu_CreateInfo();
				
				info.value = 1;
				info.text = DalaranUniversity.Translation.SpawnedAt;
				info.func = DalaranUniversity.SetTime.Spawn.DropDown.SpawnedAt;
				if (DalaranUniversity.Settings.Spawn == DalaranUniversity.Enums.SPAWNEDAT) then
					UIDropDownMenu_SetText(DalaranUniversity_SetTime_Spawn_DropDown, info.text);
				end;
				UIDropDownMenu_AddButton(info);
				
				info.value = 2;
				info.text = DalaranUniversity.Translation.SpawnsAt;
				info.func = DalaranUniversity.SetTime.Spawn.DropDown.SpawnsAt;
				if (DalaranUniversity.Settings.Spawn == DalaranUniversity.Enums.SPAWNSAT) then
					UIDropDownMenu_SetText(DalaranUniversity_SetTime_Spawn_DropDown, info.text);
				end;
				UIDropDownMenu_AddButton(info);
			end;

			SpawnedAt = function()
				local utc = time(date("!*t"));
				local gd = date("!*t");
				gd.hour, gd.min = GetGameTime();
				if (difftime(time(gd), utc) < -(12 * 60 * 60)) then
					gd = date("*t", time(gd) + (24 * 60 * 60));
				elseif (difftime(time(gd), utc) > (12 * 60 * 60)) then
					gd = date("*t", time(gd) - (24 * 60 * 60));
				end;

				DalaranUniversity.Settings.Spawn = DalaranUniversity.Enums.SPAWNEDAT;
				UIDropDownMenu_SetText(DalaranUniversity_SetTime_Spawn_DropDown, DalaranUniversity.Translation.SpawnedAt);
				DalaranUniversity_SetTime_Hours:SetText(date("%I", time(gd)));
				DalaranUniversity_SetTime_Minutes:SetText(date("%M", time(gd)));
				if (gd.hour < 12) then
					DalaranUniversity.Settings.AMPM = DalaranUniversity.Enums.AM;
					UIDropDownMenu_SetText(DalaranUniversity_SetTime_AMPM_DropDown, DalaranUniversity.Translation.Time.AM);
				else
					DalaranUniversity.Settings.AMPM = DalaranUniversity.Enums.PM;
					UIDropDownMenu_SetText(DalaranUniversity_SetTime_AMPM_DropDown, DalaranUniversity.Translation.Time.PM);
				end;
			end;

			SpawnsAt = function()
				local utc = time(date("!*t"));
				local gd = date("!*t");
				gd.hour, gd.min = GetGameTime();
				if (difftime(time(gd), utc) < -(12 * 60 * 60)) then
					gd = date("*t", time(gd) + (24 * 60 * 60));
				elseif (difftime(time(gd), utc) > (12 * 60 * 60)) then
					gd = date("*t", time(gd) - (24 * 60 * 60));
				end;
				local sd = date("*t", time(gd) + (3 * 60 * 60));

				DalaranUniversity.Settings.Spawn = DalaranUniversity.Enums.SPAWNSAT;
				UIDropDownMenu_SetText(DalaranUniversity_SetTime_Spawn_DropDown, DalaranUniversity.Translation.SpawnsAt);
				DalaranUniversity_SetTime_Hours:SetText(date("%I", time(sd)));
				DalaranUniversity_SetTime_Minutes:SetText(date("%M", time(sd)));
				if (sd.hour < 12) then
					DalaranUniversity.Settings.AMPM = DalaranUniversity.Enums.AM;
					UIDropDownMenu_SetText(DalaranUniversity_SetTime_AMPM_DropDown, DalaranUniversity.Translation.Time.AM);
				else
					DalaranUniversity.Settings.AMPM = DalaranUniversity.Enums.PM;
					UIDropDownMenu_SetText(DalaranUniversity_SetTime_AMPM_DropDown, DalaranUniversity.Translation.Time.PM);
				end;
			end;
		};
	};

	AMPM = {
		DropDown = {
			Initialize = function(self)
				local info = UIDropDownMenu_CreateInfo();
				
				info.value = 1;
				info.text = DalaranUniversity.Translation.Time.AM;
				info.func = DalaranUniversity.SetTime.AMPM.DropDown.AM;
				UIDropDownMenu_AddButton(info);
				
				info.value = 2;
				info.text = DalaranUniversity.Translation.Time.PM;
				info.func = DalaranUniversity.SetTime.AMPM.DropDown.PM;
				UIDropDownMenu_AddButton(info);
			end;

			AM = function()
				DalaranUniversity.Settings.AMPM = DalaranUniversity.Enums.AM;
				UIDropDownMenu_SetText(DalaranUniversity_SetTime_AMPM_DropDown, DalaranUniversity.Translation.Time.AM);
			end;

			PM = function()
				DalaranUniversity.Settings.AMPM = DalaranUniversity.Enums.PM;
				UIDropDownMenu_SetText(DalaranUniversity_SetTime_AMPM_DropDown, DalaranUniversity.Translation.Time.PM);
			end;
		};
	};

	Book = {
		DropDown = {
			Initialize = function(self)
				local i = nil;
				local v = nil;
				local info = UIDropDownMenu_CreateInfo();

				i = 1;
				for _, v in pairs(DalaranUniversity.Translation.BarIds) do
					info.value = i;
					info.text = v;
					info.func = function()
						DalaranUniversity.Settings.Book = v;
						UIDropDownMenu_SetText(DalaranUniversity_SetTime_Book_DropDown, v);
					end;
					UIDropDownMenu_AddButton(info);
					if (DalaranUniversity.Settings.Book  == info.text or
						DalaranUniversity.Settings.Book == nil) then
						DalaranUniversity.Settings.Book = info.text;
						UIDropDownMenu_SetText(DalaranUniversity_SetTime_Book_DropDown, info.text);
					end
					i = i + 1;
				end;
			end;
		};
	};
};

DalaranUniversity.Command = function(args)
	local command = string.gsub(args, "^(%w+) (.*)", "%1");
	local commandargs = string.gsub(args, "^(%w+) (.*)", "%2");

	if (DalaranUniversity.Commands[command] ~= nil) then
		DalaranUniversity.Commands[command](commandargs);
	end
end

DalaranUniversity.Commands = {
	show = function(args)
		DalaranUniversity_Main:Show();
		DalaranUniversity_SavedSettings.Window.Hidden = false;
	end
}

DalaranUniversity.Main = {
	Timers = {};

	OnLoad = function(self)
		SlashCmdList["DALARANUNIVERSITY"] = DalaranUniversity.Command;
		self:RegisterEvent("ADDON_LOADED");
		self:RegisterEvent("ITEM_TEXT_BEGIN");
		self:RegisterEvent("PLAYER_ENTERING_WORLD");
		self:RegisterEvent("PLAYER_LEAVING_WORLD");
	end;
	
	OnUpdate = function(self)
		local t = nil;
		local func = nil;
		local i = 0;
		local bar = nil;
		local iBars = {};

		for t, func in pairs(DalaranUniversity.Main.Timers) do
			if (time() >= t) then
				func();
				DalaranUniversity.Main.Timers[t] = nil;
			end;
		end;

		i = 1;
		for _, bar in pairs(DalaranUniversity.Bars) do
			iBars[i] = bar;
			i = i + 1;
		end;
		table.sort(iBars, DalaranUniversity.Main.Bar.Sort);
		for i, bar in ipairs(iBars) do
			bar:SetPoint("TOP", DalaranUniversity_Main, "TOP", 0, -10 - (i * 20));
		end;
	end;

	OnMouseUp = function(self, button)
		local x, y = GetCursorPosition();

		if (button == "RightButton") then
			ToggleDropDownMenu(1, nil, DalaranUniversity_Main_DropDown, UIParent, x / UIParent:GetEffectiveScale(), y / UIParent:GetEffectiveScale());
		end;
	end;
	
	Events = {
		ADDON_LOADED = function(name)
			if (name == "DalaranUniversity") then
				if (DalaranUniversity_SavedSettings.Window.Hidden) then
					DalaranUniversity_Main:Hide();
				end;
				if (DalaranUniversity_SavedSettings.Muted) then
					DalaranUniversity_Main_MuteButton:SetNormalTexture("Interface\\Buttons\\UI-GroupLoot-Pass-UP");
				end;
			end;
		end;

		ITEM_TEXT_BEGIN = function()
			local i = 0;
			local message = "";
			local book = nil;
			local title = nil;
			local utc = time(date("!*t"));
			local gd = date("!*t");
			gd.hour, gd.min = GetGameTime();
			if (difftime(time(gd), utc) < -(12 * 60 * 60)) then
				gd = date("*t", time(gd) + (24 * 60 * 60));
			elseif (difftime(time(gd), utc) > (12 * 60 * 60)) then
				gd = date("*t", time(gd) - (24 * 60 * 60));
			end;
			local sd = date("*t", time(gd) + (3 * 60 * 60));

			for book in pairs(DalaranUniversity.Translation.Books) do
				for i, title in ipairs(DalaranUniversity.Translation.Books[book]) do
					if (ItemTextGetItem() == title) then
						if (HigherLearning_setTime ~= nil) then
							HigherLearning_setTime(book, format("%02d", sd.hour)..":"..format("%02d", sd.min));
							HigherLearning_triggerFrameRefresh();
						else
							DalaranUniversity.Bars[book].sd = date("*t", time(sd));
						end;
						if (i == 1) then
							message = "realbook";
						else
							message = "fakebook";
						end;
						DalaranUniversity.Antenna:SendPrioritizedCommMessage("BULK", "GLOBAL", message, book, time(sd));
					end;
				end;
			end;
		end;

		PLAYER_ENTERING_WORLD = function()
			DalaranUniversity.Main.Timers[time() + 10] = function()DalaranUniversity.Antenna:SendPrioritizedCommMessage("BULK", "GLOBAL", "sync", GetAddOnMetadata("DalaranUniversity", "Version"));end;
		end;

		PLAYER_LEAVING_WORLD = function()
			local bookName = nil;
			local bar = nil;

			for _, bookName in pairs(DalaranUniversity.Translation.BarIds) do
				bar = DalaranUniversity.Bars[bookName];
				if (bar.Watched[UnitName("player")] ~= nil) then
					DalaranUniversity.Antenna:SendPrioritizedCommMessage("BULK", "GLOBAL", "notwatched", bar.id);
				end;
			end;
		end;
	};

	DropDown = {
		Initialize = function()
			local info = UIDropDownMenu_CreateInfo();

			info.value = 1;
			info.text = DalaranUniversity.Translation.RequestSync;
			info.func = DalaranUniversity.Main.DropDown.RequestSync.OnClick;
			UIDropDownMenu_AddButton(info);

			info.value = 2;
			info.text = DalaranUniversity.Translation.ResetAll;
			info.func = DalaranUniversity.Main.DropDown.ResetAll.OnClick;
			UIDropDownMenu_AddButton(info);
		end;

		RequestSync = {
			OnClick = function()
				DalaranUniversity.Antenna:SendPrioritizedCommMessage("BULK", "GLOBAL", "sync", GetAddOnMetadata("DalaranUniversity", "Version"));
			end;
		};

		ResetAll = {
			OnClick = function()
				local bookName = nil;

				if (HigherLearning_getTime ~= nil) then
					for _, bookName in pairs(DalaranUniversity.Translation.BarIds) do
						local book = HigherLearning_getTime(bookName);
						book.hours = nil;
						book.minutes = nil;
					end;
					HigherLearning_triggerFrameRefresh();
				else
					for _, bookName in pairs(DalaranUniversity.Translation.BarIds) do
						DalaranUniversity.Bars[bookName].sd = nil;
					end;
				end;
			end;
		};
	};

	Bar = {
		OnLoad = function(self)
			local v = nil;

			self.Watched = {};
			self.SeenBy = {};
			self.id = DalaranUniversity.Translation.BarIds[string.gsub(self:GetName(), ".*_", "")];
			DalaranUniversity.Bars[self.id] = self;
			getglobal(self:GetName().."_Text"):SetText(DalaranUniversity.Translation.BarNames[self.id].." / "..DalaranUniversity.Translation.BarIds[self.id]);
			if (HigherLearning_timerT ~= nil) then
				for _, v in pairs(HigherLearning_timerT) do
					if (v.location == self.id) then
						self.hl = v;
					end;
				end;
			end;
		end;

		OnUpdate = function(self)
			local n = nil;
			local t = nil;
			local completed = false;
			local minutes = 0;
			local tiptext = "";
			local utc = time(date("!*t"));
			local gd = date("!*t");
			gd.hour, gd.min = GetGameTime();
			if (difftime(time(gd), utc) < -(12 * 60 * 60)) then
				gd = date("*t", time(gd) + (24 * 60 * 60));
			elseif (difftime(time(gd), utc) > (12 * 60 * 60)) then
				gd = date("*t", time(gd) - (24 * 60 * 60));
			end;
			local sd = nil;
			local px, py = GetPlayerMapPosition("player");
			px = px * 100;
			py = py * 100;

			if (math.sqrt(math.pow(DalaranUniversity.Translation.Locations[self.id].X - px, 2) + math.pow(DalaranUniversity.Translation.Locations[self.id].Y - py, 2)) < 1.1) then
				if (self.Watched[UnitName("player")] == nil) then
					self.Watched[UnitName("player")] = time(gd);
					DalaranUniversity.Antenna:SendPrioritizedCommMessage("BULK", "GLOBAL", "watched", self.id);
				elseif (self.Watched[UnitName("player")] >= time(gd) + 30) then
					self.Watched[UnitName("player")] = time(gd);
					DalaranUniversity.Antenna:SendPrioritizedCommMessage("BULK", "GLOBAL", "watched", self.id);
				end;
				if (self.SeenBy[UnitName("player")] == nil) then
					self.SeenBy[UnitName("player")] = {};
					self.SeenBy[UnitName("player")][1] = time();
					self.SeenBy[UnitName("player")][2] = time();
					--					DalaranUniversity.Antenna:SendPrioritizedCommMessage("BULK", "GLOBAL", "watched", self.id);
				elseif (self.SeenBy[UnitName("player")][2] >= time() + 30) then
					self.SeenBy[UnitName("player")][2] = time();
					--					DalaranUniversity.Antenna:SendPrioritizedCommMessage("BULK", "GLOBAL", "watched", self.id);
				end;
			else
				if (self.Watched[UnitName("player")] ~= nil) then
					DalaranUniversity.Antenna:SendPrioritizedCommMessage("BULK", "GLOBAL", "notwatched", self.id);
					self.Watched[UnitName("player")] = nil;
				end;
				if (    (self.SeenBy[UnitName("player")] ~= nil) 
					and (self.SeenBy[UnitName("player")][2] >= time() + 120 )
				) then
					self.SeenBy[UnitName("player")] = nil;
				end;
			end;
			if (self.sd ~= nil) then
				sd = date("*t", time(self.sd));
			end;
			if (self.hl ~= nil) then
				if (self.hl.hours ~= nil and
					self.hl.minutes ~= nil and
					DalaranUniversity_SavedSettings.UseHL) then
					sd = date("*t", time(gd));
					sd.hour = self.hl.hours;
					sd.min = self.hl.minutes;
					if (difftime(time(sd), utc) < -(12 * 60 * 60)) then
						sd = date("*t", time(sd) + (24 * 60 * 60));
					elseif (difftime(time(sd), utc) > (12 * 60 * 60)) then
						sd = date("*t", time(sd) - (24 * 60 * 60));
					end;
				end;
			end;
			local nsp = false;
			if (sd ~= nil) then
				local dtGdSd = difftime(time(gd), time(sd));
				local nspI, siA, siB, siDiff = DalaranUniversity.SpawnPossibleIntervall(dtGdSd);
				self:SetMinMaxValues(siA, siB);
				self:SetValue( math.max( siDiff, (siA + (siB-siA) * 20 / 100) ) );
				-- show at least a 20% bar, too see the color; instead of:
				--self:SetValue(siDiff);
				if (nspI == 1) then
					--NoSpawnPossible 1
					self:SetStatusBarColor(0.0, 0.8, 0.0, 1.0);
				elseif (nspI > 1) then
					--NoSpawnPossible following
					self:SetStatusBarColor(0.6, 0.4, 0.0, 1.0);
				else
					--SpawnPossible
					self:SetStatusBarColor(0.8, 0.0, 0.0, 1.0);
					for n, t in pairs(self.Watched) do
						if   (time() <= t + (3 * 60))
							--and ( nspI < 1 )
						then
							self:SetStatusBarColor(0.8, 0.8, 0.0, 1.0);
						end;
					end;
				end;
			else
				self:SetMinMaxValues(0, 1);
				self:SetValue(1);
				self:SetStatusBarColor(0.8, 0.0, 0.0, 1.0);
				for n, t in pairs(self.Watched) do
					if   (time() <= t + (3 * 60))
						--and ( nspI < 1 )
					then
						self:SetStatusBarColor(0.8, 0.8, 0.0, 1.0);
					end;
				end;
			end;
			
			_, _, completed = GetAchievementCriteriaInfo(DalaranUniversity.Translation.Achievements[self.id]);
			if (completed) then
				getglobal(self:GetName().."_Text"):SetTextColor(0.6, 0.8, 1.0, 1.0);
			else
				getglobal(self:GetName().."_Text"):SetTextColor(1.0, 1.0, 1.0, 1.0);
			end;
		end;

		OnEnter = function(self)
			local x, y = GetCursorPosition();
			local n = nil;
			local t = nil;
			local hours = 0;
			local minutes = 0;
			local tiptext = "";
			local utc = time(date("!*t"));
			local gd = date("!*t");
			gd.hour, gd.min = GetGameTime();
			if (difftime(time(gd), utc) < -(12 * 60 * 60)) then
				gd = date("*t", time(gd) + (24 * 60 * 60));
			elseif (difftime(time(gd), utc) > (12 * 60 * 60)) then
				gd = date("*t", time(gd) - (24 * 60 * 60));
			end;
			local sd = nil;

			if (self.sd ~= nil) then
				sd = date("*t", time(self.sd));
			end;
			if (self.hl ~= nil) then
				if (self.hl.hours ~= nil
					and self.hl.minutes ~= nil
					and DalaranUniversity_SavedSettings.UseHL)
				then
					sd = date("*t", time(gd));
					sd.hour = self.hl.hours;
					sd.min = self.hl.minutes;
					if (difftime(time(sd), utc) < -(12 * 60 * 60)) then
						sd = date("*t", time(sd) + (24 * 60 * 60));
					elseif (difftime(time(sd), utc) > (12 * 60 * 60)) then
						sd = date("*t", time(sd) - (24 * 60 * 60));
					end;
				end;
			end;
			if (sd == nil) then
				tiptext = self.id.." --:--  spawn time unknown\n"
														.."\nThis book will spawn any time in the next 4 hours.";
			else
				tiptext = self.id.." "..format("%02d", sd.hour)..":"..format("%02d", sd.min).."\n";
				local dtGdSd = difftime(time(gd), time(sd));
				local nspI, siA, siB, siDiff = DalaranUniversity.SpawnPossibleIntervall(dtGdSd);
				if (nspI == 1) then
					--NoSpawnPossible 1
					tiptext = tiptext.."\nThis book cannot spawn in the next "..(siB - siDiff ).." minutes."
																						.."\n "..nspI..". cannot spawn intervall";
				elseif (nspI > 1) then
					--NoSpawnPossible following
					tiptext = tiptext.."\nThis book will not spawn in the next "..(siB - siDiff ).." minutes,"
																						.."\nif somebody read it, as soon as it had spawned in between."
																						.."\nOn less populated servers, it will spawn any time in the next 4 hours."
																						.."\n "..nspI..". should not spawn intervall";
				else
					if   (siA == 0)
						and (siB == 1)
					then
						tiptext = tiptext.."\nThis book will spawn any time in the next 4 hours.";
					elseif (nspI == -1) then
						tiptext = tiptext.."\nThis book will spawn in the next "..(siB - siDiff + 1).." minutes,"
																							.."\n if it hadn't spawnd and been read in the last  "..(siDiff - siA + 1).." minutes."
																							.."\n ".. (-1) * nspI ..". can spawn intervall";
					else
						tiptext = tiptext.."\nThis book will spawn in the next "..(siB - siDiff + 1).." minutes,"
																							.."\n if it hadn't spawnd and been read in the last  "..(siDiff - siA + 1).." minutes."
																							.."\nif somebody read it, as soon as it had spawned in between."
																							.."\nOn less populated servers, it will spawn any time in the next 4 hours."
																							.."\n ".. (-1) * nspI ..". can spawn intervall";
					end;
				end;
				tiptext = tiptext.."\n Minute "..siDiff.." of interval ".. nspI .."("..siA..";"..siB..")";
						--"intervall lenght "..(siB-siA).." minutes";
			end;
			tiptext = tiptext.."\n";
			for n, t in pairs(self.Watched) do
				local dtWt = difftime( time(), t ) + 3600 ;
				if (dtWt <= (4 * 60 * 60)) then
					tiptext = tiptext.."\n"..DalaranUniversity.Translation.WatchedBy.." "..n.." since "..dtWt.." seconds.";
				end;
			end;
			if (tiptext ~= "") then
				GameTooltip:SetOwner(self, "ANCHOR_NONE");
				GameTooltip:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMLEFT", x / UIParent:GetEffectiveScale(), y / UIParent:GetEffectiveScale());
				GameTooltip:ClearLines();
				GameTooltip:SetText(tiptext);
				GameTooltip:Show();
			end;
		end;

		OnLeave = function(self)
			GameTooltip:Hide();
		end;

		OnMouseUp = function(self, button)
			local x, y = GetCursorPosition();

			if (button == "RightButton") then
				DalaranUniversity.Settings.Book = self.id;
				UIDropDownMenu_SetText(DalaranUniversity_SetTime_Book_DropDown, self.id);
				ToggleDropDownMenu(1, nil, DalaranUniversity_Main_Bar_DropDown, UIParent, x / UIParent:GetEffectiveScale(), y / UIParent:GetEffectiveScale());
			end;
		end;

		DropDown = {
			Initialize = function()
				local info = UIDropDownMenu_CreateInfo();

				info.value = 1;
				info.text = DalaranUniversity.Translation.SetBookTimeFor.." "..DalaranUniversity.Settings.Book;
				info.func = DalaranUniversity.Main.Bar.DropDown.SetBookTime.OnClick;
				UIDropDownMenu_AddButton(info);

				info.value = 2;
				info.text = DalaranUniversity.Translation.ResetBookTimeFor.." "..DalaranUniversity.Settings.Book;
				info.func = DalaranUniversity.Main.Bar.DropDown.ResetBookTime.OnClick;
				UIDropDownMenu_AddButton(info);
			end;

			SetBookTime = {
				OnClick = function()
					DalaranUniversity_SetTime:Show();
				end;
			};

			ResetBookTime = {
				OnClick = function()
					if (HigherLearning_getTime ~= nil) then
						local book = HigherLearning_getTime(DalaranUniversity.Settings.Book);
						book.hours = nil;
						book.minutes = nil;
						HigherLearning_triggerFrameRefresh();
					else
						DalaranUniversity.Bars[DalaranUniversity.Settings.Book].sd = nil;
					end;
					DalaranUniversity.Antenna:SendPrioritizedCommMessage("BULK", "GLOBAL", "book", DalaranUniversity.Settings.Book, "reset");
				end;
			};
		};

		Sort = function(a, b)
			local utc = time(date("!*t"));
			local gd = date("!*t");
			gd.hour, gd.min = GetGameTime();
			if (difftime(time(gd), utc) < -(12 * 60 * 60)) then
				gd = date("*t", time(gd) + (24 * 60 * 60));
			elseif (difftime(time(gd), utc) > (12 * 60 * 60)) then
				gd = date("*t", time(gd) - (24 * 60 * 60));
			end;
			local sd1 = nil;
			local sd2 = nil;

			if (a.sd ~= nil) then
				sd1 = date("*t", time(a.sd));
			end;
			if (a.hl ~= nil) then
				if (a.hl.hours ~= nil and
					a.hl.minutes ~= nil and
					DalaranUniversity_SavedSettings.UseHL) then
					sd1 = date("*t", time(gd));
					sd1.hour = a.hl.hours;
					sd1.min = a.hl.minutes;
					if (difftime(time(sd1), utc) < -(12 * 60 * 60)) then
						sd1 = date("*t", time(sd1) + (24 * 60 * 60));
					elseif (difftime(time(sd1), utc) > (12 * 60 * 60)) then
						sd1 = date("*t", time(sd1) - (24 * 60 * 60));
					end;
				end;
			end;

			if (b.sd ~= nil) then
				sd2 = date("*t", time(b.sd));
			end;
			if (b.hl ~= nil) then
				if (b.hl.hours ~= nil and
					b.hl.minutes ~= nil and
					DalaranUniversity_SavedSettings.UseHL) then
					sd2 = date("*t", time(gd));
					sd2.hour = b.hl.hours;
					sd2.min = b.hl.minutes;
					if (difftime(time(sd2), utc) < -(12 * 60 * 60)) then
						sd2 = date("*t", time(sd2) + (24 * 60 * 60));
					elseif (difftime(time(sd2), utc) > (12 * 60 * 60)) then
						sd2 = date("*t", time(sd2) - (24 * 60 * 60));
					end;
				end;
			end;

			if (sd1 ~= nil and sd2 ~= nil) then
				return time(sd1) < time(sd2);
			elseif (sd1 ~= nil) then
				return true;
			else
				return false;
			end;
		end;
	};

	Button = {
		Close = {
			OnClick = function(self)
				self:GetParent():Hide();
				DalaranUniversity_SavedSettings.Window.Hidden = true;
			end;
		};

		Mute = {
			OnClick = function(self)
				local x, y = GetCursorPosition();

				GameTooltip:SetOwner(self, "ANCHOR_NONE");
				GameTooltip:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMLEFT", x / UIParent:GetEffectiveScale(), y / UIParent:GetEffectiveScale());
				GameTooltip:ClearLines();
				if (not DalaranUniversity_SavedSettings.Muted) then
					DalaranUniversity_SavedSettings.Muted = true;
					DalaranUniversity_Main_MuteButton:SetNormalTexture("Interface\\Buttons\\UI-GroupLoot-Pass-UP");
					GameTooltip:SetText(DalaranUniversity.Translation.Unmute);
				else
					DalaranUniversity_SavedSettings.Muted = false;
					DalaranUniversity_Main_MuteButton:SetNormalTexture("Interface\\Buttons\\UI-GuildButton-MOTD-Up");
					GameTooltip:SetText(DalaranUniversity.Translation.Mute);
				end;
				GameTooltip:Show();
			end;

			OnEnter = function(self)
				local x, y = GetCursorPosition();

				GameTooltip:SetOwner(self, "ANCHOR_NONE");
				GameTooltip:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMLEFT", x / UIParent:GetEffectiveScale(), y / UIParent:GetEffectiveScale());
				GameTooltip:ClearLines();
				if (not DalaranUniversity_SavedSettings.Muted) then
					GameTooltip:SetText(DalaranUniversity.Translation.Mute);
				else
					GameTooltip:SetText(DalaranUniversity.Translation.Unmute);
				end;
				GameTooltip:Show();
			end;

			OnLeave = function(self)
				GameTooltip:Hide();
			end;
		}
	};
};
function DalaranUniversity_OnEvent(self, event, ...)
	if (DalaranUniversity.Main.Events[event] ~= nil) then
		DalaranUniversity.Main.Events[event](...);
	end;
end;

-- --[[ rm
DalaranUniversity.Antenna = AceLibrary("AceAddon-2.0"):new("AceComm-2.0");
DalaranUniversity.Antenna.commPrefix = "DalaranUniversity";
function DalaranUniversity.Antenna:OnEnable()
	DalaranUniversity.Antenna:SetCommPrefix(DalaranUniversity.Antenna.commPrefix);
	self:RegisterComm(DalaranUniversity.Antenna.commPrefix, "GLOBAL", DalaranUniversity.Antenna.OnCommReceive);
	self:RegisterComm(DalaranUniversity.Antenna.commPrefix, "WHISPER", DalaranUniversity.Antenna.OnCommReceive);
end;
DalaranUniversity.Antenna.Commands = {
	book = function(sender, book, spawndate)
		local utc = time(date("!*t"));
		local sd = nil;
		local gd = date("!*t");
		gd.hour, gd.min = GetGameTime();
		if (difftime(time(gd), utc) < -(12 * 60 * 60)) then
			gd = date("*t", time(gd) + (24 * 60 * 60));
		elseif (difftime(time(gd), utc) > (12 * 60 * 60)) then
			gd = date("*t", time(gd) - (24 * 60 * 60));
		end;

		if (spawndate == "reset") then
			--[[if (HigherLearning_getTime ~= nil) then
				local book = HigherLearning_getTime(book);
				book.hours = nil;
				book.minutes = nil;
				HigherLearning_triggerFrameRefresh();
			else
				DalaranUniversity.Bars[book].sd = nil;
			end;]]
		else
			sd = date("*t", spawndate);
			if ((difftime(time(sd), time(gd)) <= ((3 * 60 * 60) + (5 * 60)) and
					difftime(time(sd), time(gd)) > 0) or
				(difftime(time(gd), time(sd)) <= ((1 * 60 * 60) + (5 * 60)) and
					difftime(time(gd), time(sd)) >= 0)) then
				if (HigherLearning_setTime ~= nil) then
					HigherLearning_setTime(book, format("%02d", sd.hour)..":"..format("%02d", sd.min));
					HigherLearning_triggerFrameRefresh();
				else
					DalaranUniversity.Bars[book].sd = date("*t", time(sd));
				end;
			end;
		end;
	end;

	realbook = function(sender, book, spawndate)
		local completed = false;
		local utc = time(date("!*t"));
		local sd = nil;
		local gd = date("!*t");
		gd.hour, gd.min = GetGameTime();
		if (difftime(time(gd), utc) < -(12 * 60 * 60)) then
			gd = date("*t", time(gd) + (24 * 60 * 60));
		elseif (difftime(time(gd), utc) > (12 * 60 * 60)) then
			gd = date("*t", time(gd) - (24 * 60 * 60));
		end;
		local csd = nil;
		if (DalaranUniversity.Bars[book].sd ~= nil) then
			csd = date("*t", time(DalaranUniversity.Bars[book].sd));
		end;
		if (DalaranUniversity.Bars[book].hl ~= nil) then
			if (DalaranUniversity.Bars[book].hl.hours ~= nil and
				DalaranUniversity.Bars[book].hl.minutes ~= nil and
				DalaranUniversity_SavedSettings.UseHL) then
				csd = date("!*t");
				csd.hour = DalaranUniversity.Bars[book].hl.hours;
				csd.min = DalaranUniversity.Bars[book].hl.minutes;
				if (difftime(time(csd), utc) < -(12 * 60 * 60)) then
					csd = date("*t", time(csd) + (24 * 60 * 60));
				elseif (difftime(time(csd), utc) > (12 * 60 * 60)) then
					csd = date("*t", time(csd) - (24 * 60 * 60));
				end;
			end;
		end;

		sd = date("*t", spawndate);
		_, _, completed = GetAchievementCriteriaInfo(DalaranUniversity.Translation.Achievements[book]);
		if ((abs(difftime(time(sd), time(gd))) - (3 * 60 * 60)) <= 10 and
			abs(difftime(time(sd), time(csd))) > (5 * 60) and
			not completed and
			not DalaranUniversity_SavedSettings.Muted) then
			PlaySound("ReadyCheck");
			RaidNotice_AddMessage(RaidWarningFrame, DalaranUniversity.Translation.BarIds[book].." "..DalaranUniversity.Translation.IsReal, ChatTypeInfo["RAID_WARNING"]);
		end;
		if ((difftime(time(sd), time(gd)) <= ((3 * 60 * 60) + (5 * 60)) and
				difftime(time(sd), time(gd)) > 0) or
			(difftime(time(gd), time(sd)) <= ((1 * 60 * 60) + (5 * 60)) and
				difftime(time(gd), time(sd)) >= 0)) then
			if (HigherLearning_setTime ~= nil) then
				HigherLearning_setTime(book, format("%02d", sd.hour)..":"..format("%02d", sd.min));
				HigherLearning_triggerFrameRefresh();
			else
				DalaranUniversity.Bars[book].sd = date("*t", time(sd));
			end;
		end;
	end;

	fakebook = function(sender, book, spawndate)
		local utc = time(date("!*t"));
		local sd = nil;
		local gd = date("!*t");
		gd.hour, gd.min = GetGameTime();
		if (difftime(time(gd), utc) < -(12 * 60 * 60)) then
			gd = date("*t", time(gd) + (24 * 60 * 60));
		elseif (difftime(time(gd), utc) > (12 * 60 * 60)) then
			gd = date("*t", time(gd) - (24 * 60 * 60));
		end;

		sd = date("*t", spawndate);
		if ((difftime(time(sd), time(gd)) <= ((3 * 60 * 60) + (5 * 60)) and
				difftime(time(sd), time(gd)) > 0) or
			(difftime(time(gd), time(sd)) <= ((1 * 60 * 60) + (5 * 60)) and
				difftime(time(gd), time(sd)) >= 0)) then
			if (HigherLearning_setTime ~= nil) then
				HigherLearning_setTime(book, format("%02d", sd.hour)..":"..format("%02d", sd.min));
				HigherLearning_triggerFrameRefresh();
			else
				DalaranUniversity.Bars[book].sd = date("*t", time(sd));
			end;
		end;
	end;

	sync = function(sender, version)
		local book = "";
		local spawndate = "";
		local utc = time(date("!*t"));
		local sd = nil;
		local t = nil;
		local func = nil;
		local v = nil;

		if (version < GetAddOnMetadata("DalaranUniversity", "Version")) then
			DalaranUniversity.Antenna:SendPrioritizedCommMessage("BULK", "WHISPER", sender, "version", GetAddOnMetadata("DalaranUniversity", "Version"));
		elseif (version > GetAddOnMetadata("DalaranUniversity", "Version")) then
			for t, func in pairs(DalaranUniversity.Main.Timers) do
				if (func == DalaranUniversity.VersionNotice) then
					DalaranUniversity.Main.Timers[t] = nil;
				end;
			end;
			if (DalaranUniversity.LatestVersion == nil) then
				DalaranUniversity.LatestVersion = version;
			elseif (version > DalaranUniversity.LatestVersion) then
				DalaranUniversity.LatestVersion = version;
			end;
			DalaranUniversity.Main.Timers[time() + 5] = DalaranUniversity.VersionNotice;
		end
		for _, v in pairs(DalaranUniversity.Translation.BarIds) do
			book = v;
			sd = nil;
			if (DalaranUniversity.Bars[book].sd ~= nil) then
				sd = date("*t", time(DalaranUniversity.Bars[book].sd));
			end;
			if (DalaranUniversity.Bars[book].hl ~= nil) then
				if (DalaranUniversity.Bars[book].hl.hours ~= nil and
					DalaranUniversity.Bars[book].hl.minutes ~= nil and
					DalaranUniversity_SavedSettings.UseHL) then
					sd = date("*t", time(gd));
					sd.hour = DalaranUniversity.Bars[book].hl.hours;
					sd.min = DalaranUniversity.Bars[book].hl.minutes;
					if (difftime(time(sd), utc) < -(12 * 60 * 60)) then
						sd = date("*t", time(sd) + (24 * 60 * 60));
					elseif (difftime(time(sd), utc) > (12 * 60 * 60)) then
						sd = date("*t", time(sd) - (24 * 60 * 60));
					end;
				end;
			end;
			if (sd ~= nil) then
				DalaranUniversity.Antenna:SendPrioritizedCommMessage("BULK", "WHISPER", sender, "book", book, time(sd));
			end;
		end;
	end;

	watched = function(sender, book)
		local utc = time(date("!*t"));
		local gd = date("!*t");
		gd.hour, gd.min = GetGameTime();
		if (difftime(time(gd), utc) < -(12 * 60 * 60)) then
			gd = date("*t", time(gd) + (24 * 60 * 60));
		elseif (difftime(time(gd), utc) > (12 * 60 * 60)) then
			gd = date("*t", time(gd) - (24 * 60 * 60));
		end;

		DalaranUniversity.Bars[book].Watched[sender] = time(gd);
	end;

	notwatched = function(sender, book)
		DalaranUniversity.Bars[book].Watched[sender] = nil;
	end;

	version = function(sender, version)
		if (version > GetAddOnMetadata("DalaranUniversity", "Version")) then
			for t, func in pairs(DalaranUniversity.Main.Timers) do
				if (func == DalaranUniversity.VersionNotice) then
					DalaranUniversity.Main.Timers[t] = nil;
				end;
			end;
			if (DalaranUniversity.LatestVersion == nil) then
				DalaranUniversity.LatestVersion = version;
			elseif (version > DalaranUniversity.LatestVersion) then
				DalaranUniversity.LatestVersion = version;
			end;
			DalaranUniversity.Main.Timers[time() + 5] = DalaranUniversity.VersionNotice;
		end;
	end;
};
DalaranUniversity.Antenna.OnCommReceive = function(prefix, sender, distribution, command, ...)
	if (DalaranUniversity.Antenna.Commands[command]) then
		DalaranUniversity.Antenna.Commands[command](sender, ...);
	end;
end;
-- rm ]]
