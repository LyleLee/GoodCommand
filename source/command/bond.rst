************************
bond
************************

在服务器看来，bond就是多个网口组bond，变成一个虚拟网口，在虚拟网口上设置一个IP地址，虚拟网口拥有更大的带宽。
在交换机看来，bond就是链路聚合，多个端口聚合在一起形成一个更大带宽的链路。 交换机不仅可以本台设备上聚合，还可以跨设备聚合。

服务器的配置
=======================


bond的配置目标
-------------------------

.. code-block:: console

    +--------------------------------------------------------------------+
    |                        交换机                                      |
    |                                                                    |
    |                 XGigabitEthernet0/0/3        XGigabitEthernet0/0/7 |
    |     XGigabitEthernet0/0/1    XGigabitEthernet0/0/5                 |
    |         +--+    +--+             +--+      +--+                    |
    +--------------------------------------------------------------------+
              +--+    +--+             +--+      +--+
               |       |                |         |
               |       |                |         |
               | bond0 |                |   bond1 |
               |       |                |         |
        +-----++-+----++-+-------------++-+------++-+--------+
        |     |  |    |  |             |  |      |  |        |
        |     +--+    +--+             +--+      +--+        |
        |    enp137s0 enp138s0        enp139s0    enp140s0   |
        |                                                    |
        +----------------------------------------------------+
                       服务器

enp137s0的配置
-------------------------

主要关注MASTER指定为bond0， SLAVE指定为yes

.. literalinclude:: ../resources/bond_config/ifcfg-enp137s0
   :language: ini
   :linenos:
   :emphasize-lines: 16-17

enp138s0的配置
-------------------------

主要关注MASTER指定为bond0， SLAVE指定为yes

.. literalinclude:: ../resources/bond_config/ifcfg-enp138s0
   :language: ini
   :linenos:
   :emphasize-lines: 16-17

enp139s0的配置
-------------------------

主要关注MASTER指定为bond1， SLAVE指定为yes

.. literalinclude:: ../resources/bond_config/ifcfg-enp139s0
   :language: ini
   :linenos:
   :emphasize-lines: 16-17

enp140s0的配置
-------------------------

主要关注MASTER指定为bond1， SLAVE指定为yes

.. literalinclude:: ../resources/bond_config/ifcfg-enp140s0
   :language: ini
   :linenos:
   :emphasize-lines: 16-17

bond0的配置
-------------------------

.. literalinclude:: ../resources/bond_config/ifcfg-bond0
   :language: ini
   :linenos:

bond1的配置
-------------------------

.. literalinclude:: ../resources/bond_config/ifcfg-bond1
   :language: ini
   :linenos:



bonad的配置结果
-----------------------

.. code-block:: console

    10: enp137s0: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc mq master bond0 state UP group default qlen 1000
        link/ether 9c:52:f8:91:c3:c3 brd ff:ff:ff:ff:ff:ff
    11: enp138s0: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc mq master bond0 state UP group default qlen 1000
        link/ether 9c:52:f8:91:c3:c3 brd ff:ff:ff:ff:ff:ff
    12: enp139s0: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc mq master bond1 state UP group default qlen 1000
        link/ether 9c:52:f8:91:c3:c5 brd ff:ff:ff:ff:ff:ff
    13: enp140s0: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc mq master bond1 state UP group default qlen 1000
        link/ether 9c:52:f8:91:c3:c5 brd ff:ff:ff:ff:ff:ff
    14: bond1: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
        link/ether 9c:52:f8:91:c3:c5 brd ff:ff:ff:ff:ff:ff
        inet 128.10.200.10/24 brd 128.10.200.255 scope global noprefixroute bond1
           valid_lft forever preferred_lft forever
        inet6 fe80::9e52:f8ff:fe91:c3c5/64 scope link
           valid_lft forever preferred_lft forever
    15: bond0: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
        link/ether 9c:52:f8:91:c3:c3 brd ff:ff:ff:ff:ff:ff
        inet 128.10.100.10/24 brd 128.10.100.255 scope global noprefixroute bond0
           valid_lft forever preferred_lft forever
        inet6 fe80::9e52:f8ff:fe91:c3c3/64 scope link
           valid_lft forever preferred_lft forever

网口enp137s0和enp138s0属于bond0，网口enp139s0和enp140s0属于bond1。bond0和bond1是生成的虚拟网口

交换机的配置
=============

交换机配置过程
--------------------


创建一个trunk接口，设置lacp

.. code-block:: shell

    interface Eth-Trunk8
     port link-type trunk
     mode lacp
     undo local-preference enable

    interface Eth-Trunk9
     port link-type trunk
     mode lacp
     undo local-preference enable


把其中两个接口绑定到eth-trunk 8是bond0。绑定两个接口到eth-trunk 9对应bond1

.. code-block:: shell

    interface XGigabitEthernet0/0/1
     flow-control
     eth-trunk 8
    interface XGigabitEthernet0/0/3
     flow-control
     eth-trunk 8

    interface XGigabitEthernet0/0/5
     flow-control
     eth-trunk 9
    interface XGigabitEthernet0/0/7
     flow-control
     eth-trunk 9
    #



交换机配置结果：
---------------------

可以看到接口Eth-Trunk8包含了两个10GE口。

.. code-block:: console
   :emphasize-lines: 22-24

    [Quidway-Eth-Trunk8]dis interface brief
    PHY: Physical
    *down: administratively down
    (l): loopback
    (s): spoofing
    (E): E-Trunk down
    (b): BFD down
    (e): ETHOAM down
    (dl): DLDP down
    (d): Dampening Suppressed
    InUti/OutUti: input utility/output utility
    Interface                   PHY   Protocol InUti OutUti   inErrors  outErrors

      XGigabitEthernet0/0/29    up    up          0%     0%          0          0
      XGigabitEthernet0/0/31    up    up          0%     0%          0          0
    Eth-Trunk6                  up    up          0%     0%          0          0
      XGigabitEthernet0/0/30    up    up          0%     0%          0          0
      XGigabitEthernet0/0/32    up    up          0%     0%          0          0
    Eth-Trunk7                  down  down        0%     0%          0          0
      XGigabitEthernet0/0/34    up    up          0%     0%          0          0
      XGigabitEthernet0/0/36    down  down        0%     0%          0          0
    Eth-Trunk8                  up    up       0.02%  0.02%          0          0
      XGigabitEthernet0/0/1     up    up       0.02%  0.02%          0          0
      XGigabitEthernet0/0/3     up    up       0.01%  0.02%          0          0
    Eth-Trunk9                  up    up       0.01%  0.01%          0          0
      XGigabitEthernet0/0/5     up    up       0.02%  0.01%          0          0
      XGigabitEthernet0/0/7     up    up       0.01%  0.02%          0          0
    Eth-Trunk10                 up    up       0.01%  0.01%          0          0
      XGigabitEthernet0/0/2     up    up          0%  0.01%          0          0
      XGigabitEthernet0/0/4     up    up       0.01%  0.01%          0          0
    Eth-Trunk11                 up    up          0%     0%          0          0
      XGigabitEthernet0/0/6     up    up       0.01%     0%          0          0


.. code-block:: console

    [Quidway]display eth-trunk 8
    Eth-Trunk8's state information is:
    Local:
    LAG ID: 8                   WorkingMode: LACP
    Preempt Delay: Disabled     Hash arithmetic: According to SIP-XOR-DIP
    System Priority: 32768      System ID: 94db-da37-c340
    Least Active-linknumber: 1  Max Active-linknumber: 8
    Operate status: up          Number Of Up Port In Trunk: 2
    --------------------------------------------------------------------------------
    ActorPortName          Status   PortType PortPri PortNo PortKey PortState Weight
    XGigabitEthernet0/0/1  Selected 10GE     32768   15     2113    10111100  1
    XGigabitEthernet0/0/3  Selected 10GE     32768   16     2113    10111100  1

    Partner:
    --------------------------------------------------------------------------------
    ActorPortName          SysPri   SystemID        PortPri PortNo PortKey PortState
    XGigabitEthernet0/0/1  65535    9c52-f891-c3c3  255     1      15      11111100
    XGigabitEthernet0/0/3  65535    9c52-f891-c3c3  255     2      15      11111100

    [Quidway]display eth-trunk 9
    Eth-Trunk9's state information is:
    Local:
    LAG ID: 9                   WorkingMode: LACP
    Preempt Delay: Disabled     Hash arithmetic: According to SIP-XOR-DIP
    System Priority: 32768      System ID: 94db-da37-c340
    Least Active-linknumber: 1  Max Active-linknumber: 8
    Operate status: up          Number Of Up Port In Trunk: 2
    --------------------------------------------------------------------------------
    ActorPortName          Status   PortType PortPri PortNo PortKey PortState Weight
    XGigabitEthernet0/0/5  Selected 10GE     32768   17     2369    10111100  1
    XGigabitEthernet0/0/7  Selected 10GE     32768   18     2369    10111100  1

    Partner:
    --------------------------------------------------------------------------------
    ActorPortName          SysPri   SystemID        PortPri PortNo PortKey PortState
    XGigabitEthernet0/0/5  65535    9c52-f891-c3c5  255     1      15      11111100
    XGigabitEthernet0/0/7  65535    9c52-f891-c3c5  255     2      15      11111100

    [Quidway]


在Eth-Trunk8接口上可以看到学到的服务器mac地址9c52-f891-c3c3；在Eth-Trunk9接口上可以看到学到的服务器mac地址9c52-f891-c3c5

.. code-block:: console
   :emphasize-lines: 8

    [Quidway]display mac-address
    -------------------------------------------------------------------------------
    MAC Address    VLAN/VSI                          Learned-From        Type
    -------------------------------------------------------------------------------
    0000-0000-0316 1/-                               XGE0/0/48           dynamic
    0001-0263-0405 1/-                               XGE0/0/48           dynamic
    0001-0800-00b6 1/-                               XGE0/0/48           dynamic
    9c52-f891-c3c3 1/-                               Eth-Trunk8          dynamic
    9c52-f891-c3c5 1/-                               Eth-Trunk9          dynamic
    9c52-f892-15f3 1/-                               Eth-Trunk6          dynamic
    9c52-f892-4d23 1/-                               Eth-Trunk14         dynamic


其它知识
===================

链路聚合有多种模式，这里使用的是mode4，更多模式相关的内容需要搜索查询。