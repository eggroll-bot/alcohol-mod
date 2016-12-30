AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:Initialize( )
	self:SetModel( "models/gibs/airboat_broken_engine.mdl" )
	self:SetUseType( SIMPLE_USE )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetFilled( false )
	self:SetPotStillTimer( -1 )
end

function ENT:SpawnFunction( _, tr )
	local spawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create( "am_potstill" )
	ent:SetPos( spawnPos )
	ent:Spawn( )
	ent:Activate( )

	return ent
end

function ENT:Think( )
	if ( not self.nextPotStill or CurTime( ) >= self.nextPotStill ) and ( self:GetPotStillTimer( ) > 0 ) then
		self:SetPotStillTimer( self:GetPotStillTimer( ) - 1 )
		self.nextPotStill = CurTime( ) + 1
	end
end

function ENT:Use( )
	if self:GetPotStillTimer( ) == 0 then
		self:SetFilled( false )
		ginbottle = ents.Create( "am_ginbottle" )
		ginbottle:SetPos( self:GetPos( ) + self:GetUp( ) * 12 )
		ginbottle:SetAngles( self:GetAngles( ) )
		ginbottle:Spawn( )
		ginbottle:GetPhysicsObject( ):SetVelocity( self:GetUp( ) * 2 )
		ginbottle:SetModel( "models/weapons/w_models/w_bottle.mdl" )
		self:SetPotStillTimer( -1 )
	end
end
