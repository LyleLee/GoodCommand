**********************
ovs
**********************

OVS(Open vSwitch) 开源虚拟交换机，支持openflow， 可以建立vm或者容器间的VxLAN网络

OVS主要有两个服务 `ovsdb-server` `ovs-vswitchd`

快速了解OVS一个简单的视频介绍 [#openvswitch]_ 和OVS的openflow实验 [#zhihu]_

ovs常用命令
============================

ovs命令分成几类， 交换价命令以ovs-vsctl开头， 容器相关命令ovs-docker开头，
openflow相关命令以ovs-ofctl开头 [#ovs_ofctl]_

.. code-block:: shell

    ovs-vsctl list-br               # 列出host上的所有交换机
    ovs-vsctl list-ifaces ovs-br2   # 列出ovs-br2上的所有接口

    ovs-ofctl show ovs-br2          # openflow操作，查看虚拟交换机ovs-br2信息，端口、速率等

    ovs-docker add-port ovs-br1 eth1 containerA --ipaddress=173.16.1.2/24   # 添加接口到docker中
    ovs-docker del-port ovs-br2 eth1 container_overlay                      # 删除docker中的接口
    ovs-ofctl add-flow ovs-br2 "priority=1,in_port=1,actions=output:4"      # 根据端口添加转发规则
    ovs-ofctl add-flow ovs-br2 "dl_src=<mac/mask>,actions=<action>"         #
    ovs-ofctl add-flow ovs-br2 "dl_dst=66:54:7a:62:b6:10,actions=output:4"


ovs安装
============================

make install 和 ovs-ctl start 需要root用户执行 [#docs_openvswitch]_

.. code-block:: shell

    wget https://www.openvswitch.org/releases/openvswitch-2.5.9.tar.gz
    tar -xf openvswitch-2.5.9.tar.gz
    cd openvswitch-2.5.9/
    su - root
    ./boot.sh
    ./configure
    make
    make install
    export PATH=$PATH:/usr/share/openvswitch/scripts
    ovs-ctl -V
    mkdir -p /usr/local/etc/openvswitch
    ovsdb-tool create /usr/local/etc/openvswitch/conf.db vswitchd/vswitch.ovsschema
    mkdir -p /usr/local/var/run/openvswitch
    ovsdb-server --remote=punix:/usr/local/var/run/openvswitch/db.sock     \
                 --remote=db:Open_vSwitch,Open_vSwitch,manager_options     \
                 --private-key=db:Open_vSwitch,SSL,private_key             \
                 --certificate=db:Open_vSwitch,SSL,certificate             \
                 --bootstrap-ca-cert=db:Open_vSwitch,SSL,ca_cert           \
                 --pidfile --detach --log-file
    ovs-vsctl --no-wait init
    ovs-vswitchd --pidfile --detach --log-file
    ovs-vsctl show


OVS上添加docker容器
===========================

向docker容器添加接口

.. code-block:: shell

    ovs-docker add-port ovs-br1 eth1 container1 --ipaddress=173.16.1.2/24

性能测试请查看 :doc:`docker_network`



OVS建立VXLAN overlay网络
============================

在host1上执行操作

.. code-block:: shell

    docker run -itd --name container_overlay ubuntu /bin/bash

    ovs-vsctl add-br ovs-br2
    ovs-vsctl add-port ovs-br2 vxlan0 -- set interface vxlan0 type=vxlan options:remote_ip=192.168.1.180

    ovs-docker add-port ovs-br2 eth1 container_overlay --ipaddress=10.10.10.2/24 --mtu=1450


.. code-block:: console

    [root@centos86 ~]# ovs-vsctl show
    4c77c506-329c-4c46-9f73-1fcbddcd37f4
        Bridge "ovs-br2"
            Port "ovs-br2"
                Interface "ovs-br2"
                    type: internal
            Port "vxlan0"
                Interface "vxlan0"
                    type: vxlan
                    options: {remote_ip="192.168.1.180"}
    [root@centos86 ~]#


在host2上执行操作

.. code-block:: shell

    docker run -itd --name container_overlay ubuntu /bin/bash

    ovs-vsctl add-br ovs-br2
    ovs-vsctl add-port ovs-br2 vxlan0 -- set interface vxlan0 type=vxlan options:remote_ip=192.168.1.203

    ovs-docker add-port ovs-br2 eth1 container_overlay --ipaddress=100.1.1.3/24

.. code-block:: shell

    [root@localhost ~]# ovs-vsctl show
    ecfa0606-a9fe-45c5-a00b-79dbc1afe918
        Bridge "ovs-br2"
            Port "vxlan0"
                Interface "vxlan0"
                    type: vxlan
                    options: {remote_ip="192.168.1.203"}
            Port "ovs-br2"
                Interface "ovs-br2"
                    type: internal
    [root@localhost ~]#


.. caution::
    VXLAN 默认使用端口4789端口进行通信。防火墙可能会吧数据包拦截。关闭防火墙或者放心端口。
    设置请参考 :doc:`firewall`

在host2的容器中测试ping

.. code-block:: console

    root@b5590303e704:/# ping 100.1.1.2
    PING 100.1.1.2 (100.1.1.2) 56(84) bytes of data.
    64 bytes from 100.1.1.2: icmp_seq=1 ttl=64 time=0.249 ms
    64 bytes from 100.1.1.2: icmp_seq=2 ttl=64 time=0.191 ms
    64 bytes from 100.1.1.2: icmp_seq=3 ttl=64 time=0.148 ms
    64 bytes from 100.1.1.2: icmp_seq=4 ttl=64 time=0.136 ms


更加详细的性能测试实验 :doc:`docker_network`

ovs问题记录：
===========================

ovsdb-server nice: cannot set niceness: Permission denied
-----------------------------------------------------------------

.. code-block:: console

    [user1@centos86 openvswitch-2.5.9]$ ovs-ctl start
    Starting ovsdb-server nice: cannot set niceness: Permission denied
    ovsdb-server: /var/run/openvswitch/ovsdb-server.pid.tmp: create failed (Permission denied)
                                                            [FAILED]
    ovs-vsctl: unix:/var/run/openvswitch/db.sock: database connection failed (No such file or directory)
    [user1@centos86 openvswitch-2.5.9]$ sudo ovs-ctl start

    [user1@centos86 ~]$ ovs-cvsctl add-br vovs-br0
    ovs-vsctl: unix:/usr/local/var/run/openvswitch/db.sock: database connection failed (No such file or directory

解决办法： 参考安装步骤创建db.sock， 并且以root用户启动

.. code-block:: console

    [root@centos86 openvswitch-2.5.9]# ovs-ctl start


system ID not configured, please use --system-id
-----------------------------------------------------------------

.. code-block:: console

    [root@centos86 openvswitch-2.5.9]# ovs-ctl start
    Starting ovsdb-server                                      [  OK  ]
    system ID not configured, please use --system-id ... failed!
    Configuring Open vSwitch system IDs                        [  OK  ]
    Inserting openvswitch module                               [  OK  ]
    Starting ovs-vswitchd                                      [  OK  ]
    Enabling remote OVSDB managers                             [  OK  ]

    解决办法： 随机分配一个id [#ovs-ctl]_

.. code-block:: console

    [root@centos86 openvswitch-2.5.9]# ovs-ctl --system-id=random start


ovs 参考资料
===========================

.. [#docs_openvswitch] 官方文档 http://docs.openvswitch.org/en/latest/intro/install/general/#configuring
.. [#ovs_ofctl] ovs-ofctl 常用命令 https://docs.pica8.com/pages/viewpage.action?pageId=3083175
.. [#vxlan_overlay] VXLAN overlay https://www.youtube.com/watch?v=tnSkHhsLqpM
.. [#openvswitch] open vswitch https://www.youtube.com/watch?v=rYW7kQRyUvA
.. [#zhihu] ovs openflow实验 https://zhuanlan.zhihu.com/p/37408341
.. [#ovs-ctl] http://manpages.ubuntu.com/manpages/cosmic/man8/ovs-ctl.8.html