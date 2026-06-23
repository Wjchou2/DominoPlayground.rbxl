---- Created by @StrictlySimplify on 2026-05-02, 4:17 PM (EST)

--local ReplicatedStorage = game:GetService("ReplicatedStorage")
--local MarketplaceService = game:GetService("MarketplaceService")
--local Players = game:GetService("Players")
--local Icon = require(ReplicatedStorage:WaitForChild("Icon"))

--local icon = Icon.new()
--	:setAlignment("Right")
--	:setImage(72874351260536)
--	:setImageScale(0.65)

--icon:bindEvent("selected", function()
--	local player = Players.LocalPlayer
--	MarketplaceService:PromptRobloxSubscriptionPurchase(player)

--	MarketplaceService.PromptRobloxSubscriptionPurchaseFinished:Once(function()
--		icon:deselect()
--	end)
--end)