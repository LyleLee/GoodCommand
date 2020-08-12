*********************************************
netlink libnml libnetlink rtnetlink
*********************************************

netlink
    是一个协议， 用于内核态和用户态的socket通信 [#netlink]_
libnetlink
    用于访问netlink服务的库 [#libnetlink]_
linmnl
    libmnl是面向Netlink开发人员的简约用户空间库

关于他们更多的比较， 可以查看 [#netfilter_netlink]_ 中的介绍

.. note::

    It is often better to use netlink via libnetlink or libnl than via the low-level kernel interface. [#netlink]_

.. note::

    libnetlink, This library is meant for internal use, use libmnl for new programs. [#libnetlink]_

.. [#netlink] http://man7.org/linux/man-pages/man7/netlink.7.html
.. [#libnetlink] http://man7.org/linux/man-pages/man3/libnetlink.3.html
.. [#libml] https://git.netfilter.org/libmnl/
.. [#netfilter_netlink] http://people.netfilter.org/pablo/netlink/netlink-libmnl-manual.pdf