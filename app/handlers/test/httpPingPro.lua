-- function reference
local HTTP_INTERNAL_SERVER_ERROR = ngx.HTTP_INTERNAL_SERVER_ERROR
local HTTP_GET = ngx.HTTP_GET
-- include
local cstDef = require("define.const")
local schedule = require("scheduler.index")

return function()
    return function(req, res)
        local mode = cstDef.DISPATCH_MODE.MESSAGE.CAPTURE

        local content = {}
        content.uri = "/pingPro"
        content.request = {
            method = HTTP_GET,
            args = {}
        }
        local pingResp = schedule(mode, content)
		if not pingResp then
			res:status(HTTP_INTERNAL_SERVER_ERROR):send("ping failed!")
			return
		end

	    res:json(pingResp.body)
    end
end