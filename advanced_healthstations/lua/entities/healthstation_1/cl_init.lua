include("shared.lua")
include("healthstations_config.lua")
include("healthstation_translations.lua")
AddCSLuaFile("healthstation_translations.lua")
AddCSLuaFile("healthstations_config.lua")



surface.CreateFont( "HealthArmourFont", {
font = "CloseCaption_Bold",
size = 40,
weight = 800,
} )

surface.CreateFont( "HealthArmourFonthealthbar", {
	font = "CloseCaption_Bold",
	size = 20,
	weight = 800,
	} )
surface.CreateFont( "newPanelButtonFont", {
	font = "CloseCaption_Bold",
	size = 25,
	weight = 800,
	} )


surface.CreateFont( "newPanelprices", {
		font = "CloseCaption_Bold",
		size = 20,
		weight = 600,
		} )
	

	

surface.CreateFont( "armortextfont", {
	font = "CloseCaption_Bold",
	size = 25,
	weight = 400,
	} )


surface.CreateFont( "StatusFont", {
	font = "CloseCaption_Bold",
	size = 25,
	weight = 400,
	} )
	

surface.CreateFont( "gobackfont", {
		font = "CloseCaption_Bold",
		size = 40,
		weight = 400,
		} )

surface.CreateFont( "cssfontu", {
	font = "csd",
	size = 80,
	weight = 200,
	} )

	surface.CreateFont( "cssfontu2", {
		font = "csd",
		size = 80,
		weight = 200,
		} )

surface.CreateFont( "cssfontu3", {
		font = "csd",
		size = 200,
		weight = 100,
	} )


surface.CreateFont( "MoneyFont", {
font = "CloseCaption_Bold",
size = 60,
weight = 800,
} )


function ENT:Draw()
	self:DrawModel()
	
	local Pos = self:GetPos()
	local Ang = self:GetAngles()
	local health = LocalPlayer():Health()

	owner = (IsValid(owner) and owner:Nick()) or DarkRP.getPhrase("unknown")
	
	Ang:RotateAroundAxis(Ang:Up(), 90)
	Ang:RotateAroundAxis(Ang:Forward(), 90)

	local screenMaterial = Material("mat/faniquela/led_screen.png", "unlitgeneric")

	local backgroundcolorekmek = HEALTHSTATION_BACKGROUND_COLOR
	local ledcolorekmek = HEALTHSTATION_LED_COLOR
	local interacttexttranslate = INTERACT_TEXT_TRANSLATE

		local ply = LocalPlayer()
	if IsValid(ply) and ply:GetPos():Distance(Pos) < 500 then
	cam.Start3D2D(Pos + Ang:Up() * 4.2, Ang, 0.11)
	
	 	draw.RoundedBox(0, -145, 130, 287, -300, backgroundcolorekmek) --3dbg		
		draw.SimpleText("F", "cssfontu3", 18, 0, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText(interacttexttranslate, "HealthArmourFont", 0, 45, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		surface.SetMaterial(screenMaterial)
		surface.SetDrawColor(ledcolorekmek)
		surface.DrawTexturedRect(-145, -170, 287, 300) 
		
	cam.End3D2D()
	

	end



end



net.Receive("FanActivateUI", function()

	local ent = net.ReadEntity()
	local isDraggable = true

	ekmek = vgui.Create("DFrame")
	ekmek:SetSize( 0, 0 )
	ekmek:SetTitle(FIRST_PAGE_TITLE)
	ekmek:Center()
	ekmek:MakePopup()
	ekmek:ShowCloseButton(true)
	ekmek:SetDraggable(isdraggable)
	local isAnimating = true 
	ekmek:SizeTo(1024, 600, .2, 0, -1, function() 
		isAnimating = false 
	end)
	ekmek.Think = function(sikismis)
		if isAnimating then
			sikismis:Center()
		end
	end


	ekmek.btnMinim:SetVisible(false)
	ekmek.btnMaxim:SetVisible(false)

	function ekmek:Close()
  		 self:SetVisible(false)
	end

	

	local function closeEkmek()
		if IsValid(ekmek) then
			ekmek:Close()
		end
	end
	

	concommand.Add("close_healthstation", function()
		closeEkmek()
	end)




	function ekmek.btnClose:Paint(w, h)
		    
			local icon = Material("icon16/cancel.png")

			
			surface.SetMaterial(icon)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect(5, 2, 20, 20)

	end
	
	
	
	function ekmek:Paint( w, h )
		
		

		draw.RoundedBox( 6, 0, 0, w, h, Color( 32, 32, 32) ) --background
		
		draw.RoundedBox( 12, 22, 47, 980, 530, Color( 22, 22, 22) ) --middle modern look
		
		draw.RoundedBox( 12, 62, 70, 900, 230, Color( 32, 32, 32) ) -- topwindow
		draw.RoundedBox( 12, 60, 70, 665, 35, Color( 63, 15, 15) ) -- statusbar

		draw.RoundedBox( 12, 71, 113, 640, 180, Color( 46, 46, 46) ) -- topwindowoutlineekmek
		draw.RoundedBox( 12, 736, 78, 216, 215, Color( 46, 46, 46) ) -- topwindowoutline 3dplayermodel
		
		

		draw.RoundedBox( 0, 62, 100, 660, 7, Color( 22, 22, 22) ) -- topwindowline
		draw.RoundedBox( 0, 720, 70, 7, 230, Color( 22, 22, 22) ) -- topwindowlinedikey

		draw.RoundedBox( 0, 0, 0, w, 25, Color( 22, 22, 22 ) ) --çubuk

		draw.RoundedBox( 6, 190, 155, 500, 30, Color( 32, 32, 32) ) --HealthBG
		draw.RoundedBox( 6, 190, 220, 500, 30, Color( 32, 32, 32) ) --armorBG


		draw.SimpleText("F", "cssfontu", 140, 188, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText("E", "cssfontu2", 146, 253, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

	end




	local HealthBarPanel = vgui.Create("DPanel", ekmek)
	HealthBarPanel:SetPos(195, 160)
	HealthBarPanel:SetSize(0, 20)
	HealthBarPanel:SizeTo(490, 20, .5, 0, 1, function() 
		isAnimating = false 
	end)
	ekmek.Think = function(sikismis2)
		if isAnimating then
			sikismis2:Center()
		end
	end
	
	
	
	function HealthBarPanel:Paint(w, h)
	 
	  health = LocalPlayer():Health()

	  
	  draw.RoundedBox(4, 0, 0, w * health / 100, h, Color(200, 40, 40)) 
	  draw.SimpleText(health , "HealthArmourFonthealthbar", 245, 9, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	
	hook.Add("PlayerHurt", "UpdateHealthBar", function()
	  HealthBarPanel:InvalidateLayout()
	end)





	--armorbar
local ArmorBarPanel = vgui.Create("DPanel", ekmek)
ArmorBarPanel:SetPos(195, 225)
ArmorBarPanel:SetSize(0, 20)

ArmorBarPanel:SizeTo(490, 20, .5, 0, 1, function() 
	isAnimating = false 
end)
ekmek.Think = function(sikismis3)
	if isAnimating then
		sikismis3:Center()
	end
end

function ArmorBarPanel:Paint(w, h)

  armor = LocalPlayer():Armor()
  draw.RoundedBox(4, 0, 0, w * armor / 100, h, Color(40, 40, 160)) 
  draw.SimpleText(armor , "HealthArmourFonthealthbar", 245, 9, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

hook.Add("ArmorChanged", "UpdateArmorBar", function()
  ArmorBarPanel:InvalidateLayout()
  
end)



	
	local playerModelPanel = vgui.Create("DModelPanel", ekmek)
	playerModelPanel:SetSize(200, 215)
	playerModelPanel:SetPos(740,70)
	playerModelPanel:SetModel(LocalPlayer():GetModel())
	playerModelPanel:SetLookAt(Vector(0,0,52))	
	playerModelPanel:SetCamPos(Vector(0,33,60)) --uzaklik,
	playerModelPanel:SetFOV(70)
	playerModelPanel:SetMouseInputEnabled(false)
	


	function ekmek:Close()
		self:SetVisible(false)
	end


local shopButton = vgui.Create("DButton", ekmek)
shopButton:SetSize(228,228)
shopButton:SetPos(730, 325)
shopButton:SetFont("HealthArmourFont")
shopButton:SetText("" ..SHOP_BUTTON_TRANSLATION)
shopButton:SetTextColor(Color(255, 255, 255))

shopButton.Paint = function(self, w, h)
	draw.RoundedBox(12, 0, 0, w, h, Color(95, 190, 39))
end

function shopButton:OnCursorEntered()
	surface.PlaySound("ui/buttonrollover.wav")
	self:SetTextColor(Color(255, 255, 255))
	self.Paint = function(self, w, h)
		draw.RoundedBox(12, 0, 0, w, h, Color(95, 230, 39))
	end
end


function shopButton:OnCursorExited()
	self:SetTextColor(Color(255, 255, 255))
	self.Paint = function(self, w, h)
		draw.RoundedBox(12, 0, 0, w, h, Color(95, 190, 39))
	end
end


shopButton.DoClick = function()
  
  ekmek:Close()
  local windowtitle2stpage = SECOND_PAGE_TITLE 

  local newPanel = vgui.Create("DFrame")
  newPanel:SetSize(400, 600)
  newPanel:SetTitle(SECOND_PAGE_TITLE)
  newPanel:Center()
  newPanel:MakePopup()
  newPanel:ShowCloseButton(true)
  newPanel:SetDraggable(isdraggable)



newPanel.btnMinim:SetVisible(false)
newPanel.btnMaxim:SetVisible(false)

	function newPanel:Close()
  		 self:SetVisible(false)
	end
	local function closenewPanel()
		if IsValid(newPanel) then
			newPanel:Close()
		end
	end
	

	concommand.Add("close_healthstation", function()
		closenewPanel()
	end)

	function newPanel.btnClose:Paint(w, h)
		
		local icon = Material("icon16/cancel.png")

	
		surface.SetMaterial(icon)
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRect(5, 2, 20, 20)

end


local backButton = vgui.Create("DButton", newPanel)
backButton:SetText("" ..BACK_BUTTON_TRANSLATION)
backButton:SetSize(275,50)
backButton:SetPos(62, 495)
backButton:SetFont("newPanelButtonFont")


backButton.Paint = function(self, w, h)
	draw.RoundedBox(6, 0, 0, w, h, Color(38, 38, 38))
end

function backButton:OnCursorEntered()
	surface.PlaySound("ui/buttonrollover.wav")
	self:SetTextColor(Color(255, 255, 255))
	self.Paint = function(self, w, h)
		draw.RoundedBox(6, 0, 0, w, h, Color(58, 58, 58))
	end
end

function backButton:OnCursorExited()
	self:SetTextColor(Color(255, 255, 255))
	self.Paint = function(self, w, h)
		draw.RoundedBox(6, 0, 0, w, h, Color(38, 38, 38))
	end
end



backButton.DoClick = function()
newPanel:Remove()
ekmek:SetVisible(true) 


end

----------------Medkit 3D Model----------------
local modelPanel = vgui.Create("DModelPanel", newPanel)
modelPanel:SetSize(275, 225)
modelPanel:SetPos(62, 87)
modelPanel:SetMouseInputEnabled(false)
modelPanel:SetModel("models/faniquela/healthcratesmall_model.mdl")


modelPanel.Angles = Angle(0, 0, 0)
modelPanel:SetCamPos(Vector(0, 50, 50))
modelPanel:SetLookAt(Vector(0, 0, 0))


local lastTime = 0
modelPanel.Think = function(self)
    local curTime = SysTime()
    local delta = curTime - lastTime
    lastTime = curTime


    self.Angles:RotateAroundAxis(Vector(0, 0, 1), delta * 10)
end

----------------Armor 3D Model----------------
local modelPanel2 = vgui.Create("DModelPanel", newPanel)
modelPanel2:SetSize(275, 225)
modelPanel2:SetPos(62, 87)
modelPanel2:SetMouseInputEnabled(false)
modelPanel2:SetModel("models/faniquela/armorcratesmall_model.mdl")
modelPanel2.Angles = Angle(0, 0, 0)
modelPanel2:SetCamPos(Vector(0, 50, 50))
modelPanel2:SetLookAt(Vector(0, 0, 0))



local lastTime = 0
modelPanel2.Think = function(self)
    local curTime = SysTime()
    local delta = curTime - lastTime
    lastTime = curTime


    self.Angles:RotateAroundAxis(Vector(0, 0, 1), delta * 10)
end


----------------Prices For Shop----------------


local priceLabelarmor = vgui.Create("DLabel", newPanel)
priceLabelarmor:SetPos(165, 295)
priceLabelarmor:SetSize(200, 20)
priceLabelarmor:SetFont("newPanelprices")
priceLabelarmor:SetContentAlignment(5)
priceLabelarmor:CenterHorizontal()

local pricetexttranslation = PRICE_TEXT_TRANSLATION

local armorCratePrice = ARMOR_CRATE_PRICE
priceLabelarmor:SetText(pricetexttranslation .. armorCratePrice)



local priceLabelmedkit = vgui.Create("DLabel", newPanel)
priceLabelmedkit:SetPos(165, 295)
priceLabelmedkit:SetSize(200, 20)
priceLabelmedkit:SetFont("newPanelprices")
priceLabelmedkit:SetContentAlignment(5)
priceLabelmedkit:CenterHorizontal()

local medkitCratePrice = MEDKIT_CRATE_PRICE
priceLabelmedkit:SetText(pricetexttranslation .. medkitCratePrice)



local nameLabelArmor = vgui.Create("DLabel", newPanel)
nameLabelArmor:SetPos(165, 85)
nameLabelArmor:SetSize(200, 20)
nameLabelArmor:SetFont("newPanelprices")
nameLabelArmor:SetContentAlignment(5)
nameLabelArmor:CenterHorizontal()

local armorCrateName = ARMOR_TRANSLATION
nameLabelArmor:SetText("" .. armorCrateName)


local nameLabelMedkit = vgui.Create("DLabel", newPanel)
nameLabelMedkit:SetPos(165, 85)
nameLabelMedkit:SetSize(200, 20)
nameLabelMedkit:SetFont("newPanelprices")
nameLabelMedkit:SetContentAlignment(5)
nameLabelMedkit:CenterHorizontal()

local MedkitCrateName = MEDKIT_TRANSLATION
nameLabelMedkit:SetText("" .. MedkitCrateName)











local isVisible = true


local buyButton = vgui.Create("DButton", newPanel)
buyButton:SetText("" ..BUY_TRANSLATION_SHOP)
buyButton:SetSize(275, 50)
buyButton:SetPos(62, 365)
buyButton:SetFont("newPanelButtonFont")
buyButton:SetTextColor(Color(255, 255, 255))


buyButton.Think = function(self)
    modelPanel:SetVisible(self:IsVisible())
	modelPanel2:SetVisible(not self:IsVisible())
	priceLabelarmor:SetVisible(not self:IsVisible())
	priceLabelmedkit:SetVisible(self:IsVisible())
	nameLabelMedkit:SetVisible(self:IsVisible())
	nameLabelArmor:SetVisible(not self:IsVisible())
end

buyButton.Paint = function(self, w, h)
    if isVisible then
		local color = Color(95, 190, 39)
		if self:IsHovered() then
			if not hasPlayedSound then
				surface.PlaySound("ui/buttonrollover.wav")
				hasPlayedSound = true
			end
			color = Color(95, 230, 39)
		else
			hasPlayedSound = false
		end
		draw.RoundedBox(6, 0, 0, w, h, color)
	end
end


local buyButton2 = vgui.Create("DButton", newPanel)
buyButton2:SetText("" ..BUY_TRANSLATION_SHOP)
buyButton2:SetSize(275, 50)
buyButton2:SetPos(62, 365)
buyButton2:SetFont("newPanelButtonFont")
buyButton2:SetTextColor(Color(255, 255, 255))
buyButton2:SetVisible(not isVisible)


buyButton2.Think = function(self)
    modelPanel:SetVisible(not self:IsVisible())
	modelPanel2:SetVisible(self:IsVisible())
	priceLabelarmor:SetVisible(self:IsVisible())
	priceLabelmedkit:SetVisible(not self:IsVisible())
	nameLabelArmor:SetVisible(self:IsVisible())
	nameLabelMedkit:SetVisible(not self:IsVisible())
	
end






buyButton2.Paint = function(self, w, h)
    if not self:IsVisible() then return end
    
    local color = Color(95, 190, 39)
    if self:IsHovered() then
        if not hasPlayedSound then
            surface.PlaySound("ui/buttonrollover.wav")
            hasPlayedSound = true
        end
        color = Color(95, 230, 39)
    else
        hasPlayedSound = false
    end
    draw.RoundedBox(6, 0, 0, w, h, color)
	

end

buyButton2.DoClick = function()
    net.Start("BuyArmor")
    net.SendToServer()
    isVisible = true
	modelPanel:SetVisible(false)
    buyButton:SetVisible(isVisible)
    buyButton2:SetVisible(not isVisible)
end



buyButton.DoClick = function()
    net.Start("BuyHealth")
    net.SendToServer()
    isVisible = false
	modelPanel:SetVisible(true)
    buyButton:SetVisible(isVisible)
    buyButton2:SetVisible(not isVisible)
end



-- Toggle visibility button
local toggleButton = vgui.Create("DButton", newPanel)
toggleButton:SetText("" ..SWITCH_BUTTON_TRANSLATION)
toggleButton:SetSize(275, 50)
toggleButton:SetPos(62, 430)
toggleButton:SetFont("newPanelButtonFont")
toggleButton:SetTextColor(Color(255, 255, 255))

toggleButton.Paint = function(self, w, h)
	draw.RoundedBox(6, 0, 0, w, h, Color(200, 40, 40))
		
	end

	function toggleButton:OnCursorEntered()
		surface.PlaySound("ui/buttonrollover.wav")
		self:SetTextColor(Color(255, 255, 255))
		self.Paint = function(self, w, h)
			draw.RoundedBox(6, 0, 0, w, h, Color(255, 40, 40))
		end
	end
	
	function toggleButton:OnCursorExited()
		self:SetTextColor(Color(255, 255, 255))
		self.Paint = function(self, w, h)
			draw.RoundedBox(6, 0, 0, w, h, Color(200, 40, 40))
		end
	end


toggleButton.DoClick = function()
    isVisible = not isVisible
    buyButton:SetVisible(isVisible)
    buyButton2:SetVisible(not isVisible)
end







function newPanel:Paint( w, h )
	draw.RoundedBox( 6, 0, 0, w, h, Color( 32, 32, 32) ) --background
	draw.RoundedBox( 12, 25, 50, 350, 525, Color( 22, 22, 22) ) --middle modern look
	draw.RoundedBox( 12, 50, 75, 300, 250, Color( 32, 32, 32) ) -- topwindow
	draw.RoundedBox( 12, 62, 87, 275, 225, Color( 46, 46, 46) ) -- topwindowoutline 3dplayermodel
	draw.RoundedBox( 0, 62, 285, 275, 30, Color( 32, 32, 32) ) --pricetable
	draw.RoundedBox( 0, 62, 85, 275, 30, Color( 32, 32, 32) ) --itemdisplayname
	draw.RoundedBox( 0, 0, 0, w, 25, Color( 22, 22, 22 ) ) --çubuk

end

end


	local health = vgui.Create("DButton", ekmek)
	local buyhealth = buyhealth
	local healthtexttranslation = HEALTH_BUTTON_TRANSLATION
	local currency = CURRENCY_DEFINITION
	local healthprice = healthboxprice


	

health:SetSize(600, 100)
health:SetPos(71, 325)
	
health:SetText("" .. healthtexttranslation ..  " ".. currency .. "" .. healthprice .. "")
health:SetFont("HealthArmourFont")
health:SetTextColor(Color(255, 255, 255))




	health.Paint = function(self, w, h)
		draw.RoundedBox(12, 0, 0, w, h, Color(200, 40, 40))
		

		
	end

	function health:OnCursorEntered()
		surface.PlaySound("ui/buttonrollover.wav")
		self:SetTextColor(Color(255, 255, 255))
		self.Paint = function(self, w, h)
			draw.RoundedBox(12, 0, 0, w, h, Color(255, 40, 40))
		end
	end
	

	function health:OnCursorExited()
		self:SetTextColor(Color(255, 255, 255))
		self.Paint = function(self, w, h)
			draw.RoundedBox(12, 0, 0, w, h, Color(200, 40, 40))
		end
	end



	health.DoClick = function()
		net.Start("FanActivateHealth")
		net.SendToServer()
	
		net.Receive("FanActivateHealth", function(length, activator)
			local success = net.ReadBool()
	
			if success then
				surface.PlaySound("items/smallmedkit1.wav") 
			end
		end)
	end


	local armortexttranslation = ARMOR_BUTTON_TRANSLATION
	local currency = CURRENCY_DEFINITION
	local armorprice = armorboxprice
	
	local armor = vgui.Create("DButton", ekmek)
	armor:SetSize(600,100)
	armor:SetPos(71, 450)
	armor:SetFont("HealthArmourFont")
	armor:SetText("" .. armortexttranslation ..  " ".. currency .. "" .. armorprice .. "")
	armor:SetTextColor(Color(255, 255, 255))

	armor.Paint = function(self, w, h)
		draw.RoundedBox(12, 0, 0, w, h, Color(40, 40, 80))
	end
	

	function armor:OnCursorEntered()
		surface.PlaySound("ui/buttonrollover.wav")
		self:SetTextColor(Color(255, 255, 255))
		self.Paint = function(self, w, h)
			draw.RoundedBox(12, 0, 0, w, h, Color(40, 40, 160))
		end
	end
	

	function armor:OnCursorExited()
		self:SetTextColor(Color(255, 255, 255))
		self.Paint = function(self, w, h)
			draw.RoundedBox(12, 0, 0, w, h, Color(40, 40, 80))
		end
	end

	


	
	armor.DoClick = function()
		net.Start("FanActivateArmor")
		net.SendToServer()
	
		net.Receive("FanActivateArmor", function(length, activator)
			local success = net.ReadBool()
	
			if success then
				surface.PlaySound("items/battery_pickup.wav") 
			end
		end)
	end

end)





