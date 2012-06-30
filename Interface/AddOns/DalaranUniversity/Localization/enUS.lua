DalaranUniversity = {};

if (GetLocale() == "enUS" or
	true) then
	SLASH_DALARANUNIVERSITY1 = "/dalaranuniversity";
	SLASH_DALARANUNIVERSITY2 = "/du";

	DalaranUniversity_Main_TitleText = "Dalaran University";
	DalaranUniversity_SetTime_TitleText = "Set Book Time";
	DalaranUniversity_Set_ButtonText = "Set";
	DalaranUniversity_Cancel_ButtonText = "Cancel";

	DalaranUniversity.Translation = {
		BarNames = {
			VG = "Introduction",
			DVC = "Abjuration",
			LVC = "Conjuration",
			UVC = "Divination",
			TOF = "Enchantment",
			VH = "Illusion",
			ULL = "Necromancy",
			LLL = "Transmutation"
		};
		BarIds = {
			VG = "VG",
			DVC = "DVC",
			LVC = "LVC",
			UVC = "UVC",
			TOF = "TOF",
			VH = "VH",
			ULL = "ULL",
			LLL = "LLL"
		};
		Achievements = {
			VG = 7236;
			DVC = 7237;
			LVC = 7238;
			UVC = 7239;
			TOF = 7240;
			VH = 7241;
			ULL = 7242;
			LLL = 7243;
		};
		Locations = {
			VG = {X = 56.7; Y = 45.5};
			DVC = {X = 52.2; Y = 54.8};
			LVC = {X = 31.0; Y = 46.7};
			UVC = {X = 26.5; Y = 52.2};
			TOF = {X = 43.6; Y = 46.7};
			VH = {X = 64.4; Y = 52.4};
			ULL = {X = 46.8; Y = 39.1};
			LLL = {X = 46.8; Y = 40.0};
		};
		Books = {
			VG = {
				"The Schools of Arcane Magic - Introduction",
				"The Archmage Antonidas - Part II",
				"The Old Wizard's Almanac",
				"The Worst Mage in Dalaran: A Children's Book",
			};
			DVC = {
				"The Schools of Arcane Magic - Abjuration",
				"Blinking Rules & Regulations",
				"Bundle of Romantic Correspondences",
				"Damaged Apprentice Journal"
			};
			LVC = {
				"The Schools of Arcane Magic - Conjuration",
				"In Time, the Arcane Corrupts All!",
				"Journal of Archmage Antonidas",
				"Kirin Tor Monthly (March Issue)",
				"LAVA BLAST - by Pyroco"
			};
			UVC = {
				"The Schools of Arcane Magic - Divination",
				"Kirin Tor Monthly (May Issue)",
				"Losses of the Third War",
				"On the Virtues of Magic"
			};
			TOF = {
				"The Schools of Arcane Magic - Enchantment",
				"Kirin Tor Monthly (November Issue)",
				"Remedial Magic 101: Tips from the Pros",
				"STAY OUT!!!",
				"Portals are NOT Garbage Bins!"
			};
			VH = {
				"The Schools of Arcane Magic - Illusion",
				"The Archmage Antonidas - Part I",
				"The Dangers of Magic Abuse",
				"The Fate of Apprentice Argoly",
				"The Fluffy Bunny"
			};
			ULL = {
				"The Schools of Arcane Magic - Necromancy",
				"Thinking with Portals - A Memorandum on Proper Portal Usage",
				"To Do Today",
				"The Archmage Antonidas - Part III"
			};
			LLL = {
				"The Schools of Arcane Magic - Transmutation",
				"Excerpts from the Journal of Archmage Vargoth",
				"To Do Today",
				"Polymorphic Rules & Regulations",
				"Weathered Diary - Dates from the Third War"
			};
		};
		CannotSpawnIn = "cannot spawn in the next";
		WillSpawnWithin = "will spawn within";
		And = "and";
		Time = {
			Hour = {
				Singular = "hour";
				Plural = "hours";
			};
			Minute = {
				Singular = "minute";
				Plural = "minutes";
			};
			AM = "AM";
			PM = "PM";
		};
		SpawnedAt = "Last Spawned At";
		SpawnsAt = "Spawns Next At";
		SetBookTimeFor = "Set Book Time For";
		ResetBookTimeFor = "Reset Book Time For";
		RequestSync = "Request Full Synchronization";
		ResetAll = "Reset All Book Times";
		WatchedBy = "Watched By";
  WatchedSecAgo = "seconds ago";
		OutOfDate = {
			"Your version of Dalaran University is out of date!",
			"Your version is:",
			"The latest version is:"
		};
		IsReal = "is REAL!";
		Mute = "Disables the warning message\nthat pops up when a book is real";
		Unmute = "Enables the warning message\nthat pops up when a book is real";
	};
end
