-- function reference
local log = ngx.log
local WARN = ngx.WARN
local HTTP_OK = ngx.HTTP_OK
local capture_multi = ngx.location.capture_multi

return function(params)
	local rets = capture_multi(params)
    local resps = {}
    for i, ret in ipairs(rets) do
        local status = ret.status
        if status ~= HTTP_OK then
            log(WARN, "capture failed: ", status)
            resps[i] = 0
        else
            resps[i] = ret.body
        end
    end

    return resps
end