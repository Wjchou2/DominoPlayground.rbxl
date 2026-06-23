local sendFeedback=game.ReplicatedStorage:WaitForChild("sendFeedback")
local HS = game:GetService("HttpService")
local WebhookURL = "https://discord.com/api/webhooks/1363320468362367036/ysE6aLU9BpK2WLw5A9ZCExPIORwtwzNzPH8XybVPFqv9ksWpUau0UVCEYcBFQ2qNninA"
sendFeedback.OnServerEvent:Connect(function(player, message)
	local MessageData = {
		["username"] = player.Name,
		["content"] = message
	}
	MessageData = HS:JSONEncode(MessageData)
	HS:PostAsync(WebhookURL,MessageData)
end)
