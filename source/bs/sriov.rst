*************************
check sr-iov
*************************

sr-iov主要由网卡进行支持。 需要在bios开启sr-iov选项。

支持情况：

================   ==============  ============
服务器型号          网卡类型         是否支持
================   ==============  ============
Taishan2280 V1      板载网卡        不支持
Taishan2280 V1      其它网卡        不支持
Taishan2280 V2      板载网卡        支持
Taishan2280 V2      其它网卡        由网卡决定
================   ==============  ============
                   


在Taishan 2280v2上，确认是否支持sr-iov


.. code-block:: console

                            Huawei BIOS Setup Utility V2.0
              Advanced
    /--------------------------------------------------------+---------------------\
    |                     PCIe Config                        |    Help Message     |
    |--------------------------------------------------------+---------------------|
    | > CPU 0 PCIE Configuration                             |Press <Enter> to     |
    | > CPU 1 PCIE Configuration                             |config this CPU.     |
    |   Support DPC                  <Disable>               |                     |
    |   SRIOV                        <Enable>                |                     |
    |   Hilink5 Work Mode            <PCIe Mode>             |                     |
    |   PCIe DSM5# Mode              <BIOS Reserve>          |                     |
    |                                                        |                     |
    |                                                        |                     |
    |                                                        |                     |
    |                                                        |                     |
    |                                                        |                     |
    |                                                        |                     |
    |                                                        |                     |
    |                                                        |                     |
    |                                                        |                     |
    |                                                        |                     |
    |                                                        |                     ||UniqueQuestionId(), QuestionId :0x32FE.
    |--------------------------------------------------------+---------------------|
    | F1  Help     ^v  Select Item    -/+   Change Value     | F9  Setup Defaults  |
    | Esc Exit     <>  Select Menu    Enter Select>Sub-Menu  | F10 Save & Exit     |
    |etUniqueQuestionId(), QuestionId :0x32FE.    


.. code-block:: console

    [user1@centos ~]$ ls -la /sys/class/net/
    total 0
    drwxr-xr-x.  2 root root 0 Dec 12 10:54 .
    drwxr-xr-x. 70 root root 0 Dec 12 10:52 ..
    lrwxrwxrwx.  1 root root 0 Dec 12 10:52 enp125s0f0 -> ../../devices/pci0000:7c/0000:7c:00.0/0000:7d:00.0/net/enp125s0f0
    lrwxrwxrwx.  1 root root 0 Dec 12 10:52 enp125s0f1 -> ../../devices/pci0000:7c/0000:7c:00.0/0000:7d:00.1/net/enp125s0f1
    lrwxrwxrwx.  1 root root 0 Dec 12 10:52 enp125s0f2 -> ../../devices/pci0000:7c/0000:7c:00.0/0000:7d:00.2/net/enp125s0f2
    lrwxrwxrwx.  1 root root 0 Dec 12 10:52 enp125s0f3 -> ../../devices/pci0000:7c/0000:7c:00.0/0000:7d:00.3/net/enp125s0f3
    lrwxrwxrwx.  1 root root 0 Dec 12 10:52 enp189s0f0 -> ../../devices/pci0000:bc/0000:bc:00.0/0000:bd:00.0/net/enp189s0f0
    lrwxrwxrwx.  1 root root 0 Dec 12 10:52 enp189s0f1 -> ../../devices/pci0000:bc/0000:bc:00.0/0000:bd:00.1/net/enp189s0f1
    lrwxrwxrwx.  1 root root 0 Dec 12 10:52 enp189s0f2 -> ../../devices/pci0000:bc/0000:bc:00.0/0000:bd:00.2/net/enp189s0f2
    lrwxrwxrwx.  1 root root 0 Dec 12 10:52 enp189s0f3 -> ../../devices/pci0000:bc/0000:bc:00.0/0000:bd:00.3/net/enp189s0f3
    lrwxrwxrwx.  1 root root 0 Dec 12 10:52 lo -> ../../devices/virtual/net/lo
    lrwxrwxrwx.  1 root root 0 Dec 12 10:52 virbr0 -> ../../devices/virtual/net/virbr0
    lrwxrwxrwx.  1 root root 0 Dec 12 10:52 virbr0-nic -> ../../devices/virtual/net/virbr0-nic
    [user1@centos ~]$ find /sys -name sriov_numvfs 2>/dev/null
    /sys/devices/pci0000:74/0000:74:01.0/0000:75:00.0/sriov_numvfs
    /sys/devices/pci0000:b4/0000:b4:01.0/0000:b5:00.0/sriov_numvfs
    /sys/devices/pci0000:7c/0000:7c:00.0/0000:7d:00.3/sriov_numvfs
    /sys/devices/pci0000:7c/0000:7c:00.0/0000:7d:00.1/sriov_numvfs
    /sys/devices/pci0000:7c/0000:7c:00.0/0000:7d:00.2/sriov_numvfs
    /sys/devices/pci0000:7c/0000:7c:00.0/0000:7d:00.0/sriov_numvfs
    /sys/devices/pci0000:bc/0000:bc:00.0/0000:bd:00.1/sriov_numvfs
    /sys/devices/pci0000:bc/0000:bc:00.0/0000:bd:00.2/sriov_numvfs
    /sys/devices/pci0000:bc/0000:bc:00.0/0000:bd:00.0/sriov_numvfs
    /sys/devices/pci0000:bc/0000:bc:00.0/0000:bd:00.3/srio

.. code-block:: console

    [user1@centos ~]$ sudo echo 1 > /sys/devices/pci0000:bc/0000:bc:00.0/0000:bd:00.3/sriov_numvfs
    -bash: /sys/devices/pci0000:bc/0000:bc:00.0/0000:bd:00.3/sriov_numvfs: Permission denied
    [user1@centos ~]$ su root
    Password:
    [root@centos user1]# history^C
    [root@centos user1]# sudo echo 1 > /sys/devices/pci0000:7c/0000:7c:00.0/0000:7d:00.1/sriov_numvfs
    [root@centos user1]# cat /sys/devices/pci0000:7c/0000:7c:00.0/0000:7d:00.1/sriov_numvfs
    1
    [root@centos user1]# echo 1 > /sys/devices/pci0000:bc/0000:bc:00.0/0000:bd:00.3/sriov_numvfs
    [root@centos user1]# cat /sys/devices/pci0000:bc/0000:bc:00.0/0000:bd:00.3/sriov_numvfs
    1
    [root@centos user1]#
