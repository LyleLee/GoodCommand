***********************
firewall
***********************

CentOS和redhat使用firewall [#f1]_ [#f2]_ 作为防火墙

.. code::

   systemctl status firewalld.service #查看防火墙服务运行状态，systemctl 也可以用来启动关闭，重启防火墙
   firewall-cmd --state               #查看防火墙是否在运行
   firewall-cmd --get-log-denied      #查看防火墙是否记录已拒绝的数据包
   firewall-cmd --set-log-denied=all  #记录所有拒绝的请求， 设置之后可以在/var/log/messages看到所拒绝的请求log

由于命令行可能不熟悉，可以使用图形界面进行设置。

::

   firewall-config

封锁一个IP

::

   firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='192.168.1.1' reject"

封锁一个IP段

::

   firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='192.168.1.0/24' reject"

添加一条rich rule

::

   sudo firewall-cmd --zone=public --add-rich-rule="rule family="ipv4" source address="198.51.100.0/32" port protocol="tcp" port="10000" log prefix="test-firewalld-log" level="info" accept"
   firewall-cmd --add-rich-rule='rule family="ipv4" source address="139.159.243.11" destination address="192.168.100.12" protocol value="tcp" log prefix="upnpc" level="warning" accept'

防火墙开放80端口防火墙。
========================

开放前，发起80端口的http请求会失败

::

   me@ubuntu:~$ curl -X GET http://192.168.1.112/
   curl: (7) Failed to connect to 192.168.1.112 port 80: No route to host
   me@ubuntu:~$

可以观察/var/log/messages可以看到拒绝日志

::

   Jun  7 23:29:25 localhost kernel: FINAL_REJECT: IN=enahisic2i0 OUT= MAC=c0:a8:02:ba:00:04:c0:a8:02:81:00:04:08:00 SRC=192.168.1.201 DST=192.168.1.112 LEN=60 TOS=0x00 PREC=0x00 TTL=64 ID=26463 DF PROTO=TCP SPT=47840 DPT=80 WINDOW=29200 RES=0x00 SYN URGP=0
   Jun  7 23:29:26 localhost kernel: FINAL_REJECT: IN=enahisic2i0 OUT= MAC=c0:a8:02:ba:00:04:c0:a8:02:81:00:04:08:00 SRC=192.168.1.201 DST=192.168.1.112 LEN=60 TOS=0x00 PREC=0x00 TTL=64 ID=54899 DF PROTO=TCP SPT=47842 DPT=80 WINDOW=29200 RES=0x00 SYN URGP=0

防火墙允许80端口接收请求

::

   firewall-cmd --zone=public --add-port=80/tcp --permanent
   firewall-cmd --reload       #重要， 否则不起作用，在firewall-cmd --list-all也无法看到

开放后：

::

   me@ubuntu:~$ curl -X GET http://192.168.1.112/
   <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">


防火墙设置NAT
====================

第一种方法：

.. code-block:: shell

    firewall-cmd --permanent --zone=public --add-masquerade   #开启NAT转发
    firewall-cmd --zone=public --add-port=53/tcp --permanent  #开放DNS使用的53端口，否则可能导致内网服务器虽然设置正确的DNS，但是依然无法进行域名解析。
    systemctl restart firewalld.service   #重启防火墙
    firewall-cmd --query-masquerade  #检查是否允许NAT转发
    firewall-cmd --remove-masquerade #关闭NAT转发

第二种方法：

.. code-block:: shell

    net.ipv4.ip_forward=1 #开启ip_forward转发 在/etc/sysctl.conf配置文件尾部添加
    sysctl -p #然后让其生效
    firewall-cmd --permanent --direct --passthrough ipv4 -t nat -I POSTROUTING -o enoxxxxxx -j MASQUERADE -s 192.168.1.0/24 #执行firewalld命令进行转发：
                                                                                                                            #注意enoxxxxxx对应外网网口名称
    systemctl restart firewalld.service  #重启防火墙


问题记录：
====================

问题：ERROR: '/usr/sbin/iptables-restore -w -n' failed: Bad argument 53333
------------------------------------------------------------------------------

执行以下命令导致防火墙工作不正常, 表现为 ``firewall-cmd --reload`` 提示failed

.. code-block:: console

    firewall-cmd --permanent --direct --passthrough ipv4 -t nat -I PREROUTING -dport 53333 -j DNAT --to 10.10.10.1:53333
    firewall-cmd --permanent --direct --passthrough ipv4 -t nat -I POSTROUTING -d 10.10.10.1 -j SNAT --to 10.10.10.5

可以看到防火墙日志有报错

.. code-block:: console

    [root@vm_centos ~]# systemctl status firewalld
    ● firewalld.service - firewalld - dynamic firewall daemon
       Loaded: loaded (/usr/lib/systemd/system/firewalld.service; enabled; vendor preset: enabled)
       Active: active (running) since Sat 2020-01-04 02:47:03 CST; 1s ago
         Docs: man:firewalld(1)
     Main PID: 5729 (firewalld)
       CGroup: /system.slice/firewalld.service
               └─5729 /usr/bin/python -Es /usr/sbin/firewalld --nofork --nopid

    Jan 04 02:47:03 vm_centos systemd[1]: Stopped firewalld - dynamic firewall daemon.
    Jan 04 02:47:03 vm_centos systemd[1]: Starting firewalld - dynamic firewall daemon...
    Jan 04 02:47:03 vm_centos systemd[1]: Started firewalld - dynamic firewall daemon.
    Jan 04 02:47:04 vm_centos firewalld[5729]: ERROR: '/usr/sbin/iptables-restore -w -n' failed: Bad argument `53333'
                                                    Error occurred at line: 2
                                                    Try `iptables-restore -h' or 'iptables-restore --help' for more information....
    Jan 04 02:47:04 vm_centos firewalld[5729]: ERROR: COMMAND_FAILED: Direct: '/usr/sbin/iptables-restore -w -n' failed: Bad argument `53333'
                                                    Error occurred at line: 2
                                                    Try `iptables-restore -h' or 'iptables-restore --help' for more information....
    Hint: Some lines were ellipsized, use -l to show in full.

解决办法： 删掉新添加的规则。

进入/etc/firewalld/可以看到firewalld的配置文件

.. code-block:: console

    [root@vm_centos firewalld]# tree .
    .
    |-- direct.xml
    |-- direct.xml.old
    |-- firewalld.conf
    |-- firewalld.conf.old
    |-- helpers
    |-- icmptypes
    |-- ipsets
    |-- lockdown-whitelist.xml
    |-- services
    `-- zones
        |-- public.xml
        |-- public.xml.old
        `-- trusted.xml

查找和53333相关的文件并删除

.. code-block:: console

    5 directories, 8 files
    [root@vm_centos firewalld]# grep 53333 -rn .
    ./direct.xml:3:  <passthrough ipv="ipv4">-t nat -I PREROUTING -dport 53333 -j DNAT --to 10.1.1.1:53333</passthrough>
    ./zones/public.xml:10:  <port protocol="tcp" port="53333"/>
    ./zones/public.xml:11:  <port protocol="udp" port="53333"/>
    ./zones/public.xml.old:10:  <port protocol="tcp" port="53333"/>
    ./zones/public.xml.old:11:  <port protocol="udp" port="53333"/>
    ./direct.xml.old:3:  <passthrough ipv="ipv4">-t nat -I PREROUTING -dport 53333 -j DNAT --to 10.1.1.1:53333</passthrough>
    [root@vm_centos firewalld]# rm direct.xml


.. [#f1] firewall-cmd基础用法 https://havee.me/linux/2015-01/using-firewalls-on-centos-7.html
.. [#f2] firewall-cmd防火墙命令2 https://wangchujiang.com/linux-command/c/firewall-cmd.html
