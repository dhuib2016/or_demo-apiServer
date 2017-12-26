-- simple error handler ignore req, res, next
return function(err)
    ngx.log(ngx.ERR, "/user err: ", err)
end