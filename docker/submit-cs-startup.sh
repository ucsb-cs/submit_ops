#!/usr/bin/env bash

BUILD_SCRIPT_PATH=/build_scripts

echo "Starting ssh and nginx"
service sshd start
service nginx start

echo "In $0, about to loop through ${BUILD_SCRIPT_PATH}"

for s in ${BUILD_SCRIPT_PATH}/*; do
    echo "Executing $s"
    $s
    echo "Status code from $s is $?"
done

echo "About to do tail -f /dev/null"
tail -f /dev/null
