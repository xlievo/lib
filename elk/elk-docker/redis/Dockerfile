
docker run --restart=always --privileged=true -u root -v /root/workspace/elk-data:/var/lib/elasticsearch -p 5601:5601 -p 9200:9200 -p 5044:5044 -p 6000:6379 -itd --name elk xlievo/elk:latest

###############################################################################
#                      install redis dotnet filebeat nodejs pm2
###############################################################################

ENV TZ=Asia/Shanghai
ENV LC_ALL C.UTF-8

# redis
ENV REDIS_HOME /opt/redis
ENV REDIS_PACKAGE redis-stable.tar.gz

RUN apt-get install -y gcc make \
 && mkdir ${REDIS_HOME} \
 && curl -O http://download.redis.io/releases/${REDIS_PACKAGE} \
 && tar xzf ${REDIS_PACKAGE} -C ${REDIS_HOME} --strip-components=1 \
 && rm -f ${REDIS_PACKAGE} \
 && cd ${REDIS_HOME} && make

COPY redis/redis.conf ${REDIS_HOME}/redis.conf
RUN rm -rf ${LOGSTASH_PATH_CONF}/conf.d/*
COPY redis/logstash-redis.conf ${LOGSTASH_PATH_CONF}/conf.d/logstash-redis.conf

EXPOSE 6379

COPY redis/redis.sh /usr/local/bin/redis.sh
RUN chmod +x /usr/local/bin/redis.sh

# dotnet
RUN curl -L -O https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN apt-get install -y apt-transport-https
RUN apt-get update
RUN apt-get install -y aspnetcore-runtime-2.2
RUN rm -f packages-microsoft-prod.deb

# nodejs pm2
RUN apt-get install -y python-software-properties
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash  -
RUN apt-get install -y nodejs
RUN apt-get install -y build-essential
RUN npm install pm2@latest -g
#RUN ln -s /usr/local/bin

### install Filebeat

##https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-getting-started.html
ENV FILEBEAT_VERSION ${ELK_VERSION}
ENV FILEBEAT_PACKAGE filebeat-${FILEBEAT_VERSION}-amd64.deb
ENV FILEBEAT_HOME /etc/filebeat

RUN curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/${FILEBEAT_PACKAGE} \
 && dpkg -i ${FILEBEAT_PACKAGE} \
 && rm -f ${FILEBEAT_PACKAGE} \
 && mkdir -p ${FILEBEAT_HOME}/log && mkdir -p ${FILEBEAT_HOME}/postgresql && mkdir -p ${FILEBEAT_HOME}/redis && mkdir -p ${FILEBEAT_HOME}/haproxy \
 && filebeat modules enable postgresql \
 && sed -i 's/^  enabled: false/  enabled: true/g' ${FILEBEAT_HOME}/filebeat.yml \
 && sed -i 's/^    - \/var\/log\/\*.log/    - \/etc\/filebeat\/log\/\*.log/g' ${FILEBEAT_HOME}/filebeat.yml \
 && sed -i 's/^    #var.paths:/    var.paths: ["\/etc\/filebeat\/postgresql\/\*.log\*"]/g' ${FILEBEAT_HOME}/modules.d/postgresql.yml
 
RUN mv ${FILEBEAT_HOME} /opt/

VOLUME ${FILEBEAT_HOME}
# service filebeat stop
# service filebeat start
# filebeat setup -e
# sh /usr/local/bin/redis.sh

# icu
#RUN apt-get install -y libicu-dev

# crontab
#RUN apt-get install -y cron

RUN rm -rf /var/lib/apt/lists/* && apt-get clean