ethtool
=========================
查看和配置网卡的命令行工具

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
        Speed: 1000Mb/s 网口速率
        Duplex: Full
        Port: Twisted Pair
        PHYAD: 0
        Transceiver: internal
        Auto-negotiation: on
        MDI-X: off (auto)
Cannot get wake-on-lan settings: Operation not permitted
        Link detected: yes 网线是否连接

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
large-receive-offload: off [fixed] fixed 代表默认配置
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