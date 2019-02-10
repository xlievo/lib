#!/bin/bash

REDIS_HOME = "/opt/redis"

sh $REDIS_HOME/redis-password.sh
$REDIS_HOME/src/redis-server $REDIS_HOME/redis.conf
sed -n 507,507p $REDIS_HOME/redis.conf