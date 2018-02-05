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
