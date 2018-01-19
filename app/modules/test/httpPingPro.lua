-- function reference
local log = ngx.log
local WARN = ngx.WARN
local HTTP_INTERNAL_SERVER_ERROR = ngx.HTTP_INTERNAL_SERVER_ERROR
local HTTP_OK = ngx.HTTP_OK
local capture = ngx.location.capture

return function()
    return function(req, res)
        local pingResp = capture("/ping", { args = req.query })
        local status = pingResp.status
        if status ~= HTTP_OK then
            log(WARN, "capture ping failed: ", status)
            res:status(HTTP_INTERNAL_SERVER_ERROR):send("ping failed!")
            return
        end

	    res:status(HTTP_OK):send(pingResp.body)
    end
end