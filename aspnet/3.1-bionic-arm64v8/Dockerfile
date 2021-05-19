FROM mcr.microsoft.com/dotnet/aspnet:3.1-bionic-arm64v8

#RUN echo `cat /etc/issue`

ENV TZ=Asia/Shanghai
ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL=zh_CN.UTF-8
ENV LANG zh_CN.UTF-8
ENV LANGUAGE zh_CN.UTF-8

RUN apt-get update
RUN apt-get install -y --no-install-recommends locales locales-all
RUN apt-get install -y tzdata libgdiplus apache2-utils libc6-dev fontconfig
RUN apt-get install -y libx11-6 libxcb1 libxext6 libxrender1 xfonts-75dpi xfonts-base libjpeg62-dev

RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime \
	&& rm -rf /var/lib/apt/lists/ \
	&& dpkg-reconfigure -f noninteractive tzdata \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*
