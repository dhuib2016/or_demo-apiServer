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
    local requireTable = autoRequire("/app/handlers/test")

    app:get("/test/hello", requireTable.hello())

    app:get("/test/ping", requireTable.ping())
    app:get("/test/httpPing", requireTable.httpPing())
    app:get("/test/httpPingPro", requireTable.httpPingPro())

    app:post("/test/create", requireTable.create())
    app:post("/test/httpCreate", requireTable.httpCreate())
    app:post("/test/httpCreatePro", requireTable.httpCreatePro())

    app:post("/test/createPar", requireTable.createPar())
    app:post("/test/httpCreatePar", requireTable.httpCreatePar())
    app:post("/test/httpCreateParPro", requireTable.httpCreateParPro())

    app:erruse("/test", requireTable.errHandler())
end
