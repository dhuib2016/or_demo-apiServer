-- todo:server discovery
local serverMap = {
	testServer1 = {
		ip = "127.0.0.1",
		port = 19525
	},

	testServer2 = {
		ip = "127.0.0.1",
		port = 19526
	},

	idServer = {
		ip = "127.0.0.1",
		port = 19527
	},

	nameServer = {
		ip = "127.0.0.1",
		port = 19528
	}
}

return function(serverName)
	return serverMap[serverName]
end
