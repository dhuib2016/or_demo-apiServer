-- function reference
local HTTP_OK = ngx.HTTP_OK
local HTTP_INTERNAL_SERVER_ERROR = ngx.HTTP_INTERNAL_SERVER_ERROR
local HTTP_CREATED = ngx.HTTP_CREATED
local capture = ngx.location.capture
local HTTP_POST = ngx.HTTP_POST
local log = ngx.log
local WARN = ngx.WARN

return function()
    return function(req, res)
        local createIdParams = {
            method = HTTP_POST,
            args = { id = req.query.id }
        }
        local createIdResp = capture("/createId", createIdParams)
        local createIdStatus = createIdResp.status
        if createIdStatus ~= HTTP_OK then
            log(WARN, "capture create id failed: ", createIdStatus)
            res:status(HTTP_INTERNAL_SERVER_ERROR):send("create id failed!")
            return
        end

        local createNameParams = {
            method = HTTP_POST,
            args = { name = req.query.name }
        }
        local createNameResp = capture("/createName", createNameParams)
        local createNameStatus = createNameResp.status
        if createNameStatus ~= HTTP_OK then
            log(WARN, "capture create name failed: ", createNameStatus)
            res:status(HTTP_INTERNAL_SERVER_ERROR):send("create name failed!")
            return
        end

	    res:status(HTTP_CREATED):send(createIdResp.body..", "..createNameResp.body)
    end
end