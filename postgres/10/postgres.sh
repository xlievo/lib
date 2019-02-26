COPY zombodb_jessie_pg10-10-1.0.3_amd64.deb /
RUN dpkg -i zombodb_jessie_pg10-10-1.0.3_amd64.deb \
  && rm -f zombodb_jessie_pg10-10-1.0.3_amd64.deb

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV CONF /usr/share/postgresql/postgresql.conf.sample

RUN sed -i 's/^#log_destination = '\''stderr'\''/log_destination = '\''stderr'\''/g' $CONF \
 && sed -i 's/^#logging_collector = off/logging_collector = on/g' $CONF \
 && sed -i 's/^#log_directory = '\''log'\''/log_directory = '\''log'\''/g' $CONF \
 && sed -i 's/^#log_filename/log_filename/g' $CONF \
 && sed -i 's/^#log_rotation_age = 1d/log_rotation_age = 1d/g' $CONF \
 && sed -i 's/^#log_rotation_size = 10MB/log_rotation_size = 100MB/g' $CONF \
 && sed -i 's/^#log_error_verbosity = default/log_error_verbosity = verbose/g' $CONF \
 && sed -i 's/^#log_statement = '\''none'\''/log_statement = '\''mod'\''/g' $CONF \
 && sed -i 's/^#log_lock_waits = off/log_lock_waits = on/g' $CONF \
 && sed -i 's/^#log_min_duration_statement = -1/log_min_duration_statement = 1000/g' $CONF \
 && sed -i 's/^#log_checkpoints = off/log_checkpoints = on/g' $CONF \
 && sed -i 's/^#log_duration = off/log_duration = on/g' $CONF \
 && sed -i 's/^#log_min_messages = warning/log_min_messages = warning/g' $CONF \
 && sed -i 's/^#log_min_error_statement = error/log_min_error_statement = error/g' $CONF \
 && sed -i 's/^#log_line_prefix = '\''%m \[%p\] '\''/log_line_prefix = '\''%m \[%p\] %q%u@%d '\''/g' $CONF