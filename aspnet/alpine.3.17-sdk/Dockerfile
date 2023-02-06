FROM mcr.microsoft.com/dotnet/sdk:7.0.102-alpine3.17-amd64

RUN echo `cat /etc/issue`
ENV TZ=Asia/Shanghai
ENV LC_ALL=zh_CN.UTF-8

RUN apk update

RUN apk add --no-cache clang build-base zlib-dev
