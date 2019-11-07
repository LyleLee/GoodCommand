BMC
===

Baseboard Management Controller
用于管理服务器的子系统，有独立的CPU和内存，可以读取到母版上各硬件设施的状态。

以下命令在BMC提示符下执行。

.. code:: shell

   iBMC:/->

.. code:: cs

   #查询固件版本BMC、CPLD、BIOS信息
   ipmcget -d v

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


   #查询健康事件
   ipmcget -t fru0 -d healthevents


