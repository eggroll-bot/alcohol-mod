AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )
util.AddNetworkString( "ambookopen" )

function ENT:Initialize( )
	self:SetModel( "models/alcoholmod/book.mdl" )
	self:SetMaterial( "models/props_pipes/GutterMetal01a", true )
	self:SetUseType( SIMPLE_USE )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
end

function ENT:SpawnFunction( _, tr )
	local spawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create( "am_book" )
	ent:SetPos( spawnPos )
	ent:Spawn( )
	ent:Activate( )

	return ent
end

function ENT:Use( _, caller )
	net.Start( "ambookopen" )
	net.Send( caller )
end
