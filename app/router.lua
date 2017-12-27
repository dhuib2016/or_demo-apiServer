local testRouter = require("routes.test")
local testErrHandler = require("modules.test.errHandler")
local userRouter = require("routes.user")
local userErrHandler = require("modules.user.errHandler")

return function(app)
    -- special router
	-- simple router ignore next
    app:get("/hello", function(req, res)
        res:send(req.path.." : hi! welcome to lor framework.")
    end)

	-- test
	-- group router mapping a coarse-grained client request
	app:use("/test", testRouter())
	-- a default error handler for a group router
	app:erruse("/test", testErrHandler())

	-- user
    app:use("/user", userRouter())
	app:erruse("/user", userErrHandler())
end

