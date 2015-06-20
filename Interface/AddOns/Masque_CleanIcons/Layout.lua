local MSQ = LibStub("Masque", true)
if not MSQ then return end

local version = GetAddOnMetadata("Masque_CleanIcons","Version")

-- Clean Icons - Square
MSQ:AddSkin("Clean Icons - Square", {
	Author = "Suicidal Katt",
	Version = version,
	Shape = "Square",
	Masque_Version = 40200,
	Backdrop = {
		Width = 38,
		Height = 38,
		Color = {1,1,1,1},
		Texture = [[Interface\AddOns\Masque_CleanIcons\Textures\Backdrop_Square]],
	},
	Icon = {
		Width = 38,
		Height = 38,
		TexCoords = {0,1,0,1},
	},
	Flash = {
		Width = 38,
		Height = 38,
		Color = {1, 0, 0, 1},
		Texture = [[Interface\AddOns\Masque_CleanIcons\Textures\Overlay_Square]],
	},
	Cooldown = {
		Width = 38,
		Height = 38,
	},
	Pushed = {
		Width = 38,
		Height = 38,
		Color = {1, 1, 1, 1},
		Texture = [[Interface\AddOns\Masque_CleanIcons\Textures\Overlay_Square]],
	},
	Normal = {
		Width = 38,
		Height = 38,
		Static = true,
		Color = {0, 0, 0, 0},
		Texture = [[Interface\AddOns\Masque_CleanIcons\Textures\Normal_Square]],
	},
	Disabled = {
		Hide = true,
	},
	Checked = {
		Width = 38,
		Height = 38,
		BlendMode = "ADD",
		Color = {0, 0.47, 1, 1},
		Texture = [[Interface\AddOns\Masque_CleanIcons\Textures\Border_Square]],
	},
	Border = {
		Width = 38,
		Height = 38,
		BlendMode = "ALPHAKEY",
		Texture = [[Interface\AddOns\Masque_CleanIcons\Textures\Border_Square]],
	},
	Gloss = {
		Width = 38,
		Height = 38,
		Texture = [[Interface\AddOns\Masque_CleanIcons\Textures\Gloss_Square]],
	},
	AutoCastable = {
		Width = 38,
		Height = 38,
		OffsetX = 0.5,
		OffsetY = -0.5,
		Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
	},
	Highlight = {
		Width = 38,
		Height = 38,
		BlendMode = "ALPHAKEY",
		Color = {1, 1, 1, 0.9},
		Texture = [[Interface\AddOns\Masque_CleanIcons\Textures\Highlight_Square]],
	},
	Name = {
		Width = 38,
		Height = 10,
		OffsetY = 2,
	},
	Count = {
		Width = 38,
		Height = 10,
		OffsetX = -2,
		OffsetY = 2,
		FontSize = 13,
	},
	HotKey = {
		Width = 38,
		Height = 10,
		OffsetX = -1,
		OffsetY = -2,
	},
	AutoCast = {
		Width = 36,
		Height = 36,
		OffsetX = 1,
		OffsetY = -1,
	},
}, true)

MSQ:AddSkin("Clean Icons - Original", {
	Author = "Suicidal Katt",
	Version = version,
	Shape = "Square",
	Masque_Version = 40200,
	Backdrop = {
		Width = 38,
		Height = 38,
		Color = {1,1,1,1},
		Texture = [[Interface\AddOns\Masque_CleanIcons\Textures\Backdrop_Original]],
	},
	Icon = {
		Width = 38,
		Height = 38,
		TexCoords = {0,1,0,1},
	},
	Flash = {
		Width = 38,
		Height = 38,
		Color = {1, 0, 0, 1},
		Texture = [[Interface\AddOns\Masque_CleanIcons\Textures\Overlay_Original]],
	},
	Cooldown = {
		Width = 36,
		Height = 36,
	},
	Pushed = {
		Width = 38,
		Height = 38,
		Color = {1, 1, 1, 1},
		Texture = [[Interface\AddOns\Masque_CleanIcons\Textures\Normal_Original]],
	},
	Normal = {
		Width = 38,
		Height = 38,
		Static = true,
		Color = {0, 0, 0, 0},
		Texture = [[Interface\AddOns\Masque_CleanIcons\Textures\Normal_Original]],
	},
	Disabled = {
		Hide = true,
	},
	Checked = {
		Width = 38,
		Height = 38,
		BlendMode = "ADD",
		Color = {0, 0.47, 1, 1},
		Texture = [[Interface\AddOns\Masque_CleanIcons\Textures\Border_Original]],
	},
	Border = {
		Width = 38,
		Height = 38,
		BlendMode = "ALPHAKEY",
		Texture = [[Interface\AddOns\Masque_CleanIcons\Textures\Border_Original]],
	},
	Gloss = {
		Width = 38,
		Height = 38,
		Texture = [[Interface\AddOns\Masque_CleanIcons\Textures\Gloss_Original]],
	},
	AutoCastable = {
		Width = 38,
		Height = 38,
		OffsetX = 0.5,
		OffsetY = -0.5,
		Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
	},
	Highlight = {
		Width = 38,
		Height = 38,
		BlendMode = "ALPHAKEY",
		Color = {1, 1, 1, 0.9},
		Texture = [[Interface\AddOns\Masque_CleanIcons\Textures\Highlight_Original]],
	},
	Name = {
		Width = 38,
		Height = 10,
		OffsetY = 2,
	},
	Count = {
		Width = 38,
		Height = 10,
		OffsetX = -2,
		OffsetY = 2,
		FontSize = 13,
	},
	HotKey = {
		Width = 38,
		Height = 10,
		OffsetX = -1,
		OffsetY = -2,
	},
	AutoCast = {
		Width = 36,
		Height = 36,
		OffsetX = 1,
		OffsetY = -1,
	},
}, true)
