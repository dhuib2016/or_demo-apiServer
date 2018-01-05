local HTTP_OK = ngx.HTTP_OK

return function()
    return function(req, res)
	    res:status(HTTP_OK):send("pong succ!")
    end
end