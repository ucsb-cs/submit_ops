#!/bin/bash -eux

# The submit user has permission to the database
adduser submit --home /tmp

# Add ec2-user
adduser ec2-user

# Create the submit postgres user and submit database
# TODO: Execute these lines on the postgres container
su postgres -c "createuser submit"
su postgres -c "createdb submit"

# Generate worker users

# Generate SSH key
ssh-keygen -f ssh_rsa -N ""

# The submit user must own the key in order to use it
chown submit:submit ssh_rsa

for worker in worker1 worker2; do
    # Create user
    adduser $worker

    # Create .ssh/authorized_keys file
    su $worker -c 'mkdir .ssh'
    su $worker -c 'chmod 700 .ssh'
    cat ssh_rsa.pub | su $worker -c 'tee -a .ssh/authorized_keys'
    su $worker -c 'chmod 600 .ssh/authorized_keys'
done

# Remove the public key as it's no longer needed
rm ssh_rsa.pub
