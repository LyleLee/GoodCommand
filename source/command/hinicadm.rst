*************************
hinicadm
*************************

1822网卡管理工具

.. code-block:: shell

    hinicadm info                 #查看1822网口信息
    hinicadm reset -i hinicX -p X #恢复出厂设置，X换位相应的ID
    hinicadm reset -i hinic0 -p 0


1822驱动自动加载

.. code-block:: shell

    cp hinic.ko /lib/modules/`uname -r`/updates
    depmod `uname -r`
