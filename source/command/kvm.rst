****************************
kvm
****************************

有一天需要安装ceph集群来看看分布式系统的性能，想找几台机器来测测，一看发现至少需要3台，机器不够怎么办，起一个虚拟机。

有一天需要整点危险的事情，如果在服务器上搞，容易导致设备数据损坏，导致其他任务影响。

有一天需要装个操作系统看看redhat好还是ubuntu好，
在物理机上装实在太久了，用虚拟机好一些。

怎么搞虚拟机？和在window一样装个VMware或者virtualbox，然后挂上ISO。以前都是这么搞的。坏处就是慢、久、坑。还是在linux上搞好一点。

**KVM就是我们一直寻找的东西**\ 下面在ARM64设备上进行操作。

看看你的服务器到底支不支持。
----------------------------

.. code:: shell-session

   sudo apt install cpu-checker
   sudo kvm-ok
   me@ubuntu:~/virtual_machine$ sudo kvm-ok
   [sudo] password for me:
   INFO: /dev/kvm exists
   KVM acceleration can be used

安装qemu工具
------------

ubuntu18.04验证通过过

.. code:: shell-session

   sudo apt-get install qemu-kvm libvirt-bin bridge-utils virtinst
   #如果需要图形化管理界面：
   sudo apt-get install virt-manager

redhat8.0 CentOS7.6 arm验证通过

.. code:: shell-session

   yum install qemu-kvm libvirt virt-install

创建一台虚拟机
--------------

可以想到：需要指定虚拟机的CPU、内存、硬盘，ISO文件等。
命令写成一行装不下，写成多行，把下面的命令保存为文件，添加执行权限，执行即可。

**脚本1：./install_ubuntu.sh**

在ubuntu18.04 安装一个ubuntu18.04虚机

.. code:: sh

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

::

   --name ubuntu_1                 是虚拟机的名字，待会儿查看有多少台虚拟机时会列出来的名字，并不是虚拟机的主机名。
   --os-variant "ubuntu18.04"      必须是指定的版本，可以使用命令查询osinfo-query os 如果缺少相应软件包：sudo apt install libosinfo-bin
   --memory                        4096指定虚拟机的内存，以M为单位，这里是4个G。也就是4*1024
   --vcpus 2                       指定虚拟机的CPU数量
   --disk path                     指定虚拟机的硬盘文件，也就是虚拟机的硬盘，大小是50G。
   --network bridge:virbr0         指定链接到的网桥，请用自己主机上对应的网桥，具体参考KVM网络配置
   --graphics vnc,listen=0.0.0.0,keymap=en-us  据说可以用VNC看到图形界面， 我没有图形界面环境，没研究什么意思
   --extra-args console=ttyS0      指定登陆虚拟机的串口，非常重要，进入虚拟机有三种方式：SSH、VNS、串口，这里是串口的配置。

**脚本2：./install_vm.sh**

一个可供选择的简单脚本（没有vnc图形界面）。改脚本在redhat8.0上验证通过。。

::

   #!/bin/bash
   virt-install \
     --name suse \
     --memory 2048 \
     --vcpus 2 \
     --disk size=20 \
     --cdrom /root/iso/SLE-15-SP1-Installer-DVD-aarch64-Beta4-DVD1.iso

**脚本3：./install_vm.sh**

在CentOS7.6上安装CentOS7.6

::

   #!/bin/bash
   virt-install \
     --name CentOS7.6 \
     --os-variant "centos7.0" \
     --memory 8192 \
     --vcpus 4 \
     --disk size=20 \
     --graphics vnc,listen=0.0.0.0,keymap=en-us \
     --location /home/me/isos/CentOS-7-aarch64-Minimal-1810.iso \
     --extra-args console=ttyS0

提示安装成功后可以使用命令查看设备。

::

   [me@centos ~]$ virsh list --all
    Id    Name                           State
   ----------------------------------------------------
    1     CentOS7.6                      running
    2     2-centos7.6                    running

部署网络
--------

ubuntu18.04网络配置文件：\ ``/etc/netplan/01-netcfg.yaml``

CentOS7、redhat7.5、redhat8.0网络配置文件：
``/etc/sysconfig/network-scripts/ifcfg-enp1s0``,参考\ `linux网络操作 <linux.md#_5>`__

这里给出两个例子：

host机Bridge模式ubuntu 8.0
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

路径一般是对的，文件名有可能不一样。

.. code:: shell-session

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

本人主机上有4个网口，网卡enahisic2i0上有内网IP，安装好kvm工具后会自动生成网桥virbr0，
使用\ ``ip a``\ 可以查到，这里是把enahisic2i0加到了网桥上，这样后面加入的虚拟机也会自己挂到这个网桥上，
即可和外部网络接通，这里的网关，和nameservers保持和原来主机上的一致即可。

host机Bridge模式 CentOS 7.6
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


设置host的网络。 我的设备联网的网口是enp189s0f0，一般情况下，
它会dhcp获得一个IP地址。 安装kvm之后， 会生成一个bridge设备：virbr0。
需要设置virbr0自动获取IP地址，并且把enp189s0f0添加到virbr0 slave
device当中。

.. code-block:: shell

   sudo brctl addif virbr0 enp189s0f0  # 把接口添加到虚拟交换机当中
   sudo brctl show                     # 显示配置结果

虚拟机设置
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

   virsh edit CentOS7.6

使用脚本3创建的VM的interface字段是：

::

       <interface type='user'>
         <mac address='52:54:00:bf:37:a0'/>
         <model type='virtio'/>
         <address type='pci' domain='0x0000' bus='0x01' slot='0x00' function='0x0'/>
       </interface>

修改user为bridge， 添加：

::

       <interface type='bridge'>
         <mac address='52:54:00:bf:37:a0'/>
         <source bridge='virbr0'/>
         <model type='virtio'/>
         <address type='pci' domain='0x0000' bus='0x01' slot='0x00' function='0x0'/>
       </interface>


查看配置结果：

.. code-block:: shell

   [user1@centos ~]$ sudo brctl show
   bridge name     bridge id               STP enabled     interfaces
   virbr0          8000.00182d04005c       yes             enp189s0f0
                                                         tap0
   [user1@centos ~]$

如果没有看到新添加的tap0， 需要关机重启一下：

.. code-block:: shell

   virsh shutdown vm1
   virsh start vm1


设置之后，在host的bridge上会自动添加一个tab设备。这个时候重新进入VM就可以看到VM已经获得了和
Host一样的由DHCP服务器分配的地址：

::

   2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
       link/ether 52:54:00:0a:e3:0c brd ff:ff:ff:ff:ff:ff
       inet 192.168.2.216/24 brd 192.168.2.255 scope global noprefixroute dynamic eth0
          valid_lft 86363sec preferred_lft 86363sec
       inet6 fe80::1be7:b0db:e5af:65ab/64 scope link tentative noprefixroute dadfailed
          valid_lft forever preferred_lft forever
       inet6 fe80::2a4a:917b:1d4a:a231/64 scope link noprefixroute
          valid_lft forever preferred_lft forever


查看当前虚拟机
--------------

.. code:: shell-session

   virsh list --all

通过串口登录虚拟机
------------------

.. code:: shell-session

   virsh console ubuntu_1

退出串口登录
------------

::

   ctrl + ]

启动VM
------

.. code:: shell-session

   virsh start ubuntu_2

停止VM，
--------

.. code:: shell-session

   virsh shutdown ubuntu_2

删除VM
------

.. code:: shell-session

   virsh destroy ubuntu_2
   virsh undefine ubuntu_2
   virsh undefine ubuntu_2 --nvram

克隆VM
------

有时候发现一台装系统太慢了，直接复制一下多好，这个时候就可以用克隆工具完成。克隆需要虚拟机暂停运行，可以使用前面的shutdown命令停止。
克隆完成之后最好查看一下各个虚拟机的mac地址是否相同，一般现在工具可以自动生成，这样可以避免MAC地址冲突，结果就是dhcp分配的一个ip地址在两台虚拟机上变来变去。

.. code:: sh

   sudo virt-clone \
           --original ubuntu_1     \
           --name ubuntu_7         \
           --auto-clone

强烈建议确认mac地址不一样之后，在每台虚拟机里面重启网络服务，等待DHCP分配地址。由于我装的是ubuntu18.04，我的命令是如下，其他系统请自行搜索。

::

   sudo systemctl restart systemd-networkd.serivce

查看网络信息
------------

.. code:: sh

   virsh net-list
   virsh net-info default
   virsh net-dhcp-leases default

动态添加网卡
----------------

.. code-block:: shell

    virsh attach-interface vm3 --type bridge --source br0
    virsh detach-interface --domain vm3 --type bridge --mac 52:54:00:f8:bd:31

添加或者卸载硬盘
----------------

搞着搞着会发现50G的硬盘可能不够用，这个时候想给虚拟机再挂一个硬盘

.. code:: sh

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

编辑虚拟机配置文件
------------------

::

   virsh edit ubuntu_1

可以查询到images文件保存的路径为

::

   /var/lib/libvirt/images

日志文件
--------

::

   $HOME/.virtinst/virt-install.log        #virt-install tool log file.
   $HOME/.virt-manager/virt-manager.log    #virt-manager tool log file.
   /var/log/libvirt/qemu/                  #VM的运行日志，每个VM一个文件

网络NAT模式
-----------

前面的网桥模式一般来说可以满足比较普遍的需求。
如果不希望外部网络知道虚机的网络结构，可以选中NAT模式。

默认情况下有一个default网络在运行

.. code-block:: console

   [user1@kunpeng920 ~]$ sudo virsh net-list --all
   [sudo] password for user1:
   Name                 State      Autostart     Persistent
   ----------------------------------------------------------
   default              active     yes           yes


sudo virsh net-edit default 可以看到配置的网络内容， 有一个virbr0的网桥

.. code-block:: xml

   <network>
   <name>default</name>
   <uuid>17642016-bbbc-48e0-9404-bbd0b5d3f74b</uuid>
   <forward mode='nat'/>
   <bridge name='virbr0' stp='on' delay='0'/>
   <mac address='52:54:00:31:10:e8'/>
   <ip address='192.168.122.1' netmask='255.255.255.0'>
      <dhcp>
         <range start='192.168.122.2' end='192.168.122.254'/>
      </dhcp>
   </ip>
   </network>

这个时候只需要修改vm1的配置文件 virsh edit vm1。 type指定为xml， 指定source bridge为virbr0后启动vm就可以

.. code-block:: xml

    <interface type='bridge'>
      <mac address='52:54:00:c0:29:14'/>
      <source bridge='virbr0'/>
      <model type='virtio'/>
      <address type='pci' domain='0x0000' bus='0x01' slot='0x00' function='0x0'/>
    </interface>



参考资料
----------------------

`【http://blog.programster.org/kvm-cheatsheet】 <http://blog.programster.org/kvm-cheatsheet>`__

`【https://www.sysgeek.cn/install-configure-kvm-ubuntu-18-04/】 <https://www.sysgeek.cn/install-configure-kvm-ubuntu-18-04/>`__


问题：无法连接到libvirt-sock
-------------------------------

::

   [root@localhost ~]# ./install_vm.sh
   ERROR    Failed to connect socket to '/var/run/libvirt/libvirt-sock': No such file or directory

解决

::

   systemctl start libvirtd

问题：无法读取iso，权限不对
-------------------------------

::

   Starting install...
   Allocating 'suse-02.qcow2'                                                                                                                       |  20 GB  00:00:01
   ERROR    internal error: qemu unexpectedly closed the monitor: 2019-03-01T03:15:50.278936Z qemu-kvm: -drive file=/root/iso/SLE-15-SP1-Installer-DVD-aarch64-Beta4-DVD1.iso,format=raw,if=none,id=drive-scsi0-0-0-1,readonly=on: Could not open '/root/iso/SLE-15-SP1-Installer-DVD-aarch64-Beta4-DVD1.iso': Permission denied
   Removing disk 'suse-02.qcow2'                                                                                                                    |    0 B  00:00:00
   Domain installation does not appear to have been successful.

解决办法

::

   vim /etc/libvirt/qemu.conf

取消\ ``user = "root"``\ 和\ ``group = "root"``\ 前面的注释并重启

::

   #
   user = "root"

   # The group for QEMU processes run by the system instance. It can be
   # specified in a similar way to user.
   group = "root"

   # Whether libvirt should dynamically change file ownership

::

   systemctl restart libvirtd

问题：unsupported configuration: ACPI requires UEFI on this architecture
-------------------------------------------------------------------------

::

   [me@centos bin]$ ./install_vm.sh
   WARNING  Couldn't configure UEFI: Did not find any UEFI binary path for arch 'aarch64'
   WARNING  Your aarch64 VM may not boot successfully.

   Starting install...
   Retrieving file .treeinfo...                                                   |  274 B  00:00:00
   Retrieving file vmlinuz...                                                     | 5.8 MB  00:00:00
   Retrieving file initrd.img...                                                  |  41 MB  00:00:00
   Allocating 'CentOS7.6.qcow2'                                                   |  20 GB  00:00:00
   ERROR    unsupported configuration: ACPI requires UEFI on this architecture
   Removing disk 'CentOS7.6.qcow2'                                                |    0 B  00:00:00
   Domain installation does not appear to have been successful.
   If it was, you can restart your domain by running:
     virsh --connect qemu:///session start CentOS7.6
   otherwise, please restart your installation.

解决办法

::

   yum install AAVMF

::

   AAVMF.noarch : UEFI firmware for aarch64 virtual machines

问题：error: Refusing to undefine while domain managed save image exists
--------------------------------------------------------------------------

::

   [me@centos instruction_set]$ virsh undefine vm1
   error: Refusing to undefine while domain managed save image exists

解决办法：

::

   [me@centos instruction_set]$ virsh managedsave-remove --domain vm1
   Removed managedsave image for domain vm1

::

   [me@centos instruction_set]$ virsh undefine --nvram --remove-all-storage vm1
   Domain vm1 has been undefined
   Volume 'sda'(/home/me/.local/share/libvirt/images/CentOS7.6.qcow2) removed.


qemu 命令行参数和 libvirt xml转换
----------------------------------

参考 [#transfer_url]_


问题: virsh exit xml 和dump处的xml不一样
----------------------------------------

virsh edit 的结果：

.. code-block:: xml

    <interface type='bridge'>
      <mac address='52:54:00:38:06:f9'/>
      <source bridge='br0'/>
      <model type='virtio'/>
      <address type='pci' domain='0x0000' bus='0x01' slot='0x00' function='0x0'/>
    </interface>

virsh dumpxml 的结果

.. code-block:: console

    [user1@centos ~]$ virsh dumpxml vm1 | grep interface -A 10
        <interface type='user'>
          <mac address='52:54:00:38:06:f9'/>
          <model type='virtio'/>
          <alias name='net0'/>
          <address type='pci' domain='0x0000' bus='0x01' slot='0x00' function='0x0'/>
        </interface>


解决办法：

Soft-reboot isn't good enough because it doesn't restart the qemu process and
doesn't use new XML. You need to shutdown and start the VM again in order to load the new XML. [#virsh_edit]_

.. code-block:: shell

    virsh shutdown vm1
    virsh start vm1


问题: failed to communicate with bridge
----------------------------------------


.. code-block:: console

    [user1@centos ~]$
    [user1@centos ~]$ virsh start vm1
    error: Failed to start domain vm1
    error: internal error: /usr/libexec/qemu-bridge-helper --use-vnet --br=br0 --fd=27: failed to communicate with bridge helper: Transport endpoint is not connected
    stderr=access denied by acl file


解决办法：

在host上，编辑 vim /etc/qemu-kvm/bridge.conf, 其他设备可能是：
vim /etc/qemu/bridge.conf [#allow_br0]_

.. code-block:: console

    [user1@centos ~]$ sudo cat /etc/qemu-kvm/bridge.conf
    allow virbr0
    allow br0



待确认问题
----------

kvm可以跑X86的linux？

::

   error: unexpected data '-all'
   [root@192e168e100e118 ~]# virsh list
    Id    Name                           State
   ----------------------------------------------------
    1     instance-8e278c38-2559-4499-81af-37166cf78f3d running

   [root@192e168e100e118 ~]# virsh console instance-8e278c38-2559-4499-81af-37166cf78f3d
   Connected to domain instance-8e278c38-2559-4499-81af-37166cf78f3d
   Escape character is ^]

   CentOS Linux 7 (Core)
   Kernel 3.10.0-862.el7.x86_64 on an x86_64

   ceshi-03 login:


.. [#transfer_url] https://blog.csdn.net/beckdon/article/details/50883754
.. [#virsh_edit] https://bugzilla.redhat.com/show_bug.cgi?id=1347219
.. [#allow_br0] https://mike42.me/blog/2019-08-how-to-use-the-qemu-bridge-helper-on-debian-10
