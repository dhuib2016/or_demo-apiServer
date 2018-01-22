-- function reference
local type = type
local next = next
local log = ngx.log
local WARN = ngx.WARN
-- include
local cstDef = require("src.define.const")
local rule = require("scheduler.schedulerRule")
local parallel = require("src.toolkit.flowCtrl.parallel")
local captureMultiDispatcher = require("scheduler.dispatcher.message.captureMultiDispatcher")

local serialHandler = function(size, dispatcher, content)
    local c = content
    if size == 1 then
        c = content[1]
    end

    return dispatcher(c)
end

--[[
    mode see src.define.const.DISPATCH_MODE
    if content is more than one request, it will take parallel mode
    todo:think about return error code
    ]]
return function(mode, content)
    local dispatcher = rule[mode]
    if not dispatcher then
        log(WARN, "invalid mode: ", mode)
		return nil
    end

    if type(content) ~= "table" or not next(content) then
        log(WARN, "invalid content: ", content)
		return nil
    end

    local size = #content
    if size > 1 then
        -- parallel
        if mode == cstDef.DISPATCH_MODE.MESSAGE.CAPTURE then
            -- use capture multi
            return captureMultiDispatcher(content)
        end

        return parallel(dispatcher, content)
    else
        -- serial
        return serialHandler(size, dispatcher, content)
    end
end