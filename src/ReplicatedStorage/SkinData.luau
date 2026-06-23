local this = {}

this.Skins = { Common = { "Red","Blue","Green","Yellow","Orange","Purple", "Pink","White","Black","Brown","Gray","Cyan", "Lime","Navy","Maroon","Tan","Olive","Teal" }, Rare = { "Gold","Ice","Wood","Stone","Copper","Steel", "Marble","Brick","Sand","Moss","Cloud","Ocean", "Forest","Sunset","Midnight","Pearl","Amber","Crystal" }, Epic = { "Galaxy","Lava","Neon","Lightning","Plasma","Toxic", "Fire","Arctic","Jungle","Circuit","Digital","Glitch", "Prism","Aurora","Candy","Inferno","Volcano","Cyberpunk" }, Legendary = { "Dragon","Phoenix","Void","Eclipse","Celestial","Storm", "Ancient","Royal","Titanium","Shadowfire","Nuclear","Meteor", "Treasure","Diamond","Obsidian","Runic","Spectral","Abyss" }, Mythic = { "Cyber","Divine","Rainbow","Singularity","Chrono","Quantum", "Dark Matter","Omega","Solar","Lunar","Starlight","Infinity", "Cosmos","Heavenly","Hellfire","Godly" }, Divine = { "Creator","Nebula Core","Omniscient","Eternal", "Paradox","Transcendent"}, Secret = { "RGB","Holographic","Error","404","Corrupted","Black Hole", "Binary","Fractal" }, Impossible = { "Developer","Owner","Admin", "One In A Million","Glitched Reality", "Unobtainium","The End","Infinity Cube" } }
this.order={
	-- Common
	"Red","Blue","Green","Yellow","Orange","Purple",
	"Pink","White","Black","Brown","Gray","Cyan",
	"Lime","Navy","Maroon","Tan","Olive","Teal",

	-- Rare
	"Gold","Ice","Wood","Stone","Copper","Steel",
	"Marble","Brick","Sand","Moss","Cloud","Ocean",
	"Forest","Sunset","Midnight","Pearl","Amber","Crystal",

	-- Epic
	"Galaxy","Lava","Neon","Lightning","Plasma","Toxic",
	"Fire","Arctic","Jungle","Circuit","Digital","Glitch",
	"Prism","Aurora","Candy","Inferno","Volcano","Cyberpunk",

	-- Legendary
	"Dragon","Phoenix","Void","Eclipse","Celestial","Storm",
	"Ancient","Royal","Titanium","Shadowfire","Nuclear","Meteor",
	"Treasure","Diamond","Obsidian","Runic","Spectral","Abyss",

	-- Mythic
	"Cyber","Divine","Rainbow","Singularity","Chrono","Quantum",
	"Dark Matter","Omega","Solar","Lunar","Starlight","Infinity",
	"Cosmos","Heavenly","Hellfire","Godly",

	-- Divine
	"Creator","Nebula Core","Omniscient","Eternal",
	"Paradox","Transcendent",

	-- Secret
	"RGB","Holographic","Error","404","Corrupted","Black Hole",
	"Binary","Fractal",

	-- Impossible
	"Developer","Owner","Admin",
	"One In A Million","Glitched Reality",
	"Unobtainium","The End","Infinity Cube"
}
this.SkinRarity = {}
this.RarityColors = {
	Common = Color3.fromRGB(120, 255, 120),      -- Green
	Rare = Color3.fromRGB(80, 170, 255),         -- Blue
	Epic = Color3.fromRGB(180, 100, 255),        -- Purple
	Legendary = Color3.fromRGB(255, 170, 0),     -- Orange
	Mythic = Color3.fromRGB(255, 60, 60),        -- Red
	Divine = Color3.fromRGB(255, 255, 120),      -- Gold
	Secret = Color3.fromRGB(255, 100, 255),      -- Magenta
	Impossible = Color3.fromRGB(255, 255, 255),  -- White
}
for rarity, skinList in pairs(this.Skins) do
	for _, skinName in ipairs(skinList) do
		this.SkinRarity[skinName] = rarity
	end
end
this.DuplicateRewards = {
	Common = 25,
	Rare = 100,
	Epic = 500,
	Legendary = 2500,
	Mythic = 10000,
	Divine = 50000,
	Secret = 250000,
	Impossible = 1000000
}


this.SkinMultipliers = {
	-- Common
	Common = 1.0,

	-- Rare
	Rare = 1.2,

	-- Epic
	Epic = 1.5,

	-- Legendary
	Legendary = 2.0,

	-- Mythic
	Mythic = 3.0,

	-- Divine
	Divine = 5.0,

	-- Secret
	Secret = 8.0,

	-- Impossible
	Impossible = 15.0,
}
this.SkinData = {
	-- Common
	Red = {Color=Color3.fromRGB(255,0,0), Material=Enum.Material.SmoothPlastic, Transparency=0, Reflectance=0, IsCustom=false},
	Blue = {Color=Color3.fromRGB(0,85,255), Material=Enum.Material.SmoothPlastic, Transparency=0, Reflectance=0, IsCustom=false},
	Green = {Color=Color3.fromRGB(0,200,80), Material=Enum.Material.SmoothPlastic, Transparency=0, Reflectance=0, IsCustom=false},
	Yellow = {Color=Color3.fromRGB(255,255,0), Material=Enum.Material.SmoothPlastic, Transparency=0, Reflectance=0, IsCustom=false},
	Orange = {Color=Color3.fromRGB(255,140,0), Material=Enum.Material.SmoothPlastic, Transparency=0, Reflectance=0, IsCustom=false},
	Purple = {Color=Color3.fromRGB(140,0,255), Material=Enum.Material.SmoothPlastic, Transparency=0, Reflectance=0, IsCustom=false},
	Pink = {Color=Color3.fromRGB(255,100,180), Material=Enum.Material.SmoothPlastic, Transparency=0, Reflectance=0, IsCustom=false},
	White = {Color=Color3.fromRGB(255,255,255), Material=Enum.Material.SmoothPlastic, Transparency=0, Reflectance=0, IsCustom=false},
	Black = {Color=Color3.fromRGB(10,10,10), Material=Enum.Material.SmoothPlastic, Transparency=0, Reflectance=0, IsCustom=false},
	Brown = {Color=Color3.fromRGB(110,70,35), Material=Enum.Material.SmoothPlastic, Transparency=0, Reflectance=0, IsCustom=false},
	Gray = {Color=Color3.fromRGB(130,130,130), Material=Enum.Material.SmoothPlastic, Transparency=0, Reflectance=0, IsCustom=false},
	Cyan = {Color=Color3.fromRGB(0,255,255), Material=Enum.Material.SmoothPlastic, Transparency=0, Reflectance=0, IsCustom=false},
	Lime = {Color=Color3.fromRGB(120,255,0), Material=Enum.Material.SmoothPlastic, Transparency=0, Reflectance=0, IsCustom=false},
	Navy = {Color=Color3.fromRGB(0,30,120), Material=Enum.Material.SmoothPlastic, Transparency=0, Reflectance=0, IsCustom=false},
	Maroon = {Color=Color3.fromRGB(120,0,30), Material=Enum.Material.SmoothPlastic, Transparency=0, Reflectance=0, IsCustom=false},
	Tan = {Color=Color3.fromRGB(210,180,130), Material=Enum.Material.SmoothPlastic, Transparency=0, Reflectance=0, IsCustom=false},
	Olive = {Color=Color3.fromRGB(110,120,40), Material=Enum.Material.SmoothPlastic, Transparency=0, Reflectance=0, IsCustom=false},
	Teal = {Color=Color3.fromRGB(0,130,130), Material=Enum.Material.SmoothPlastic, Transparency=0, Reflectance=0, IsCustom=false},

	-- Rare
	Gold = {Color=Color3.fromRGB(255,200,40), Material=Enum.Material.Metal, Transparency=0, Reflectance=0.15, IsCustom=false},
	Ice = {Color=Color3.fromRGB(180,230,255), Material=Enum.Material.Glass, Transparency=0.35, Reflectance=0.05, IsCustom=false},
	Wood = {Color=Color3.fromRGB(130,85,45), Material=Enum.Material.Wood, Transparency=0, Reflectance=0, IsCustom=false},
	Stone = {Color=Color3.fromRGB(110,110,110), Material=Enum.Material.Slate, Transparency=0, Reflectance=0, IsCustom=false},
	Copper = {Color=Color3.fromRGB(184,115,51), Material=Enum.Material.Metal, Transparency=0, Reflectance=0.1, IsCustom=false},
	Steel = {Color=Color3.fromRGB(170,180,190), Material=Enum.Material.Metal, Transparency=0, Reflectance=0.12, IsCustom=false},
	Marble = {Color=Color3.fromRGB(230,230,220), Material=Enum.Material.Marble, Transparency=0, Reflectance=0.05, IsCustom=false},
	Brick = {Color=Color3.fromRGB(150,60,45), Material=Enum.Material.Brick, Transparency=0, Reflectance=0, IsCustom=false},
	Sand = {Color=Color3.fromRGB(220,200,140), Material=Enum.Material.Sand, Transparency=0, Reflectance=0, IsCustom=false},
	Moss = {Color=Color3.fromRGB(70,120,60), Material=Enum.Material.Grass, Transparency=0, Reflectance=0, IsCustom=false},
	Cloud = {Color=Color3.fromRGB(240,245,255), Material=Enum.Material.SmoothPlastic, Transparency=0.15, Reflectance=0, IsCustom=false},
	Ocean = {Color=Color3.fromRGB(0,100,180), Material=Enum.Material.SmoothPlastic, Transparency=0, Reflectance=0, IsCustom=false},
	Forest = {Color=Color3.fromRGB(20,100,45), Material=Enum.Material.Grass, Transparency=0, Reflectance=0, IsCustom=false},
	Sunset = {Color=Color3.fromRGB(255,110,60), Material=Enum.Material.SmoothPlastic, Transparency=0, Reflectance=0, IsCustom=false},
	Midnight = {Color=Color3.fromRGB(15,15,55), Material=Enum.Material.SmoothPlastic, Transparency=0, Reflectance=0, IsCustom=false},
	Pearl = {Color=Color3.fromRGB(245,235,220), Material=Enum.Material.SmoothPlastic, Transparency=0, Reflectance=0.2, IsCustom=false},
	Amber = {Color=Color3.fromRGB(255,170,40), Material=Enum.Material.Glass, Transparency=0.2, Reflectance=0.05, IsCustom=false},
	Crystal = {Color=Color3.fromRGB(200,255,255), Material=Enum.Material.Glass, Transparency=0.45, Reflectance=0.1, IsCustom=false},

	-- Epic+
	Galaxy = {Color=Color3.fromRGB(80,40,160), Material=Enum.Material.SmoothPlastic, Transparency=0, Reflectance=0, IsCustom=true},
	Lava = {Color=Color3.fromRGB(255,80,20), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	Neon = {Color=Color3.fromRGB(0,255,255), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=false},
	Lightning = {Color=Color3.fromRGB(255,255,80), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	Plasma = {Color=Color3.fromRGB(180,0,255), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	Toxic = {Color=Color3.fromRGB(80,255,0), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	Fire = {Color=Color3.fromRGB(255,70,0), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	Arctic = {Color=Color3.fromRGB(150,230,255), Material=Enum.Material.Ice, Transparency=0.15, Reflectance=0.05, IsCustom=false},
	Jungle = {Color=Color3.fromRGB(20,150,60), Material=Enum.Material.Grass, Transparency=0, Reflectance=0, IsCustom=true},
	Circuit = {Color=Color3.fromRGB(0,255,120), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	Digital = {Color=Color3.fromRGB(0,180,255), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	Glitch = {Color=Color3.fromRGB(255,0,255), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	Prism = {Color=Color3.fromRGB(255,255,255), Material=Enum.Material.Glass, Transparency=0.25, Reflectance=0.2, IsCustom=true},
	Aurora = {Color=Color3.fromRGB(80,255,180), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	Candy = {Color=Color3.fromRGB(255,120,200), Material=Enum.Material.SmoothPlastic, Transparency=0, Reflectance=0, IsCustom=true},
	Inferno = {Color=Color3.fromRGB(255,35,0), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	Volcano = {Color=Color3.fromRGB(120,40,20), Material=Enum.Material.Basalt, Transparency=0, Reflectance=0, IsCustom=true},
	Cyberpunk = {Color=Color3.fromRGB(0,255,255), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},

	-- Legendary
	Dragon = {Color=Color3.fromRGB(170,20,20), Material=Enum.Material.SmoothPlastic, Transparency=0, Reflectance=0, IsCustom=true},
	Phoenix = {Color=Color3.fromRGB(255,130,0), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	Void = {Color=Color3.fromRGB(20,0,40), Material=Enum.Material.SmoothPlastic, Transparency=0, Reflectance=0, IsCustom=true},
	Eclipse = {Color=Color3.fromRGB(30,20,20), Material=Enum.Material.SmoothPlastic, Transparency=0, Reflectance=0, IsCustom=true},
	Celestial = {Color=Color3.fromRGB(255,245,180), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	Storm = {Color=Color3.fromRGB(80,90,120), Material=Enum.Material.Metal, Transparency=0, Reflectance=0.05, IsCustom=true},
	Ancient = {Color=Color3.fromRGB(150,120,70), Material=Enum.Material.Slate, Transparency=0, Reflectance=0, IsCustom=true},
	Royal = {Color=Color3.fromRGB(90,0,180), Material=Enum.Material.SmoothPlastic, Transparency=0, Reflectance=0.1, IsCustom=true},
	Titanium = {Color=Color3.fromRGB(190,190,200), Material=Enum.Material.Metal, Transparency=0, Reflectance=0.18, IsCustom=false},
	Shadowfire = {Color=Color3.fromRGB(80,0,0), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	Nuclear = {Color=Color3.fromRGB(120,255,0), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	Meteor = {Color=Color3.fromRGB(90,70,60), Material=Enum.Material.Rock, Transparency=0, Reflectance=0, IsCustom=true},
	Treasure = {Color=Color3.fromRGB(255,190,60), Material=Enum.Material.Metal, Transparency=0, Reflectance=0.2, IsCustom=true},
	Diamond = {Color=Color3.fromRGB(180,240,255), Material=Enum.Material.Glass, Transparency=0.35, Reflectance=0.25, IsCustom=false},
	Obsidian = {Color=Color3.fromRGB(10,5,20), Material=Enum.Material.Slate, Transparency=0, Reflectance=0.08, IsCustom=false},
	Runic = {Color=Color3.fromRGB(80,50,120), Material=Enum.Material.Slate, Transparency=0, Reflectance=0, IsCustom=true},
	Spectral = {Color=Color3.fromRGB(180,255,255), Material=Enum.Material.ForceField, Transparency=0.35, Reflectance=0, IsCustom=true},
	Abyss = {Color=Color3.fromRGB(5,5,25), Material=Enum.Material.SmoothPlastic, Transparency=0, Reflectance=0, IsCustom=true},

	-- Mythic
	Cyber = {Color=Color3.fromRGB(0,220,255), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	Divine = {Color=Color3.fromRGB(255,255,180), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	Rainbow = {Color=Color3.fromRGB(255,255,255), Material=Enum.Material.SmoothPlastic, Transparency=0, Reflectance=0, IsCustom=true},
	Singularity = {Color=Color3.fromRGB(30,0,60), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	Chrono = {Color=Color3.fromRGB(80,180,255), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	Quantum = {Color=Color3.fromRGB(160,80,255), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	["Dark Matter"] = {Color=Color3.fromRGB(15,0,25), Material=Enum.Material.SmoothPlastic, Transparency=0, Reflectance=0.1, IsCustom=true},
	Omega = {Color=Color3.fromRGB(255,60,60), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	Solar = {Color=Color3.fromRGB(255,210,50), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	Lunar = {Color=Color3.fromRGB(180,190,255), Material=Enum.Material.SmoothPlastic, Transparency=0, Reflectance=0.15, IsCustom=true},
	Starlight = {Color=Color3.fromRGB(255,255,220), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	Infinity = {Color=Color3.fromRGB(120,80,255), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	Cosmos = {Color=Color3.fromRGB(60,30,140), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	Heavenly = {Color=Color3.fromRGB(255,255,230), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	Hellfire = {Color=Color3.fromRGB(255,40,0), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	Godly = {Color=Color3.fromRGB(255,255,120), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},

	-- Divine
	Creator = {Color=Color3.fromRGB(255,255,255), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	["Nebula Core"] = {Color=Color3.fromRGB(120,40,255), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	Omniscient = {Color=Color3.fromRGB(200,255,255), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	Eternal = {Color=Color3.fromRGB(255,220,120), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	Paradox = {Color=Color3.fromRGB(80,0,180), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	Transcendent = {Color=Color3.fromRGB(255,255,240), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},

	-- Secret
	RGB = {Color=Color3.fromRGB(255,255,255), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	Holographic = {Color=Color3.fromRGB(180,255,255), Material=Enum.Material.Glass, Transparency=0.25, Reflectance=0.35, IsCustom=true},
	Error = {Color=Color3.fromRGB(255,0,0), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	["404"] = {Color=Color3.fromRGB(40,40,40), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	Corrupted = {Color=Color3.fromRGB(100,0,120), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	["Black Hole"] = {Color=Color3.fromRGB(0,0,0), Material=Enum.Material.SmoothPlastic, Transparency=0, Reflectance=0.2, IsCustom=true},
	Binary = {Color=Color3.fromRGB(0,255,80), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	Fractal = {Color=Color3.fromRGB(255,120,255), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},

	-- Impossible
	Developer = {Color=Color3.fromRGB(0,255,255), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	Owner = {Color=Color3.fromRGB(255,215,0), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	Admin = {Color=Color3.fromRGB(255,0,80), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	["One In A Million"] = {Color=Color3.fromRGB(255,255,100), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	["Glitched Reality"] = {Color=Color3.fromRGB(255,0,255), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
	Unobtainium = {Color=Color3.fromRGB(120,255,255), Material=Enum.Material.Metal, Transparency=0, Reflectance=0.3, IsCustom=true},
	["The End"] = {Color=Color3.fromRGB(0,0,0), Material=Enum.Material.SmoothPlastic, Transparency=0, Reflectance=0, IsCustom=true},
	["Infinity Cube"] = {Color=Color3.fromRGB(80,80,255), Material=Enum.Material.Neon, Transparency=0, Reflectance=0, IsCustom=true},
}


local Decals = {
	["404"] = "125761955243496",
	["Abyss"] = "139908136877427",
	["Admin"] = "70789488561682",
	["Ancient"] = "135261201085765",
	["Aurora"] = "131985353128893",
	["Binary"] = "127436435498281",
	["Black_Hole"] = "90614773186208",
	["Candy"] = "75668425883346",
	["Celestial"] = "101574267129799",
	["Chrono"] = "133860287797298",
	["Circuit"] = "122293801136364",
	["Corrupted"] = "117786124969873",
	["Cosmos"] = "98515193682295",
	["Creator"] = "131499935715420",
	["Cyber"] = "137234532221980",
	["Cyberpunk"] = "101580472930405",
	["Dark Matter"] = "105633429978746",
	["Developer_s_Choice"] = "71583713299628",
	["Developer"] = "84828462847242",
	["Digital"] = "90007006021998",
	["Divine"] = "140734768838620",
	["Dragon"] = "103964263665392",
	["Eclipse"] = "122443480831209",
	["Error"] = "131377560126666",
	["Eternal"] = "129052041377650",
	["Fire"] = "101280897641718",
	["Fractal"] = "112714984746425",
	["Galaxy"] = "138878292741986",
	["Genesis"] = "86144209685666",
	["Glitch"] = "70758048338282",
	["Glitched_Reality"] = "92570026399069",
	["Godly"] = "112688977914958",
	["Heavenly"] = "80922411345107",
	["Hellfire"] = "120795484860323",
	["Holographic"] = "118995436252676",
	["Inferno"] = "137727953312129",
	["Infinity_Cube"] = "101225939676011",
	["Infinity"] = "77463581376512",
	["Jungle"] = "120131039325586",
	["Lava"] = "104008310648656",
	["Lightning"] = "78416117944378",
	["Lunar"] = "112907641115390",
	["Meteor"] = "122379748920849",
	["Nebula_Core"] = "86045756603662",
	["Nuclear"] = "108845873717220",
	["Omega"] = "128159016258838",
	["Omniscient"] = "90535937236468",
	["One In A Million"] = "75345553636939",
	["Owner"] = "88367968271072",
	["Paradox"] = "89983344284335",
	["Phoenix"] = "84275078527911",
	["Plasma"] = "121069723606499",
	["Prism"] = "113760452252622",
	["Quantum"] = "72196783017828",
	["Rainbow"] = "112466052902457",
	["RGB"] = "118464858613198",
	["Royal"] = "89777951513455",
	["Runic"] = "113967030075075",
	["Shadowfire"] = "114896804023722",
	["Singularity"] = "77312867280101",
	["Solar"] = "101671399335266",
	["Spectral"] = "123515798663569",
	["Starlight"] = "96194978694833",
	["Storm"] = "97704799712501",
	["The End"] = "119305990320915",
	["The_First_Domino"] = "88746783354683",
	["Toxic"] = "114817333544039",
	["Transcendent"] = "128650560638411",
	["Treasure"] = "75328485865761",
	["Void"] = "98297076271673",
	["Volcano"] = "120363131041096",
}

function this.getDominoPart(part, skinName)
	local data = this.SkinData[skinName]

	part.Color = data.Color
	part.Material = data.Material
	part.Transparency = data.Transparency
	part.Reflectance = data.Reflectance

	if data.IsCustom then
		for _, child in ipairs(part:GetChildren()) do
			if child:IsA("Decal") then
				child:Destroy()
			end
		end
		if not Decals[skinName] then print("missing"..skinName) return end
			
		
		local left = Instance.new("Decal")
		left.Name = "SkinDecal"
		left.Parent = part
	
		left.Texture = "rbxassetid://" .. Decals[skinName]
		left.Face = Enum.NormalId.Left

		local right = Instance.new("Decal")
		right.Name = "SkinDecal"
		right.Parent = part
		right.Texture = "rbxassetid://" .. Decals[skinName]
		right.Face = Enum.NormalId.Right
	end
end

return this
