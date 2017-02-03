#!/bin/bash -eux

# postgres is used as the relational database
sudo yum install -y postgresql94-server

sudo service postgresql94 initdb
sudo service postgresql94 start

# Create the submit postgres user and submit database
sudo -iu postgres createuser submit
sudo -iu postgres createdb submit

# Start postgresql on boot
sudo chkconfig postgresql94 on
