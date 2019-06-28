下载地址
http://core.dpdk.org/download/

安装依赖
```
[root@arm-134 ~]# yum install make makecache gcc-c++ patch kernel-devel numactl
已加载插件：fastestmirror, langpacks
Loading mirror speeds from cached hostfile
软件包 1:make-3.82-23.el7.aarch64 已安装并且是最新版本
没有可用软件包 makecache。
软件包 gcc-c++-4.8.5-36.el7.aarch64 已安装并且是最新版本
软件包 patch-2.7.1-10.el7_5.aarch64 已安装并且是最新版本
软件包 kernel-devel-4.14.0-115.el7a.0.1.aarch64 已安装并且是最新版本
软件包 numactl-2.0.9-7.el7.aarch64 已安装并且是最新版本
无须任何处理
```

设置环境变量
```

export RTE_SDK=/home/lixianfa/dpdk/dpdk-stable-17.11.6/
export RTE_TARGET=arm64-armv8a-linuxapp-gcc
export KERNELDIR=/lib/modules/4.14.0-115.el7a.0.1.aarch64/build/
```

绑定dpdk
```
Network devices using DPDK-compatible driver
============================================
0002:e9:00.0 '82599ES 10-Gigabit SFI/SFP+ Network Connection 10fb' drv=igb_uio unused=ixgbe

Network devices using kernel driver
===================================
<none>

```

巨型页配置
```
Option: 28

AnonHugePages:         0 kB
ShmemHugePages:        0 kB
HugePages_Total:      48
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:     524288 kB
```


pfring发包
```
/home/PF_RING-6.0.2/userland/examples/pfsend -i dna1 -f /data1/rawdata110   -r4 -n100
/home/PF_RING-6.0.2/userland/examples/pfsend -i dna0 -f /data1/rawdata002 -r 5
/home/PF_RING-6.0.2/userland/examples/pfsend -i dna0 -n 0 -r 5

#更多参数
-a              Active send retry
-f <.pcap file> Send packets as read from a pcap file
-g <core_id>    Bind this app to a core
-h              Print this help
-i <device>     Device name. Use device
-l <length>     Packet length to send. Ignored with -f
-n <num>        Num pkts to send (use 0 for infinite)
-r <rate>       Rate to send (example -r 2.5 sends 2.5 Gbit/sec, -r -1 pcap capture rate)
-m <dst MAC>    Reforge destination MAC (format AA:BB:CC:DD:EE:FF)
-b <num>        Number of different IPs (balanced traffic)
-w <watermark>  TX watermark (low value=low latency) [not effective on DNA]
-z              Disable zero-copy, if supported [DNA only]
-x <if index>   Send to the selected interface, if supported
-d              Daemon mode
-P <pid file>   Write pid to the specified file (daemon mode only)
-v              Verbose
```

```
watch -d -n 1 IPNetStat 0
```

测试线速

```
134
/home/jiuzhou/bin/jz_dpdk

206
/home/PF_RING-6.0.2/userland/examples/pfsend -i dna0 -f rawdata100 -r10 -n0
/home/PF_RING-6.0.2/userland/examples/pfsend -i dna0 -r10 -n0				#需要制定要发送的IP数据包，否则自行构建的数据包可能不是IP数据包，测试结果较差
```

测试处理
```
/home/PF_RING-6.0.2/userland/examples/pfsend_dir -i dna0 -r10 -n0

watch -d -n 1 IPNetStat 0
```

优化操作：

```
收一核
发一核
IPnet 绑到numctl一个核上， 观察网卡是否在哪一个P上。dpdk在另一个片上

增加内存256
增加处理进程数量
```

待处理问题：
1. top 显示进程运行所在的核


确认网卡在从片还是主片上：
```
[root@arm-134 home]# lspci -tv
-+-[000d:30]---00.0-[31]--
 +-[000c:20]---00.0-[21]--
 +-[000a:10]---00.0-[11]--
 +-[0007:40]---00.0-[41]----00.0  Huawei Technologies Co., Ltd. Hi1710 [iBMC Intelligent Management system chip w/VGA support]
 +-[0006:08]---00.0-[09]--
 +-[0005:00]---00.0-[01]--
 +-[0004:48]---00.0-[49]----00.0  LSI Logic / Symbios Logic MegaRAID SAS-3 3108 [Invader]
 +-[0002:e8]---00.0-[e9]--+-00.0  Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection
 |                        \-00.1  Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection
 \-[0000:00]-

```


/home/hengguang/lichao/4xg_sdh_mmap
/home/hengguang/devmem/devmem2 0x75040000000
/home/hengguang/devmem/devmem2 0x75040048000

for((i=0x75040000000;i<0x75041000000;i+=8)); do
	printf "read: 0x%x\n" $i;
	/home/hengguang/devmem/devmem2 "$i"
done


[    0.604814] pci_bus 000a:10: on NUMA node 2
[    0.604821] pci 000a:10:00.0: BAR 0: assigned [mem 0x65040000000-0x6504000ffff]
[    0.604824] pci 000a:10:00.0: PCI bridge to [bus 11]
[    0.605176] acpi PNP0A08:06: MCFG quirk: ECAM at [mem 0x74002000000-0x74002ffffff] for [bus 20-2f] with hisi_pcie_ops
[    0.607069] pci_bus 000c:20: root bus resource [mem 0x75040000000-0x750ffffffff window] (bus address [0x40000000-0xffffffff])
[    0.607072] pci_bus 000c:20: root bus resource [io  0x60000-0x6ffff window] (bus address [0x0000-0xffff])
[    0.607074] pci_bus 000c:20: root bus resource [bus 20-2f]
[    0.607084] pci 000c:20:00.0: [19e5:1610] type 01 class 0x060400
[    0.607101] pci 000c:20:00.0: reg 0x10: [mem 0x00000000-0x0000ffff]
[    0.607147] pci 000c:20:00.0: supports D1 D2
[    0.607148] pci 000c:20:00.0: PME# supported from D0 D1 D3hot
[    0.607250] pci 000c:21:00.0: [10ee:7028] type 00 class 0x020000
[    0.607275] pci 000c:21:00.0: reg 0x10: [mem 0x75040000000-0x75040ffffff 64bit]
[    0.607356] pci 000c:21:00.0: PME# supported from D0 D1 D2 D3hot
[    0.607431] pci_bus 000c:20: on NUMA node 3
[    0.607439] pci 000c:20:00.0: BAR 14: assigned [mem 0x75040000000-0x75040ffffff]
[    0.607441] pci 000c:20:00.0: BAR 0: assigned [mem 0x75041000000-0x7504100ffff]
[    0.607445] pci 000c:21:00.0: BAR 0: assigned [mem 0x75040000000-0x75040ffffff 64bit]
[    0.607456] pci 000c:20:00.0: PCI bridge to [bus 21]
[    0.607460] pci 000c:20:00.0:   bridge window [mem 0x75040000000-0x75040ffffff]
[    0.607819] acpi PNP0A08:07: MCFG quirk: ECAM at [mem 0x78003000000-0x78003ffffff] for [bu


# 问题

缺少numa.h, 
```
/home/lixianfa/dpdk/dpdk-stable-17.11.6/lib/librte_eal/linuxapp/eal/eal_memory.c:56:18: fatal error: numa.h: No such file or directory
```
解决办法
```
sudo yum install numactl-devel
```








ARM-131# show traffic
-----------------------------------------------------------
Interface pps                      Mbps
-----------------------------------------------------------
0         0                        0
1         398106                   1327
ARM-131# show traffic
-----------------------------------------------------------
Interface pps                      Mbps
-----------------------------------------------------------
0         0                        0
1         398106                   1327
ARM-131# show traffic
-----------------------------------------------------------
Interface pps                      Mbps
-----------------------------------------------------------
0         0                        0
1         396911                   1323
ARM-131# show traffic
-----------------------------------------------------------
Interface pps                      Mbps
-----------------------------------------------------------
0         0                        0
1         396527                   1322
ARM-131# show traffic
-----------------------------------------------------------
Interface pps                      Mbps
-----------------------------------------------------------
0         0                        0
1         394882                   1316
ARM-131# show traffic
-----------------------------------------------------------
Interface pps                      Mbps
-----------------------------------------------------------
0         0                        0
1         394882                   1316
ARM-131# show traffic
-----------------------------------------------------------
Interface pps                      Mbps
-----------------------------------------------------------
0         0                        0
1         424770                   1416
ARM-131# show traffic
-----------------------------------------------------------
Interface pps                      Mbps
-----------------------------------------------------------
0         0                        0
1         424770                   1416
ARM-131# show traffic
-----------------------------------------------------------
Interface pps                      Mbps
-----------------------------------------------------------
0         0                        0
1         423611                   1412
ARM-131# show traffic
-----------------------------------------------------------



Tasks: 785 total,   6 running, 427 sleeping,   0 stopped,   0 zombie
%Cpu(s):  2.7 us,  7.3 sy,  0.0 ni, 89.8 id,  0.0 wa,  0.0 hi,  0.2 si,  0.0 st
KiB Mem : 66271616 total, 29970176 free,  6529280 used, 29772160 buff/cache
KiB Swap:  4194240 total,  4194240 free,        0 used. 47201280 avail Mem

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
22649 root      20   0 2633984   2.0g   2.0g S 215.5  3.1  54:05.93 exam
23455 root      20   0    8512   8000   2112 R  95.7  0.0   2:54.89 tcpreplay
23457 root      20   0    8512   8000   2112 R  95.7  0.0   2:55.43 tcpreplay
23456 root      20   0    8448   7936   2048 R  95.4  0.0   2:54.99 tcpreplay
23459 root      20   0    8512   8000   2048 R  95.1  0.0   2:50.93 tcpreplay
23458 root      20   0    8512   8064   2112 R  94.7  0.0   2:49.99 tcpreplay
23416 root      20   0  113280   5440   2880 S   2.6  0.0   0:11.37 htop
23472 root      20   0  118528   8576   3840 R   1.0  0.0   0:02.30 top
  301 root      20   0       0      0      0 S   0.3  0.0   0:13.58 ksoftirqd/48
16824 root      20   0  498112  16576  10752 S   0.3  0.0   0:00.97 gsd-smartcard
    1 root      20   0  164672  16512   6016 S   0.0  0.0   0:03.82 systemd
    2 root      20   0       0      0      0 S   0.0  0.0   0:00.06 kthreadd
    4 root       0 -20       0      0      0 I   0.0  0.0   0:00.00 kworker/0:0H
    5 root      20   0       0      0      0 I   0.0  0.0   0:00.14 kworker/u128:0
    7 root       0 -20       0      0      0 I   0.0  0.0   0:00.00 mm_percpu_wq
    8 root      20   0       0      0      0 S   0.0  0.0   0:00.29 ksoftirqd/0
    9 root      20   0       0      0      0 I   0.0  0.0   0:05.67 rcu_sched
   10 root      20   0       0      0      0 I   0.0  0.0   0:00.00 rcu_bh
   11 root      rt   0       0      0      0 S   0.0  0.0   0:00.06 migration/0



tcpreplay -i enahisic2i3 -M 10000 -l 0 link.pcap
tcpreplay -i enahisic2i3 -M 10000 -l 0 link.pcap
tcpreplay -i enahisic2i3 -M 10000 -l 0 link.pcap
Interface pps                      Mbps
-----------------------------------------------------------
0         0                        0
1         423611                   1412
ARM-131# show traffic
-----------------------------------------------------------
Interface pps                      Mbps
-----------------------------------------------------------
0         0                        0
1         424017                   1413
ARM-131# show traffic
-----------------------------------------------------------
Interface pps                      Mbps
-----------------------------------------------------------
0         0                        0
1         423236                   1411
ARM-131# show traffic
