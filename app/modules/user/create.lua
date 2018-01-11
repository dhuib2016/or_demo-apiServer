-- function reference
local HTTP_INTERNAL_SERVER_ERROR = ngx.HTTP_INTERNAL_SERVER_ERROR
local HTTP_CREATED = ngx.HTTP_CREATED
-- include
local msgDef = require("src.define.messageDefine")
local dispatch = require("modules.dispatcher")

return function()
    return function(req, res)
		local creatIdReq = {
		    id = msgDef.MESSAGE_CREATE_ID,
		    content = {
			    id = req.query.id
		    }
	    }
		local serverName = "idServer"
		local creatIdResp = dispatch(serverName, creatIdReq)
		if not creatIdResp then
			res:status(HTTP_INTERNAL_SERVER_ERROR):send("create id failed!")
			return
		end

		local createNameReq = {
		    id = msgDef.MESSAGE_CREATE_NAME,
		    content = {
			    name = req.query.name
		    }
	    }
		serverName = "nameServer"
		local createNameResp = dispatch(serverName, createNameReq)
		if not createNameResp then
			-- todo: think about rollback
			res:status(HTTP_INTERNAL_SERVER_ERROR):send("create name failed!")
			return
		end

	    -- todo:check ngx default status
	    res:status(HTTP_CREATED):send("create succ!")
    end
end