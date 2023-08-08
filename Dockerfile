# 第一个构建阶段
FROM golang:1.19.2 AS builder

MAINTAINER runningriven@gmail.com
# 暴露端口 不然无法访问
EXPOSE 8088
# 设置工作目录(容器内路径,非宿主机路径)
WORKDIR /usr/src/helloworld/
# 拷贝当前目录的所有文件到工作目录，第一个“.”表示当前目录，第二个“.”表示工作目录(上面WORKDIR指定的目录)
COPY . .

ENV GOPROXY=https://goproxy.cn,direct

RUN go mod tidy

# go build 生成可执行文件，文件名为helloworld-server，生成路径“./cmd/hello/”，实际上是“WORKDIR+cmd/hello”
# ls -l 列出目录下的文件
# cp命令 构建过程中会删除中间容器(Removing intermediate container 36dea0c095e0), 需要将生成的文件拷贝拷贝到对应路径
RUN CGO_ENABLED=0 GOOS=linux go build -o helloworld-server ./cmd/hello/ \
    && ls -l \
    && cp helloworld-server ./cmd/hello/helloworld-server

# 第二个构建阶段
FROM ubuntu
# 设置第二个阶段的工作路径
WORKDIR /usr/local/bin

# -from=builder 从构建阶段中拷贝文件，拷贝可执行文件到第二个阶段的WORKDIR
COPY --from=builder /usr/src/helloworld/cmd/hello/helloworld-server .

# 运行可执行文件，可执行文件的所在目录为: /usr/local/bin/helloworld-server
CMD ["./helloworld-server"]