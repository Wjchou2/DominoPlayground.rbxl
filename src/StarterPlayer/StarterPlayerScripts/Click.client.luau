local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local clickSound =game.SoundService:WaitForChild("Effects"):WaitForChild("click")


local connected = {}

local function connectButton(button)
	if connected[button] then
		return
	end

	connected[button] = true

	button.Activated:Connect(function()
		game.SoundService:WaitForChild("Effects"):WaitForChild("click"):Play()
		
	end)
end

local function scanGui(gui)
	for _, obj in ipairs(gui:GetDescendants()) do
		if obj:IsA("TextButton") or obj:IsA("ImageButton") then
			connectButton(obj)
		end
	end
end

scanGui(playerGui)

playerGui.DescendantAdded:Connect(function(obj)
	if obj:IsA("TextButton") or obj:IsA("ImageButton") then
		connectButton(obj)
	end
end)