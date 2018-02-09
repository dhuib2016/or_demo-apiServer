-- function reference
local HTTP_INTERNAL_SERVER_ERROR = ngx.HTTP_INTERNAL_SERVER_ERROR
local HTTP_CREATED = ngx.HTTP_CREATED
local HTTP_POST = ngx.HTTP_POST
-- include
local cstDef = require("define.const")
local schedule = require("scheduler.index")

return function()
    return function(req, res)
        local mode = cstDef.DISPATCH_MODE.MESSAGE.CAPTURE
        local params = req.body
        local content = {}

        content.uri = "/createId"
        content.request = {
            method = HTTP_POST,
            args = { id = params.id }
        }
        local createIdResp = schedule(mode, content)
		if not createIdResp then
			res:status(HTTP_INTERNAL_SERVER_ERROR):send("create id failed!")
			return
		end

        content.uri = "/createName"
        content.request = {
            method = HTTP_POST,
            args = { name = params.name }
        }
        local createNameResp = schedule(mode, content)
		if not createNameResp then
			res:status(HTTP_INTERNAL_SERVER_ERROR):send("create name failed!")
			return
		end

        local resp = { createIdResp, createNameResp }
        res:status(HTTP_CREATED):json(resp)
    end
end