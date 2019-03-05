KVM 常用命令
=====================
有一天需要安装ceph集群来看看分布式系统的性能，想找几台机器来测测，一看发现至少需要3台，突然发现自己很穷，起个虚拟机吧。  
有一天需要整点危险的事情，服务器只有一台怕搞坏被集体群殴，起个虚拟机吧。  
有一天需要装个操作系统看看redhat好还是ubuntu好， 起个虚拟机吧。  
那就起个虚拟机吧。  怎么起？ 和在window一样装个VMware或者virtualbox，然后挂上ISO。以前都是这么搞的。坏处就是慢、久、坑。还是在linux上搞好一点。  
咨询一下大佬，用KVM好！  
具体是参考：[地址](https://www.sysgeek.cn/install-configure-kvm-ubuntu-18-04/) ，图文教程，感觉还是挺良心的。  
如果还是懒，参考步骤

## 看看你的服务器到底支不支持。

```shell-session
sudo apt install cpu-checker
sudo kvm-ok
me@ubuntu:~/virtual_machine$ sudo kvm-ok
[sudo] password for me:
INFO: /dev/kvm exists
KVM acceleration can be used
```

## 安装qemu工具
ubuntu18.04验证通过过
```shell-session
sudo apt-get install qemu-kvm libvirt-bin bridge-utils virtinst
#如果需要图形化管理界面：
sudo apt-get install virt-manager
```
redhat8.0 arm验证通过
```shell-session
yum install qemu-kvm libvirt virt-install
```
## 部署网络
主要是为了虚拟机起来之后可以直接联网，安装各种软件方便。 也可以先跳过这一步，先部署虚拟机
参考[参考地址](https://segmentfault.com/a/1190000015418876)
我选择的是网桥模式，主要是修改好配置文件之后重启网络即可。  
ubuntu18.04网络配置文件：`/etc/netplan/01-netcfg.yaml`  
redhat7.5、redhat8.0网络配置文件：`/etc/sysconfig/network-scripts/ifcfg-enp1s0`,参考[linux网络操作](linux.md#_5)  
路径一般是对的，文件名有可能不一样。
```shell-session
me@ubuntu:/etc/netplan$ cat 01-netcfg.yaml
# This file describes the network interfaces available on your system
# For more information, see netplan(5).
network:
  version: 2
  renderer: networkd
  ethernets:
    enahisic2i0:
      dhcp4: yes
    enahisic2i1:
      dhcp4: yes
    enahisic2i2:
      dhcp4: yes
    enahisic2i3:
      dhcp4: yes

  bridges:
        virbr0:
                interfaces: [enahisic2i0]
                dhcp4: yes
                addresses: [192.168.1.201/24]
                gateway4: 192.168.1.2
                nameservers:
                        addresses: [127.0.0.53]
me@ubuntu:/etc/netplan$
```
    本人主机上有4个网口，网卡enahisic2i0上有内网IP，安装好kvm工具后会自动生成网桥virbr0，使用`ip a`可以查到，这里是把enahisic2i0加到了网桥上，这样后面加入的虚拟机也会自己挂到这个网桥上，即可和外部网络接通，这里的网关，和nameservers保持和原来主机上的一致即可。
## 创建一台虚拟机
可以想到：需要指定虚拟机的CPU、内存、硬盘，ISO文件等。  命令写成一行装不下，写成多行，把下面的命令保存为文件，添加执行权限，执行即可。

例如脚本1：install_ubuntu.sh
改脚本已经在host机为ubuntu18.04时验证通过，无报错
```sh
#!/bin/bash
#install_ubuntu.sh
sudo virt-install               \
 --name ubuntu_1              \
 --description "ubuntu vm setup for ceph"       \
 --os-type linux                \
 --os-variant "ubuntu18.04"     \
 --memory 4096                  \
 --vcpus 2                      \
 --disk path=/var/lib/libvirt/images/ubuntu_1.img,bus=virtio,size=50  \
 --network bridge:virbr0                                \
 --accelerate                                           \
 --graphics vnc,listen=0.0.0.0,keymap=en-us             \
 --location /home/me/ubuntu-18.04-server-arm64.iso      \
 --extra-args console=ttyS0
```
```
--name ubuntu_1                 是虚拟机的名字，待会儿查看有多少台虚拟机时会列出来的名字，并不是虚拟机的主机名。
--os-variant "ubuntu18.04"      必须是指定的版本，可以使用命令查询osinfo-query os 如果缺少相应软件包：sudo apt install libosinfo-bin
--memory                        4096指定虚拟机的内存，以M为单位，这里是4个G。也就是4*1024
--vcpus 2                       指定虚拟机的CPU数量
--disk path                     指定虚拟机的硬盘文件，也就是虚拟机的硬盘，大小是50G。
--network bridge:virbr0         指定链接到的网桥，请用自己主机上对应的网桥，具体参考KVM网络配置
--graphics vnc,listen=0.0.0.0,keymap=en-us  据说可以用VNC看到图形界面， 我没有图形界面环境，没研究什么意思
--extra-args console=ttyS0      指定登陆虚拟机的串口，非常重要，进入虚拟机有三种方式：SSH、VNS、串口，这里是串口的配置。
```


例如脚本2：install_vm.sh
一个可供选择的简单脚本（没有vnc图形界面）。改脚本在redhat8.0上验证通过。。
```
#!/bin/bash
virt-install \
  --name suse \
  --memory 2048 \
  --vcpus 2 \
  --disk size=20 \
  --cdrom /root/iso/SLE-15-SP1-Installer-DVD-aarch64-Beta4-DVD1.iso
```

执行安装：
使用脚本1：
```shell-session
sudo chmod +x install_ubuntu.sh
./install_ubuntu.sh
```
使用脚本2
```shell-session
sudo chmod +x install_vm.sh
./install_vm.sh
```

由于redhat和ubuntu环境不同，使用脚本时可能会报两种错误, 解决办法见后文报错处理
```
1. Failed to connect socket
2. Could not open '/root/iso/SLE-15-SP1-Installer-DVD-aarch64-Beta4-DVD1.iso': Permission denied
```
## 查看当前虚拟机
```shell-session
virsh list -all
```
## 通过串口登录虚拟机
```shell-session
virsh console ubuntu_1
```
## 启动VM
```shell-session
virsh start ubuntu_2
```
## 停止VM，
```shell-session
virsh shutdown ubuntu_2
```
## 删除VM
```shell-session
virsh destroy ubuntu_2
virsh undefine ubuntu_2
virsh undefine ubuntu_2 --nvram
```
## 克隆VM
有时候发现一台装系统太慢了，直接复制一下多好，这个时候就可以用克隆工具完成。克隆需要虚拟机暂停运行，可以使用前面的shutdown命令停止。
克隆完成之后最好查看一下各个虚拟机的mac地址是否相同，一般现在工具可以自动生成，这样可以避免MAC地址冲突，结果就是dhcp分配的一个ip地址在两台虚拟机上变来变去。
```sh
sudo virt-clone \
        --original ubuntu_1     \
        --name ubuntu_7         \
        --auto-clone

```
   强烈建议确认mac地址不一样之后，在每台虚拟机里面重启网络服务，等待DHCP分配地址。由于我装的是ubuntu18.04，我的命令是如下，其他系统请自行搜索。
```
sudo systemctl restart systemd-networkd.serivce
```
## 查看网络信息
```sh
virsh net-list
virsh net-info default
virsh net-dhcp-leases default
```
## 添加或者卸载硬盘
搞着搞着会发现50G的硬盘可能不够用，这个时候想给虚拟机再挂一个硬盘
```sh
#主机上创建硬盘文件100G，也有其他类型的硬盘例如RAW，请自行搜索
sudo qemu-img create -f qcow2 ubuntu_vm7_disk_100G 100G
#查看创建好的镜像信息
qemu-img info ubuntu_vm7_disk_100G
#添加到虚拟机上，vdb需要是虚拟机ubuntu_7上未使用的盘符，必须制定驱动，--subdriver=qcow2，否则虚拟机里面看不到
virsh attach-disk ubuntu_7 /var/lib/libvirt/images/ubuntu_vm7_disk_100G vdb --subdriver=qcow2
#卸载可以使用detach命令
virsh detach-disk ubuntu_7 /var/lib/libvirt/images/ubuntu_vm7_disk_100G
#这个时候进入虚拟机中
virsh console ubuntu_7
#执行下面的命令就可以观察到硬盘
fdisk -l
lsblk
#可以创建文件系统
sudo mke2fs -t ext4 /dev/vdb
#挂在硬盘
mount /dev/vdb /mnt/data_disk

#其他虚拟机操作类似
virsh attach-disk ubuntu_1 /var/lib/libvirt/images/ubuntu_vm1_disk_100G vdb --subdriver=qcow2
virsh attach-disk ubuntu_2 /var/lib/libvirt/images/ubuntu_vm2_disk_100G vdb --subdriver=qcow2
virsh attach-disk ubuntu_3 /var/lib/libvirt/images/ubuntu_vm3_disk_100G vdb --subdriver=qcow2
virsh attach-disk ubuntu_4 /var/lib/libvirt/images/ubuntu_vm4_disk_100G vdb --subdriver=qcow2
virsh attach-disk ubuntu_5 /var/lib/libvirt/images/ubuntu_vm5_disk_100G vdb --subdriver=qcow2
virsh attach-disk ubuntu_6 /var/lib/libvirt/images/ubuntu_vm6_disk_100G vdb --subdriver=qcow2
```
## 编辑虚拟机配置文件
```
virsh edit ubuntu_1
```
可以查询到images文件保存的路径为
```
/var/lib/libvirt/images
```
## 日志文件
```
$HOME/.virtinst/virt-install.log        #virt-install tool log file.
$HOME/.virt-manager/virt-manager.log    #virt-manager tool log file.
/var/log/libvirt/qemu/                  #VM的运行日志，每个VM一个文件
```
## 网络NAT模式
前面的网桥模式一般来说可以满足比较普遍的需求。 如果不希望外部网络知道虚机的网络结构，可以选中NAT模式。
这里涉及两个配置文件,内容差不多，2019年3月1日17:26:03还不知道主要用途。
```
1. /usr/share/libvirt/networks/default.xml
<network>
  <name>default</name>
  <bridge name="virbr0"/>
  <forward/>
  <ip address="192.168.122.1" netmask="255.255.255.0">
    <dhcp>
      <range start="192.168.122.2" end="192.168.122.254"/>
    </dhcp>
  </ip>
</network>


2. /etc/libvirt/qemu/networks/default.xml
<!--
WARNING: THIS IS AN AUTO-GENERATED FILE. CHANGES TO IT ARE LIKELY TO BE
OVERWRITTEN AND LOST. Changes to this xml configuration should be made using:
  virsh net-edit default
or other application using the libvirt API.
-->

<network>
  <name>default</name>
  <uuid>5b8f9cf9-cbd2-4461-83e6-2ac31ad8f9e6</uuid>
  <forward mode='nat'/>
  <bridge name='virbr0' stp='on' delay='0'/>
  <mac address='52:54:00:fe:91:35'/>
  <ip address='192.168.122.1' netmask='255.255.255.0'>
    <dhcp>
      <range start='192.168.122.2' end='192.168.122.254'/>
    </dhcp>
  </ip>
</network>

```


## 报错处理
**无法连接到libvirt-sock**
```
[root@localhost ~]# ./install_vm.sh
ERROR    Failed to connect socket to '/var/run/libvirt/libvirt-sock': No such file or directory
```
解决
```
systemctl start libvirtd
```
**无法读取iso，权限不对**
```
Starting install...
Allocating 'suse-02.qcow2'                                                                                                                       |  20 GB  00:00:01
ERROR    internal error: qemu unexpectedly closed the monitor: 2019-03-01T03:15:50.278936Z qemu-kvm: -drive file=/root/iso/SLE-15-SP1-Installer-DVD-aarch64-Beta4-DVD1.iso,format=raw,if=none,id=drive-scsi0-0-0-1,readonly=on: Could not open '/root/iso/SLE-15-SP1-Installer-DVD-aarch64-Beta4-DVD1.iso': Permission denied
Removing disk 'suse-02.qcow2'                                                                                                                    |    0 B  00:00:00
Domain installation does not appear to have been successful.
```
解决办法
```
vim /etc/libvirt/qemu.conf
```
取消`user = "root"`和`group = "root"`前面的注释并重启
```
#
user = "root"

# The group for QEMU processes run by the system instance. It can be
# specified in a similar way to user.
group = "root"

# Whether libvirt should dynamically change file ownership
```
```
systemctl restart libvirtd
```