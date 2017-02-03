#!/bin/bash -eux

# socat is required for rabbitmq
sudo yum install -y socat

# recent erlang version is required for rabbitmq
cd /tmp
wget https://github.com/rabbitmq/erlang-rpm/releases/download/v1.3.2/erlang-18.3.4-5.el6.x86_64.rpm
sudo rpm -i erlang-18.3.4-5.el6.x86_64.rpm

# install rabbitmq
wget https://github.com/rabbitmq/rabbitmq-server/releases/download/rabbitmq_v3_6_6/rabbitmq-server-3.6.6-1.el6.noarch.rpm
sudo rpm -i rabbitmq-server-3.6.6-1.el6.noarch.rpm

sudo service rabbitmq-server start

# cleanup
rm -f *.rpm

# Start rabbitmq-server on boot
sudo chkconfig rabbitmq-server on
