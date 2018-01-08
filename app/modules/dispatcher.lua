-- function reference
local log = ngx.log
local WARN = ngx.WARN
-- include
local Socket = require("share.libs.net.index")
--local cjson = require("cjson.safe")
local servAddrResv = require("modules.utils.serverAddressResolve")

--[[
	request_xxx = {
		id = message_id,
		content = {}
	}

	notify_xxx = {
		id = message_id,
		content = {}
	}

	response_xxx = {
		code = error_code,
		content = {}
	}
	]]

return function(serverName, request)
	local servAddr = servAddrResv(serverName)
	if not servAddr then
		log(WARN, "invalid server name: ", serverName)
		return nil
	end

	--[[local jReq, enErr = cjson.encode(request)
	if not jReq then
		log(ERR, "encode request failed: ", enErr)
		return nil
	end]]

	local TcpSocket = Socket("tcpClient")
	local resp, respErr = TcpSocket(servAddr.ip, servAddr.port, request)
	if not resp then
		log(WARN, "dispatch failed: ", respErr)
		return nil
	end

	if respErr then
		log(WARN, respErr)
	end

	--[[local resp, deErr = cjson.decode(jResp)
	if not resp then
		log(ERR, "decode response failed: ", deErr)
		return nil
	end]]

	return resp
end