-- function reference
local HTTP_INTERNAL_SERVER_ERROR = ngx.HTTP_INTERNAL_SERVER_ERROR
local HTTP_CREATED = ngx.HTTP_CREATED
-- include
local cstDef = require("define.const")
local schedule = require("scheduler.index")
local utils = require("toolkit.utils")

return function()
    return function(req, res)
        local mode = cstDef.DISPATCH_MODE.MSG.HTTP
        local params = req.body
        local contents = {}

        local c1 = {}
        c1.uri = "http://127.0.0.1:29528/createId"
        c1.request = {
            method = "POST",
            body = utils.json_encode({ id = params.id })
        }
        local createIdIndex = 1
        contents[createIdIndex] = c1

        local c2 = {}
        c2.uri = "http://127.0.0.1:29529/createName"
        c2.request= {
            method = "POST",
            body = utils.json_encode({ name = params.name })
        }
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

	    local resp = { createIdResp.body, createNameResp.body }
        res:status(HTTP_CREATED):json(resp)
    end
end