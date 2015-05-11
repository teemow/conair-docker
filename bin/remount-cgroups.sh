#!/bin/bash

set -eu

READONLY_CGROUPS=$(mount |grep ^cgroup |grep -v systemd |grep ro,nosuid|awk '{print $3}'|sed -e 's/\/sys\/fs\/cgroup\///g')

for i in $READONLY_CGROUPS
do 
    umount /sys/fs/cgroup/$i
    mount -t cgroup -o $i none /sys/fs/cgroup/$i
done
