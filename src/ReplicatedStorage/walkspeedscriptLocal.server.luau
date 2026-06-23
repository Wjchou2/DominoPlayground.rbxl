local part = script.Parent.Parent
local speedName = part.Name

local leaderstats = require(game.ReplicatedStorage.LeaderstatsControl)
local HttpService = game:GetService("HttpService")
local speedUpgrades = game.Players.LocalPlayer
	:WaitForChild("hiddenData")
	:WaitForChild("SpeedUpgrades2")

speedUpgrades.Changed:Connect(function(newValue)
	update()
	
end)
function update()
	

local upgradeList = HttpService:JSONDecode(leaderstats.getValue(game.Players.LocalPlayer, "SpeedUpgrades2"))
if upgradeList[speedName] then
		script.Parent.Enabled=false
		script.Parent.Parent:WaitForChild("Highlight").Enabled=false
else
		script.Parent.Enabled=true
		script.Parent.Parent:WaitForChild("Highlight").Enabled=true
end

	
end
update()
	