#!/bin/bash

# 获取设备上的所有网络接口，可以用户批量设置参数等

ip_interface=$(ip link | grep '^[[:digit:]]' |grep "UP" | awk -F ':' '{printf "%s\n", $2}')

for link in ${ip_interface[@]}; do
    echo "$link"
    #ethtool -l "$link"
done