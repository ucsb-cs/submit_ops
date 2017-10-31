#!/bin/bash -eux

# install tools necessary for python packages to build
yum -y install gcc-c++ openldap-devel postgresql94-devel

yum -y install python-pip

# prepare the python virtualenv to be used
pip install --upgrade pip
pip install --upgrade virtualenv
