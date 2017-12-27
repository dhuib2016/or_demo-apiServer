-- todo:server discovery
local serverMap = {
	idServer = {
		ip = "127.0.0.1",
		port = 9527
	},

	nameServer = {
		ip = "127.0.0.1",
		port = 9528
	}
}

return function(serverName)
	return serverMap[serverName]
end
