
这里记录使用过的硬盘的硬件信息


SSD 
---------------

.. code-block:: console

    [root@ceph1 ~]# smartctl -a /dev/sdv
    smartctl 6.6 2017-11-05 r4594 [aarch64-linux-4.19.36-vhulk1906.1.0.h288_c.eulerosv2r8.aarch64] (local build)
    Copyright (C) 2002-17, Bruce Allen, Christian Franke, www.smartmontools.org

    === START OF INFORMATION SECTION ===
    Device Model:     SAMSUNG MZ7KH960HAJR-00005
    Serial Number:    S47NNE0M104708
    LU WWN Device Id: 5 002538 e0003d8a5
    Firmware Version: HXM7304Q
    User Capacity:    960,197,124,096 bytes [960 GB]
    Sector Sizes:     512 bytes logical, 4096 bytes physical
    Rotation Rate:    Solid State Device
    Form Factor:      2.5 inches
    Device is:        Not in smartctl database [for details use: -P showall]
    ATA Version is:   ACS-4 T13/BSR INCITS 529 revision 5
    SATA Version is:  SATA 3.2, 6.0 Gb/s (current: 6.0 Gb/s)
    Local Time is:    Tue Dec 10 14:10:25 2019 CST
    SMART support is: Available - device has SMART capability.
    SMART support is: Enabled

查询SAMSUNG MZ7KH960HAJR-00005得到额外的信息 |MZ7KH960HAJR|

.. code-block:: console

    Seq. Read	540 MB/s	Seq. Write	520 MB/s
    Ran. Read	97K IOPS	Ran. Write	29K IOPS




HDD
--------------

.. code-block:: console

    物理盘信息
    接口类型：SATA
    健康状态：正常
    厂商：HGST
    型号：HUS728T8TALE600
    序列号：VAJHJ89L
    固件版本：T010
    介质类型：HDD
    温度：26 ℃
    固件状态：JBOD
    SAS地址(0)：500605b00002738d
    SAS地址(1)：0000000000000000
    容量：7.277 TB
    支持的速率：6.0 Gbps
    协商速率：12.0 Gbps
    电源状态：Spun Up
    热备状态：无
    重构状态：已停止
    巡检状态：已停止
    定位状态：关闭
    累计通电时间：2304 h
    
查询资料 |HUS728T8TALE600| 得到内部传输速率， 没有提到IOPS

.. code-block:: console

    Sustained transfer rate5
     (MiB/s, typical) 195 (8TB)
     (MB/s, typical) 205 (8TB)


.. |MZ7KH960HAJR| replace:: https://www.samsung.com/semiconductor/ssd/datacenter-ssd/MZ7KH960HAJR/
.. |HUS728T8TALE600| replace:: https://documents.westerndigital.com/content/dam/doc-library/en_us/assets/public/western-digital/product/data-center-drives/ultrastar-sas-series/data-sheet-ultrastar-he8.pdf