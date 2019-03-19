fio 硬盘性能测试
===================

## 硬件信息
在开始测试之前先用命令行工具检查硬盘的信息。
```
smartctl -a /dev/sdb
```
一般可以看到类似输出：
```
[root@localhost ~]# smartctl -a /dev/sdb
smartctl 6.6 2017-11-05 r4594 [aarch64-linux-4.18.0-68.el8.aarch64] (local build)
Copyright (C) 2002-17, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Model Family:     Intel 730 and DC S35x0/3610/3700 Series SSDs
Device Model:     INTEL SSDSC2BB800G6
Serial Number:    BTWA7053075K800HGN
LU WWN Device Id: 5 5cd2e4 14da27aab
Firmware Version: G2010150
User Capacity:    800,166,076,416 bytes [800 GB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    Solid State Device
Form Factor:      2.5 inches
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   ACS-2 T13/2015-D revision 3
SATA Version is:  SATA 2.6, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Fri Mar  8 16:46:19 2019 CST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled
```

如果设备安装了raid卡，是看不到硬盘信息的。这个时候只能从iBMC界面查看
```
ubuntu@ubuntu:~$ sudo smartctl -a /dev/sdb
smartctl 6.6 2016-05-31 r4324 [x86_64-linux-4.15.0-46-generic] (local build)
Copyright (C) 2002-16, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Vendor:               AVAGO
Product:              AVAGO
Revision:             4.65
User Capacity:        798,999,183,360 bytes [798 GB]
Logical block size:   512 bytes
Logical Unit id:      0x6500283359349804241c75cf0bb21412
Serial number:        001214b20bcf751c2404983459332800
Device type:          disk
Local Time is:        Fri Mar 15 08:26:35 2019 UTC
SMART support is:     Unavailable - device lacks SMART capability.

=== START OF READ SMART DATA SECTION ===
Current Drive Temperature:     0 C
Drive Trip Temperature:        0 C

Error Counter logging not supported

Device does not support Self Test logging
```
### 查看硬盘分区类型
有时候希望知道把硬盘格式化成什么分区了
```
lsblk -f
```
x86
```
[root@localhost stream]# lsblk -f
NAME              FSTYPE      LABEL UUID                                   MOUNTPOINT
nvme0n1
├─nvme0n1p3       LVM2_member       45XcIA-acC1-knNo-DGqJ-xfJo-qv27-GcTifd
│ ├─centos00-home xfs               f748eb86-1771-42cd-bd36-fe7a469f7994
│ ├─centos00-swap swap              f05c6b1f-66ca-4993-91bf-0983ff4af2b0
│ └─centos00-root xfs               1111403b-8be4-409d-833e-502d1c05ca4f
├─nvme0n1p1
└─nvme0n1p2       xfs               b0c52bf4-94dd-4836-929d-f14998064de9
sda
├─sda2            LVM2_member       F4Y5X8-x7MA-g6E2-3ENx-ye0s-p7e8-eJ3216
│ ├─centos-swap   swap              5150bd1b-e2da-4b9d-9830-cffac4662b9f   [SWAP]
│ ├─centos-home   xfs               17778bbf-b08d-4d50-b35b-033235756827   /home
│ └─centos-root   xfs               ad72866e-5ad3-45fa-b318-79577c783a91   /
└─sda1            xfs               02d582c6-b93a-497d-93bb-da20ba887e51   /boot
```
ARM
```
root@ubuntu:~/app/stream# lsblk -f
NAME   FSTYPE LABEL UUID                                 MOUNTPOINT
sda
├─sda1 vfat         819D-544E                            /boot/efi
└─sda2 ext4         b72d7507-0c9b-4d8e-8546-566649cb34b0 /
sdb
```



