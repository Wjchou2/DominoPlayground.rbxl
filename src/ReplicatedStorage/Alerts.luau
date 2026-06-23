
local this = {}
function this.alert(message:string)
	local gui=game.Players.LocalPlayer.PlayerGui:WaitForChild("GameplayGui")
	local frame=gui:WaitForChild("TopBar")
	local alertText=frame:WaitForChild("Alert"):Clone()
	alertText.Parent=frame
	alertText.Text=message
	alertText.Visible=true
	alertText.Transparency=0
	wait(2.5)
	local anim=game.TweenService:Create(alertText,TweenInfo.new(0.4),{Transparency=1})
	anim:Play()
	anim.Completed:Connect(function()
		alertText:Destroy()
	end)
end
return this
