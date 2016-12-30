AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )
util.AddNetworkString( "grapecrusheropen" )

function ENT:Initialize( )
	local WM_crusherTime = EggrollAM:GetConfig( "CrusherTimer" )
	local WM_maxGrapes = EggrollAM:GetConfig( "MaxGrapes" )
	self:SetUseType( SIMPLE_USE )
	self:SetNWInt( "time", WM_crusherTime )
	self:SetNWInt( "maxgrapes", WM_maxGrapes )
	self:SetModel( "models/props_wasteland/laundry_basket001.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetNWInt( "grapes", 0 )
	self:SetNWInt( "MaxTime", self:GetNWInt( "time" ) )
	self:SetNWInt( "status", 0 )
	self:SetNWInt( "must", 1 )
end

function ENT:SpawnFunction( _, tr )
	local spawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create( "wm_crusher" )
	ent:SetPos( spawnPos )
	ent:Spawn( )
	ent:Activate( )

	return ent
end

local effectData = EffectData( )

function ENT:PhysicsCollide( data )
	if ( ( data.DeltaTime > 0 ) and ( data.HitEntity:GetClass( ) == "wm_grapes" ) and self:GetNWInt( "grapes" ) < self:GetNWInt( "maxgrapes" ) ) then
		self:SetNWInt( "grapes", self:GetNWInt( "grapes" ) + 1 )
		data.HitEntity:Remove( )
	end
end

function ENT:OnTakeDamage( )
	effectData:SetStart( self:GetPos( ) )
	effectData:SetOrigin( self:GetPos( ) )
	effectData:SetScale( 1 )
	util.Effect( "watersplash", effectData )
	self:Remove( )
end

function ENT:Think( )
	if ( ( not self.nextCrush ) or ( CurTime( ) >= self.nextCrush ) ) and ( ( self:GetNWInt( "grapes" ) == self:GetNWInt( "maxgrapes" ) ) and ( self:GetNWInt( "status" ) == 0 ) ) then
		self:SetNWInt( "time", math.Clamp( self:GetNWInt( "time" ) - 1, 0, self:GetNWInt( "MaxTime" ) ) )
		self.nextCrush = CurTime( ) + 1
	end

	if ( self:GetNWInt( "time" ) == 0 ) and ( self:GetNWInt( "status" ) == 0 ) then
		self:SetNWInt( "status", 2 )
	end
end

function ENT:Use( _, caller )
	if ( self:GetNWInt( "status" ) == 2 ) then
		self:SetNWInt( "must", 0 )
	end

	if ( self:GetNWInt( "must" ) == 0 ) then
		wine = ents.Create( "wm_bottle" )
		wine:SetPos( self:GetPos( ) + self:GetUp( ) * 12 )
		wine:SetAngles( self:GetAngles( ) )
		wine:Spawn( )
		wine:GetPhysicsObject( ):SetVelocity( self:GetUp( ) * 2 )
		wine:SetModel( "models/props/cs_militia/bottle01.mdl" )
		self:SetNWInt( "time", self:GetNWInt( "MaxTime" ) )
		self:SetNWInt( "status", 0 )
		self:SetNWInt( "must", 1 )
		self:SetNWInt( "grapes", 0 )
	end

	net.Start( "grapecrusheropen" )
	net.WriteEntity( self )
	net.Send( caller )
end
