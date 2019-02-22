#!/bin/bash

sed -i 's/^log_rotation_age = 1d/log_rotation_age = 1d/g' $PGDATA/postgresql.conf
sed -i 's/^log_rotation_size = 100MB/log_rotation_size = 100MB/g' $PGDATA/postgresql.conf
sed -i 's/^log_lock_waits = on/log_lock_waits = on/g' $PGDATA/postgresql.conf
sed -i 's/^log_statement = 'none'/log_statement = 'ddl'/g' $PGDATA/postgresql.conf
sed -i 's/^log_duration = off/log_duration = on/g' $PGDATA/postgresql.conf
sed -i 's/^log_min_duration_statement = -1/log_min_duration_statement = 60/g' $PGDATA/postgresql.conf
sed -i 's/^log_timezone = 'UTC'/log_timezone = 'Asia/Shanghai'/g' $PGDATA/postgresql.conf

RUN ENV TZ=Asia/Shanghai