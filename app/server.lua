-- function reference
-- include
local lor = require("lor.index")
local view = require("config.view")
local applicationInfoMiddleware = require("middleware.applicationInfo")
local sessionMiddleware = require("lor.lib.middleware.session")
local validateLoginMiddleware = require("middleware.validateLogin")
local router = require("router")
local versionCfg = require("config.version")
local sessionCfg = require("config.session")
local whitePathList = require("config.whitePathList")

local app = lor()

app:conf("view enable", true)
app:conf("view engine", view.engine)
app:conf("view ext", view.ext)
app:conf("view layout", view.layout)
app:conf("views", view.views)

app:use(applicationInfoMiddleware(versionCfg))
app:use(sessionMiddleware({
    secret = sessionCfg.secret,
    timeout = sessionCfg.timeout
}))
app:use(validateLoginMiddleware(whitePathList))

router(app)

app:erroruse(function(err, req, res)
    ngx.log(ngx.WARN, "default error handler: ", err)

    if req:is_found() then
        res:status(500):send("server error.")
    else
        res:status(404):send("404! sorry, not found.")
    end
end)

return app
