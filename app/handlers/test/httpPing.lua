-- function reference
local HTTP_INTERNAL_SERVER_ERROR = ngx.HTTP_INTERNAL_SERVER_ERROR
--include
local cstDef = require("define.const")
local schedule = require("scheduler.index")
local utils = require("toolkit.utils")

return function()
    return function(req, res)
        local mode = cstDef.DISPATCH_MODE.MESSAGE.HTTP

        local content = {}
        content.uri = "http://127.0.0.1:29527/ping"
        content.request = utils.json_encode({
            header = {
                contentType = "application/json; charset=utf-8"
            },
            body = req.query
        })
        local pingResp = schedule(mode, content)
        if not pingResp then
            res:status(HTTP_INTERNAL_SERVER_ERROR):send("ping failed!")
            return
        end

	    res:json(pingResp)
    end
end