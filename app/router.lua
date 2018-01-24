local testRouter = require("routes.test")
local testErrHandler = require("modules.test.errHandler")

return function(app)
    -- special router
	-- simple router ignore next
    app:get("/hi", function(_, res)
        res:send("welcome to OR framework.")
    end)

	-- test
	-- group router mapping a coarse-grained client request
	app:use("/test", testRouter())
	-- a default error handler for a group router
	app:erruse("/test", testErrHandler())
end

