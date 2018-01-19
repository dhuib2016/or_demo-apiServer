-- function reference
local HTTP_INTERNAL_SERVER_ERROR = ngx.HTTP_INTERNAL_SERVER_ERROR
local HTTP_CREATED = ngx.HTTP_CREATED
local get_uri_args = ngx.req.get_uri_args
local capture = ngx.location.capture

return function()
    return function(req, res)
        local createIdResp = capture("/createId", { args = { id = req.query.id } })
        local createIdStatus = createIdResp.status
        if createIdStatus ~= HTTP_OK then
            log(WARN, "capture create id failed: ", createIdStatus)
            res:status(HTTP_INTERNAL_SERVER_ERROR):send("create id failed!")
            return
        end
        
        local createNameResp = capture("/createName", { args = { id = req.query.name } })
        local createNameStatus = createNameResp.status
        if createNameStatus ~= HTTP_OK then
            log(WARN, "capture create name failed: ", createNameStatus)
            res:status(HTTP_INTERNAL_SERVER_ERROR):send("create name failed!")
            return
        end

	    res:status(HTTP_CREATED):send(createIdResp.body..", "..createNameResp.body)
    end
end