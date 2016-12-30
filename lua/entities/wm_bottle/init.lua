AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )
util.AddNetworkString( "StartAMWineEffect" )

function ENT:Initialize( )
	self:SetModel( "models/props/cs_militia/bottle01.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
end

function ENT:SpawnFunction( _, tr )
	local spawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create( "wm_bottle" )
	ent:SetPos( spawnPos )
	ent:Spawn( )
	ent:Activate( )

	return ent
end

function EggrollAMWineEffect( ply )
	local AddHealth = EggrollAM:GetConfig( "AddHealthWine" )
	local AddArmor = EggrollAM:GetConfig( "AddArmorWine" )
	ply:SetHealth( ply:Health( ) + AddHealth )
	ply:SetArmor( ply:Armor( ) + AddArmor )
	net.Start( "StartAMWineEffect" )
	net.WriteFloat( EggrollAM:GetConfig( "DrunkEffectTime" ) )
	net.Send( ply )
	ply:ChatPrint( "You drank a bottle of wine." )
end

local function EggrollDetectInputWine( ply, inputkey )
	if inputkey == IN_RELOAD and ply:GetEyeTrace( ).Entity:GetClass( ) == "wm_bottle" and ply:GetPos( ):Distance( ply:GetEyeTrace( ).Entity:GetPos( ) ) < 256 then
		ply:SetNWInt( "EggrollWineAmount", ply:GetNWInt( "EggrollWineAmount", 0 ) + 1 )
		ply:ChatPrint( "You have picked up a bottle of wine. Go sell it." )
		ply:GetEyeTrace( ).Entity:Remove( )
	elseif inputkey == IN_USE and ply:GetEyeTrace( ).Entity:GetClass( ) == "wm_bottle" and ply:GetPos( ):Distance( ply:GetEyeTrace( ).Entity:GetPos( ) ) < 256 then
		EggrollAMWineEffect( ply )
		ply:GetEyeTrace( ).Entity:Remove( )
	end
end

hook.Add( "KeyPress", "EggrollDetectInputWine", EggrollDetectInputWine )
