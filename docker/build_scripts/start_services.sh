#!/bin/bash -eux

service rabbitmq-server start
rm -rf /var/lib/pgsql/9.4/data/
service postgresql-9.4 initdb
service postgresql-9.4 start