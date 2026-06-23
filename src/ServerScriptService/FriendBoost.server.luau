--local Players = game:GetService("Players")
--local ReplicatedStorage = game:GetService("ReplicatedStorage")

--local FriendBoostUpdated = ReplicatedStorage:WaitForChild("FriendBoostUpdated")

--local MAX_BOOST = 2
--local BOOST_PER_FRIEND = 0.25

--local friendBoosts = {}

--local function calculateFriendBoost(player)
--	local friends = 0

--	for _, otherPlayer in ipairs(Players:GetPlayers()) do
--		if otherPlayer ~= player then
--			local success, isFriend = pcall(function()
--				return player:IsFriendsWith(otherPlayer.UserId)
--			end)

--			if success and isFriend then
--				friends += 1
--			end
--		end
--	end

--	local multiplier = math.min(1 + friends * BOOST_PER_FRIEND, MAX_BOOST)

--	friendBoosts[player.UserId] = multiplier
--	FriendBoostUpdated:FireClient(player, multiplier, friends)
--end

--local function updateAllFriendBoosts()
--	for _, player in ipairs(Players:GetPlayers()) do
--		calculateFriendBoost(player)
--	end
--end

--Players.PlayerAdded:Connect(function()
--	task.wait(2)
--	updateAllFriendBoosts()
--end)

--Players.PlayerRemoving:Connect(function()
--	task.wait(1)
--	updateAllFriendBoosts()
--end)

--_G.GetFriendBoost = function(player)
--	return friendBoosts[player.UserId] or 0
--end