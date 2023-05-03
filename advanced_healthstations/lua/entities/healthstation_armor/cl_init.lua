include("shared.lua")

include("healthstations_config.lua")
include("healthstation_translations.lua")
AddCSLuaFile("healthstation_translations.lua")
AddCSLuaFile("healthstations_config.lua")






surface.CreateFont( "MedkitFont", {
	font = "CloseCaption_Bold",
	size = 70,
	weight = 800,
	} )

	
	function ENT:Draw()
		self:DrawModel()
		
		if not self:GetFirstSpawn() then return end
		
		local pos = self:GetPos()
		local ang = self:GetAngles()
		ang:RotateAroundAxis(ang:Forward(), 90)
		ang:RotateAroundAxis(ang:Right(), 270)
		
		local remainingUses = self:GetUsesLeft()
		
		-- Distance
		local ply = LocalPlayer()
		if IsValid(ply) and ply:GetPos():Distance(pos) < 100 then
			local viewang = ply:EyeAngles()
			viewang.pitch = 0
			viewang.yaw = viewang.yaw - 90
			viewang.roll = 70
	

		

			cam.Start3D2D(pos + self:GetUp() * 25, viewang, 0.1)
				local text = ""..ARMOR_REMAININGUSES .. remainingUses
				surface.SetFont("MedkitFont")
				local textWidth, textHeight = surface.GetTextSize(text)
				local boxWidth, boxHeight = textWidth + 20, textHeight + 20 
				draw.RoundedBox(12, -boxWidth / 2, -boxHeight / 2, boxWidth, boxHeight, Color(12, 12, 12, 255))

				local boxW, boxH = textWidth + 5, textHeight + 5 
				draw.RoundedBox(12, -boxW / 2, -boxH / 2, boxW, boxH, Color(45, 45, 45, 255))
				draw.SimpleText(text, "MedkitFont", 0, 0, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			cam.End3D2D()
		end
	end
	




