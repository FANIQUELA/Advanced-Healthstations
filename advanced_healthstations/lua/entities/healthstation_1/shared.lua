include("healthstations_config.lua")
AddCSLuaFile("healthstations_config.lua")
include("healthstation_translations.lua")
AddCSLuaFile("healthstation_translations.lua")

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "HealthStation 1"
ENT.Author = "FANIQUELA"
ENT.AdminSpawnable = true
ENT.Spawnable = true
ENT.Category = "FANIQUELA'S Health Stations"

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "price")
	self:NetworkVar("Entity", 0, "owning_ent")
	self:NetworkVar("Int", 1, "Money")
end
