local skinData = require(game.ReplicatedStorage.SkinData)
local skins = skinData.SkinData
local y=1

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

local lastHovered = nil


for i=1,#skinData.order do
	local skinName=skinData.order[i]
	local skin=skins[skinName]
	
	local domino = Instance.new("Part")
	domino.Anchored = true
	domino.Size = Vector3.new(0.5, 6, 3)
	domino.CFrame = CFrame.Angles(0, math.rad(45), 0)
	skinData.getDominoPart(domino,skinName)
	local y=math.floor((i-1)/15)
	domino.Position=workspace:WaitForChild("templateStart").Position+Vector3.new(0, 2+y*7 , -5*(((i-1)+15)%15) )
	domino.Parent = workspace.Templates
	
end

--local highlight = Instance.new("Highlight")
--highlight.FillTransparency = 0.8
--highlight.OutlineTransparency = 0
--highlight.Parent = workspace

--mouse.Move:Connect(function()
--	local target = mouse.Target
--	if target and target:IsDescendantOf(workspace.Templates) then
--		highlight.Adornee = target
--	else
--		highlight.Adornee = workspace.templateStart
		
--	end
--end)