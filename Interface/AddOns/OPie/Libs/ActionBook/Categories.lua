local _, T = ...
if T.SkipLocalActionBook then return end
local AB, mark = assert(T.ActionBook:compatible(2, 14), "A compatible version of ActionBook is required"), {}
local RW = assert(T.ActionBook:compatible("Rewire", 1,4), "A compatible version of Rewire is required")
_ = T.Toboe and T.Toboe()

do -- spellbook
	local function addEntry(add, at, ok, st, sid, ...)
		if st == "SPELL" and not IsPassiveSpell(sid) and not mark[sid] then
			mark[sid] = 1
			add(at, sid)
		elseif st == "FLYOUT" then
			for j=1,select(3,GetFlyoutInfo(sid)) do
				local asid, _osid, ik = GetFlyoutSlotInfo(sid, j)
				if ik then
					addEntry(add, at, true, "SPELL", asid)
				end
			end
		end
	end
	local function aug(category, add)
		wipe(mark)
		if category == "Pet abilities" then
			if PetHasSpellbook() then
				for i=1,HasPetSpells() or 0 do
					addEntry(add, "petspell", pcall(GetSpellBookItemInfo, i, "pet"))
				end
				for s in ("attack move stay follow assist defend passive dismiss"):gmatch("%S+") do
					add("petspell", s)
				end
			end
		else
			if UnitLevel("player") >= 90 and GetExpansionLevel() >= 5 then
				add("spell", 161691)
			end
			for i=1,GetNumSpellTabs()+12 do
				local _, _, ofs, c, _, sid = GetSpellTabInfo(i)
				for j=ofs+1,sid == 0 and (ofs+c) or 0 do
					addEntry(add, "spell", pcall(GetSpellBookItemInfo, j, "spell"))
				end
			end
		end
		wipe(mark)
	end
	AB:AugmentCategory("Abilities", aug)
	AB:AugmentCategory("Pet abilities", aug)
end
AB:AugmentCategory("Items", function(_, add)
	wipe(mark)
	for bag=0,4 do
		for slot=1,GetContainerNumSlots(bag) do
			local iid = GetContainerItemID(bag, slot)
			if iid and GetItemSpell(iid) and not mark[iid] then
				add("item", iid)
				mark[iid] = 1
			end
		end
	end
	for slot=INVSLOT_FIRST_EQUIPPED, INVSLOT_LAST_EQUIPPED do
		if GetItemSpell(GetInventoryItemLink("player", slot)) then
			add("item", GetInventoryItemID("player", slot))
		end
	end
end)
do -- Battle pets
	local running, sourceFilters, typeFilters, flagFilters, search = false, {}, {}, {[LE_PET_JOURNAL_FLAG_COLLECTED]=1, [LE_PET_JOURNAL_FLAG_NOT_COLLECTED]=1}, ""
	hooksecurefunc(C_PetJournal, "SetSearchFilter", function(filter) search = filter end)
	hooksecurefunc(C_PetJournal, "ClearSearchFilter", function() if not running then search = "" end end)
	local function aug(_, add)
		assert(not running, "Battle pets enumerator is not reentrant")
		running = true
		for i=1, C_PetJournal.GetNumPetSources() do
			sourceFilters[i] = not C_PetJournal.IsPetSourceFiltered(i)
		end
		C_PetJournal.AddAllPetSourcesFilter()
		
		for i=1, C_PetJournal.GetNumPetTypes() do
			typeFilters[i] = not C_PetJournal.IsPetTypeFiltered(i)
		end
		C_PetJournal.AddAllPetTypesFilter()
		
		-- There's no API to retrieve the filter, so rely on hooks
		C_PetJournal.ClearSearchFilter()
		
		for k in pairs(flagFilters) do
			flagFilters[k] = not C_PetJournal.IsFlagFiltered(k)
		end
		C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_COLLECTED, true)
		C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_NOT_COLLECTED, false)
		local sortParameter = C_PetJournal.GetPetSortParameter()
		C_PetJournal.SetPetSortParameter(LE_SORT_BY_LEVEL)
		
		for i=1,C_PetJournal.GetNumPets() do
			add("battlepet", (C_PetJournal.GetPetInfoByIndex(i)))
		end
		
		for k, v in pairs(flagFilters) do
			C_PetJournal.SetFlagFilter(k, v)
		end
		for i=1,#typeFilters do
			C_PetJournal.SetPetTypeFilter(i, typeFilters[i])
		end
		for i=1,#sourceFilters do
			C_PetJournal.SetPetSourceFilter(i, sourceFilters[i])
		end
		C_PetJournal.SetSearchFilter(search)
		C_PetJournal.SetPetSortParameter(sortParameter)
		
		running = false
	end
	AB:AugmentCategory("Battle pets", aug)
end
AB:AugmentCategory("Mounts", function(_, add)
	if GetSpellInfo(150544) then add("spell", 150544) end
	local myFactionId = UnitFactionGroup("player") == "Horde" and 0 or 1
	for i=1, C_MountJournal.GetNumMounts() do
		local _1, sid, _3, _4, _5, _6, _7, factionLocked, factionId, hide, have = C_MountJournal.GetMountInfo(i)
		local sname = GetSpellInfo(sid)
		if have and not hide and (not factionLocked or factionId == myFactionId) and GetSpellInfo(sname) ~= nil then
			add("spell", sid)
		end
	end
end)
local function icmp(a,b)
	return strcmputf8i(a,b) < 1
end
AB:AugmentCategory("Macros", function(_, add)
	add("macrotext", "")
	local n, ni = {}, 1
	for name in RW:GetNamedMacros() do
		n[ni], ni = name, ni + 1
	end
	table.sort(n, icmp)
	for i=1,#n do
		add("macro", n[i])
	end
end)
AB:AugmentCategory("Equipment sets", function(_, add)
	for i=1,GetNumEquipmentSets() do
		add("equipmentset", (GetEquipmentSetInfo(i)))
	end
end)
AB:AugmentCategory("Raid markers", function(_, add) for i=0,8 do add("raidmark", i) end end)
AB:AugmentCategory("Raid markers", function(_, add) for i=0,8 do add("worldmark", i) end end)
do -- data broker launchers
	local LDB, waiting = nil, true
	local function checkLDB()
		LDB = LibStub and LibStub:GetLibrary("LibDataBroker-1.1", 1)
	end
	local function hasLaunchers()
		for n, o in LDB:DataObjectIterator() do
			if o.type == "launcher" then return true end
		end
	end
	local function aug(_, add)
		for name, obj in LDB:DataObjectIterator() do
			if obj.type == "launcher" then
				add("opie.databroker.launcher", name)
			end
		end
	end
	local function register()
		if waiting and hasLaunchers() then
			AB:AugmentCategory("DataBroker", aug)
			waiting = nil
		elseif not waiting then
			AB:NotifyObservers("opie.databroker.launcher")
		end
	end
	T.Evie.RegisterEvent("ADDON_LOADED", function()
		if LDB or checkLDB() or LDB then
			register()
			if waiting then LDB.RegisterCallback("opie.databroker.launcher", "LibDataBroker_DataObjectCreated", register) end
			return "remove"
		end
	end)
end
if C_ToyBox then
	local tx, fs, search = C_ToyBox, {}
	hooksecurefunc(C_ToyBox, "SetFilterString", function(s) search = s end) -- No corresponding Get
	AB:AugmentCategory("Toys", function(_, add)
		local ns, search = C_PetJournal.GetNumPetSources(), search, tx.SetFilterString("")
		local fc = tx.GetFilterCollected(), tx.SetFilterCollected(true)
		local fu = tx.GetFilterUncollected(), tx.SetFilterUncollected(false)
		for i=1,ns do
			fs[i] = tx.IsSourceTypeFiltered(i), tx.SetFilterSourceType(i, false)
		end
		C_ToyBox.FilterToys()
		for i=1,C_ToyBox.GetNumFilteredToys() do
			local iid = C_ToyBox.GetToyFromIndex(i)
			if iid > 0 and PlayerHasToy(iid) then
				add("toy", iid)
			end
		end
		tx.SetFilterCollected(fc)
		tx.SetFilterUncollected(fu)
		for i=1,ns do
			tx.SetFilterSourceType(i, fs[i])
		end
		tx.SetFilterString(search or "")
		C_ToyBox.FilterToys()
	end)
end