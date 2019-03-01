#!/bin/bash

p=`openssl rand -hex 8 | cut -c 1-8`

psql -v ON_ERROR_STOP=1 --username="$POSTGRES_USER" <<-EOSQL
    create role replica login replication encrypted password '$p'; 
EOSQL

echo 'master replica password '$p

echo 'host replication replica 0.0.0.0/0 md5' >> /var/lib/postgresql/data/pg_hba.conf
# SHOST SPORT SPASSWORD
if [ -z $SPASSWORD ]; then
echo "master OK !"
else
echo "SHOST="${SHOST} "SPORT="${SPORT} "SPASSWORD="${SPASSWORD}
export PGPASSWORD=${SPASSWORD}
rm -rf /var/lib/postgresql/data/*
pg_basebackup -h ${SHOST} -p ${SPORT} -U replica -D /var/lib/postgresql/data -X stream -P
mkdir -p /var/lib/postgresql/data/pg_archive
cp /docker-entrypoint-initdb.d/recovery.conf /var/lib/postgresql/data/
sed -i "s/\${SHOST}/"${SHOST}"/" /var/lib/postgresql/data/recovery.conf
sed -i "s/\${SPORT}/"${SPORT}"/" /var/lib/postgresql/data/recovery.conf
sed -i "s/\${SPASSWORD}/"${SPASSWORD}"/" /var/lib/postgresql/data/recovery.conf
echo "slave OK !"
fi

pg_ctl restart