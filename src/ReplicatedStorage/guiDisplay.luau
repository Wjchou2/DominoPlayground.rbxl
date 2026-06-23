local this = {}
local guiFrames= {}

tweenService=game:GetService("TweenService")
hiddenPosition=UDim2.new(0.5, 0,-0.5, 0)
shownPosition=UDim2.new(0.5, 0,0.5, 0)
local debounces={}

animationSpeed=0.2
function this.init(guiFrame:Frame)
	table.insert(guiFrames,guiFrame)
	guiFrame.Visible=false
	guiFrame.Position=hiddenPosition
	debounces[guiFrame]=true

end
function this.initAsSurfaceGui(guiFrame:Frame)
	guiFrame.Visible=false
	guiFrame.Position=hiddenPosition
end
function this.hideAllGui()
	if #guiFrames>1 then
		for i=1,#guiFrames do
			this.hideGuiWithoutAnim(guiFrames[i])
		end
	end
end
local TweenService=game:GetService("TweenService")
local camera = workspace.CurrentCamera

local function tweenCameraFov(fov, time)
	return TweenService:Create(
		camera,
		TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{ FieldOfView = fov }
	)
end
local Lighting=game:GetService("Lighting")
function this.showGui(guiFrame:Frame,position)
	if 	not debounces[guiFrame] then return end
	debounces[guiFrame]=false
	this.hideAllGui()
	Lighting.Blur.Enabled = true
	Lighting.Blur.Size = 0
	tweenCameraFov(45, 0.7):Play()
	TweenService:Create(Lighting.Blur, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Size = 24
	}):Play()

	--TweenService:Create(Lighting, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
	--	Brightness = 1
	--}):Play()

	local show
	if position==nil then
		show=tweenService:Create(guiFrame,TweenInfo.new(animationSpeed,Enum.EasingStyle.Sine),{Position=shownPosition})
	else
		show=tweenService:Create(guiFrame,TweenInfo.new(animationSpeed,Enum.EasingStyle.Sine),{Position=position})
	end
	guiFrame.Visible=true
	show:Play()
	show.Completed:Wait()
	wait(0.1)
	debounces[guiFrame]=true
end
function this.hideGui(guiFrame:Frame)
	if 	not debounces[guiFrame] then return end
	debounces[guiFrame]=false
	local hide=tweenService:Create(guiFrame,TweenInfo.new(animationSpeed,Enum.EasingStyle.Sine),{Position=hiddenPosition})
	hide:Play()
	wait(animationSpeed)
	guiFrame.Visible=false
	tweenCameraFov(70, 0.25):Play()

	--TweenService:Create(Lighting, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
	--	Brightness = 4
	--}):Play()
	local blurTween = TweenService:Create(Lighting.Blur, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Size = 0
	})
	blurTween:Play()

	blurTween.Completed:Wait()
	Lighting.Blur.Enabled = false
	wait(0.1)
	debounces[guiFrame]=true
end

function this.fadeInGui(guiFrame:Frame)
	guiFrame.Visible=true
	local show=tweenService:Create(guiFrame,TweenInfo.new(animationSpeed,Enum.EasingStyle.Sine),{Transparency=0})
	show:Play()
end
function this.fadeOutGui(guiFrame:Frame)
	local hide=tweenService:Create(guiFrame,TweenInfo.new(animationSpeed,Enum.EasingStyle.Sine),{Transparency=1})
	hide:Play()
	wait(animationSpeed)
	guiFrame.Visible=false

end
function this.hideGuiWithoutAnim(guiFrame:Frame)
	if guiFrame.Parent:FindFirstChild("ColorPickerSample") then
		guiFrame.Parent:FindFirstChild("ColorPickerSample"):Destroy()
	end
	guiFrame.Position=hiddenPosition
	guiFrame.Visible=false

end
function this.isVisible(guiFrame:Frame)
	return guiFrame.Visible
end
function this.initButtonTween(guiFrame: Frame)
	guiFrame:SetAttribute("OldSize", guiFrame.Size)

end
function this.click(guiFrame: TextButton)
	local rotation = ((math.random(0, 1) * 2) - 1)*5
	local rotationTween = tweenService:Create(guiFrame, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {Rotation = rotation})
	rotationTween:Play()
	local newSize = UDim2.new(
		guiFrame.Size.X.Scale * 1.2, guiFrame.Size.X.Offset * 1.2,
		guiFrame.Size.Y.Scale * 1.2, guiFrame.Size.Y.Offset * 1.2)
	local sizeTween = tweenService:Create(guiFrame, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {Size = newSize})
	sizeTween:Play()

end

function this.unclicked(guiFrame: TextButton)
	task.wait(0.1) 
	local rotationTween = tweenService:Create(guiFrame, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {Rotation = 0})
	local oldSize = guiFrame:GetAttribute("OldSize")
	if oldSize then
		local sizeTween = tweenService:Create(guiFrame, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {Size = oldSize})
		sizeTween:Play()
		rotationTween:Play()

	end
end


return this
