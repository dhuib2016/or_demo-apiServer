local autoRequire = require("handlers.autoRequire")

return function(app)
    local requireTable = autoRequire("/app/handlers/testUser")

    app:post("/testUser/login", requireTable.auth.login())
    app:get("/testUser/logout", requireTable.auth.logout())
    app:post("/testUser/register", requireTable.auth.register())
    app:post("/testUser/chgPwd", requireTable.auth.chgPwd())

    app:erruse("/testUser", requireTable.errHandler())
end
