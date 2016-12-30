AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )
util.AddNetworkString( "beerboileropen" )
local BoilerTimer

function ENT:Initialize( )
	self:SetModel( "models/props_c17/TrapPropeller_Engine.mdl" )
	self:SetUseType( SIMPLE_USE )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetBoilerTimer( -1 )
	self:SetGrainAmount( 0 )
	self:SetHopAmount( 0 )
	BoilerTimer = EggrollAM:GetConfig( "BoilerTimer" )
end

function ENT:SpawnFunction( _, tr )
	local spawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create( "am_boiler" )
	ent:SetPos( spawnPos )
	ent:Spawn( )
	ent:Activate( )

	return ent
end

function ENT:PhysicsCollide( data )
	if data.DeltaTime > 0 and data.HitEntity:GetClass( ) == "am_grain" and self:GetGrainAmount( ) < 1 then
		self:SetGrainAmount( self:GetGrainAmount( ) + 1 )
		data.HitEntity:Remove( )
	end

	if data.DeltaTime > 0 and data.HitEntity:GetClass( ) == "am_hops" and self:GetHopAmount( ) < 1 then
		self:SetHopAmount( self:GetHopAmount( ) + 1 )
		data.HitEntity:Remove( )
	end

	if self:GetGrainAmount( ) == 1 and self:GetHopAmount( ) == 1 and self:GetBoilerTimer( ) == -1 then
		self:SetBoilerTimer( BoilerTimer )
	end
end

function ENT:Think( )
	if ( not self.nextBoiler or CurTime( ) >= self.nextBoiler ) and ( self:GetBoilerTimer( ) > 0 ) then
		self:SetBoilerTimer( self:GetBoilerTimer( ) - 1 )
		self.nextBoiler = CurTime( ) + 1
	end
end

function ENT:Use( _, caller )
	local curTime = CurTime( )

	if ( not self.nextCreateBeer or curTime >= self.nextCreateBeer ) then
		if self:GetBoilerTimer( ) == 0 then
			self:SetGrainAmount( 0 )
			self:SetHopAmount( 0 )
			beer = ents.Create( "am_beer" )
			beer:SetPos( self:GetPos( ) + self:GetUp( ) * 12 )
			beer:SetAngles( self:GetAngles( ) )
			beer:Spawn( )
			beer:GetPhysicsObject( ):SetVelocity( self:GetUp( ) * 2 )
			beer:SetModel( "models/props_junk/GlassBottle01a.mdl" )
			self:SetBoilerTimer( -1 )
		end

		self.nextCreateBeer = curTime + 0.5
	end

	net.Start( "beerboileropen" )
	net.WriteEntity( self )
	net.Send( caller )
end
