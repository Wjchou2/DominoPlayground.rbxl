local RemoteEvent = game:GetService("ReplicatedStorage"):WaitForChild("DeleteDominoEvent")
local eventto = game:GetService("ReplicatedStorage"):WaitForChild("resetDom")
local leaderstats=require(game.ReplicatedStorage.LeaderstatsControl)
local CommunicationModule = require(game.ServerScriptService.CommunicationModule)
RemoteEvent.OnServerEvent:Connect(function(player)
	_G.spawnItStates[player.UserId]=false
	--if  not (workspace.playerDominoes:FindFirstChild(tostring(player.UserId))==nil) the
	if _G.dominosLeftStates[player.UserId] ~=math.huge then
		_G.dominosLeftStates[player.UserId]=leaderstats.getValue(player,"DominoInventory")

	end
	--end
	
	for i,v in pairs(game.Workspace.playerDominoes:GetChildren()) do
		if v.Name==tostring(player.UserId) then
			v:Destroy()
		end
	end


	game:GetService("ReplicatedStorage"):WaitForChild("UpdateNum"):FireClient(player,_G.dominosLeftStates[player.UserId])
	--CommunicationModule.sendData(nil)

	game:GetService("ReplicatedStorage"):WaitForChild("ChangeToggle"):FireClient(player,false)
 


end)
