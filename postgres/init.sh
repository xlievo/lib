#!/bin/bash

p=`openssl rand -hex 8 | cut -c 1-8`

psql -v ON_ERROR_STOP=1 --username="$POSTGRES_USER" <<-EOSQL
    create role replica login replication encrypted password '$p'; 
EOSQL

echo 'replica' $p

echo 'host all all all trust' >> /var/lib/postgresql/data/pg_hba.conf

pg_ctl restart