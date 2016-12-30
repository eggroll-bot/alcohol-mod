include( "shared.lua" )

function ENT:Initialize()
end

surface.CreateFont( "BarleyProcFont", {
	font = "HUDNumber",
	size = 40,
	weight = 600,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

function ENT:Draw()
	self:DrawModel()
end
