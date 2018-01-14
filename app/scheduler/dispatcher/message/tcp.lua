-- function reference
local type = type
local next = next
local log = ngx.log
local WARN = ngx.WARN
-- include
local Socket = require("share.libs.net.index")
local servAddrResv = require("scheduler.dispatcher.serverAddressResolve")

return function(serverName, request)
    if type(request) ~= "table" or not next(request) then
        log(WARN, "invalid server request: ", request)
		return nil
    end

	local servAddr = servAddrResv(serverName)
	if not servAddr then
		log(WARN, "invalid server name: ", serverName)
		return nil
	end

	local TcpSocket = Socket("tcpClient")
	local resp, respErr = TcpSocket(servAddr.ip, servAddr.port, request)
	if not resp then
		log(WARN, "dispatch failed: ", respErr)
		return nil
	end

	if respErr then
		log(WARN, respErr)
	end

	return resp
end