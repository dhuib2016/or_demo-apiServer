-- function reference
local log = ngx.log
local WARN = ngx.WARN
local HTTP_INTERNAL_SERVER_ERROR = ngx.HTTP_INTERNAL_SERVER_ERROR
local HTTP_OK = ngx.HTTP_OK
local http = require("resty.http")

return function()
    return function(req, res)
        local httpc = http.new()
        local uri = "http://127.0.0.1:29527/ping"
        local params = { body = "seq = "..req.query.seq }
        local pingResp, pingErr = httpc:request_uri(uri, params)
        if not pingResp then
            log(WARN, "ping failed: ", pingErr)
            res:status(HTTP_INTERNAL_SERVER_ERROR):send("ping failed!")
            return
        end

        local status = pingResp.status
        if status ~= HTTP_OK then
            log(WARN, "ping failed: ", status)
            res:status(HTTP_INTERNAL_SERVER_ERROR):send("ping failed!")
            return
        end

	    res:status(HTTP_OK):send(pingResp.body)
    end
end