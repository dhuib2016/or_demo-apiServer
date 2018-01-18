-- function reference
local HTTP_INTERNAL_SERVER_ERROR = ngx.HTTP_INTERNAL_SERVER_ERROR
local HTTP_OK = ngx.HTTP_OK
-- include
local cstDef = require("src.define.const")
local msgDef = require("src.define.message")
local schedule = require("scheduler.index")

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
        content.serverName = "httpTestServer"
		local pingResp = schedule(mode, content)
		if not pingResp then
			res:status(HTTP_INTERNAL_SERVER_ERROR):send("ping failed!")
			return
		end

	    -- todo:check ngx default status
	    res:status(HTTP_OK):send("create succ!")
    end
end