Ceph集群操作
*************************


#新建集群目标：

::

   [root@192e168e100e118 ~]# ceph -s
     cluster:
       id:     6534efb5-b842-40ea-b807-8e94c398c4a9
       health: HEALTH_WARN
               noscrub,nodeep-scrub flag(s) set

     services:
       mon: 5 daemons, quorum ceph-node00,ceph-node01,ceph-node06,ceph-node07,ceph-node02 (age 2w)
       mgr: ceph-node00(active, since 2w)
       osd: 96 osds: 96 up (since 12d), 96 in (since 2w)
            flags noscrub,nodeep-scrub

     data:
       pools:   9 pools, 4096 pgs
       objects: 40.96M objects, 156 TiB
       usage:   491 TiB used, 230 TiB / 721 TiB avail
       pgs:     4096 active+clean

HDD 重测
========

删除pool
--------

::

   ceph osd pool delete images images --yes-i-really-really-mean-it
   ceph osd pool delete volumes volumes --yes-i-really-really-mean-it

删除HDD OSD
-----------

在每个节点上执行，停止OSD进程

::

   systemctl stop ceph-osd.target

在可以对集群进行管理的节点上执行删除

::

   for i in {0..95}; do
       ceph osd down osd.$i
       ceph osd out osd.$i
       ceph osd crush remove osd.$i
       ceph auth del osd.$i
       ceph osd rm osd.$i
   done

在每台ceph节点上取消挂载

::

   umount /var/lib/ceph/osd/ceph-*
   rm -rf /var/lib/ceph/osd/ceph-*

在每台设备上删除ceph上的lvm分区：

方法一

::

   lsblk | grep ceph |awk '{print substr($1,3)}'                           #列出所有的lvm分区
   lsblk | grep ceph |awk '{print substr($1,3)}' | xargs dmsetup remove    #列出所有的lvm分区，并删除

也可以指定删除某一个

::

   dmsetup remove ceph--7c7c2721--5dfc--45e4--9946--5316e21087df-osd--block--92276738--1bbe--4229--a094--761ceda16812

方法二：

::

   lvs | grep osd | awk '{print $2}' | xargs lvremove -y       #先删除lvm
   vgs | grep ceph | awk '{print $1}' | xargs vgremove -y      #再删除lvm group

可以在单台设备上执行上述命令，

::

   root@hadoop00 /h/m/test_script# pdsh -w '^arm.txt' 'lvs | grep osd | awk \'{print $2}\' | xargs lvremove -y'
   root@hadoop00 /h/m/test_script# pdsh -w '^arm.txt' 'vgs | grep ceph | awk \'{print $1}\' | xargs vgremove -y '

传递的命令带有单引号，所以这里加了转义符号。

在每台设备上格式化HDD,SSD（如果有）

::

   for disk in {a..l}
       do parted -s /dev/sd${disk} mklabel gpt
       ceph-volume lvm zap /dev/sd${disk} --destroy 
   done

::

   for ssd_disk in nvme0n1 nvme1n1
       do parted -s /dev/$ssd_disk mklabel gpt
       ceph-volume lvm zap /dev/$ssd_disk --destroy 
   done

在deploy节点上收集key
---------------------

::

   ceph-deploy gatherkeys ceph-node00

::

   for node in {00..07}; do
       ceph-deploy gatherkeys ceph-node${node}
   done

创建 HDD OSD
------------

正常情况下在ceph-deploy节点上执行创建

::

   for node in {00..07}; do
       for disk in {a..l};do
           ceph-deploy osd create --data /dev/sd${disk} ceph-node${node}
           sleep 2
       done
   done

如果需要设置SSD作为wal和db在每个节点上执行

::

   vgcreate ceph-db /dev/nvme0n1
   vgcreate ceph-wal /dev/nvme1n1
   for index in {a..l};do lvcreate -n ceph-db-$index -L 240G ceph-db;lvcreate -n ceph-wal-$index -L 240G ceph-wal;  done

正常情况下在deploy节点上执行

::

   for node in {00..07}; do
       for disk in {a..l};do
           ceph-deploy --overwrite-conf osd create --data /dev/sd${disk} ceph-node${node}
       done
   done

如果需要设置SSD作为wal和db在每个节点上执行

::

   vgcreate ceph-db /dev/nvme0n1
   vgcreate ceph-wal /dev/nvme1n1
   for node in {00..07}; do
       for disk in {a..l};do
           ceph-deploy --overwrite-conf osd create --data /dev/sd${disk} --block-db ceph-db/ceph-db-$disk --block-wal ceph-wal/ceph-wal-$disk ceph-node${node}
       done
   done

创建pool
--------

正常情况下创建pool

::

   ceph osd pool create volumes 4096 4096
   ceph osd pool application enable volumes rbd

如果需要创建EC pool

::

   ceph osd erasure-code-profile set testprofile k=4 m=2   #创建名字为testprofile的profile。 k+m为4+2。允许2个OSD出错。还有其他参数请查询其他文档
   ceph osd erasure-code-profile get testprofile   #查看创建好的profile
   ceph osd crush rule create-erasure test_profile_rule test_profile #根据profile创建crush rule
   ceph osd crush rule ls  #查看所有的rule
   ceph osd crush rule dump test_profile_rule  #查看某条rule的配置

   ceph osd pool create volumes test_profile test_profile_rule
   ceph osd pool set volumes allow_ec_overwrites true
   ceph osd pool application enable volumes rbd

   ceph osd crush rule create-replicated replicated_volumes default host
   ceph osd pool create volumes_replicated_metadata replicated replicated_volumes
   ceph osd pool create volumes_repli_metadata 1024 1024 replicated replicated_volumes
   ceph osd pool application enable volumes_repli_metadata rbd

`reference <https://yanyixing.github.io/2019/03/13/rgw-with-ec/>`__

创建rbd
-------

一共创建400个rbd

::

   for i in {000..399};do rbd create size3/test-$i --size 400G; done

约2分钟 如果是EC池

::

   for i in {000..399};do
       rbd create volumes_repli_metadata/test-$i --size 400G --data-pool volumes;
   done

写入数据
--------

::

   pdcp -w ^dell.txt fill_hdd_data.sh /root/rbd_test/
   pdsh -w ^dell.txt 'cd /root/rbd_test; . fill_hdd_data.sh'

查看rbd容量
-----------

::

   for index in {000..399};do
       rbd du volumes/test-$index
   done

SSD 重测
========

格式化SSD
=========

::

   parted /dev/nvme1n1 -s mklabel gpt
   parted /dev/nvme0n1 -s mklabel gpt

收集key
=======

::

   ceph-deploy gatherkeys

::

   ceph-deploy osd create --data /dev/nvme0n1 ceph-node00
   ceph-deploy osd create --data /dev/nvme1n1 ceph-node00

创建 pool
=========

::

   [root@ceph-node00 ~]# ceph osd pool create volumes 4096 4096
   Error ERANGE:  pg_num 4096 size 3 would mean 12288 total pgs, which exceeds max 4000 (mon_max_pg_per_osd 250 * num_in_osds 16)
   [root@ceph-node00 ~]# ceph osd pool create volumes 512 512

.. _创建rbd-1:

创建rbd
=======

一共创建50个rbd

::

   for i in {01..50};do
       rbd create --size 100G volumes/test-$i
   done

写满rbd数据
===========

::

   pdsh -w ^dell.txt "cd /root/rbd_test;. fill_nvm2_data.sh"

查看rbd的容量

::

   for index in {01..50};do
       rbd du volumes/test-$index
   done

收集数据
========

for host in ``cat ../dell.txt``; do scp -r
root@${host}:/root/rbd_test/192\* ./;done

分发脚本
========

for host in ``cat dell.txt``; do scp do_fio.sh
root@\ :math:`{host}:/root/rbd_test/; done for host in `cat dell.txt`; do scp rmhostname.sh root@`\ {host}:/root/rbd_test/;
done

重启进入bios
============

for host in ``cat BMC_arm.txt``; do ipmitool -I lanplus -H ${host} -U
Administrator -P Admin@9000 chassis bootdev bios; wait ;done

仅仅测试读
==========

执行单个测试
============

::

   fio315 -runtime=120     \
           -size=100%  \
           -bs=4k      \
           -rw=read    \
           -ioengine=rbd   \
           -direct=1       \
           -iodepth=32     \
           -numjobs=1  \
           -clientname=admin \
           -pool=volumes   \
           -ramp_time=10   \
           -rbdname=test-13 \
           --output="$(date "+%Y-%m-%d-%H%M")".json \
           -name="$(date "+%Y-%m-%d-%H%M")".json
           

统计json文件
============

py /home/monitor/test_script/parase_fio.py ./

禁用 osd
========

| systemctl \| grep ceph-osd \| grep fail \| awk ‘{print $2}’
| systemctl \| grep ceph-osd \| grep fail \| awk ‘{print $2}’ \| xargs
  systemctl disable systemctl \| grep ceph-osd \| grep fail \| awk
  ‘{print $2}’ \| xargs systemctl status

ceph绑核
========

可以先用taskset -acp 0-23 {osd-pid}
看看对性能帮助有多大。如果有帮助，再调整ceph参数配置

绑定node2 for osd_pid in $(pgrep ceph-osd); do taskset -acp 48-71
$osd_pid ;done

for osd_pid in $(pgrep ceph-osd); do ps -o thcount $osd_pid ;done

daemon命令查看集群状态
======================

::

   ceph daemon mon.cu-pve04 help       #显示monitor的命令帮助     
   ceph daemon mon.cu-pve04 sessions   #
   ceph daemon osd.0 config show
   ceph daemon osd.0 help              #显示命令帮助
   ceph daemon osd.0 "dump_historic_ops_by_duration" #显示被ops的时间

noscrub 设置
============

::

   ceph used set noscrub       #停止scrub
   ceph osd unset noscrub      #启动scrub

删除lvm分区效果

::

   sdk                                                                                                     8:160  0   7.3T  0 disk
   sdi                                                                                                     8:128  0   7.3T  0 disk
   sdg                                                                                                     8:96   0   7.3T  0 disk
   └─ceph--e59eb57a--ca76--4b1c--94f5--723d83acf023-osd--block--8f205c61--80b5--4251--9fc4--52132f71f378 253:11   0   7.3T  0 lvm
   nvme1n1                                                                                               259:0    0   2.9T  0 disk
   └─ceph--192b4f4b--c3d0--48d2--a7df--1d721c96ad41-osd--block--4f61b14a--0412--4891--90c6--75cad9f68be8 253:2    0   2.9T  0 lvm
   sde                                                                                                     8:64   0   7.3T  0 disk
   └─ceph--ae498ea1--917c--430e--bdf9--cb76720b12cd-osd--block--8d20de06--7b58--48de--90a0--6353cada8c82 253:9    0   7.3T  0 lvm
   sdc                                                                                                     8:32   0   7.3T  0 disk
   └─ceph--69b9fdfb--f6f0--427d--bea8--379bec4a15dc-osd--block--0642e902--89c1--4490--bd9a--e1986c0eb50b 253:7    0   7.3T  0 lvm
   sdl                                                                                                     8:176  0   7.3T  0 disk
   sda                                                                                                     8:0    0   7.3T  0 disk
   └─ceph--f7113ad8--a34e--4bb2--9cb8--8b27f48e7ce1-osd--block--8d67b2c0--1490--4a51--839a--2ea472fb53c8 253:5    0   7.3T  0 lvm
   sdj                                                                                                     8:144  0   7.3T  0 disk
   nvme0n1                                                                                               259:1    0   2.9T  0 disk
   └─ceph--869d506c--83be--4abe--aaf6--70cf7900d5ff-osd--block--fede0b19--429d--4ec5--9c21--352c6b43f1d1 253:3    0   2.9T  0 lvm
   sdh                                                                                                     8:112  0   7.3T  0 disk
   [root@ceph-node03 ~]#
   [root@ceph-node03 ~]#
   [root@ceph-node03 ~]#
   [root@ceph-node03 ~]#
   [root@ceph-node03 ~]# lsblk
   NAME            MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
   sdf               8:80   0   7.3T  0 disk
   sdd               8:48   0   7.3T  0 disk
   sdm               8:192  0 446.1G  0 disk
   ├─sdm3            8:195  0 444.9G  0 part
   │ ├─centos-swap 253:1    0     4G  0 lvm
   │ ├─centos-home 253:4    0 390.9G  0 lvm  /home
   │ └─centos-root 253:0    0    50G  0 lvm  /
   ├─sdm1            8:193  0   200M  0 part /boot/efi
   └─sdm2            8:194  0     1G  0 part /boot
   sdb               8:16   0   7.3T  0 disk
   sdk               8:160  0   7.3T  0 disk
   sdi               8:128  0   7.3T  0 disk
   sdg               8:96   0   7.3T  0 disk
   nvme1n1         259:0    0   2.9T  0 disk
   sde               8:64   0   7.3T  0 disk
   sdc               8:32   0   7.3T  0 disk
   sdl               8:176  0   7.3T  0 disk
   sda               8:0    0   7.3T  0 disk
   sdj               8:144  0   7.3T  0 disk
   nvme0n1         259:1    0   2.9T  0 disk
   sdh               8:112  0   7.3T  0 disk