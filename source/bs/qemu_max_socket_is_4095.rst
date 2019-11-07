qemu max socket is 4095
=======================

使用qemu时出现最大socket报错：

ubuntu 上的报错
---------------

Error polling connection ‘qemu:///system’: internal error: Socket 5418
can’t be handled (max socket is 4095)

|image0|

` <https://bugs.launchpad.net/ubuntu/+source/libvirt/+bug/1811198>`__

CentOS上的报错
--------------

报错记录
--------

目前有亮起报错，其中一个是：

::

   virsh node info
   error:failed to get node information
   error: internal error: Socket 6378 can't be handled(max socket is 4095)

解决办法
--------

https://github.com/libvirt/libvirt/commit/ba35ac2ebbc7f94abc50ffbf1d681458e2406444
https://www.redhat.com/archives/libvir-list/2018-August/msg00798.html

.. |image0| image:: https://launchpadlibrarian.net/405637969/error_virt.png

