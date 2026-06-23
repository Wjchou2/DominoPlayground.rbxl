
local this = {}
function this.playSoundFromPart(sound,part)
	if part:isA("Model") then
		warn("attempt to play sound ",sound,"from model ",part)
	end
	local soundClone = sound:Clone()
	soundClone.Parent = part
	soundClone:Play()
	soundClone.Ended:Connect(function()
		soundClone:Destroy()
	end)
end
function this.playSound(sound,duration)
	sound:Play()
	
	task.spawn(function()
		wait(duration)
		sound:Stop()
	end)
end
function this.fadeOut(sound)
	local sound = Sounds.Mumble1:Clone()
	sound.Parent = npc.Head
	sound:Play()

	sound.Ended:Connect(function()
		sound:Destroy()
	end)
end
return this


