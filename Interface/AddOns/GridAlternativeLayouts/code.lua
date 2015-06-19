-- This file is loaded from "GridAlternativeLayouts.toc"

local GridLayout = Grid:GetModule("GridLayout")

GridLayout:AddLayout("Sorted by 5", {
	{
		groupFilter = "1,2,3,4,5,6,7,8",
		groupBy = "ASSIGNEDROLE",
		groupingOrder = "TANK,HEALER,DAMAGER,NONE",
		unitsPerColumn = 5,
		maxColumns = 8,
	},
})

GridLayout:AddLayout("Sorted by 6", {
	{
		groupFilter = "1,2,3,4,5,6,7,8",
		groupBy = "ASSIGNEDROLE",
		groupingOrder = "TANK,HEALER,DAMAGER,NONE",
		unitsPerColumn = 6,
		maxColumns = 7,
	},
})

GridLayout:AddLayout("Sorted by 7", {
	{
		groupFilter = "1,2,3,4,5,6,7,8",
		groupBy = "ASSIGNEDROLE",
		groupingOrder = "TANK,HEALER,DAMAGER,NONE",
		unitsPerColumn = 7,
		maxColumns = 6,
	},
})

GridLayout:AddLayout("Sorted by 8", {
	{
		groupFilter = "1,2,3,4,5,6,7,8",
		groupBy = "ASSIGNEDROLE",
		groupingOrder = "TANK,HEALER,DAMAGER,NONE",
		unitsPerColumn = 8,
		maxColumns = 5,
	},
})