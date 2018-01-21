-- function reference
local type = type
local next = next
local log = ngx.log
local WARN = ngx.WARN
local HTTP_OK = ngx.HTTP_OK
-- include
local http = require("resty.http")

return function(params)
    if not params or not params.uri or not params.request then
        log(WARN, "invalid params")
        return nil
    end

    local request = params.request
    if type(request) ~= "table" or not next(request) then
        log(WARN, "invalid server request")
		return nil
    end

	local httpClient = http.new()
	local ret, err =  httpClient:request_uri(params.uri, request)
    if not ret then
        log(WARN, "http request failed: ", err)
        return nil
    end

    local status = ret.status
    if status ~= HTTP_OK then
        log(WARN, "bad http request: ", status)
        return nil
    end

    return ret.body
end