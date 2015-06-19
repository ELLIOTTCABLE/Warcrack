local addonName, ns, _ = ...

local Set = ns.class()
ns.Set = Set

-- create a new, empty set object using the given name
function Set:construct(setName)
	-- initialize member variables
	self.weights = {}
	self.caps = {}
	self.forced = {}
	self.virtualItems = {}
	self.itemScoreCache = {}
	self.ignoreCapsForCalculation = false
	self.useVirtualItems = true
	self.associatedSpec = nil
	self.preferredSpecNum = nil
	self.autoUpdate = false
	self.autoEquip = false

	self.calculationData = {} -- for use by calculation functions

	-- set some defaults
	self:SetName(setName or 'Unknown')

	-- determine if the player can dualwield
	self:ForceDualWield(false)
	self:ForceTitansGrip(false)
	self:EnableDualWield(ns:PlayerCanDualWield()) -- TODO: instead of initializing once, get capability from namespaced variable (which should be updated on spec change)
	self:EnableTitansGrip(ns:PlayerHasTitansGrip())
end

-- create a new set object using data from saved variables
function Set.CreateFromSavedVariables(setTable)
	Set.AssertArgumentType(setTable, 'table')

	local setInstance = Set(setTable.name)

	-- as part of the 6.0v4 database update, detect the character's spec for auto-updating if necessary
	if setTable._oldAutoUpdate then
		if not setTable.associatedSpec then
			local specID = GetSpecializationInfo(GetSpecialization(nil, nil, setTable._oldAutoUpdate) or 0)
			setInstance:SetAssociatedSpec(specID)
		end

		setTable._oldAutoUpdate = nil
	end

	-- load weights and caps
	if setTable.weights then
		-- initialize weights
		for stat, value in pairs(setTable.weights) do
			setInstance:SetStatWeight(stat, value)
		end
	end

	if setTable.caps then
		-- initialize caps
		for stat, cap in pairs(setTable.caps) do
			if cap.active then
				setInstance:SetHardCap(stat, cap.value)
			end
		end
	end

	-- load forced items
	if setTable.forced then
		-- initialize forced items
		for slotID, forced in pairs(setTable.forced) do
			for _, forcedItemID in ipairs(forced) do
				setInstance:ForceItem(slotID, forcedItemID)
			end
		end
	end

	-- load virtual items
	if setTable.virtualItems then
		for _, item in pairs(setTable.virtualItems) do
			-- TODO: use function
			tinsert(setInstance.virtualItems, item)
		end
	end

	-- load all other individual settings
	if setTable.associatedSpec then
		setInstance:SetAssociatedSpec(setTable.associatedSpec)
	end
	if setTable.preferredSpecNum then
		setInstance:SetPreferredSpecNumber(setTable.preferredSpecNum)
	end
	if setTable.autoUpdate then
		setInstance:SetAutoUpdate(true)
	end
	if setTable.autoEquip then
		setInstance:SetAutoEquip(true)
	end
	if setTable.simulateDualWield then
		setInstance:ForceDualWield(true)
	end
	if setTable.simulateTitansGrip then
		setInstance:ForceTitansGrip(true)
	end
	if not setTable.excludeFromTooltip then
		setInstance:SetDisplayInTooltip(true)
	end
	if setTable.forceArmorType then
		setInstance:SetForceArmorType(true)
	end
	if setTable.skipVirtualItems then
		setInstance:SetUseVirtualItems(false)
	end

	return setInstance
end

function Set.CreateWritableFromSavedVariables(setID)
	if not setID or not ns.db.profile.sets[setID] then return nil end
	local setInstance = Set.CreateFromSavedVariables(ns.db.profile.sets[setID])
	setInstance.setID = setID

	return setInstance
end

-- set the set's name
function Set:SetName(setName)
	self.AssertArgumentType(setName, 'string')

	self.name = setName
	if self.setID and ns.db.profile.sets[self.setID] then
		ns.db.profile.sets[self.setID].name = setName
	end
end

-- get the set's name
function Set:GetName()
	return self.name
end

-- get the set's icon texture used for its equipment set
function Set:GetIconTexture()
	local icon = GetEquipmentSetInfoByName(self:GetEquipmentSetName())
	if icon then
		return "Interface\\Icons\\" .. icon
	end

	local spec = self:GetAssociatedSpec()
	if spec then
		icon = select(4, GetSpecializationInfoByID(spec))
		icon = icon:gsub('[iI][nN][tT][eE][rR][fF][aA][cC][eE]\\[iI][cC][oO][nN][sS]\\', 'Interface\\Icons\\')
	end
	return icon or "Interface\\Icons\\Spell_Holy_EmpowerChampion"
end

function Set:GetEquipmentSetName()
	return ns:GenerateSetName(self:GetName()) -- TODO: move code here and maybe get rid of global function
end

-- set a hard cap for any stat
-- use value = nil to unset a cap
function Set:SetHardCap(stat, value)
	self.AssertArgumentType(stat, 'string')
	if type(value) ~= 'nil' then
		self.AssertArgumentType(value, 'number')
		if self.setID and ns.db.profile.sets[self.setID] then
			ns.db.profile.sets[self.setID].caps[stat] = {
				active = 1,
				value = value
			}
		end
	else
		if self.setID and ns.db.profile.sets[self.setID] then
			ns.db.profile.sets[self.setID].caps[stat] = nil
		end
	end

	wipe(self.itemScoreCache)
	self.caps[stat] = value
end

-- get the defined hard cap for any stat
function Set:GetHardCap(stat)
	self.AssertArgumentType(stat, 'string')

	return self.caps[stat]
end

-- get a list of all configured hard caps and their values, keyed by stat
function Set:GetHardCaps(useTable)
	if useTable then wipe(useTable) end
	local caps = useTable or {}
	for stat, value in pairs(self.caps) do
		caps[stat] = value
	end
	return caps
end

-- set a hard cap for any stat
-- use value = nil to unset a cap
function Set:SetStatWeight(stat, value)
	self.AssertArgumentType(stat, 'string')
	if type(value) ~= 'nil' then
		self.AssertArgumentType(value, 'number')
	end

	wipe(self.itemScoreCache)
	self.weights[stat] = value
	if self.setID and ns.db.profile.sets[self.setID] then
		ns.db.profile.sets[self.setID].weights[stat] = value
	end
end

-- get the defined hard cap for any stat
function Set:GetStatWeight(stat)
	self.AssertArgumentType(stat, 'string')

	return self.weights[stat]
end

-- get a list of all configured hard caps and their values, keyed by stat
function Set:GetStatWeights()
	local weights = useTable and wipe(useTable) or {}
	for stat, value in pairs(self.weights) do
		weights[stat] = value
	end
	return weights
end

-- remove all hard caps from this set
function Set:ClearAllHardCaps()
	wipe(self.itemScoreCache)
	wipe(self.caps)
end

-- add an item to this set's forced items
function Set:ForceItem(slotID, itemID)
	if not slotID or not itemID then return end

	if not self.forced[slotID] then
		self.forced[slotID] = {}
	end
	tinsert(self.forced[slotID], itemID)

	if self.setID and ns.db.profile.sets[self.setID] then
		if not ns.db.profile.sets[self.setID].forced then
			ns.db.profile.sets[self.setID].forced = {}
		end
		if not ns.db.profile.sets[self.setID].forced[slotID] then
			ns.db.profile.sets[self.setID].forced[slotID] = {}
		end
		tinsert(ns.db.profile.sets[self.setID].forced[slotID], itemID)
	end
end

-- remove an item from this set's forced items
function Set:UnforceItem(slotID, itemID)
	if not slotID or not itemID then return end

	if not self.forced[slotID] then return end
	for i = #(self.forced[slotID]), 1, -1 do
		local forcedItemID = self.forced[slotID][i]
		if forcedItemID == itemID then
			tremove(self.forced[slotID], i)
		end
	end

	if self.setID and ns.db.profile.sets[self.setID] and ns.db.profile.sets[self.setID].forced and ns.db.profile.sets[self.setID].forced[slotID] then
		for i = #(ns.db.profile.sets[self.setID].forced[slotID]), 1, -1 do
			local forcedItemID = ns.db.profile.sets[self.setID].forced[slotID][i]
			if forcedItemID == itemID then
				tremove(ns.db.profile.sets[self.setID].forced[slotID], i)
			end
		end
	end
end

-- determine whether the given item is part of this set's forced items
function Set:IsForcedItem(item, slotID)
	if not item then return false end

	local itemTable = ns:GetCachedItem(item)
	if not itemTable or not itemTable.itemID then return false end

	local itemID = itemTable.itemID

	if not slotID then
		for slotID, _ in pairs(ns.slotNames) do
			if self:IsForcedItem(itemID, slotID) then return true end
		end

		return false
	end
	if not self.forced[slotID] then
		return false
	else
		for _, forcedItemID in ipairs(self.forced[slotID]) do
			if forcedItemID == itemID then
				return true
			end
		end
	end
end

-- get a list of all of this set's forced items for the given slot
function Set:GetForcedItems(slotID, useTable)
	local items = useTable or {}
	if slotID then
		if self.forced[slotID] then
			for _, forcedItemID in ipairs(self.forced[slotID]) do
				tinsert(items, forcedItemID)
			end
		end
	else
		-- collect results for all slots
		for slotID, _ in pairs(ns.slotNames) do
			local subForced = self:GetForcedItems(slotID)
			if #subForced > 0 then
				items[slotID] = subForced
			end
		end
	end
	return items
end

-- add a virtual item to be included in this set's calculations
function Set:AddVirtualItem(item)
	if not item then return end

	tinsert(self.virtualItems, item)

	if self.setID and ns.db.profile.sets[self.setID] then
		if not ns.db.profile.sets[self.setID].virtualItems then
			ns.db.profile.sets[self.setID].virtualItems = {}
		end
		tinsert(ns.db.profile.sets[self.setID].virtualItems, item)
	end
end

-- remove a virtual item from this set's calculations
function Set:RemoveVirtualItem(item)
	if not item then return end

	for i = #(self.virtualItems), 1, -1 do
		local virtualItem = self.virtualItems[i]
		if virtualItem == item then
			tremove(self.virtualItems, i)
		end
	end

	if self.setID and ns.db.profile.sets[self.setID] and ns.db.profile.sets[self.setID].virtualItems then
		for i = #(ns.db.profile.sets[self.setID].virtualItems), 1, -1 do
			local virtualItem = ns.db.profile.sets[self.setID].virtualItems[i]
			if virtualItem == item then
				tremove(ns.db.profile.sets[self.setID].virtualItems, i)
			end
		end
	end
end

-- get a list of all of this set's virtual items
function Set:GetVirtualItems(useTable)
	local items = useTable or {}

	for _, item in ipairs(self.virtualItems) do
		tinsert(items, item)
	end

	return items
end

-- allow dual wielding for this set
function Set:EnableDualWield(value)
	self.canDualWield = value and true or false
end

-- get the current setting for dual wielding for this set
function Set:CanDualWield()
	return self.canDualWield or self.forceDualWield
end

function Set:ForceDualWield(force)
	self.forceDualWield = force and true or false
	if self.setID and ns.db.profile.sets[self.setID] then
		ns.db.profile.sets[self.setID].simulateDualWield = force and true or false
	end
end

function Set:IsDualWieldForced()
	return self.forceDualWield
end

-- allow titan's grip for this set
function Set:EnableTitansGrip(value)
	self.canTitansGrip = value and true or false
end

-- get the current setting for titan's grip for this set
function Set:CanTitansGrip()
	return self.canTitansGrip or self.forceTitansGrip
end

function Set:ForceTitansGrip(force)
	self.forceTitansGrip = force and true or false
	if self.setID and ns.db.profile.sets[self.setID] then
		ns.db.profile.sets[self.setID].simulateTitansGrip = force and true or false
	end
end
function Set:IsTitansGripForced()
	return self.forceTitansGrip
end

function Set:SetDisplayInTooltip(enable)
	self.displayInTooltip = enable and true or false
	if self.setID and ns.db.profile.sets[self.setID] then
		ns.db.profile.sets[self.setID].excludeFromTooltip = (not enable) and true or false
	end
end
function Set:GetDisplayInTooltip()
	return self.displayInTooltip
end

function Set:SetForceArmorType(enable)
	self.forceArmorType = enable and true or false
	if self.setID and ns.db.profile.sets[self.setID] then
		ns.db.profile.sets[self.setID].forceArmorType = enable and true or false
	end
end
function Set:GetForceArmorType()
	return self.forceArmorType
end

function Set:SetUseVirtualItems(enable)
	self.useVirtualItems = enable and true or false
	if self.setID and ns.db.profile.sets[self.setID] then
		ns.db.profile.sets[self.setID].skipVirtualItems = (not enable) and true or false
	end
end
function Set:GetUseVirtualItems()
	return self.useVirtualItems
end

function Set:SetAssociatedSpec(spec)
	self.associatedSpec = spec
	if self.setID and ns.db.profile.sets[self.setID] then
		ns.db.profile.sets[self.setID].associatedSpec = spec
	end
end
function Set:GetAssociatedSpec()
	return self.associatedSpec
end

function Set:SetPreferredSpecNumber(specNum)
	self.preferredSpecNum = specNum
	if self.setID and ns.db.profile.sets[self.setID] then
		ns.db.profile.sets[self.setID].preferredSpecNum = specNum
	end
end
function Set:GetPreferredSpecNumber()
	return self.preferredSpecNum
end

function Set:SetAutoUpdate(enable)
	self.autoUpdate = enable and true or false
	if self.setID and ns.db.profile.sets[self.setID] then
		ns.db.profile.sets[self.setID].autoUpdate = enable and true or false
	end
end
function Set:GetAutoUpdate()
	return self.autoUpdate
end

function Set:SetAutoEquip(enable)
	self.autoEquip = enable and true or false
	if self.setID and ns.db.profile.sets[self.setID] then
		ns.db.profile.sets[self.setID].autoEquip = enable and true or false
	end
end
function Set:GetAutoEquip()
	return self.autoEquip
end

function Set:GetItemScore(item, useRaw)
	assert(item and (type(item) == "string" or type(item) == "number"), "Usage: setObject:GetItemScore(itemLink or itemID[, useRaw])")

	if not self.itemScoreCache[item] then
		local itemTable = TopFit:GetCachedItem(item)
		if not itemTable then return end

		-- calculate item score
		local itemScore = 0
		local capsModifier = 0
		-- iterate given weights
		for stat, statValue in pairs(self.weights) do
			if itemTable.totalBonus[stat] then
				-- check for hard cap on this stat
				-- if not self.caps[stat] then -- [TODO] capped stats are still valuable! don't ignore their weights
					itemScore = itemScore + statValue * itemTable.totalBonus[stat]
				-- end
			end
		end

		-- also calculate raw item score
		local rawScore = 0
		local rawModifier = 0
		-- iterate given weights
		for stat, statValue in pairs(self.weights) do
			if itemTable.itemBonus[stat] then
				-- check for hard cap on this stat
				if not self.caps[stat] then
					rawScore = rawScore + statValue * itemTable.itemBonus[stat]
				end
			end
			if itemTable.procBonus[stat] then
				-- check for hard cap on this stat
				if not self.caps[stat] then
					rawScore = itemScore + statValue * itemTable.procBonus[stat]
				end
			end
		end

		self.itemScoreCache[item] = {
			itemScore = itemScore,
			rawScore = rawScore,
		}
	end

	if useRaw then
		return self.itemScoreCache[item].rawScore
	else
		return self.itemScoreCache[item].itemScore
	end
end
