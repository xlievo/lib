### install redis

ENV TZ=Asia/Shanghai
### ENV LC_ALL=zh_CN.UTF-8

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

COPY redis/redis-password.sh ${REDIS_HOME}/redis-password.sh
RUN chmod +x ${REDIS_HOME}/redis-password.sh

EXPOSE 6379

COPY ./redis.sh /usr/local/bin/redis.sh
RUN chmod +x /usr/local/bin/redis.sh
ENTRYPOINT ["/usr/local/bin/redis.sh", ${REDIS_HOME}]