FROM mcr.microsoft.com/dotnet/aspnet:3.1-bionic-arm64v8

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