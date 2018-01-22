-- function reference
local type = type
local next = next
local log = ngx.log
local WARN = ngx.WARN
local HTTP_OK = ngx.HTTP_OK
local capture = ngx.location.capture

return function(params)
    if not params or not params.uri or not params.request then
        log(WARN, "invalid params")
        return nil
    end

    local request = params.request
    if type(request) ~= "table" or not next(request) then
        log(WARN, "invalid request")
		return nil
    end

	local ret = capture(params.uri, request)
    local status = ret.status
    if status ~= HTTP_OK then
        log(WARN, "capture failed: ", status)
        return nil
    end

    return ret.body
end