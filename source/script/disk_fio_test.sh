#!/bin/bash


#config disk to run fio
DISK="$1"

#configure runtime
RUN_TIME=60

#查询硬盘是否是否存在
if [ ! -e "${DISK}" ]; then
	echo "${DISK} disk not exists, script exit"
	exit
fi

#查询硬盘是否挂载，挂载则不执行fio
if [ "$(grep "${DISK}" /proc/mounts)" ] ; then
	echo -e "your device:$DISK is mounted: \n$(grep "${DISK}" /proc/mounts) \n script exit!"
	exit
fi
echo "Disk you want to test is $DISK runtime $RUN_TIME"

SDX="${DISK##*/}" #get sdc. delete charactor from left to right until meet /
host_ip=$(ip a | grep -E "inet [0-9]*.[0-9]*.[0-9]*.[0-9]*/24"|head -1| awk '{print $2}' |awk -F '/' '{print $1}')
dir_name=${host_ip//\./e}


if [ -e "$dir_name" ] ; then
    rm "$dir_name" -rf
fi
mkdir "$dir_name"

for bs in 4k 256k 4m; do 
    for rw in read randread write randwrite; do
        for numjob in 1 8 16 32 64; do
            for iodepth in 1 8 16 32 64 128 256; do
            	fio	-runtime=600 	\
                    --parse-only    \
                    -size=100% 		\
                    -bs="$bs"		\
                    -rw="$rw" 	\
                    -ioengine=libaio \
                    -direct=1 		\
                    -iodepth="${iodepth}" 	\
                    -numjobs="${numjob}"	\
                    --filename="$DISK"        \
                    --output-format=json	\
                    --output="${dir_name}/${dir_name}-${SDX}-${bs}-${rw}-iodepth${iodepth}-numjob${numjob}-$(date "+%H%M")".json \
                    -name="${dir_name}-${SDX}-${bs}-${rw}-iodepth${iodepth}-numjob${numjob}-$(date "+%H%M")"
            done
        done
    done
done
