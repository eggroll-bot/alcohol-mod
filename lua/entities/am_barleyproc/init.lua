AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel ( "models/alcoholmod/barleyproc.mdl" )
	self:SetMaterial( "models/props_c17/FurnitureMetal001a", true )
	self:PhysicsInit (SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
end

function ENT:SpawnFunction ( _, tr )
	local spawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create ( "am_barleyproc" )
	ent:SetPos(spawnPos)
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Use( _, caller )
	if caller:GetNWInt( "Barley" ) > 0 then
		grain = ents.Create ( "am_grain" )
		grain:SetPos( self:GetPos() + self:GetUp() * 12 )
		grain:SetAngles( self:GetAngles() )
		grain:Spawn()
		grain:GetPhysicsObject():SetVelocity( self:GetUp() * 2 )
		grain:SetModel( "models/props_granary/grain_sack.mdl" )
		caller:SetNWInt( "Barley", caller:GetNWInt( "Barley" ) - 1 )
		return false
	end
end
