--[[
Copyright 2010-2013 João Cardoso
Scrap Broker is distributed under the terms of the GNU General Public License (Version 3).
As a special exception, the copyright holders of this addon do not give permission to
redistribute and/or modify it.

This addon is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with the addon. If not, see <http://www.gnu.org/licenses/gpl-3.0.txt>.

This file is part of Scrap Broker.
--]]

local L = Scrap_Locals
local Launcher = LibStub('LibDataBroker-1.1'):NewDataObject('Scrap', {
	type = 'data source',
	tocname = ...,
})

StaticPopupDialogs['DELETE_SCRAP'] = {
	text = L.ConfirmDelete,
	button1 = OKAY,
	button2 = CANCEL,
	OnAccept = function()
		for bag, slot, id in Scrap:IterateJunk() do
			PickupContainerItem(bag, slot)
			DeleteCursorItem()
		end
	end,
	
	hideOnEscape = 1, showAlert = 1,
	exclusive = 1, whileDead = 1,
	preferredIndex = STATICPOPUP_NUMDIALOGS,
	timeout = 0
}


--[[ API ]]--

function Launcher:Startup()
	-- Event --
	local frame = CreateFrame('Frame')
	frame:RegisterEvent('BAG_UPDATE')
	frame:SetScript('OnEvent', function()
		self:Update()
	end)
	
	-- Hook --
	local UpdateState = Scrap.UpdateButtonState
	function Scrap.UpdateButtonState(...)
		UpdateState(...)
		self:Update()
	end
end

function Launcher:Update()
	local value = Scrap:GetJunkValue()
	if value > 0 then
		self.icon = 'Interface\\Addons\\Scrap\\Art\\Enabled Icon'
	else
		self.icon = 'Interface\\Addons\\Scrap\\Art\\Disabled Icon'
	end
	
	self.text = GetCoinTextureString(value)
end


--[[ Scripts ]]--

function Launcher:OnClick(button)
	if MerchantFrame:IsShown() or button == 'RightButton' then
		Scrap:OnClick(button, self)
	else
		StaticPopup_Show('DELETE_SCRAP')
	end
end

function Launcher:OnReceiveDrag()
	Scrap:OnReceiveDrag()
end

function Launcher:OnTooltipShow()
	Scrap:OnTooltipShow(not MerchantFrame:IsShown() and L.DeleteJunk)
end


--[[ Load Addon ]]--

Launcher:Startup()