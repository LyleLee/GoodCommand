ubuntu软件包管理
=================
经常需要知道改安装什么软件， linux下安装软件不像windows那么傻瓜。软件包装上来之后，一段时间不用你甚至会把命令忘记了，软件就不存在了。当前装的软件是什么版本，怎么查询某个包提供什么命令，这些问题时常困扰着我们。

## 查询某个可用软件包。
例如现在想要安装nfs，但是不知道该下载什么包，也不知道什么包相关，可以使用命令查询
```shell-session
#列出所有可用软件包
apt-cache pkgnames
#查询nfs相关的软件包
root@ubuntu:~# apt-cache pkgnames | grep nfs
daemonfs
nfs-ganesha-nullfs
argonaut-fai-nfsroot
nfs-ganesha
nfs-ganesha-doc
libfile-nfslock-perl
nfs-kernel-server #一般来说我们只需要安装这个就可以了
nfs-ganesha-proxy
unionfs-fuse
libyanfs-java
nfswatch
python-nfs-ganesha
nfs-ganesha-mem
nfstrace-doc
libnfs-dev
nfs-ganesha-mount-9p
nfstrace
nfs-ganesha-gluster
nfs-ganesha-vfs
nfs-ganesha-xfs
libnfs11
libnfsidmap-dev
nfs4-acl-tools
fai-nfsroot
nfs-ganesha-gpfs
nfs-common
libnfsidmap2

# 也可以使用
apt search nfs来查询
```
具体安装教程可以参考[nfs](nfs.md)

## 查看软件包信息
查看软件的大小，版本，依赖，项目主页，功能信息等
```shell-session
apt search iperf3 由命令或者名称，搜索适用与当前版本的软件包
apt show iperf3  可以查询已安装的或者未安装的软件包信息
dpkg -s coreutils 查询已安装的软件包信息
```
```shell-session
root@ubuntu:~# apt show iperf3
Package: iperf3
Version: 3.1.3-1
Priority: optional
Section: universe/net
Origin: Ubuntu
Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
Original-Maintainer: Raoul Gunnar Borenius <borenius@dfn.de>
Bugs: https://bugs.launchpad.net/ubuntu/+filebug
Installed-Size: 41.0 kB
Depends: libc6 (>= 2.17), libiperf0
Homepage: http://software.es.net/iperf/
Download-Size: 8,788 B
APT-Sources: https://mirrors.huaweicloud.com/ubuntu-ports bionic/universe arm64 Pack                                                                                                         ages
Description: Internet Protocol bandwidth measuring tool
 Iperf3 is a tool for performing network throughput measurements. It can
 test either TCP or UDP throughput.
 .
 This is a new implementation that shares no code with the original
 iperf from NLANR/DAST and also is not backwards compatible.
 .
 This package contains the command line utility.
```

## 查看dep包信息
```
dpkg --info dpkg --info ceph_12.2.11-0ubuntu0.18.04.1_arm64.deb
```
## 查看命令对应的软件包
有时候我们知道一个命令，想要知道哪个软件包提供这个命令。
```shell-session
dpkg -S vim
dpkg -S /usr/bin/vim
dpkg --search vim
dpkg-query --search vim
#这三条命令等价，搜索本地已安装的软件包，会给出包含vim关键字的软件包名称和路径

apt-file search kvm-ok              根据命令名字搜索
apt-file search '/usr/bin/rsync'    根据命令路径搜索
可以查找安装的或者未安装的包，给出包含kvm-ok命令的软件包和路径

apt search virsh
```

## 升级系统中的所有软件
这会升级系统所有已经安装的软件到最新版本，未安装的不会安装，未安装的依赖不安装，也就是只升级不安装。
```
sudo apt upgrade
```
## 升级指定软件
其实和安装命令一样，如果有版本更新会自动安装。
```
sudo apt install iperf3
```

## 安装指定版本的软件
但是感觉没有什么用，一般一个发行代号只提供一个版本。
```
sudo apt intall vsftpd=2.3.5-3ubuntu1
```
## 卸载软件
```
sudo apt remove iperf3 #卸载软件，但是不会删除配置
sudo apt purge ipef3 #purge会卸载软件的同时删除所有配置
```
## 下载源码

```
sudo apt --download-only source iperf3  #下载不解压
sudo apt source ipef3                   #下载并解压
apt --compile source iperf3             #下载并编译

```
如果没有在sources.list中设置软包url会出现：
```
Reading package lists... Done
E: You must put some 'source' URIs in your sources.list
```
在软件源文件中取消dev-src行前的注释,然后执行apt update。 软件源的更多配置，请参考[ubuntu 软件源](ubuntu_sources_list.md)

## 下载二进制包
```
apt download iperf3
apt download --print-uris  iperf3 #显示软件包下载地址，获取url

sudo apt install --download-only python-pecan #下载所有二进制包，包含依赖，不安装。下载位置是/var/cache/apt/archives

```
## 搜索并编译软件依赖
```
apt build-dep iperf3
```

## 例子
我们知道系统中有ssh命令，但是不知道是哪个软件包提供的。  
首先先用which命令确认执行的是哪一个ssh命令
```shell-session
root@ubuntu:~# which ssh
/usr/bin/ssh
```
查找提供命令的软件包
```shell-session
root@ubuntu:~# dpkg -S /usr/bin/ssh
openssh-client: /usr/bin/ssh
```
再查询软件包penssh-client的信息
```shell-session
root@ubuntu:~# dpkg -s openssh-client
Package: openssh-client
Status: install ok installed
Priority: standard
Section: net
Installed-Size: 3732
Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
Architecture: arm64
Multi-Arch: foreign
Source: openssh
Version: 1:7.6p1-4
Replaces: ssh, ssh-krb5
Provides: rsh-client, ssh-client
```
