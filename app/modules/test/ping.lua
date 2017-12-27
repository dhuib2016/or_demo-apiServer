local msgDef = require("share.src.messageDefine")
local dispatch = require("modules.dispatcher")

return function()
    return function(req, res)
		local pingReq = {
		    id = msgDef.MESSAGE_PING,
		    content = {
			    seq = req.query.seq
		    }
	    }
		local serverName = "testServer1"
		local pingResp = dispatch(serverName, pingReq)
		if not pingResp then
			res:status(ngx.HTTP_INTERNAL_SERVER_ERROR):send("ping failed!")
			return
		end

	    -- todo:check ngx default status
	    res:status(ngx.HTTP_CREATED):send("create succ!")
    end
end