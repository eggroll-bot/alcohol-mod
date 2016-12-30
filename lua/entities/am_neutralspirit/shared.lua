ENT.Base = "base_gmodentity"
ENT.Type = "anim"

ENT.PrintName		= "Neutral Spirit"
ENT.Category 		= "Alcohol Mod"
ENT.Author			= "TheAsian EggrollMaker"

ENT.Contact    		= "brian@melonscriptsinc.mm.my"
ENT.Purpose 		= ""
ENT.Instructions 	= "Pot of neutral spirit"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

function ENT:SetupDataTables()
	self:NetworkVar( "Float", 0, "BotanicalAmount" )
	self:NetworkVar( "Float", 1, "NeutralSpiritTimer" )
	self:NetworkVar( "Bool", 0, "Filled" )
end
