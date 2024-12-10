# 使用官方的基础镜像，这里以 Alpine Linux 为例，因为它是一个轻量级的基础镜像
FROM alpine:latest

# 设置维护者信息
LABEL maintainer="yourname@example.com"

# 安装编译 udpxy 所需的依赖
RUN apk add --update --no-cache build-base openssl-dev

# 设置工作目录
WORKDIR /usr/src/udpxy

# 下载 udpxy 源代码
RUN wget -O udpxy.tar.gz https://github.com/pcherenkov/udpxy/archive/master.tar.gz \
    && tar xzf udpxy.tar.gz --strip-components=1 \
    && rm udpxy.tar.gz

# 编译 udpxy
RUN make \
    && make install

# 指定 udpxy 的运行端口
EXPOSE 4022

# 运行 udpxy
CMD ["udpxy", "--syslog", "--foreground", "-p", "4022"]
