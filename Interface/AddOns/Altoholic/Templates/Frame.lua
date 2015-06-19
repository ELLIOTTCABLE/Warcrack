--[[ ** widget extensions **
The purpose of widget extensions to add methods to any widgets.
This can technically be done in the XML file, as part of the XML template's OnLoad.
Like this:

self.Draw = function(self, arg1, arg2, arg3)
		... do whatever
	end

The problem is that if the object is instantiated multiple times, and it will since we're using a template, 
then the function is actually created multiple times in memory too. A simple print proves it.

print(self.Draw)

.. this will show that the same function in each instance of the object actually has a different address in memory.

Thus to stay proper, instantiate each function once here as a local function, then expose it so that widgets can reference it. 
A print with this technique proves we're using the single copy in memory of each function.

Naturally, it would also work if my local functions were all global.. but let's avoid polluting the global namespace.

--]]

local addonName = "Altoholic"
local addon = _G[addonName]

local function _ShowChildFrames(self)
	for _, child in ipairs( {self} ) do
		child:Show()
	end
end

local function _HideChildFrames(self)
	for _, child in ipairs( {self} ) do
		child:Hide()
	end
end

addon:RegisterClassExtensions("AltoFrame", {
	ShowChildFrames = _ShowChildFrames,
	HideChildFrames = _HideChildFrames,
})
