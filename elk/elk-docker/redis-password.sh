#!/bin/bash

p=`openssl rand -base64 8 | cut -c 1-8`
sed -i '/^# requirepass/arequirepass '$p /root/redis-stable/redis.conf
sed -i '/^		# password =>/a		password => '\"$p\" /etc/logstash/conf.d/logstash-redis.conf