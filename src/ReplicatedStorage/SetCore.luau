local this = {}
local StarterGui = game:GetService("StarterGui")
function this.toggleBackpackVisibility(toggle:boolean)
	task.spawn(function()
		local success = false
		while not success do
			success = pcall(function()
				StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, toggle)
			end)
			task.wait(0)
		end
	end)
end
function this.toggleResetButtonVisibility(toggle:boolean)
	task.spawn(function()
		local success = false
		while not success do
			success = pcall(function()
				StarterGui:SetCore("ResetButtonCallback", toggle)
			end)
			task.wait(0)
		end
	end)
end
function this.toggleCharControl(toggle:boolean)
	local controls =require(game.Players.LocalPlayer.PlayerScripts.PlayerModule):GetControls()
	controls:Enable(toggle)
end
return this
