return function()
	return function(err)
		ngx.log(ngx.ERR, "/test err: ", err)
	end
end