#!/bin/bash
HOME_DIR=$(cd $(dirname $0);pwd)
hardware_software_conf=$HOME_DIR"/hardware_software_conf.txt"

echo "export system hardware and software configuration"

if[ -e "$LOG_DETAIL" ];then
    rm $LOG_DETAIL

echo "lscpu" | tee -a $hardware_software_conf
lscpu >> $hardware_software_conf

echo "dmidecode" | tee -a $hardware_software_conf
var type=(bios
system
baseboard
chassis
processor
memory
cache
connector
slot)

for t in $type ; do
    dmidecode -t $t >> $hardware_software_conf
done



