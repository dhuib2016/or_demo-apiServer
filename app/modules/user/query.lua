-- function reference
local HTTP_INTERNAL_SERVER_ERROR = ngx.HTTP_INTERNAL_SERVER_ERROR
local HTTP_OK = ngx.HTTP_OK
local log = ngx.log
local WARN = ngx.WARN
-- include
local cstDef = require("src.define.const")
local msgDef = require("src.define.message")
local schedule = require("scheduler.index")
local ec = require("src.define.errorCode")

local idQueryHandler = function(ret)
    local idQueryRespErr = ret.err
    if idQueryRespErr then
        log(WARN, "process query id failed: ", idQueryRespErr)
        return nil
    end
    -- sample process
    local idQueryResp = ret.resp
    if idQueryResp and idQueryResp.code == ec.SUCC then
        return idQueryResp.body.id
    end

    return false
end

local nameQueryHandler = function(ret)
    local nameQueryRespErr = ret.err
    if nameQueryRespErr then
        log(WARN, "process query name failed: ", nameQueryRespErr)
        return nil
    end
    -- sample process
    local nameQueryResp = ret.resp
    if nameQueryResp and nameQueryResp.code == ec.SUCC then
        return nameQueryResp.body.name
    end

    return nil
end

return function()
    return function(_, res)
        local mode = cstDef.DISPATCH_MODE.MESSAGE.TCP
        local contents = {}
        local c1 = {}
        c1.request = {
		    id = msgDef.MESSAGE_QUERY_ID,
		    body = {}
	    }
        c1.address = "idServer"
        local idQueryIndex = 1
        contents[idQueryIndex] = c1
        local c2 = {}
        c2.request = {
		    id = msgDef.MESSAGE_QUERY_NAME,
		    body = {}
	    }
        c2.address = "nameServer"
        local nameQueryIndex = 2
        contents[nameQueryIndex] = c2

		local rets, err = schedule(mode, contents)
        if not rets then
            log(WARN, "process query failed: ", err)
            return res:status(HTTP_INTERNAL_SERVER_ERROR):send("query failed!")
        end

        local r1 = idQueryHandler(rets[idQueryIndex])
        local r2 = nameQueryHandler(rets[nameQueryIndex])
        if r1 and r2 then
            local resContent = "id:"..r1..", name:"..r2
            res:status(HTTP_OK):send(resContent)
        else
            res:status(HTTP_INTERNAL_SERVER_ERROR):send("query failed!")
        end
    end
end