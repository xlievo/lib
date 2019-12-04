FROM mcr.microsoft.com/dotnet/core/aspnet:3.0.1-alpine3.10

RUN echo `cat /etc/issue`
#ENV TZ=Asia/Shanghai
#ENV LC_ALL=zh_CN.UTF-8

#RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN apt update

RUN apk add -y apache2-utils wkhtmltopdf
