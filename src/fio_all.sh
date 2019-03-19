#!/bin/bash

HOME_DIR=$(cd $(dirname $0);pwd)
LOG_DETAIL=$HOME_DIR"/fio_detail.log"
LOG_SIMPLE=""
DEV_NAME=""

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
rw=("read" "write" "randread" "randwrite" "rw")
numjob=(1 8 16 32 64)
iodepth=(1 4 8 16 32 64 128 265)

count=0
for b in ${bs[@]}; do
    for ro in ${rw[@]}; do
		for n in ${numjob[@]}; do
			for d in ${iodepth[@]}; do
				run_name=$b"-"$ro"-"$n"-"$d 
                echo -n $count "bs-rw-numjob-iodepth" $run_name " "
                echo -n $count "bs-rw-numjob-iodepth" $run_name " ">> $LOG_SIMPLE
				echo $count "bs-rw-numjob-iodepth" $run_name " " "-----------------------------------------------------" >> $LOG_DETAIL
				result=$(fio --ramp_time=5 \
					--runtime=15 \
					--size=20g \
					--ioengine=libaio \
					--filename=/dev/sdb \
			       	--name=$run_name \
					--numjobs=$n \
					--iodepth=$d \
					--rw=$ro \
					--bs=$b \
					--direct=1 \
                    --group_report)
                wait
                echo "$result" >> $LOG_DETAIL
                iops_bandwith=$(echo "$result" | grep "IOPS=")
                iops=$(echo $iops_bandwith | awk '{print $2}'|awk -F '[=,]' '{print $2}')
                bandwith=$(echo $iops_bandwith | awk -F '[()]' '{print $2}')
                lat_avg=$(echo "$result" | grep "\ lat.*avg"| awk -F, '{print $3}'|awk -F= '{print $2}')
                cpu=$(echo "$result" | grep cpu |awk -F '[:,]' '{print $2 $3}')
                echo $iops " " $bandwith " " $lat_avg " " $cpu " "
                echo $iops " " $bandwith " " $lat_avg " " $cpu " " >> $LOG_SIMPLE
                echo "" >> $LOG_DETAIL
                (( count++ ))
			done
		done
	done
done

