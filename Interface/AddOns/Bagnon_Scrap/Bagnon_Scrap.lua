--[[
Copyright 2008-2013 João Cardoso
Bagnon Scrap is distributed under the terms of the GNU General Public License (Version 3).
As a special exception, the copyright holders of this addon do not give permission to
redistribute and/or modify it.

This addon is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with the addon. If not, see <http://www.gnu.org/licenses/gpl-3.0.txt>.

This file is part of Bagnon Scrap.
--]]

local Addon = Bagnon
local ItemSlot = Addon.ItemSlot
local UpdateBorder = ItemSlot.UpdateBorder
local r, g, b  = GetItemQualityColor(0)


-- Glow and Icon
function ItemSlot:UpdateBorder()
	local link = select(7, self:GetInfo())
	if link then
		local id = tonumber(strmatch(link, 'item:(%d+)'))
		local bag, slot
		
		if not self:IsCached() then
			bag, slot = self:GetBag(), self:GetID()
		end
		
		if Scrap:IsJunk(id, bag, slot) then
			self:HideBorder()
			self:SetBorderColor(r, g, b)

			return self.JunkIcon:SetShown(Scrap_Icons)
		end
	end

	UpdateBorder(self)
	self.JunkIcon:Hide()
end


-- Update Bags
local function UpdateBags()
	Addon:UpdateFrames()
end

hooksecurefunc(Scrap, 'SettingsUpdated', UpdateBags)
hooksecurefunc(Scrap, 'ToggleJunk', UpdateBags)
Scrap.HasSpotlight = true