-- function reference
local type = type
local log = ngx.log
local WARN = ngx.WARN
local HTTP_OK = ngx.HTTP_OK
local capture_multi = ngx.location.capture_multi

return function(params)
    if type(params) ~= "table" or #params < 2 then
        log(WARN, "invalid params(params must be an array-table and length >= 2)")
        return nil
    end

	local rets = capture_multi(params)
    local resps = {}
    for i, ret in ipairs(rets) do
        local status = ret.status
        if status ~= HTTP_OK then
            log(WARN, "capture multi failed: ", status)
            resps[i] = 0
        else
            resps[i] = ret.body
        end
    end

    return resps
end