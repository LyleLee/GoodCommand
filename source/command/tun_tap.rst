*************************
tun/tap
*************************





创建tun设备
==================

代码在src目录下。


实验： 创建两个net namespace并使他们互通


.. code-block:: shell

    # 查看已有的net namespace
    ip netns list

    # 创建两个namespace net0 net1
    sudo ip netns add net0
    sudo ip netns add net1


    #创建veth pair
    sudo ip link add type veth

    #分别加入到两个namespace当中
    sudo ip link set veth0 netns net0
    sudo ip link set veth1 netns net1

    #分别为两个namespac中的veth添加ip并且up
    sudo ip netns exec net0 ip addr add 10.0.1.1/24 dev veth0
    sudo ip netns exec net1 ip addr add 10.0.1.2/24 dev veth1
    sudo ip netns exec net0 ip link set veth0 up
    sudo ip netns exec net1 ip link set veth1 up

测试：

.. code-block:: shell

    sudo ip netns exec net0 ping -c 3 10.0.1.2


实验： 创建交换机使两个net namespace互通

.. code-block:: shell

    #连接创建三个namespace
    ip netns add net0
    ip netns add net1
    ip netns add bridge

    #net0 连接到bridge
    ip link add type veth
    ip link set dev veth0 name net0-bridge netns net0
    ip link set dev veth1 name bridge-net0 netns bridge

    #net1连接到bride
    ip link add type veth
    ip link set dev veth0 name net1-bridge netns net1
    ip link set dev veth1 name bridge-net1 netns bridge

    #创建交换机，添加net0和net1的veth接口
    ip netns exec bridge brctl addbr br
    ip netns exec bridge ip link set dev br up
    ip netns exec bridge ip link set dev bridge-net0 up
    ip netns exec bridge ip link set dev bridge-net1 up
    ip netns exec bridge brctl addif br bridge-net0
    ip netns exec bridge brctl addif br bridge-net1

    #虚拟网卡配置IP
    ip netns exec net0 ip link set dev net0-bridge up
    ip netns exec net0 ip address add 10.0.1.1/24 dev net0-bridge
    ip netns exec net1 ip link set dev net1-bridge up
    ip netns exec net1 ip address add 10.0.1.2/24 dev net1-bridge

测试： 在net0中ping net1

.. code-block:: shell

    ip netns exec net0 ping -c 3 10.0.1.2



实验： 创建tuntap设备 [#tuntap]_

.. code-block:: shell

    ip link add br0 type bridge
    ip tuntap add dev tap0 mod tap # 创建 tap
    ip tuntap add dev tun0 mod tun # 创建 tun
    ip tuntap del dev tap0 mod tap # 删除 tap
    ip tuntap del dev tun0 mod tun # 删除 tun

    ip link add br0 type bridge
    ip netns add netns1
    ip link add type veth

    ip link set eth0 master br0
    ip link set veth1 master br0
    ip link set veth0 netns netns1


.. code-block:: xml

    <interface type='bridge'>
      <mac address='52:54:00:38:06:f9'/>
      <source bridge='br0'/>
      <model type='virtio'/>
      <address type='pci' domain='0x0000' bus='0x01' slot='0x00' function='0x0'/>
    </interface>


veth
==================

veth是虚拟网卡， 成对出现，从其中一个网卡发出的数据包， 会直接出现在另一张网卡上， 即使这两张网卡在不同的
Network namespace当中。

使用veth的常见的有： :doc:`kvm`,:doc:`docker`


参考资料
==================

tun tap 解释出处
    https://www.fir3net.com/Networking/Terms-and-Concepts/virtual-networking-devices-tun-tap-and-veth-pairs-explained.html

tun、tap、macvlan、mactap的作用
    + tun是一个三层设备， 通过/dev/tunX 收发IP数据包
    + tap是一个二层设备， 通过/dev/tap 收发二层数据包，可以与物理网卡bridge
    + macvlan 实现一个网卡绑定多个mac地址，进而对应多个IP
    + mactap 是对macvlan的改进， macvlan会把数据交给网络协议栈， mactap把数据交给tapX

    https://blog.kghost.info/2013/03/27/linux-network-tun/
    https://blog.kghost.info/2013/03/01/linux-network-emulator/

创建tun设备的示例程序
    https://blog.csdn.net/sld880311/article/details/77854651


    https://www.lijiaocn.com/%E6%8A%80%E5%B7%A7/2017/03/31/linux-net-devices.html#tun%E8%AE%BE%E5%A4%87%E5%88%9B%E5%BB%BA


.. [#src] 创建一个tun设备的代码 https://github.com/LyleLee/GoodCommand/tree/master/source/src/virtual_net

tun tap 和交换机的配置

.. [#tuntap] https://developers.redhat.com/blog/2018/10/22/introduction-to-linux-interfaces-for-virtual-networking/

问题记录
================

centos没有tunctl rpm包
-----------------------
解决办法：从fedoras的源进行安装。 实际上可以使用ip tuntap命令替代

.. code-block:: shell

     sudo dnf install https://rpmfind.net/linux/fedora/linux/releases/30/Everything/aarch64/os/Packages/t/tunctl-1.5-20.fc30.aarch64.rpm
