#!/bin/bash -eux

# install tools necessary for python packages to build
yum install -y gcc-c++ openldap-devel postgresql94-devel

# prepare the python virtualenv to be used
pip install --upgrade pip
/usr/local/bin/pip install --upgrade virtualenv
