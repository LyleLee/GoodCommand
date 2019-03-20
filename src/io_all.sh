#!/bin/bash

HOME_DIR=$(cd $(dirname $0);pwd)
LOG_DETAIL=$HOME_DIR"/fio_detail.log"
LOG_SIMPLE=""
DEV_NAME=""
INDICATE="bs-rw-numjob-iodepth"
if [ $(uname -m) = "x86_64" ]; then
    LOG_DETAIL=$HOME_DIR"/x86_fio_detail.log"
    LOG_SIMPLE=$HOME_DIR"/x86_fio_simple.log"
    DEV_NAME="/dev/sdb"
    echo "x86_86 set $DEV_NAME"
    
elif [ $(uname -m) = "aarch64" ]; then
    LOG_DETAIL=$HOME_DIR"/arm_fio_detail.log"
    LOG_SIMPLE=$HOME_DIR"/arm_fio_simple.log"
    DEV_NAME="/dev/sdc"
    echo "aarch64 set $DEV_NAME"
else
    echo "unrecognize system when using uname -m"
    exit
fi


if [ -e $LOG_DETAIL ]; then
	rm $LOG_DETAIL
fi

if [ -e $LOG_SIMPLE ]; then
	rm $LOG_SIMPLE
fi

bs=(4k 8k 1m 4m)
rw=("read" "write" "randread" "randwrite")
numjob=(1 8 16 32 64)
iodepth=(1)

count=0
for b in ${bs[@]}; do
    for ro in ${rw[@]}; do
		for n in ${numjob[@]}; do
			for d in ${iodepth[@]}; do
				run_name=$b"-"$ro"-"$n"-"$d 
                printf "%3d\t %20s\t %20s\t " $count $INDICATE $run_name
                printf "%3d\t %20s\t %20s\t " $count $INDICATE $run_name >> $LOG_SIMPLE
				echo $count $INDICATE $run_name " -----------------------------------------------------" >> $LOG_DETAIL
				result=$(fio --ramp_time=5 \
					--runtime=60 \
					--ioengine=libaio \
					--filename=/dev/sdb \
			       	--name=$run_name \
					--numjobs=$n \
					--iodepth=$d \
					--rw=$ro \
					--bs=$b \
					--direct=1 \
                    --group_report)
                while [ $(pgrep fio) ]; do
                    echo "need to sleep a while when fio is running"
                    sleep 5
                done
                echo "$result" >> $LOG_DETAIL
                iops_bandwith=$(echo "$result" | grep "IOPS=")
                iops=$(echo "$iops_bandwith" | awk '{print $2}'|awk -F '[=,]' '{print $2}')
                bandwith=$(echo "$iops_bandwith" | awk -F '[()]' '{print $2}')
                lat=$(echo "$result" | grep "\ lat.*avg"| awk -F, '{print $3}'|awk -F= '{print $2}')
                cpu_user=$(echo "$result" | grep cpu |awk -F '[:,=]' '{print $3}')
                cpu_sys=$(echo "$result" | grep cpu |awk -F '[:,=]' '{print $5}')
                printf "%-6s\t %-10s\t %-10s\t %-5s\t %-5s\t\n" $iops $bandwith $lat_avg $cpu_user $cpu_sys
                printf "%-6s\t %-10s\t %-10s\t %-5s\t %-5s\t\n" $iops $bandwith $lat_avg $cpu_user $cpu_sys >> $LOG_SIMPLE
                echo "" >> $LOG_DETAIL
                (( count++ ))                  
			done
		done
	done
done

