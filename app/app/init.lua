local userslogin = require("users.login")
local json = require("cjson")
function  logininfo(name,pass)
   local name,pass = userslogin(name,pass)
    local loginresult= {
        name = name,
        pass = pass
    }
    ngx.say(json.encode(loginresult))
end

return logininfo