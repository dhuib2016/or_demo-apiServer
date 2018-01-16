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

return function()
    return function(_, res)
        local mode = cstDef.DISPATCH_MODE.MESSAGE.TCP
        local contents = {}
        local content1 = {}
        content1.request = {
		    id = msgDef.MESSAGE_QUERY_ID,
		    body = {}
	    }
        content1.address = "idServer"
        local idQueryIndex = 1
        contents[idQueryIndex] = content1
        local content2 = {}
        content2.request = {
		    id = msgDef.MESSAGE_QUERY_NAME,
		    body = {}
	    }
        content2.address = "nameServer"
        local nameQueryIndex = 2
        contents[nameQueryIndex] = content2

		local resps = schedule(mode, contents)
        local idQueryResp = resps[idQueryIndex]
        local idQueryRespContent = idQueryResp[1]
        local idQueryRespErr = idQueryResp[2]
        local nameQueryResp = resps[nameQueryIndex]
        local nameQueryRespContent = nameQueryResp[1]
        local nameQueryRespErr = nameQueryResp[2]
        if idQueryRespContent and idQueryRespContent.code == ec.SUCC
            and nameQueryRespContent and nameQueryResp.code == ec.SUCC then
            local resContent = "id:"..idQueryRespContent.body.id
            resContent = resContent..", name:"..nameQueryRespContent.body.name
            res:status(HTTP_OK):send(resContent)
        else
			res:status(HTTP_INTERNAL_SERVER_ERROR):send("query failed!")
		end

        if idQueryRespErr then
            log(WARN, "id query err: ", idQueryRespErr)
        end

        if nameQueryRespErr then
            log(WARN, "name query err: ", nameQueryRespErr)
        end
    end
end