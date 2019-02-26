#!/bin/bash

psql -c 'create role replica login replication encrypted password \'replica\'; '