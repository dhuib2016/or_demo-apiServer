--auth(accName, pwd) return stats
--chgPwd(accName, oldPwd, newPwd) return stats
-- function reference
local log = ngx.log
local WARN = ngx.WARN
-- include
local cstDef = require("define.const")
local msgDef = require("define.message")
local schedule = require("scheduler.index")

local account = {}

function account.auth(accountName, password)
end

return account