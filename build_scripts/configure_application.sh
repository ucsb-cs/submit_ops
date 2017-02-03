#!/bin/bash -eux

# Home directory must be readable by other users
chmod 755 $HOME

# Files directory must be owned by submit user
mkdir -p files
sudo chown submit:submit files

# Create bin directory
mkdir -p bin

# Set secrets in submit.ini
auth_secret=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 64 ; echo '')
cookie_secret=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 64 ; echo '')
sed -i s/{{auth_secret}}/$auth_secret/ submit.ini
sed -i s/{{cookie_secret}}/$cookie_secret/ submit.ini

# Make update_submit executable and relocate to directory on path
chmod +x update_submit
mv update_submit bin/

# Run update_submit to fetch the application and start it for the first time
bin/update_submit

# Prepare the application's database
sudo -u submit bash -lc 'source /home/ec2-user/venv/bin/activate; echo "from submit import models; models.create_schema()" | pshell /home/ec2-user/submit.ini'
