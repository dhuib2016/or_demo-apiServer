-- local hello = require("handlers.test.hello")
-- local ping = require("handlers.test.ping")
-- local httpPing = require("handlers.test.httpPing")
-- local httpPingPro = require("handlers.test.httpPingPro")
-- local create = require("handlers.test.create")
-- local createPar = require("handlers.test.createPar")
-- local httpCreate = require("handlers.test.httpCreate")
-- local httpCreatePro = require("handlers.test.httpCreatePro")
-- local httpCreatePar = require("handlers.test.httpCreatePar")
-- local httpCreateParPro = require("handlers.test.httpCreateParPro")
-- local testErrHandler = require("handlers.test.errHandler")
local autoRequire = require("handlers.autoRequire")

return function(app)
    local requireTable = autoRequire()

    app:post("/user/login", requireTable.auth.login())
    app:post("/user/chgPwd", requireTable.auth.chgPwd())
    app:get("/user/logout", requireTable.auth.logout())

    app:erruse("/user", requireTable.errHandler())
end
