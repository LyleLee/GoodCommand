*************
pdsh
*************
多台服务器同时执行命令。

.. code-block:: shell

    pdsh -w ^host.txt "uptime"


使用前提：

1. 运行pdsh的设备可以免密登录到被控机
   
   参考ssh免密登录设置 :ref:`ssh_password_less`


2. 指定好主机列表
    
.. code-block:: console

    [root@ceph4 bringup]# cat host.txt
    128.5.65.117
    128.5.65.118
    128.5.65.119
    128.5.65.120

3. 一般设置为ssh

原因是pdsh默认采用的是rsh登录，修改成ssh登录即可，在环境变量/etc/profile里加入：

.. code-block:: console

    export PDSH_RCMD_TYPE=ssh


否则会出现：
    
.. code-block:: console

    [root@ceph4 bringup]# pdsh -w ^host.txt "uptime"
    pdsh@ceph4: 128.5.65.120: connect: Connection refused
    pdsh@ceph4: 128.5.65.119: connect: Connection refused
    pdsh@ceph4: 128.5.65.118: connect: Connection refused
    pdsh@ceph4: 128.5.65.117: connect: Connection refused


