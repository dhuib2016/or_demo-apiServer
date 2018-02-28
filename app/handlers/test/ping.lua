-- function reference
local HTTP_INTERNAL_SERVER_ERROR = ngx.HTTP_INTERNAL_SERVER_ERROR
-- include
local cstDef = require("define.const")
local msgDef = require("define.message")
local schedule = require("scheduler.index")

return function()
    return function(_, res)
        local mode = cstDef.DISPATCH_MODE.MSG.TCP
		local content = {}
        content.request = { id = msgDef.MESSAGE_PING }
        content.serverName = "testServer"
		local pingResp = schedule(mode, content)
		if not pingResp then
			res:status(HTTP_INTERNAL_SERVER_ERROR):send("ping failed!")
			return
		end

	    res:json(pingResp)
    end
end