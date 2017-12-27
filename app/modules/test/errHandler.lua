-- simple error handler ignore req, res, next
return function(err)
    ngx.log(ngx.ERR, "/test err: ", err)
end