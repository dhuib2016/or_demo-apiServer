local autoRequire = require("handlers.autoRequire")

return function(app)
    local requireTable = autoRequire("/handlers/testUser/")

    app:post("/testUser/login", requireTable.auth.login())
    app:post("/testUser/chgPwd", requireTable.auth.chgPwd())
    app:get("/testUser/logout", requireTable.auth.logout())

    app:erruse("/testUser", requireTable.errHandler())
end
