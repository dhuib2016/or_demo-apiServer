local lor = require("lor.index")
local testRouter = lor:Router()
local hello = require("modules.test.hello")
local ping = require("modules.test.ping")
local httpPing = require("modules.test.httpPing")
local httpPingPro = require("modules.test.httpPingPro")
local create = require("modules.test.create")
local createPar = require("modules.test.createPar")
local httpCreate = require("modules.test.httpCreate")
local httpCreatePro = require("modules.test.httpCreatePro")
local httpCreatePar = require("modules.test.httpCreatePar")
local httpCreateParPro = require("modules.test.httpCreateParPro")


testRouter:get("/hello", hello())

testRouter:get("/ping", ping())
testRouter:get("/httpPing", httpPing())
testRouter:get("/httpPingPro", httpPingPro())

testRouter:post("/create", create())
testRouter:post("/httpCreate", httpCreate())
testRouter:post("/httpCreatePro", httpCreatePro())

testRouter:post("/createPar", createPar())
testRouter:post("/httpCreatePar", httpCreatePar())
testRouter:post("/httpCreateParPro", httpCreateParPro())

return testRouter
