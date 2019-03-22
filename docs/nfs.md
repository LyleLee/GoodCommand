NFS(Network File System)
========================
NFS网络文件系统,可以使不同系统之间共享文件或者目录。
带来的好处, 每台主机消耗更少的硬盘空间，因为可以通过过NFS共享同一个文件。操作远程目录就像在本地一样方便。

## 安装

ubuntu官方教程  
[https://help.ubuntu.com/lts/serverguide/network-file-system.html.en](https://help.ubuntu.com/lts/serverguide/network-file-system.html.en)
```shell-session
# ubuntu服务端
apt install nfs-kernel-server
# ubuntu客户端
apt install nfs-common
```
redhat官方教程
```
yum install nfs-utils
```
## 配置
配置共享文件路径，配置文件是
```
/etc/exports
```
参考内容：
```shell-session
[root@readhat76 ~]# cat /etc/exports
/ubuntu *(ro,sync,no_root_squash)
/home   *(rw,sync,no_root_squash)
/root/nfs-test-dir *(rw,sync,no_root_squash)
```
修改配置文件后，可能需要执行命令以使配置文件生效
```
exportfs -r
```

## 重启服务
```shell-session
# redhat
systemctl restart nfs-server
# ubuntu
systemctl start nfs-kernel-server.service
```

## 查看共享
```shell-session
showmount -e ip
# 在服务端使用showmount查看是否exports成功
showmount -e localhost
```

可以使用systemctl查看服务的名字。

**注意**redhat需要关闭防火墙或者配置防火墙之后才才可以mount  
**注意**redhat需要关闭防火墙或者配置防火墙之后才才可以mount  
**注意**redhat需要关闭防火墙或者配置防火墙之后才才可以mount  



## 挂载

在客户端挂载
```shell-session
mount -o vers=3 192.168.1.227:/root/nfs-test-dir ./1620-mount-point/

# -o 表示option
# vers=3 表示NFSv3
# 192.168.1.227:/root/nfs-test-di 表示挂载服务器下，由前面exports指定的目录
# ./1620-mount-point/   表示本机目录，在本机目录上的操作等同于操作远程目录
```
在客户端卸载
```
umount /root/1620-mount-point/
#如果出现 umount.nfs: /root/1620-mount-point: device is busy，可以使用-f选项
umount -f /root/1620-mount-point/
```


## 查看nfs服务
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

### 设置静态端口

有时候希望nfs服务能运行在指定端口，可以观察到原来使用的端口号如下：
```shell-session
pi@raspberrypi:/etc/default $ rpcinfo -p
   program vers proto   port  service
    100000    4   tcp    111  portmapper
    100000    3   tcp    111  portmapper
    100000    2   tcp    111  portmapper
    100000    4   udp    111  portmapper
    100000    3   udp    111  portmapper
    100000    2   udp    111  portmapper
    100005    1   udp  41487  mountd
    100005    1   tcp  41073  mountd
    100005    2   udp  53337  mountd
    100005    2   tcp  43843  mountd
    100005    3   udp  59561  mountd
    100005    3   tcp  37855  mountd
    100003    3   tcp   2049  nfs
    100003    4   tcp   2049  nfs
    100227    3   tcp   2049
    100003    3   udp   2049  nfs
    100003    4   udp   2049  nfs
    100227    3   udp   2049
    100021    1   udp  47977  nlockmgr
    100021    3   udp  47977  nlockmgr
    100021    4   udp  47977  nlockmgr
    100021    1   tcp  41839  nlockmgr
    100021    3   tcp  41839  nlockmgr
    100021    4   tcp  41839  nlockmgr
```
ubuntu或者树莓派，请参考debian的教程：[https://wiki.debian.org/SecuringNFS](https://wiki.debian.org/SecuringNFS)  
设置完之后的效果
```shell-session
pi@raspberrypi:/media/pi $ rpcinfo -p
   program vers proto   port  service
    100000    4   tcp    111  portmapper
    100000    3   tcp    111  portmapper
    100000    2   tcp    111  portmapper
    100000    4   udp    111  portmapper
    100000    3   udp    111  portmapper
    100000    2   udp    111  portmapper
    100005    1   udp   4002  mountd
    100005    1   tcp   4002  mountd
    100005    2   udp   4002  mountd
    100005    2   tcp   4002  mountd
    100005    3   udp   4002  mountd
    100005    3   tcp   4002  mountd
    100003    3   tcp   2049  nfs
    100003    4   tcp   2049  nfs
    100227    3   tcp   2049
    100003    3   udp   2049  nfs
    100003    4   udp   2049  nfs
    100227    3   udp   2049
    100021    1   udp  32768  nlockmgr
    100021    3   udp  32768  nlockmgr
    100021    4   udp  32768  nlockmgr
    100021    1   tcp  32768  nlockmgr
    100021    3   tcp  32768  nlockmgr
    100021    4   tcp  32768  nlockmgr
```

## 只启用NFSv4
有时候希望只启用NFSv4
```shell-session
vim /etc/default/nfs-kernel-server
#修改
RPCMOUNTDOPTS="--manage-gids"
#变为
RPCMOUNTDOPTS="--manage-gids -N 2 -N 3"
#重启服务
sudo systemctl restart nfs-kernel-server
```

设置之后在客户端可以观察到只有v4成功
```shell-session
ubuntu@ubuntu:~$ sudo mount -t nfs -o vers=3 192.168.1.201:/home/me/syncfile dir_name
mount.nfs: requested NFS version or transport protocol is not supported
ubuntu@ubuntu:~$ sudo mount -t nfs -o vers=2 192.168.1.201:/home/me/syncfile dir_name
mount.nfs: Protocol not supported
ubuntu@ubuntu:~$ sudo mount -t nfs -o vers=4 192.168.1.201:/home/me/syncfile dir_name
```

