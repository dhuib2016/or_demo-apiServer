local testRouter = require("routes.test")
local testHandler = require("modules.test.errHandler")
local userRouter = require("routes.user")
local errHandler = require("modules.user.errHandler")

return function(app)
    -- special router
	-- simple router ignore next
    app:get("/hello", function(req, res)
        res:send(req.path.." : hi! welcome to lor framework.")
    end)

	-- test
	-- group router mapping a coarse-grained client request
	app:get("/test", testRouter())
	-- a default error handler for a group router
	app:erruse("/test", testHandler())

	-- user
    app:use("/user", userRouter())
	app:erruse("/user", errHandler())
end

