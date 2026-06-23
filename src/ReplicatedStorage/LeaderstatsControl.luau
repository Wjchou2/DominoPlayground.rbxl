local this = {}
local runService=game:GetService("RunService")
function this.createNew(name:string,statType:any,value:any,folder:Folder)
	if  runService:IsClient() then return end
	local stat = statType 
	stat.Name = name
	stat.Parent = folder
	if value then
		stat.Value = value
		return true
	else
		return false
	end
end

function this.incrementValue(player:Player,key:string,value:number)
	if  runService:IsClient() then return end

	if 	player:FindFirstChild("leaderstats"):FindFirstChild(key) then
		player:FindFirstChild("leaderstats"):FindFirstChild(key).Value+=value	
	else
		player:FindFirstChild("hiddenData"):FindFirstChild(key).Value+=value
	end
end
function this.setValue(player:Player,key:string,value:any)
	if  runService:IsClient() then return end
	if 	player:FindFirstChild("leaderstats"):FindFirstChild(key) then
		player:FindFirstChild("leaderstats"):FindFirstChild(key).Value=value	
	else
		player:FindFirstChild("hiddenData"):FindFirstChild(key).Value=value
	end
end



function this.getValue(player:Player,key:string)
	local leaderstats = player:WaitForChild("leaderstats")
	local hiddenData = player:WaitForChild("hiddenData")

	while true do
		local value =
			leaderstats:FindFirstChild(key)
			or hiddenData:FindFirstChild(key)

		if value then
			return value.Value
		end

		task.wait()
	end
end

return this
