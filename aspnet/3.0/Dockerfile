FROM mcr.microsoft.com/dotnet/core/aspnet:3.0.1

RUN echo `cat /etc/issue`
ENV TZ=Asia/Shanghai
ENV LC_ALL=zh_CN.UTF-8

#RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y fontconfig libjpeg62-turbo libx11-6 libxcb1 libxext6 libxrender1 xfonts-75dpi xfonts-base

#https://wkhtmltopdf.org/downloads.html
#https://downloads.wkhtmltopdf.org/0.12/0.12.5/wkhtmltox_0.12.5-1.buster_amd64.deb
RUN curl https://github-production-release-asset-2e65be.s3.amazonaws.com/271714/fecafd00-09e8-11ea-9473-ed54b0adbb7d?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20191209%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20191209T045851Z&X-Amz-Expires=300&X-Amz-Signature=bc1c4fbcded854844a5d066fdb16d0b98a029df2a7be35655c9f4c12373e9d0e&X-Amz-SignedHeaders=host&actor_id=0&response-content-disposition=attachment%3B%20filename%3Dwkhtmltox_0.12.5-1.buster_amd64.deb&response-content-type=application%2Foctet-stream -O --progress
#RUN apt-get install -y apache2-utils wkhtmltopdf
RUN dpkg -i wkhtmltox_0.12.5-1.buster_amd64.deb && rm -rf wkhtmltox_0.12.5-1.buster_amd64.deb

#RUN mkdir -p /root/workspace
#COPY /* /root/workspace/
#RUN dpkg -i /root/workspace/wkhtmltox_0.12.5-1.buster_amd64.deb

# ENTRYPOINT ["wkhtmltoimage"]
#
#WORKDIR /root/workspace/
#RUN chmod +x /root/workspace/HTML2Image
#ENTRYPOINT ["/root/workspace/HTML2Image"]
