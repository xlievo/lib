#!/bin/bash

sh $1/redis-password.sh
exec $1/src/redis-server $1/redis.conf
sed -n 507,507p $1/redis.conf