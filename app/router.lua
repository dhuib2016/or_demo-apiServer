local testRouter = require("routes.test.index")
local testErrHandler = require("routes.test.errHandler")

return function(app)
    -- special router
	-- simple router ignore next
    app:get("/hi", function(_, res)
        res:send("welcome to OR framework.")
    end)

	-- test
    -- do not use route tree
    testRouter(app)
    app:erruse("/test", testErrHandler())
end

