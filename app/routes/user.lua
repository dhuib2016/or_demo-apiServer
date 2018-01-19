local lor = require("lor.index")
local userRouter = lor:Router()
local create = require("modules.user.create")
local createParallel = require("modules.user.createParallel")
local httpCreate = require("modules.user.httpCreate")

userRouter:post("/create", create())
userRouter:post("/createPar", createParallel())
userRouter:post("/httpCreate", httpCreate())

return userRouter
