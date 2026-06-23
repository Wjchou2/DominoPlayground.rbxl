local redeemDaily=game.ReplicatedStorage:WaitForChild("redeemDaily")
local leaderstatsControl=require(game.ReplicatedStorage.LeaderstatsControl)
local abbreviation=require(game.ReplicatedStorage.Abbreviation)
--local incrementPoints=game.ReplicatedStorage:WaitForChild("incrementPoints")
--local closeLogin=game.ReplicatedStorage:WaitForChild("closeLogin")
local sendMessageToClient=game.ReplicatedStorage:WaitForChild("Message")
local OpenCrate= game.ReplicatedStorage:WaitForChild("OpenCrate")

redeemDaily.OnServerEvent:Connect(function(player, dayNumber)
	player:WaitForChild("hiddenData"):WaitForChild("DominoInventory")
	wait(0.1)
	dayNumber=tonumber(dayNumber)
	if leaderstatsControl.getValue(player,"LastLoginDay")+1==dayNumber then	
	if os.time()-leaderstatsControl.getValue(player,"LastClaimTime")>86400 then
		--incrementPoints:FireClient(player,rewardAmounts[leaderstatsControl.getValue(player,"LastLoginDay")+1])

			local day=leaderstatsControl.getValue(player,"LastLoginDay")+1
			if day == 1 then
				leaderstatsControl.incrementValue(player, "Dots", 5000)

				sendMessageToClient:FireClient(player, "Day 1: +5,000 Dots, Common Crate!", Color3.new(0.127764, 1, 0.490517))

				task.delay(1, function()
					OpenCrate:Fire(player, "Common Crate")
				end)

			elseif day == 2 then
				leaderstatsControl.incrementValue(player, "Dots", 10000)
				leaderstatsControl.incrementValue(player, "DominoInventory", 50)

				sendMessageToClient:FireClient(player, "Day 2: +10,000 Dots, +50 Dominoes, Rare Crate!", Color3.new(0.127764, 1, 0.490517))

				task.delay(1, function()
					OpenCrate:Fire(player, "Rare Crate")
				end)

			elseif day == 3 then
				leaderstatsControl.incrementValue(player, "Dots", 20000)
				leaderstatsControl.incrementValue(player, "DominoInventory", 100)

				sendMessageToClient:FireClient(player, "Day 3: +20,000 Dots, +100 Dominoes, Rare Crate!", Color3.new(0.127764, 1, 0.490517))

				task.delay(1, function()
					OpenCrate:Fire(player, "Rare Crate")
				end)

			elseif day == 4 then
				leaderstatsControl.incrementValue(player, "Dots", 35000)
				leaderstatsControl.incrementValue(player, "DominoInventory", 200)

				sendMessageToClient:FireClient(player, "Day 4: +35,000 Dots, +200 Dominoes, Epic Crate!", Color3.new(0.127764, 1, 0.490517))

				task.delay(1, function()
					OpenCrate:Fire(player, "Epic Crate")
				end)

			elseif day == 5 then
				leaderstatsControl.incrementValue(player, "Dots", 50000)
				leaderstatsControl.incrementValue(player, "DominoInventory", 200)

				sendMessageToClient:FireClient(player, "Day 5: +50,000 Dots, +200 Dominoes, Neon Crate!", Color3.new(0.127764, 1, 0.490517))

				task.delay(1, function()
					OpenCrate:Fire(player, "Neon Crate")
				end)

			elseif day == 6 then
				leaderstatsControl.incrementValue(player, "Dots", 75000)
				leaderstatsControl.incrementValue(player, "DominoInventory", 300)

				sendMessageToClient:FireClient(player, "Day 6: +75,000 Dots, +300 Dominoes, Galaxy Crate!", Color3.new(0.127764, 1, 0.490517))

				task.delay(1, function()
					OpenCrate:Fire(player, "Galaxy Crate")
				end)

			elseif day == 7 then
				leaderstatsControl.incrementValue(player, "Dots", 150000)
				leaderstatsControl.incrementValue(player, "DominoInventory", 300)

				sendMessageToClient:FireClient(player, "Day 7: +150,000 Dots, +300 Dominoes, Legendary Crate!", Color3.new(0.127764, 1, 0.490517))

				task.delay(1, function()
					OpenCrate:Fire(player, "Legendary Crate")
				end)
			end
			
			leaderstatsControl.setValue(player,"LastClaimTime",os.time())
			
			leaderstatsControl.incrementValue(player,"LastLoginDay",1)

			if leaderstatsControl.getValue(player,"LastLoginDay")==7 then
				leaderstatsControl.setValue(player,"LastLoginDay",0)
			end
		--closeLogin:FireClient(player)
	else
		sendMessageToClient:FireClient(player,"You must wait "..  abbreviation.abbreviateTime(86400-(os.time()-leaderstatsControl.getValue(player,"LastClaimTime"))).." until you can claim!",Color3.new(0.117372, 0.327291, 1))
	end
	end
end)