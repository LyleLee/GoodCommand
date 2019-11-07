#!/bin/bash

# 获取设备上的所有网络接口，可以用户批量设置参数等

ip_interface=$(ip link | grep '^[[:digit:]]' | awk -F ':' '{printf "%s\n", $2}')

for link in "${ip_interface[@]}"; do
    echo $link
done