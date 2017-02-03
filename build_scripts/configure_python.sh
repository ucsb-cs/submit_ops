#!/bin/bash -eux

# install tools necessary for python packages to build
sudo yum install -y gcc-c++ openldap-devel postgresql94-devel

# prepare the python virtualenv to be used
sudo pip install --upgrade pip
sudo /usr/local/bin/pip install --upgrade virtualenv
