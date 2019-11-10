====================
stream run on x86
====================

1. 查询\ `GNU
   compiler <https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html>`__
   得知 ``-O``\ 和\ ``-O1``\ 优化级别相同。stream测试结果也相同。
2. ``-O``\ 和\ ``-O1``\ 测试结果较好，stream官方例子带\ ``-o``
3. 不指定编译优化选项，或者指定编译优化选项为\ ``-O0``\ 时，测试结果最差
4. stream官方要求数组大小使每个数组大于cache的4倍。数组大小满足这个需求之后，增大数组，cache-misses增加，但是性能测试结果不变

硬件信息
--------

cpu E5-2697A v4 @ 2.60GHz 64核 L3 cache 40MB

::

   [root@localhost ~]# lscpu
   Architecture:          x86_64
   CPU op-mode(s):        32-bit, 64-bit
   Byte Order:            Little Endian
   CPU(s):                64
   On-line CPU(s) list:   0-63
   Thread(s) per core:    2
   Core(s) per socket:    16
   Socket(s):             2
   NUMA node(s):          2
   Vendor ID:             GenuineIntel
   CPU family:            6
   Model:                 79
   Model name:            Intel(R) Xeon(R) CPU E5-2697A v4 @ 2.60GHz
   Stepping:              1
   CPU MHz:               1199.196
   CPU max MHz:           3600.0000
   CPU min MHz:           1200.0000
   BogoMIPS:              5188.11
   Virtualization:        VT-x
   L1d cache:             32K
   L1i cache:             32K
   L2 cache:              256K
   L3 cache:              40960K
   NUMA node0 CPU(s):     0-15,32-47
   NUMA node1 CPU(s):     16-31,48-63
   Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 invpcid_single pti intel_ppin tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm cqm rdt_a rdseed adx smap intel_pt xsaveopt cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts

内存

32G*16条 = 512G内存 频率2133MT/s

::

   Handle 0x0017, DMI type 17, 40 bytes
   Memory Device
           Array Handle: 0x0000
           Error Information Handle: Not Provided
           Total Width: 72 bits
           Data Width: 64 bits
           Size: 32 GB
           Form Factor: DIMM
           Set: None
           Locator: DIMM130
           Bank Locator: _Node1_Channel3_Dimm0
           Type: DRAM
           Type Detail: Synchronous Registered (Buffered)
           Speed: 2133 MT/s
           Manufacturer: Hynix
           Serial Number: 0x116E4F85
           Asset Tag: NO DIMM
           Part Number: HMA84GR7MFR4N-TF
           Rank: 2
           Configured Clock Speed: 2133 MT/s
           Minimum Voltage: 1.2 V
           Maximum Voltage: 1.2 V
           Configured Voltage: 1.2 V


   [root@localhost ~]# free -h
                 total        used        free      shared  buff/cache   available
   Mem:           503G        926M        499G         26M        2.8G        499G
   Swap:          4.0G          0B        4.0G

软件信息
--------

OS centos 7
~~~~~~~~~~~

::

   [root@localhost ~]# cat /etc/os-release
   NAME="CentOS Linux"
   VERSION="7 (Core)"
   ID="centos"
   ID_LIKE="rhel fedora"
   VERSION_ID="7"
   PRETTY_NAME="CentOS Linux 7 (Core)"
   ANSI_COLOR="0;31"
   CPE_NAME="cpe:/o:centos:centos:7"
   HOME_URL="https://www.centos.org/"
   BUG_REPORT_URL="https://bugs.centos.org/"

   CENTOS_MANTISBT_PROJECT="CentOS-7"
   CENTOS_MANTISBT_PROJECT_VERSION="7"
   REDHAT_SUPPORT_PRODUCT="centos"
   REDHAT_SUPPORT_PRODUCT_VERSION="7"

stream 5.10
~~~~~~~~~~~

.. code:: c

   /* Program: STREAM                                                       */
   /* Revision: $Id: stream.c,v 5.10 2013/01/17 16:01:06 mccalpin Exp mccalpin $ */
   /* 

perf 3.10.0
~~~~~~~~~~~

::

   Installed Packages
   Name        : perf
   Arch        : x86_64
   Version     : 3.10.0
   Release     : 957.5.1.el7
   Size        : 5.4 M
   Repo        : installed
   From repo   : updates
   Summary     : Performance monitoring for the Linux kernel
   URL         : http://www.kernel.org/
   License     : GPLv2
   Description : This package contains the perf tool, which enables performance monitoring
               : of the Linux kernel.

gcc 4.8.5
~~~~~~~~~

::

   [root@localhost stream]# gcc -v
   Using built-in specs.
   COLLECT_GCC=gcc
   COLLECT_LTO_WRAPPER=/usr/libexec/gcc/x86_64-redhat-linux/4.8.5/lto-wrapper
   Target: x86_64-redhat-linux
   Configured with: ../configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --with-bugurl=http://bugzilla.redhat.com/bugzilla --enable-bootstrap --enable-shared --enable-threads=posix --enable-checking=release --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-gnu-unique-object --enable-linker-build-id --with-linker-hash-style=gnu --enable-languages=c,c++,objc,obj-c++,java,fortran,ada,go,lto --enable-plugin --enable-initfini-array --disable-libgcj --with-isl=/builddir/build/BUILD/gcc-4.8.5-20150702/obj-x86_64-redhat-linux/isl-install --with-cloog=/builddir/build/BUILD/gcc-4.8.5-20150702/obj-x86_64-redhat-linux/cloog-install --enable-gnu-indirect-function --with-tune=generic --with-arch_32=x86-64 --build=x86_64-redhat-linux
   Thread model: posix
   gcc version 4.8.5 20150623 (Red Hat 4.8.5-36) (GCC)

执行结果
--------

数组10000000，选项无
--------------------

::

   [root@localhost stream]# gcc stream.c -o stream 
   [root@localhost stream]# perf stat -e cache-misses ./stream
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
   Each test below will take on the order of 27683 microseconds.
      (= 27683 clock ticks)
   Increase the size of the arrays if this shows that
   you are not getting at least 20 clock ticks per test.
   -------------------------------------------------------------
   WARNING -- The above is only a rough guideline.
   For best results, please be sure you know the
   precision of your system timer.
   -------------------------------------------------------------
   Function    Best Rate MB/s  Avg time     Min time     Max time
   Copy:            6063.6     0.026436     0.026387     0.026485
   Scale:           5873.7     0.027301     0.027240     0.027391
   Add:             8484.2     0.028379     0.028288     0.028467
   Triad:           7965.8     0.030200     0.030129     0.030277
   -------------------------------------------------------------
   Solution Validates: avg error less than 1.000000e-13 on all three arrays
   -------------------------------------------------------------

    Performance counter stats for './stream':

          111,963,498      cache-misses

          1.291149781 seconds time elapsed

数组20000000，选项无
--------------------

::

   gcc -DSTREAM_ARRAY_SIZE=20000000 stream.c -o stream

为了让数组大小大于L3cache的4倍,应该设置20000000个数组元素

::

   200000000*8/1024/1024 = 152 MB

::

   [root@localhost stream]# perf stat -e cache-misses ./stream
   -------------------------------------------------------------
   STREAM version $Revision: 5.10 $
   -------------------------------------------------------------
   This system uses 8 bytes per array element.
   -------------------------------------------------------------
   Array size = 20000000 (elements), Offset = 0 (elements)
   Memory per array = 152.6 MiB (= 0.1 GiB).
   Total memory required = 457.8 MiB (= 0.4 GiB).
   Each kernel will be executed 10 times.
    The *best* time for each kernel (excluding the first iteration)
    will be used to compute the reported bandwidth.
   -------------------------------------------------------------
   Your clock granularity/precision appears to be 1 microseconds.
   Each test below will take on the order of 50360 microseconds.
      (= 50360 clock ticks)
   Increase the size of the arrays if this shows that
   you are not getting at least 20 clock ticks per test.
   -------------------------------------------------------------
   WARNING -- The above is only a rough guideline.
   For best results, please be sure you know the
   precision of your system timer.
   -------------------------------------------------------------
   Function    Best Rate MB/s  Avg time     Min time     Max time
   Copy:            5960.6     0.053784     0.053686     0.054260
   Scale:           5867.8     0.054635     0.054535     0.055155
   Add:             8444.3     0.056898     0.056843     0.056956
   Triad:           7965.9     0.060358     0.060257     0.060863
   -------------------------------------------------------------
   Solution Validates: avg error less than 1.000000e-13 on all three arrays
   -------------------------------------------------------------

    Performance counter stats for './stream':

          212,489,174      cache-misses

          2.579120788 seconds time elapsed

   [root@localhost stream]#

结果相差不多，默认数组大小在x86上执行结果正确。

数组20000000，选项-O1
---------------------

指导文档使用-O，经查，等于-O1

::

   gcc -O -DSTREAM_ARRAY_SIZE=20000000 stream.c -o stream

::

   [root@localhost stream]# gcc -O -DSTREAM_ARRAY_SIZE=20000000 stream.c -o stream
   [root@localhost stream]# perf stat -e cache-misses ./stream
   -------------------------------------------------------------
   STREAM version $Revision: 5.10 $
   -------------------------------------------------------------
   This system uses 8 bytes per array element.
   -------------------------------------------------------------
   Array size = 20000000 (elements), Offset = 0 (elements)
   Memory per array = 152.6 MiB (= 0.1 GiB).
   Total memory required = 457.8 MiB (= 0.4 GiB).
   Each kernel will be executed 10 times.
    The *best* time for each kernel (excluding the first iteration)
    will be used to compute the reported bandwidth.
   -------------------------------------------------------------
   Your clock granularity/precision appears to be 1 microseconds.
   Each test below will take on the order of 18355 microseconds.
      (= 18355 clock ticks)
   Increase the size of the arrays if this shows that
   you are not getting at least 20 clock ticks per test.
   -------------------------------------------------------------
   WARNING -- The above is only a rough guideline.
   For best results, please be sure you know the
   precision of your system timer.
   -------------------------------------------------------------
   Function    Best Rate MB/s  Avg time     Min time     Max time
   Copy:           10046.5     0.031868     0.031852     0.031885
   Scale:          10236.7     0.031280     0.031260     0.031298
   Add:            10847.5     0.044293     0.044250     0.044328
   Triad:          11011.7     0.043612     0.043590     0.043641
   -------------------------------------------------------------
   Solution Validates: avg error less than 1.000000e-13 on all three arrays
   -------------------------------------------------------------

    Performance counter stats for './stream':

          163,072,098      cache-misses

          1.749581755 seconds time elapsed

   [root@localhost stream]#

.. _数组20000000选项-o1-1:

数组20000000，选项-O1
---------------------

::

   [root@localhost stream]# gcc -O1 -DSTREAM_ARRAY_SIZE=20000000 stream.c -o stream
   [root@localhost stream]# perf stat -e cache-misses ./stream
   -------------------------------------------------------------
   STREAM version $Revision: 5.10 $
   -------------------------------------------------------------
   This system uses 8 bytes per array element.
   -------------------------------------------------------------
   Array size = 20000000 (elements), Offset = 0 (elements)
   Memory per array = 152.6 MiB (= 0.1 GiB).
   Total memory required = 457.8 MiB (= 0.4 GiB).
   Each kernel will be executed 10 times.
    The *best* time for each kernel (excluding the first iteration)
    will be used to compute the reported bandwidth.
   -------------------------------------------------------------
   Your clock granularity/precision appears to be 1 microseconds.
   Each test below will take on the order of 18549 microseconds.
      (= 18549 clock ticks)
   Increase the size of the arrays if this shows that
   you are not getting at least 20 clock ticks per test.
   -------------------------------------------------------------
   WARNING -- The above is only a rough guideline.
   For best results, please be sure you know the
   precision of your system timer.
   -------------------------------------------------------------
   Function    Best Rate MB/s  Avg time     Min time     Max time
   Copy:           10058.8     0.031857     0.031813     0.031907
   Scale:          10222.4     0.031368     0.031304     0.031422
   Add:            10832.0     0.044360     0.044313     0.044405
   Triad:          10977.7     0.043773     0.043725     0.043835
   -------------------------------------------------------------
   Solution Validates: avg error less than 1.000000e-13 on all three arrays
   -------------------------------------------------------------

    Performance counter stats for './stream':

          162,980,110      cache-misses

          1.757360340 seconds time elapsed

   [root@localhost stream]#

数组20000000，选项-O2
---------------------

::

   [root@localhost stream]# gcc -O2 -DSTREAM_ARRAY_SIZE=20000000 stream.c -o stream
   [root@localhost stream]# perf stat -e cache-misses ./stream
   -------------------------------------------------------------
   STREAM version $Revision: 5.10 $
   -------------------------------------------------------------
   This system uses 8 bytes per array element.
   -------------------------------------------------------------
   Array size = 20000000 (elements), Offset = 0 (elements)
   Memory per array = 152.6 MiB (= 0.1 GiB).
   Total memory required = 457.8 MiB (= 0.4 GiB).
   Each kernel will be executed 10 times.
    The *best* time for each kernel (excluding the first iteration)
    will be used to compute the reported bandwidth.
   -------------------------------------------------------------
   Your clock granularity/precision appears to be 1 microseconds.
   Each test below will take on the order of 18338 microseconds.
      (= 18338 clock ticks)
   Increase the size of the arrays if this shows that
   you are not getting at least 20 clock ticks per test.
   -------------------------------------------------------------
   WARNING -- The above is only a rough guideline.
   For best results, please be sure you know the
   precision of your system timer.
   -------------------------------------------------------------
   Function    Best Rate MB/s  Avg time     Min time     Max time
   Copy:           10048.3     0.031864     0.031846     0.031882
   Scale:          10144.9     0.031571     0.031543     0.031592
   Add:            10861.4     0.044214     0.044193     0.044234
   Triad:          10896.2     0.044092     0.044052     0.044117
   -------------------------------------------------------------
   Solution Validates: avg error less than 1.000000e-13 on all three arrays
   -------------------------------------------------------------

    Performance counter stats for './stream':

          163,743,497      cache-misses

          1.761638820 seconds time elapsed

数组20000000，选项-O3
---------------------

::

   [root@localhost stream]# gcc -O3 -DSTREAM_ARRAY_SIZE=20000000 stream.c -o stream
   [root@localhost stream]# perf stat -e cache-misses ./stream
   -------------------------------------------------------------
   STREAM version $Revision: 5.10 $
   -------------------------------------------------------------
   This system uses 8 bytes per array element.
   -------------------------------------------------------------
   Array size = 20000000 (elements), Offset = 0 (elements)
   Memory per array = 152.6 MiB (= 0.1 GiB).
   Total memory required = 457.8 MiB (= 0.4 GiB).
   Each kernel will be executed 10 times.
    The *best* time for each kernel (excluding the first iteration)
    will be used to compute the reported bandwidth.
   -------------------------------------------------------------
   Your clock granularity/precision appears to be 1 microseconds.
   Each test below will take on the order of 18628 microseconds.
      (= 18628 clock ticks)
   Increase the size of the arrays if this shows that
   you are not getting at least 20 clock ticks per test.
   -------------------------------------------------------------
   WARNING -- The above is only a rough guideline.
   For best results, please be sure you know the
   precision of your system timer.
   -------------------------------------------------------------
   Function    Best Rate MB/s  Avg time     Min time     Max time
   Copy:           16874.0     0.018975     0.018964     0.018988
   Scale:           9966.6     0.032122     0.032107     0.032143
   Add:            10795.3     0.044488     0.044464     0.044501
   Triad:          10761.4     0.044620     0.044604     0.044649
   -------------------------------------------------------------
   Solution Validates: avg error less than 1.000000e-13 on all three arrays
   -------------------------------------------------------------

    Performance counter stats for './stream':

          155,187,006      cache-misses

          1.653922727 seconds time elapsed

   [root@localhost stream]#

数组20000000，选项-O0
---------------------

::

   [root@localhost stream]# perf stat -e cache-misses ./stream
   -------------------------------------------------------------
   STREAM version $Revision: 5.10 $
   -------------------------------------------------------------
   This system uses 8 bytes per array element.
   -------------------------------------------------------------
   Array size = 20000000 (elements), Offset = 0 (elements)
   Memory per array = 152.6 MiB (= 0.1 GiB).
   Total memory required = 457.8 MiB (= 0.4 GiB).
   Each kernel will be executed 10 times.
    The *best* time for each kernel (excluding the first iteration)
    will be used to compute the reported bandwidth.
   -------------------------------------------------------------
   Your clock granularity/precision appears to be 1 microseconds.
   Each test below will take on the order of 50331 microseconds.
      (= 50331 clock ticks)
   Increase the size of the arrays if this shows that
   you are not getting at least 20 clock ticks per test.
   -------------------------------------------------------------
   WARNING -- The above is only a rough guideline.
   For best results, please be sure you know the
   precision of your system timer.
   -------------------------------------------------------------
   Function    Best Rate MB/s  Avg time     Min time     Max time
   Copy:            5956.9     0.053873     0.053719     0.054393
   Scale:           5870.6     0.054687     0.054509     0.055268
   Add:             8448.0     0.056944     0.056818     0.057079
   Triad:           7960.3     0.060478     0.060299     0.061003
   -------------------------------------------------------------
   Solution Validates: avg error less than 1.000000e-13 on all three arrays
   -------------------------------------------------------------

    Performance counter stats for './stream':

          212,044,019      cache-misses

          2.581445722 seconds time elapsed

   [root@localhost stream]#

数组30000000，选项-O
--------------------

::

   [root@localhost stream]# gcc -O -DSTREAM_ARRAY_SIZE=30000000 stream.c -o stream
   [root@localhost stream]# perf stat -e cache-misses ./stream
   -------------------------------------------------------------
   STREAM version $Revision: 5.10 $
   -------------------------------------------------------------
   This system uses 8 bytes per array element.
   -------------------------------------------------------------
   Array size = 30000000 (elements), Offset = 0 (elements)
   Memory per array = 228.9 MiB (= 0.2 GiB).
   Total memory required = 686.6 MiB (= 0.7 GiB).
   Each kernel will be executed 10 times.
    The *best* time for each kernel (excluding the first iteration)
    will be used to compute the reported bandwidth.
   -------------------------------------------------------------
   Your clock granularity/precision appears to be 1 microseconds.
   Each test below will take on the order of 26309 microseconds.
      (= 26309 clock ticks)
   Increase the size of the arrays if this shows that
   you are not getting at least 20 clock ticks per test.
   -------------------------------------------------------------
   WARNING -- The above is only a rough guideline.
   For best results, please be sure you know the
   precision of your system timer.
   -------------------------------------------------------------
   Function    Best Rate MB/s  Avg time     Min time     Max time
   Copy:           10593.9     0.045330     0.045309     0.045347
   Scale:          10608.0     0.045292     0.045249     0.045328
   Add:            11352.4     0.063469     0.063423     0.063617
   Triad:          11288.3     0.063819     0.063783     0.063925
   -------------------------------------------------------------
   Solution Validates: avg error less than 1.000000e-13 on all three arrays
   -------------------------------------------------------------

    Performance counter stats for './stream':

          249,967,744      cache-misses

          2.531537686 seconds time elapsed

数组40000000，选项-O
--------------------

::

   [root@localhost stream]# gcc -O -DSTREAM_ARRAY_SIZE=40000000 stream.c -o stream
   [root@localhost stream]# perf stat -e cache-misses ./stream
   -------------------------------------------------------------
   STREAM version $Revision: 5.10 $
   -------------------------------------------------------------
   This system uses 8 bytes per array element.
   -------------------------------------------------------------
   Array size = 40000000 (elements), Offset = 0 (elements)
   Memory per array = 305.2 MiB (= 0.3 GiB).
   Total memory required = 915.5 MiB (= 0.9 GiB).
   Each kernel will be executed 10 times.
    The *best* time for each kernel (excluding the first iteration)
    will be used to compute the reported bandwidth.
   -------------------------------------------------------------
   Your clock granularity/precision appears to be 1 microseconds.
   Each test below will take on the order of 35411 microseconds.
      (= 35411 clock ticks)
   Increase the size of the arrays if this shows that
   you are not getting at least 20 clock ticks per test.
   -------------------------------------------------------------
   WARNING -- The above is only a rough guideline.
   For best results, please be sure you know the
   precision of your system timer.
   -------------------------------------------------------------
   Function    Best Rate MB/s  Avg time     Min time     Max time
   Copy:           10221.9     0.062669     0.062611     0.062891
   Scale:          10435.7     0.061434     0.061328     0.061619
   Add:            10980.6     0.087577     0.087427     0.087796
   Triad:          11013.6     0.087207     0.087165     0.087377
   -------------------------------------------------------------
   Solution Validates: avg error less than 1.000000e-13 on all three arrays
   -------------------------------------------------------------

    Performance counter stats for './stream':

          334,073,899      cache-misses

          3.469917205 seconds time elapsed

数组50000000，选项-O
--------------------

::

   [root@localhost stream]# gcc -O -DSTREAM_ARRAY_SIZE=50000000 stream.c -o stream
   [root@localhost stream]# perf stat -e cache-misses ./stream
   -------------------------------------------------------------
   STREAM version $Revision: 5.10 $
   -------------------------------------------------------------
   This system uses 8 bytes per array element.
   -------------------------------------------------------------
   Array size = 50000000 (elements), Offset = 0 (elements)
   Memory per array = 381.5 MiB (= 0.4 GiB).
   Total memory required = 1144.4 MiB (= 1.1 GiB).
   Each kernel will be executed 10 times.
    The *best* time for each kernel (excluding the first iteration)
    will be used to compute the reported bandwidth.
   -------------------------------------------------------------
   Your clock granularity/precision appears to be 1 microseconds.
   Each test below will take on the order of 44100 microseconds.
      (= 44100 clock ticks)
   Increase the size of the arrays if this shows that
   you are not getting at least 20 clock ticks per test.
   -------------------------------------------------------------
   WARNING -- The above is only a rough guideline.
   For best results, please be sure you know the
   precision of your system timer.
   -------------------------------------------------------------
   Function    Best Rate MB/s  Avg time     Min time     Max time
   Copy:           10957.6     0.073081     0.073009     0.073334
   Scale:          10329.6     0.077563     0.077447     0.077736
   Add:            11045.7     0.108870     0.108640     0.109140
   Triad:          11196.7     0.107286     0.107175     0.107587
   -------------------------------------------------------------
   Solution Validates: avg error less than 1.000000e-13 on all three arrays
   -------------------------------------------------------------

    Performance counter stats for './stream':

          426,955,169      cache-misses

          4.245849035 seconds time elapsed

数组60000000，选项-O
--------------------

::

   [root@localhost stream]# gcc -O -DSTREAM_ARRAY_SIZE=60000000 stream.c -o stream
   [root@localhost stream]# perf stat -e cache-misses ./stream
   -------------------------------------------------------------
   STREAM version $Revision: 5.10 $
   -------------------------------------------------------------
   This system uses 8 bytes per array element.
   -------------------------------------------------------------
   Array size = 60000000 (elements), Offset = 0 (elements)
   Memory per array = 457.8 MiB (= 0.4 GiB).
   Total memory required = 1373.3 MiB (= 1.3 GiB).
   Each kernel will be executed 10 times.
    The *best* time for each kernel (excluding the first iteration)
    will be used to compute the reported bandwidth.
   -------------------------------------------------------------
   Your clock granularity/precision appears to be 1 microseconds.
   Each test below will take on the order of 52796 microseconds.
      (= 52796 clock ticks)
   Increase the size of the arrays if this shows that
   you are not getting at least 20 clock ticks per test.
   -------------------------------------------------------------
   WARNING -- The above is only a rough guideline.
   For best results, please be sure you know the
   precision of your system timer.
   -------------------------------------------------------------
   Function    Best Rate MB/s  Avg time     Min time     Max time
   Copy:           10130.0     0.094858     0.094768     0.095173
   Scale:          10631.8     0.090408     0.090295     0.090570
   Add:            11216.3     0.128531     0.128385     0.128746
   Triad:          11289.0     0.127709     0.127558     0.127884
   -------------------------------------------------------------
   Solution Validates: avg error less than 1.000000e-13 on all three arrays
   -------------------------------------------------------------

    Performance counter stats for './stream':

          495,551,653      cache-misses

          5.104867523 seconds time elapsed

   [root@localhost stream]#

