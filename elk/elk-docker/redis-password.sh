#!/bin/bash

p=`openssl rand -base64 8 | cut -c 1-8`
sed -i 's/^# requirepass $p/requirepass '$p'/' /root/redis-stable/redis.conf
sed -i 's/^		# password => $p/		password => '\"$p\"'/' /etc/logstash/conf.d/logstash-redis.conf