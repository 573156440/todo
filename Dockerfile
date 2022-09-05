FROM node:10.15.3

LABEL maintainer="gx.7711@163.com"

COPY . /app

WORKDIR /app

RUN ls

RUN npm install --registry=https://registry.npm.taobao.org   # 安装依赖

RUN ls                             # 测试以依赖安装结果

EXPOSE 3000

CMD [ "npm", "start"]