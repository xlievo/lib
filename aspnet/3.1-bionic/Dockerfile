FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-bionic

RUN echo `cat /etc/issue`

ENV DEBIAN_FRONTEND noninteractive

#RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN apt-get update \
    && apt-get install -y --no-install-recommends locales locales-all tzdata libgdiplus apache2-utils \
	&& ln -fs /usr/share/zoneinfo/$TZ /etc/localtime \
	&& rm -rf /var/lib/apt/lists/ \
	&& dpkg-reconfigure -f noninteractive tzdata \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

ENV TZ=Asia/Shanghai
ENV LC_ALL=zh_CN.UTF-8
ENV LANG zh_CN.UTF-8
ENV LANGUAGE zh_CN.UTF-8