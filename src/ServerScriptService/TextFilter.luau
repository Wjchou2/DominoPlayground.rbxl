local TextService = game:GetService("TextService")
local this = {}

function this.filterText(player: Player,text: string):string
	local filterResult=""
	local success=false
	if not player then
		  success, filterResult = pcall(function()
			return TextService:FilterStringAsync(text, game.Players:GetPlayers()[1].UserId)
		end)
	else
		  success, filterResult = pcall(function()
			return TextService:FilterStringAsync(text, player.UserId)
		  end)
	end
	if success and filterResult then

		local filteredText
		local ok, result = pcall(function()
			return filterResult:GetNonChatStringForBroadcastAsync()
		end)

		if ok and result then
			filteredText = result
			--if string.find(filteredText, "#") then
			--	return "#"
			--end
			return filteredText
		end
	end

	return "" -- fallback
end

return this
