*************************
Ceph operate
*************************

.. code-block:: shell

    ceph daemon osd.2 show config       #查看OSD的参数
    ceph daemon osd.2 perf restet       #重置OSD的性能参数统计
    ceph daemon osd.2 perf dump > a.txt #到处配置
    ceph pg dump                        #查看pg分布
    for i in {40..59};do ceph daemon osd.$i config set osd_max_backfills 10;done

目标是新建如下集群：

.. code-block:: console

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


卸载过程
======================

文件存储卸载过程

在客户端取消挂载点
---------------------

这里的挂载点点是/mnt/cephfs.

.. code-block:: console

    ceph1,ceph2,ceph3,ceph4:/ on /mnt/cephfs type ceph (rw,relatime,sync,name=admin,secret=<hidden>,acl,wsize=16777216)

.. code-block:: console

    [root@client1 vdbench]# pssh -h client_hosts.txt -i -P "umount /mnt/cephfs"
    [1] 16:11:37 [SUCCESS] root@client1:22
    [2] 16:11:37 [SUCCESS] root@client3:22
    [3] 16:11:37 [SUCCESS] root@client4:22
    [4] 16:11:37 [SUCCESS] root@client2:22
    [root@client1 vdbench]#
    [root@client1 vdbench]#

确认客户端为 0

.. code-block:: console

    [root@ceph1 ~]# ceph fs status
    cephfs - 0 clients
    ======
    +------+--------+-------+---------------+-------+-------+
    | Rank | State  |  MDS  |    Activity   |  dns  |  inos |
    +------+--------+-------+---------------+-------+-------+
    |  0   | active | ceph4 | Reqs:    0 /s | 5111  | 5113  |
    +------+--------+-------+---------------+-------+-------+
    +-----------------+----------+-------+-------+
    |       Pool      |   type   |  used | avail |
    +-----------------+----------+-------+-------+
    | cephfs_metadata | metadata |  156M |  183T |
    |   cephfs_data   |   data   |  976G |  183T |
    +-----------------+----------+-------+-------+

    +-------------+
    | Standby MDS |
    +-------------+
    |    ceph2    |
    |    ceph3    |
    |    ceph1    |
    +-------------+
    MDS version: ceph version 12.2.5 (cad919881333ac92274171586c827e01f554a70a) luminous (stable)
    [root@ceph1 ~]#

停止MDS进程
---------------------

.. code-block:: console

    [root@client1 vdbench]# pssh -h backend_hosts.txt -i -P "systemctl stop ceph-mds.target"
    [1] 16:17:27 [SUCCESS] root@ceph2:22
    Stderr:
    Authorized users only. All activities may be monitored and reported.
    [2] 16:17:27 [SUCCESS] root@ceph4:22
    Stderr:
    Authorized users only. All activities may be monitored and reported.
    [3] 16:17:27 [SUCCESS] root@ceph1:22
    Stderr:
    Authorized users only. All activities may be monitored and reported.
    [4] 16:17:27 [SUCCESS] root@ceph3:22
    Stderr:
    Authorized users only. All activities may be monitored and reported.
    [root@client1 vdbench]#

删除后端文件存储
-----------------------

.. code-block:: console

    [root@ceph1 ~]# ceph osd pool delete cephfs_metadata cephfs_metadata --yes-i-really-really-mean-it
    pool 'cephfs_metadata' removed
    [root@ceph1 ~]# ceph osd pool delete cephfs_data cephfs_data --yes-i-really-really-mean-it
    pool 'cephfs_data' removed
    [root@ceph1 ~]#


如果报错提示需要设置MON允许删除pool

在 ``/etc/ceph/ceph.conf`` 中需要包含:

.. code-block:: ini

    [mon]
    mon_allow_pool_delete = true



删除pool
--------

.. code-block:: shell

   # 文件存储池删除
   ceph osd pool delete cephfs_metadata cephfs_metadata --yes-i-really-really-mean-it
   ceph osd pool delete cephfs_data cephfs_data --yes-i-really-really-mean-it

   # 块存储池删除
   ceph osd pool delete images images --yes-i-really-really-mean-it
   ceph osd pool delete volumes volumes --yes-i-really-really-mean-it



停止OSD进程
---------------------

在每一个ceph节点上执行 ``systemctl stop ceph-osd.target``

.. code-block:: console

    [root@client1 bin]# pssh -h backend_hosts.txt -i -P "systemctl stop ceph-osd.target"
    [1] 16:43:35 [SUCCESS] root@ceph2:22
    Stderr:
    Authorized users only. All activities may be monitored and reported.
    [2] 16:43:35 [SUCCESS] root@ceph3:22
    Stderr:
    Authorized users only. All activities may be monitored and reported.
    [3] 16:43:35 [SUCCESS] root@ceph4:22
    Stderr:
    Authorized users only. All activities may be monitored and reported.
    [4] 16:43:35 [SUCCESS] root@ceph1:22
    Stderr:
    Authorized users only. All activities may be monitored and reported.



删除HDD OSD
-----------

在可以对集群进行管理的节点上执行删除

.. code-block:: shell

   for i in {0..95}; do
       ceph osd down osd.$i
       ceph osd out osd.$i
       ceph osd crush remove osd.$i
       ceph auth del osd.$i
       ceph osd rm osd.$i
   done

查看删除情况

.. code-block:: console

    [root@ceph1 bin]# ceph osd tree
    ID CLASS WEIGHT TYPE NAME      STATUS REWEIGHT PRI-AFF
    -1            0 root default
    -3            0     host ceph1
    -5            0     host ceph2
    -7            0     host ceph3
    -9            0     host ceph4


取消每台ceph节点上OSD挂载

.. code-block:: shell

   umount /var/lib/ceph/osd/ceph-*
   rm -rf /var/lib/ceph/osd/ceph-*


删除每台ceph节点上的上的lvm分区
----------------------------------

方法一：

.. code-block:: shell

   lvs | grep osd | awk '{print $2}' | xargs lvremove -y       #先删除lvm
   vgs | grep ceph | awk '{print $1}' | xargs vgremove -y      #再删除lvm group， 有时候可以直接执行这一条

可以在单台设备上执行上述命令，

.. code-block:: shell

   pdsh -w '^arm.txt' 'lvs | grep osd | awk {print $2} | xargs lvremove -y'
   pdsh -w '^arm.txt' 'vgs | grep ceph | awk {print $1} | xargs vgremove -y '


传递的命令带有单引号，所以这里加了转义符号。


方法二：

.. code-block:: shell

   lsblk | grep ceph |awk '{print substr($1,3)}'                           #列出所有的lvm分区
   lsblk | grep ceph |awk '{print substr($1,3)}' | xargs dmsetup remove    #列出所有的lvm分区，并删除

也可以指定删除某一个

.. code-block:: shell

   dmsetup remove ceph--7c7c2721--5dfc--45e4--9946--5316e21087df-osd--block--92276738--1bbe--4229--a094--761ceda16812



删除前

.. code-block:: console

    [root@ceph1 bin]# lsblk
    NAME                                                                                                      MAJ:MIN  RM   SIZE RO TYPE MOUNTPOINT
    loop0                                                                                                       7:0     0   4.2G  0 loop /mnt/euler
    sda                                                                                                         8:0     0   7.3T  0 disk
    └─bcache0                                                                                                 251:0     0   7.3T  0 disk
      └─ceph--1f0cdb93--553b--4ae9--a70d--44d1f330d564-osd--block--ace0eccc--eba3--4216--a66a--b9725ec56cdf   250:0     0   7.3T  0 lvm
    sdb                                                                                                         8:16    0   7.3T  0 disk
    └─bcache1                                                                                                 251:128   0   7.3T  0 disk
      └─ceph--d1c3ee5c--41a7--4662--be22--c5bc3e78ad69-osd--block--8a9951cf--33ac--4246--a6a7--36048e5852bf   250:1     0   7.3T  0 lvm
    sdc                                                                                                         8:32    0   7.3T  0 disk
    └─bcache2                                                                                                 251:256   0   7.3T  0 disk
      └─ceph--0bea6159--6d83--4cd5--be49--d1b4a74c4007-osd--block--476506ce--64a3--461e--8ffc--78de4f29a0ed   250:2     0   7.3T  0 lvm
    sdd                                                                                                         8:48    0   7.3T  0 disk
    └─bcache3                                                                                                 251:384   0   7.3T  0 disk
      └─ceph--8efa3be6--8448--47ff--9653--4f9d52439f80-osd--block--a4659aeb--bbc5--4ca0--8e4f--656b3ca47aad   250:3     0   7.3T  0 lvm
    sde
删除后

.. code-block:: console

    [root@ceph1 bin]# lsblk
    NAME         MAJ:MIN  RM   SIZE RO TYPE MOUNTPOINT
    loop0          7:0     0   4.2G  0 loop /mnt/euler
    sda            8:0     0   7.3T  0 disk
    └─bcache0    251:0     0   7.3T  0 disk
    sdb            8:16    0   7.3T  0 disk
    └─bcache1    251:128   0   7.3T  0 disk
    sdc            8:32    0   7.3T  0 disk
    └─bcache2    251:256   0   7.3T  0 disk
    sdd            8:48    0   7.3T  0 disk


删除bcache(未使用请跳过)
--------------------------

.. code-block:: shell

    pssh -h backend_hosts.txt -i -P -I < resetbcache.sh


删除前

.. code-block:: console

    [root@ceph1 bin]# lsblk
    NAME         MAJ:MIN  RM   SIZE RO TYPE MOUNTPOINT
    loop0          7:0     0   4.2G  0 loop /mnt/euler
    sda            8:0     0   7.3T  0 disk
    └─bcache0    251:0     0   7.3T  0 disk
    sdb            8:16    0   7.3T  0 disk
    └─bcache1    251:128   0   7.3T  0 disk
    sdc            8:32    0   7.3T  0 disk
    └─bcache2    251:256   0   7.3T  0 disk
    sdd            8:48    0   7.3T  0 disk
    └─bcache3    251:384   0   7.3T  0 disk
    sde            8:64    0   7.3T  0 disk
    └─bcache4    251:512   0   7.3T  0 disk
    sdf            8:80    0   7.3T  0 disk

删除后

.. code-block:: console

    [root@ceph1 dzw]# lsblk
    NAME    MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
    loop0     7:0    0   4.2G  0 loop /mnt/euler
    sda       8:0    0   7.3T  0 disk
    sdb       8:16   0   7.3T  0 disk
    sdc       8:32   0   7.3T  0 disk
    sdd       8:48   0   7.3T  0 disk
    sde       8:64   0   7.3T  0 disk
    sdf       8:80   0   7.3T  0 disk
    sdg       8:96   0   7.3T  0 disk
    sdh       8:112  0   7.3T  0 disk
    sdi       8:128  0   7.3T  0 disk
    sdj       8:144  0   7.3T  0 disk
    sdk       8:160  0   7.3T  0 disk
    sdl       8:176  0   7.3T  0 disk


最好dd一遍所有HDD和SSD分区

.. code-block:: shell

    for ssd in v w x y;
    do
            for i in {1..15};
            do
                    echo sd$ssd$i
                    dd if=/dev/zero of=/dev/sd"$ssd""$i" bs=1M count=1
            done
    done


.. warn::

    到这里就完成了卸载，可以重新添加OSD了,再往下的过程是格式化所有硬盘，重新分区


格式化每台设备上的HDD,SSD（如果有）
-------------------------------------

.. code-block:: shell

   for disk in {a..l}
       do parted -s /dev/sd${disk} mklabel gpt
       ceph-volume lvm zap /dev/sd${disk} --destroy
   done

.. code-block:: shell

   for ssd_disk in nvme0n1 nvme1n1
       do parted -s /dev/$ssd_disk mklabel gpt
       ceph-volume lvm zap /dev/$ssd_disk --destroy
   done

在deploy节点上收集key
---------------------

.. code-block:: shell

   ceph-deploy gatherkeys ceph-node00

.. code-block:: shell

   for node in {00..07}; do
       ceph-deploy gatherkeys ceph-node${node}
   done

创建 HDD OSD
------------

正常情况下在ceph-deploy节点上执行创建

.. code-block:: shell

   for node in {00..07}; do
       for disk in {a..l};do
           ceph-deploy osd create --data /dev/sd${disk} ceph-node${node}
           sleep 2
       done
   done

如果需要设置SSD作为wal和db在每个节点上执行

.. code-block:: shell

   vgcreate ceph-db /dev/nvme0n1
   vgcreate ceph-wal /dev/nvme1n1
   for index in {a..l};do
       lvcreate -n ceph-db-$index -L 240G ceph-db;
       lvcreate -n ceph-wal-$index -L 240G ceph-wal;
   done

正常情况下在deploy节点上执行

.. code-block:: shell

   for node in {00..07}; do
       for disk in {a..l};do
           ceph-deploy --overwrite-conf osd create --data /dev/sd${disk} ceph-node${node}
       done
   done

如果需要设置SSD作为wal和db在每个节点上执行

.. code-block:: shell

   vgcreate ceph-db /dev/nvme0n1
   vgcreate ceph-wal /dev/nvme1n1
   for node in {00..07}; do
       for disk in {a..l};do
           ceph-deploy --overwrite-conf osd create --data /dev/sd${disk} \
           --block-db ceph-db/ceph-db-$disk \
           --block-wal ceph-wal/ceph-wal-$disk ceph-node${node}
       done
   done

创建pool
--------

正常情况下创建pool

.. code-block:: shell

   ceph osd pool create volumes 4096 4096
   ceph osd pool application enable volumes rbd

如果需要创建EC pool

.. code-block:: shell

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

.. code-block:: shell

   for i in {000..399};do rbd create size3/test-$i --size 400G; done

约2分钟 如果是EC池

.. code-block:: shell

   for i in {000..399};do
       rbd create volumes_repli_metadata/test-$i --size 400G --data-pool volumes;
   done

写入数据
--------

.. code-block:: shell

   pdcp -w ^dell.txt fill_hdd_data.sh /root/rbd_test/
   pdsh -w ^dell.txt 'cd /root/rbd_test; . fill_hdd_data.sh'

查看rbd容量
-----------

.. code-block:: shell

   for index in {000..399};do
       rbd du volumes/test-$index
   done

SSD 集群重测
=============

格式化SSD
-------------

.. code-block:: shell

   parted /dev/nvme1n1 -s mklabel gpt
   parted /dev/nvme0n1 -s mklabel gpt

收集key
-----------

.. code-block:: shell

   ceph-deploy gatherkeys

.. code-block:: shell

   ceph-deploy osd create --data /dev/nvme0n1 ceph-node00
   ceph-deploy osd create --data /dev/nvme1n1 ceph-node00

创建 pool
-------------

.. code-block:: console

   [root@ceph-node00 ~]# ceph osd pool create volumes 4096 4096
   Error ERANGE:  pg_num 4096 size 3 would mean 12288 total pgs, which exceeds max 4000 (mon_max_pg_per_osd 250 * num_in_osds 16)
   [root@ceph-node00 ~]# ceph osd pool create volumes 512 512

.. _创建rbd-1:

创建rbd
-------------

一共创建50个rbd

.. code-block:: shell

   for i in {01..50};do
       rbd create --size 100G volumes/test-$i
   done

写满rbd数据
-------------

.. code-block:: shell

   pdsh -w ^dell.txt "cd /root/rbd_test;. fill_nvm2_data.sh"



查看rbd的容量
----------------

.. code-block:: shell

   for index in {01..50};do
       rbd du volumes/test-$index
   done


其它常用操作
===============

收集数据
-----------

.. code-block:: shell

   for host in `cat ../dell.txt`; do
       scp -r root@${host}:/root/rbd_test/192/* ./;
   done

分发脚本
---------------

.. code-block:: shell

   for host in `cat dell.txt`; do
       scp do_fio.sh root@${host}:/root/rbd_test/;
   done
   for host in `cat dell.txt`; do
       scp rmhostname.sh root@${host}:/root/rbd_test/;
   done


重启进入bios
----------------

.. code-block:: shell

   for host in ``cat BMC_arm.txt``; do
       ipmitool -I lanplus -H ${host} -U Administrator -P Admin@9000 chassis bootdev bios;
       wait ;
   done


执行单个测试
------------------

.. code-block:: shell

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
------------------

.. code-block:: shell

   py /home/monitor/test_script/parase_fio.py ./


禁用 osd
-------------
.. code-block:: shell

   systemctl | grep ceph-osd | grep fail | awk ‘{print $2}’
   systemctl | grep ceph-osd | grep fail | awk ‘{print $2}’ | xargs systemctl disable
   systemctl | grep ceph-osd | grep fail | awk ‘{print $2}’ | xargs systemctl status


ceph绑核
--------------

可以先用`taskset -acp 0-23 {osd-pid}`
看看对性能帮助有多大。如果有帮助，再调整ceph参数配置

绑定node2

.. code-block:: shell

   for osd_pid in $(pgrep ceph-osd); do taskset -acp 48-71 $osd_pid ;done
   for osd_pid in $(pgrep ceph-osd); do ps -o thcount $osd_pid ;done


daemon命令查看集群状态
-----------------------

.. code-block:: shell

   ceph daemon mon.cu-pve04 help       #显示monitor的命令帮助
   ceph daemon mon.cu-pve04 sessions   #
   ceph daemon osd.0 config show
   ceph daemon osd.0 help              #显示命令帮助
   ceph daemon osd.0 "dump_historic_ops_by_duration" #显示被ops的时间

noscrub 设置
----------------------

.. code-block:: shell

   ceph used set noscrub       #停止scrub
   ceph osd unset noscrub      #启动scrub

删除lvm分区效果
----------------------

.. code-block:: console

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



问题记录
===============

问题记录：

1. inform the kernel of the change

.. code-block:: console

    [root@ceph2 ~]# parted /dev/sdy mklabel gpt
    Warning: The existing disk label on /dev/sdy will be destroyed and all data on this disk will be lost. Do you want to continue?
    Yes/No? yes
    Error: Partition(s) 11, 12, 13, 14, 15 on /dev/sdy have been written, but we have been unable to inform the kernel of the change, probably because it/they are in use.  As a result, the old partition(s) will
    remain in use.  You should reboot now before making further changes.
    Ignore/Cancel? yes^C
    [root@ceph2 ~]#

解决办法，bcache没有删除干净使用find命令查找没有删除的bcache分区

.. code-block:: shell

    find / -name bcahce
