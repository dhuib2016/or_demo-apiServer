local lor = require("lor.index")
local testRouter = lor:Router()
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
