-- function reference
local HTTP_INTERNAL_SERVER_ERROR = ngx.HTTP_INTERNAL_SERVER_ERROR
local HTTP_CREATED = ngx.HTTP_CREATED
-- include
local cstDef = require("src.define.const")
local msgDef = require("src.define.message")
local schedule = require("scheduler.index")

return function()
    return function(req, res)
        local mode = cstDef.DISPATCH_MODE.MESSAGE.TCP
        local content = {}
        content.request = {
		    id = msgDef.MESSAGE_CREATE_ID,
		    body = {
			    id = req.query.id
		    }
	    }
        content.address = "idServer"
		local creatIdResp = schedule(mode, content)
		if not creatIdResp then
			res:status(HTTP_INTERNAL_SERVER_ERROR):send("create id failed!")
			return
		end

        content.request = {
		    id = msgDef.MESSAGE_CREATE_NAME,
		    body = {
			    name = req.query.name
		    }
	    }
        content.address = "nameServer"
		local createNameResp = schedule(mode, content)
		if not createNameResp then
			-- todo: think about rollback
			res:status(HTTP_INTERNAL_SERVER_ERROR):send("create name failed!")
			return
		end

	    -- todo:check ngx default status
	    res:status(HTTP_CREATED):send("create succ!")
    end
end