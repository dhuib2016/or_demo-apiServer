-- todo:server discovery
local serverMap = {
	testServer = {
		ip = "127.0.0.1",
		port = 19527
	},

	idServer = {
		ip = "127.0.0.1",
		port = 19528
	},

	nameServer = {
		ip = "127.0.0.1",
		port = 19529
	},

    httpTestServer = {
        ip = "127.0.0.1",
        port = 29527
    },

    httpIdServer = {
        ip = "127.0.0.1",
        port = 29528
    },

    httpNameServer = {
        ip = "127.0.0.1",
        port = 29529
    }
}

return function(serverName)
	return serverMap[serverName]
end
