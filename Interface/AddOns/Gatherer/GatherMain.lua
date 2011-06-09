--[[
	Gatherer Addon for World of Warcraft(tm).
	Version: 3.2.3 (<%codename%>)
	Revision: $Id: GatherMain.lua 894 2010-12-02 22:46:33Z Esamynn $

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GPL.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

	Note:
		This AddOn's source code is specifically designed to work with
		World of Warcraft's interpreted AddOn system.
		You have an implicit licence to use this AddOn with these facilities
		since that is it's designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat
]]
Gatherer_RegisterRevision("$URL: http://svn.norganna.org/gatherer/trunk/Gatherer/GatherMain.lua $", "$Rev: 894 $")

Gatherer.Var.Version="3.2.3"
if (Gatherer.Var.Version == "<%".."version%>") then
	Gatherer.Var.Version = "3.2-DEV"
end
Gatherer.Version = Gatherer.Var.Version

Gatherer.AstrolabeVersion = "Astrolabe-1.0"

-- Global variables
Gatherer.Var.NoteUpdateInterval = 0.1
Gatherer.Var.NoteCheckInterval = 5.0
Gatherer.Var.Loaded = false
Gatherer.Var.ClosestCheck = 0.4

Gatherer.Var.UpdateWorldMap = -1

Gatherer.Var.Skills = { }
Gatherer.Var.ZoneData = { }
Gatherer.Var.MainMapItem = { }

StaticPopupDialogs["GATHERER_VERSION_DIALOG"] = {
	text = TEXT(GATHERER_VERSION_WARNING),
	button1 = TEXT(OKAY),
	showAlert = 1,
	timeout = 0,
}



