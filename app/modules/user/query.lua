-- function reference
local HTTP_INTERNAL_SERVER_ERROR = ngx.HTTP_INTERNAL_SERVER_ERROR
local HTTP_OK = ngx.HTTP_OK
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
        local nameQueryResp = resps[nameQueryIndex]
        if idQueryResp.code == ec.SUCC and nameQueryResp.code == ec.SUCC then
            local resContent = "id:"..idQueryResp.body.id
            resContent = resContent..", name:"..nameQueryResp.body.name
            return res:status(HTTP_OK):send(resContent)
        else
			return res:status(HTTP_INTERNAL_SERVER_ERROR):send("query failed!")
		end
    end
end