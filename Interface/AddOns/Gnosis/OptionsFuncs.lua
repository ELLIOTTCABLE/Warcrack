-- Gnosis v4.49 last changed 2015-05-10T22:07:21Z
-- OptionsFuncs.lua last changed 2015-05-10T22:07:21Z

-- local functions
local pairs = pairs;
local ipairs = ipairs;
local type = type;
local unpack = unpack;
local setmetatable = setmetatable;
local getmetatable = getmetatable;
local next = next;
local wipe = wipe;
local string_len = strlenutf8;
local string_trim = strtrim;
local string_gmatch = string.gmatch;
local table_insert = table.insert;

-- local variables
local _;

function Gnosis:OptColor_Entry(key, idx, namestr, variable, cfgtab, bartab)
	cfgtab = cfgtab or "cbconf";
	bartab = bartab or "castbars";

	return {
		order = idx,
		name = namestr,
		type = "color",
		get = function(info) return unpack(Gnosis.s[cfgtab][key][variable]); end,
		set = function(info,r,g,b,a) Gnosis.s[cfgtab][key][variable] = { r, g, b, a }; Gnosis:SetBarParams(key, cfgtab, bartab); end,
		hasAlpha = true,
	};
end

function Gnosis:OptColorText_Entry(key, idx, namestr, variable, cfgtab, bartab)
	cfgtab = cfgtab or "cbconf";
	bartab = bartab or "castbars";

	return {
		order = idx,
		name = namestr,
		type = "input",
		get = function(info) return Gnosis:CreateColorString(unpack(Gnosis.s[cfgtab][key][variable])) end,
		set = function(info,val)
			local r, g, b, a = Gnosis:GetColorsFromString(val);
			if(r) then
				Gnosis.s[cfgtab][key][variable] = { r, g, b, a };
				Gnosis:SetBarParams(key, cfgtab, bartab);
			end
		end,
	};
end

function Gnosis:OptColorGroup_Entry(key, idx, namestr, variable, cfgtab, bartab)
	cfgtab = cfgtab or "cbconf";
	bartab = bartab or "castbars";

	return {
		name = "",
		order = idx,
		type = "group",
		inline = true,
		args = {
			colentry = self:OptColor_Entry(key, 1, namestr, variable, cfgtab, bartab),
			coltextentry = self:OptColorText_Entry(key, 2, "", variable, cfgtab, bartab),
		}
	};
end

function Gnosis:OptToggle_Entry(key, idx, namestr, descstr, variable, cfgtab, bartab)
	cfgtab = cfgtab or "cbconf";
	bartab = bartab or "castbars";

	local t = {
		order = self:GetNextTableIndexInner(),
		name = namestr,
		desc = descstr,
		type = "toggle",
		get = function(info) return Gnosis.s[cfgtab][key][variable]; end,
		set = function(info,val) Gnosis.s[cfgtab][key][variable] = val; Gnosis:SetBarParams(key, cfgtab, bartab); end,
	}

	return t;
end

function Gnosis:OptSimpleToggle(key, idx, namestr, descstr, variable, cfgtab)
	cfgtab = cfgtab or "cbconf";

	return {
		order = idx,
		name = namestr,
		desc = descstr,
		type = "toggle",
		get = function(info) return Gnosis.s[cfgtab][key][variable]; end,
		set = function(info,val) Gnosis.s[cfgtab][key][variable] = val; end,
	};
end

function Gnosis:MultilineFromTable(t)
	local str = "";
	local i = 1;

	for k, v in ipairs(t) do
		str = str .. v .. "\n";
	end

	str = string_trim(str);
	return str;
end

function Gnosis:MultilineToTable(str, t)
	wipe(t);

	if(str and string_len(str) > 0) then
		for line in string_gmatch(str, "%s*([^\r\n]+)") do
			line = string_trim(line);
			table_insert(t, line);
		end
	end
end

function Gnosis:deepcopy(object)
    local lookup_table = {};
    local function _copy(object)
        if(type(object) ~= "table") then
            return object;
        elseif(lookup_table[object]) then
            return lookup_table[object];
        end
        local new_table = {};
        lookup_table[object] = new_table;
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value);
        end
        return setmetatable(new_table, _copy(getmetatable(object)));
    end
    return _copy(object);
end
