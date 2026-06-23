

local RemoteEvent = game:GetService("ReplicatedStorage"):WaitForChild("UpdateNum")



RemoteEvent.OnClientEvent:Connect(function(Num)
	game.Players.LocalPlayer.PlayerGui:WaitForChild("Btn").Frame1.Frame.DominoNums.Text="Dominoes: "..Num
end)
--local Message = game:GetService("ReplicatedStorage"):WaitForChild("Message")



--Message.OnClientEvent:Connect(function(Num)

--	for  i =1,20 do 
--		game.Players.LocalPlayer.PlayerGui.Btn.RunOut.Transparency=1-i/20
--		wait(0.01)


--	end
--	wait(3)
--	for  i =1,20 do 
--		game.Players.LocalPlayer.PlayerGui.Btn.RunOut.Transparency=i/20
--		wait(0.01)


--	end
--end)