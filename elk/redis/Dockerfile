
docker run --restart=always --privileged=true -u root -v /root/workspace/elk-data:/var/lib/elasticsearch -p 5601:5601 -p 9200:9200 -p 5044:5044 -p 6000:6379 -itd --name elk xlievo/elk:latest

###############################################################################
#                      install redis dotnet nodejs pm2
###############################################################################

ENV TZ=Asia/Shanghai

# redis
ENV REDIS_HOME /opt/redis
ENV REDIS_PACKAGE redis-stable.tar.gz

RUN apt-get install -y gcc make wget \
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
RUN wget -q https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN apt-get install apt-transport-https
RUN apt-get update
RUN apt-get install aspnetcore-runtime-2.2

# nodejs pm2
RUN apt-get install -y python-software-properties
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash  -
RUN apt-get install -y nodejs
RUN apt-get install -y build-essential
RUN npm install pm2@latest -g

RUN apt-get clean