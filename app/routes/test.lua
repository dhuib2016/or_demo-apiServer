local lor = require("lor.index")
local testRouter = lor:Router()
local hello = require("modules.test.hello")
local ping = require("modules.test.ping")
local httpPing = require("modules.test.httpPing")


testRouter:get("/hello", hello())

testRouter:get("/ping", ping())
testRouter:get("/httpPing", httpPing())


return testRouter
