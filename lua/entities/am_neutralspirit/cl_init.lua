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

		if self:GetNeutralSpiritTimer( ) > 0 then
			draw.DrawText( "Timer: " .. math.Round( self:GetNeutralSpiritTimer( ) ) .. " seconds", "BarleyProcFont", 0, -150, Color( 255, 0, 0, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 25, 25, 25, 100 ) )
		end

		if self:GetFilled( ) then
			draw.DrawText( "Pour the soaked botanical into a pot still.", "BarleyProcFont", 0, -150, Color( 255, 0, 0, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 25, 25, 25, 100 ) )
		end

		cam.End3D2D( )
	end
end

net.Receive( "neutralspiritopen", function()
	local NeutralSpiritPanel = vgui.Create( "DFrame" )
	local neutralspirit = net.ReadEntity()
	NeutralSpiritPanel:SetSize( 500, 100 )
	NeutralSpiritPanel:Center( )
	NeutralSpiritPanel:SetTitle( "Neutral Spirit Pot" )
	NeutralSpiritPanel:SetVisible( true )
	NeutralSpiritPanel:SetDraggable( true )
	NeutralSpiritPanel:ShowCloseButton( true )
	NeutralSpiritPanel:MakePopup( )

	NeutralSpiritPanel.Paint = function( _, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 25, 25, 25, 250 ) )
	end

	local BotanicAmount = vgui.Create( "DLabel", NeutralSpiritPanel )
	BotanicAmount:SetPos( 10, 40 )
	BotanicAmount:SetText( "You have put in " .. neutralspirit:GetBotanicalAmount() .. "/1" )
	BotanicAmount:SetFont( "BarleyProcFont" )
	BotanicAmount:SizeToContents()

	local botanicalicon = vgui.Create( "DImage", NeutralSpiritPanel )
	botanicalicon:SetPos( 380, 30 )
	botanicalicon:SetSize( 40, 60 )
	botanicalicon:SetImage( "icons/botanical.png" )
end )
