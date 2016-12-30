AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel ( "models/grapes/grapes.mdl" )
    self:SetMaterial( "mofoak", true )
    self:PhysicsInit (SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetModelScale ( 2, 0 )
end

function ENT:SpawnFunction (ply, tr)
    local spawnPos = tr.HitPos + tr.HitNormal *16
    local ent = ents.Create ( "wm_grapes" )
    ent:SetPos(spawnPos)
    ent:Spawn()
    ent:Activate()
    return ent
end

function ENT:OnTakeDamage(dmginfo)
    local effectData = EffectData()
    effectData:SetStart(self:GetPos())
    effectData:SetOrigin(self:GetPos())
    effectData:SetScale(1)
    util.Effect( "watersplash", effectData )
    self:Remove()
end