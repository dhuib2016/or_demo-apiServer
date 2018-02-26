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
            return res:json({ code = ec.TEST.INVALID_PARAMS })
        end

        local ret = account.auth(accountName, password)
        if not ret then
            return res:json({ code = ec.INTERNAL_ERROR })
        else
            local resp = ret.body
            if resp.code ~= ec.SUCC then
                -- todo:if need transfer server error code to client error code
                return res:json({ code = resp.code })
            end

            local accInfo = resp.content
            req.session.set("accInfo", {
                id = accInfo.accId,
                type = accInfo.accType
            })

            res:json({ code = ec.SUCC, content = "hi there" })
        end
    end
end

function auth.logout()
    return function()
    end
end

function auth.register()
    return function(req, res)
        local accountName = req.body.accountName
        local password = req.body.password
        local accountType = req.body.accountType

        if not accountName or not password or not accountType
            or accountName == "" or password == "" then
            return res:json({ code = ec.TEST.INVALID_PARAMS })
        end

        local ret = account.register(accountName, password, accountType)
        if not ret then
            return res:json({ code = ec.INTERNAL_ERROR })
        else
            local resp = ret.body
            if resp.code ~= ec.SUCC then
                -- todo:if need transfer server error code to client error code
                return res:json({ code = resp.code })
            end

            local accInfo = resp.content
            req.session.set("accInfo", {
                id = accInfo.accId,
                type = accInfo.accType
            })

            res:json({ code = ec.SUCC, content = "welcome" })
        end
    end
end

function auth.chgPwd()
    return function()
    end
end

return auth