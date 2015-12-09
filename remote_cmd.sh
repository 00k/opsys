#!/bin/bash

if [ $# -lt 1 ];
then
    echo "usage: remote_cmd.sh cmd [args ...]"
    exit
fi

source host.sh

for ((i=0; i<HOST_NUM; i++)); do
    ssh -o StrictHostKeyChecking=no ${HOST[$i]} "cd ~ && $*"
done
