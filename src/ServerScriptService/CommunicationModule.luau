
local module = {}

module.dataToTransfer = nil

function module.sendData(data)
	module.dataToTransfer = data
end

return module