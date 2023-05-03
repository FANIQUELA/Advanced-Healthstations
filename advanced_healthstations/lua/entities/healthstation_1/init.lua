AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
include("healthstations_config.lua")
include("healthstation_translations.lua")


util.AddNetworkString("FanActivateUI")
util.AddNetworkString("FanActivateHealth")
util.AddNetworkString("FanActivateArmor")
util.AddNetworkString("FanActivateShop")
util.AddNetworkString("CloseDPanelOnSuccess")
util.AddNetworkString("BuyHealth")
util.AddNetworkString("BuyArmor")

ENT.SeizeReward = 360

local HealthStationskeke
function ENT:Initialize()
	self:SetUseType(SIMPLE_USE)
	self:SetModel("models/faniquela/healthstation_1_lowpoly_model.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	phys:Wake()
end

function ENT:Use( ply )

	net.Start("FanActivateUI")
	net.Send(ply)

end

local healthnotification = healthisfull
local armornotification = armorisfull
local healthsettofull = HEALTH_SET_TO_FULL_NOTIFICATION
local healthremovedamount = HEALTH_REMOVED_MONEY_NOTIFICATION
local youdonthaveenoughmoney = YOU_DONT_HAVE_ENOUGH_MONEY_NOTIFICATION

net.Receive("FanActivateHealth", function(length, activator)
    if activator:getDarkRPVar("money") > healthboxprice and activator:Health() < healthboxamount then
        activator:SetHealth(healthboxamount)
        activator:addMoney(-healthboxprice)

        net.Start("FanActivateHealth")
        net.WriteBool(true) 
        net.Send(activator)

        DarkRP.notify(activator, 2, 5, healthsettofull)
        DarkRP.notify(activator, 2, 5, healthremovedamount)
    elseif activator:getDarkRPVar("money") < healthboxprice then
        net.Start("FanActivateHealth")
        net.WriteBool(false) 
        net.Send(activator)

        DarkRP.notify(activator, 1, 5, youdonthaveenoughmoney)
    else
        net.Start("FanActivateHealth")
        net.WriteBool(false) 
        net.Send(activator)

        DarkRP.notify(activator, 1, 5, healthnotification)
    end
end)



local armorsettofull = ARMOR_SET_TO_FULL_NOTIFICATION
local armorremovedamount = ARMOR_REMOVED_MONEY_NOTIFICATION

net.Receive("FanActivateArmor", function(length, activator)
    if activator:getDarkRPVar("money") > armorboxprice and activator:Armor() < armorboxamount then
        activator:SetArmor(armorboxamount)
        activator:addMoney(-armorboxprice)

        net.Start("FanActivateArmor")
        net.WriteBool(true) 
        net.Send(activator)

        DarkRP.notify(activator, 2, 5, armorsettofull)
        DarkRP.notify(activator, 2, 5, armorremovedamount)
    elseif activator:getDarkRPVar("money") < armorboxprice then
        net.Start("FanActivateArmor")
        net.WriteBool(false) 
        net.Send(activator)

        DarkRP.notify(activator, 1, 5, youdonthaveenoughmoney)
    else
        net.Start("FanActivateArmor")
        net.WriteBool(false) 
        net.Send(activator)

        DarkRP.notify(activator, 1, 5, armornotification)
    end
end)


net.Receive("FanActivateShop", function(length, ply)
    net.Start("FanActivateShop")
    net.Send(ply)
end)



local lastHealthPurchase = 0
local healthPurchaseDelay = MEDKIT_PURCHASE_DELAY
local wait30secondsmedkit = BUY_MEDKIT_COOLDOWN_NOTIFICATION
local boughtmedkitfor = BOUGHT_MEDKIT_FOR_NOTIFICATION

net.Receive("BuyHealth", function(length, ply)
    local pricemedkit = MEDKIT_CRATE_PRICE

    if ply:getDarkRPVar("money") < pricemedkit then
        DarkRP.notify(ply, 1, 4, youdonthaveenoughmoney)
        return
    end

  
    if lastHealthPurchase + healthPurchaseDelay > CurTime() then
        DarkRP.notify(ply, 1, 4, wait30secondsmedkit)
        return
    end


    ply:addMoney(-pricemedkit)


    local pos = ply:GetPos() + ply:GetForward() * -35 + ply:GetRight() * 35 
    local tr = util.TraceLine({
        start = pos,
        endpos = pos - Vector(0, 0, 100),
        filter = ply
    })

    local ent = ents.Create("healthstation_medkit")
    ent:SetPos(tr.HitPos)
    ent:Spawn()

    DarkRP.notify(ply, 0, 4, boughtmedkitfor ..pricemedkit.. "!")
    lastHealthPurchase = CurTime()
end)



local armorPurchaseDelay = ARMOR_PURCHASE_DELAY
local lastArmorPurchase = 0
local wait30secondsarmor = BUY_ARMOR_COOLDOWN_NOTIFICATION
local boughtarmorfor = BOUGHT_ARMOR_FOR_NOTIFICATION

net.Receive("BuyArmor", function(length, ply)
    local pricearmor = ARMOR_CRATE_PRICE

    if ply:getDarkRPVar("money") < pricearmor then
        DarkRP.notify(ply, 1, 4, youdonthaveenoughmoney)
        return
    end


        if CurTime() < lastArmorPurchase + armorPurchaseDelay then
            DarkRP.notify(ply, 1, 4, wait30secondsarmor)
            return
        end


    ply:addMoney(-pricearmor)

    local pos = ply:GetPos() + ply:GetForward() * -15 + ply:GetRight() * 35 
    local tr = util.TraceLine({
        start = pos,
        endpos = pos - Vector(0, 0, 100),
        filter = ply
    })

    local ent = ents.Create("healthstation_armor")
    local offset = Vector(-50, 0, 0) 
    ent:SetPos(tr.HitPos + offset) 
    ent:Spawn()

    DarkRP.notify(ply, 0, 4, boughtarmorfor ..pricearmor.. "!")
       
        lastArmorPurchase = CurTime()
end)

