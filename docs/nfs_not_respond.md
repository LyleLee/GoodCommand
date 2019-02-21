nfs not responding,flock 问题跟踪
=============
复现过程
```shell-session
[root@readhat76 /tmp]#showmount -e localhost
Export list for localhost:
/root/nfs-test-dir *
[root@readhat76 /tmp]#df -h
Filesystem                       Size  Used Avail Use% Mounted on
devtmpfs                         256G     0  256G   0% /dev
tmpfs                            256G     0  256G   0% /dev/shm
tmpfs                            256G   40M  256G   1% /run
tmpfs                            256G     0  256G   0% /sys/fs/cgroup
/dev/mapper/rhel_readhat76-root   50G  5.1G   45G  11% /
/dev/sdb2                       1014M  125M  890M  13% /boot
/dev/sdb1                        200M  7.8M  193M   4% /boot/efi
/dev/mapper/rhel_readhat76-home  3.6T   33M  3.6T   1% /home
tmpfs                             52G     0   52G   0% /run/user/0
/dev/loop0                       3.0G  3.0G     0 100% /mnt/cd_redhat7.6
localhost:/root/nfs-test-dir      50G  5.1G   45G  11% /tmp
[root@readhat76 /tmp]#ls
gen_test.py  Makefile
[root@readhat76 /tmp]#python gen_test.py 48 4096
Generating testcase 'test1.c ...

Generating testcase 'test2.c ...

Generating testcase 'test3.c ...

Generating testcase 'test4.c ...

Generating testcase 'test5.c ...

Generating testcase 'test6.c ...
```
demsg输出
```console
[   32.712027] IPv6: ADDRCONF(NETDEV_UP): enp189s0f1: link is not ready
[   33.786131] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
[   34.983938] Netfilter messages via NETLINK v0.30.
[   35.017919] ip_set: protocol 6
[   39.130824] nr_pdflush_threads exported in /proc is scheduled for removal
[   40.530250] sctp: Hash tables configured (bind 8192/8192)
[   40.794992] MACsec IEEE 802.1AE
[ 3775.563634] hns3 0000:bd:00.1 enp189s0f1: link up
[ 3775.568350] IPv6: ADDRCONF(NETDEV_CHANGE): enp189s0f1: link becomes ready
[ 3775.578137] hns3 0000:bd:00.1 enp189s0f1: link down
[ 3775.583009] warning: `NetworkManager' uses legacy ethtool link settings API, link modes are only partially reported
[ 5531.853606] usb 1-2.3: new high-speed USB device number 5 using ehci-pci
[ 5532.062999] usb 1-2.3: New USB device found, idVendor=12d1, idProduct=0001
[ 5532.069876] usb 1-2.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[ 5532.077183] usb 1-2.3: Product: DVD-ROM VM 1.1.0
[ 5532.118490] usb-storage 1-2.3:1.0: USB Mass Storage device detected
[ 5532.125043] scsi host3: usb-storage 1-2.3:1.0
[ 5532.129552] usbcore: registered new interface driver usb-storage
[ 5533.210907] scsi 3:0:0:0: CD-ROM            Virtual  DVD-ROM VM 1.1.0  225 PQ: 0 ANSI: 0 CCS
[ 5533.219925] scsi 3:0:0:0: Attached scsi generic sg3 type 5
[ 5533.267759] sr 3:0:0:0: [sr0] scsi3-mmc drive: 0x/0x caddy
[ 5533.273232] cdrom: Uniform CD-ROM driver Revision: 3.20
[ 5533.279123] sr 3:0:0:0: Attached scsi CD-ROM sr0
[ 5618.554367] usb 1-2.3: USB disconnect, device number 5
[ 6807.702162] loop: module loaded
[ 6807.802313] ISO 9660 Extensions: Microsoft Joliet Level 3
[ 6807.802587] ISO 9660 Extensions: Microsoft Joliet Level 3
[ 6807.830170] ISO 9660 Extensions: RRIP_1991A
[ 7806.737833] Ebtables v2.0 unregistered
[54305.878513] RPC: Registered named UNIX socket transport module.
[54305.884439] RPC: Registered udp transport module.
[54305.889132] RPC: Registered tcp transport module.
[54305.893839] RPC: Registered tcp NFSv4.1 backchannel transport module.
[54305.969982] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[54306.096858] NFSD: starting 90-second grace period (net ffff000008e7c480)
[54385.596831] FS-Cache: Loaded
[54385.628479] FS-Cache: Netfs 'nfs' registered for caching
[59831.572637] Key type dns_resolver registered
[59831.612984] NFS: Registering the id_resolver key type
[59831.618046] Key type id_resolver registered
[59831.622217] Key type id_legacy registered
[root@readhat76 /tmp]#
```


# 复现过程

## 系统信息：
```
[root@readhat76 ~]#lscpu
Architecture:          aarch64
Byte Order:            Little Endian
CPU(s):                96
On-line CPU(s) list:   0-95
Thread(s) per core:    1
Core(s) per socket:    48
Socket(s):             2
NUMA node(s):          4
Model:                 0
CPU max MHz:           2000.0000
CPU min MHz:           200.0000
BogoMIPS:              200.00
L1d cache:             64K
L1i cache:             64K
L2 cache:              512K
L3 cache:              32768K
NUMA node0 CPU(s):     0-23
NUMA node1 CPU(s):     24-47
NUMA node2 CPU(s):     48-71
NUMA node3 CPU(s):     72-95
Flags:                 fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics cpuid asimdrdm dcpop
[root@readhat76 ~]#


[root@readhat76 ~]#cat /etc/os-release
NAME="Red Hat Enterprise Linux Server"
VERSION="7.6 (Maipo)"
ID="rhel"
ID_LIKE="fedora"
VARIANT="Server"
VARIANT_ID="server"
VERSION_ID="7.6"
PRETTY_NAME="Red Hat Enterprise Linux Server 7.6 (Maipo)"
ANSI_COLOR="0;31"
CPE_NAME="cpe:/o:redhat:enterprise_linux:7.6:GA:server"
HOME_URL="https://www.redhat.com/"
BUG_REPORT_URL="https://bugzilla.redhat.com/"

REDHAT_BUGZILLA_PRODUCT="Red Hat Enterprise Linux 7"
REDHAT_BUGZILLA_PRODUCT_VERSION=7.6
REDHAT_SUPPORT_PRODUCT="Red Hat Enterprise Linux"
REDHAT_SUPPORT_PRODUCT_VERSION="7.6"
[root@readhat76 ~]#
```


## nfs设置
```shell-session
[root@readhat76 ~]#cat /etc/exports
/root/nfs-test-dir *(rw,sync,no_root_squash)

[root@readhat76 ~]#mount -o vers=3 localhost:/root/nfs-test-dir /root/nfs-client-dir

[root@readhat76 ~]#df
Filesystem                       1K-blocks     Used  Available Use% Mounted on
devtmpfs                         267835008        0  267835008   0% /dev
tmpfs                            267845760        0  267845760   0% /dev/shm
tmpfs                            267845760    41728  267804032   1% /run
tmpfs                            267845760        0  267845760   0% /sys/fs/cgroup
/dev/mapper/rhel_readhat76-root   52403200 12393324   40009876  24% /
/dev/sdb2                          1038336   127428     910908  13% /boot
/dev/sdb1                           204580     7944     196636   4% /boot/efi
/dev/mapper/rhel_readhat76-home 3847258716    33008 3847225708   1% /home
tmpfs                             53569216        0   53569216   0% /run/user/0
/dev/loop0                         3109414  3109414          0 100% /mnt/cd_redhat7.6
localhost:/root/nfs-test-dir      52403200 12392448   40010752  24% /root/nfs-client-dir
```

## 安装GCC
```
[root@readhat76 ~]# makedir gcc8
[root@readhat76 ~]# cd gcc8
[root@readhat76 ~/gcc8]#wget http://ftp.gnu.org/gnu/gcc/gcc-8.1.0/gcc-8.1.0.tar.gz
[root@readhat76 ~/gcc8]#tar xzf gcc-8.1.0.tar.gz
[root@readhat76 ~/gcc8/gcc-8.1.0]#./configure -prefix=/root/nfs-test-dir/gcc8
[root@readhat76 ~/gcc8/gcc-8.1.0]make -j96
[root@readhat76 ~/gcc8/gcc-8.1.0]make install
[root@readhat76 ~/nfs-test-dir]#ls gcc8/bin/
aarch64-unknown-linux-gnu-c++  aarch64-unknown-linux-gnu-gcc-8.1.0  aarch64-unknown-linux-gnu-gcc-ranlib  cpp  gcc-ar      gcov       gfortran
aarch64-unknown-linux-gnu-g++  aarch64-unknown-linux-gnu-gcc-ar     aarch64-unknown-linux-gnu-gfortran    g++  gcc-nm      gcov-dump
aarch64-unknown-linux-gnu-gcc  aarch64-unknown-linux-gnu-gcc-nm     c++                                   gcc  gcc-ranlib  gcov-tool
```

## 更改脚本
```python
[root@readhat76 ~/nfs-test-dir]#cat gen_test.py
#!/usr/bin/env python


    for i in range(1,jnum + 1):
        fpComp.write("(cd $WORKDIR ;")
        #gcc 改为 /root/nfs-client-dir/gcc8/bin/gcc
        fpComp.write("/root/nfs-client-dir/gcc8/bin/gcc -o test"+str(i) + ".o -fPIC -O3 -std=c99 -w -c ")
        fpComp.write("-I$INC test" + str(i) + ".c )&\n")
    fpComp.write("wait\n")

```

## 执行测试
```shell-session
[root@readhat76 ~]# cd nfs-client-dir
[root@readhat76 ~/nfs-client-dir]#make gen_test
[root@readhat76 ~/nfs-client-dir]#make test
[root@readhat76 ~/nfs-client-dir]#make test
rm -rf test*.o
./comp_parallel
set WORKDIR=`pwd`
pwd
set INC=/root/nfs-client-dir/include
[1] 64435
cd /root/nfs-client-dir
[2] 64436
/root/nfs-client-dir/gcc8/bin/gcc -o test1.o -fPIC -O3 -std=c99 -w -c -I/root/nfs-client-dir/include test1.c
cd /root/nfs-client-dir
[3] 64437
/root/nfs-client-dir/gcc8/bin/gcc -o test2.o -fPIC -O3 -std=c99 -w -c -I/root/nfs-client-dir/include test2.c
cd /root/nfs-client-dir
[4] 64438
/root/nfs-client-dir/gcc8/bin/gcc -o test3.o -fPIC -O3 -std=c99 -w -c -I/root/nfs-client-dir/include test3.c
cd /root/nfs-client-dir
[5] 64439
/root/nfs-client-dir/gcc8/bin/gcc -o test4.o -fPIC -O3 -std=c99 -w -c -I/root/nfs-client-dir/include test4.c
cd /root/nfs-client-dir
```

## dmesg
```console
[root@readhat76 ~/nfs-client-dir]#dmesg
[75323.323614] rpc-srv/tcp: nfsd: got error -11 when sending 140 bytes - shutting down socket
[75359.803614] rpc-srv/tcp: nfsd: got error -11 when sending 140 bytes - shutting down socket
[75396.283622] rpc-srv/tcp: nfsd: got error -11 when sending 140 bytes - shutting down socket
[75432.763610] rpc-srv/tcp: nfsd: got error -11 when sending 140 bytes - shutting down socket
[75469.243613] rpc-srv/tcp: nfsd: got error -11 when sending 140 bytes - shutting down socket
[75505.723623] rpc-srv/tcp: nfsd: got error -11 when sending 140 bytes - shutting down socket
[75542.203619] rpc-srv/tcp: nfsd: got error -11 when sending 140 bytes - shutting down socket
[75578.683613] rpc-srv/tcp: nfsd: got error -11 when sending 140 bytes - shutting down socket
[75615.163620] rpc-srv/tcp: nfsd: got error -11 when sending 140 bytes - shutting down socket
[75651.643625] rpc-srv/tcp: nfsd: got error -11 when sending 140 bytes - shutting down socket
[75688.123613] rpc-srv/tcp: nfsd: got error -11 when sending 140 bytes - shutting down socket
[75724.603616] rpc-srv/tcp: nfsd: got error -11 when sending 140 bytes - shutting down socket
[75761.083625] rpc-srv/tcp: nfsd: got error -11 when sending 140 bytes - shutting down socket
[75797.563616] rpc-srv/tcp: nfsd: got error -11 when sending 140 bytes - shutting down socket
[75834.043622] rpc-srv/tcp: nfsd: got error -11 when sending 140 bytes - shutting down socket
```console