-- function reference
local HTTP_INTERNAL_SERVER_ERROR = ngx.HTTP_INTERNAL_SERVER_ERROR
local HTTP_CREATED = ngx.HTTP_CREATED
--include
local cstDef = require("define.const")
local schedule = require("scheduler.index")
local utils = require("toolkit.utils")

return function()
    return function(req, res)
        local mode = cstDef.DISPATCH_MODE.MESSAGE.HTTP
        local params = req.body
        local content = {}

        content.uri = "http://127.0.0.1:29528/createId"
        content.request = {
            method = "POST",
            body = utils.json_encode({ id = params.id })
        }
        local createIdResp = schedule(mode, content)
		if not createIdResp then
			res:status(HTTP_INTERNAL_SERVER_ERROR):send("create id failed!")
			return
		end

        content.uri = "http://127.0.0.1:29529/createName"
        content.request = {
            method = "POST",
            body = utils.json_encode({ name = params.name })
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