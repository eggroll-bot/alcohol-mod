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

		if self:GetPotStillTimer( ) > 0 then
			draw.DrawText( "Timer: " .. math.Round( self:GetPotStillTimer( ) ) .. " seconds", "BarleyProcFont", 0, -150, Color( 255, 0, 0, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 25, 25, 25, 100 ) )
		end

		if self:GetPotStillTimer( ) == 0 then
			draw.DrawText( "Hit your use key on me.", "BarleyProcFont", 0, -150, Color( 255, 0, 0, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 25, 25, 25, 100 ) )
		end

		cam.End3D2D( )
	end
end
