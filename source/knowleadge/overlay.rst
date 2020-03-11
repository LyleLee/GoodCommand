**********************************
overlay、underlay、大二层网络概念
**********************************

名词理解了就简单了，主要参考这篇文章 [#32486650]_

:undelay: 也就是承载网。 路由可以扩散， 我添加一个路由， 全网要通告。
:overlay: 承载网之上的网络。 客户的CE路由器通过承载网创建隧道， 实现两个客户网络路由互通，
          客户网络路由不影响承载网网络的路由。通常建立在承载网之上的各种VPN叫做overlay网络。
:大二层: 在underlay网络之上建立更大的二层网络，实现虚机迁移需求。



Network Virtualization Overlays（NOV3技术）的代表：

.. csv-table::
    :header: overlay, 厂家, 技术

    VxLAN,  VMware,     MAC in UDP
    NvGRE,  Microsoft,  MAC in GRE
    STT,    Nicira,     MAC in TCP

.. [#32486650] https://zhuanlan.zhihu.com/p/32486650
