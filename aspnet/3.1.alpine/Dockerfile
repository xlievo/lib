FROM mcr.microsoft.com/dotnet/core/aspnet:3.1.0-alpine3.10

RUN echo `cat /etc/issue`
#ENV TZ=Asia/Shanghai
#ENV LC_ALL=zh_CN.UTF-8

RUN apk update

RUN apk add apache2-utils wkhtmltopdf
