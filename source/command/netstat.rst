==========
netstat
==========

使用netstat监控网络状态

列出工作中的tcp和udp端口
~~~~~~~~~~~~~~~~~~~~~~~~

一般指的是连接已经建立的链接。包含程序PID和程序名，使用\ ``-p``\ 选项

.. code-block:: console

   netstat -tup

列出所有的tcp和udp端口
~~~~~~~~~~~~~~~~~~~~~~

包含所有状态的链接。包含程序PID和程序名，使用\ ``-p``\ 选项

.. code-block:: console

   netstat -atup

以数字显示端口和主机
~~~~~~~~~~~~~~~~~~~~

使用\ ``-n``\ 选项

.. code-block:: console

   netstat -atupn

.. code-block:: console

   root@ubuntu:~# netstat -atupn
   Active Internet connections (servers and established)
   Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
   tcp        0      0 127.0.0.1:3306          0.0.0.0:*               LISTEN      18023/mysqld
   tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN      17722/nginx
   tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      17590/sshd
   tcp        0      0 xxx.xxx.xxx.xxx:991    0.0.0.0:*               LISTEN      21397/python
   tcp        0      0 xxx.xxx.xxx.xxx:992    0.0.0.0:*               LISTEN      21397/python
   tcp        0      0 127.0.0.1:6011          0.0.0.0:*               LISTEN      19062/1
   tcp6       0      0 :::7500                 :::*                    LISTEN      1832/frps
   tcp6       0      0 :::8080                 :::*                    LISTEN      1832/frps
   tcp6       0      0 :::80                   :::*                    LISTEN      17722/nginx
   tcp6       0      0 :::7000                 :::*                    LISTEN      1832/frps
   tcp6       0      0 ::1:6011                :::*                    LISTEN      19062/1
   udp    42368      0 0.0.0.0:44810           0.0.0.0:*                           21397/python
   udp    27648      0 0.0.0.0:50484           0.0.0.0:*                           1207/miredo
   udp        0      0 127.0.0.1:4500          0.0.0.0:*                           1120/pluto
   udp     4608      0 xxx.xxx.xxx.xxx:4500     0.0.0.0:*                           1120/pluto
   udp        0      0 127.0.0.1:500           0.0.0.0:*                           1120/pluto
   udp    15360      0 xxx.xxx.xxx.xxx:500      0.0.0.0:*                           1120/pluto
   udp        0      0 xxx.xxx.xxx.xxx:991    0.0.0.0:*                           21397/python
   udp    13056      0 xxx.xxx.xxx.xxx:992    0.0.0.0:*                           21397/python
   udp6       0      0 ::1:500                 :::*                                1120/pluto
   udp6       0      0 :::9910                 :::*                                1824/server_linux_a
   root@ubuntu:~#

注意要显示PID和程序名，可能需要有root权限，否则root用户的进程 ###
显示所有网络接口

.. code-block:: console

   [root@ubuntu:]~# netstat -i
   Kernel Interface table
   Iface   MTU Met   RX-OK RX-ERR RX-DRP RX-OVR    TX-OK TX-ERR TX-DRP TX-OVR Flg
   eth0       1500 0    797518      0      0 0        677533      0      0      0 BMRU
   lo        65536 0       340      0      0 0           340      0      0      0 LRU
   teredo     1280 0         8      0      0 0            63      0      0      0 MOPRU
   root@ubuntu:~#

::

   netstat -ie
   #like ifconfig

查询指定端口上的进程
~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

   netstat -anp | grep ":80"

.. code-block:: console

   root@ubuntu:~# netstat -anp | grep ":80"
   tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN      17722/nginx
   tcp6       0      0 :::8080                 :::*                    LISTEN      1832/frps
   tcp6       0      0 :::80                   :::*                    LISTEN      17722/nginx

只显示ipv4结果，使用\ ``-4``\ 选项

.. code-block:: console

   root@ubuntu:~# netstat -4anp | grep ":80"
   tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN      17722/nginx

lsof也可以实现类似效果

.. code-block:: console

   lsof -i :80

显示主机路由
~~~~~~~~~~~~

.. code-block:: console

   netstat -r
   netstat -rn

IP地址查询主机名
~~~~~~~~~~~~~~~~

::

   nslookup 139.159.243.11

.. code-block:: console

   root@ubuntu:~# nslookup 139.159.243.11
   Server:         8.8.8.8
   Address:        8.8.8.8#53

   Non-authoritative answer:
   11.243.159.139.in-addr.arpa     name = ecs-139-159-243-11.compute.hwclouds-dns.com.

   Authoritative answers can be found from:

###主机名查询IP地址

.. code-block:: console

   ping ecs-139-159-243-11.compute.hwclouds-dns.com

.. code-block:: console

   root@ubuntu:~# ping ecs-139-159-243-11.compute.hwclouds-dns.com
   PING ecs-139-159-243-11.compute.hwclouds-dns.com (139.159.243.11) 56(84) bytes of data.
   64 bytes from ecs-139-159-243-11.compute.hwclouds-dns.com (139.159.243.11): icmp_seq=1 ttl=44 time=160 ms
   64 bytes from ecs-139-159-243-11.compute.hwclouds-dns.com (139.159.243.11): icmp_seq=2 ttl=44 time=161 ms
   64 bytes from ecs-139-159-243-11.compute.hwclouds-dns.com (139.159.243.11): icmp_seq=3 ttl=44 time=160 ms
   64 bytes from ecs-139-159-243-11.compute.hwclouds-dns.com (139.159.243.11): icmp_seq=4 ttl=44 time=160 ms
