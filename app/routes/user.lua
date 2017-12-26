local lor = require("lor.index")
local userRouter = lor:Router()
local create = require("modules.user.create")
--local query = require("modules.user.create")

--userRouter:post("/create", creator:createId(), creator:createName())
userRouter:post("/create", create())
--userRouter:get("/query", query())

return userRouter
