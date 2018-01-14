-- function reference
local type = type
local next = next
local log = ngx.log
local WARN = ngx.WARN
-- include
local rule = require("scheduler.schedulerRule")

--[[
    mode see src.define.const.DISPATCH_MODE
    if content is more than one request, it will take parallel mode
    ]]
return function(mode, content)
    local dispatcher = rule[mode]
    if not dispatcher then
        log(WARN, "invalid mode: ", mode)
		return nil
    end

    if type(content) ~= "table" or not next(content) then
        log(WARN, "invalid content: ", mode)
		return nil
    end

    local size = #content
    if size > 1 then
        -- parallel
        -- make functions
    else
        -- serial
        local serverName, request
        if size == 1 then
            serverName = content[1].serverName
            request = content[1].request
        else
            serverName = content.serverName
            request = content.request
        end

        return dispatcher(serverName, request)
    end
end