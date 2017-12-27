-- todo:server discovery
local serverMap = {
	testServer1 = {
		ip = "127.0.0.1",
		port = 9525
	},
	
	testServer2 = {
		ip = "127.0.0.1",
		port = 9526
	},
	
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
