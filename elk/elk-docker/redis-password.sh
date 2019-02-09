#!/bin/bash

p=`openssl rand -hex 8 | cut -c 1-8`
sed -i 's/^# requirepass $p/requirepass '$p'/g' /root/redis-stable/redis.conf
sed -i 's/^		# password => $p/		password => '\"$p\"'/g' /etc/logstash/conf.d/logstash-redis.conf