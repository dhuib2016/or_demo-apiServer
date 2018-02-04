-- function reference
local HTTP_POST = ngx.HTTP_POST
local HTTP_INTERNAL_SERVER_ERROR = ngx.HTTP_INTERNAL_SERVER_ERROR
local HTTP_CREATED = ngx.HTTP_CREATED
-- include
local cstDef = require("define.const")
local schedule = require("scheduler.index")

return function()
    return function(req, res)
        local mode = cstDef.DISPATCH_MODE.MESSAGE.CAPTURE
        local params = req.query
        local contents = {}

        local c1 = {}
        c1[1] = "/createId"
        c1[2] = {
            method = HTTP_POST,
            args = { id = params.id }
        }
        local createIdIndex = 1
        contents[createIdIndex] = c1

        local c2 = {}
        c2[1] = "/createName"
        c2[2]= {
            method = HTTP_POST,
            args = { name = params.name }
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

	    local resp = createIdResp..", "..createNameResp
        res:status(HTTP_CREATED):send(resp)
    end
end