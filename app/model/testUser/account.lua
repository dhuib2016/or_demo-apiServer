-- function reference
local HTTP_POST = ngx.HTTP_POST
-- include
local cstDef = require("define.const")
local schedule = require("scheduler.index")

local account = {}

function account.auth(accountName, password)
    -- todo:use LRU + SHAREDDIC + RPC cache
    local mode = cstDef.DISPATCH_MODE.MESSAGE.CAPTURE
    local content = {}
    content.uri = "/auth"
    content.request = {
        method = HTTP_POST,
        args = { accountName = accountName, password = password }
    }
    return schedule(mode, content)
end

return account