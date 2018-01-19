-- function reference
local log = ngx.log
local WARN = ngx.WARN
local HTTP_INTERNAL_SERVER_ERROR = ngx.HTTP_INTERNAL_SERVER_ERROR
local HTTP_OK = ngx.HTTP_OK
local capture = ngx.location.capture
-- include
--local cstDef = require("src.define.const")
--local msgDef = require("src.define.message")
--local schedule = require("scheduler.index")
--local ec = require("src.define.errorCode")

return function()
    return function(_, res)
        -- local mode = cstDef.DISPATCH_MODE.MESSAGE.TCP
		-- local content = {}
        -- content.request = {
		    -- id = msgDef.MESSAGE_PING,
		    -- body = {
			    -- seq = req.query.seq
		    -- }
	    -- }
        -- content.serverName = "httpTestServer"
		-- local pingResp = schedule(mode, content)
		-- if not pingResp then
			-- res:status(HTTP_INTERNAL_SERVER_ERROR):send("ping failed!")
			-- return
		-- end

        ngx.req.read_body()
        local args, err = ngx.req.get_uri_args()
        if not args then
            log(WARN, "get uri args failed: ", err)
            res:status(HTTP_INTERNAL_SERVER_ERROR):send("ping failed!")
            return
        end

        local pingResp = capture("/ping", { vars = { seq = args.seq } })
        local status = pingResp.status
        if status ~= HTTP_OK then
            log(WARN, "capture failed: ", status)
            res:status(HTTP_INTERNAL_SERVER_ERROR):send("ping failed!")
            return
        end

	    res:status(HTTP_OK):send(pingResp.body)
    end
end