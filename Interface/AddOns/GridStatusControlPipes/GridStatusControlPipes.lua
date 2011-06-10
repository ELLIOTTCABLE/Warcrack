local L = LibStub("AceLocale-3.0"):GetLocale("GridStatusControlPipes")

local GridPipe = GridPipeClass

GridStatusControlPipes = Grid:NewModule("GridSCP")

GridStatusControlPipes.defaultDB = {
    pipesDB = {}
}

local cp_options = {
    type = "group",
    name = L["Control pipes"],
    desc = L["General settings for control pipes."],
    args = {
        
    },
}

Grid.options.args["controlpipes"] = cp_options

    
function GridStatusControlPipes:OnInitialize()
	self.super.OnInitialize(self)
    
	GridPipe:Init(self.db.profile.pipesDB, cp_options)
end