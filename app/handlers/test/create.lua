-- function reference
local HTTP_INTERNAL_SERVER_ERROR = ngx.HTTP_INTERNAL_SERVER_ERROR
local HTTP_CREATED = ngx.HTTP_CREATED
-- include
local cstDef = require("define.const")
local msgDef = require("define.message")
local schedule = require("scheduler.index")

return function()
    return function(req, res)
        local mode = cstDef.DISPATCH_MODE.MESSAGE.TCP
        local content = {}
        content.request = {
		    id = msgDef.MESSAGE_CREATE_ID,
		    body = {
			    id = req.body.id
		    }
	    }
        content.serverName = "idServer"
		local createIdResp = schedule(mode, content)
		if not createIdResp then
			res:status(HTTP_INTERNAL_SERVER_ERROR):send("create id failed!")
			return
		end

        content.request = {
		    id = msgDef.MESSAGE_CREATE_NAME,
		    body = {
			    name = req.body.name
		    }
	    }
        content.serverName = "nameServer"
		local createNameResp = schedule(mode, content)
		if not createNameResp then
			res:status(HTTP_INTERNAL_SERVER_ERROR):send("create name failed!")
			return
		end

        res:status(HTTP_CREATED):json({createIdResp, createNameResp})
    end
end