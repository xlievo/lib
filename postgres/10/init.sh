#!/bin/bash

p=`openssl rand -hex 8 | cut -c 1-8`

psql -v ON_ERROR_STOP=1 <<-EOSQL
    create role replica login replication encrypted password '$p'; 
EOSQL

echo 'replica' $p