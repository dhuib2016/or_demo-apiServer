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

	    local createIdIdCode = createIdResp.code
        local createNameCode = createNameResp.code
	    local resp = "createId Code:"..createIdIdCode
        resp = resp.." createName Code:"..createNameCode
	    res:status(HTTP_CREATED):send(resp)
    end
end