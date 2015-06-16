local E, tip, _, T = {}, CreateFrame("GameTooltip"), ...
tip:AddFontStrings(tip:CreateFontString(), tip:CreateFontString())

do -- Is*InRange
	local m = {[0]=0, 1, [true]=1, [false]=0}
	local function normalized(f)
		return function(...)
			return m[f(...)]
		end
	end
	for k in ("IsSpellInRange IsItemInRange IsActionInRange"):gmatch("%S+") do
		E[k] = normalized(_G[k])
	end
end

function E.GetNumTalents()
	return 21
end
function E.GetTalentInfo(id, isInspect, talentGroup, inspectedUnit, classId)
	local col = ((id-1) % 3)+1
	local row = 1 + (id - col)/3
	local _sid, name, tex, selected, available = GetTalentInfo(row, col, talentGroup or GetActiveSpecGroup() or 1, isInspect, inspectedUnit)
	return name, tex, row, col, selected, available
end
function E.GetTalentSpellForSpecialization(id, spec)
	tip:SetOwner(UIParent, "ANCHOR_NONE")
	local col = ((id-1) % 3)+1
	tip:SetTalent((GetTalentInfoBySpecialization(spec or GetSpecialization() or 1, 1 + (id - col)/3, col)))
	return tip:GetSpell()
end

E.MAX_ACCOUNT_MACROS = 120
do -- Macro icons and file data
	local tex = tip:CreateTexture()
	local function wrap(f)
		return function(t)
			local fi, t = (t and #t or 0), f(t)
			for i=fi+1,#t do
				if type(t[i]) == "number" then
					t[i] = (tex:SetToFileData(t[i]) and nil) or tex:GetTexture():match("[^\\]+$")
				end
			end
			return t
		end
	end
	E.GetMacroIcons, E.GetMacroItemIcons = wrap(GetMacroIcons), wrap(GetMacroItemIcons)
end

function T.Toboe()
	local G, N = getfenv(2), {}
	for k,v in pairs(E) do N[k] = v end
	N._G = N
	setmetatable(N, {__index=G, __newindex=function(t,k,v) G[k] = v end})
	setfenv(2, N)
end