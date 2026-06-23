local streaks={}
local times={}
local lastDomino={}
local currentChain={}
local tweenService=game:GetService("TweenService")
local updateStreak= game.ReplicatedStorage:WaitForChild("updateStreak")
local leaderstatsControl = require(game.ReplicatedStorage.LeaderstatsControl) -- Require the module script
local sounds = require(game.ReplicatedStorage.Sounds) -- Require the module script

local skinDataModule=require(game.ReplicatedStorage.SkinData)
game.Players.PlayerAdded:Connect(function(player)
	local streakval=Instance.new("IntValue")
	streakval.Name="streak"
	streakval.Value=0
	streakval.Parent=player
end)
game.RunService.Heartbeat:Connect(function()
	for i,v:Part in pairs(game.Workspace.playerDominoes:GetChildren()) do
		if v.CFrame.UpVector.Y < math.cos(math.rad(20)) and not v:FindFirstChild("Highlight") then
			if not streaks[v.Name] then
				streaks[v.Name]=0
			end
			
			if not currentChain[v.Name] then
				currentChain[v.Name]={}
			end
			
			sounds.playSoundFromPart(game.SoundService.Domino:GetChildren()[math.random(1,#game.SoundService.Domino:GetChildren())],v)
			
			times[tostring(v.Name)]=0
			local highlight=Instance.new("Highlight")
			highlight.Parent=v
			highlight.Adornee=v
			highlight.FillTransparency=0.8
			highlight.DepthMode=Enum.HighlightDepthMode.Occluded
			highlight.OutlineTransparency=0.8
			highlight.OutlineColor=Color3.new(0.90901, 0.92929, 0.912993)
			highlight.FillColor=Color3.new(0.90901, 0.92929, 0.912993)
			local sign=game.ServerStorage.DominoSign:Clone()
			sign.Parent=v
			streaks[v.Name]+=1
			game.Players:GetPlayerByUserId(tonumber(v.Name)):FindFirstChild("streak").Value+=1
				
			updateStreak:FireClient(game.Players:GetPlayerByUserId(tonumber(v.Name)),streaks[v.Name])
			sign.BillboardGui.TextLabel.Text="+"..streaks[v.Name]
			sign.BillboardGui.Adornee=v
			sign.BillboardGui.Size=UDim2.fromScale(4+0.1*streaks[v.Name],2+0.1*streaks[v.Name])
			sign.BillboardGui.TextLabel.TextColor3=Color3.new(0.01*streaks[v.Name],1-0.01*streaks[v.Name],1-0.01*streaks[v.Name])
			lastDomino[v.Name]=v
			table.insert(currentChain[v.Name],v)
			task.spawn(function()
				wait(0.2)
				if sign:FindFirstChild("BillboardGui") then
					tweenService:Create(sign.BillboardGui,TweenInfo.new(2),{StudsOffset=Vector3.new(0,5+0.1*streaks[v.Name],0)}):Play()
					tweenService:Create(sign.BillboardGui.TextLabel,TweenInfo.new(2),{TextTransparency=1}):Play()
				end
			end)


		end
	end

end)
local playSoundLocal= game.ReplicatedStorage:WaitForChild("playSoundLocal")
local abbrev=require(game.ReplicatedStorage.Abbreviation)
while wait(0.1) do
	for i,v in pairs(game.Players:GetPlayers()) do
		local success, result = pcall(function()
			if not times[tostring(v.UserId)] then
				times[tostring(v.UserId)]=0
			end
			if not currentChain[v.Name] then
				currentChain[v.Name]={}
			end

			times[tostring(v.UserId)]+=0.1
			if (times[tostring(v.UserId)]>=1) then
				times[tostring(v.UserId)]=0

				if lastDomino[tostring(v.UserId)] then

					local id=tostring(v.UserId)
					if  lastDomino[id]  then 
						local sign=lastDomino[id]:FindFirstChild("DominoSign"):FindFirstChild("BillboardGui")
						if  sign  and sign.TextLabel then
							local streak=streaks[tostring(v.UserId)]
							local equipped=leaderstatsControl.getValue(v,"EquippedSkin")
							local reward = math.floor(
								(streak * (streak + 1) / 2)
									* (1 + streak / 5000))*skinDataModule.SkinMultipliers[skinDataModule.SkinRarity[equipped]]

							sign.TextLabel.Text=streak.." STREAK!".."  +".. abbrev.abbreviate(reward).." Dots"
							sign.TextLabel.TextColor3=Color3.new(1, 0.410178, 0.368353)
								
							leaderstatsControl.incrementValue(v, "Dots", reward)
							playSoundLocal:FireClient(v,game.SoundService.Effects.cash)
							tweenService:Create(sign,TweenInfo.new(1.5),{StudsOffset=Vector3.new(0,math.clamp(5+0.2*streaks[id],0,30),0),Size=UDim2.fromScale(4+0.5*streaks[id],2+0.5*streaks[id])}):Play()
							tweenService:Create(sign.TextLabel,TweenInfo.new(0),{TextTransparency=0}):Play()
							lastDomino[id]=nil
							local newarr = table.clone(currentChain[id])
							currentChain[id]={}
							task.spawn(function()
								wait(2)
								if  sign:FindFirstChild("TextLabel") then 
									
								
								tweenService:Create(sign.TextLabel,TweenInfo.new(2),{TextTransparency=1}):Play()
								wait(10)
								for j,k in pairs(newarr) do
									task.spawn(function()
										_G.dominosLeftStates[v.UserId]+=1
										local fade=tweenService:Create(k,TweenInfo.new(1),{Transparency=1})
										fade:Play()
										fade.Completed:Wait()
										k:Destroy()
									end)
									end
								end
							end)
						end
					end
				end


				if streaks[tostring(v.UserId)]>tonumber(leaderstatsControl.getValue(v,"Streak")) then
					leaderstatsControl.setValue(v,"Streak",tonumber(streaks[tostring(v.UserId)]))
					updateStreak:FireClient(v,streaks[tostring(v.UserId)],true)
				end
				streaks[tostring(v.UserId)]=0
			end
		end)
		if not success then
			currentChain[v.Name]={}
		end
	end

end