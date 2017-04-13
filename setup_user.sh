#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: setup_user.sh \$username"
    exit 1
fi

username=$1

source host.sh

echo "add user ..."
for ((i=0; i<HOST_NUM; i++)); do
    ssh -o StrictHostKeyChecking=no ${HOST[$i]} "rm -fr /home/$username/.ssh/*"
    ssh -o StrictHostKeyChecking=no ${HOST[$i]} "/usr/sbin/useradd $username; sudo -u $username ssh-keygen -t rsa  -N '' -f /home/$username/.ssh/id_rsa"
done

cat /home/$username/.ssh/id_rsa.pub > /home/$username/.ssh/authorized_keys
chown $username:$username /home/$username/.ssh/authorized_keys

echo "setup trust"
for ((i=1; i<HOST_NUM; i++)); do
    scp /home/$username/.ssh/id_rsa.pub /home/$username/.ssh/id_rsa /home/$username/.ssh/authorized_keys ${HOST[$i]}:/home/$username/.ssh/
    ssh -o StrictHostKeyChecking=no ${HOST[$i]} "chown $username:$username /home/$username/.ssh/id_rsa.pub /home/$username/.ssh/id_rsa /home/$username/.ssh/authorized_keys"
done

echo "done"
