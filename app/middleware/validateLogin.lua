-- function reference
local match = ngx.re.match
local ipairs = ipairs
-- include

local logined = function(req)
    return req.session and req.session.get("accInfo") or nil
end

local validateLogin = function(whitePathList)
	return function(req, res, next)
		local requestPath = req.path
	    local white = false
	    for _, v in ipairs(whitePathList) do
            local captures = match(requestPath, v, "jo")
            if captures then
                white = true
                goto goon
            end
        end

        ::goon::
		local accInfo = logined(req)
	    if white or accInfo then
            res.locals.login = accInfo and true or false
            res.locals.id = accInfo and accInfo.id
            res.locals.type = accInfo and accInfo.type
            next()
	    else
	        next("please login first")
	    end
	end
end

return validateLogin

