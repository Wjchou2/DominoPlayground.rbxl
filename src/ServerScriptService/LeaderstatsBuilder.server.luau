local leaderstatsControl = require(game.ReplicatedStorage.LeaderstatsControl) -- Require the module script
local datastoreControl = require(game.ServerScriptService.DatastoreControl) -- Require the module script
local badgeControl = require(game.ServerScriptService.BadgeControl) -- Require the module script
local httpService=game:GetService("HttpService")
local updateStreak= game.ReplicatedStorage:WaitForChild("updateStreak")
local Inventory = {}
local skinData=require(game.ReplicatedStorage.SkinData)
local Skins=skinData.Skins
for _, rarityTable in pairs(Skins) do
	for _, skinName in ipairs(rarityTable) do
		Inventory[skinName] = 0
	end
end
local HttpService = game:GetService("HttpService")

Inventory["White"] = 1
local speedUpgrades = {
	["16"] = true,
	["32"] = true,
	["48"] = false,
	["64"] = false,
	["80"] = false,
	["96"] = false,

}
--local welcomeBadge=1943780265534301
game.Players.PlayerAdded:Connect(function(player)
	wait(1)
	local leaderstatsFolder = Instance.new("Folder") 
	leaderstatsFolder.Name = "leaderstats" -- The name must be leaderstats or else it will not work
	leaderstatsFolder.Parent = player
	local hiddenData = Instance.new("Folder") 
	hiddenData.Name = "hiddenData" -- The name must be leaderstats or else it will not work
	hiddenData.Parent = player
	local fetchedState=datastoreControl.getValue(player)
	local function fallback(value, default)
		if value == nil or value == false or value == "" then
			return default
		end
		return value
	end
	leaderstatsControl.createNew("Streak", Instance.new("NumberValue"), fallback(fetchedState and fetchedState[1], 0), hiddenData)
	leaderstatsControl.createNew("Dots", Instance.new("NumberValue"), fallback(fetchedState and fetchedState[2], 0), leaderstatsFolder)
	leaderstatsControl.createNew("EquippedSkin", Instance.new("StringValue"), fallback(fetchedState and fetchedState[3], "White"), hiddenData)
	leaderstatsControl.createNew("Inventory", Instance.new("StringValue"), fallback(fetchedState and fetchedState[4],  HttpService:JSONEncode(Inventory)), hiddenData)
	leaderstatsControl.createNew("hasClaimedGroup", Instance.new("BoolValue"), fallback(fetchedState and fetchedState[5],  false), hiddenData)
	leaderstatsControl.createNew("thing", Instance.new("StringValue"), fallback(fetchedState and fetchedState[6],  HttpService:JSONEncode(speedUpgrades)), hiddenData)
	leaderstatsControl.createNew("DominoInventory", Instance.new("NumberValue"), fallback(fetchedState and fetchedState[7], 100), hiddenData)
	leaderstatsControl.createNew("SpeedUpgrades2", Instance.new("StringValue"), fallback(fetchedState and fetchedState[8],  HttpService:JSONEncode(speedUpgrades)), hiddenData)
	
	leaderstatsControl.createNew("LastClaimTime", Instance.new("IntValue"), fallback(fetchedState and fetchedState[9], 0), hiddenData)
	leaderstatsControl.createNew("LastLoginDay", Instance.new("IntValue"), fallback(fetchedState and fetchedState[10], 0), hiddenData)
	

	leaderstatsControl.createNew("HasJoined", Instance.new("BoolValue"), fallback(fetchedState and fetchedState[11], false), hiddenData)


	local waitForChar
	waitForChar=player.CharacterAdded:Wait()
	wait(1)
	updateStreak:FireClient(player,leaderstatsControl.getValue(player,"Streak"),true)

end)
function saveData(player:Player)
	local playerLeaderstats=player:WaitForChild("leaderstats")
	local tableToSave = {
		leaderstatsControl.getValue(player,"Streak"),
		leaderstatsControl.getValue(player,"Dots"),
		leaderstatsControl.getValue(player,"EquippedSkin"),
		leaderstatsControl.getValue(player,"Inventory"),
		leaderstatsControl.getValue(player,"hasClaimedGroup"),
		leaderstatsControl.getValue(player,"thing"),
		leaderstatsControl.getValue(player,"DominoInventory"),
		leaderstatsControl.getValue(player,"SpeedUpgrades2"),
		
		leaderstatsControl.getValue(player,"LastClaimTime"),
		leaderstatsControl.getValue(player,"LastLoginDay"),
		
		true --leaderstatsControl.getValue(player,"HasJoined"),




		
		--leaderstatsControl.getValue(player,"DominosKnocked")
	}
	datastoreControl.setValue(player,tableToSave)
end
game.Players.PlayerRemoving:Connect(function(player)
	saveData(player)
end)

while wait(60) do
	for i,player in pairs(game.Players:GetPlayers()) do
		saveData(player)
	end
	print("Saving All Player data")
end
