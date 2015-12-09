#!/bin/bash

echo "begin to optimize sys"
echo noop > /sys/block/sdg/queue/scheduler
echo noop > /sys/block/sdh/queue/scheduler
echo 0 > /sys/block/sdg/queue/read_ahead_kb
echo 0 > /sys/block/sdh/queue/read_ahead_kb
echo 0 > /proc/sys/vm/check_lumpy_condition
sh /root/set_irq_affinity.sh xgbe0
echo "end of optimize sys"

