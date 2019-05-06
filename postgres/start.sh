#!/bin/bash

DATA=/var/lib/postgresql/data
CONF=$DATA/postgresql.conf
CONFEX=$DATA/postgresql.ex.conf

logging_collector_key=`cat $CONF | grep logging_collector | awk -F'=' '{ print $1 }' | sed s/^[[:space:]\']*//g | sed s/[[:space:]\']*$//g`
log_directory_key=`cat $CONF | grep log_directory | awk -F'=' '{ print $1 }' | sed s/^[[:space:]\']*//g | sed s/[[:space:]\']*$//g`
log_day_key=`cat $CONFEX | grep log_day | awk -F'=' '{ print $1 }' | sed s/^[[:space:]\']*//g | sed s/[[:space:]\']*$//g`
back_day_key=`cat $CONFEX | grep back_day | awk -F'=' '{ print $1 }' | sed s/^[[:space:]\']*//g | sed s/[[:space:]\']*$//g`
back_auto_key=`cat $CONFEX | grep back_auto | awk -F'=' '{ print $1 }' | sed s/^[[:space:]\']*//g | sed s/[[:space:]\']*$//g`
back_directory_key=`cat $CONFEX | grep back_directory | awk -F'=' '{ print $1 }' | sed s/^[[:space:]\']*//g | sed s/[[:space:]\']*$//g`
back_time_key=`cat $CONFEX | grep back_time | awk -F'=' '{ print $1 }' | sed s/^[[:space:]\']*//g | sed s/[[:space:]\']*$//g`
log_clear_time_key=`cat $CONFEX | grep log_clear_time | awk -F'=' '{ print $1 }' | sed s/^[[:space:]\']*//g | sed s/[[:space:]\']*$//g`
back_clear_time_key=`cat $CONFEX | grep back_clear_time | awk -F'=' '{ print $1 }' | sed s/^[[:space:]\']*//g | sed s/[[:space:]\']*$//g`

logging_collector=`cat $CONF | grep logging_collector | awk -F'=' '{ print $2 }' | awk -F'#' '{ print $1 }' | sed s/^[[:space:]\']*//g | sed s/[[:space:]\']*$//g`
log_directory=`cat $CONF | grep log_directory | awk -F'=' '{ print $2 }' | awk -F'#' '{ print $1 }' | sed s/^[[:space:]\']*//g | sed s/[[:space:]\']*$//g`
log_day=`cat $CONFEX | grep log_day | awk -F'=' '{ print $2 }' | awk -F'#' '{ print $1 }' | sed s/^[[:space:]\']*//g | sed s/[[:space:]\']*$//g`
back_day=`cat $CONFEX | grep back_day | awk -F'=' '{ print $2 }' | awk -F'#' '{ print $1 }' | sed s/^[[:space:]\']*//g | sed s/[[:space:]\']*$//g`
back_auto=`cat $CONFEX | grep back_auto | awk -F'=' '{ print $2 }' | awk -F'#' '{ print $1 }' | sed s/^[[:space:]\']*//g | sed s/[[:space:]\']*$//g`
back_directory=`cat $CONFEX | grep back_directory | awk -F'=' '{ print $2 }' | awk -F'#' '{ print $1 }' | sed s/^[[:space:]\']*//g | sed s/[[:space:]\']*$//g`
back_time=`cat $CONFEX | grep back_time | awk -F'=' '{ print $2 }' | awk -F'#' '{ print $1 }' | sed s/^[[:space:]\']*//g | sed s/[[:space:]\']*$//g`
log_clear_time=`cat $CONFEX | grep log_clear_time | awk -F'=' '{ print $2 }' | awk -F'#' '{ print $1 }' | sed s/^[[:space:]\']*//g | sed s/[[:space:]\']*$//g`
back_clear_time=`cat $CONFEX | grep back_clear_time | awk -F'=' '{ print $2 }' | awk -F'#' '{ print $1 }' | sed s/^[[:space:]\']*//g | sed s/[[:space:]\']*$//g`

echo $HOSTNAME postgresql.ex.conf: log_day="$log_day" log_clear_time="$log_clear_time" back_auto="$back_auto" back_directory="$back_directory" back_time="$back_time" back_day="$back_day" back_clear_time="$back_clear_time"

cron_pg=/var/spool/cron/crontabs/postgres

if [ -f $cron_pg ]; then
crontab -r
fi

if [[ $back_time_key == \#* ]]; then
back_time='0 0 * * *'
fi

if [[ $log_clear_time_key == \#* ]]; then
log_clear_time='0 0 * * *'
fi

if [[ $back_clear_time_key == \#* ]]; then
back_clear_time='0 0 * * *'
fi

if [[ $log_directory == \/* ]]; then
log_directory=$log_directory
else
log_directory=$DATA/$log_directory
mkdir -p log_directory
fi

if [[ ! $log_directory_key == \#* ]] && [[ ! $log_day_key == \#* ]] && [ ! -z $log_day ]; then
if [ -f $cron_pg ]; then
crontab -l >> $DATA/conf
fi
echo "$log_clear_time find "$log_directory" -mtime +"$log_day" -name \"*"$HOSTNAME.log"\" -exec rm -rf {} \;" >> $DATA/conf && crontab $DATA/conf && rm -f $DATA/conf
fi

if [[ $back_directory == \/* ]]; then
back_directory=$back_directory
else
back_directory=$DATA/$back_directory
mkdir -p back_directory
fi

if [[ ! $back_day_key == \#* ]] && [ ! -z $back_day ] && [[ ! $back_directory_key == \#* ]] && [ ! -z $back_directory ]; then
if [ -f $cron_pg ]; then
crontab -l >> $DATA/conf
fi
echo "$back_clear_time find "$back_directory" -mtime +"$back_day" -name \"*"$HOSTNAME"\" -exec rm -rf {} \;" >> $DATA/conf && crontab $DATA/conf && rm -f $DATA/conf
fi

if [[ ! $back_auto_key == \#* ]] && [ "on" = $back_auto ] && [ ! -z "$back_time" ]; then
if [ -f $cron_pg ]; then
crontab -l >> $DATA/conf
fi
echo "$back_time pg_dumpall -U $POSTGRES_USER > $back_directory/\$(date -d \"2 second\" +\"\%Y-\%m-\%d-\%H-\%M-\%S\")-"$HOSTNAME"" >> $DATA/conf && crontab $DATA/conf && rm -f $DATA/conf
fi

echo "docker exec -it db crontab -u postgres -l" 
crontab -u postgres -l