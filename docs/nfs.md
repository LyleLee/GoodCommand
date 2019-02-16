NFS(Network File System)
========================
NFS网络文件系统,可以使不同系统之间共享文件或者目录。
带来的好处, 每台主机消耗更少的硬盘空间，因为可以通过过NFS共享同一个文件。

ubuntu官方教程
[https://help.ubuntu.com/lts/serverguide/network-file-system.html.en](https://help.ubuntu.com/lts/serverguide/network-file-system.html.en)

应该打开那些端口，参考资料[https://discussions.citrix.com/topic/289912-nfs-which-ports-to-open/](https://discussions.citrix.com/topic/289912-nfs-which-ports-to-open/)
```
Looks like:{code}
Sharing filesystems by NFS
Regardless of which choice is made for ID mapping you will need to adjust any firewall the system is using
so that NFS clients can communicate with the server. You will need to ensure that the following ports are
open before sharing any filesystem:
UDP: 111, 1039, 1047, 1048 and 2049.
TCP: 111, 1039, 1047, 1048 and 2049.
```
查看有哪些共享
```
showmount -e ip
```
参考资料[https://www.cnblogs.com/starof/p/4234028.html](https://www.cnblogs.com/starof/p/4234028.html)
查看运行的nfs版本
```shell-session
pi@raspberrypi:/usr/lib/systemd/system $ rpcinfo -p
   program vers proto   port  service
    100000    4   tcp    111  portmapper
    100000    3   tcp    111  portmapper
    100000    2   tcp    111  portmapper
    100000    4   udp    111  portmapper
    100000    3   udp    111  portmapper
    100000    2   udp    111  portmapper
    100005    1   udp  55205  mountd
    100005    1   tcp  52029  mountd
    100005    2   udp  54228  mountd
    100005    2   tcp  42297  mountd
    100005    3   udp  45438  mountd
    100005    3   tcp  56119  mountd
    100003    3   tcp   2049  nfs
    100003    4   tcp   2049  nfs
    100227    3   tcp   2049
    100003    3   udp   2049  nfs
    100003    4   udp   2049  nfs
    100227    3   udp   2049
    100021    1   udp  46797  nlockmgr
    100021    3   udp  46797  nlockmgr
    100021    4   udp  46797  nlockmgr
    100021    1   tcp  42021  nlockmgr
    100021    3   tcp  42021  nlockmgr
    100021    4   tcp  42021  nlockmgr
```