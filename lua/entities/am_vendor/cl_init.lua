AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

surface.CreateFont( "AlcoholVendorFont", {
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

function ENT:Draw( )
	self:DrawModel( )
	local pos = self:GetPos( )
	local ang = self:GetAngles( )
	ang:RotateAroundAxis( ang:Up( ), 90 )
	ang:RotateAroundAxis( ang:Forward( ), 0 )
	cam.Start3D2D( pos + ang:Up( ), Angle( 1, LocalPlayer( ):EyeAngles( ).y - 90, 90 ), 0.25 )
	draw.DrawText( self:GetVendorName( ), "AlcoholVendorFont", 0, -325, Color( 0, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 25, 25, 25, 100 ) )
	cam.End3D2D( )
end

net.Receive( "alcoholvendoropen", function( )
	local EnableBuy = net.ReadBool( EnableBuy )
	local EnableSell = net.ReadBool( EnableSell )
	local AlcoholVendorPanel = vgui.Create( "DFrame" )
	AlcoholVendorPanel:SetSize( 250, 200 )
	AlcoholVendorPanel:Center( )
	AlcoholVendorPanel:SetTitle( "Buy or Sell" )
	AlcoholVendorPanel:SetVisible( true )
	AlcoholVendorPanel:SetDraggable( true )
	AlcoholVendorPanel:ShowCloseButton( true )
	AlcoholVendorPanel:MakePopup( )

	AlcoholVendorPanel.Paint = function( _, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 25, 25, 25, 250 ) )
	end

	local AVPBuyButton = vgui.Create( "DButton", AlcoholVendorPanel )
	AVPBuyButton:SetText( "Buy" )
	AVPBuyButton:SetSize( 100, 50 )
	AVPBuyButton:SetPos( 75, 40 )

	if EnableBuy then
		AVPBuyButton.DoClick = function( )
			local AVBuyFrame = vgui.Create( "DFrame" )
			AVBuyFrame:SetSize( 250, 200 )
			AVBuyFrame:Center( )
			AVBuyFrame:SetTitle( "Buy Menu" )
			AVBuyFrame:SetVisible( true )
			AVBuyFrame:SetDraggable( true )
			AVBuyFrame:ShowCloseButton( true )
			AVBuyFrame:MakePopup( )

			AVBuyFrame.Paint = function( _, w, h )
				draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 250 ) )
			end

			AVPBuyButton:Remove( )
			AlcoholVendorPanel:Remove( )
			local AVPBuyBeerButton = vgui.Create( "DButton", AVBuyFrame )
			AVPBuyBeerButton:SetText( "Buy Beer" )
			AVPBuyBeerButton:SetSize( 75, 25 )
			AVPBuyBeerButton:SetPos( 90, 40 )

			AVPBuyBeerButton.DoClick = function( )
				net.Start( "AVBuyBeer" )
				net.SendToServer( )
				AVBuyFrame:Remove( )
			end

			local AVPBuyWineButton = vgui.Create( "DButton", AVBuyFrame )
			AVPBuyWineButton:SetText( "Buy Wine" )
			AVPBuyWineButton:SetSize( 75, 25 )
			AVPBuyWineButton:SetPos( 90, 95 )

			AVPBuyWineButton.DoClick = function( )
				net.Start( "AVBuyWine" )
				net.SendToServer( )
				AVBuyFrame:Remove( )
			end

			local AVPBuyGinButton = vgui.Create( "DButton", AVBuyFrame )
			AVPBuyGinButton:SetText( "Buy Gin" )
			AVPBuyGinButton:SetSize( 75, 25 )
			AVPBuyGinButton:SetPos( 90, 150 )

			AVPBuyGinButton.DoClick = function( )
				net.Start( "AVBuyGin" )
				net.SendToServer( )
				AVBuyFrame:Remove( )
			end
		end
	else
		AVPBuyButton.DoClick = function( )
			LocalPlayer( ):ChatPrint( "Buying is disabled on this server." )
			AlcoholVendorPanel:Remove( )
		end
	end

	local AVPSellButton = vgui.Create( "DButton", AlcoholVendorPanel )
	AVPSellButton:SetText( "Sell" )
	AVPSellButton:SetSize( 100, 50 )
	AVPSellButton:SetPos( 75, 125 )

	if EnableSell then
		AVPSellButton.DoClick = function( )
			net.Start( "AVSellAll" )
			net.SendToServer( )
			AlcoholVendorPanel:Remove( )
		end
	else
		AVPSellButton.DoClick = function( )
			LocalPlayer( ):ChatPrint( "Selling is disabled on this server." )
			AlcoholVendorPanel:Remove( )
		end
	end
end )
