AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )
util.AddNetworkString( "StartAMBeerEffect" )

function ENT:Initialize( )
	self:SetModel( "models/props_junk/GlassBottle01a.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
end

function ENT:SpawnFunction( _, tr )
	local spawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create( "am_beer" )
	ent:SetPos( spawnPos )
	ent:Spawn( )
	ent:Activate( )

	return ent
end

function EggrollAMBeerEffect( ply )
	local AddHealth = EggrollAM:GetConfig( "AddHealthBeer" )
	local AddArmor = EggrollAM:GetConfig( "AddArmorBeer" )
	ply:SetHealth( ply:Health( ) + AddHealth )
	ply:SetArmor( ply:Armor( ) + AddArmor )
	net.Start( "StartAMBeerEffect" )
	net.WriteFloat( EggrollAM:GetConfig( "DrunkEffectTime" ) )
	net.Send( ply )
	ply:ChatPrint( "You drank a bottle of beer." )
end

local function EggrollDetectInputBeer( ply, inputkey )
	if inputkey == IN_RELOAD and ply:GetEyeTrace( ).Entity:GetClass( ) == "am_beer" and ply:GetPos( ):Distance( ply:GetEyeTrace( ).Entity:GetPos( ) ) < 256 then
		ply:SetNWInt( "EggrollBeerAmount", ply:GetNWInt( "EggrollBeerAmount", 0 ) + 1 )
		ply:ChatPrint( "You have picked up a beer. Go sell it." )
		ply:GetEyeTrace( ).Entity:Remove( )
	elseif inputkey == IN_USE and ply:GetEyeTrace( ).Entity:GetClass( ) == "am_beer" and ply:GetPos( ):Distance( ply:GetEyeTrace( ).Entity:GetPos( ) ) < 256 then
		EggrollAMBeerEffect( ply )
		ply:GetEyeTrace( ).Entity:Remove( )
	end
end

hook.Add( "KeyPress", "EggrollDetectInputBeer", EggrollDetectInputBeer )
