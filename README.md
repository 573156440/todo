# express-todoList

A todoList using express and MongoDB.
> 用express框架和MongoDB，配合ejs模版引擎编写的todoList项目。

The default mongodb port is 27017.

## run project
```shell
npm i
npm start
```
Open browser at http://localhost:3000.

## docker 构建&运行
```
docker build -t sheen/todo:latest
docker run --name mytodo --net=host -p -d sheen/todo:latest
```

## nginx
1. 配置外部配置文件和nginx docker的映射, 外部/root/sheen/nginx文件夹下创建conf.d文件、log文件夹和nginx.conf文件， 上级myPro文件夹里放项目。
```
docker run --name mynginx -d -p 80:80 -v /root/sheen/nginx/nginx.conf:/etc/nginx/nginx.conf -v /root/sheen/nginx/conf.d:/etc/nginx/conf.d -v /root/sheen/nginx/log:/var/log/nginx -v /root/sheen/myPro:/root/sheen/myPro nginx
```
2. nginx.conf
```
user nginx;
worker_processes 1;

error_log  /var/log/nginx/error.log warn;
pid        /var/run/nginx.pid;


events {
    worker_connections  1024;
}


http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    keepalive_timeout  65;

    #gzip  on;

    include /etc/nginx/conf.d/*.conf;
}
```
3. default.conf
```
server {
    listen       80;
    server_name  localhost;

    #access_log  /var/log/nginx/log/host.access.log  main;

    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
        autoindex  on;
        #try_files $uri /index/index/page.html;
        #try_files $uri /index/map/page.html;
    }

    #error_page  404              /404.html;

    # redirect server error pages to the static page /50x.html
    #
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}
```
