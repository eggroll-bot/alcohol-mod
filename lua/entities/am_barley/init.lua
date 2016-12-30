AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel ( "models/alcoholmod/barley.mdl" )
	self:SetMaterial( "models/player/shared/gold_player", true )
	self:SetModelScale( 7 )
	self:PhysicsInit (SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
end

function ENT:SpawnFunction ( _, tr )
	local spawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create ( "am_barley" )
	ent:SetPos(spawnPos)
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Use( _, caller )
	caller:SetNWInt( "Barley", caller:GetNWInt( "Barley" ) + 1 )
	if caller:GetNWInt( "Barley" ) == 1 then
		caller:ChatPrint( "You now have 1 wad of barley." )
	elseif caller:GetNWInt( "Barley" ) > 1 then
		caller:ChatPrint( "You now have " .. caller:GetNWInt( "Barley" ) .. " wads of barley." )
	end
	self:Remove()
end
