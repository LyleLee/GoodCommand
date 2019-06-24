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
```

# 问题

缺少numa.h, 
```
/home/lixianfa/dpdk/dpdk-stable-17.11.6/lib/librte_eal/linuxapp/eal/eal_memory.c:56:18: fatal error: numa.h: No such file or directory
```
解决办法
```
sudo yum install numactl-devel
```