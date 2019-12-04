FROM mcr.microsoft.com/dotnet/core/aspnet:3.1

RUN echo `cat /etc/issue`
#ENV TZ=Asia/Shanghai
#ENV LC_ALL=zh_CN.UTF-8

#RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN apt-get update

#https://wkhtmltopdf.org/downloads.html
#https://downloads.wkhtmltopdf.org/0.12/0.12.5/wkhtmltox_0.12.5-1.buster_amd64.deb
RUN curl https://downloads.wkhtmltopdf.org/0.12/0.12.5/wkhtmltox_0.12.5-1.buster_amd64.deb -O --progress
RUN apt-get install -y apache2-utils fontconfig libjpeg62-turbo libx11-6 libxcb1 libxext6 libxrender1 xfonts-75dpi xfonts-base
RUN dpkg -i wkhtmltox_0.12.5-1.buster_amd64.deb && rm -rf wkhtmltox_0.12.5-1.buster_amd64.deb

#RUN mkdir -p /root/workspace
#COPY /* /root/workspace/
#RUN dpkg -i /root/workspace/wkhtmltox_0.12.5-1.buster_amd64.deb

# ENTRYPOINT ["wkhtmltoimage"]
#
#WORKDIR /root/workspace/
#RUN chmod +x /root/workspace/HTML2Image
#ENTRYPOINT ["/root/workspace/HTML2Image"]
