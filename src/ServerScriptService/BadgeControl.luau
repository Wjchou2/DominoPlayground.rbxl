local this = {}

local BadgeService=game:GetService("BadgeService")
function this.awardBadge(player:Player,id:badges)
	if  BadgeService:UserHasBadgeAsync(player.UserId,id)  then return end
	pcall(function()
		BadgeService:AwardBadge(player.UserId,id)
	end)

end



return this
