local lor = require("lor.index")
local userRouter = lor:Router()
local create = require("modules.user.create")
local query = require("modules.user.query")

userRouter:post("/create", create())
userRouter:get("/query", query())

return userRouter
