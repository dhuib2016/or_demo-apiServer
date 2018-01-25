-- function reference
local HTTP_INTERNAL_SERVER_ERROR = ngx.HTTP_INTERNAL_SERVER_ERROR
local HTTP_OK = ngx.HTTP_OK
--include
local cstDef = require("define.const")
local schedule = require("scheduler.index")

return function()
    return function(_, res)
        local mode = cstDef.DISPATCH_MODE.MESSAGE.HTTP

        local content = {}
        content.uri = "http://127.0.0.1:29527/ping"
        content.forward = true
        local pingResp = schedule(mode, content)
        if not pingResp then
            res:status(HTTP_INTERNAL_SERVER_ERROR):send("ping failed!")
            return
        end

	    res:status(HTTP_OK):send(pingResp)
    end
end