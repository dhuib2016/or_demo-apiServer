local userRouter = require("routes.user")
local errHandler = require("modules.user.errHandler")

return function(app)
    -- special router
	-- simple router ignore next
    app:get("/hello", function(req, res)
        res:send(req.path.." : hi! welcome to lor framework.")
    end)

    -- group router mapping a coarse-grained client request
    app:use("/user", userRouter())
	-- a default error handler for a group router
	app:erruse("/user", errHandler())
end

