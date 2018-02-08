-- function reference
local concat = table.concat
local HTTP_INTERNAL_SERVER_ERROR = ngx.HTTP_INTERNAL_SERVER_ERROR
local HTTP_CREATED = ngx.HTTP_CREATED
--include
local cstDef = require("define.const")
local schedule = require("scheduler.index")
local utils = require("toolkit.utils")

return function()
    return function(req, res)
        local mode = cstDef.DISPATCH_MODE.MESSAGE.HTTP
        local params = req.query
        local content = {}

        content.uri = "http://127.0.0.1:29528/createId"
        content.request = {
            header = {
                contentType = "application/json; charset=utf-8"
            },
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
            header = {
                contentType = "application/json; charset=utf-8"
            },
            method = "POST",
            body = utils.json_encode({ name = params.name })
        }
        local createNameResp = schedule(mode, content)
		if not createNameResp then
			res:status(HTTP_INTERNAL_SERVER_ERROR):send("create name failed!")
			return
		end

        local resp = concat(createIdResp, createNameResp)
        res:status(HTTP_CREATED):send(resp)
    end
end