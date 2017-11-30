#!/bin/bash -eux

# The submit user has permission to the database

adduser submit

# Generate worker users

# Generate SSH key
ssh-keygen -f ssh_rsa -N ""

# The submit user must own the key in order to use it
chown submit:submit ssh_rsa
mv ssh_rsa /home/submit/
# TODO: move user creation to submit_worker
# TODO: figure out how to distribute the keys

for worker in worker1 worker2; do
    # Create user
    adduser $worker

    # Create .ssh/authorized_keys file
    su -l $worker -c 'mkdir ${HOME}/.ssh'
    su -l $worker -c 'chmod 700 ${HOME}/.ssh'
    cat ssh_rsa.pub | su $worker -c 'tee -a ${HOME}/.ssh/authorized_keys'
    su -l $worker -c 'chmod 600 ${HOME}/.ssh/authorized_keys'
done

# Remove the public key as it's no longer needed
rm ssh_rsa.pub
