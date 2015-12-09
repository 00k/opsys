#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: setup_user.sh \$username"
    exit 1
fi

username=$1

source host.sh

echo "add user ..."
for ((i=0; i<HOST_NUM; i++)); do
    ssh -o StrictHostKeyChecking=no ${HOST[$i]} "/usr/sbin/useradd $username; sudo -u $username ssh-keygen -t rsa  -N '' -f /home/$username/.ssh/id_rsa"
done

echo "setup trust"
for ((i=0; i<HOST_NUM; i++)); do
    cat /home/$username/.ssh/id_rsa.pub | ssh -o StrictHostKeyChecking=no ${HOST[$i]} "sudo -u $username cat - >> /home/$username/.ssh/authorized_keys"
done

echo "done"
