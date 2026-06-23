
wait(1)
part=script.Parent
part.Anchored = false
part.CanCollide=true
--part.Transparency=0
goodOrientation=script.Parent.Orientation
for i=1,10 do
	part.AssemblyAngularVelocity = Vector3.zero
	part.AssemblyLinearVelocity = Vector3.zero

	part.Orientation = goodOrientation
	wait(0.1)
end
script:Destroy()


