-- function reference
local HTTP_INTERNAL_SERVER_ERROR = ngx.HTTP_INTERNAL_SERVER_ERROR
local HTTP_CREATED = ngx.HTTP_CREATED
--include
local cstDef = require("src.define.const")
local schedule = require("scheduler.index")

return function()
    return function(req, res)
        local mode = cstDef.DISPATCH_MODE.MESSAGE.HTTP
        local params = req.query
        local content = {}

        content.uri = "http://127.0.0.1:29528/createId"
        content.request = {
            method = "POST",
            body = "id = "..params.id
        }
        local createIdResp = schedule(mode, content)
		if not createIdResp then
			res:status(HTTP_INTERNAL_SERVER_ERROR):send("create id failed!")
			return
		end

        content.uri = "http://127.0.0.1:29529/createName"
        content.request = {
            method = "POST",
            args = "name = "..params.name
        }
        local createNameResp = schedule(mode, content)
		if not createNameResp then
			res:status(HTTP_INTERNAL_SERVER_ERROR):send("create name failed!")
			return
		end

        local createIdCode = createIdResp.code
        local createNameCode = createNameResp.code
	    local resp = "createId Code:"..createIdCode
        resp = resp.." createName Code:"..createNameCode
	    res:status(HTTP_CREATED):send(resp)
    end
end