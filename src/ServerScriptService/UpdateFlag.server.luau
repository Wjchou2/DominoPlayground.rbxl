local datastore=require(game.ServerScriptService.DatastoreControl)
local ShowUpdatingFlag=game.ReplicatedStorage:WaitForChild("ShowUpdatingFlag")
while wait(10) do
	if datastore.getValueGlobal("updating")==true then
		ShowUpdatingFlag:FireAllClients(true)
	else
		ShowUpdatingFlag:FireAllClients(false)
	end
	
end