local playSoundLocal= game.ReplicatedStorage:WaitForChild("playSoundLocal")
playSoundLocal.OnClientEvent:Connect(function(sound)
	sound:Play()
end)