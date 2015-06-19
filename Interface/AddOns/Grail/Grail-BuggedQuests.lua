--
--	Grail Bugged Quests
--	Written by scott@mithrandir.com
--
--	Version History
--		001	Initial version
--		002	Added 13913
--		003	Added 822, 30926, 30724 and 31074
--		004	Removed 24992.  Added 14395
--		005 Removed 31074.
--		006	Added 13981
--		007	Removed 822 and marked it unobtainable.
--		008	Switches to using separate table to hold bugged quests
--
--	UTF-8 file
--
local Grail_Bugged_Quests_File_Version = 008

if Grail.buggedQuestsVersionNumber < Grail_Bugged_Quests_File_Version then
	Grail.buggedQuestsVersionNumber = Grail_Bugged_Quests_File_Version
	local G = Grail.buggedQuests

-- 15050 is the 4.3.0 release
-- 15211 is the 4.3.2 release
-- 15882 is the 5.0.3 release dated 2012-07-16
local _, release = GetBuildInfo()
release = tonumber(release)

if release > 15050 then
	G[1]='This quest is bugged and cannot be completed.'
	G[13712]='This quest is bugged on many servers, so Blizzard seems to have added the ability to talk to Kadrak again to just fly over.'
end
end

