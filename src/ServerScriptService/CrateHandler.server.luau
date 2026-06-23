local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local leaderstatsControl = require(ReplicatedStorage.LeaderstatsControl)
local buyCrate = ReplicatedStorage:WaitForChild("BuyCrate")
local skinData=require(game.ReplicatedStorage.SkinData)
local Skins=skinData.Skins
local SkinAnimation=ReplicatedStorage:WaitForChild("SkinAnimation")
local OpenCrate= ReplicatedStorage:WaitForChild("OpenCrate")
local crateData=require(game.ReplicatedStorage.CrateHandler)
local Crates=crateData.crateData
local ProductIds = {
	["Common Crate"] = 3605539278,
	["Rare Crate"] = 3605539328,
	["Epic Crate"] = 3605539425,
	["Legendary Crate"] = 3605539456,
	["Neon Crate"] = 3605539493,
	["Galaxy Crate"] = 3605539537,
	["Lava Crate"] = 3605539573,
	["Cyber Crate"] = 3605539612,
	["Divine Crate"] = 3605539649,
	["Void Crate"] = 3605539678,
}

local ProductRewards = {}
for crateName, productId in pairs(ProductIds) do
	ProductRewards[productId] = crateName
end

	
local function getCrate(crateName)
	for _, crate in ipairs(Crates) do
		if crate.name == crateName then
			return crate
		end
	end
end

local function rollRarity(crate)
	local roll = math.random(1, 100)
	local current = 0

	for _, rarity in ipairs(crate.LootTable) do
		current += rarity.Chance
		if roll <= current then
			return rarity.Rarity
		end
	end
end
local https = game:GetService("HttpService")
local function openCrate(player, crateName)
	local crate = getCrate(crateName)
	if not crate then return false end

	local rarity = rollRarity(crate)
	local skinList = Skins[rarity]
	if not skinList then return false end

	local skin = skinList[math.random(1, #skinList)]

	print(player.Name .. " opened " .. crateName .. " and got " .. rarity .. " skin: " .. skin)
	
	local Inventory = https:JSONDecode( leaderstatsControl.getValue(player,"Inventory"))
	
	SkinAnimation:FireClient(player, skin,Inventory[skin]>0 ,crateName)
	if Inventory[skin]==0 then
		
	
	Inventory[tostring(skin)]+=1
	
	leaderstatsControl.setValue(player,"Inventory",https:JSONEncode(Inventory))
	end
	return true, rarity, skin
end
local Message = game:GetService("ReplicatedStorage"):WaitForChild("Message")

buyCrate.OnServerEvent:Connect(function(player, crateName, robuxBuy)
	local crate = getCrate(crateName)
	if not crate then return end

	if robuxBuy then
		local productId = ProductIds[crateName]
		if productId then
			MarketplaceService:PromptProductPurchase(player, productId)
		end
		return
	end

	if leaderstatsControl.getValue(player, "Dots") >= crate.DotCost then
		leaderstatsControl.incrementValue(player, "Dots", -crate.DotCost)
		openCrate(player, crateName)
	else
		Message:FireClient(player,"Not enough Dots!",Color3.new(1, 0.34844, 0.464942))

	end
end)
local RemoteEvent = game:GetService("ReplicatedStorage"):WaitForChild("UpdateNum")
local message=game:GetService("ReplicatedStorage"):WaitForChild("Message")
local dominoData=require(game.ReplicatedStorage.DominoData)
MarketplaceService.ProcessReceipt = function(receiptInfo)
	local player = Players:GetPlayerByUserId(receiptInfo.PlayerId)
	if not player then
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end

	local crateName = ProductRewards[receiptInfo.ProductId]
	print(crateName)
	if not crateName then
		--Buy dominoes
		print(receiptInfo.ProductId)
		if table.find(dominoData.ids,tonumber(receiptInfo.ProductId))>-1 then
			local productId = receiptInfo.ProductId

			for key, value in pairs(dominoData.productIds) do
				print(value,productId)
				if tonumber(value) == tonumber(productId) then
					leaderstatsControl.incrementValue(player,"DominoInventory",tonumber(key))
					_G.dominosLeftStates[player.UserId]+=tonumber(key)
					RemoteEvent:FireClient(player,_G.dominosLeftStates[player.UserId])
					message:FireClient(player,"Bought "..tonumber(key).." dominoes",Color3.new(0.327626, 0.940673, 0.307622))
					
					break
				end
			end

		else
			print("not found")
		end
		
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end

	local success = openCrate(player, crateName)

	if success then
		return Enum.ProductPurchaseDecision.PurchaseGranted
	else
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end
end
local BuyDominoes=game.ReplicatedStorage:WaitForChild("BuyDominoes")

BuyDominoes.OnServerEvent:Connect(function(player,amt,cost)
	if leaderstatsControl.getValue(player,"Dots")>=cost then
	leaderstatsControl.incrementValue(player,"Dots", -cost)
		leaderstatsControl.incrementValue(player,"DominoInventory",amt)
		_G.dominosLeftStates[player.UserId]+=amt
		RemoteEvent:FireClient(player,_G.dominosLeftStates[player.UserId])
		message:FireClient(player,"Bought "..tonumber(amt).." dominoes",Color3.new(0.327626, 0.940673, 0.307622))

	end
end)

local UpdateEquipped=game.ReplicatedStorage:WaitForChild("UpdateEquipped")
UpdateEquipped.OnServerEvent:Connect(function(player, skinName)
	leaderstatsControl.setValue(player,"EquippedSkin",skinName)
end)
local incrementDots=game.ReplicatedStorage:WaitForChild("IncrementDots")
incrementDots.OnServerEvent:Connect(function(player,amount)
	leaderstatsControl.incrementValue(player,"Dots",amount)
	
	
end)
OpenCrate.Event:Connect(function(player, crateName)
	openCrate(player,crateName)
end)