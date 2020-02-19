******************
brctl
******************

brctl 常用命令
=======================

.. code-block:: shell

    brctl addbr stage       #添加虚拟交换机stage
    brctl delbr stage       #删除虚拟交换机stage， 需要交换机是down的状态
    brctl addif dev eth0    #添加接口的虚拟交换机
    brctl addif dev eth0    #删除dev交换机上的eth0接口
    brctl stp dev off       #关闭STP
    brctl stp dev on        #启动STP

.. code-block:: console

    [user1@centos bin]$ brctl show
    bridge name     bridge id               STP enabled     interfaces
    dev             8000.000000000000       no
    docker0         8000.02420d8a54b5       no
    prod            8000.000000000000       no
    stage           8000.000000000000       no
    virbr0          8000.5254003852f7       yes             virbr0-nic
    [user1@centos bin]$

virbr0-nic是virbr0上的一张卡



参考文档

1. brctl Command Examples for Ethernet Network Bridge https://www.thegeekstuff.com/2017/06/brctl-bridge/
