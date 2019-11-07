linux常用工具
=============

查询设备信息
------------

-  快速查看服务器的硬件信息

.. code:: cs

   sudo lshw -short        #以简短的方式列出服务器的硬件信息
   sudo lshw -c network    #观察网卡型号，接口命令，IP的对应关系。 查看某个口属于什么网卡

-  查看服务器型号，bios， 主板，槽位，cpu，内存等

.. code:: cs

   sudo dmidecode -t  bios         #含厂商、版本等
   sudo dmidecode -t  system       #含服务器型号、厂商，发布日期等
   sudo dmidecode -t  baseboard    #含厂商，序列号等
   sudo dmidecode -t  chassis      #含槽位，最大支持PCI槽位，并不是实际服务器的槽位
   sudo dmidecode -t  processor    #含CPU个数，类型：x86/ARM，时钟频率，L1，L2，L3缓存等
   sudo dmidecode -t  memory       #含所有内存插槽，每个内存条大小，位宽，类型：DDR4等
   sudo dmidecode -t  cache        #含所有L1、L2、L3缓存信息
   sudo dmidecode -t  connector    #未调查
   sudo dmidecode -t  slot         #含槽位信息

请参考\ `dmidecode例子 <cpuinfo.md#dmidecode>`__\ 查看不同设备的输出

查询CPU信息
-----------

::

   总核数（总逻辑核数）= 物理CPU个数 × 每颗物理CPU的核数 × 超线程数

-  查看物理CPU个数

.. code:: shell-session

   cat /proc/cpuinfo| grep "physical id"| sort| uniq| wc -l

-  查看每个物理CPU中core的个数(即核数)

.. code:: shell-session

   cat /proc/cpuinfo| grep "cpu cores"| uniq

-  查看逻辑CPU的个数

::

   cat /proc/cpuinfo| grep "processor"| wc -l

| 另外，可以直接使用lscpu得出CPU概览。
| 请参考\ `解读CPU信息 <cpuinfo.md#lscpu>`__\ 查看不同设备的输出 ##
  查询内存信息 + 查看内存使用情况

.. code:: shell-session

   me@ubuntu:~$ free -mh
                 total        used        free      shared  buff/cache   available
   Mem:           125G         20G        1.2G        3.1M        103G        103G
   Swap:          2.0G         20M        2.0G
   me@ubuntu:~$

查询硬盘信息
------------

1.lsblk
~~~~~~~

可以看到物理盘和逻辑盘以及挂载情况

.. code:: shell-session

   me@ubuntu:~$ lsblk
   NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
   sda      8:0    0  3.7T  0 disk
   ├─sda1   8:1    0  512M  0 part /boot/efi
   └─sda2   8:2    0  3.7T  0 part /
   sdb      8:16   0  3.7T  0 disk
   └─sdb1   8:17   0  3.7T  0 part /home/data

2.fdisk
~~~~~~~

系统自带的硬盘工具,可以进行格式化硬盘等操作

.. code:: shell-session

   fdisk -l
   #列出所有物理硬盘，做了硬raid只能看到一个硬盘

3. smartctl
~~~~~~~~~~~

| smartctl控制ATA-3、ATA later、IDE 和
  SCSI-3硬件驱动器的自监测、分析和报告功能。
  可以看到硬盘本身的信息：设备型号、序列号，厂家、转速，大小等
| ``smartctl -a /dev/sdb``

.. code:: shell-session

   me@ubuntu:~$ sudo smartctl -a /dev/sdb
   smartctl 6.6 2016-05-31 r4324 [aarch64-linux-4.15.0-20-generic] (local build)
   Copyright (C) 2002-16, Bruce Allen, Christian Franke, www.smartmontools.org

   === START OF INFORMATION SECTION ===
   Device Model:     HUS726040ALA610
   Serial Number:    K4JGB1DB
   LU WWN Device Id: 5 000cca 25de2b5aa
   Firmware Version: T7R4
   User Capacity:    4,000,787,030,016 bytes [4.00 TB]
   Sector Size:      512 bytes logical/physical
   Rotation Rate:    7200 rpm
   Form Factor:      3.5 inches
   Device is:        Not in smartctl database [for details use: -P showall]
   ATA Version is:   ACS-2, ATA8-ACS T13/1699-D revision 4
   SATA Version is:  SATA 3.1, 6.0 Gb/s (current: 6.0 Gb/s)
   Local Time is:    Fri Jan 18 17:26:44 2019 CST
   SMART support is: Available - device has SMART capability.
   SMART support is: Enabled
   ...........

4. hdparm
~~~~~~~~~

hdparm是Linux的命令行程序，用于设置和查看ATA硬盘驱动器的硬件参数和测试性能。它可以设置驱动器缓存，睡眠模式，电源管理，声学管理和DMA设置等参数。

::

   hdparm -I /dev/sdb

.. code:: shell-session

   me@ubuntu:~$ sudo hdparm -I /dev/sdb

   /dev/sdb:

   ATA device, with non-removable media
           Model Number:       HUS726040ALA610
           Serial Number:      K4JGB1DB
           Firmware Revision:  T7R4
           Transport:          Serial, ATA8-AST, SATA 1.0a, SATA II Extensions, SATA Rev 2.5, SATA Rev 2.6, SATA Rev 3.0; Revision: ATA8-AST T13 Project D1697 Revision 0b
   Standards:
           Used: unknown (minor revision code 0x0029)
           Supported: 9 8 7 6 5
           Likely used: 9
   Configuration:
           Logical         max     current
           cylinders       16383   16383
           heads           16      16
           sectors/track   63      63
           --
           CHS current addressable sectors:    16514064
           LBA    user addressable sectors:   268435455
           LBA48  user addressable sectors:  7814037168
           Logical  Sector size:                   512 bytes
           Physical Sector size:                   512 bytes
           device size with M = 1024*1024:     3815447 MBytes
           device size with M = 1000*1000:     4000787 MBytes (4000 GB)
           cache/buffer size  = unknown
           Form Factor: 3.5 inch
           Nominal Media Rotation Rate: 7200
   Capabilities:

网络操作
--------

设置IP
~~~~~~

建议使用\ ``ip address``\ 命令。ifconfig
可以完成同样配置，ubuntu上使用ifconfig，redhat使用的是ifcfg。\ ``ip address``\ 可以兼容两个系统

::

   ip address add 10.0.0.3/24 dev eth0
   ip address add 192.168.2.223/24 dev eth1
   ip address add 192.168.4.223/24 dev eth1

dhcp
~~~~

| 有时候不需要配置网络接口文件，希望各个网络接口使用dhcp自动获取IP地址。
| redhat7 8

::

   dhclient

会在可用的网络接口下自动获取IP

网络配置文件
~~~~~~~~~~~~

ubuntu

.. code:: shell-session

   me@ceph-client:~$ cat /etc/netplan/01-netcfg.yaml
   # This file describes the network interfaces available on your system
   # For more information, see netplan(5).
   network:
   version: 2
   renderer: networkd
   ethernets:
   enp1s0:
     dhcp4: yes
   me@ceph-client:~$

`【设置DNS教程】 <https://www.tecmint.com/configure-network-static-ip-address-in-ubuntu/>`__
修改好配置文件之后设置生效

::

   sudo netplan apply

redhat7.5 redhat8.0

.. code:: shell-session

   [me@localhost ~]$ cat /etc/sysconfig/network-scripts/ifcfg-enp1s0
   TYPE=Ethernet
   PROXY_METHOD=none
   BROWSER_ONLY=no
   BOOTPROTO=dhcp
   DEFROUTE=yes
   IPV4_FAILURE_FATAL=no
   IPV6INIT=yes
   IPV6_AUTOCONF=yes
   IPV6_DEFROUTE=yes
   IPV6_FAILURE_FATAL=no
   IPV6_ADDR_GEN_MODE=stable-privacy
   NAME=enp1s0
   UUID=8d5bd07f-3342-424c-9a18-ef91be6cf514
   DEVICE=enp1s0
   ONBOOT=yes
   [me@localhost ~]$

主要修改\ ``BOOTPROTO=dhcp``\ 和\ ``ONBOOT=yes``\ 这两个选项 ###
重启网络

ubuntu18.04

.. code:: shell-session

   sudo systemctl restart systemd-networkd.service

redhat7.5 redhat8.0

.. code:: shell-session

   sudo systemctl restart NetworkManager

suse 15

.. code:: shell-session

   systemctl restart network

其他系统上各有不同，即使是ubuntu，也因为版本命令不一样，所以其他发行版请自行搜索。

-  抓包

在eth0上抓ping包，看是否有ping包到达

::

   tcpdump -v icmp -i eth0

查看网口对应的PCI设备
~~~~~~~~~~~~~~~~~~~~~

.. code:: shell

   ls -la /sys/class/net/

::

   total 0
   drwxr-xr-x  2 root root 0 May 31 23:57 .
   drwxr-xr-x 52 root root 0 Apr 14  2015 ..
   lrwxrwxrwx  1 root root 0 Apr 14  2015 eno1 -> ../../devices/pci0000:7c/0000:7c:00.0/0000:7d:00.0/net/eno1
   lrwxrwxrwx  1 root root 0 Apr 14  2015 eno2 -> ../../devices/pci0000:7c/0000:7c:00.0/0000:7d:00.1/net/eno2
   lrwxrwxrwx  1 root root 0 Apr 14  2015 eno3 -> ../../devices/pci0000:7c/0000:7c:00.0/0000:7d:00.2/net/eno3
   lrwxrwxrwx  1 root root 0 Apr 14  2015 eno4 -> ../../devices/pci0000:7c/0000:7c:00.0/0000:7d:00.3/net/eno4
   lrwxrwxrwx  1 root root 0 Apr 14  2015 enp189s0f0 -> ../../devices/pci0000:bc/0000:bc:00.0/0000:bd:00.0/net/enp189s0f0
   lrwxrwxrwx  1 root root 0 Apr 14  2015 enp189s0f1 -> ../../devices/pci0000:bc/0000:bc:00.0/0000:bd:00.1/net/enp189s0f1
   lrwxrwxrwx  1 root root 0 Apr 14  2015 enp189s0f2 -> ../../devices/pci0000:bc/0000:bc:00.0/0000:bd:00.2/net/enp189s0f2
   lrwxrwxrwx  1 root root 0 Apr 14  2015 enp189s0f3 -> ../../devices/pci0000:bc/0000:bc:00.0/0000:bd:00.3/net/enp189s0f3
   lrwxrwxrwx  1 root root 0 Apr 14  2015 lo -> ../../devices/virtual/net/lo

http代理
~~~~~~~~

有时候服务器需要经过代理服务器访问网络

::

   export http_proxy=http://192.168.1.212:8118

这个命令只对当前终端有效，关闭终端，或者重启机器都会失效。使用wegt
和curl时有用。yum的时无效的。

yum的代理需要在/etc/yum.conf下设置

文件操作
--------

-  修改文件所有者和文件所在组

::

   chgrp   用户名 文件名  -R  
   chown   用户名 文件名  -R

   sudo chown -R me:me .[^.]*  #更改当前目录下所有的文件，包括隐藏文件的拥有者为me，组为me
   sudo chown -R me:me /home/me/code/linux/.[^.]*  更改linux目录下所有的文件，包括隐藏文件的拥有者为me，组为me

-  递归搜索当前目录下所有.h 文件中包含 linux_binfmt字符串的文件

::

   grep "linux_binfmt" -Ril --include=\*.h

-  查找ELF64_Sym在所有.h文件中的原型

::

   grep Elf64_Sym /usr/include/*.h | grep typedef
   find /etc/httpd/ -name httpd.conf

-  在linux目录中查找所有的\ ``*.h``\ ，并在这些文件中查找SYSCALL_VECTOR

::

   find linux -name *.h | xargs grep "SYSCALL_VECTOR"

-  从根目录开始查找所有扩展名为.log的文本文件，并找出包含”ERROR”的行

::

   find / -type f -name “*.log” | xargs grep “ERROR”

-  从当前目录开始查找所有扩展名为.in的文本文件，并找出包含”thermcontact”的行

::

   find . -name “*.in” | xargs grep “thermcontact”

-  查找系统库中包含 “getopt_long”函数的头文件

::

   find /usr/lib/ -name *.h | xargs grep "getopt_long"

-  查找指定指定文件类型

::

   find . -type d -name debug*

   b   block (buffered) special
   c   character (unbuffered) special
   d   directory
   p   named pipe (FIFO)
   f   regular file
   l   symbolic link
   s   socket
   D   door (Solaris)

-  设置深度

::

   find . -maxdepth 2

-  查找当前目录下所有文件中包含ibv_open_device的文件和行

::

   grep ibv_open_device -rn .

-  查找时忽略文件\ ``.java``\ 文件和\ ``.js``\ 文件

::

   grep -E "http"  . -R --exclude=*.{java,js}

-  查找时忽略tag文件

::

   grep show_interrupts . -rn --exclude-dir={.git} --exclude=tags --binary-files=without-match
   grep ibv_context -rn --exclude={GPATH,GRTAGS,GTAGS,tags}

-  查找时忽略目录\ ``.git``,\ ``res``,\ ``bin``

::

   grep -E "http"  . -R --exclude-dir={.git,res,bin}

-  设置环境变量排除目录或者文件

::

   export GREP_OPTIONS="--exclude-dir=\.svn --exclude-dir=\.git --exclude=tags --exclude=cscope\.out"

-  查找时忽略二进制文件

::

   grep rtc_init . -rn --exclude-dir={.git} --binary-files=without-match

-  查找文件并且ls

::

   find . -name verbs.h | xargs -n 1 ls -l

-  grep 显示匹配行的后面几行 -A选项

::

   dmidecode|grep "System Information" -A9

-  复制文件

::

   scp /home/a.txt root@192.168.1.199:/home/code/b.c

-  复制文件夹

::

   scp -r /home/code-project root@192.168.1.1991:/home/code-project

-  同步文件

::

   rsync -avzP /path/to/source/ user@192.168.1.5:/path/to/dest/

软件安装
--------

1.  查找软件包 ``yum search ~``

2.  | 列出所有可安装的软件包
    | >yum list

3.  列出所有可更新的软件包 >yumlist updates

4.  列出所有已安装的软件包 >yum list installed

5.  列出所有已安装但不在Yum Repository內的软件包 >yum list extras

6.  列出所指定软件包 >yum list~

7.  使用YUM获取软件包信息 >yum info~

8.  列出所有软件包的信息 >yum info

9.  列出所有可更新的软件包信息 >yum info updates

10. 列出所有已安裝的软件包信息 >yum info installed

11. 列出所有已安裝但不在Yum Repository內的软件包信息 >yum info extras

12. 列出软件包提供哪些文件 >yum provides~

| fdisk -l可以看到多个物理硬盘，做了硬raid只能看到一个硬盘
| ``cat /proc/cpuinfo查看cpu具体的信息`` 13. 查找不常见软件包 >rmadision
  -S

用户管理
--------

因为安装系统时没有为用户添加到管理员，所以无法执行sudo命令，系统提示

.. code:: shell-session

   [me@redhat75 ~]$ sudo vim /etc/sysconfig/network-scripts/ifcfg-eth0
   [sudo] password for me:
   me is not in the sudoers file.  This incident will be reported.

添加用户到sudo组 方法一：

::

   [root@redhat75 me]# usermod -a -G sudo me
   usermod: group 'sudo' does not exist

添加不成功，原因是默认没有sudo组，在安装系统时，账户默认是wheel组，wheel也有sudo权限。

::

   [root@redhat75 me]# usermod -a -G wheel me

方法二：

::

   visudo
   ## Allow root to run any commands anywhere
   root    ALL=(ALL)       ALL
   me      ALL=(ALL)       ALL

允许用户user1无密码执行sudo命令 \```\` sudo visudo

Allows people in group wheel to run all commands
------------------------------------------------

%wheel ALL=(ALL) ALL user1 ALL=(ALL) NOPASSWD: ALL

::


   ## 安装linux源码,安装内核源码

| sudo apt-get install linux-4.4-source-4.4
| xz -d linux-4.4-source-4.4.tar.xz
| sudo xz -d linux-4.4-source-4.4.tar.xz
| tar -xvf linux-4.4-source-4.4.tar
| sudo tar -xvf linux-4.4-source-4.4.tar

::

   Ubuntu

sudo apt-get update sudo apt-get install linux-source

#会在/usr/src下面安装当前内核版本的源码 me@ubuntu:~$ ls /usr/src/
linux-headers-4.15.0-29 linux-headers-4.15.0-29-generic
linux-source-4.15.0 linux-source-4.15.0.tar.bz2 me@ubuntu:~$ uname -a
Linux ubuntu 4.15.0-29-generic #31-Ubuntu SMP Tue Jul 17 15:41:03 UTC
2018 aarch64 aarch64 aarch64 GNU/Linux

::


   Redhat、CentOS

yum install kernel-devel Kernel-headers

::


   ## 校验md5
   计算文件的md5值
   ```shell-session
   me@ubuntu:~$ md5sum shrc
   5d17293b5f05e123c50b04e1cd1b9ff7  shrc

修改键盘布局
------------

有时候键盘布局可能不一样，导致按键错误，可以使用命令进行配置.一般选择1-4键盘

.. code:: shell-session

   sudo dpkg-reconfigure keyboard-configuration

.. code:: shell-session

   me@ubuntufio:~$ sudo dpkg-reconfigure keyboard-configuration
   Package configuration

            ┌──────────┤ Configuring keyboard-configuration ├───────────┐
            │ Please select the model of the keyboard of this machine.  │
            │                                                           │
            │ Keyboard model:                                           │
            │                                                           │
            │     DTK2000                                            ↑  │
            │     eMachines m6800 laptop                             ▒  │
            │     Ennyah DKB-1008                                    ▒  │
            │     Everex STEPnote                                    ▮  │
            │     FL90                                               ▒  │
            │     Fujitsu-Siemens Amilo laptop                       ▒  │
            │     Generic 101-key PC                                 ▒  │
            │     Generic 101-key PC (intl.)                         ▒  │
            │     Generic 104-key PC                                 ▒  │
            │     Generic 105-key PC (intl.)                         ↓  │
            │                                                           │
            │                                                           │
            │              <Ok>                  <Cancel>               │
            │                                                           │
            └───────────────────────────────────────────────────────────┘
