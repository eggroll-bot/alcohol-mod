include( "shared.lua" )

function ENT:Initialize( )
end

function ENT:Draw( )
	self:DrawModel( )
end

net.Receive( "StartAMBeerEffect", function( )
	local DrunkBlurTime = net.ReadFloat( )

	if timer.Exists( "EggrollAMDrunkBlur" ) then
		timer.Remove( "EggrollAMDrunkBlur" )
	end

	timer.Create( "EggrollAMDrunkBlur", DrunkBlurTime, 1, function( ) end )
end )

local function AMStartEffect( )
	if timer.Exists( "EggrollAMDrunkBlur" ) then
		DrawMotionBlur( 0.03, 10, 0 )
	end
end

hook.Add( "RenderScreenspaceEffects", "AMStartEffect", AMStartEffect )
