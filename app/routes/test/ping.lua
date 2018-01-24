-- function reference
local HTTP_INTERNAL_SERVER_ERROR = ngx.HTTP_INTERNAL_SERVER_ERROR
local HTTP_OK = ngx.HTTP_OK
-- include
local cstDef = require("define.const")
local msgDef = require("define.message")
local schedule = require("scheduler.index")
local ec = require("define.errorCode")

return function()
    return function(req, res)
        local mode = cstDef.DISPATCH_MODE.MESSAGE.TCP
		local content = {}
        content.request = {
		    id = msgDef.MESSAGE_PING,
		    body = {
			    seq = req.query.seq
		    }
	    }
        content.serverName = "testServer"
		local pingResp = schedule(mode, content)
		if not pingResp then
			res:status(HTTP_INTERNAL_SERVER_ERROR):send("ping failed!")
			return
		end

	    -- todo:check ngx default status
        local code = pingResp.code
	    local resp = "code:"..code
        if code == ec.SUCC then
            resp = resp.." response:"..pingResp.body.ack
        end
	    res:status(HTTP_OK):send(resp)
    end
end