fio 测试硬盘性能
*******************

fio是多线程IO负载生成测试工具，是测试服务器硬盘性能的优秀工具。

参数
----

命令行参数：

.. code:: shell

   fio --ramp_time=5 --runtime=60 --size=100% --ioengine=libaio --filename=/dev/sdb --name=4k_read --numjobs=1 --iodepth=64 --rw=read --bs=4k --direct=1

配置文件参数：

.. code::

   ; -- start job file including.fio --
   [global]
   filename=/tmp/test
   filesize=1m
   include glob-include.fio

   [test]
   rw=randread
   bs=4k
   time_based=1
   runtime=10
   include test-include.fio
   ; -- end job file including.fio --

详细说明可以参考\ `[官方文档] <https://fio.readthedocs.io/en/latest/index.html>`__

配置文件参数可以转化成命令行的写法：

::

   fio configfile --showcmd

一些基础知识
------------

以下内容摘自
`系统技术非业余研究 <http://blog.yufeng.info/archives/2104>`__

随着块设备的发展，特别是SSD盘的出现，设备的并行度越来越高。利用好这些设备，有个诀窍就是提高设备的iodepth,
一把喂给设备更多的IO请求，让电梯算法和设备有机会来安排合并以及内部并行处理，提高总体效率。

应用使用IO通常有二种方式：同步和异步。
同步的IO一次只能发出一个IO请求，等待内核完成才返回，
这样对于单个线程iodepth总是小于1，但是可以透过多个线程并发执行来解决，通常我们会用16-32个线程同时工作把iodepth塞满。
异步的话就是用类似libaio这样的linux native
aio一次提交一批，然后等待一批的完成，减少交互的次数，会更有效率。

参数配置要求
------------

::

   bs          #块大小必须是扇区（512字节）
   ramp_time   #作用是减少日志对高速IO的影响
   direct      #使用direct，fsync就不会发生

查看硬盘支持的最大队列深度
--------------------------

lsscsi在redhat，centOS，ubuntu都支持 ，每个操作系统的设置都不一样

X86

::

   [root@localhost queue]# lsscsi -l
   [0:0:0:0]    enclosu 12G SAS  Expander         RevB  -
     state=running queue_depth=256 scsi_level=7 type=13 device_blocked=0 timeout=90
   [0:0:13:0]   disk    HUAWEI   HWE32SS3008M001N 2774  /dev/sda
     state=running queue_depth=64 scsi_level=7 type=0 device_blocked=0 timeout=90
   [0:2:0:0]    disk    AVAGO    AVAGO            4.65  /dev/sdb
     state=running queue_depth=256 scsi_level=6 type=0 device_blocked=0 timeout=90

ARM-ubuntu

::

   root@ubuntu:~/app/fio-fio-3.13# lsscsi -l
   [0:0:0:0]    disk    ATA      HUS726040ALA610  T7R4  /dev/sda
     state=running queue_depth=31 scsi_level=6 type=0 device_blocked=0 timeout=30
   [0:0:1:0]    disk    ATA      HUS726040ALA610  T7R4  /dev/sdb
     state=running queue_depth=31 scsi_level=6 type=0 device_blocked=0 timeout=30
   [0:0:2:0]    disk    HUAWEI   HWE32SS3008M001N 2774  /dev/sdc
     state=running queue_depth=64 scsi_level=7 type=0 device_blocked=0 timeout=30
   [0:0:3:0]    enclosu 12G SAS  Expander         RevB  -
     state=running queue_depth=64 scsi_level=7 type=13 device_blocked=0 timeout=0

redhat支持， centOS不支持

::

   cat /sys/block/sdb/device/queue_depth
   32

fio编译
-------

./configure 提示一些fio特性会依赖zlib

::

   yum install zlib-devel.aarch64

编译安装好之后，version还是不对，需要重新登录系统才会生效。

::

   [root@localhost fio-fio-3.13]# fio -v
   fio-3.7
   [root@localhost ~]# which fio
   /usr/local/bin/fio
   [root@localhost ~]# /usr/local/bin/fio -v
   fio-3.13
   [root@localhost ~]# 

::

   [root@localhost fio-fio-3.13]# make install
   install -m 755 -d /usr/local/bin
   install fio t/fio-genzipf t/fio-btrace2fio t/fio-dedupe t/fio-verify-state ./tools/fio_generate_plots ./tools/plot/fio2gnuplot ./tools/genfio ./tools/fiologparser.py ./tools/hist/fiologparser_hist.py ./tools/fio_jsonplus_clat2csv /usr/local/bin
   install -m 755 -d /usr/local/man/man1
   install -m 644 ./fio.1 /usr/local/man/man1
   install -m 644 ./tools/fio_generate_plots.1 /usr/local/man/man1
   install -m 644 ./tools/plot/fio2gnuplot.1 /usr/local/man/man1
   install -m 644 ./tools/hist/fiologparser_hist.py.1 /usr/local/man/man1
   install -m 755 -d /usr/local/share/fio
   install -m 644 ./tools/plot/*gpm /usr/local/share/fio/

fio 调优指导
------------

1.  测试硬盘direct读写时，请使用erase命令清除硬盘数据
2.  BIOS关闭CPU节能模式，选择performace.风扇全速。
3.  硬盘测试请如果有raid卡，请设置硬盘为JBOD模式
4.  关闭SMMU可以提升随机读和随机写，顺序写性能
5.  fio 指定–ioengine=libaio时，应当指定 –direct=1。
    这是避免使用主机页缓存的方法，写入输入会直接写入硬盘.
    这样的测试结果是最低的，但是也是最接近真实的。
    –direct=1对读测试的影响是，read操作不会因为内存大而结果变好
6.  开启硬盘多队列
    scsi_mod.use_blk_mq=y。内核启动时，按e，进入编辑，在linux启动先后添加
7.  设置NUMA亲和性。
    查看硬盘在哪个节点上，并使用–cpus_allowed或者taskset或者numctl手动亲核
8.  绑中断。 建议设备中断、fio在同一个NUMA节点上。
9.  IRQ
    balancing。查看/proc/interrupts，是否均衡，如果没有，/etc/ini.d/irq_balance
    stop手动设置
10. 拓展卡可能会影响4k测试性能，在需要测试的场景硬盘数量不多的情况下可以不使用拓展卡。
11. 硬盘测试请设置–size=100%
12. 硬盘测试时，256k， 512k和1M
    –filename=/dev/sdb单盘测试时，numjobs很大，带宽会上升，但是不准确（待核实）
13. 发现numberjob不起作用时添加–thread
14. –bs小于4k时，可以格式化硬盘sector
    size为512B。–bs>=4k时，格式化硬盘sector 为4KB可以获得更好性能。

第8条如下：

.. code::

   [global]
   ioengine=libaio
   direct=1
   iodepth=32
   rw=randread
   bs=4k
   thread
   numjobs=1
   runtime=100 
   group_reporting
   [/dev/sdc]

查考参数

4k randwrite Peak IOPS
^^^^^^^^^^^^^^^^^^^^^^

::

   [global]
   readwrite=randrw
   rwmixread=0
   blocksize=4k
   ioengine=libaio
   numjobs=4
   thread=0
   direct=1
   iodepth=128
   iodepth_batch=4
   iodepth_batch_complete=4
   group_reporting=1
   ramp_time=5
   norandommap=1
   description=fio random 4k write peak IOPS
   time_based=1
   runtime=30
   randrepeat=0
   [/dev/fioa]
   filename=/dev/fioa
   cpus_allowed=1-4

4k randread Peak IOPS
^^^^^^^^^^^^^^^^^^^^^

::

   [global]
   readwrite=randrw
   rwmixread=100
   blocksize=4k
   ioengine=libaio
   numjobs=4
   thread=0
   direct=1
   iodepth=128
   iodepth_batch=4
   iodepth_batch_complete=4
   group_reporting=1
   ramp_time=5
   norandommap=1
   description=fio random 4k read peak IOPS
   time_based=1
   runtime=30
   randrepeat=0
   [/dev/fioa]
   filename=/dev/fioa
   cpus_allowed=1-

1M randwrite Peak Bandwith
^^^^^^^^^^^^^^^^^^^^^^^^^^

::

   [global]
   readwrite=randrw
   rwmixread=0
   blocksize=1M
   ioengine=libaio
   numjobs=4
   thread=0
   direct=1
   iodepth=128
   iodepth_batch=4
   iodepth_batch_complete=4
   group_reporting=1
   ramp_time=5
   norandommap=1
   description=fio random 1M write peak BW
   time_based=1
   runtime=30
   randrepeat=0
   [/dev/fioa]
   filename=/dev/fioa
   cpus_allowed=1-4

1M write Peak Bandwith
^^^^^^^^^^^^^^^^^^^^^^

::

   [global]
   readwrite=write
   rwmixread=0
   blocksize=1M
   ioengine=libaio
   thread=0
   size=100%
   iodepth=16
   group_reporting=1
   description=fio PRECONDITION sequential 1M complete write
   21ioMemory VSL Peak Performance Guide
   [/dev/fioa]
   filename=/dev/fioa
   cpus_allowed=1-4

1M read Peak Bandwith
^^^^^^^^^^^^^^^^^^^^^

::

   [global]
   readwrite=randrw
   rwmixread=100
   blocksize=1M
   ioengine=libaio
   numjobs=4
   thread=0
   direct=1
   iodepth=128
   iodepth_batch=4
   iodepth_batch_complete=4
   group_reporting=1
   ramp_time=5
   norandommap=1
   description=fio random 1M read peak BW
   time_based=1
   runtime=30
   randrepeat=0
   [/dev/fioa]
   filename=/dev/fioa
   cpus_allowed=1-

编译安装fio以支持ceph rbd测试
-----------------------------

::

   [2019-07-20 20:59:26]  [root@192e168e100e111 ~]# unzip fio-3.15.zip 
   [2019-07-20 22:19:37]  [root@192e168e100e111 ~]# yum install librbd1-devel
   [2019-07-20 22:20:15]  [root@192e168e100e111 fio-fio-3.15]# ./configure 
   [2019-07-20 22:20:21]  Rados engine                  yes
   [2019-07-20 22:20:21]  Rados Block Device engine     yes # 有这几个代表安装librbd成功
   [2019-07-20 22:20:21]  rbd_poll                      yes
   [2019-07-20 22:20:21]  rbd_invalidate_cache          yes
   [2019-07-20 22:20:26]  [root@192e168e100e111 fio-fio-3.15]# make -j8

如果不先安装librbd，编译完之后执行会出现

::

   [2019-07-20 22:15:43]  fio: engine rbd not loadable
   [2019-07-20 22:15:43]  fio: engine rbd not loadable
   [2019-07-20 22:15:43]  fio: failed to load engine

除此之外，要想可以执行成功，就好是ceph节点上的/etc/ceph拷贝到当前的主机上。

参考文档
========

`【其他IO监控各工具】 <https://www.cnblogs.com/quixotic/p/3258730.html>`__

`【fio官方文档】 <https://fio.readthedocs.io/en/latest/fio_doc.html#command-line-options>`__

`【高性能指导】 <https://support.fusionio.com/load/-media-/2fk40u/docsConfluence/ioMemory_VSL_Peak_Performance_Guide_2013-08-20.pdf>`__

问题记录：
==========

问题1： ubuntu下缺少libaio库
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code:: console

   4k_read: No I/O performed by libaio, perhaps try --debug=io option for details?

解决办法

.. code:: console

   sudo apt-get install libaio-dev

问题2：如何限制带宽和IOPS
^^^^^^^^^^^^^^^^^^^^^^^^^

.. code:: console

   --rate 400k,300k

把读速率设置为400kB/s， 把写速率设置为300kB/s

问题3：编译安装后发现libaio无法加载
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

   [root@localhost fio_scripts]# perf record -ag -o fio_symbol.data fio --ramp_time=5 --runtime=60 --size=10g --ioengine=libaio --filename=/dev/sdb --name=4k_read --numjobs=1 --rw=read --bs=4k --direct=1
   fio: engine libaio not loadable
   fio: engine libaio not loadable
   fio: failed to load engine

查看当前系统支持的io引擎

::

   fio -enghelp

解决办法： 安装libaio

.. code:: console

   sudo apt-get install libaio-dev
