local lor = require("lor.index")
local testRouter = lor:Router()
local ping = require("modules.test.ping")

testRouter:get("/ping", ping())

return testRouter
