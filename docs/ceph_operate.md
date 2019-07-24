
# 删除pool
```
ceph osd pool delete images images --yes-i-really-really-mean-it
ceph osd pool delete volumes volumes --yes-i-really-really-mean-it
```
# 删除HDD OSD

在每个节点上执行，停止OSD进程
```
systemctl stop ceph-osd.target
```
然后执行删除
```
for i in {0..95}; do
	ceph osd down osd.$i
	ceph osd out osd.$i
	ceph osd crush remove osd.$i
	ceph auth del osd.$i
	ceph osd rm osd.$i
done
```

# 格式化SSD
```
parted /dev/nvme1n1 -s mklabel gpt
parted /dev/nvme0n1 -s mklabel gpt
```

# 创建OSD
```
ceph-deploy osd create --data /dev/nvme0n1 ceph-node00
ceph-deploy osd create --data /dev/nvme1n1 ceph-node00
```

# 创建 pool
```
[root@ceph-node00 ~]# ceph osd pool create volumes 4096 4096
Error ERANGE:  pg_num 4096 size 3 would mean 12288 total pgs, which exceeds max 4000 (mon_m                                                      ax_pg_per_osd 250 * num_in_osds 16)
[root@ceph-node00 ~]# ceph osd pool create volumes 512 512
```


# 创建rbd
一共创建50个rbd
```
for i in {01..50};do
	rbd create --size 100G volumes/test-$i
done
```

# 写满rbd数据
```
pdsh -w ^dell.txt "cd /root/rbd_test;. fill_nvm2_data.sh"
```

查看rbd的容量
```
for index in {01..50};do
	rbd du volumes/test-$index
done
```


# 收集数据

for host in `cat ../dell.txt`; do scp -r root@${host}:/root/rbd_test/192* ./;done

# 分发脚本
for host in `cat dell.txt`; do scp do_fio.sh  root@${host}:/root/rbd_test/; done
for host in `cat dell.txt`; do scp rmhostname.sh  root@${host}:/root/rbd_test/; done

# 重启进入bios
for host in `cat BMC_arm.txt`; do ipmitool -I lanplus -H ${host} -U Administrator -P Admin@9000 chassis bootdev bios; wait ;done


# 仅仅测试读


# 执行单个测试
```
fio315 -runtime=120 	\
		-size=100% 	\
		-bs=4k		\
		-rw=read 	\
		-ioengine=rbd 	\
		-direct=1 		\
		-iodepth=32 	\
		-numjobs=1	\
		-clientname=admin \
		-pool=volumes 	\
		-ramp_time=10 	\
		-rbdname=test-13 \
		--output="$(date "+%Y-%m-%d-%H%M")".json \
		-name="$(date "+%Y-%m-%d-%H%M")".json
		
```


# 统计json文件

py /home/monitor/test_script/parase_fio.py ./


# 禁用 osd
systemctl | grep ceph-osd | grep fail | awk '{print $2}'                           
systemctl | grep ceph-osd | grep fail | awk '{print $2}' | xargs systemctl disable 
systemctl | grep ceph-osd | grep fail | awk '{print $2}' | xargs systemctl status 

# ceph绑核
可以先用taskset -acp 0-23 {osd-pid} 看看对性能帮助有多大。如果有帮助，再调整ceph参数配置

绑定node2
for osd_pid in $(pgrep ceph-osd); do taskset -acp 48-71 $osd_pid ;done

for osd_pid in $(pgrep ceph-osd); do ps -o thcount $osd_pid ;done

