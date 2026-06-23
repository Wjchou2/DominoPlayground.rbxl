local colors = {"Bright red", "Bright orange", "Bright yellow", "Bright green", "Bright blue", "Bright violet"}
local red=BrickColor.new("Bright red")
local green=BrickColor.new("Bright green")

btnFolder=workspace.Buttons
btn1=btnFolder.button1
btn2=btnFolder.button2
btn3=btnFolder.button3
btn4=btnFolder.button4
btn5=btnFolder.button5

btn1.BrickColor = green
btn2.BrickColor = green
btn3.BrickColor = green
btn4.BrickColor = green
btn5.BrickColor = green

local cindex=1
local images=require(game.ServerScriptService.Images)
local TweenService = game:GetService("TweenService")
local function fallDomino(domino)
	if domino:GetAttribute("Fallen") then return end
	domino:SetAttribute("Fallen", true)
	local pos=domino.Position-Vector3.new(0,2,0)
	TweenService:Create(
		domino,
		TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
		{
			Orientation = Vector3.new(0, -38.083, -58.06),
			Position=pos
		}
	):Play()
end

local function animateGridFrom(folder, startDomino)
	local startRow = startDomino:GetAttribute("Row")
	local startCol = startDomino:GetAttribute("Col")
	if not startRow or not startCol then return end

	for wave = 0, 80 do
		task.delay(wave * 0.1, function()
			if not folder or not folder.Parent then return end

			for _, domino in ipairs(folder:GetChildren()) do
				local row = domino:GetAttribute("Row")
				local col = domino:GetAttribute("Col")

				if row and col then
					local dRow = row - startRow
					local dCol = col - startCol

					if dRow >= 0 and dCol >= 0 and dRow + dCol == wave then
						fallDomino(domino)
					end
				end
			end
		end)
	end
end
function drawLine4(colorArr, customArr)
	local line = workspace:FindFirstChild("DominoLine4")
	if line then
		line:Destroy()
	end

	local cindex = 1
	local offset = 140
	local folder = Instance.new("Folder")
	folder.Name = "DominoLine4"
	folder.Parent = workspace

	local img
	if colorArr and colorArr ~= 0 then
		img = images.getImage(colorArr)
	elseif colorArr == nil then
		img = images.getImage("Amongus")
	end

	for j = 1, 40 do
		for pos = 1, 40 do
			local part = Instance.new("Part")
			part.Name = tostring(j * 40 + pos - 40)
			part.Anchored = true
			part.Shape = "Block"
			part.CastShadow = false
			part.Orientation = Vector3.new(0, -45, 0)
			part.Size = Vector3.new(0.8, 8, 3)
			part.Position = Vector3.new(pos * 3, 7, offset + j * 3)
			game.ServerStorage.ClickSoft:Clone().Parent=part
				
			part:SetAttribute("Row", j)
			part:SetAttribute("Col", pos)
			part:SetAttribute("Fallen", false)

			part.Touched:Connect(function(hit)
				local humanoid = hit.Parent and hit.Parent:FindFirstChild("Humanoid")
				if not humanoid then return end

				if part:GetAttribute("Fallen") then
					return
				end

				animateGridFrom(folder, part)
			end)
			if colorArr == 0 then
				part.BrickColor = BrickColor.new(customArr[j][41 - pos])
			else
				part.BrickColor = BrickColor.new(
					img[j][41 - pos][1],
					img[j][41 - pos][2],
					img[j][41 - pos][3]
				)
			end

			part.Parent = folder
		end
	end

	return folder
end

function createSemiCircle(pos,start,endpos,cindex)
	local center = pos
	local radius = 10

	for i = start, endpos do
		local formula = i * math.pi*2/10
		local position = center+Vector3.new(math.cos(formula) * 5, 3.5, math.sin(formula) * 5)

		local part = Instance.new("Part")
		part.Anchored = true
		part.BrickColor=BrickColor.new(colors[6-cindex+1])
		part.Size = Vector3.new(0.5,8,3)
		part.Position = position
		part.Orientation=Vector3.new(0,360-math.deg(formula)+90,0)
		part.Parent = workspace:WaitForChild("DominoLine3")
		part.CastShadow=false
		game.ServerStorage.Click:Clone().Parent=part
		if cindex==6 then
			cindex=1
		else
			cindex+=1
		end
	end
end

btnStates={false,false,false,false,false}
function spawnDominoLine(id)
	if id==1 then
		cindex=1
		local folder=Instance.new("Folder")
		folder.Name="DominoLine"..tostring(id)
		folder.Parent=workspace
		for pos=1,100 do
			local part = Instance.new("Part")
			part.Name = tostring(pos)
			part.Anchored = true
			part.Shape = "Block"
			part.CastShadow=false
			game.ServerStorage.Click:Clone().Parent=part
			if pos<3 then
				part.Position = Vector3.new(pos*(pos/2)-1,pos+4,1)
			else
				part.Position = Vector3.new(pos*5-11,pos,1)
			end
			part.Size = Vector3.new(0.5,pos*2.5,pos)
			part.BrickColor = BrickColor.new(colors[cindex])

			if cindex==6 then
				cindex=1
			else
				cindex+=1
			end



			local Clonescript=game.ServerStorage:WaitForChild("waitFortouch"):Clone()
			Clonescript.Parent=part

			part.Parent = folder 


		end
	elseif id==2 then
		local folder=Instance.new("Folder")
		folder.Name="DominoLine"..tostring(id)
		folder.Parent=workspace
		cindex=1
		for pos=20,200 do
			local part = Instance.new("Part")
			part.Name = tostring(pos)
			part.Anchored = true
			part.Shape = "Block"
			local x = pos * math.cos(math.rad(pos*9))
			local z = pos * math.sin(math.rad(pos*9))
			part.Position = Vector3.new(x+200,7,z-300)
			part.Size = Vector3.new(0.7,pos/3.5,pos/6)
			part.Rotation =Vector3.new(0,pos*-9.125-10,0)
			part.BrickColor = BrickColor.new(colors[cindex])
			game.ServerStorage.Click:Clone().Parent=part
			part.CastShadow=false
			local Clonescript=game.ServerStorage:WaitForChild("waitFortouch"):Clone()
			Clonescript.Parent=part


			if cindex==6 then
				cindex=1
			else
				cindex+=1
			end
			part.Parent = folder 
		end
	elseif id==3 then


		cindex=1
		local offset=40
		local folder=Instance.new("Folder")
		folder.Name="DominoLine"..tostring(id)
		folder.Parent=workspace
		for j=0,6 do


			for pos=1,20 do
				local part = Instance.new("Part")
				part.Name =  tostring(j*30+pos)
				part.Anchored = true
				part.Shape = "Block"
				part.Position = Vector3.new(pos*3,3.5,offset+j*10)
				part.Size = Vector3.new(0.5,8,3)
				part.BrickColor = BrickColor.new(colors[cindex])
				game.ServerStorage.Click:Clone().Parent=part
				part.CastShadow=false


				local Clonescript=game.ServerStorage:WaitForChild("waitFortouch"):Clone()
				Clonescript.Parent=part


				if cindex==6 then
					cindex=1
				else
					cindex+=1
				end

				part.Parent = folder 
				if pos==20 then
					if j % 2==0 then
						createSemiCircle(Vector3.new(pos*3,3.5,offset+5+j*10),8,12,cindex)

					else


						createSemiCircle(Vector3.new(2,3.5,offset+5+j*10),3,7,cindex)
					end
				end
			end
		end
	elseif id==4 then
		drawLine4()
	elseif id==5 then
		cindex=1
		local folder=Instance.new("Folder")
		folder.Name="DominoLine"..tostring(id)
		folder.Parent=workspace

		for lines=0,3 do
			
	
			for pos=1,36 do
			local part = Instance.new("Part")
			part.Name = tostring(pos)
			part.Anchored = false
			part.Shape = "Block"
			part.CastShadow=false
			game.ServerStorage.Click:Clone().Parent=part
			part.Position = game.Workspace.line5Start.Position+Vector3.new(0,lines*15+3,(pos)*-3+(lines%2==0 and -12 or -11))
			part.Size = Vector3.new(4,8,0.5)


			part.BrickColor = BrickColor.new(colors[cindex])

			if cindex==6 then
				cindex=1
			else
				cindex+=1
			end



			local Clonescript=game.ServerStorage:WaitForChild("waitFortouch"):Clone()
			Clonescript.Parent=part

			part.Parent = folder 


		end
		if  lines~=0 then
			
		
			local pusher=game.ServerStorage.Pusher:Clone()
			pusher.Parent=folder
			local pivotPos= game.Workspace.line5Start.Position
				+Vector3.new(0,lines*15-1,(lines%2==0 and 0 or 40)*-3+(lines%2==0 and -10 or -4))
			pivotPos=CFrame.new(pivotPos)
			pusher:PivotTo(pivotPos)
			end
		end
local ball=game.ServerStorage.Ball:Clone()
		ball.Parent=folder
		ball.Position=workspace.line5End.Position

	
end
end



local function animateGrid(folder)
	for wave = 2, 80 do
		task.delay((wave - 2) * 0.1, function()
			for _, domino in ipairs(folder:GetChildren()) do
				local row = domino:GetAttribute("Row")
				local col = domino:GetAttribute("Col")

				if row and col and row + col == wave then
					fallDomino(domino)
				end
			end
		end)
	end
end

function touchBtn(id,touch)
	
	if not btnStates[id] then

		btnStates[id]=true
		btnFolder:FindFirstChild("button"..tostring(id)).BrickColor = red
		if  id~=4 then
			if touch and touch.Name=="Ball" then
				wait(1.5)
			end
			local line=workspace:FindFirstChild("DominoLine"..tostring(id))
			if line then
				line:Destroy()	
			end
			
			spawnDominoLine(tonumber(id))
		end
		wait(2)
		btnFolder:FindFirstChild("button"..tostring(id)).BrickColor = green
		btnStates[id]=false	
	end	
end
btn1.Touched:Connect(function()
	touchBtn(1)
end)
btn2.Touched:Connect(function()
	touchBtn(2)
end)
btn3.Touched:Connect(function()
	touchBtn(3)	
end)
btn5.Touched:Connect(function(hit)
	touchBtn(5,hit)	
end)
drawEvent=game.ReplicatedStorage:WaitForChild("draw")

btn4.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") then
		if not btnStates[4] then
			drawEvent:FireClient(game.Players:FindFirstChild(hit.Parent.Name))
		end
		touchBtn(4)	
	end
end)

wait(0.5)
for i=1,5 do
	spawnDominoLine(i)
end


local Workspace = game:GetService("Workspace")

drawEvent.OnServerEvent:Connect(function(player,colorArr,customArr)
	drawLine4(colorArr, customArr)
end)


anchorStates={}
playerZone={}

for i=1,4 do
	anchorStates[i]=true
	playerZone[i]=0

end
--unanchor=game.ReplicatedStorage:WaitForChild("unanchor")
--unanchor.OnServerEvent:Connect(function(player, index, state,numofplayers)
--	if numofplayers==0 then
--		anchorStates[index]=true
--	else
--		anchorStates[index]=false

--	end
--end)



local Zone = require(game:GetService("ReplicatedStorage").Zone)
unanchor=game.ReplicatedStorage:WaitForChild("unanchor")
wait(1)

function zones()

	for i=1,4 do

		local zone = Zone.new(workspace.zones:WaitForChild(tostring(i)))
	
		--table.insert(zones,zone)
		zone.playerEntered:Connect(function(player)
			playerZone[i]+=1

		if playerZone[i]==0 then
				anchorStates[i]=true
				
			else
				anchorStates[i]=false
			end

		end)
		zone.playerExited:Connect(function(player)
			playerZone[i]-=1

		
			if playerZone[i]==0 then
				anchorStates[i]=true

			else
				anchorStates[i]=false
			end

		end)


	end


end
zones()
--wait(1)
--animateGrid(game.Workspace["DominoLine4"])


while true do
	wait(0.2)
	for i=1,3 do
		for d,v in pairs(game.Workspace:WaitForChild("DominoLine"..tostring(i)):GetChildren()) do
			v.Anchored=anchorStates[i]
		end 
	end
end



