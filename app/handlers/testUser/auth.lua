-- function reference
-- include
local ec = require("define.errorCode")
local account = require("model.testUser.account")

local auth = {}

function auth.login()
    return function(req, res)
        local accountName = req.body.accountName
        local password = req.body.password

        if not accountName or not password or accountName == "" or password == "" then
            return res:json({
                code = ec.TEST.INVALID_LOGIN_PARAMS
            })
        end

        local accInfo = account:auth(accountName, password)
        if not accInfo then
            return res:json({
                code = ec.TEST.INVALID_ACCNAME_OR_PWD
            })
        else
            req.session.set("accInfo", {
                id = accInfo.id,
                type = accInfo.type
            })
            return res:json({
                code = ec.SUCC
            })
        end
    end
end

function auth.logout()
    return function()
    end
end

function auth.chgPwd()
    return function()
    end
end

return auth