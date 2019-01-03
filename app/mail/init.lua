local mail = require "resty.mail"

function  send()
    local mailer, err = mail.new({
        host = "smtp2http",
        port = 25,
        ssl=false,
      })
      if err then
        ngx.log(ngx.ERR, "mail.new error: ", err)
        return ngx.exit(ngx.HTTP_INTERNAL_SERVER_ERROR)
      end
      
      local ok, err = mailer:send({
        from = "dalongrong <rongfl@demo.com>",
        to = { "1141591465@qq.com" },
        subject = "荣锋亮测试!",
        text = "There's pizza in the sewer.",
        html = "<h1>There's pizza in the sewer.</h1>",
      })
      if err then
        ngx.log(ngx.ERR, "mailer:send error: ", err)
        return ngx.exit(ngx.HTTP_INTERNAL_SERVER_ERROR)
      end
end
return  send
