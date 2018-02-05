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
        local contents = {}
        local params = req.query

        local c1 = {}
        c1.request = {
		    id = msgDef.MESSAGE_CREATE_ID,
		    body = {
			    id = params.id
		    }
	    }
        c1.serverName = "idServer"
        local createIdIndex = 1
        contents[createIdIndex] = c1

        local c2 = {}
        c2.request = {
		    id = msgDef.MESSAGE_CREATE_NAME,
		    body = {
			    name = params.name
		    }
	    }
        c2.serverName = "nameServer"
        local createNameIndex = 2
        contents[createNameIndex] = c2

		local resps = schedule(mode, contents)
		if not resps then
			res:status(HTTP_INTERNAL_SERVER_ERROR):send("create failed!")
			return
		end

        local createIdResp = resps[createIdIndex]
        if not createIdResp then
            res:status(HTTP_INTERNAL_SERVER_ERROR):send("create id failed!")
			return
        end

        local createNameResp = resps[createNameIndex]
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