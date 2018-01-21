-- function reference
local HTTP_OK = ngx.HTTP_OK
local HTTP_INTERNAL_SERVER_ERROR = ngx.HTTP_INTERNAL_SERVER_ERROR
local HTTP_CREATED = ngx.HTTP_CREATED
local log = ngx.log
local WARN = ngx.WARN
--include
local http = require("resty.http")

return function()
    return function(req, res)
        local httpc = http.new()
        local params = req.query

        local createIdUri = "http://127.0.0.1:29528/createId"
        local createIdParams = {
            method = "POST",
            body = "id = "..params.id
        }
        local createIdResp, createIdErr =
            httpc:request_uri(createIdUri, createIdParams)
        if not createIdResp then
            log(WARN, "create id failed: ", createIdErr)
            res:status(HTTP_INTERNAL_SERVER_ERROR):send("create id failed!")
            return
        end

        local createIdStatus = createIdResp.status
        if createIdStatus ~= HTTP_OK then
            log(WARN, "create id failed: ", createIdStatus)
            res:status(HTTP_INTERNAL_SERVER_ERROR):send("create id failed!")
            return
        end

        local createNameUri = "http://127.0.0.1:29529/createName"
        local createNameParams = {
            method = "POST",
            args = "name = "..params.name
        }
        local createNameResp, createNameErr =
            httpc:request_uri(createNameUri, createNameParams)
        if not createNameResp then
            log(WARN, "create name failed: ", createNameErr)
            res:status(HTTP_INTERNAL_SERVER_ERROR):send("create name failed!")
            return
        end

        local createNameStatus = createNameResp.status
        if createNameStatus ~= HTTP_OK then
            log(WARN, "create id failed: ", createNameStatus)
            res:status(HTTP_INTERNAL_SERVER_ERROR):send("create name failed!")
            return
        end

        local resp = createIdResp.body..", "..createNameResp.body
        res:status(HTTP_CREATED):send(resp)
    end
end