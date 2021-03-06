#!/bin/bash

p=`openssl rand -hex 8 | cut -c 1-8`
sed -i 's/^# requirepass $p/requirepass '$p'/g' ${REDIS_HOME}/redis.conf
sed -i 's/^		# password => $p/	password => '\"$p\"'/g' ${LOGSTASH_PATH_CONF}/conf.d/logstash-redis.conf

${REDIS_HOME}/src/redis-server ${REDIS_HOME}/redis.conf
#sed -n 507,507p ${REDIS_HOME}/redis.conf
grep -F "requirepass"  ${REDIS_HOME}/redis.conf

env >> /etc/default/locale
#/etc/init.d/cron restart