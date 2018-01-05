return function()
	return function(err)
		ngx.log(ngx.ERR, "/user err: ", err)
	end
end