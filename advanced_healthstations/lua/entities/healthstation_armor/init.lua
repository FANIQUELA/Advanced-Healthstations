AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
self:SetModel("models/faniquela/armorcratesmall_model.mdl")
self:PhysicsInit(SOLID_VPHYSICS)
self:SetMoveType(MOVETYPE_VPHYSICS)
self:SetUseType(SIMPLE_USE)
local phys = self:GetPhysicsObject()
phys:Wake()

self:CPPISetOwner(self:Getowning_ent())
if IsValid(phys) then
	phys:SetMass(25) 
end

if not self:GetFirstSpawn() then
	self:SetUsesLeft(5)
	self:SetFirstSpawn(true)
end

self.coolDown = 0

end

local already100armor = ALREADY_100ARMOR

function ENT:Use(ply)
if self.coolDown > CurTime() then return end
self.coolDown = CurTime() + 1

if ply:Armor() >= 100 then
	DarkRP.notify(ply, 1, 4, already100armor)
	return
end

local curArmor = ply:Armor()
if curArmor > 80 then
	ply:SetArmor(100)
	self:UsedOnce()
	return
end

local youUsedarmor = ARMOR_USED_NOTIFICATION

ply:SetArmor(curArmor + 20)

DarkRP.notify(ply, 3, 4, youUsedarmor)

self:UsedOnce()

end



function ENT:UsedOnce()
local usesLeft = self:GetUsesLeft()
local armorpackisempty = ARMOR_PACK_EMPTY
if usesLeft <= 1 then
	self:Remove()
	if IsValid(self:Getowning_ent()) then
		DarkRP.notify(ply, 3, 4, armorpackisempty, self:Getowning_ent())
	end
end

self:SetUsesLeft(usesLeft - 1)

end

function ENT:OnTakeDamage(dmginfo)
	self:TakePhysicsDamage(dmginfo)

	if dmginfo:GetDamage() > 25 then
		util.Effect("Explosion", EffectData {
            Start = self:GetPos(),
            Normal = Vector(0, 0, 1),
            Scale = 1,
            Radius = 25,
            Magnitude = 25
        })
		self:Remove()
	end
	
end
