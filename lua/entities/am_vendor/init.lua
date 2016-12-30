AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )
util.AddNetworkString( "alcoholvendoropen" )
util.AddNetworkString( "AVBuyBeer" )
util.AddNetworkString( "AVBuyWine" )
util.AddNetworkString( "AVBuyGin" )
util.AddNetworkString( "AVSellAll" )
local AVBuyPriceBeer
local AVSellPriceBeer
local AVBuyPriceWine
local AVSellPriceWine
local EnableBuy
local EnableSell

function ENT:Initialize( )
	self.AutomaticFrameAdvance = true
	self:SetModel( "models/eli.mdl" )
	self:SetHullType( HULL_HUMAN )
	self:SetSolid( SOLID_BBOX )
	self:SetHullSizeNormal( )
	self:SetNPCState( NPC_STATE_SCRIPT )
	self:CapabilitiesAdd( CAP_ANIMATEDFACE )
	self:SetUseType( SIMPLE_USE )
	self:DropToFloor( )
	AVBuyPriceBeer = EggrollAM:GetConfig( "AVBuyPriceBeer" )
	AVSellPriceBeer = EggrollAM:GetConfig( "AVSellPriceBeer" )
	AVBuyPriceWine = EggrollAM:GetConfig( "AVBuyPriceWine" )
	AVSellPriceWine = EggrollAM:GetConfig( "AVSellPriceWine" )
	AVBuyPriceGin = EggrollAM:GetConfig( "AVBuyPriceGin" )
	AVSellPriceGin = EggrollAM:GetConfig( "AVSellPriceGin" )
	EnableBuy = EggrollAM:GetConfig( "EnableBuy" )
	EnableSell = EggrollAM:GetConfig( "EnableSell" )
	self:SetVendorName( EggrollAM:GetConfig( "VendorName" ) )
end

function ENT:AcceptInput( _, _, caller )
	net.Start( "alcoholvendoropen" )
	net.WriteBool( EnableBuy )
	net.WriteBool( EnableSell )
	net.Send( caller )
end

net.Receive( "AVBuyBeer", function( _, ply )
	if ply:canAfford( AVBuyPriceBeer ) then
		EggrollAMBeerEffect( ply )
	else
		ply:ChatPrint( "You cannot afford beer." )
	end
end )

net.Receive( "AVBuyWine", function( _, ply )
	if ply:canAfford( AVBuyPriceWine ) then
		EggrollAMWineEffect( ply )
	else
		ply:ChatPrint( "You cannot afford wine." )
	end
end )

net.Receive( "AVBuyGin", function( _, ply )
	if ply:canAfford( AVBuyPriceGin ) then
		EggrollAMGinEffect( ply )
	else
		ply:ChatPrint( "You cannot afford gin." )
	end
end )

net.Receive( "AVSellAll", function( _, ply )
	local nobeertosell
	local nowinetosell
	local nogintosell

	if ply:GetNWInt( "EggrollBeerAmount", 0 ) > 0 then
		local SellAllPrice = AVSellPriceBeer * ply:GetNWInt( "EggrollBeerAmount", 0 )
		ply:addMoney( SellAllPrice )
		ply:SetNWInt( "EggrollBeerAmount", 0 )
		ply:ChatPrint( "You've been given $" .. SellAllPrice .. " for selling beer." )
	else
		nobeertosell = true
	end

	if ply:GetNWInt( "EggrollWineAmount", 0 ) > 0 then
		local SellAllPrice = AVSellPriceWine * ply:GetNWInt( "EggrollWineAmount", 0 )
		ply:addMoney( SellAllPrice )
		ply:SetNWInt( "EggrollWineAmount", 0 )
		ply:ChatPrint( "You've been given $" .. SellAllPrice .. " for selling wine." )
	else
		nowinetosell = true
	end

	if ply:GetNWInt( "EggrollGinAmount", 0 ) > 0 then
		local SellAllPrice = AVSellPriceGin * ply:GetNWInt( "EggrollGinAmount", 0 )
		ply:addMoney( SellAllPrice )
		ply:SetNWInt( "EggrollGinAmount", 0 )
		ply:ChatPrint( "You've been given $" .. SellAllPrice .. " for selling gin." )
	else
		nogintosell = true
	end

	if nobeertosell and nowinetosell and nogintosell then
		ply:ChatPrint( "You have nothing to sell." )
	end
end )
