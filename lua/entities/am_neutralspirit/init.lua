AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )
util.AddNetworkString( "neutralspiritopen" )
local NeutralSpiritTimer

function ENT:Initialize( )
	self:SetModel( "models/props_wasteland/laundry_basket001.mdl" )
	self:SetUseType( SIMPLE_USE )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetNeutralSpiritTimer( -1 )
	self:SetBotanicalAmount( 0 )
	NeutralSpiritTimer = EggrollAM:GetConfig( "NeutralSpiritTimer" )
	self:SetFilled( false )
end

function ENT:SpawnFunction( _, tr )
	local spawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create( "am_neutralspirit" )
	ent:SetPos( spawnPos )
	ent:Spawn( )
	ent:Activate( )

	return ent
end

function ENT:PhysicsCollide( data )
	if data.DeltaTime > 0 and data.HitEntity:GetClass( ) == "am_botanical" and self:GetBotanicalAmount( ) < 1 then
		self:SetBotanicalAmount( self:GetBotanicalAmount( ) + 1 )
		data.HitEntity:Remove( )
	end

	if self:GetBotanicalAmount( ) == 1 and self:GetNeutralSpiritTimer( ) == -1 then
		self:SetNeutralSpiritTimer( NeutralSpiritTimer )
	end

	if self:GetFilled( ) and data.HitEntity:GetClass( ) == "am_potstill" then
		self:SetBotanicalAmount( 0 )
		data.HitEntity:SetFilled( true )
		data.HitEntity:SetPotStillTimer( EggrollAM:GetConfig( "PotStillTimer" ) )
		self:SetFilled( false )
		self:SetNeutralSpiritTimer( -1 )
	end
end

function ENT:Think( )
	if ( not self.nextNeutralSpirit or CurTime( ) >= self.nextNeutralSpirit ) and ( self:GetNeutralSpiritTimer( ) > 0 ) then
		self:SetNeutralSpiritTimer( self:GetNeutralSpiritTimer( ) - 1 )
		self.nextNeutralSpirit = CurTime( ) + 1
	end

	if self:GetNeutralSpiritTimer( ) == 0 then
		self:SetFilled( true )
	end
end

function ENT:Use( _, caller )
	net.Start( "neutralspiritopen" )
	net.WriteEntity( self )
	net.Send( caller )
end