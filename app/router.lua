-- function reference
-- include
local testRouter = require("handlers.test.index")
local testUserRouter = require("handlers.testUser.index")

return function(app)
    -- special router
	-- simple router ignore next
    app:get("/hi", function(_, res)
        res:send("welcome to OR framework.")
    end)

	-- test
    -- do not use route tree
    testRouter(app)
    testUserRouter(app)
end

