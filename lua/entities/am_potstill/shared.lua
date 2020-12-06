ENT.Base = "base_gmodentity"
ENT.Type = "anim"

ENT.PrintName		= "Pot Still"
ENT.Category 		= "Alcohol Mod"
ENT.Author			= "TheAsian EggrollMaker"

ENT.Contact    		= "theasianeggrollmaker@gmail.com"
ENT.Purpose 		= ""
ENT.Instructions 	= "Pot Still"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

function ENT:SetupDataTables()
	self:NetworkVar( "Bool", 0, "Filled" )
	self:NetworkVar( "Float", 0, "PotStillTimer" )
end
