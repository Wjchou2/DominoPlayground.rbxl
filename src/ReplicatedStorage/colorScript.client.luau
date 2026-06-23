_G.currentSelectedColor={0,0,0}
local name=script.Parent.Name

script.Parent.MouseEnter:Connect(function()

	if _G.held then
		local dotIndex = string.find(name, "%.") -- Find the position of "."


		local x = tonumber(string.sub(name, 1, dotIndex - 1))  -- Extract part before "."
		local y = tonumber(string.sub(name, dotIndex + 1))     -- Extract part after "."
		local color=Color3.new(_G.currentSelectedColor[1],_G.currentSelectedColor[2],_G.currentSelectedColor[3])
		_G.saveDrawing[x][y]=color
		


		--_G.saveDrawing[]
		script.Parent.BackgroundColor3=color
	end
end)

