FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-bionic

RUN echo `cat /etc/issue`

ENV DEBIAN_FRONTEND noninteractive

#RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
#apt-get install -y --no-install-recommends libgdiplus libc6-dev apache2-utils fontconfig libjpeg62-turbo libx11-6 libxcb1 libxext6 libxrender1 xfonts-75dpi xfonts-base \
RUN apt-get update \
    && apt-get install -y --no-install-recommends locales locales-all tzdata libgdiplus apache2-utils libc6-dev fontconfig libjpeg62-dev libx11-6 libxcb1 libxext6 libxrender1 xfonts-75dpi xfonts-base \
	&& ln -fs /usr/share/zoneinfo/$TZ /etc/localtime \
	&& rm -rf /var/lib/apt/lists/ \
	&& dpkg-reconfigure -f noninteractive tzdata \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

ENV TZ=Asia/Shanghai
ENV LC_ALL=zh_CN.UTF-8
ENV LANG zh_CN.UTF-8
ENV LANGUAGE zh_CN.UTF-8