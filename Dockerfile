FROM openresty/openresty:alpine-fat
LABEL author="1141591465@qq.com"
RUN /usr/local/openresty/luajit/bin/luarocks install lua-rocks-app-project
RUN /usr/local/openresty/luajit/bin/luarocks install lua-resty-mail
