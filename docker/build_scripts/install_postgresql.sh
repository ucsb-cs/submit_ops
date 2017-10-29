#!/bin/bash -eux

curl -o /tmp/pgdg.rpm http://download.postgresql.org/pub/repos/yum/9.4/redhat/rhel-6-x86_64/pgdg-centos94-9.4-3.noarch.rpm

# Install the RPM

ls -l /tmp
rpm -ivh /tmp/pgdg.rpm

# postgres is used as the relational database
yum install -y postgresql94-server

service postgresql-9.4 initdb
service postgresql-9.4 start

# Create the submit postgres user and submit database
su postgres -c "createuser submit"
su postgres -c "createdb submit"

# Start postgresql on boot
chkconfig postgresql-9.4 on
