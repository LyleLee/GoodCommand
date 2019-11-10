*********************
stream
*********************

stream是内存性能评估的工业标准之一，工具现由弗吉尼亚计算机系维护。

官方指导： `教程 <https://www.cs.virginia.edu/stream/ref.html>`__

下载源码
--------

这里以C源码为例。

::

   wget https://www.cs.virginia.edu/stream/FTP/Code/stream.c

完整的项目代码，请访问
`链接 <https://www.cs.virginia.edu/stream/FTP/Code/>`__ ## 编译

::

   gcc -O2 -mcmodel=large -fopenmp -DSTREAM_ARRAY_SIZE=10000000 -DNTIMES=30 -DOFFSET=4096 stream.c -o stream

   -mcmodel=large 大内存服务器使用参数
   -DSTREAM_ARRAY_SIZE=10000000 根据L3 cache的大小选择数组元素，使数组的占用的内存大小超过L3 cache的大小
   -DNTIMES=30 执行测试的次数，选择最好的依次打印
   -DOFFSET=4096 有可能改变数组再内存中的对齐方式

执行
----

::

   ./stream

1616服务器
----------

.. code:: shell-session

   me@ubuntu:~/code/stream$ ./stream
   -------------------------------------------------------------
   STREAM version $Revision: 5.10 $
   -------------------------------------------------------------
   This system uses 8 bytes per array element.
   -------------------------------------------------------------
   Array size = 100000000 (elements), Offset = 4096 (elements)
   Memory per array = 762.9 MiB (= 0.7 GiB).
   Total memory required = 2288.8 MiB (= 2.2 GiB).
   Each kernel will be executed 30 times.
    The *best* time for each kernel (excluding the first iteration)
    will be used to compute the reported bandwidth.
   -------------------------------------------------------------
   Number of Threads requested = 64
   Number of Threads counted = 64
   -------------------------------------------------------------
   Your clock granularity/precision appears to be 1 microseconds.
   Each test below will take on the order of 37823 microseconds.
      (= 37823 clock ticks)
   Increase the size of the arrays if this shows that
   you are not getting at least 20 clock ticks per test.
   -------------------------------------------------------------
   WARNING -- The above is only a rough guideline.
   For best results, please be sure you know the
   precision of your system timer.
   -------------------------------------------------------------
   Function    Best Rate MB/s  Avg time     Min time     Max time
   Copy:           58415.5     0.033761     0.027390     0.073813
   Scale:          58925.3     0.031476     0.027153     0.074888
   Add:            56900.2     0.047931     0.042179     0.076715
   Triad:          57035.6     0.049256     0.042079     0.089866
   -------------------------------------------------------------
   Solution Validates: avg error less than 1.000000e-13 on all three arrays
   -------------------------------------------------------------

.. _服务器-1:

1620服务器
----------

.. code:: shell-session

   [me@centos stream]$ ./stream
   -------------------------------------------------------------
   STREAM version $Revision: 5.10 $
   -------------------------------------------------------------
   This system uses 8 bytes per array element.
   -------------------------------------------------------------
   Array size = 10000000 (elements), Offset = 4096 (elements)
   Memory per array = 76.3 MiB (= 0.1 GiB).
   Total memory required = 228.9 MiB (= 0.2 GiB).
   Each kernel will be executed 30 times.
    The *best* time for each kernel (excluding the first iteration)
    will be used to compute the reported bandwidth.
   -------------------------------------------------------------
   Number of Threads requested = 128
   Number of Threads counted = 128
   -------------------------------------------------------------
   Your clock granularity/precision appears to be 1 microseconds.
   Each test below will take on the order of 3460 microseconds.
      (= 3460 clock ticks)
   Increase the size of the arrays if this shows that
   you are not getting at least 20 clock ticks per test.
   -------------------------------------------------------------
   WARNING -- The above is only a rough guideline.
   For best results, please be sure you know the
   precision of your system timer.
   -------------------------------------------------------------
   Function    Best Rate MB/s  Avg time     Min time     Max time
   Copy:          103292.1     0.002324     0.001549     0.004953
   Scale:          89145.7     0.002493     0.001795     0.004599
   Add:           101608.3     0.003173     0.002362     0.004439
   Triad:         105318.4     0.003154     0.002279     0.005893
   -------------------------------------------------------------
   Solution Validates: avg error less than 1.000000e-13 on all three arrays
   -------------------------------------------------------------

ARM树莓派执行结果
-----------------

树莓派总内存大小为1GB，内存频率没有标明

.. code:: shell-session

   pi@raspberrypi:~/app/stream $ ./stream
   -------------------------------------------------------------
   STREAM version $Revision: 5.10 $
   -------------------------------------------------------------
   This system uses 8 bytes per array element.
   -------------------------------------------------------------
   Array size = 10000000 (elements), Offset = 0 (elements)
   Memory per array = 76.3 MiB (= 0.1 GiB).
   Total memory required = 228.9 MiB (= 0.2 GiB).
   Each kernel will be executed 10 times.
    The *best* time for each kernel (excluding the first iteration)
    will be used to compute the reported bandwidth.
   -------------------------------------------------------------
   Your clock granularity/precision appears to be 1 microseconds.
   Each test below will take on the order of 114310 microseconds.
      (= 114310 clock ticks)
   Increase the size of the arrays if this shows that
   you are not getting at least 20 clock ticks per test.
   -------------------------------------------------------------
   WARNING -- The above is only a rough guideline.
   For best results, please be sure you know the
   precision of your system timer.
   -------------------------------------------------------------
   Function    Best Rate MB/s  Avg time     Min time     Max time
   Copy:            2030.0     0.079971     0.078817     0.083276
   Scale:           2030.5     0.080576     0.078797     0.084133
   Add:             1912.1     0.126776     0.125519     0.129104
   Triad:           1652.5     0.145481     0.145232     0.145794
   -------------------------------------------------------------
   Solution Validates: avg error less than 1.000000e-13 on all three arrays
   -------------------------------------------------------------

x86 PC执行结果
--------------

::

   root@SZX:~/working/stream# ./stream
   -------------------------------------------------------------
   STREAM version $Revision: 5.10 $
   -------------------------------------------------------------
   This system uses 8 bytes per array element.
   -------------------------------------------------------------
   Array size = 10000000 (elements), Offset = 0 (elements)
   Memory per array = 76.3 MiB (= 0.1 GiB).
   Total memory required = 228.9 MiB (= 0.2 GiB).
   Each kernel will be executed 10 times.
    The *best* time for each kernel (excluding the first iteration)
    will be used to compute the reported bandwidth.
   -------------------------------------------------------------
   Your clock granularity/precision appears to be 1 microseconds.
   Each test below will take on the order of 14092 microseconds.
      (= 14092 clock ticks)
   Increase the size of the arrays if this shows that
   you are not getting at least 20 clock ticks per test.
   -------------------------------------------------------------
   WARNING -- The above is only a rough guideline.
   For best results, please be sure you know the
   precision of your system timer.
   -------------------------------------------------------------
   Function    Best Rate MB/s  Avg time     Min time     Max time
   Copy:            7528.7     0.024472     0.021252     0.027480
   Scale:           7773.3     0.024656     0.020583     0.028275
   Add:             7866.3     0.034299     0.030510     0.036829
   Triad:           8017.6     0.035185     0.029934     0.038185
   -------------------------------------------------------------
   Solution Validates: avg error less than 1.000000e-13 on all three arrays
   -------------------------------------------------------------
   root@SZX:~/working/stream# 

x86 服务器执行结果
------------------

::

   me@Board:~/stream$ ./stream
   -------------------------------------------------------------
   STREAM version $Revision: 5.10 $
   -------------------------------------------------------------
   This system uses 8 bytes per array element.
   -------------------------------------------------------------
   Array size = 10000000 (elements), Offset = 0 (elements)
   Memory per array = 76.3 MiB (= 0.1 GiB).
   Total memory required = 228.9 MiB (= 0.2 GiB).
   Each kernel will be executed 10 times.
    The *best* time for each kernel (excluding the first iteration)
    will be used to compute the reported bandwidth.
   -------------------------------------------------------------
   Your clock granularity/precision appears to be 1 microseconds.
   Each test below will take on the order of 26998 microseconds.
      (= 26998 clock ticks)
   Increase the size of the arrays if this shows that
   you are not getting at least 20 clock ticks per test.
   -------------------------------------------------------------
   WARNING -- The above is only a rough guideline.
   For best results, please be sure you know the
   precision of your system timer.
   -------------------------------------------------------------
   Function    Best Rate MB/s  Avg time     Min time     Max time
   Copy:            8830.0     0.018140     0.018120     0.018157
   Scale:           8800.5     0.018211     0.018181     0.018317
   Add:             9812.8     0.024520     0.024458     0.024679
   Triad:           9722.5     0.024715     0.024685     0.024746
   -------------------------------------------------------------
   Solution Validates: avg error less than 1.000000e-13 on all three arrays
   -------------------------------------------------------------
   me@Board:~/stream$ lscpu

结果分析
--------

1616内存硬件信息：

::

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
   Maximum Voltage: 1.2 V
   Configured Voltage: 1.2 V

   数量：4

1620内存硬件信息：

::

   Array Handle: 0x0006
   Error Information Handle: Not Provided
   Total Width: 72 bits
   Data Width: 64 bits
   Size: 32 GB
   Form Factor: DIMM
   Set: None
   Locator: DIMM170 J31
   Bank Locator: SOCKET 1 CHANNEL 7 DIMM 0
   Type: DDR4
   Type Detail: Synchronous Registered (Buffered)
   Speed: 2666 MT/s
   Manufacturer: Samsung
   Serial Number: 0x40C3BA1D
   Asset Tag: 1838
   Part Number: M393A4K40BB2-CTD
   Rank: 2
   Configured Clock Speed: 2666 MT/s
   Minimum Voltage: 1.2 V
   Maximum Voltage: 2.0 V
   Configured Voltage: 1.2 V

   数量：16

计算公式：

::

   speed * data size /8 * DIMM number / 1024 /1024 = bandwidth

====== =============================== ============
服务器 理论带宽                        stream测试值
====== =============================== ============
1616   2400*64/8*4/1024/1024=75GiB/s   55GiB/s
1620   2666*64/8*16/1024/1024=333GiB/s 102GiB/s
====== =============================== ============

问题记录：静态数组内存大小限制
------------------------------

当设置的数组大小比较大时，编译器会给出报警。

::

   [root@localhost stream]# gcc -DSTREAM_ARRAY_SIZE=100000000  stream.c -o option_no_100M_stream
   /tmp/ccTzV1dQ.o: In function `main':
   stream.c:(.text+0x546): relocation truncated to fit: R_X86_64_32S against `.bss'
   stream.c:(.text+0x57a): relocation truncated to fit: R_X86_64_32S against `.bss'
   stream.c:(.text+0x5f9): relocation truncated to fit: R_X86_64_32S against `.bss'
   stream.c:(.text+0x62e): relocation truncated to fit: R_X86_64_32S against `.bss'
   stream.c:(.text+0x65e): relocation truncated to fit: R_X86_64_32S against `.bss'
   stream.c:(.text+0x6a0): relocation truncated to fit: R_X86_64_32S against `.bss'
   stream.c:(.text+0x6b9): relocation truncated to fit: R_X86_64_32S against `.bss'
   stream.c:(.text+0x6c5): relocation truncated to fit: R_X86_64_32S against `.bss'
   stream.c:(.text+0x6dd): relocation truncated to fit: R_X86_64_32S against `.bss'
   collect2: error: ld returned 1 exit status
   [root@localhost stream]#

解决办法是添加编译选项

::

   -mcmodel=medium
