local lor = require("lor.index")
local testRouter = lor:Router()
local ping = require("modules.test.ping")
local pong = require("modules.test.pong")

testRouter:get("/ping", ping())
testRouter:get("/pong", pong())

return testRouter
