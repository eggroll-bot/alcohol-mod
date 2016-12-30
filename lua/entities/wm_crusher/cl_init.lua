include( "shared.lua" )

surface.CreateFont( "WineFont", {
	font = "HUDNumber",
	size = 50,
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
	outline = false
} )

function ENT:Initialize( )
end

function ENT:Draw( )
	self:DrawModel( )
	local pos = self:GetPos( )
	local ang = self:GetAngles( )
	ang:RotateAroundAxis( ang:Up( ), 90 )
	ang:RotateAroundAxis( ang:Forward( ), 90 )

	if LocalPlayer( ):GetPos( ):Distance( self:GetPos( ) ) < 256 and self:GetNWInt( "time" ) < 60 and self:GetNWInt( "time" ) > 0 then
		cam.Start3D2D( pos + ang:Up( ), Angle( 1, LocalPlayer( ):EyeAngles( ).y - 90, 90 ), .25 )
		draw.DrawText( "Time Left:  " .. math.Round( self:GetNWInt( "time" ) ) .. " sec", "WineFont", 0, -170, Color( 255, 0, 0, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 25, 25, 25, 100 ) )
		cam.End3D2D( )
	end

	if LocalPlayer( ):GetPos( ):Distance( self:GetPos( ) ) < 256 and self:GetNWInt( "status" ) == 2 and self:GetNWInt( "must" ) ~= 0 then
		cam.Start3D2D( pos + ang:Up( ), Angle( 1, LocalPlayer( ):EyeAngles( ).y - 90, 90 ), .25 )
		draw.DrawText( "Press 'E' On Me to remove must", "WineFont", 0, -170, Color( 255, 0, 0, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 25, 25, 25, 100 ) )
		cam.End3D2D( )
	end

	if LocalPlayer( ):GetPos( ):Distance( self:GetPos( ) ) < 256 and self:GetNWInt( "must" ) == 0 then
		cam.Start3D2D( pos + ang:Up( ), Angle( 1, LocalPlayer( ):EyeAngles( ).y - 90, 90 ), .25 )
		draw.DrawText( "Hit E on me to produce wine.", "WineFont", 0, -170, Color( 255, 0, 0, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 25, 25, 25, 100 ) )
		cam.End3D2D( )
	end
end

net.Receive( "grapecrusheropen", function()
	local GrapeCrusherPanel = vgui.Create( "DFrame" )
	local crusherent = net.ReadEntity()
	GrapeCrusherPanel:SetSize( 500, 100 )
	GrapeCrusherPanel:Center( )
	GrapeCrusherPanel:SetTitle( "Grape Crusher" )
	GrapeCrusherPanel:SetVisible( true )
	GrapeCrusherPanel:SetDraggable( true )
	GrapeCrusherPanel:ShowCloseButton( true )
	GrapeCrusherPanel:MakePopup( )

	GrapeCrusherPanel.Paint = function( _, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 25, 25, 25, 250 ) )
	end

	local GrapeAmount = vgui.Create( "DLabel", GrapeCrusherPanel )
	GrapeAmount:SetPos( 10, 40 )
	GrapeAmount:SetText( "You have put in " .. crusherent:GetNWInt( "grapes" ) .. "/" .. crusherent:GetNWInt( "maxgrapes" ) )
	GrapeAmount:SetFont( "WineFont" )
	GrapeAmount:SizeToContents()

	local GrapeIcon = vgui.Create( "DImage", GrapeCrusherPanel )
	GrapeIcon:SetPos( 425, 30 )
	GrapeIcon:SetSize( 40, 60 )
	GrapeIcon:SetImage( "icons/grapeicon.png" )
end )