local lor = require("lor.index")
local userRouter = lor:Router()
local create = require("modules.user.create")
local createPar = require("modules.user.createPar")
local httpCreate = require("modules.user.httpCreate")
local httpCreatePro = require("modules.user.httpCreatePro")
local httpCreatePar = require("modules.user.httpCreatePar")

userRouter:post("/create", create())
userRouter:post("/createPar", createPar())
userRouter:post("/httpCreate", httpCreate())
userRouter:post("/httpCreatePro", httpCreatePro())
userRouter:post("/httpCreatePar", httpCreatePar())

return userRouter
