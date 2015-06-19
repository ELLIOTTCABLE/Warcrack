
----------------------------------
-- module independent variables --
----------------------------------
local addon, ns = ...
local C, L, I = ns.LC.color, ns.L, ns.I
graphicsSetsDB = {}

-----------------------------------------------------------
-- module own local variables and local cached functions --
-----------------------------------------------------------
local name = "FPS" -- L["FPS"]
local ldbName = name
local tt,tt2,tt3 = nil,nil,nil
local ttName, tt2Name, tt3Name = name.."TT", name.."TT2", name.."TT3"
local GetFramerate = GetFramerate
local _, playerClass = UnitClass("player")
local _minmax = {[1] = nil,[2] = nil}
local graph_maxValues,graph_maxHeight = 50,50
local fps = 0
local minmax_delay = 3
local gfxRestart = {}
local gameRestart = {}

local gfxMenu = {
	{ label = C("orange","("..L["Experimental"]..")"), title=true },
	{ separator = true },
	{ label=DISPLAY_HEADER, title=true },
--	{ label=DISPLAY_HEADER, childs={
		{ label=DISPLAY_MODE,		--[=[	childs={
			{label=VIDEO_OPTIONS_WINDOWED,            cvarType="num", cvars={gxWindow=1,gxMaximize=0}, controlGroup="displayMode"},
			{label=VIDEO_OPTIONS_WINDOWED_FULLSCREEN, cvarType="num", cvars={gxWindow=1,gxMaximize=1}, controlGroup="displayMode"},
			{label=VIDEO_OPTIONS_FULLSCREEN,          cvarType="num", cvars={gxWindow=0,gxMaximize=0}, controlGroup="displayMode"}
		}, gxRestart=true --]=]
		},
		{ label=VERTICAL_SYNC,			cvarType="bool", cvar="gxVSync",			gxRestart=true},
--	}},

	{ separator = true },

	{label=TEXTURES_SUBHEADER, title=true },
--	{label=TEXTURES_SUBHEADER, childs={
		{ label=TEXTURE_DETAIL,	--[=[		childs={
			{label=VIDEO_OPTIONS_LOW,    cvarType="num", cvars={terrainMipLevel=1, componentTextureLevel=1, worldBaseMip=2}, controlGroup="textureDetails"},
			{label=VIDEO_OPTIONS_FAIR,   cvarType="num", cvars={terrainMipLevel=1, componentTextureLevel=1, worldBaseMip=1}, controlGroup="textureDetails"},
			{label=VIDEO_OPTIONS_MEDIUM, cvarType="num", cvars={terrainMipLevel=0, componentTextureLevel=0, worldBaseMip=1}, controlGroup="textureDetails"},
			{label=VIDEO_OPTIONS_HIGH,   cvarType="num", cvars={terrainMipLevel=0, componentTextureLevel=0, worldBaseMip=0}, controlGroup="textureDetails"}
		} --]=]
		},
		{ label=ANISOTROPIC, --[=[ groupName="anisotropic", optionGroup={
			{label=VIDEO_OPTIONS_BILINEAR,       cvarType="num", cvars={textureFilteringMode=0}},
			{label=VIDEO_OPTIONS_TRILINEAR,      cvarType="num", cvars={textureFilteringMode=1}},
			{label=VIDEO_OPTIONS_2XANISOTROPIC,  cvarType="num", cvars={textureFilteringMode=2}},
			{label=VIDEO_OPTIONS_4XANISOTROPIC,  cvarType="num", cvars={textureFilteringMode=3}},
			{label=VIDEO_OPTIONS_8XANISOTROPIC,  cvarType="num", cvars={textureFilteringMode=4}},
			{label=VIDEO_OPTIONS_16XANISOTROPIC, cvarType="num", cvars={textureFilteringMode=5}}
		} --]=]
		},
		{ label=PROJECTED_TEXTURES,		cvarType="bool", cvar="projectedTextures"},
--	}},

	{ separator = true },

	{ label=EFFECTS_SUBHEADER, title=true },
--	{ label=EFFECTS_SUBHEADER, childs={
		{ label=SHADOW_QUALITY,		--[=[	childs={ 
			{label=VIDEO_OPTIONS_LOW,    cvarType="num", cvars={shadowMode=0, shadowTextureSize=512}, controlGroup="shadowQuality"},
			{label=VIDEO_OPTIONS_FAIR,   cvarType="num", cvars={shadowMode=1, shadowTextureSize=1024}, controlGroup="shadowQuality"},
			{label=VIDEO_OPTIONS_MEDIUM, cvarType="num", cvars={shadowMode=1, shadowTextureSize=2048}, controlGroup="shadowQuality"},
			{label=VIDEO_OPTIONS_HIGH,   cvarType="num", cvars={shadowMode=2, shadowTextureSize=2048}, controlGroup="shadowQuality"},
			{label=VIDEO_OPTIONS_ULTRA,  cvarType="num", cvars={shadowMode=3, shadowTextureSize=2048}, controlGroup="shadowQuality"}
		} --]=]
		},
		{ label=LIQUID_DETAIL,		--[=[	childs={
			{label=VIDEO_OPTIONS_LOW,    cvarType="num", cvars={waterDetail=0, reflectionMode=0, rippleDerail=0}, controlGroup="liquidDetails"},
			{label=VIDEO_OPTIONS_FAIR,   cvarType="num", cvars={waterDetail=1, reflectionMode=0, rippleDetail=0}, controlGroup="liquidDetails"},
			{label=VIDEO_OPTIONS_MEDIUM, cvarType="num", cvars={waterDetail=2, reflectionMode=1, rippleDetail=0}, controlGroup="liquidDetails"},
			{label=VIDEO_OPTIONS_ULTRA,  cvarType="num", cvars={waterDetail=3, reflectionMode=2, rippleDetail=1}, controlGroup="liquidDetails"}
		} --]=]
		},
		{ label=SUNSHAFTS,		--[=[		childs={
			{label=VIDEO_OPTIONS_DISABLED, cvarType="num", cvars={sunshafts=0}, controlGroup="sunShafts"},
			{label=VIDEO_OPTIONS_LOW,      cvarType="num", cvars={sunshafts=1}, controlGroup="sunShafts"},
			{label=VIDEO_OPTIONS_HIGH,     cvarType="num", cvars={sunshafts=2}, controlGroup="sunShafts"}
		} --]=]
		},
		{ label=PARTICLE_DENSITY,	--[=[	childs={
			{label=VIDEO_OPTIONS_LOW,    cvarType="num", cvars={particleDensity=10,  weatherDensity=0}, controlGroup="particleDensity"},
			{label=VIDEO_OPTIONS_FAIR,   cvarType="num", cvars={particleDensity=40,  weatherDensity=1}, controlGroup="particleDensity"},
			{label=VIDEO_OPTIONS_MEDIUM, cvarType="num", cvars={particleDensity=60,  weatherDensity=1}, controlGroup="particleDensity"},
			{label=VIDEO_OPTIONS_HIGH,   cvarType="num", cvars={particleDensity=80,  weatherDensity=2}, controlGroup="particleDensity"},
			{label=VIDEO_OPTIONS_ULTRA,  cvarType="num", cvars={particleDensity=100, weatherDensity=3}, controlGroup="particleDensity"}
		} --]=]
		},
		{ label=SSAO_LABEL,		--[=[		childs={
			{label=VIDEO_OPTIONS_DISABLED, cvarType="num", cvars={ssao=0}, controlGroup="ssao"},
			{label=VIDEO_OPTIONS_LOW,      cvarType="num", cvars={ssao=1}, controlGroup="ssao"},
			{label=VIDEO_OPTIONS_HIGH,     cvarType="num", cvars={ssao=2}, controlGroup="ssao"}
		} --]=]
		},
--	}},

	{ separator = true },

	{ label=ENVIRONMENT_SUBHEADER, title=true },
--	{ label=ENVIRONMENT_SUBHEADER, childs={
		{ label=FARCLIP,			--[=[	childs={
			{label=VIDEO_OPTIONS_LOW,        cvarType="num", cvars={farClip=0,    wmoLodDist=0,   terrainLodDist=0,   terrainTextureLod=0}, controlGroup="farclip"},
			{label=VIDEO_OPTIONS_FAIR,       cvarType="num", cvars={farClip=600,  wmoLodDist=300, terrainLodDist=300, terrainTextureLod=1}, controlGroup="farclip"},
			{label=VIDEO_OPTIONS_MEDIUM,     cvarType="num", cvars={farClip=800,  wmoLodDist=400, terrainLodDist=450, terrainTextureLod=1}, controlGroup="farclip"},
			{label=VIDEO_OPTIONS_HIGH,       cvarType="num", cvars={farClip=1000, wmoLodDist=500, terrainLodDist=500, terrainTextureLod=0}, controlGroup="farclip"},
			{label=VIDEO_OPTIONS_ULTRA,      cvarType="num", cvars={farClip=1300, wmoLodDist=650, terrainLodDist=650, terrainTextureLod=0}, controlGroup="farclip"},
			{label=VIDEO_OPTIONS_ULTRA.."+", cvarType="num", cvars={farClip=1600, wmoLodDist=800, terrainLodDist=800, terrainTextureLod=0}, controlGroup="farclip"}
		} --]=]
		},
		{ label=ENVIRONMENT_DETAIL,	--[=[	childs={
			{label=VIDEO_OPTIONS_LOW,    cvarType="num", cvars={environmentDetail=50}, controlGroup="environmentDetails"},
			{label=VIDEO_OPTIONS_FAIR,   cvarType="num", cvars={environmentDetail=75}, controlGroup="environmentDetails"},
			{label=VIDEO_OPTIONS_MEDIUM, cvarType="num", cvars={environmentDetail=100}, controlGroup="environmentDetails"},
			{label=VIDEO_OPTIONS_HIGH,   cvarType="num", cvars={environmentDetail=125}, controlGroup="environmentDetails"},
			{label=VIDEO_OPTIONS_ULTRA,  cvarType="num", cvars={environmentDetail=150}, controlGroup="environmentDetails"}
		} --]=]
		},
		{ label=GROUND_CLUTTER,		--[=[	childs={
			{label=VIDEO_OPTIONS_LOW,    cvarType="num", cvars={groundEffectDist=70,  groundEffectDensity=16}, controlGroup="groundClutter"},
			{label=VIDEO_OPTIONS_FAIR,   cvarType="num", cvars={groundEffectDist=110, groundEffectDensity=40}, controlGroup="groundClutter"},
			{label=VIDEO_OPTIONS_MEDIUM, cvarType="num", cvars={groundEffectDist=160, groundEffectDensity=64}, controlGroup="groundClutter"},
			{label=VIDEO_OPTIONS_HIGH,   cvarType="num", cvars={groundEffectDist=200, groundEffectDensity=80}, controlGroup="groundClutter"},
			{label=VIDEO_OPTIONS_ULTRA,  cvarType="num", cvars={groundEffectDist=260, groundEffectDensity=128}, controlGroup="groundClutter"}
		} --]=]
		},
--	}},

	{ separator = true },

	{ label=CAMERA_LABEL, title=true },
--	{ label=CAMERA_LABEL, childs={
		{ label=FOLLOW_TERRAIN,			cvarType="bool", cvar="cameraTerrainTilt"},
		{ label=HEAD_BOB,				cvarType="bool", cvar="cameraBobbing"},
		{ label=WATER_COLLISION,		cvarType="bool", cvar="cameraWaterCollision"},
		{ label=SMART_PIVOT,			cvarType="bool", cvar="cameraPivot"},
--	}},

	{ separator = true },

	{ label=EFFECTS_LABEL,  title=true },
--	{ label=EFFECTS_LABEL, childs={
		{ label=TRIPLE_BUFFER,			cvarType="bool", cvar="gxTripleBuffer",	gxRestart=true},
		{ label=FIX_LAG,				cvarType="bool", cvar="gxFixLag",		gxRestart=true},
		{ label=HARDWARE_CURSOR,		cvarType="bool", cvar="gxCursor",		gxRestart=true},
		{ label=GXAPI,		--[=[			childs={
			{label="DirectX 9",  cvarType="num", cvars={gxapi="D3D9"},  hide=(not IsWindowsClient()), controlGroup="gxApi"},
			{label="DirectX 11", cvarType="num", cvars={gxapi="D3D11"}, hide=(not IsWindowsClient()), controlGroup="gxApi"},
			{label="OpenGL",     cvarType="num", cvars={gxapi="OpenGL"}, controlGroup="gxApi"}
		}, gameRestart=true --]=]
		},
--	}},
}


-- ------------------------------------- --
-- register icon names and default files --
-- ------------------------------------- --
I[name..'_yellow'] = {iconfile="Interface\\Addons\\"..addon.."\\media\\fps_yellow"}	--IconName::FPS_yellow--
I[name..'_red']    = {iconfile="Interface\\Addons\\"..addon.."\\media\\fps_red"}	--IconName::FPS_red--
I[name..'_blue']   = {iconfile="Interface\\Addons\\"..addon.."\\media\\fps_blue"}	--IconName::FPS_blue--
I[name..'_green']  = {iconfile="Interface\\Addons\\"..addon.."\\media\\fps_green"}	--IconName::FPS_green--


---------------------------------------
-- module variables for registration --
---------------------------------------
ns.modules[name] = {
	desc = L["Broker to show your frames per second."],
	icon_suffix = "_blue",
	events = {},
	updateinterval = 1,
	config_defaults = nil,
	config_allowed = nil,
	config = { { type="header", label=L[name], align="left", icon=I[name..'_blue'] } }
}


--------------------------
-- some local functions --
--------------------------
local function minmax(f)
	if minmax_delay~=0 then minmax_delay = minmax_delay - 1 return end
	if (not _minmax[1]) or _minmax[1] > f then _minmax[1]=f end
	if (not _minmax[2]) or _minmax[2] < f then _minmax[2]=f end
end

local function fps_color(f)
	if not f then return {"","","?"} end
	local c = (f<20 and {"_red","red"}) or (f<30 and {"_yellow","dkyellow"}) or (f<100 and {"_green","green"}) or {"_blue","ltblue"}
	table.insert(c,C(c[2],f)..ns.suffixColour("fps"));
	return c
end

local function fpsTooltip(tt)
	if (not tt.key) or tt.key~=ttName then return end -- don't override other LibQTip tooltips...

	local l, c, cell
	tt:Clear()
	tt:AddHeader(C("dkyellow",L[name]))
	tt:AddSeparator()
	tt:AddLine(L["Current"]..":",fps_color(fps)[3])
	tt:AddSeparator(3,0,0,0,0)
	tt:AddLine(L["Min."]..":",fps_color(_minmax[1])[3])
	tt:AddLine(L["Max."]..":",fps_color(_minmax[2])[3])

	--[[
	tt:AddSeparator(3,0,0,0,0)
	l,c = tt:AddLine()
	tt:SetCell(l,1,"",nil,nil,2)
	local cell = tt.lines[l].cells[1]

	local f = ns.tooltipGraph(name,graph_maxValues,graph_maxHeight,true)
	f:SetParent(cell)
	f:SetPoint("TOPLEFT", cell,"TOPLEFT", 0, 0)
	cell:SetWidth(f:GetWidth())
	cell:SetHeight(f:GetHeight())
	]]

	--if Broker_EverythingDB.showHints then
	if false then
		tt:AddLine(" ")
		tt:AddLine(C("copper",L["Click"]).." ||",C("green",L["Open graphics set manager"]))
		tt:AddLine(C("copper",L["Right-Click"]).." ||",C("green",L["Open graphics menu"]))
	end
end

local function graphicsSetManager(_self)
	if (tt) and (tt:IsShown()) then ns.hideTooltip(tt,ttName,true); end

	local l,c
	tt2 = ns.LQT:Acquire(name.."TT2", 1, "LEFT")
	ns.createTooltip(_self,tt2)
	tt2:SetScript('OnEnter', function()
	end)
	tt2:Clear()

	tt2:AddHeader(C("ltblue","Graphics set manager"))
	tt2:AddSeparator()
	tt2:AddLine(L["No set found"])

	if Broker_EverythingDB.showHints then
		tt2:AddLine(" ")
		line, column = tt:AddLine()
		tt2:SetCell(line, 1,
			C("ltblue",L["Click"]).." || "..C("green",L["Use a set"])
			.."|n"..
			C("ltblue",L["Shift+Click"]).." || "..C("green",L["Update/save a set"])
			.."|n"..
			C("ltblue",L["Ctrl+Click"]).." || "..C("green",L["Delete a set"])
			, nil, nil, 1)
		
	end
end

local function checkSelection(selName)
	local bool,cvars=true,{}
	for i,v in ipairs(options[selName]) do
		bool=true
		for I,V in pairs(v) do
			if I~="label" and I~="check" then
				if selName=="gfxapi" then
					if cvars[I]==nil then cvars[I] = strlower(GetCVar(I)) end -- reduce call of GetCVar
					V=strlower(V)
				else
					if cvars[I]==nil then cvars[I] = tonumber(GetCVar(I)) end -- reduce call of GetCVar
				end
				if cvars[I]~=V then bool=false end
			end
		end
		if bool==true then
			return v.label
		end
	end
	return C("gray",VIDEO_QUALITY_LABEL6)
end

local function setSelection(selName,index)
end

local function graphicsMenuSelection(self,selName)
	local l,c
	if tt3==nil or (tt3~=nil and tt3.key~=tt3Name) then
		tt3 = ns.LQT:Acquire(tt3Name,1,"LEFT")
	end
	tt3:SetScript('OnEnter', function()
		tt3:SetScript('OnLeave', function()
			ns.hideTooltip(tt2,ttName2,true);
			ns.hideTooltip(tt3,ttName3,true);
		end)
	end)
	tt3:Clear()

	for i,v in ipairs(options[selName]) do
		if v.label~=nil then
			l,c = tt3:AddLine(v.label)
			tt3:SetLineScript(l,"OnMouseUp",function()
				setSelection(selName,i)
			end)
		end
	end

	ns.createTooltip(self,tt3)
	tt3:ClearAllPoints()
	tt3:SetPoint("LEFT",tt2,"RIGHT",-15,0)
	tt3:SetPoint("TOP",self,"TOP",0,5)
	tt3:SetFrameLevel(tt2:GetFrameLevel()+3)
end

local function graphicsMenu(_self)
	if (tt) and (tt:IsShown()) then ns.hideTooltip(tt,ttName,true); end
	local l,c
	tt2 = ns.LQT:Acquire(name.."TT2", 2, "LEFT", "RIGHT")
	tt2:Clear()

	for i,v in ipairs(tt2_normal) do
		if v.head~=nil then
			tt2:AddLine(C("ltblue",v.head))
		elseif v.sep==true then
			tt2:AddSeparator()
		elseif v.sep~=nil then
			tt2:AddSeparator(unpack(v.sep))
		elseif v.label~=nil then
			l,c = tt2:AddLine()
			tt2:SetCell(l,1,C("ltyellow",v.label))
			if v.boolean~=nil then
				tt2:SetCell(l,2, GetCVar(v.boolean)=="1" and C("green",VIDEO_OPTIONS_ENABLED) or C("red",VIDEO_OPTIONS_DISABLED))
				tt2:SetLineScript(l,"OnMouseUp",function(self,button) ns.SetCVar(v.boolean,GetCVar(v.boolean)=="1" and "0" or "1") graphicsMenu(_self) end)
			elseif v.option~=nil then
				tt2:SetCell(l,2,checkSelection(v.option))
				tt2:SetLineScript(l,"OnEnter",function(__self)
					graphicsMenuSelection(__self,v.option)
				end)
				tt2:SetLineScript(l,"OnLeave", function(__self)
					ns.hideTooltip(tt3,ttName3);
				end)
			else
				tt2:SetCell(l,2,C("gray","?"))
			end
		end
	end

	ns.createTooltip(_self,tt2)
	tt2:SetScript('OnLeave', function() ns.hideTooltip(tt2,ttName2) end)
end

local function getSettings()
	
end

local function createMenu(parent)
	if (tt) and (tt.key) and (tt.key==ttName) then ns.hideTooltip(tt,ttName,true) end

	ns.EasyMenu.InitializeMenu();
	ns.EasyMenu.addEntries(gfxMenu);
	ns.EasyMenu.ShowMenu(parent);
end

------------------------------------
-- module (BE internal) functions --
------------------------------------
ns.modules[name].init = function(obj)
	ldbName = (Broker_EverythingDB.usePrefix and "BE.." or "")..name
end

-- ns.modules[name].onevent = function(self,event,msg) end

ns.modules[name].onupdate = function(self)
	fps = floor(GetFramerate())
	local c = fps_color(fps)
	local d = self.obj or ns.LDB:GetDataObjectByName(ldbName)

	minmax(fps)
	--ns.tooltipGraphAddValue(name,fps,graph_maxValues)

	local icon = I(name..c[1])
	d.iconCoords = icon.coords or {0,1,0,1}
	d.icon = icon.iconfile
	d.text = c[3]

	--if tt then
	if tt~=nil and tt.key~=nil and tt.key==ttName and tt:IsShown() then
		fpsTooltip(tt)
	end
end

-- ns.modules[name].optionspanel = function(panel) end
-- ns.modules[name].onmousewheel = function(self,direction) end
-- ns.modules[name].ontt = function(tt) end

-------------------------------------------
-- module functions for LDB registration --
-------------------------------------------
ns.modules[name].onenter = function(self)
	if (ns.tooltipChkOnShowModifier(false)) then return; end

	if tt2~=nil and tt2.key==tt2Name and tt2:IsShown() then return end

	tt = ns.LQT:Acquire(ttName, 2, "LEFT", "RIGHT")
	fpsTooltip(tt)
	ns.createTooltip(self,tt)
end

ns.modules[name].onleave = function(self)
	if (tt) then ns.hideTooltip(tt,ttName,true); end
end

ns.modules[name].onclick = function(self,button)
	if button == "LeftButton" then
		--graphicsSetManager(self)
	elseif button == "RightButton" then
		--graphicsMenu(self)
		--createMenu(self);
	end
end

-- ns.modules[name].ondblclick = function(self,button) end

