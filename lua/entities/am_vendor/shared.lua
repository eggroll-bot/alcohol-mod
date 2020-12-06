ENT.Base = "base_ai"
ENT.Type = "ai"

ENT.PrintName		= "Alcohol Vendor"
ENT.Category 		= "Alcohol Mod"
ENT.Author			= "TheAsian EggrollMaker"

ENT.Contact    		= "theasianeggrollmaker@gmail.com"
ENT.Purpose 		= ""
ENT.Instructions 	= "Buys alcohol and resells it."

ENT.AutomaticFrameAdvance = true
ENT.Spawnable			= true
ENT.AdminSpawnable		= true

function ENT:SetupDataTables()
	self:NetworkVar( "String", 0, "VendorName" )
end
