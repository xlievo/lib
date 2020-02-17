FROM mcr.microsoft.com/dotnet/core/aspnet:3.1

RUN echo `cat /etc/issue`
ENV TZ=Asia/Shanghai
ENV LC_ALL=zh_CN.UTF-8

#RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN apt-get update \
    && apt-get install -y --no-install-recommends libgdiplus libc6-dev apache2-utils fontconfig libjpeg62-turbo libx11-6 libxcb1 libxext6 libxrender1 xfonts-75dpi xfonts-base \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN curl -L https://downloads.wkhtmltopdf.org/0.12/0.12.5/wkhtmltox_0.12.5-1.buster_amd64.deb -O --progress
RUN dpkg -i wkhtmltox_0.12.5-1.buster_amd64.deb && rm -rf wkhtmltox_0.12.5-1.buster_amd64.deb
