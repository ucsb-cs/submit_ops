#!/bin/bash -eux

BIN_DIR=/home/submit/bin

# Create bin directory
mkdir -p ${BIN_DIR}

# Make rabbit_util executable and relocate to directory on path

cp /tmp/rabbit_util ${BIN_DIR} 
chmod +x ${BIN_DIR}/rabbit_util
