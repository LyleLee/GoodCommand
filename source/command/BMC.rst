***********
BMC
***********

Baseboard Management Controller
用于管理服务器的子系统，有独立的CPU和内存，可以读取到母版上各硬件设施的状态。

以下命令在BMC提示符下执行。

.. code:: shell

   iBMC:/->

.. code:: shell

   #查询固件版本BMC、CPLD、BIOS信息
   ipmcget -d v

   #查询健康事件(普通，严重，告警)
   ipmcget -t fru0 -d healthevents

   #查询iBMC管理网口的IP信息。
   ipmcget -d ipinfo

   #ipaddr命令用于设置iBMC网口的IPv4地址和掩码。
   ipmcset -d ipaddr -v <ipaddr> <mask>
   ipmcset -d ipaddr -v 192.168.0.25 255.255.255.0

   #ipmode命令用于设置iBMC网口的IPv4 DHCP模式。
   ipmcset -d ipmode -v dhcp

   #gateway命令用来设置iBMC网口的IPv4网关地址。
   ipmcset -d gateway -v <gateway>
   ipmcset -d gateway -v 192.168.0.1

   #reset命令用来重启iBMC管理系统。
   ipmcset -d reset

   #查询和设置BMC服务状态
   ipmcget -t service -d list
   ipmcset -t service -d state -v <option> <enabled | disabled>
   ipmcset -t service -d state -v http enabled

   #查询和设置启动设备
   ipmcget -d bootdevice
   ipmcset -d bootdevice -v <option>
   ipmcset -d bootdevice -v 0 #取消强制启动
   ipmcset -d bootdevice -v 1 #从PXE启动
   ipmcset -d bootdevice -v 2 #从默认硬盘启动
   ipmcset -d bootdevice -v 5 #从默认CD/DVD启动
   ipmcset -d bootdevice -v 6 #启动后进入BIOS菜单

   #重启BMC
   ipmcset -d reset

   #重启服务器设备。
   ipmcget -d powerstate      #查询上电状态
   ipmcset -d frucontrol -v 0 #强制重启
   ipmcset -d powerstate -v 0 #正常下电
   ipmcset -d powerstate -v 1 #上电
   ipmcset -d powerstate -v 2 #强制下电



**查询系统健康事件**

.. code-block:: console

   iBMC:/->ipmcget -d healthevents
   Event Num  | Event Time           | Alarm Level  | Event Code   | Event Description
   1          | 2019-11-04 07:07:39  | Major        | 0x10000015   | Abnormal mainboard CPLD 3 self-check result.
   2          | 2019-11-04 07:07:36  | Major        | 0x28000001   | The SAS or PCIe cable to front disk backplane is incorrectly connected.
   3          | 2019-11-04 07:07:40  | Major        | 0x28000001   | The SAS or PCIe cable to front disk backplane PORTB is incorrectly connected.
   4          | 2019-11-04 07:07:40  | Major        | 0x28000001   | The SAS or PCIe cable to front disk backplane PORTA is incorrectly connected.
   iBMC:/->


命令行升级BMC
========================
上传文件到BMC

.. code-block:: console

    scp TaiShan_2280_V2_5280_V2-BIOS_V105.hpm Administrator@192.168.2.53:/tmp/
    scp TS200-2280-iBMC-V366.hpm Administrator@192.168.2.53:/tmp/

升级命令

.. code-block:: console

    iBMC:/->
    iBMC:/->ipmcset -d upgrade -v /tmp/TS200-2280-iBMC-V366.hpm
    Please make sure the iBMC is working while upgrading.
    Updating...
    100%
    Upgrade successfully.
    iBMC:/->

升级成功，可以看到 ``Active iBMC    Version:           (U68)3.66``

.. code-block:: console

    iBMC:/->ipmcget -d v
    ------------------- iBMC INFO -------------------
    IPMC               CPU:           Hi1710
    IPMI           Version:           2.0
    CPLD           Version:           (U6076)1.00
    Active iBMC    Version:           (U68)3.66
    Active iBMC      Build:           003
    Active iBMC      Built:           18:21:27 Nov  2 2019
    Backup iBMC    Version:           3.55
    SDK            Version:           3.33
    SDK              Built:           20:39:29 Jul 18 2019
    Active Uboot   Version:           2.1.13 (Dec 24 2018 - 20:23:20)
    Backup Uboot   Version:           2.1.13 (Dec 24 2018 - 20:23:20)
    ----------------- Product INFO -----------------
    Product             ID:           0x0001
    Product           Name:           TaiShan 2280 V2
    BIOS           Version:           (U75)0.88
    -------------- Mother Board INFO ---------------
    Mainboard      BoardID:           0x00b9
    Mainboard          PCB:           .A
    ------------------- NIC INFO -------------------
    NIC 1 (TM280)  BoardID:           0x0067
    NIC 1 (TM280)      PCB:           .A
    NIC 2 (TM210)  BoardID:           0x0068
    NIC 2 (TM210)      PCB:           .A
    --------------- Riser Card INFO ----------------
    Riser1       BoardName:           BC82PRNE
    Riser1         BoardID:           0x0032
    Riser1             PCB:           .A
    Riser2       BoardName:           BC82PRUA
    Riser2         BoardID:           0x0094
    Riser2             PCB:           .A
    -------------- HDD Backplane INFO --------------
    Disk BP1      BoardName:          BC11THBQ
    Disk BP1       BoardID:           0x0073
    Disk BP1           PCB:           .A
    Disk BP1     CPLD Version:        (U3)1.11
    -------------------- PS INFO -------------------
    PS1            Version:           DC:107 PFC:107
    iBMC:/->


命令行升级BIOS
==================================================
复制文件到BMC的/tmp/目录下，下电，使用命令升级

.. code-block:: console

    iBMC:/->ipmcset -t maintenance -d upgradebios -v /tmp/TaiShan_2280_V2_5280_V2-BIOS_V105.hpm
    Please power off OS first, and then upgrade BIOS again.
    iBMC:/->ipmcset -d powerstate -v 0
    WARNING: The operation may have many adverse effects.
    Do you want to continue?[Y/N]:Y
    Control fru0 normal power off successfully.
    iBMC:/->ipmcset -t maintenance -d upgradebios -v /tmp/TaiShan_2280_V2_5280_V2-BIOS_V105.hpm
    Please make sure the iBMC is working while upgrading.
    Updating...
    100%
    Upgrade successfully.
    iBMC:/->

重新开机

.. code-block:: console

    iBMC:/->ipmcget -d powerstate
    Power state   : Off
    Hotswap state : M1
    iBMC:/->ipmcset -d powerstate -v 1
    WARNING: The operation may have many adverse effects.
    Do you want to continue?[Y/N]:Y
    Control fru0 power on successfully.
    iBMC:/->

这个时候可以看到成功了 ``BIOS           Version:           (U75)1.05``

.. code-block:: console

    iBMC:/->ipmcget -d v
    ------------------- iBMC INFO -------------------
    IPMC               CPU:           Hi1710
    IPMI           Version:           2.0
    CPLD           Version:           (U6076)1.00
    Active iBMC    Version:           (U68)3.66
    Active iBMC      Build:           003
    Active iBMC      Built:           18:21:27 Nov  2 2019
    Backup iBMC    Version:           3.55
    SDK            Version:           3.33
    SDK              Built:           20:39:29 Jul 18 2019
    Active Uboot   Version:           2.1.13 (Dec 24 2018 - 20:23:20)
    Backup Uboot   Version:           2.1.13 (Dec 24 2018 - 20:23:20)
    ----------------- Product INFO -----------------
    Product             ID:           0x0001
    Product           Name:           TaiShan 2280 V2
    BIOS           Version:           (U75)1.05
    -------------- Mother Board INFO ---------------
    Mainboard      BoardID:           0x00b9
    Mainboard          PCB:           .A
    ------------------- NIC INFO -------------------
    NIC 1 (TM280)  BoardID:           0x0067
    NIC 1 (TM280)      PCB:           .A
    NIC 2 (TM210)  BoardID:           0x0068
    NIC 2 (TM210)      PCB:           .A
    --------------- Riser Card INFO ----------------
    Riser1       BoardName:           BC82PRNE
    Riser1         BoardID:           0x0032
    Riser1             PCB:           .A
    Riser2       BoardName:           BC82PRUA
    Riser2         BoardID:           0x0094
    Riser2             PCB:           .A
    -------------- HDD Backplane INFO --------------
    Disk BP1      BoardName:          BC11THBQ
    Disk BP1       BoardID:           0x0073
    Disk BP1           PCB:           .A
    Disk BP1     CPLD Version:        (U3)1.11
    -------------------- PS INFO -------------------
    PS1            Version:           DC:107 PFC:107

在OS内获取BMC IP地址
========================

.. code-block:: console

    [root@localhost ~]# ipmitool lan print 1
    Set in Progress         : Set Complete
    IP Address Source       : Static Address
    IP Address              : 192.168.2.63
    Subnet Mask             : 255.255.255.0
    MAC Address             : e0:00:84:2b:44:dd
    SNMP Community String   : TrapAdmin12#$
    IP Header               : TTL=0x40 Flags=0x40 Precedence=0x00 TOS=0x10
    Default Gateway IP      : 192.168.2.1
    802.1q VLAN ID          : Disabled
    RMCP+ Cipher Suites     : 0,1,2,3,17
    Cipher Suite Priv Max   : XuuaXXXXXXXXXXX
                            :     X=Cipher Suite Unused
                            :     c=CALLBACK
                            :     u=USER
                            :     o=OPERATOR
                            :     a=ADMIN
                            :     O=OEM
    Bad Password Threshold  : Not Available


BMC一键收集信息格式说明
==========================

主要关注 OSDump/systemcom.tar 串口日志

SOL串口信息

.. raw:: html
   :file: ../resources/dump_info.html

