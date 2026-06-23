local part = script.Parent.Parent
local prompt = script.Parent
local textLabel = part.SurfaceGui.TextLabel
local abbrev=require(game.ReplicatedStorage.Abbreviation)
textLabel.Text = "x"..tonumber(script.Parent.Parent.Name)/16 .." Speed"

local leaderstats = require(game.ReplicatedStorage.LeaderstatsControl)
local HttpService = game:GetService("HttpService")

local speedUpgradePrices = {
	["16"] = 0,
	["32"] = 5000,
	["48"] = 25000,
	["64"] = 100000,
	["80"] = 400000,
	["96"] = 1500000,
}

local speedName = part.Name
local price = speedUpgradePrices[speedName]

prompt.ActionText = "Buy " .. textLabel.Text .. " for " .. abbrev.abbreviate(price) .. " Dots"
local message=game.ReplicatedStorage.Message

prompt.Triggered:Connect(function(player)
	local upgradeList = HttpService:JSONDecode(leaderstats.getValue(player, "SpeedUpgrades2"))

	if upgradeList[speedName] then
		return
	end

	if upgradeList[speedName] == false and leaderstats.getValue(player, "Dots") >= price then
		message:FireClient(player,"Bought!",Color3.new(0.399725, 0.942565, 0.472297))

		leaderstats.incrementValue(player, "Dots", -price)

		upgradeList[speedName] = true
		leaderstats.setValue(player, "SpeedUpgrades2", HttpService:JSONEncode(upgradeList))
	else
		message:FireClient(player,"Not Enough dots, place some dominoes to earn more!",Color3.new(1, 0.382712, 0.453941))
	end
end)

part.Touched:Connect(function(hit)
	local character = hit.Parent
	local humanoid = character and character:FindFirstChild("Humanoid")

	if humanoid then
		local player = game.Players:GetPlayerFromCharacter(character)

		if player then
			local upgradeList = HttpService:JSONDecode(leaderstats.getValue(player, "SpeedUpgrades2"))

			if upgradeList[speedName] then
				humanoid.WalkSpeed = tonumber(speedName)
			end
		end
	end
end)