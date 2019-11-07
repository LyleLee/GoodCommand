#!/bin/bash
HOME_DIR=$(cd $(dirname $0);pwd)
hardware_software_conf=$HOME_DIR"/out_hardware_software_conf.txt"

echo "export system hardware and software configuration"

if [ -e "hardware_software_conf" ];then
    echo "" > $hardware_software_conf
fi

echo "lscpu" | tee -a $hardware_software_conf
lscpu >> $hardware_software_conf
wait
printf "\n\n****************\n" | tee -a $hardware_software_conf


echo "lsblk" | tee -a $hardware_software_conf
lsblk >> $hardware_software_conf
wait
printf "\n\n****************\n" | tee -a $hardware_software_conf

echo "free -g" | tee -a $hardware_software_conf
free -g >> $hardware_software_conf
wait
printf "\n\n****************\n" | tee -a $hardware_software_conf

echo "df" | tee -a $hardware_software_conf
df -h >> $hardware_software_conf
wait
printf "\n\n****************\n" | tee -a $hardware_software_conf

echo "smartctl" | tee -a $hardware_software_conf
for disk in {a..l};do
    if [ -b "/dev/sd${disk}" ];then
        echo "/dev/sd${disk}"
        echo "smartctl -a /dev/sd${disk}" | tee -a $hardware_software_conf
        smartctl -a "/dev/sd${disk}" >> $hardware_software_conf
        wait
    fi
done
printf "\n\n****************\n" | tee -a $hardware_software_conf

echo "ip a" | tee -a $hardware_software_conf
ip a >> $hardware_software_conf
wait
printf "\n\n****************\n" | tee -a $hardware_software_conf

echo "lspci" | tee -a $hardware_software_conf
lspci -tv >> $hardware_software_conf
printf "\n\n****************\n" | tee -a $hardware_software_conf

echo "dmidecode" | tee -a $hardware_software_conf
typ=("bios" "system" "baseboard" "chassis" "processor" "memory" "cache" "connector" "slot")
for t in "${typ[@]}" ; do
    printf "dmidecode -t %s \n" $t |tee -a $hardware_software_conf
    dmidecode -t $t >> $hardware_software_conf
    wait
done
printf "\n\n****************\n" | tee -a $hardware_software_conf

echo "cat /proc/cupinfo" | tee -a $hardware_software_conf
cat /proc/cpuinfo >> $hardware_software_conf
printf "\n\n****************\n" | tee -a $hardware_software_conf

echo "cat /proc/meminfo" | tee -a $hardware_software_conf
cat /proc/meminfo >> $hardware_software_conf
printf "\n\n****************\n" | tee -a $hardware_software_conf

echo "lshw" | tee -a $hardware_software_conf
lshw >> $hardware_software_conf
printf "\n\n****************\n" | tee -a $hardware_software_conf

echo "ls /sys/class/net/ -la" | tee -a $hardware_software_conf
ls /sys/class/net/ -la >> $hardware_software_conf
printf "\n\n****************\n" | tee -a $hardware_software_conf