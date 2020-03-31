************
ipmitool
************

好像是一种管理工具。可以连接到服务器的串口输出

::

   ipmitool -I lanplus -H 192.168.2.151 -U Administrator -P Adminpasscode sol activate

| 192.168.2.151 是IP地址
| Administrator 是用户名
| Adminpasscode 是密码

当发现ipmi无法使用时，可以另起session，kill掉现在的连接

::

   ipmitool -I lanplus -H 192.168.2.151 -U Administrator -P Adminpasscode sol deactivate

如果ipmitool 连接到了目标单板但是没有输出。有两种设置方法：

方法一：修改BIOS设置

.. code::

   #开源版本
   BIOS -> Device Manager -> Console Preference Selection -> Preferred console Serial
   #产品版本
   BIOS -> Advanced -> MISC Config -> Support SPCR  <Enabled>

::

                            BIOS Setup Utility V2.0
             Advanced
   /--------------------------------------------------------+---------------------\
   |                     MISC Config                        |    Help Message     |
   |--------------------------------------------------------+---------------------|
   |   Support Smmu                 <Enabled>               |Memory Print Level   |
   |   Support GOP FB for SM750     <Disabled>              |Set. Disable: Do     |
   |   Support SPCR                 <Enabled>               |not print any MRC    |
   |                                                        |statement/ Minimum:  |
   |   System Debug Level           <Debug>                 |Print the most       |
   |   Memory Print Level           <Minimum>               |important(High       |
   |   CPU Prefetching              <Enabled>               |level) MRC           |
   |   Configuration                                        |statement/ Minmax:   |
   |   Support Down Core            <Disabled>              |Print the            |
   |                                                        |Mid-important(Mid    |
   |                                                        |level) and most      |
   |                                                        |important MRC        |
   |                                                        |statement/ Maximum:  |
   |                                                        |MRC statement        |
   |                                                        |                     |


方法二：修改OS的/etc/default/grub，设置串口重定向， 鲲鹏设备在quiet后面添加 `console=ttyAMA0,115200` ，
intel设备添加 `console=ttyS0,115200`

CentOS、RetHat：Kunpeng

.. code-block:: cfg

   GRUB_CMDLINE_LINUX="crashkernel=auto rd.lvm.lv=rhel/root rd.lvm.lv=rhel/swap
         rhggb quiet console=ttyAMA0,115200"

CentOS、RetHat：Intel

.. code-block:: cfg

   GRUB_CMDLINE_LINUX="crashkernel=auto rd.lvm.lv=centos00/root rd.lvm.lv=centos00/swap
         rhgb quiet console=ttyS0,115200"


ubuntu

.. code-block:: cfg

   GRUB_CMDLINE_LINUX="console=ttyAMA0,115200"

更新grub.cfg文件。

.. code::

   #RedHat
   grub2-mkconfig -o /boot/efi/EFI/redhat/grub.cfg
   #CentOS
   grub2-mkconfig -o /boot/grub2/grub.cfg
   #ubuntu
   sudo grub-mkconfig -o /boot/grub/grub.cfg

设置结果, 可以查看grub.cfg

.. code-block:: cfg

   ### BEGIN /etc/grub.d/10_linux ###
   menuentry 'CentOS Linux (3.10.0-957.el7.x86_64) 7 (Core)' --class centos --class gnu-linux --class gnu --class os --unrestricted $menuentry_id_option 'gnulinux-3.10.0-957.el7.x86_64-advanced-bdd56b03-059d-4192-af2e-e70610dcd3d5' {
         load_video
         set gfxpayload=keep
         insmod gzio
         insmod part_msdos
         insmod xfs
         set root='hd0,msdos1'
         if [ x$feature_platform_search_hint = xy ]; then
            search --no-floppy --fs-uuid --set=root --hint-bios=hd0,msdos1 --hint-efi=hd0,msdos1 --hint-baremetal=ahci0,msdos1 --hint='hd0,msdos1'  934e58ff-667e-49df-9779-f6a32a7a98a5
         else
            search --no-floppy --fs-uuid --set=root 934e58ff-667e-49df-9779-f6a32a7a98a5
         fi
         linux16 /vmlinuz-3.10.0-957.el7.x86_64 root=/dev/mapper/centos00-root ro crashkernel=auto rd.lvm.lv=centos00/root rd.lvm.lv=centos00/swap rhgb quiet console=ttyAMA0,115200
         initrd16 /initramfs-3.10.0-957.el7.x86_64.img
   }


.. caution:: 这里主要注意更新grub.cfg的方式，grub更多内容请参考 :doc:`grub`

以下所有命令需要先执行：

::

   ipmitool -H 192.168.1.59 -I lanplus -U Administrator -P Adminpasscode

#电源管理：

.. code::

   ipmitool -H 192.168.1.59 -I lanplus -U Administrator -P Adminpasscode chassis power off     #(硬关机，直接切断电源)
   ipmitool -H 192.168.1.59 -I lanplus -U Administrator -P Adminpasscode chassis power power soft      #(软关机，即如同轻按一下开机按钮)
   ipmitool -H 192.168.1.59 -I lanplus -U Administrator -P Adminpasscode chassis power power on        #(硬开机)
   ipmitool -H 192.168.1.59 -I lanplus -U Administrator -P Adminpasscode chassis power power reset     #(硬重启,断电上电)
   ipmitool -H 192.168.1.59 -I lanplus -U Administrator -P Adminpasscode chassis power power status    #(获取当前电源状态)
   ipmitool -H 192.168.1.59 -I lanplus -U Administrator -P Adminpasscode chassis power cycle #（断电1秒后上电）

上面的命令很长，每次打那么多字会太不友好了，可以进入ipmitool交互模式，后面直接输入命令就可以了。

.. code:: shell

   ipmitool -I lanplus -H 192.168.1.233 -U Administrator -P Admin@9000 shell

远程引导（当次有效）
====================

::

   chassis bootdev pxe     #网络引导
   chassis bootdev disk    #硬盘引导
   chassis bootdev cdrom   #光驱引导
   chassis bootdev bios    #重启后停在BIOS菜单
   chassis bootdev pxe　    #重启后从PXE启动

chassis bootdev 在1620有. 在1620 CS上可以。 要再OS里面systemctl reboot
-i 有效。 ipmitool

读取系统状态
============

::

   sensor list   #显示系统所有传感器列表
   fru list　　　#显示系统所有现场可替代器件的列表
   sdr list　　　#显示系统所有SDRRepository设备列表
   pef list      #显示系统平台时间过滤的列表

#系统日志类

::

   sel elist　　　 #显示所有系统事件日志
   sel clear　　　 #删除所有系统时间日志
   sel delete ID   #删除第ID条SEL
   sel time get    #显示当前BMC的时间
   sel time set    #设置当前BMC的时间

#系统相关的命令

::

   mc info             #显示BMC版本信息
   bmc reset cold      #BMC热启动
   bmc reset warm      #BMC冷启动

#通道相关命令

::

   channel info　#显示系统默认channel
   channel authcap channel-number privilege 　#修改通道的优先级别
   channel getaccess channel-number user-id　#读取用户在通道上的权限
   channel setacccess channel-number  user-id callin=on ipmi=on link=onprivilege=5   #设置用户在通道上的权限

.. code::

   Channel 0x1 info:   #通道1
     Channel Medium Type   : 802.3 LAN
     Channel Protocol Type : IPMB-1.0
     Session Support       : multi-session
     Active Session Count  : 1
     Protocol Vendor ID    : 7154
     Volatile(active) Settings
       Alerting            : disabled
       Per-message Auth    : enabled
       User Level Auth     : enabled
       Access Mode         : always available
     Non-Volatile Settings
       Alerting            : enabled
       Per-message Auth    : enabled
       User Level Auth     : enabled
       Access Mode         : disabled

#网络接口相关命令

::

   lan print                               #显示通道 1的网络配置信息
   lan set 1 ipaddr 10.32.2.2              #设置通道 1的IP地址
   lan set 1 netmask 255.255.0.0           #设置通道 1的netmask
   lan set 4 defgw ipaddr255.255.0.254     #设置通道 4的网关
   lan set 2 defgw macaddr  <macaddr>      #设置通道 2的网关mac address
   lan set 2 ipsrc dhcp                    #设置通道 2的ip 源在DHCP
   lan set 3 ipsrc static                  #设置通道 2的ip是静态获得的

   ipmitool -I lanplus -H 172.92.17.58 -U Administrator -P Admin@9000 raw 0x30 0x90 0x44 0x02 0x00 0x18 0xe1 0xc5 0xd8 0x67 #修改mac地址
                                                                                              0x00 0x18 0xe1 0xc5 0xd8 0x67 #mac地址，前面的raw数据是握手字段
                                                                                              00:18:e1:c5:d8:67             #实际mac地址

#看门狗相关命令

::

   mc watchdog get　#读取当前看门狗的设置
   watchdog  off    #关掉看门狗
   watchdog reset 　#在最近设置的计数器的基础上重启看门狗

#用户管理相关命令

.. code::

   ipmitool user list chan-id                      #显示某通道上的所有用户
   ipmitool set password <user id>[<password>]     #修改某用户的密码
   ipmitool disable      <user id>　　               #禁止掉某用户
   ipmitool enable       <user id>　　               #使能某用户
   ipmitool priv         <user id> <privilegelevel> [<channel number>]　#修改某用户在某通道上的权限
   ipmitool test         <user id> <16|20>[<password]>　#测试用户

#升级固件

::

   ipmitool hpm upgrade <xxxxx.hpm> -z 25000 forces

报错处理

.. code-block:: console

   [user1@localhost network-scripts]$ ipmitool
   Could not open device at /dev/ipmi0 or /dev/ipmi/0 or /dev/ipmidev/0: No such file or directory

首先确保已经加载ipmitool模块

.. code-block:: console

   [user1@localhost ~]$ lsmod | grep ipmi
   ipmi_poweroff         262144  0
   ipmi_watchdog         262144  0
   ipmi_si               262144  0
   ipmi_devintf          262144  0
   ipmi_msghandler       262144  4 ipmi_devintf,ipmi_si,ipmi_watchdog,ipmi_poweroff

如果没有使用modprobe命令加载模块,如：

.. code-block:: console

   modprobe ipmi_poweroff


更多命令亲参考 [#ipmitool_blog]_

.. [#ipmitool_blog] https://blog.51cto.com/bovin/2128475
