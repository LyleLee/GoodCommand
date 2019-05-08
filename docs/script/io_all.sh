#!/bin/bash

#config here you disk you want to run fio

#config disk to run fio
DISK="/dev/sdd"

#configure runtime
RUN_TIME=60

#查询硬盘是否是否存在
if [ ! -e "${DISK}" ]; then
	echo "${DISK} disk not exists, script exit"
	exit
fi

#查询硬盘是否挂载，挂载则不执行fio
if [ "$(grep "${DISK}" /proc/mounts)" ] ; then
	echo -e "your device:$DISK is mounted: \n$(grep "${DISK}" /proc/mounts) \nscript exit!"
	exit
fi

echo "Disk you want to test is $DISK each runtime $RUN_TIME"

SDX="${DISK##*/}" #get sdc. delete charactor from left to right until meet /
CPU_NAME="$(sudo dmidecode -s processor-version | uniq)"

HOME_DIR=$(cd "$(dirname "$0")" || exit ;pwd)

#设置CPU型号的命名
if [ "$CPU_NAME" ]; then
	LOG_DETAIL="${HOME_DIR}/${CPU_NAME}_$(uname -m)_${SDX}_fio_detail.txt"
	LOG_SIMPLE="${HOME_DIR}/${CPU_NAME}_$(uname -m)_${SDX}_fio_simple.txt"
else
	LOG_DETAIL="${HOME_DIR}/$(uname -m)_${SDX}_fio_detail.txt"
	LOG_SIMPLE="${HOME_DIR}/$(uname -m)_${SDX}_fio_simple.txt"
fi

if [ -e "$LOG_DETAIL" ]; then
	echo "" > "$LOG_DETAIL"
fi

if [ -e "$LOG_SIMPLE" ]; then
	echo "" > "$LOG_SIMPLE"
fi

bs=(4k 8k 1m 4m)
rw=("read" "write" "randread" "randwrite")
numjob=(1 8 16 32 64)
iodepth=(1 8 16 32 64 128 256)

count=0

printf "number  block_size read_write  numjobs   iodepth        " | tee -a "${LOG_SIMPLE}"
if [ "$(uname -m)" = "aarch64" ]; then
	 printf "numactl configuration if there are any    " | tee -a "${LOG_SIMPLE}"
fi
printf "IOPS     bandwith     latency    cpu_user  cpu_sys\n"| tee -a "${LOG_SIMPLE}"


for b in "${bs[@]}"; do
    for ro in "${rw[@]}"; do
		for n in "${numjob[@]}"; do
			for d in "${iodepth[@]}"; do
                printf "%d\t %s\t %-10s\t %s\t %d\t " "${count}" "${b}" "${ro}" "${n}" "${d}" | tee -a "$LOG_SIMPLE" -a "$LOG_DETAIL" #输出到屏幕同时到文件
				echo " -----------------------------------------------------" >> "$LOG_DETAIL"
                
                if [ "$(uname -m)" = "aarch64" ]; then
                    numa="numactl -C 0-"$(( $n-1 ))" -m 0 "
                    printf "%s\t" "$numa" | tee -a "$LOG_SIMPLE"
                else
                    numa=""
                fi
                result=$(${numa} fio --ramp_time=5 --runtime="$RUN_TIME" --ioengine=libaio --filename=$DISK --name="$count-$b-$ro-$n-$d" --bs="$b" \
                        --rw="$ro" \
                        --numjobs="$n" \
                        --iodepth="$d" \
                        --direct=1 \
                        --group_report)
                while [ "$(pgrep fio)" ]; do
                    echo "need to sleep a while when fio is running"
                    sleep 5
                done
                echo "$result" >> "$LOG_DETAIL"
                iops_bandwith=$(echo "$result" | grep "IOPS=")
                iops=$(echo "$iops_bandwith" | awk '{print $2}'|awk -F '[=,]' '{print $2}')
                bandwith=$(echo "$iops_bandwith" | awk -F '[()]' '{print $2}')
                lat=$(echo "$result" | grep "\ lat.*avg"| awk -F, '{print $3}'|awk -F= '{print $2}')
                cpu_user=$(echo "$result" | grep cpu |awk -F '[:,=]' '{print $3}')
                cpu_sys=$(echo "$result" | grep cpu |awk -F '[:,=]' '{print $5}')
                printf "%s\t %s\t %-10s\t %s\t %s\t\n" "$iops" "$bandwith" "$lat" "$cpu_user" "$cpu_sys" | tee -a "$LOG_SIMPLE"
                echo "" >> "$LOG_DETAIL"
                (( count++ ))
			done
		done
	done
done

