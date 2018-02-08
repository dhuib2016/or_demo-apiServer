-- function reference
local HTTP_INTERNAL_SERVER_ERROR = ngx.HTTP_INTERNAL_SERVER_ERROR
local HTTP_CREATED = ngx.HTTP_CREATED
-- include
local cstDef = require("define.const")
local msgDef = require("define.message")
local schedule = require("scheduler.index")
local utils = require("toolkit.utils")

return function()
    return function(req, res)
        utils.print_table(req.query)
        local mode = cstDef.DISPATCH_MODE.MESSAGE.TCP
        local content = {}
        content.request = {
		    id = msgDef.MESSAGE_CREATE_ID,
		    body = {
			    id = req.query.id
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
			    name = req.query.name
		    }
	    }
        content.serverName = "nameServer"
		local createNameResp = schedule(mode, content)
		if not createNameResp then
			res:status(HTTP_INTERNAL_SERVER_ERROR):send("create name failed!")
			return
		end

        local resp = {
            ["createId Code"] = createIdResp.code,
            id = createIdResp.body and createIdResp.body.id,
            ["createName Code"] = createNameResp.code,
            name = createNameResp.body and createNameResp.body.name
        }
        res:status(HTTP_CREATED):json(resp)
    end
end