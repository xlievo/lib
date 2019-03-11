#!/bin/bash

export HOSTNAME=`hostname`
DATA=/var/lib/postgresql/data

mkdir -p $DATA/pg_archive

p=`openssl rand -hex 8 | cut -c 1-8`

psql -v ON_ERROR_STOP=1 --username="$POSTGRES_USER" <<-EOSQL
    create role replica login replication encrypted password '$p';
EOSQL

echo 'master replica password '$p

echo 'host replication replica 0.0.0.0/0 md5' >> $DATA/pg_hba.conf
# SHOST SPORT SPASSWORD
if [ -z $SPASSWORD ]; then
echo "master" `hostname` "OK !"
else
echo "SHOST="${SHOST} "SPORT="${SPORT} "SPASSWORD="${SPASSWORD}
export PGPASSWORD=${SPASSWORD}
rm -rf $DATA/*
pg_basebackup -h ${SHOST} -p ${SPORT} -U replica -D $DATA -X stream -P
mkdir -p $DATA/pg_archive
cp /docker-entrypoint-initdb.d/recovery.conf $DATA/
sed -i "s/\${SHOST}/"${SHOST}"/" $DATA/recovery.conf
sed -i "s/\${SPORT}/"${SPORT}"/" $DATA/recovery.conf
sed -i "s/\${SPASSWORD}/"${SPASSWORD}"/" $DATA/recovery.conf
echo "slave" `hostname` "OK !"
fi

sed -i 's/^log_filename.*/log_filename = '\''postgresql-%Y-%m-%d_%H%M%S-'$HOSTNAME'.log'\''/g' $DATA/postgresql.conf
sed -i 's/^#log_filename.*/log_filename = '\''postgresql-%Y-%m-%d_%H%M%S-'$HOSTNAME'.log'\''/g' $DATA/postgresql.conf

cp /docker-entrypoint-initdb.d/postgresql.ex.conf $DATA/
#mkdir -p $DATA/backups
#export back_directory=$DATA/backups
#echo backups=$BACKUPS

pg_ctl restart