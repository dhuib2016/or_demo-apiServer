local Socket = require("share.libs.net.index")
local TcpSocket = Socket("tcpClient")
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
		ngx.log(ngx.ERR, "invalid server name: ", serverName)
		return nil
	end

	local jReq, enErr = cjson.encode(request)
	if not jReq then
		ngx.log(ngx.ERR, "encode request failed: ", enErr)
		return nil
	end

	local jResp, respErr = TcpSocket(servAddr.ip, servAddr.port, jReq)
	if not jResp then
		ngx.log(ngx.ERR, "dispatch failed: ", respErr)
		return nil
	end

	local resp, deErr = cjson.decode(jResp)
	if not resp then
		ngx.log(ngx.ERR, "decode response failed: ", deErr)
		return nil
	end

	return resp
end