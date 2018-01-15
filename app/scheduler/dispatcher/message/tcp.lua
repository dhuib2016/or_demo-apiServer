-- function reference
local type = type
local next = next
-- include
local socket = require("share.libs.net.index")
local servAddrResv = require("scheduler.dispatcher.serverAddressResolve")

return function(serverName, request)
    if type(request) ~= "table" or not next(request) then
		return nil, "invalid server request"
    end

	local servAddr = servAddrResv(serverName)
	if not servAddr then
		return nil, "invalid server name"
	end

	local tcpDispatcher = socket("tcpClient")
	local resp, respErr = tcpDispatcher(servAddr.ip, servAddr.port, request)
	if not resp then
		return nil, "tcp dispatch failed: "..respErr
	end

    -- maybe there is a warn in tcpDispatcher's return
	return resp, respErr
end