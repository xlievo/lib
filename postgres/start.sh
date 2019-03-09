#!/bin/bash

DATA=/var/lib/postgresql/data
CONF=$DATA/postgresql.conf
CONFEX=$DATA/postgresql.ex.conf

logging_collector_key=`cat $CONF | grep logging_collector | awk -F'=' '{ print $1 }' | sed s/[[:space:]]//g`
log_directory_key=`cat $CONF | grep log_directory | awk -F'=' '{ print $1 }' | sed s/[[:space:]]//g`
log_day_key=`cat $CONFEX | grep log_day | awk -F'=' '{ print $1 }' | sed s/[[:space:]]//g`
back_day_key=`cat $CONFEX | grep back_day | awk -F'=' '{ print $1 }' | sed s/[[:space:]]//g`
back_auto_key=`cat $CONFEX | grep back_auto | awk -F'=' '{ print $1 }' | sed s/[[:space:]]//g`
back_directory_key=`cat $CONFEX | grep back_directory | awk -F'=' '{ print $1 }' | sed s/[[:space:]]//g`
back_time_key=`cat $CONFEX | grep back_time | awk -F'=' '{ print $1 }' | sed s/[[:space:]]//g`

logging_collector=`cat $CONF | grep logging_collector | awk -F'=' '{ print $2 }' | awk -F'#' '{ print $1 }' | sed s/[[:space:]]//g`
log_directory=`cat $CONF | grep log_directory | awk -F'=' '{ print $2 }' | awk -F'#' '{ print $1 }' | sed s/[[:space:]\']//g`
log_day=`cat $CONFEX | grep log_day | awk -F'=' '{ print $2 }' | awk -F'#' '{ print $1 }' | sed s/[[:space:]]//g`
back_day=`cat $CONFEX | grep back_day | awk -F'=' '{ print $2 }' | awk -F'#' '{ print $1 }' | sed s/[[:space:]]//g`
back_auto=`cat $CONFEX | grep back_auto | awk -F'=' '{ print $2 }' | awk -F'#' '{ print $1 }' | sed s/[[:space:]]//g`
back_directory=`cat $CONFEX | grep back_directory | awk -F'=' '{ print $2 }' | awk -F'#' '{ print $1 }' | sed s/[[:space:]\']//g`
back_time=`cat $CONFEX | grep back_time | awk -F'=' '{ print $2 }' | awk -F'#' '{ print $1 }' | sed s/[[:space:]]//g`

echo postgresql.ex.conf: log_day=$log_day back_auto=$back_auto back_directory=$back_directory back_time=$back_time back_day=$back_day

cron_pg=/var/spool/cron/crontabs/postgres

if [ -f $cron_pg ]; then
crontab -r
fi

if [[ $back_time_key == \#* ]]; then
back_time=0
fi

if [[ $log_directory == \/* ]]; then
log_directory=$log_directory
else
log_directory=$DATA/$log_directory
fi

if [[ ! $log_directory_key == \#* ]] && [[ ! $log_day_key == \#* ]] && [ ! -z $log_day ] && [ ! -1 = $log_day ] && [ true = `echo $log_day | grep -E '[^0-9]' >/dev/null && echo false || echo true` ]; then
if [ -f $cron_pg ]; then
crontab -l >> $DATA/conf
fi
echo "0 0 * * * find "$log_directory" -mtime +"$log_day" -name \"*\" -exec rm -rf {} \;" >> $DATA/conf && crontab $DATA/conf && rm -f $DATA/conf
fi

if [[ ! $back_day_key == \#* ]] && [ ! -z $back_day ] && [ ! -1 = $back_day ] && [ true = `echo $back_day | grep -E '[^0-9]' >/dev/null && echo false || echo true` ] && [[ ! $back_directory_key == \#* ]] && [ ! -z $back_directory ]; then
if [ -f $cron_pg ]; then
crontab -l >> $DATA/conf
fi
if [[ $back_directory == \/* ]]; then
back_directory=$back_directory
else
back_directory=$DATA/$back_directory
fi
echo "0 0 * * * find "$back_directory" -mtime +"$back_day" -name \"*\" -exec rm -rf {} \;" >> $DATA/conf && crontab $DATA/conf && rm -f $DATA/conf
fi

if [[ ! $back_auto_key == \#* ]] && [ "on" = $back_auto ] && [ ! -z $back_time ] && [ true = `echo $back_time | grep -E '[^0-9]' >/dev/null && echo false || echo true` ]; then
if [ -f $cron_pg ]; then
crontab -l >> $DATA/conf
fi
echo "0 $back_time * * * pg_dumpall -U $POSTGRES_USER > $DATA/backups/\$(date -d \"2 second\" +\"\%Y-\%m-\%d-\%H-\%M-\%S\")" >> $DATA/conf && crontab $DATA/conf && rm -f $DATA/conf
fi

echo "docker exec -it db crontab -u postgres -l" 
crontab -u postgres -l