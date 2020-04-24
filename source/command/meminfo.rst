*********************
memory information
*********************

dmidecode
---------

dmidecode可以获取内存的完整信息，插槽，最大内存，DRR4，内存频率，电压等。

::

   me@ubuntu:~/stream$ sudo dmidecode -t memory
   [sudo] password for me:
   # dmidecode 3.1
   Getting SMBIOS data from sysfs.
   SMBIOS 3.0.0 present.

   Handle 0x0007, DMI type 16, 23 bytes
   Physical Memory Array
           Location: System Board Or Motherboard
           Use: System Memory
           Error Correction Type: None
           Maximum Capacity: 512 GB
           Error Information Handle: Not Provided
           Number Of Devices: 16

获取设备内存硬件信息：最大支持\ **512**\ GB，最大支持16个内存插槽，当前设备插有4个内存条，每个内存条大小是32GB。

1 内存条 0x0009

::

   Handle 0x0009, DMI type 17, 40 bytes
   Memory Device
           Array Handle: 0x0007
           Error Information Handle: Not Provided
           Total Width: 72 bits
           Data Width: 64 bits
           Size: 32 GB
           Form Factor: DIMM
           Set: None
           Locator: DIMM000 J11
           Bank Locator: SOCKET 0 CHANNEL 0 DIMM 0
           Type: DDR4
           Type Detail: Synchronous Registered (Buffered)
           Speed: 2400 MT/s
           Manufacturer: Samsung
           Serial Number: 0x351254BC
           Asset Tag: 1709
           Part Number: M393A4K40BB1-CRC
           Rank: 2
           Configured Clock Speed: 2400 MT/s
           Minimum Voltage: 1.2 V
           Maximum Voltage: 2.0 V
           Configured Voltage: 1.2 V

2 内存条 0x000D

::

   Handle 0x000D, DMI type 17, 40 bytes
   Memory Device
           Array Handle: 0x0007
           Error Information Handle: Not Provided
           Total Width: 72 bits
           Data Width: 64 bits
           Size: 32 GB
           Form Factor: DIMM
           Set: None
           Locator: DIMM020 J5
           Bank Locator: SOCKET 0 CHANNEL 2 DIMM 0
           Type: DDR4
           Type Detail: Synchronous Registered (Buffered)
           Speed: 2400 MT/s
           Manufacturer: Samsung
           Serial Number: 0x35125985
           Asset Tag: 1709
           Part Number: M393A4K40BB1-CRC
           Rank: 2
           Configured Clock Speed: 2400 MT/s
           Minimum Voltage: 1.2 V
           Maximum Voltage: 2.0 V
           Configured Voltage: 1.2 V

3 内存条 0x0011

::

   Handle 0x0011, DMI type 17, 40 bytes
   Memory Device
           Array Handle: 0x0007
           Error Information Handle: Not Provided
           Total Width: 72 bits
           Data Width: 64 bits
           Size: 32 GB
           Form Factor: DIMM
           Set: None
           Locator: DIMM100 J23
           Bank Locator: SOCKET 1 CHANNEL 0 DIMM 0
           Type: DDR4
           Type Detail: Synchronous Registered (Buffered)
           Speed: 2400 MT/s
           Manufacturer: Samsung
           Serial Number: 0x351258E0
           Asset Tag: 1709
           Part Number: M393A4K40BB1-CRC
           Rank: 2
           Configured Clock Speed: 2400 MT/s
           Minimum Voltage: 1.2 V
           Maximum Voltage: 2.0 V
           Configured Voltage: 1.2 V

4 内存条 0x0015

::

   Handle 0x0015, DMI type 17, 40 bytes
   Memory Device
           Array Handle: 0x0007
           Error Information Handle: Not Provided
           Total Width: 72 bits
           Data Width: 64 bits
           Size: 32 GB
           Form Factor: DIMM
           Set: None
           Locator: DIMM120 J17
           Bank Locator: SOCKET 1 CHANNEL 2 DIMM 0
           Type: DDR4
           Type Detail: Synchronous Registered (Buffered)
           Speed: 2400 MT/s
           Manufacturer: Samsung
           Serial Number: 0x35125924
           Asset Tag: 1709
           Part Number: M393A4K40BB1-CRC
           Rank: 2
           Configured Clock Speed: 2400 MT/s
           Minimum Voltage: 1.2 V
           Maximum Voltage: 2.0 V
           Configured Voltage: 1.2 V

free
----

free可以获取系统可用内存大小、内存占用情况。

.. code:: shell-session

   root@ubuntu:~# free -h
                 total        used        free      shared  buff/cache   available
   Mem:           125G        810M        105G        1.1M         19G        123G
   Swap:          2.0G          0B        2.0G
   root@ubuntu:~# free -m
                 total        used        free      shared  buff/cache   available
   Mem:         128665         810      108301           1       19554      126911
   Swap:          2047           0        2047
   root@ubuntu:~# free -b
                 total        used        free      shared  buff/cache   available
   Mem:    134915833856   849604608 113562103808     1134592 20504125440 133076762624
   Swap:    2147479552           0  2147479552
   root@ubuntu:~#

看到可用内存是125GB，和4个43GB内存条的128GB总容量存在差距。

数据对比
--------

计算机中的字节大小换算方式

==== ====== ======= ==========
GB   MB     KB      B
==== ====== ======= ==========
进制 1024   1024    1024
1    1024^1 1024^2  1024^3
1    2^10   2^20    2^30
1    1024   1048576 1073741824
==== ====== ======= ==========

物理内存大小：

::

   128G =128*2^30 B = 137438953472 B

可用实际大小：free 命令可以看到的，应用程序可使用内存为

::

                       134915833856 B ≈ 125G

两者相差

::

   137438953472 - 134915833856 = 2523119616 B = 2.34 GB

相差内存查阅资料提示：bios会占用一部分，
内核会预留一部分，需要进一步分析

内存速率
--------

4个内存条，都标识\ ``2400MT/s``\ 。
``MT/s``\ 指的是\ ``MegaTransfers per second``
，每秒万兆次传输。和时钟频率单位是两码事，
因为一个时钟周期内可能发生两次传输。
内存条的数据位宽是64bit，所以每个内存条的理论带宽是：

::

   2400M * 64bit = 153600 Mbit/s = 19200 MB/s = 18.75 GB/s

stream测出的内存带宽是\ ``11416.0 MB/s``\ ，是应用程序获得的可持续带宽,
和单条内存的理论贷款还是有差距，并且内存条可以组成多通道，应该可获得的带宽要大于单条内存的带宽

DDR带宽能力
=================

Intel Xeon 6148 1P:

::

   2666MHz * 64bit/s ÷ 8 * 6 * 0.9 ≈ 112.4 GB/s


Kunpeng 920 4826 1P:

::

   2933MHz * 64bit/s ÷ 8 * 8 * 0.9 ≈ 164.9 GB/s

.. note:: 0.9 是DDR控制器效率
