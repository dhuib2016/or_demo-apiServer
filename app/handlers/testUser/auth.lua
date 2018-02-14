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

        local ret = account.auth(accountName, password)
        if not ret then
            return res:json({ code = ec.INTERNAL_ERROR })
        else
            local resp = ret.body
            local ec = resp.code
            if ec then
                -- todo:if need transfer server error code to client error code
                return res:json({ code = ec })
            end

            local accInfo = resp.body
            req.session.set("accInfo", {
                id = accInfo.accId,
                type = accInfo.accType
            })
            
            res:json({ code = ec.SUCC, content = "welcome~" })
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