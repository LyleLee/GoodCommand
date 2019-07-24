OSD down
=======================
在一个ceph集群中， 突然发现有一个节点上的所有OSD其中后不久就被标记为down。重启后显示down，但是过了一段时间之后会显示为down。

# 现象

```
[root@ceph-node00 ~]# ceph osd tree
ID  CLASS WEIGHT    TYPE NAME            STATUS REWEIGHT PRI-AFF

 -7        90.09357     host ceph-node2
 34   hdd   7.50780         osd.34           down  1.00000 1.00000
 35   hdd   7.50780         osd.35           down  1.00000 1.00000
 36   hdd   7.50780         osd.36           down  1.00000 1.00000
 37   hdd   7.50780         osd.37           down  1.00000 1.00000
 38   hdd   7.50780         osd.38           down  1.00000 1.00000
 39   hdd   7.50780         osd.39           down  1.00000 1.00000
 40   hdd   7.50780         osd.40           down  1.00000 1.00000
 41   hdd   7.50780         osd.41           down  1.00000 1.00000
 42   hdd   7.50780         osd.42           down  1.00000 1.00000
 43   hdd   7.50780         osd.43           down  1.00000 1.00000
 44   hdd   7.50780         osd.44           down  1.00000 1.00000
 45   hdd   7.50780         osd.45           down  1.00000 1.00000

[root@ceph-node00 ~]#

```
# 分析

查看该节点上的osd日志：
```cs
2019-07-15 09:46:40.479 ffff91adbbd0  0 log_channel(cluster) log [WRN] : Monitor daemon marked osd.44 down, but it is still running
2019-07-15 09:46:40.479 ffff91adbbd0  0 log_channel(cluster) log [DBG] : map e6540 wrongly marked me down at e6539
2019-07-15 09:46:40.479 ffff91adbbd0  0 osd.44 6540 _committed_osd_maps marked down 6 > osd_max_markdown_count 5 in last 600.000000 seconds, shutting down
2019-07-15 09:46:40.479 ffff91adbbd0  1 osd.44 6540 start_waiting_for_healthy
2019-07-15 09:46:40.489 ffff892cabd0  1 osd.44 pg_epoch: 6539 pg[5.93( empty local-lis/les=0/0 n=0 ec=3129/3129 lis/c 4077/3306 les/c/f 4078/3307/0 6524/6524/6524) [44,1] r=0 lpr=6526 pi=[3306,6524)/8 crt=0'0 mlcod 0'0 peering mbc={}] state<Started/Primary/Peering>: Peering, affected_by_map, going to Reset
2019-07-15 09:46:40.489 ffff89acbbd0  1 osd.44 pg_epoch: 6539 pg[5.15f( v 6431'70954 (6431'67954,6431'70954] lb MIN (bitwise) local-lis/les=6432/6433 n=0 ec=3129/3129 lis/c 6501/6478 les/c/f 6502/6479/0 6539/6539/5395) [17]/[17,33] r=-1 lpr=6539 pi=[3306,6539)/2 crt=6431'70954 lcod 0'0 remapped NOTIFY mbc={}] start_peering_interval up [17,44] -> [17], acting [17,33] -> [17,33], acting_primary 17 -> 17, up_primary 17 -> 17, role -1 -> -1, features acting 4611087854031667199 upacting 4611087854031667199
2019-07-15 09:46:40.489 ffff8a2ccbd0  1 osd.44 pg_epoch: 6539 pg[5.2b7( v 3248'22282 (3241'19282,3248'22282] lb 5:ed43d65e:::rbd_data.123d361bb2f645.0000000000001f5d:head (bitwise) local-lis/les=4546/4550 n=165 ec=3142/3129 lis/c 6524/6510 les/c/f 6525/6511/0 6539/6539/6179) [21]/[21,26] r=-1 lpr=6539 pi=[3306,6539)/3 luod=0'0 crt=3248'22282 active+remapped mbc={}] start_peering_interval up [44,21] -> [21], acting [21,26] -> [21,26], acting_primary 21 -> 21, up_primary 44 -> 21, role -1 -> -1, features acting 4611087854031667199 upacting 4611087854031667199
2019-07-15 09:46:40.489 ffff882c8bd0  1 osd.44 pg_epoch: 6540 pg[5.13( v 5954'28297 (3241'25297,5954'28297] lb MIN (bitwise) local-lis/les=6181/6182 n=464 ec=3129/3129 lis/c 6466/6463 les/c/f 6467/6464/0 6540/6540/5876) [0]/[0,33] r=-1 lpr=6540 pi=[5876,6540)/2 crt=5954'28297 lcod 0'0 remapped NOTIFY mbc={}] start_peering_interval up [36,0] -> [0], acting [0,33] -> [0,33], acting_primary 0 -> 0, up_primary 36 -> 0, role -1 -> -1, features acting 4611087854031667199 upacting 4611087854031667199
2019-07-15 09:46:40.489 ffff892cabd0  1 osd.44 pg_epoch: 6539 pg[5.93( empty local-lis/les=0/0 n=0 ec=3129/3129 lis/c 4077/3306 les/c/f 4078/3307/0 6539/6539/6539) [1] r=-1 lpr=6539 pi=[3306,6539)/8 crt=0'0 unknown mbc={}] start_peering_interval up [44,1] -> [1], acting [44,1] -> [1], acting_primary 44 -> 1, up_primary 44 -> 1, role 0 -> -1, features acting 4611087854031667199 upacting 4611087854031667199
2019-07-15 09:46:40.489 ffff88ac9bd0  1 osd.44 pg_epoch: 6539 pg[5.1bb( v 6161'65198 (6161'62198,6161'65198] lb MIN (bitwise) local-lis/les=6181/6182 n=0 ec=3129/3129 lis/c 6524/6510 les/c/f 6525/6511/0 6539/6539/5029) [29]/[29,8] r=-1 lpr=6539 pi=[3306,6539)/3 luod=0'0 crt=6161'65198 lcod 0'0 active+remapped mbc={}] start_peering_interval up [29,44] -> [29], acting [29,8] -> [29,8], acting_primary 29 -> 29, up_primary 29 -> 29, role -1 -> -1, features acting 4611087854031667199 upacting 4611087854031667199
2019-07-15 09:46:40.489 ffff89acbbd0  1 osd.44 pg_epoch: 6540 pg[5.15f( v 6431'70954 (6431'67954,6431'70954] lb MIN (bitwise) local-lis/les=6432/6433 n=0 ec=3129/3129 lis/c 6501/6478 les/c/f 6502/6479/0 6539/6539/5395) [17]/[17,33] r=-1 lpr=6539 pi=[3306,6539)/2 crt=6431'70954 lcod 0'0 remapped NOTIFY mbc={}] state<Start>: transitioning to Stray
2019-07-15 09:46:40.489 ffff91adbbd0  0 osd.44 6540 _committed_osd_maps shutdown OSD via async signal
2019-07-15 09:46:40.489 ffff882c8bd0  1 osd.44 pg_epoch: 6540 pg[5.13( v 5954'28297 (3241'25297,5954'28297] lb MIN (bitwise) local-lis/les=6181/6182 n=464 ec=3129/3129 lis/c 6466/6463 les/c/f 6467/6464/0 6540/6540/5876) [0]/[0,33] r=-1 lpr=6540 pi=[5876,6540)/2 crt=5954'28297 lcod 0'0 remapped NOTIFY mbc={}] state<Start>: transitioning to Stray
2019-07-15 09:46:40.489 ffff88ac9bd0  1 osd.44 pg_epoch: 6540 pg[5.1bb( v 6161'65198 (6161'62198,6161'65198] lb MIN (bitwise) local-lis/les=6181/6182 n=0 ec=3129/3129 lis/c 6524/6510 les/c/f 6525/6511/0 6539/6539/5029) [29]/[29,8] r=-1 lpr=6539 pi=[3306,6539)/3 crt=6161'65198 lcod 0'0 remapped NOTIFY mbc={}] state<Start>: transitioning to Stray
2019-07-15 09:46:40.489 ffff8a2ccbd0  1 osd.44 pg_epoch: 6540 pg[5.2b7( v 3248'22282 (3241'19282,3248'22282] lb 5:ed43d65e:::rbd_data.123d361bb2f645.0000000000001f5d:head (bitwise) local-lis/les=4546/4550 n=165 ec=3142/3129 lis/c 6524/6510 les/c/f 6525/6511/0 6539/6539/6179) [21]/[21,26] r=-1 lpr=6539 pi=[3306,6539)/3 crt=3248'22282 remapped NOTIFY mbc={}] state<Start>: transitioning to Stray
2019-07-15 09:46:40.489 ffffa1afbbd0 -1 received  signal: Interrupt from Kernel ( Could be generated by pthread_kill(), raise(), abort(), alarm() ) UID: 0
2019-07-15 09:46:40.489 ffff892cabd0  1 osd.44 pg_epoch: 6540 pg[5.93( empty local-lis/les=0/0 n=0 ec=3129/3129 lis/c 4077/3306 les/c/f 4078/3307/0 6539/6539/6539) [1] r=-1 lpr=6539 pi=[3306,6539)/8 crt=0'0 unknown NOTIFY mbc={}] state<Start>: transitioning to Stray
2019-07-15 09:46:40.489 ffffa1afbbd0 -1 osd.44 6540 *** Got signal Interrupt ***
2019-07-15 09:46:40.489 ffffa1afbbd0  0 osd.44 6540 prepare_to_stop starting shutdown
2019-07-15 09:46:40.489 ffffa1afbbd0  0 osd.44 6540 shutdown
2019-07-15 09:46:40.559 ffffa1afbbd0  1 bluestore(/var/lib/ceph/osd/ceph-44) umount
2019-07-15 09:46:40.679 ffffa1afbbd0  4 rocksdb: [/home/jenkins-build/build/workspace/ceph-build/ARCH/arm64/AVAILABLE_ARCH/arm64/AVAILABLE_DIST/centos7/DIST/centos7/MACHINE_SIZE/huge/release/14.2.1/rpm/el7/BUILD/ceph-14.2.1/src/rocksdb/db/db_impl.cc:365] Shutdown: canceling all background work
2019-07-15 09:46:40.679 ffffa1afbbd0  4 rocksdb: [/home/jenkins-build/build/workspace/ceph-build/ARCH/arm64/AVAILABLE_ARCH/arm64/AVAILABLE_DIST/centos7/DIST/centos7/MACHINE_SIZE/huge/release/14.2.1/rpm/el7/BUILD/ceph-14.2.1/src/rocksdb/db/db_impl.cc:521] Shutdown complete
2019-07-15 09:46:40.679 ffffa1afbbd0  1 bluefs umount
```
可以看到显示Monitor把osd.44 标记为down，but it is still running. 有6个osd报告osd.44是down。 超过了osd_max_markdown_count最大值。之后`Got signal Interrupt`就shutdown了。


在其他正常节点上的osd日志上看到， 没有收到来自osd.44的心跳信号。

从日志ceph-osd.23.log分析，osd.23报告osd.44心跳无法检测到
```
2019-07-12 06:50:18.528 ffff89882bd0 -1 osd.23 6178 heartbeat_check: no reply from 192.168.200.3:6802 osd.44 ever on either front or back, first ping sent
2019-07-12 06:49:58.148429 (oldest deadline 2019-07-12 06:50:18.148429)
```

从日志ceph-osd.5.log分析，osd.5报告osd.44心跳无法检测到
```
2019-07-12 06:50:17.874 ffffb575ebd0 -1 osd.5 6178 heartbeat_check: no reply from 192.168.200.3:6802 osd.44 ever on either front or back, first ping sent
2019-07-12 06:49:57.751149 (oldest deadline 2019-07-12 06:50:17.751149)
```

从日志ceph-osd.25.log分析，osd.25报告osd.44心跳无法检测到
```
2019-07-12 06:50:18.425 ffffa43c9bd0 -1 osd.25 6178 heartbeat_check: no reply from 192.168.200.3:6802 osd.44 ever on either front or back, first ping sent
2019-07-12 06:49:57.962790 (oldest deadline 2019-07-12 06:50:17.962790)
```

从ceph和各个节点的现象来看，down掉的osd是被正常标记为down的，由于是只有一个节点上的osd有问题，并且是这个节点的上的所有osd都有问题。想看一下OS本身是不是有异常信息。

在异常节点上查看dmesg，无任何打印。也就是说，至少没有发生软硬件错误信息
```
[四 7月 11 20:34:55 2019] hinic 0000:90:00.0 enp144s0: [NIC]Finally num_qps: 16, num_rss: 16
[四 7月 11 20:34:55 2019] hinic 0000:90:00.0 enp144s0: [NIC]Netdev is up
[四 7月 11 20:34:55 2019] IPv6: ADDRCONF(NETDEV_UP): enp144s0: link is not ready
[四 7月 11 20:34:56 2019] TCP: enp131s0: Driver has suspect GRO implementation, TCP performance may be compromised.
[四 7月 11 20:35:17 2019]  nvme1n1: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12
[四 7月 11 20:35:41 2019]  nvme1n1: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12
[四 7月 11 20:36:05 2019]  nvme1n1: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12
[四 7月 11 20:36:29 2019]  nvme1n1: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12
[四 7月 11 20:36:54 2019]  nvme1n1: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12
[四 7月 11 20:37:19 2019]  nvme1n1: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12

```

查看messages获得类似的消息
```
Jul 12 07:03:13 ceph-node02 systemd: Starting Ceph object storage daemon osd.44...
Jul 12 07:03:13 ceph-node02 systemd: Started Ceph object storage daemon osd.44.
Jul 12 07:03:18 ceph-node02 ceph-osd: 2019-07-12 07:03:18.659 ffffaf9f6010 -1 osd.44 6208 log_to_monitors {default=true}
Jul 12 07:05:46 ceph-node02 ceph-osd: 2019-07-12 07:05:46.969 ffffabf17bd0 -1 received  signal: Interrupt from Kernel ( Could be generated by pthread_kill(), raise(), abort(), alarm() ) UID: 0
Jul 12 07:05:46 ceph-node02 ceph-osd: 2019-07-12 07:05:46.969 ffffabf17bd0 -1 osd.44 6293 *** Got signal Interrupt ***
Jul 12 07:52:25 ceph-node02 systemd-logind: Removed session 44.
```
也就是说OS是没有什么错误信息的。这个时候有点怀疑防火墙了。 也检查了一遍网络， 发现互相之间都是可以ping通的。

先看SELinux, 都关了（其实应该和SELinux没有什么关系）
```
[2019-07-15 18:48:52]  192.168.100.107: Permissive
[2019-07-15 18:48:52]  192.168.100.104: Permissive
[2019-07-15 18:48:52]  192.168.100.101: Permissive
[2019-07-15 18:48:52]  192.168.100.103: Permissive
[2019-07-15 18:48:52]  192.168.100.102: Permissive
[2019-07-15 18:48:52]  192.168.100.108: Permissive
[2019-07-15 18:48:52]  192.168.100.106: Permissive
[2019-07-15 18:48:52]  192.168.100.105: Permissive
```
再看Firewalls, 真的有一台在running，也就是node2这一台
```
pdsh -w ^arm.txt -R ssh "firewall-cmd --state"

[2019-07-15 18:50:47]  192.168.100.107: not running
[2019-07-15 18:50:47]  192.168.100.105: not running
[2019-07-15 18:50:47]  192.168.100.101: not running
[2019-07-15 18:50:47]  192.168.100.108: not running
[2019-07-15 18:50:47]  192.168.100.104: not running
[2019-07-15 18:50:47]  192.168.100.102: not running
[2019-07-15 18:50:47]  192.168.100.106: not running
[2019-07-15 18:50:47]  192.168.100.103: running
```
# 解决方案

直接关掉，发现所有OSD都up了。
```
systectl stop firewalld
```
```
-7        90.09357     host ceph-node02
 34   hdd   7.50780         osd.34           up  1.00000 1.00000
 35   hdd   7.50780         osd.35           up  1.00000 1.00000
 36   hdd   7.50780         osd.36           up  1.00000 1.00000
 37   hdd   7.50780         osd.37           up  1.00000 1.00000
 38   hdd   7.50780         osd.38           up  1.00000 1.00000
 39   hdd   7.50780         osd.39           up  1.00000 1.00000
 40   hdd   7.50780         osd.40           up  1.00000 1.00000
 41   hdd   7.50780         osd.41           up  1.00000 1.00000
 42   hdd   7.50780         osd.42           up  1.00000 1.00000
 43   hdd   7.50780         osd.43           up  1.00000 1.00000
 44   hdd   7.50780         osd.44           up  1.00000 1.00000
 45   hdd   7.50780         osd.45           up  1.00000 1.00000

```