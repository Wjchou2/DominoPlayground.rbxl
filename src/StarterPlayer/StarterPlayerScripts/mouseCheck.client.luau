_G.held=false
local player = game.Players.LocalPlayer

local mouse = player:GetMouse()

mouse.Button1Down:Connect(function()
	_G.held=true

end)

mouse.Button1Up:Connect(function()
	_G.held=false


end)
