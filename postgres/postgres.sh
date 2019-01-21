#!/bin/bash

p=`openssl rand -base64 8 | cut -c 1-8`

docker run -d --name db -v /root/workspace/db:/var/lib/postgresql/data -e POSTGRES_USER=root -e POSTGRES_PASSWORD=$p -p 5920:5432 daocloud.io/library/postgres:latest -c 'shared_buffers=256MB' -c 'max_connections=500'

echo "port=5920 password=$p max_connections=500 shared_buffers=256MB data=/root/workspace/db"