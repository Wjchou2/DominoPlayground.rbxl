local Lplayer
local toggleStates={}
_G.spawnItStates={}
_G.dominosLeftStates={}
local playerStates={}
local dominoSizes={}

local bgStates={}
local updateDominoPlayerSize=game.ReplicatedStorage:WaitForChild("updateDominoPlayerSize")
local buyLargerDominoes=game.ReplicatedStorage:WaitForChild("buyLargerDominoes")
local MarketplaceService=game:GetService("MarketplaceService")
local tweenService=game:GetService("TweenService")
local Message = game:GetService("ReplicatedStorage"):WaitForChild("Message")

local spawnDomino = game:GetService("ReplicatedStorage"):WaitForChild("SpawnDominoEvent")
local Infinite = game:GetService("ReplicatedStorage"):WaitForChild("BoughtInfinite")
local ChangeBG=game:GetService("ReplicatedStorage"):WaitForChild("ChangeBG")
local boughtIn={}
local GetPlayerData=game:GetService("ReplicatedStorage"):WaitForChild("GetPlayerData")

local leaderstats=require(game.ReplicatedStorage.LeaderstatsControl)


local Players = game:GetService("Players")
ChangeBG.OnServerEvent:Connect(function(player,changeType)
	bgStates[player.UserId]=changeType

end)

game.MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, pass_id, was_purchased)
	if pass_id==268945302 and was_purchased then
		print(player.Name,player.UserId)
		
		boughtIn[player.UserId]=true
		_G.spawnItStates[player.UserId]=false
		_G.dominosLeftStates[player.UserId]=math.huge
		leaderstats.setValue(player,"DominoInventory",math.huge)
		game:GetService("ReplicatedStorage"):WaitForChild("UpdateNum"):FireClient(player,_G.dominosLeftStates[player.UserId])
	end
end)


Infinite.OnServerEvent:Connect(function(player)
	print(player.Name,player.UserId)
	
	boughtIn[player.UserId]=true
	_G.spawnItStates[player.UserId]=false
	_G.dominosLeftStates[player.UserId]=math.huge
	player:WaitForChild("hiddenData"):WaitForChild("DominoInventory")
	leaderstats.setValue(player,"DominoInventory",math.huge)
	game:GetService("ReplicatedStorage"):WaitForChild("UpdateNum"):FireClient(player,_G.dominosLeftStates[player.UserId])


end)
local RemoteEvent = game:GetService("ReplicatedStorage"):WaitForChild("UpdateNum")

Players.PlayerAdded:Connect(function(player)
	boughtIn[player.UserId]=false
	local	placed = Instance.new("IntValue")
	placed.Name = "Placed"
	placed.Parent = player


	bgStates[player.UserId]="rainbow"
	dominoSizes[player.UserId]=1
	playerStates[player.UserId]=Vector3.new(0,0,0)
	if boughtIn[player.UserId]==true then
		_G.dominosLeftStates[player.UserId]=math.huge
	else
		player:WaitForChild("hiddenData"):WaitForChild("DominoInventory")
		_G.dominosLeftStates[player.UserId]=leaderstats.getValue(player,"DominoInventory")

	end
	RemoteEvent:FireClient(player,_G.dominosLeftStates[player.UserId])


end)

Players.PlayerRemoving:Connect(function(player)
	for i,v in pairs(game.Workspace.playerDominoes:GetChildren()) do
		if v.Name==tostring(player.UserId) then
			v:Destroy()
		end
	end
end)


buyLargerDominoes.OnServerEvent:Connect(function(player)
	MarketplaceService:PromptGamePassPurchase(player, 1098501660)
	MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(playerBought, gamepassId, wasPurchased)
		if playerBought.UserId==player.UserId and gamepassId==1098501660 and wasPurchased then
			buyLargerDominoes:FireClient(player)
		end
	end)

end)

updateDominoPlayerSize.OnServerEvent:Connect(function(player,newsize)
	dominoSizes[player.UserId]=newsize
	GetPlayerData:FireClient(player,newsize)

end)
local colors = {"Bright red", "Bright orange", "Bright yellow", "Bright green", "Bright blue", "Bright violet"}
local Neoncolors = {"Bright red", "CGA brown", "Fawn brown", "Bright green", "Bright blue", "Bright violet"}
local skinData=require(game.ReplicatedStorage.SkinData)

local leaderstatsControl=require(game.ReplicatedStorage.LeaderstatsControl)
spawnDomino.OnServerEvent:Connect(function(player,charPos,direction,cindex)
	if _G.dominosLeftStates[player.UserId] <=0 then
		Message:FireClient(player,"No Dominoes Left, buy more in shop!",Color3.new(1, 0.34844, 0.464942))
		return
	end
	local placed = player:FindFirstChild("Placed")

	if not placed then
		placed = Instance.new("IntValue")
		placed.Name = "Placed"
		placed.Parent = player
	end

	placed.Value += 1

	local part = Instance.new("Part")
	local rotationMatrix = CFrame.Angles(0, math.pi / 2, 0)
	part.CFrame = CFrame.lookAt(charPos, charPos + direction*2) * rotationMatrix
	part.Name = tostring(player.UserId)
	part.Anchored = true
	part.Shape = "Block"
	part.Transparency=0
	part.CanCollide=false
	part.CastShadow=false
	part.Size = Vector3.zero

	--local data=skinData.SkinData[leaderstatsControl.getValue(player,"EquippedSkin")]
	skinData.getDominoPart(part,leaderstatsControl.getValue(player,"EquippedSkin"))


	--if bgStates[player.UserId]=="rainbow" then
	--	part.BrickColor = BrickColor.new(colors[cindex])
	--elseif bgStates[player.UserId]=="plant" then
	--	local textureFront = Instance.new("Decal")
	--	local textureBack = Instance.new("Decal")
	--	textureFront.Texture = "rbxassetid://15163084206"
	--	textureBack.Texture = "rbxassetid://15163084206"
	--	part.BrickColor=BrickColor.new("Dark green")
	--	textureFront.Face="Right"
	--	textureBack.Face="Left"
	--	textureFront.Parent = part
	--	textureBack.Parent = part
	--elseif bgStates[player.UserId]=="classic" then
	--	local textureFront = Instance.new("Decal")
	--	local textureBack = Instance.new("Decal")
	--	textureFront.Texture = "rbxassetid://15156334164"
	--	textureBack.Texture = "rbxassetid://15156334164"
	--	textureFront.Face="Right"
	--	textureBack.Face="Left"
	--	textureFront.Parent = part
	--	textureBack.Parent = part
	--elseif bgStates[player.UserId]=="neon" then
	--	part.Material='Neon'
	--	part.BrickColor = BrickColor.new(Neoncolors[cindex])
	--elseif bgStates[player.UserId]=="amongUs" then
	--	part.BrickColor = BrickColor.new("Fire Yellow")
	--	local textureFront = Instance.new("Decal")
	--	local textureBack = Instance.new("Decal")
	--	textureFront.Texture = "rbxassetid://15163964105"
	--	textureBack.Texture = "rbxassetid://15163964105"
	--	textureFront.Face="Right"
	--	textureBack.Face="Left"
	--	textureFront.Parent = part
	--	textureBack.Parent = part
	--end
	local event=game:GetService("ReplicatedStorage"):WaitForChild("UpdateNum")
	event:FireClient(player,_G.dominosLeftStates[player.UserId])
	part.Parent = workspace.playerDominoes
	tweenService:Create(part,TweenInfo.new(0.6,Enum.EasingStyle.Bounce,Enum.EasingDirection.InOut),{Size=Vector3.new(0.5, 6*dominoSizes[player.UserId], 3*dominoSizes[player.UserId])}):Play()

	_G.dominosLeftStates[player.UserId]-=1
	local playerdomino=game.ServerStorage:WaitForChild("playerdomino"):Clone()
	playerdomino.Parent=part
end)
--spawnDomino.OnServerEvent:Connect(function(player,togglething,size)



--toggleStates[player.UserId]=togglething
--local colors = {"Bright red", "Bright orange", "Bright yellow", "Bright green", "Bright blue", "Bright violet"}
--local Neoncolors = {"Bright red", "CGA brown", "Fawn brown", "Bright green", "Bright blue", "Bright violet"}
--local cindex = 1
--if toggleStates[player.UserId]==true then

--	if _G.dominosLeftStates[player.UserId]>0 then
--		_G.spawnItStates[player.UserId]=true
--		while _G.spawnItStates[player.UserId]==true do
--			local Mag=0
--			if player.Character then


--				Mag = (player.Character:WaitForChild("HumanoidRootPart").Position - playerStates[player.UserId]).Magnitude
--			end
--			if Mag>0.5 then
--				if _G.dominosLeftStates[player.UserId]>0 then
--					local character = player.Character
--					local HumanoidRootPart = character and character:WaitForChild("HumanoidRootPart")

--					if HumanoidRootPart then
--						local direction = HumanoidRootPart.CFrame.LookVector
--						local playerPos=character.PrimaryPart.Position
--						local characterPosition = Vector3.new(playerPos.X,playerPos.Y+dominoSizes[player.UserId]*3-3,playerPos.Z)
--						local part = Instance.new("Part")
--						local rotationMatrix = CFrame.Angles(0, math.pi / 2, 0)
--						part.CFrame = CFrame.lookAt(characterPosition, characterPosition + direction*2) * rotationMatrix
--						part.Name = tostring(player.UserId)
--						part.Anchored = true
--						part.Shape = "Block"
--						part.Transparency=1
--						part.CanCollide=false
--						part.CastShadow=false
--						part.Size = Vector3.zero

--						playerStates[player.UserId]=player.Character:WaitForChild("HumanoidRootPart").Position

--						_G.dominosLeftStates[player.UserId]-=1

--						if bgStates[player.UserId]=="rainbow" then
--							part.BrickColor = BrickColor.new(colors[cindex])
--						elseif bgStates[player.UserId]=="plant" then

--							local textureFront = Instance.new("Decal")
--							local textureBack = Instance.new("Decal")
--							textureFront.Texture = "rbxassetid://15163084206"
--							textureBack.Texture = "rbxassetid://15163084206"
--							part.BrickColor=BrickColor.new("Dark green")

--							textureFront.Face="Right"
--							textureBack.Face="Left"
--							--textureBack.StudsPerTileU=6
--							--textureBack.StudsPerTileV=6
--							--textureBack.OffsetStudsU=1.5
--							--textureFront.StudsPerTileU=6
--							--textureFront.StudsPerTileV=6
--							--textureFront.OffsetStudsU=1.5
--							textureFront.Parent = part
--							textureBack.Parent = part
--						elseif bgStates[player.UserId]=="classic" then
--							local textureFront = Instance.new("Decal")
--							local textureBack = Instance.new("Decal")
--							textureFront.Texture = "rbxassetid://15156334164"
--							textureBack.Texture = "rbxassetid://15156334164"


--							textureFront.Face="Right"
--							textureBack.Face="Left"
--							--textureBack.StudsPerTileU=6
--							--textureBack.StudsPerTileV=6
--							--textureBack.OffsetStudsU=1.5
--							--textureFront.StudsPerTileU=6
--							--textureFront.StudsPerTileV=6
--							--textureFront.OffsetStudsU=1.5
--							textureFront.Parent = part
--							textureBack.Parent = part
--						elseif bgStates[player.UserId]=="neon" then
--							part.Material='Neon'
--							part.BrickColor = BrickColor.new(Neoncolors[cindex])

--						elseif bgStates[player.UserId]=="amongUs" then
--							part.BrickColor = BrickColor.new("Fire Yellow")
--							local textureFront = Instance.new("Decal")
--							local textureBack = Instance.new("Decal")
--							textureFront.Texture = "rbxassetid://15163964105"
--							textureBack.Texture = "rbxassetid://15163964105"
--							textureFront.Face="Right"
--							--textureFront.StudsPerTileU=3
--							--textureFront.StudsPerTileV=6
--							--textureFront.OffsetStudsU=-0.1
--							textureBack.Face="Left"
--							--textureBack.StudsPerTileU=3
--							--textureBack.StudsPerTileV=6
--							--textureBack.OffsetStudsU=-0.1
--							textureFront.Parent = part
--							textureBack.Parent = part
--						end
--						local event=game:GetService("ReplicatedStorage"):WaitForChild("UpdateNum")
--						event:FireClient(player,_G.dominosLeftStates[player.UserId])
--						part.Parent = workspace.playerDominoes
--						tweenService:Create(part,TweenInfo.new(0.6,Enum.EasingStyle.Bounce,Enum.EasingDirection.InOut),{Size=Vector3.new(0.5, 6*dominoSizes[player.UserId], 3*dominoSizes[player.UserId])}):Play()

--						if cindex == 6 then
--							cindex = 1
--						else
--							cindex = cindex + 1
--						end
--						playerStates[player.UserId]=player.Character:WaitForChild("HumanoidRootPart").Position

--						wait(0.2-player.Character.Humanoid.WalkSpeed/16/20)
--						local Mag = (player.Character:WaitForChild("HumanoidRootPart").Position - playerStates[player.UserId]).Magnitude
--						if Mag>0.5 then
--							part.Transparency=0

--							local playerdomino=game.ServerStorage:WaitForChild("playerdomino"):Clone()
--							playerdomino.Parent=part



--						else
--							part:Destroy()
--						end


--					end
--				else

--					game:GetService("ReplicatedStorage"):WaitForChild("Message"):FireClient(player)
--					break
--				end

--			else
--				wait((0.2-player.Character.Humanoid.WalkSpeed/16/20_))

--			end

--		end

--	else

--		game:GetService("ReplicatedStorage"):WaitForChild("Message"):FireClient(player)
--	end


--else


--	_G.spawnItStates[player.UserId]=false

--end


--end)
local promptBuyinfinite = game:GetService("ReplicatedStorage"):WaitForChild("promptBuyinfinite")
local MarketplaceService=game:GetService("MarketplaceService")
promptBuyinfinite.OnServerEvent:Connect(function(player)
	MarketplaceService:PromptGamePassPurchase(player, 268945302)

end)
