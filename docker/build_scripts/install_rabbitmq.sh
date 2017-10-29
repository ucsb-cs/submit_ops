#!/bin/bash -eux

yum install -y wget

yum -y install initscripts
yum -y install logrotate

cd /etc/yum.repos.d
wget --no-cache http://www.convirture.com/repos/definitions/rhel/6.x/convirt.repo

# socat is required for rabbitmq
yum install -y socat

# recent erlang version is required for rabbitmq
cd /tmp
wget https://github.com/rabbitmq/erlang-rpm/releases/download/v1.3.2/erlang-18.3.4-5.el6.x86_64.rpm
rpm -i erlang-18.3.4-5.el6.x86_64.rpm

# install rabbitmq
wget https://github.com/rabbitmq/rabbitmq-server/releases/download/rabbitmq_v3_6_6/rabbitmq-server-3.6.6-1.el6.noarch.rpm
rpm -i rabbitmq-server-3.6.6-1.el6.noarch.rpm

service rabbitmq-server start

# cleanup
rm -f *.rpm

# Start rabbitmq-server on boot
chkconfig rabbitmq-server on
