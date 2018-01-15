-- function reference
local HTTP_INTERNAL_SERVER_ERROR = ngx.HTTP_INTERNAL_SERVER_ERROR
local HTTP_CREATED = ngx.HTTP_CREATED
-- include
local cstDef = require("src.define.const")
local msgDef = require("src.define.message")
local schedule = require("scheduler.index")

return function()
    return function(req, res)
        local mode = cstDef.DISPATCH_MODE.TCP
		local pingReq = {
		    id = msgDef.MESSAGE_PING,
		    body = {
			    seq = req.query.seq
		    }
	    }
		local pingResp = schedule(mode, {"testServer1", pingReq})
		if not pingResp then
			res:status(HTTP_INTERNAL_SERVER_ERROR):send("ping failed!")
			return
		end

	    -- todo:check ngx default status
	    res:status(HTTP_CREATED):send("create succ!")
    end
end