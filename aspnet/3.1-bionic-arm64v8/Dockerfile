FROM golang:alpine AS builder
WORKDIR /go
ENV QEMU_DOWNLOAD_SHA256 a1ef52971537e11915565233f48aa179839f676008d7911c05b3ae94c08c4f5c
RUN apk add curl --no-cache
RUN curl -sL -o qemu-3.0.0+resin-aarch64.tar.gz https://github.com/balena-io/qemu/releases/download/v3.0.0%2Bresin/qemu-3.0.0+resin-aarch64.tar.gz && echo "$QEMU_DOWNLOAD_SHA256 *qemu-3.0.0+resin-aarch64.tar.gz" | sha256sum -c - | tar zxvf qemu-3.0.0+resin-aarch64.tar.gz -C . && mv qemu-3.0.0+resin-aarch64/qemu-aarch64-static .

FROM mcr.microsoft.com/dotnet/aspnet:3.1-bionic-arm64v8
COPY --from=builder /go/qemu-aarch64-static /usr/bin/

#RUN echo `cat /etc/issue`

ENV TZ=Asia/Shanghai
ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL=zh_CN.UTF-8
ENV LANG zh_CN.UTF-8
ENV LANGUAGE zh_CN.UTF-8

RUN apt-get update \
    && apt-get install -y --no-install-recommends locales locales-all tzdata libgdiplus apache2-utils libc6-dev fontconfig libx11-6 libxcb1 libxext6 libxrender1 xfonts-75dpi xfonts-base libjpeg62-dev \
	&& ln -fs /usr/share/zoneinfo/$TZ /etc/localtime \
	&& rm -rf /var/lib/apt/lists/ \
	&& dpkg-reconfigure -f noninteractive tzdata \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*
