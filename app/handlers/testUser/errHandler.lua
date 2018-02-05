-- function reference
local log = ngx.log
local WARN = ngx.WARN

return function()
	return function(err)
		log(WARN, "/user err: ", err)
	end
end