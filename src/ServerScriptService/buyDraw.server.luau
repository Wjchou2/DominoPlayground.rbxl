buyDraw=game.ReplicatedStorage:WaitForChild("buyDraw")

myGamePassId=1093757786
MarketplaceService=game:GetService("MarketplaceService")
buyDraw.OnServerEvent:Connect(function(player)
	MarketplaceService:PromptGamePassPurchase(player, myGamePassId)
end)
MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, gamepassId, wasPurchased)
	if gamepassId == myGamePassId and wasPurchased then
		buyDraw:FireClient(player)
	end
end)