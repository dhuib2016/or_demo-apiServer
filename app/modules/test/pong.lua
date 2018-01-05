local HTTP_OK = ngx.HTTP_OK

return function()
    return function(req, res)
		ngx.sleep(0.2)
	    res:status(HTTP_OK):send("pong succ!")
    end
end