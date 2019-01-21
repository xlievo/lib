#!/bin/bash

p=`openssl rand -base64 8 | cut -c 1-8`

docker run -d --name redis --privileged=true --ulimit nproc=65535:65535 -p 5900:6379 daocloud.io/library/redis:latest redis-server --requirepass $p --maxclients 10000 --tcp-keepalive 60 --timeout 120

echo "port=5900 password=$p maxclients=10000 tcp-keepalive=60 timeout=120"