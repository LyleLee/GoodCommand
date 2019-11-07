#~/bin/bash
HOME_DIR=$(cd $(dirname $0);pwd)
dump_file=$HOME_DIR"/dump_file.txt"

if [ -e "$dump_file" ];then
    echo "" > $dump_file
fi

dmesg -C 
echo "0" > /proc/sys/kernel/sysrq

for (( ; ; ));do
    echo "Will dump a list of current tasks and their information to your console." |tee -a $dump_file
    echo t > /proc/sysrq-trigger
    dmesg -T >> $dump_file
    wait
    echo -e "\n\n-------------------------------------------------------\n" >> $dump_file
    dmesg -C
    
    
    echo "Shows a stack backtrace for all active CPUs." |tee -a $dump_file
    echo l > /proc/sysrq-trigger
    dmesg -T >> $dump_file
    wait
    echo -e "\n\n-------------------------------------------------------\n" >> $dump_file
    dmesg -C
    
    echo "Dumps tasks that are in uninterruptable (blocked) state." |tee -a $dump_file
    echo w > /proc/sysrq-trigger
    dmesg -T >> $dump_file
    wait
    echo -e "\n\n-------------------------------------------------------\n" >> $dump_file
    dmesg -C
    
    sleep 1m
done