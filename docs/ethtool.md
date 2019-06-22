ethtool
=========================
查看和配置网卡的命令行工具

```
ethtool -p enP2p233s0f1		#端口闪灯，识别是哪一个物理网口
```

查看网卡enahisic2i0的基本参数
```shell-session
me@ubuntu:~$ ethtool enahisic2i0
Settings for enahisic2i0:
        Supported ports: [ TP ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
        Supported pause frame use: Symmetric
        Supports auto-negotiation: Yes
        Supported FEC modes: Not reported
        Advertised link modes:  1000baseT/Full
        Advertised pause frame use: No
        Advertised auto-negotiation: Yes
        Advertised FEC modes: Not reported
        Link partner advertised link modes:  10baseT/Full
                                             100baseT/Full
                                             1000baseT/Full
        Link partner advertised pause frame use: No
        Link partner advertised auto-negotiation: Yes
        Link partner advertised FEC modes: Not reported
        Speed: 1000Mb/s #网口速率
        Duplex: Full
        Port: Twisted Pair
        PHYAD: 0
        Transceiver: internal
        Auto-negotiation: on
        MDI-X: off (auto)
Cannot get wake-on-lan settings: Operation not permitted
        Link detected: yes #网线是否连接

```

查看网卡驱动
```shell-session
me@ubuntu:~$ ethtool -i enahisic2i0
driver: hns 驱动
version: 2.0 驱动版本
firmware-version: N/A
expansion-rom-version:
bus-info: platform
supports-statistics: yes
supports-test: yes
supports-eeprom-access: no
supports-register-dump: yes
supports-priv-flags: no
me@ubuntu:~$
```

查看网卡高级设置
```shell-session
me@ubuntu:~$ sudo ethtool -k enahisic2i0
[sudo] password for me:
Features for enahisic2i0:
rx-checksumming: on
tx-checksumming: on
        tx-checksum-ipv4: on
        tx-checksum-ip-generic: off [fixed]
        tx-checksum-ipv6: on
        tx-checksum-fcoe-crc: off [fixed]
        tx-checksum-sctp: off [fixed]
scatter-gather: on
        tx-scatter-gather: on
        tx-scatter-gather-fraglist: off [fixed]
tcp-segmentation-offload: on
        tx-tcp-segmentation: on
        tx-tcp-ecn-segmentation: off [fixed]
        tx-tcp-mangleid-segmentation: off
        tx-tcp6-segmentation: on
udp-fragmentation-offload: off
generic-segmentation-offload: on
generic-receive-offload: on
large-receive-offload: off [fixed] #fixed 代表默认配置
rx-vlan-offload: off [fixed]
tx-vlan-offload: off [fixed]
ntuple-filters: off [fixed]
receive-hashing: off [fixed]
highdma: off [fixed]
rx-vlan-filter: off [fixed]
vlan-challenged: off [fixed]
tx-lockless: off [fixed]
netns-local: off [fixed]
tx-gso-robust: off [fixed]
tx-fcoe-segmentation: off [fixed]
tx-gre-segmentation: off [fixed]
tx-gre-csum-segmentation: off [fixed]
tx-ipxip4-segmentation: off [fixed
```

打开或者关闭网卡参数
```shell-session
ethtool -K enp125s0f2 rx-vlan-offload off
ethtool -K enp125s0f2 tx-vlan-offload off
ethtool -K enp125s0f2 rx-vlan-filter off
ethtool -K enp125s0f2 tx-gre-segmentation off
ethtool -K enp125s0f2 tx-udp_tnl-segmentation on
ethtool -K enp125s0f2 tx-udp_tnl-csum-segmentation on
```

## 网卡队列和中断

**1、判断当前系统环境是否支持多队列网卡，执行命令:**
```
lspci -vvv
```

```
root@ubuntu:~# lspci -vvv | grep MSI-X
pcilib: sysfs_read_vpd: read failed: Input/output error
pcilib: sysfs_read_vpd: read failed: Input/output error
        Capabilities: [c0] MSI-X: Enable+ Count=97 Masked-
        Capabilities: [70] MSI-X: Enable+ Count=64 Masked-
        Capabilities: [70] MSI-X: Enable+ Count=64 Masked-
pcilib: sysfs_read_vpd: read failed: Input/output error

```
如果在Ethernet项中。含有`Capabilities: [c0] MSI-X: Enable+ Count=97 Masked-`语句，则说明当前系统环境是支持多队列网卡的，否则不支持。


**2、查看网卡接口是否支持多队列，最多支持多少、当前开启多少**

```
ethtool -l eth0
```
不同设备的输出结果 [[ethtool -l结果]](resources/ethtool-l.md)

ARM
```
me@ubuntu:~$ ethtool -l enahisic2i0
Channel parameters for enahisic2i0:
Pre-set maximums:
RX:             16
TX:             16
Other:          0
Combined:       0
Current hardware settings:
RX:             16
TX:             16
Other:          0
Combined:       0
```

X86
```
root@ubuntu:~# ethtool -l enp2s0f0
Channel parameters for enp2s0f0:
Pre-set maximums:
RX:             0
TX:             0
Other:          1
Combined:       63
Current hardware settings:
RX:             0
TX:             0
Other:          1
Combined:       63
```


**3、设置网卡当前使用多队列。**

```
ethtool -L eth0 combined <N>  #N为要使能的队列数
```

## 在96核ARM服务器上试验
```shell-session
[root@localhost ~]# ethtool -l eno3
Channel parameters for eno3:
Pre-set maximums:
RX:             0
TX:             0
Other:          1
Combined:       8
Current hardware settings:
RX:             0
TX:             0
Other:          1
Combined:       8

[root@localhost ~]# ethtool -L eno3 combined 4

[root@localhost ~]# ethtool -l eno3
Channel parameters for eno3:
Pre-set maximums:
RX:             0
TX:             0
Other:          1
Combined:       8
Current hardware settings:
RX:             0
TX:             0
Other:          1
Combined:       4

[root@localhost ~]#
```

**4、要确保多队列确实生效，可以查看文件**
```
root@ubuntu:~# ls /sys/class/net/enp2s0f0/queues/
rx-0   rx-14  rx-2   rx-25  rx-30  rx-36  rx-41  rx-47  rx-52  rx-58  rx-7   tx-11  tx-17  tx-22  tx-28  tx-33  tx-39  tx-44  tx-5   tx-55  tx-60
rx-1   rx-15  rx-20  rx-26  rx-31  rx-37  rx-42  rx-48  rx-53  rx-59  rx-8   tx-12  tx-18  tx-23  tx-29  tx-34  tx-4   tx-45  tx-50  tx-56  tx-61
rx-10  rx-16  rx-21  rx-27  rx-32  rx-38  rx-43  rx-49  rx-54  rx-6   rx-9   tx-13  tx-19  tx-24  tx-3   tx-35  tx-40  tx-46  tx-51  tx-57  tx-62
rx-11  rx-17  rx-22  rx-28  rx-33  rx-39  rx-44  rx-5   rx-55  rx-60  tx-0   tx-14  tx-2   tx-25  tx-30  tx-36  tx-41  tx-47  tx-52  tx-58  tx-7
rx-12  rx-18  rx-23  rx-29  rx-34  rx-4   rx-45  rx-50  rx-56  rx-61  tx-1   tx-15  tx-20  tx-26  tx-31  tx-37  tx-42  tx-48  tx-53  tx-59  tx-8
rx-13  rx-19  rx-24  rx-3   rx-35  rx-40  rx-46  rx-51  rx-57  rx-62  tx-10  tx-16  tx-21  tx-27  tx-
```


