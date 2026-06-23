
local datastoreControl = {}
local DataStoreService = game:GetService("DataStoreService")
local leaderstatsControl = require(game.ReplicatedStorage.LeaderstatsControl) -- Require the module script
local httpService=game:GetService("HttpService")
local abbreviation = require(game.ReplicatedStorage.Abbreviation) -- Require the module script

local experienceStore = DataStoreService:GetDataStore("playerStates")
self=datastoreControl
function datastoreControl.setValue(player:Player, value:any)

	local success, errorMessage = pcall(function()
		experienceStore:SetAsync(player.UserId, value)
	end)
	if  not success then
		print(errorMessage)	
		return nil
	end
end
function datastoreControl.setValueGlobal(key:string, value:any)

	local success, errorMessage = pcall(function()
		experienceStore:SetAsync(key, value)
	end)
	if  not success then
		print(errorMessage)	
		return nil
	end
end
function datastoreControl.getValueGlobal(key:string)
	local data=false
	local success, err = pcall(function()
		data = experienceStore:GetAsync(key)
	end)
	if success and data then
		return data

	end
	return false
end
function datastoreControl.getValue(player:Player)
	local data=false
	local success, err = pcall(function()
		data = experienceStore:GetAsync(player.UserId)
	end)
	if success and data then
		return data

	end
	return false

end
function datastoreControl.setOrderedDataStore(player:Player,key:string, value:any)

	local orderedStore = DataStoreService:GetOrderedDataStore(key)
	orderedStore:SetAsync(player.UserId, value)
end

function datastoreControl.getOrderedDataStore(key:string,amount:any)
	local pageSize = amount
	local orderedStore = DataStoreService:GetOrderedDataStore(key)
	local pages = orderedStore:GetSortedAsync(false, pageSize)
	return pages:GetCurrentPage()
end

--function datastoreControl.redrawLeaderboard()

--	end

function datastoreControl.setAllOrderedDataStore(key:string)
	local orderedStore = DataStoreService:GetOrderedDataStore(key)
	for i,player in pairs(game.Players:GetPlayers()) do
		orderedStore:SetAsync(player.UserId, httpService:JSONDecode(player.hiddenData.Stats.Value)[key])
	end
end

function datastoreControl.redrawLeaderboard(guiDisplay,frameElement:Frame,key:string,abbreviateTime)
	local entry=game.ServerStorage:WaitForChild("leaderboardEntry")
	for i,v in pairs(frameElement:GetChildren()) do
		if  v.Name=="leaderboardEntry" then
		v:Destroy()
		end
	end
	local playerrank=0
	for rank,v in pairs(datastoreControl.getOrderedDataStore(key,10)) do
		local name =nil
		local success, response = pcall(function()
			name = game.Players:GetNameFromUserIdAsync(tonumber(v.key))

		end)
		if success and name then
			playerrank+=1
			local stat
			if abbreviateTime then
				stat = abbreviation.abbreviateTime(v.value)
			else
				 stat = abbreviation.abbreviate(v.value)
			end
			
			local playerEntry=entry:Clone()
			guiDisplay.initAsSurfaceGui(playerEntry)
			playerEntry.Parent=frameElement
			playerEntry.Text=name..": "..stat

			--if playerrank==1 then
			--	playerEntry.BackgroundColor3=Color3.fromRGB(255, 215, 0)
			--elseif playerrank==2 then
			--	playerEntry.BackgroundColor3=Color3.fromRGB(192, 192, 192)
			--elseif playerrank==3 then
			--	playerEntry.BackgroundColor3=Color3.fromRGB(205, 127, 50)
			--else
				playerEntry.BackgroundTransparency=1
			--end
			
			guiDisplay.showGui(playerEntry,UDim2.new(0.5, 0,0.1*playerrank-0.1+0.02,0))
		end
	end
end
return datastoreControl