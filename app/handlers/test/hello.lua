local HTTP_OK = ngx.HTTP_OK

return function()
    return function(req, res)
	    res:status(HTTP_OK):send("hello too!")
    end
end