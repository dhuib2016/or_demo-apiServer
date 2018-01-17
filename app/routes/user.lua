local lor = require("lor.index")
local userRouter = lor:Router()
local create = require("modules.user.create")
local createParallel = require("modules.user.createParallel")

userRouter:post("/create", create())
userRouter:post("/createPRL", createParallel())

return userRouter
