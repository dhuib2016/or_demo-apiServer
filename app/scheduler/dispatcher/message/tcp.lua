-- function reference
local type = type
local next = next
local log = ngx.log
local WARN = ngx.WARN
-- include
local socket = require("share.libs.net.index")
local servAddrResv = require("scheduler.dispatcher.serverAddressResolve")

return function(params)
    if not params or not params.serverName or not params.request then
        log(WARN, "invalid params")
        return nil
    end

    local request = params.request
    if type(request) ~= "table" or not next(request) then
        log(WARN, "invalid request")
		return nil
    end

    local serverName = params.serverName
	local servAddr = servAddrResv(serverName)
	if not servAddr then
        log(WARN, "invalid server name")
		return nil
	end

	local tcpDispatcher = socket("tcpClient")
	return tcpDispatcher(servAddr.ip, servAddr.port, request)
end