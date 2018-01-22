-- function reference
local log = ngx.log
local WARN = ngx.WARN
local HTTP_OK = ngx.HTTP_OK
local capture_multi = ngx.location.capture_multi

return function(params)
	local rets = capture_multi(params)
    local status = rets.status
    if status ~= HTTP_OK then
        log(WARN, "capture failed: ", status)
        return nil
    end

    return rets.body
end