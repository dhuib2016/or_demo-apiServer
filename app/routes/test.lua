local lor = require("lor.index")
local testRouter = lor:Router()
local ping = require("modules.test.ping")
local pong = require("modules.test.pong")

testRouter:get("/ping", ping())
testRouter:get("/pong", pong())

return testRouter

--[[ pong.lua
local HTTP_OK = ngx.HTTP_OK

return function()
    return function(req, res)
	    res:status(HTTP_OK):send("pong succ!")
    end
end
]]
