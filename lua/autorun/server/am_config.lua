EggrollAM = {}
local ConfigVariables = {}

function EggrollAM:SetConfig( name, value )
	ConfigVariables[ name ] = value
end

function EggrollAM:GetConfig( name )
	return ConfigVariables[ name ]
end

-- CONFIG BEGINS BELOW HERE --

EggrollAM:SetConfig( "WorkshopEnabled", true ) -- Makes players automatically download content through the workshop. Set to false if using FastDL and remember to add the models and materials to your FastDL set up.

EggrollAM:SetConfig( "AddHealthBeer", 10 ) -- > \
												 -- Adds health and/or armor upon drinking beer. If you don't want to add health or armor, set the value to 0. Negatives may be added to subtract health or armor (UNTESTED).
EggrollAM:SetConfig( "AddArmorBeer", 10 )  -- > /

EggrollAM:SetConfig( "AddHealthWine", 10 ) -- > \
												 -- Adds health and/or armor upon drinking wine. If you don't want to add health or armor, set the value to 0. Negatives may be added to subtract health or armor (UNTESTED).
EggrollAM:SetConfig( "AddArmorWine", 10 )  -- > /

EggrollAM:SetConfig( "AddHealthGin", 10 ) -- > \
												 -- Adds health and/or armor upon drinking gin. If you don't want to add health or armor, set the value to 0. Negatives may be added to subtract health or armor (UNTESTED).
EggrollAM:SetConfig( "AddArmorGin", 10 )  -- > /

EggrollAM:SetConfig( "BoilerTimer", 60 ) -- Time in seconds on how long it takes for the boiler to finish boiling ingredients into beer.

EggrollAM:SetConfig( "CrusherTimer", 60 ) -- How long in seconds you have to wait for the crusher to be ready.

EggrollAM:SetConfig( "PotStillTimer", 60 ) -- How long in seconds you have to wait for the pot still to be ready.

EggrollAM:SetConfig( "MaxGrapes", 5 ) -- How many grapes you need to put in the crusher for the timer to start.

EggrollAM:SetConfig( "DrunkEffectTime", 10 ) -- The amount of time in which a person is drunk for after drinking an alcoholic beverage.

EggrollAM:SetConfig( "NeutralSpiritTimer", 60 ) -- How long in seconds you have to wait for the neutral spirit pot to be done soaking with the botanical.

EggrollAM:SetConfig( "AVBuyPriceBeer", 3000 ) -- How much the player needs to give the vendor in exchange for a single bottle of beer.

EggrollAM:SetConfig( "AVSellPriceBeer", 2500 ) -- How much the alcohol vendor should give to the player in exchange for a single bottle of beer.

EggrollAM:SetConfig( "AVBuyPriceWine", 3000 ) -- How much the player needs to give the vendor in exchange for a single bottle of wine.

EggrollAM:SetConfig( "AVSellPriceWine", 2500 ) -- How much the alcohol vendor should give to the player in exchange for a single bottle of wine.

EggrollAM:SetConfig( "AVBuyPriceGin", 3000 ) -- How much the player needs to give the vendor in exchange for a single bottle of gin.

EggrollAM:SetConfig( "AVSellPriceGin", 2500 ) -- How much the alcohol vendor should give to the player in exchange for a single bottle of gin.

EggrollAM:SetConfig( "EnableBuy", true ) -- Enable the buy feature in the alcohol vendor.

EggrollAM:SetConfig( "EnableSell", true ) -- Enable the sell feature in the alcohol vendor.

EggrollAM:SetConfig( "VendorName", "Alcohol Vendor" ) -- What the vendor's name should be (Text that displays above its head).

-- CONFIG ENDS HERE -- IF THIS IS NOT REMOVED IN THE ACTUAL RELEASE, PLEASE REMIND THEASIAN EGGROLLMAKER TO REMOVE THIS AND SET WORKSHOPENABLED TO TRUE!
