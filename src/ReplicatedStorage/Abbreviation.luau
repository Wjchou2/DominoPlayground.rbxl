
local this = {}
local suffixes = {"", "K", "M", "B", "T", "QA", "QI", "SX", "SP", "OC", "NO", "DC", "UD", "DD", "TD", "QAD", "QID", "SXD", "SPD", "OCD", "NOD", "VG", "UVG"}
function this.abbreviate(n:number)
	-- Abhi's Number Abbreviation System V 2.4
	local s = tostring(math.floor(n))
	return string.sub(s, 1, ((#s - 1) % 3) + 1) .. (suffixes)[math.floor((#s - 1) / 3) + 1]
end
function this.abbreviateTime(totalSeconds:number,withSec:number)
	local weeks = math.floor(totalSeconds / 604800) -- 604800 seconds in a week
	local days = math.floor((totalSeconds % 604800) / 86400)
	local hours = math.floor((totalSeconds % 86400) / 3600)
	local minutes = math.floor((totalSeconds % 3600) / 60)
	local seconds=0

	

	local result = ""
	if weeks > 0 then
		result = result .. weeks .. "weeks"
	end
	if days > 0 then
		if #result > 0 then result = result .. " " end
		result = result .. days .. "days"
	end
	if hours > 0 then
		if #result > 0 then result = result .. " " end
		result = result .. hours .. "hours"
	end
	if minutes > 0 then
		if #result > 0 then result = result .. " " end
		result = result .. minutes .. "min"
	end
	if withSec==nil or withSec==true then
		seconds = totalSeconds % 60
		if seconds > 0 or #result == 0 then
			if #result > 0 then result = result .. " " end
			result = result .. seconds .. "sec"
		end
	end

	return result
end

return this
