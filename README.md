# hello world
## 简介
该项目是一个用来制作`Docker image`的项目案例。采用多阶段构建的方式来生成一个服务镜像, 后续可以用`Docker`部署在目的平台上，向外界提交服务。

镜像的构建方式详见`Dockerfile`文件。

## 其他
如果`Dockerfile`的名字为`hello.Dockerfile`，则对应的构建镜像的命令应当改为
```Dockerfile
docker build -f hello.Dockerfile -t hello-server:latest .
```