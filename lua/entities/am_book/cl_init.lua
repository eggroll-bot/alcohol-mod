include( "shared.lua" )

function ENT:Initialize( )
end

function ENT:Draw( )
	self:DrawModel( )
end

net.Receive( "ambookopen", function( )
	local BookPanelP1 = vgui.Create( "DFrame" )
	BookPanelP1:SetSize( 370, 700 )
	BookPanelP1:Center( )
	BookPanelP1:SetTitle( "Title Page" )
	BookPanelP1:SetVisible( true )
	BookPanelP1:SetDraggable( true )
	BookPanelP1:ShowCloseButton( true )
	BookPanelP1:MakePopup( )

	BookPanelP1.Paint = function( _, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 25, 25, 25, 250 ) )
	end

	local PageOneText = vgui.Create( "DLabel", BookPanelP1 )
	PageOneText:SetPos( 80, 200 )
	PageOneText:SetText( "       Instructions Book\nBy: TheAsian EggrollMaker" )
	PageOneText:SetFont( "GModNotify" )
	PageOneText:SetContentAlignment( 8 )
	PageOneText:SizeToContents( )
	local NextPageButton = vgui.Create( "DButton" )
	NextPageButton:SetParent( BookPanelP1 )
	NextPageButton:SetText( "Next Page" )
	NextPageButton:SetPos( 60, 500 )
	NextPageButton:SetSize( 250, 30 )

	NextPageButton.DoClick = function( )
		hook.Run( "AMBookPanelP2" )
		PageOneText:Remove( )
		NextPageButton:Remove( )
		BookPanelP1:Remove( )
	end
end )

local function AMBookPanelP2( )
	local BookPanelP2 = vgui.Create( "DFrame" )
	BookPanelP2:SetSize( 370, 700 )
	BookPanelP2:Center( )
	BookPanelP2:SetTitle( "Part I: Beer Instructions" )
	BookPanelP2:SetVisible( true )
	BookPanelP2:SetDraggable( true )
	BookPanelP2:ShowCloseButton( true )
	BookPanelP2:MakePopup( )

	BookPanelP2.Paint = function( _, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 25, 25, 25, 250 ) )
	end

	local PageTwoText = vgui.Create( "DLabel", BookPanelP2 )
	PageTwoText:SetPos( 15, 50 )
	PageTwoText:SetText( [[1. Buy a wad of barley.

	2. Pickup the barley with your use key.

	3. Hit your use key on the barley processor.
	   Whole grain will come out.

	4. Buy a pot of hops.

	5. Buy a boiler. You can check the amount
	   of hops and/or whole grain you have
	   inside by using your use key on it.

	6. Use your gravity gun to drag the hops
	   and whole grain into boiler.

	7. Wait until the timer is up.

	8. Hit your use key on the boiler when
	   done. A beer bottle will come out.
	   Use your reload key to pick it up or
	   your use key to drink it.

	9. If a beer bottle is picked up, it can
	   be brought to the vendor and sold for
	   money.]] )
	PageTwoText:SetFont( "GModNotify" )
	PageTwoText:SizeToContents( )
	local NextPageButton = vgui.Create( "DButton" )
	NextPageButton:SetParent( BookPanelP2 )
	NextPageButton:SetText( "Next Page" )
	NextPageButton:SetPos( 60, 600 )
	NextPageButton:SetSize( 250, 30 )

	NextPageButton.DoClick = function( )
		hook.Run( "AMBookPanelP3" )
		PageTwoText:Remove( )
		NextPageButton:Remove( )
		BookPanelP2:Remove( )
	end
end

hook.Add( "AMBookPanelP2", "AMBookPanelP2", AMBookPanelP2 )

local function AMBookPanelP3( )
	local BookPanelP3 = vgui.Create( "DFrame" )
	BookPanelP3:SetSize( 370, 700 )
	BookPanelP3:Center( )
	BookPanelP3:SetTitle( "Part II: Wine Instructions" )
	BookPanelP3:SetVisible( true )
	BookPanelP3:SetDraggable( true )
	BookPanelP3:ShowCloseButton( true )
	BookPanelP3:MakePopup( )

	BookPanelP3.Paint = function( _, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 25, 25, 25, 250 ) )
	end

	local PageThreeText = vgui.Create( "DLabel", BookPanelP3 )
	PageThreeText:SetPos( 30, 50 )
	PageThreeText:SetText( [[1. Buy five grapes.

	2. Buy a crusher. You can check the
	   amount of grapes you have inside
	   by using your use key on it.

	3. Use your gravity gun to bring the five
	   grapes into the crusher.

	4. Wait for the timer to be up.

	5. When the timer is up, hit your use key
	   to remove the must.

	6. Then, hit your use key again. You
	   should now have a wine bottle.

	7. Hit your use key to drink it or your
	   reload key to pick it up.

	8. If a wine bottle is picked up, it can
	   be sold to a vendor for money.]] )
	PageThreeText:SetFont( "GModNotify" )
	PageThreeText:SizeToContents( )
	local NextPageButton = vgui.Create( "DButton" )
	NextPageButton:SetParent( BookPanelP3 )
	NextPageButton:SetText( "Next Page" )
	NextPageButton:SetPos( 60, 600 )
	NextPageButton:SetSize( 250, 30 )

	NextPageButton.DoClick = function( )
		hook.Run( "AMBookPanelP4" )
		PageThreeText:Remove( )
		NextPageButton:Remove( )
		BookPanelP3:Remove( )
	end
end

hook.Add( "AMBookPanelP3", "AMBookPanelP3", AMBookPanelP3 )

local function AMBookPanelP4( )
	local BookPanelP4 = vgui.Create( "DFrame" )
	BookPanelP4:SetSize( 370, 700 )
	BookPanelP4:Center( )
	BookPanelP4:SetTitle( "Part III: Gin Instructions" )
	BookPanelP4:SetVisible( true )
	BookPanelP4:SetDraggable( true )
	BookPanelP4:ShowCloseButton( true )
	BookPanelP4:MakePopup( )

	BookPanelP4.Paint = function( _, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 25, 25, 25, 250 ) )
	end

	local PageFourText = vgui.Create( "DLabel", BookPanelP4 )
	PageFourText:SetPos( 40, 50 )
	PageFourText:SetText( [[1. Buy a botanical.

	2. Buy a neutral spirit pot.

	3. Use your gravity gun to bring the
	   botanical into the neutral spirit pot.

	4. Wait for the timer to be finished.

	5. When the timer is finished, buy a
	   pot still.

	6. Use your gravity gun to pour the
	   contents inside of the neutral spirit
	   pot into the pot still.

	7. Wait for the timer to be finished.

	8. When the timer is done, hit your
	   use key.

	9. You should now have a gin bottle.

	10. Hit your use key to drink it or your
		reload key to pick it up.

	11. If a gin bottle is picked up, it can
		be sold to a vendor for money.]] )
	PageFourText:SetFont( "GModNotify" )
	PageFourText:SizeToContents( )
	local ClosePanelButton = vgui.Create( "DButton" )
	ClosePanelButton:SetParent( BookPanelP4 )
	ClosePanelButton:SetText( "Close Book" )
	ClosePanelButton:SetPos( 60, 600 )
	ClosePanelButton:SetSize( 250, 30 )

	ClosePanelButton.DoClick = function( )
		PageFourText:Remove( )
		ClosePanelButton:Remove( )
		BookPanelP4:Remove( )
	end
end

hook.Add( "AMBookPanelP4", "AMBookPanelP4", AMBookPanelP4 )
