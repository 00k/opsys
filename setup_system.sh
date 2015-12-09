#!/bin/bash

source host.sh

for ((i=0; i<HOST_NUM; i++)); do
    scp -o StrictHostKeyChecking=no optimize_sys.sh set_irq_affinity.sh ${HOST[$i]}:~
done

for ((i=0; i<HOST_NUM; i++)); do
    ssh -o StrictHostKeyChecking=no ${HOST[$i]} "sh optimize_sys.sh"
done

echo "done"
