#!/bin/bash -eux

# nginx is used as the front-end web server
sudo yum install -y nginx

sudo mv /tmp/nginx.conf /etc/nginx/nginx.conf
sudo chown root:root /etc/nginx/nginx.conf

# Start nginx on boot
sudo chkconfig nginx on
