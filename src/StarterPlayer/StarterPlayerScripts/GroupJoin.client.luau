local InviteToGroup= game.ReplicatedStorage:WaitForChild("InviteToGroup")
local GroupService = game:GetService("GroupService")

InviteToGroup.OnClientEvent:Connect(function()
	-- Copy this from your Community's web URL, e.g.:
	-- https://www.roblox.com/communities/1200769/Official-Group-of-Roblox
	-- => in this case, the group ID is 1200769
	local GROUP_ID = 34997762

	-- This should be done in a script running on the client
	local success, result = pcall(function()
		return GroupService:PromptJoinAsync(GROUP_ID)
	end)

	if success then
		if result == Enum.GroupMembershipStatus.Joined then
			print("Player joined the group!")
		elseif result == Enum.GroupMembershipStatus.JoinRequestPending then
			print("Join request sent")
		elseif result == Enum.GroupMembershipStatus.AlreadyMember then
			print("Already a member")
		else
			print("Did not join or not eligible")
		end
	else
		warn("Prompt failed: ", result)
	end

end)