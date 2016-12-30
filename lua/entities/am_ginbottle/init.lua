AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )
util.AddNetworkString( "StartAMGinEffect" )

function ENT:Initialize( )
	self:SetModel( "models/weapons/w_models/w_bottle.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
end

function ENT:SpawnFunction( _, tr )
	local spawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create( "am_ginbottle" )
	ent:SetPos( spawnPos )
	ent:Spawn( )
	ent:Activate( )

	return ent
end

function EggrollAMGinEffect( ply )
	local AddHealth = EggrollAM:GetConfig( "AddHealthGin" )
	local AddArmor = EggrollAM:GetConfig( "AddArmorGin" )
	ply:SetHealth( ply:Health( ) + AddHealth )
	ply:SetArmor( ply:Armor( ) + AddArmor )
	net.Start( "StartAMGinEffect" )
	net.WriteFloat( EggrollAM:GetConfig( "DrunkEffectTime" ) )
	net.Send( ply )
	ply:ChatPrint( "You drank a bottle of gin." )
end

local function EggrollDetectInputGin( ply, inputkey )
	if inputkey == IN_RELOAD and ply:GetEyeTrace( ).Entity:GetClass( ) == "am_ginbottle" and ply:GetPos( ):Distance( ply:GetEyeTrace( ).Entity:GetPos( ) ) < 256 then
		ply:SetNWInt( "EggrollGinAmount", ply:GetNWInt( "EggrollGinAmount", 0 ) + 1 ) -- Add gin into NPC shop.
		ply:ChatPrint( "You have picked up a bottle of gin. Go sell it." )
		ply:GetEyeTrace( ).Entity:Remove( )
	elseif inputkey == IN_USE and ply:GetEyeTrace( ).Entity:GetClass( ) == "am_ginbottle" and ply:GetPos( ):Distance( ply:GetEyeTrace( ).Entity:GetPos( ) ) < 256 then
		EggrollAMGinEffect( ply )
		ply:GetEyeTrace( ).Entity:Remove( )
	end
end

hook.Add( "KeyPress", "EggrollDetectInputGin", EggrollDetectInputGin )
