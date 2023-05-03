-- Healthstations config


--HealthStation Screen (Strongly recommended to leave it default)
HEALTHSTATION_BACKGROUND_COLOR = Color(46,46,46) -- What color should the background be?
HEALTHSTATION_LED_COLOR = Color(25,25,25,170) -- What color should the LED be? (STRONGLY RECOMMENDED TO KEEP IT DEFAULT)



--First Page config
healthboxamount = 100 -- How much HP should the healthstation give? (100 = 100HP, it does not give the player 100HP, it sets player's hp to 100
healthboxprice = 25000 -- How much should the healthbox cost?
armorboxamount = 100 -- How much armor should the armorstation give? 
armorboxprice = 100000 -- How much should the armorbox cost?



--Second page config
MEDKIT_CRATE_PRICE = 250000 -- How much should the medkit crate cost?
ARMOR_CRATE_PRICE = 1000000 -- How much should the armor crate cost?
MEDKIT_PURCHASE_DELAY = 30 -- How many seconds should the player wait before being able to buy another medkit? (Keep it default to avoid spamming)
ARMOR_PURCHASE_DELAY = 30 -- How many seconds should the player wait before being able to buy another armor crate? (Keep it default to avoid spamming)

--General config
isdraggable = false -- Can the panel be dragged around with mouse? (true/false)