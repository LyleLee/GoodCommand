#~/bin/bash
HOME_DIR=$(cd $(dirname $0);pwd)
sysrq_file=$HOME_DIR"/sysrq_value.txt"
register_file=$HOME_DIR"/register_value.txt"

if [ -e "$sysrq_file" ];then
    echo "" > $sysrq_file
fi

if [ -e "$register_file" ];then
    echo "" >$register_file
fi

dmesg -C 

echo "0" > /proc/sys/kernel/sysrq
echo "0" > /proc/sys/kernel/softlockup_panic 


for (( ; ; ));do

    echo "Dumps tasks that are in uninterruptable (blocked) state." |tee -a $sysrq_file
    echo w > /proc/sysrq-trigger
    dmesg -T >> $sysrq_file
    wait
    echo -e "\n\n-------------------------------------------------------\n" >> $sysrq_file
    dmesg -C
    
    
    #chip0
    #L3D
    {devmem 0x90141030 32
    devmem 0x90151030 32 
    devmem 0x90161030 32 
    devmem 0x90171030 32
    #L3T
    devmem 0x90181030 32
    devmem 0x90191030 32
    devmem 0x901a1030 32
    devmem 0x901b1030 32
    devmem 0x901c1030 32
    devmem 0x901d1030 32
    devmem 0x901e1030 32
    devmem 0x901f1030 32
    #HHA
    devmem 0x90121000 32
    devmem 0x90121000 32
    #MN
    devmem 0x90331030 32
    #L3D
    devmem 0x98141030 32
    devmem 0x98151030 32
    devmem 0x98161030 32
    devmem 0x98171030 32
    #L3T
    devmem 0x98181030 32
    devmem 0x98191030 32
    devmem 0x981a1030 32
    devmem 0x981b1030 32
    devmem 0x981c1030 32
    devmem 0x981d1030 32
    devmem 0x981e1030 32
    devmem 0x981f1030 32
    #HHA
    devmem 0x98121000 32
    devmem 0x98121000 32
    #MN
    devmem 0x98331030 32
    #chip1
    #L3D
    devmem 0x400090141030 32
    devmem 0x400090151030 32
    devmem 0x400090161030 32
    devmem 0x400090171030 32
    #L3T
    devmem 0x400090181030 32
    devmem 0x400090191030 32
    devmem 0x4000901a1030 32
    devmem 0x4000901b1030 32
    devmem 0x4000901c1030 32
    devmem 0x4000901d1030 32
    devmem 0x4000901e1030 32
    devmem 0x4000901f1030 32
    #HHA
    devmem 0x400090121000 32
    devmem 0x400090121000 32
    #MN
    devmem 0x400090331030 32
    #L3D
    devmem 0x400098141030 32
    devmem 0x400098151030 32
    devmem 0x400098161030 32
    devmem 0x400098171030 32
    #L3T
    devmem 0x400098181030 32
    devmem 0x400098191030 32
    devmem 0x4000981a1030 32
    devmem 0x4000981b1030 32
    devmem 0x4000981c1030 32
    devmem 0x4000981d1030 32
    devmem 0x4000981e1030 32
    devmem 0x4000981f1030 32
    #HHA
    devmem 0x400098121000 32
    devmem 0x400098121000 32
    #MN
    devmem 0x400098331030 32} >> $register_file
    
    sleep 5s
done
