#!/bin/bash -eux

# Create bin directory
mkdir -p bin

# Make rabbit_util executable and relocate to directory on path
chmod +x rabbit_util
mv rabbit_util bin/
