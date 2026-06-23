local sounds = require(game.ReplicatedStorage.Sounds)
local played=false
while wait(0.1) do
	if (script.Parent.CFrame.UpVector.Y < math.cos(math.rad(20)) and not played) then
		played=true
		sounds.playSoundFromPart(game.SoundService.Domino:GetChildren()[math.random(1,#game.SoundService.Domino:GetChildren())],script.Parent)
		wait(1)
		break
		
	end 
end
script:Destroy()