# openresty with simple luarocks demo

## luarocks packages create

* init spec

```code
luarocks-5.1 write_rockspec --lua-version=5.1

```

* add some codes

```code
mkdir -p users
touch users/login.lua

just like below:

function init(name,password)
   return name,password
end
return init;

```

* modify spec file info

```code
change name to lua-rocks-app-project-1.0.0-2.rockspec

content like below:

package = "lua-rocks-app-project"
version = "1.0.0-2"
source = {
   url = "git://github.com/rongfengliang/luarocks-packagedemo.git"
}
description = {
   homepage = "https://github.com/rongfengliang/luarocks-packagedemo.git",
   license = "unlicense"
}
dependencies = {
   "lua ~> 5.1"
}
build = {
   type = "builtin",
   modules = {
      ["users.login"]="users/login.lua"
   }
}

```

* publish module

```code
luarocks upload lua-rocks-app-project-1.0.0-2.rockspec  --api-key=${api-key}
```

* how to use the package in your project

with  openresty for test

```code
mkdir app/app

touch app/app/init.lua

content:

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

openresty call the module

content_by_lua_block {
             require("app/init")("dalong","admin");
}
```

## running project

with docker && docker-compose

* dockerfile

add luarocks install module

```code
FROM openresty/openresty:alpine-fat
LABEL author="1141591465@qq.com"
RUN /usr/local/openresty/luajit/bin/luarocks install lua-rocks-app-project

```

* build image

```code
docker-compose build
```

* running

```code
docker-compose up -d
```

* watch result

```code
curl http://localhost:8080/info
```