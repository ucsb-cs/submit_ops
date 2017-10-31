#!/bin/bash -eux

# nginx is used as the front-end web server

yum install -y nginx

mv /tmp/nginx.conf /etc/nginx/nginx.conf
chown root:root /etc/nginx/nginx.conf

# Start nginx on boot
chkconfig nginx on
