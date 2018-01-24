-- function reference
local HTTP_INTERNAL_SERVER_ERROR = ngx.HTTP_INTERNAL_SERVER_ERROR
local HTTP_OK = ngx.HTTP_OK
local HTTP_POST = ngx.HTTP_POST
-- include
local cstDef = require("define.const")
local schedule = require("scheduler.index")

return function()
    return function(req, res)
        local mode = cstDef.DISPATCH_MODE.MESSAGE.CAPTURE
        
        local content = {}
        content.uri = "/ping"
        content.request = {
            method = HTTP_POST,
            args = req.query
        }
        local pingResp = schedule(mode, content)
		if not pingResp then
			res:status(HTTP_INTERNAL_SERVER_ERROR):send("ping failed!")
			return
		end

	    res:status(HTTP_OK):send(pingResp)
    end
end