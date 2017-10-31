#!/bin/bash -eux

# Create bin directory
mkdir -p bin

# Make rabbit_util executable and relocate to directory on path
chmod +x rabbit_util
mv rabbit_util bin/

# Install python packages needed for rabbit_util
pip install docopt pika
