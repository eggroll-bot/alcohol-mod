include( "shared.lua" )

function ENT:Initialize( )
end

function ENT:Draw( )
	self:DrawModel( )
	local pos = self:GetPos( )
	local ang = self:GetAngles( )
	ang:RotateAroundAxis( ang:Up( ), 90 )
	ang:RotateAroundAxis( ang:Forward( ), 0 )

	if ( LocalPlayer( ):GetPos( ):Distance( self:GetPos( ) ) < 256 ) then
		cam.Start3D2D( pos + ang:Up( ), Angle( 1, LocalPlayer( ):EyeAngles( ).y - 90, 90 ), .25 )

		if self:GetBoilerTimer( ) > 0 then
			draw.DrawText( "Timer: " .. math.Round( self:GetBoilerTimer( ) ) .. " seconds", "BarleyProcFont", 0, -150, Color( 255, 0, 0, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 25, 25, 25, 100 ) )
		end

		if self:GetBoilerTimer( ) == 0 then
			draw.DrawText( "Hit E on me.", "BarleyProcFont", 0, -150, Color( 255, 0, 0, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 25, 25, 25, 100 ) )
		end
		cam.End3D2D( )
	end
end

net.Receive( "beerboileropen", function( )
	local BeerBoilerPanel = vgui.Create( "DFrame" )
	local boilerent = net.ReadEntity( )
	BeerBoilerPanel:SetSize( 500, 200 )
	BeerBoilerPanel:Center( )
	BeerBoilerPanel:SetTitle( "Boiler" )
	BeerBoilerPanel:SetVisible( true )
	BeerBoilerPanel:SetDraggable( true )
	BeerBoilerPanel:ShowCloseButton( true )
	BeerBoilerPanel:MakePopup( )

	BeerBoilerPanel.Paint = function( _, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 25, 25, 25, 250 ) )
	end

	local WholeGrainAmount = vgui.Create( "DLabel", BeerBoilerPanel )
	WholeGrainAmount:SetPos( 10, 40 )
	WholeGrainAmount:SetText( "You have put in " .. boilerent:GetGrainAmount( ) .. "/1" )
	WholeGrainAmount:SetFont( "BarleyProcFont" )
	WholeGrainAmount:SizeToContents( )
	local wholegrainbag = vgui.Create( "DImage", BeerBoilerPanel )
	wholegrainbag:SetPos( 385, 30 )
	wholegrainbag:SetSize( 40, 60 )
	wholegrainbag:SetImage( "icons/wholegrainbag.png" )
	local HopsAmount = vgui.Create( "DLabel", BeerBoilerPanel )
	HopsAmount:SetPos( 10, 130 )
	HopsAmount:SetText( "You have put in " .. boilerent:GetHopAmount( ) .. "/1" )
	HopsAmount:SetFont( "BarleyProcFont" )
	HopsAmount:SizeToContents( )
	local hopsicon = vgui.Create( "DImage", BeerBoilerPanel )
	hopsicon:SetPos( 385, 120 )
	hopsicon:SetSize( 40, 60 )
	hopsicon:SetImage( "icons/hops.png" )
end )
