local testRouter = require("routes.test.index")
local testErrHandler = require("routes.test.errHandler")

return function(app)
    -- special router
	-- simple router ignore next
    app:get("/hi", function(_, res)
        res:send("welcome to OR framework.")
    end)

    -- todo:auto read files and require them under routes/
	-- test
	-- group router mapping a coarse-grained client request
	app:use("/test", testRouter())
	--a default error handler for a group router
	app:erruse("/test", testErrHandler())

    -- -- do not use route tree
    -- testRouter(app, "/test")
    -- app:erruse("/test", testErrHandler())
end

