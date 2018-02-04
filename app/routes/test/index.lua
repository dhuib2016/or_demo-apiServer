local hello = require("routes.test.hello")
local ping = require("routes.test.ping")
local httpPing = require("routes.test.httpPing")
local httpPingPro = require("routes.test.httpPingPro")
local create = require("routes.test.create")
local createPar = require("routes.test.createPar")
local httpCreate = require("routes.test.httpCreate")
local httpCreatePro = require("routes.test.httpCreatePro")
local httpCreatePar = require("routes.test.httpCreatePar")
local httpCreateParPro = require("routes.test.httpCreateParPro")

return function(app)
    app:get("/test/hello", hello())

    app:get("/test/ping", ping())
    app:get("/test/httpPing", httpPing())
    app:get("/test/httpPingPro", httpPingPro())

    app:post("/test/create", create())
    app:post("/test/httpCreate", httpCreate())
    app:post("/test/httpCreatePro", httpCreatePro())

    app:post("/test/createPar", createPar())
    app:post("/test/httpCreatePar", httpCreatePar())
    app:post("/test/httpCreateParPro", httpCreateParPro())
end
