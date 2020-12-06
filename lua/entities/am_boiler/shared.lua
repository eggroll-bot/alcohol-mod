ENT.Base = "base_gmodentity"
ENT.Type = "anim"

ENT.PrintName		= "Boiler"
ENT.Category 		= "Alcohol Mod"
ENT.Author			= "TheAsian EggrollMaker"

ENT.Contact    		= "theasianeggrollmaker@gmail.com"
ENT.Purpose 		= ""
ENT.Instructions 	= "Boils the grain and hops."

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

function ENT:SetupDataTables()
	self:NetworkVar( "Float", 0, "GrainAmount" )
	self:NetworkVar( "Float", 1, "HopAmount" )
	self:NetworkVar( "Float", 2, "BoilerTimer" )
end
