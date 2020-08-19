FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-bionic

RUN echo `cat /etc/issue`
ENV TZ=Asia/Shanghai
ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL=zh_CN.UTF-8

#RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN apt-get update \
    && apt-get install -y --no-install-recommends tzdata libgdiplus libc6-dev apache2-utils fontconfig libjpeg62-turbo libx11-6 libxcb1 libxext6 libxrender1 xfonts-75dpi xfonts-base \
	&& ln -fs /usr/share/zoneinfo/$TZ /etc/localtime \
	&& rm -rf /var/lib/apt/lists/ \
	&& dpkg-reconfigure -f noninteractive tzdata \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*