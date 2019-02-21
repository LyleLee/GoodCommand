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
