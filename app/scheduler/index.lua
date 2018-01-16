-- function reference
local type = type
local next = next
local log = ngx.log
local WARN = ngx.WARN
local spawn = ngx.thread.spawn
local wait = ngx.thread.wait
-- include
local cstDef = require("src.define.const")
local rule = require("scheduler.schedulerRule")

local parallelHandler = function(dispatcher, content)
    local threads = {}
    local i = 1
    for _, v in ipairs(content) do
        threads[i] = spawn(dispatcher, v.address, v.request)
        i = i + 1
    end

    local results = {}
    local j = 1
    for _, t in ipairs(threads) do
        local ok, res = wait(t)
        if not ok then
            log(WARN, "parallel dispatche failed: ", res)
            results[j] = {}
        else
            results[j] = res
        end
        j = j + 1
    end

    return results
end

local parallelHTTPHandler = function(content)
    return nil
end

local serialHandler = function(size, dispatcher, content)
    local address, request
    if size == 1 then
        address = content[1].address
        request = content[1].request
    else
        address = content.address
        request = content.request
    end

    local resp, err = dispatcher(address, request)
    if err then
        log(WARN, "dispatch failed: ", err)
    end

    return resp
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
        if mode == cstDef.DISPATCH_MODE.MESSAGE.HTTP then
            -- http use capture_multi
            return parallelHTTPHandler(content)
        end
        return parallelHandler(dispatcher, content)
    else
        -- serial
        return  serialHandler(size, dispatcher, content)
    end
end