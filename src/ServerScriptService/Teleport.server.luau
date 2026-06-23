local RemoteEvent = game:GetService("ReplicatedStorage"):WaitForChild("TeleportEvent")


eventThing=RemoteEvent.OnServerEvent:Connect(function(player,object)
	
	local character = player.Character
	--local touchBlock = workspace:FindFirstChild("TouchBlock")

	--if character and touchBlock then


	character:SetPrimaryPartCFrame(CFrame.new(workspace:FindFirstChild(object).Position))
	--end


end)


