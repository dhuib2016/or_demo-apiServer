-- function reference
local log = ngx.log
local ERR = ngx.ERR
-- include
local Socket = require("share.libs.net.index")
local cjson = require("cjson.safe")
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
		log(ERR, "invalid server name: ", serverName)
		return nil
	end

	local jReq, enErr = cjson.encode(request)
	if not jReq then
		log(ERR, "encode request failed: ", enErr)
		return nil
	end

	local TcpSocket = Socket("tcpClient")
	local jResp, respErr = TcpSocket(servAddr.ip, servAddr.port, jReq)
	if not jResp then
		log(ERR, "dispatch failed: ", respErr)
		return nil
	end

	local resp, deErr = cjson.decode(jResp)
	if not resp then
		log(ERR, "decode response failed: ", deErr)
		return nil
	end

	return resp
end