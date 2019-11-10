===========================
stream run on arm
===========================

1. 查询\ `GNU
   compiler <https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html>`__
   得知 ``-O``\ 和\ ``-O1``\ 优化级别相同。stream测试结果也相同。
2. ``-O``\ 和\ ``-O1``\ 测试结果较好；\ ``-O2``\ 和\ ``-O3``\ 可以使add
   和 Triad结果变好，但是整体结果可能变差。stream官方例子带\ ``-o``
3. 不指定编译优化选项，或者指定编译优化选项为\ ``-O0``\ 时，测试结果最差
4. stream官方要求数组大小使每个数组大于cache的4倍。数组大小满足这个需求之后，增大数组，cache-misses增加，但是性能测试结果不变

硬件信息
--------

CPU
~~~

::

   root@ubuntu:~# lscpu
   Architecture:        aarch64
   Byte Order:          Little Endian
   CPU(s):              64
   On-line CPU(s) list: 0-63
   Thread(s) per core:  1
   Core(s) per socket:  32
   Socket(s):           2
   NUMA node(s):        4
   Vendor ID:           ARM
   Model:               2
   Model name:          Cortex-A72
   Stepping:            r0p2
   BogoMIPS:            100.00
   L1d cache:           32K
   L1i cache:           48K
   L2 cache:            1024K
   L3 cache:            16384K
   NUMA node0 CPU(s):   0-15
   NUMA node1 CPU(s):   16-31
   NUMA node2 CPU(s):   32-47
   NUMA node3 CPU(s):   48-63
   Flags:               fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid

内存
~~~~

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
   Maximum Voltage: 1.2 V
   Configured Voltage: 1.2 V

   root@ubuntu:~# free -h
                 total        used        free      shared  buff/cache   available
   Mem:           125G        1.8G        123G         17M        786M        123G
   Swap:          2.0G          0B        2.0G

软件信息
--------

::

   root@ubuntu:~# cat/tec /etc/os-release 
   NAME="Ubuntu"
   VERSION="18.04.1 LTS (Bionic Beaver)"
   ID=ubuntu
   ID_LIKE=debian
   PRETTY_NAME="Ubuntu 18.04.1 LTS"
   VERSION_ID="18.04"
   HOME_URL="https://www.ubuntu.com/"
   SUPPORT_URL="https://help.ubuntu.com/"
   BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
   PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
   VERSION_CODENAME=bionic
   UBUNTU_CODENAME=bionic

perf
~~~~

::

   root@ubuntu:~# perf -v
   perf version 4.15.18
   root@ubuntu:~# dpkg -s linux-tools-common
   Package: linux-tools-common
   Status: install ok installed
   Priority: optional
   Section: kernel
   Installed-Size: 330
   Maintainer: Ubuntu Kernel Team <kernel-team@lists.ubuntu.com>
   Architecture: all
   Multi-Arch: foreign
   Source: linux
   Version: 4.15.0-46.49
   Depends: lsb-release
   Description: Linux kernel version specific tools for version 4.15.0
    This package provides the architecture independent parts for kernel
    version locked tools (such as perf and x86_energy_perf_policy) for
    version PGKVER.

gcc
~~~

::

   root@ubuntu:~# gcc -v
   Using built-in specs.
   COLLECT_GCC=gcc
   COLLECT_LTO_WRAPPER=/usr/lib/gcc/aarch64-linux-gnu/7/lto-wrapper
   Target: aarch64-linux-gnu
   Configured with: ../src/configure -v --with-pkgversion='Ubuntu/Linaro 7.3.0-27ubuntu1~18.04' --with-bugurl=file:///usr/share/doc/gcc-7/README.Bugs --enable-languages=c,ada,c++,go,d,fortran,objc,obj-c++ --prefix=/usr --with-gcc-major-version-only --program-suffix=-7 --program-prefix=aarch64-linux-gnu- --enable-shared --enable-linker-build-id --libexecdir=/usr/lib --without-included-gettext --enable-threads=posix --libdir=/usr/lib --enable-nls --with-sysroot=/ --enable-clocale=gnu --enable-libstdcxx-debug --enable-libstdcxx-time=yes --with-default-libstdcxx-abi=new --enable-gnu-unique-object --disable-libquadmath --disable-libquadmath-support --enable-plugin --enable-default-pie --with-system-zlib --enable-multiarch --enable-fix-cortex-a53-843419 --disable-werror --enable-checking=release --build=aarch64-linux-gnu --host=aarch64-linux-gnu --target=aarch64-linux-gnu
   Thread model: posix
   gcc version 7.3.0 (Ubuntu/Linaro 7.3.0-27ubuntu1~18.04) 

执行结果
--------

数组10000000，选项无
--------------------

::

   root@ubuntu:~/app/stream# gcc stream.c -o stream
   root@ubuntu:~/app/stream# perf stat -e cache-misses ./stream
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
   Your clock granularity/precision appears to be 2 microseconds.
   Each test below will take on the order of 62633 microseconds.
      (= 31316 clock ticks)
   Increase the size of the arrays if this shows that
   you are not getting at least 20 clock ticks per test.
   -------------------------------------------------------------
   WARNING -- The above is only a rough guideline.
   For best results, please be sure you know the
   precision of your system timer.
   -------------------------------------------------------------
   Function    Best Rate MB/s  Avg time     Min time     Max time
   Copy:            2549.2     0.062770     0.062765     0.062775
   Scale:           3186.0     0.050415     0.050220     0.051743
   Add:             4065.9     0.059105     0.059028     0.059161
   Triad:           4217.8     0.056916     0.056902     0.056935
   -------------------------------------------------------------
   Solution Validates: avg error less than 1.000000e-13 on all three arrays
   -------------------------------------------------------------

    Performance counter stats for './stream':

           60,424,173      cache-misses                                                

          2.718200988 seconds time elapsed

数组10000000，选项-O1
---------------------

::

   root@ubuntu:~/app/stream# gcc -O1 stream.c -o stream
   perf stat -e cache-misses ./stream
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
   Your clock granularity/precision appears to be 2 microseconds.
   Each test below will take on the order of 15230 microseconds.
      (= 7615 clock ticks)
   Increase the size of the arrays if this shows that
   you are not getting at least 20 clock ticks per test.
   -------------------------------------------------------------
   WARNING -- The above is only a rough guideline.
   For best results, please be sure you know the
   precision of your system timer.
   -------------------------------------------------------------
   Function    Best Rate MB/s  Avg time     Min time     Max time
   Copy:           10603.1     0.015104     0.015090     0.015135
   Scale:          11113.3     0.014412     0.014397     0.014426
   Add:            11757.3     0.020444     0.020413     0.020470
   Triad:          11739.4     0.020467     0.020444     0.020485
   -------------------------------------------------------------
   Solution Validates: avg error less than 1.000000e-13 on all three arrays
   -------------------------------------------------------------

    Performance counter stats for './stream':

            8,937,017      cache-misses                                                

          0.935925494 seconds time elapsed

数组10000000，选项-O2
---------------------

::

   root@ubuntu:~/app/stream# gcc -O2 stream.c -o streamperf stat -e cache-misses ./stream
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
   Each test below will take on the order of 14916 microseconds.
      (= 14916 clock ticks)
   Increase the size of the arrays if this shows that
   you are not getting at least 20 clock ticks per test.
   -------------------------------------------------------------
   WARNING -- The above is only a rough guideline.
   For best results, please be sure you know the
   precision of your system timer.
   -------------------------------------------------------------
   Function    Best Rate MB/s  Avg time     Min time     Max time
   Copy:           10847.5     0.014777     0.014750     0.014815
   Scale:          11175.5     0.014349     0.014317     0.014374
   Add:            11782.7     0.020399     0.020369     0.020430
   Triad:          11778.0     0.020391     0.020377     0.020417
   -------------------------------------------------------------
   Solution Validates: avg error less than 1.000000e-13 on all three arrays
   -------------------------------------------------------------

    Performance counter stats for './stream':

            8,511,736      cache-misses                                                

          0.916443067 seconds time elapsed

数组10000000，选项-O3
---------------------

::

   root@ubuntu:~/app/stream# gcc -O3 stream.c -o stream
   perf stat -e cache-misses ./stream
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
   Each test below will take on the order of 15007 microseconds.
      (= 15007 clock ticks)
   Increase the size of the arrays if this shows that
   you are not getting at least 20 clock ticks per test.
   -------------------------------------------------------------
   WARNING -- The above is only a rough guideline.
   For best results, please be sure you know the
   precision of your system timer.
   -------------------------------------------------------------
   Function    Best Rate MB/s  Avg time     Min time     Max time
   Copy:           11190.4     0.014314     0.014298     0.014326
   Scale:          11327.3     0.014139     0.014125     0.014156
   Add:            11374.4     0.021113     0.021100     0.021124
   Triad:          11753.8     0.020434     0.020419     0.020447
   -------------------------------------------------------------
   Solution Validates: avg error less than 1.000000e-13 on all three arrays
   -------------------------------------------------------------

    Performance counter stats for './stream':

           14,925,428      cache-misses                                                

          0.911908645 seconds time elapsed

数组10000000，选项-O0
---------------------

::

   root@ubuntu:~/app/stream# gcc -O0 stream.c -o stream
   perf stat -e cache-misses ./stream
   gcc -O0 stream.c -o streamperf stat -e cache-misses ./stream
   -

数组20000000，选项无
--------------------

::

   root@ubuntu:~/app/stream# gcc -DSTREAM_ARRAY_SIZE 20000000 stream.c= -o stream
   root@ubuntu:~/app/stream# perf stat -e cache-misses ./stream
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
   Your clock granularity/precision appears to be 2 microseconds.
   Each test below will take on the order of 125238 microseconds.
      (= 62619 clock ticks)
   Increase the size of the arrays if this shows that
   you are not getting at least 20 clock ticks per test.
   -------------------------------------------------------------
   WARNING -- The above is only a rough guideline.
   For best results, please be sure you know the
   precision of your system timer.
   -------------------------------------------------------------
   Function    Best Rate MB/s  Avg time     Min time     Max time
   Copy:            2549.6     0.125998     0.125508     0.128678
   Scale:           3345.5     0.097012     0.095650     0.101765
   Add:             4172.2     0.117473     0.115047     0.120862
   Triad:           4232.1     0.190047     0.113418     0.794803
   -------------------------------------------------------------
   Solution Validates: avg error less than 1.000000e-13 on all three arrays
   -------------------------------------------------------------

    Performance counter stats for './stream':

          135,075,891      cache-misses                                                

          6.586831272 seconds time elapsed

数组20000000，选项-O
--------------------

::

   root@ubuntu:~/app/stream# gcc -O -DSTREAM_ARRAY_SIZE=20000000 stream.c -o streamperf stat -e cache-misses ./stream
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
   Your clock granularity/precision appears to be 2 microseconds.
   Each test below will take on the order of 29887 microseconds.
      (= 14943 clock ticks)
   Increase the size of the arrays if this shows that
   you are not getting at least 20 clock ticks per test.
   -------------------------------------------------------------
   WARNING -- The above is only a rough guideline.
   For best results, please be sure you know the
   precision of your system timer.
   -------------------------------------------------------------
   Function    Best Rate MB/s  Avg time     Min time     Max time
   Copy:           11145.6     0.028769     0.028711     0.028829
   Scale:          11149.8     0.028731     0.028700     0.028757
   Add:            12317.8     0.039278     0.038968     0.039673
   Triad:          12387.1     0.038914     0.038750     0.039191
   -------------------------------------------------------------
   Solution Validates: avg error less than 1.000000e-13 on all three arrays
   -------------------------------------------------------------

    Performance counter stats for './stream':

           19,804,344      cache-misses                                                

          1.803501622 seconds time elapsed

数组20000000，选项-O1
---------------------

::

   root@ubuntu:~/app/stream# gcc -O1 -DSTREAM_ARRAY_SIZE=20000000 stream.c -o streamperf stat -e cache-misses ./stream
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
   Your clock granularity/precision appears to be 2 microseconds.
   Each test below will take on the order of 32049 microseconds.
      (= 16024 clock ticks)
   Increase the size of the arrays if this shows that
   you are not getting at least 20 clock ticks per test.
   -------------------------------------------------------------
   WARNING -- The above is only a rough guideline.
   For best results, please be sure you know the
   precision of your system timer.
   -------------------------------------------------------------
   Function    Best Rate MB/s  Avg time     Min time     Max time
   Copy:            9760.2     0.032807     0.032786     0.032823
   Scale:           9978.5     0.032094     0.032069     0.032113
   Add:            11772.8     0.040799     0.040772     0.040848
   Triad:          11914.5     0.040312     0.040287     0.040324
   -------------------------------------------------------------
   Solution Validates: avg error less than 1.000000e-13 on all three arrays
   -------------------------------------------------------------

    Performance counter stats for './stream':

           21,508,150      cache-misses                                                

          1.925709392 seconds time elapsed

数组20000000，选项-O2
---------------------

::

   root@ubuntu:~/app/stream# gcc -O2 -DSTREAM_ARRAY_SIZE=20000000 stream.c -o streamperf stat -e cache-misses ./stream
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
   Your clock granularity/precision appears to be 2 microseconds.
   Each test below will take on the order of 31427 microseconds.
      (= 15713 clock ticks)
   Increase the size of the arrays if this shows that
   you are not getting at least 20 clock ticks per test.
   -------------------------------------------------------------
   WARNING -- The above is only a rough guideline.
   For best results, please be sure you know the
   precision of your system timer.
   -------------------------------------------------------------
   Function    Best Rate MB/s  Avg time     Min time     Max time
   Copy:            9762.9     0.032804     0.032777     0.032827
   Scale:           9688.2     0.033068     0.033030     0.033112
   Add:            12236.8     0.039240     0.039226     0.039267
   Triad:          12132.6     0.039607     0.039563     0.039621
   -------------------------------------------------------------
   Solution Validates: avg error less than 1.000000e-13 on all three arrays
   -------------------------------------------------------------

    Performance counter stats for './stream':

           19,257,528      cache-misses                                                

          1.883242611 seconds time elapsed

数组20000000，选项-O3
---------------------

::

   root@ubuntu:~/app/stream# gcc -O3 -DSTREAM_ARRAY_SIZE=20000000 stream.c -o streamperf stat -e cache-misses ./stream
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
   Your clock granularity/precision appears to be 2 microseconds.
   Each test below will take on the order of 31440 microseconds.
      (= 15720 clock ticks)
   Increase the size of the arrays if this shows that
   you are not getting at least 20 clock ticks per test.
   -------------------------------------------------------------
   WARNING -- The above is only a rough guideline.
   For best results, please be sure you know the
   precision of your system timer.
   -------------------------------------------------------------
   Function    Best Rate MB/s  Avg time     Min time     Max time
   Copy:           10445.6     0.030642     0.030635     0.030653
   Scale:          10470.5     0.030577     0.030562     0.030598
   Add:            11711.1     0.040998     0.040987     0.041024
   Triad:          11779.7     0.040759     0.040748     0.040772
   -------------------------------------------------------------
   Solution Validates: avg error less than 1.000000e-13 on all three arrays
   -------------------------------------------------------------

    Performance counter stats for './stream':

           30,113,752      cache-misses                                                

          1.845901002 seconds time elapsed

数组20000000，选项-O0
---------------------

::

   root@ubuntu:~/app/stream# gcc -O0 -DSTREAM_ARRAY_SIZE=20000000 stream.c -o streamperf stat -e cache-misses ./stream
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
   Your clock granularity/precision appears to be 2 microseconds.
   Each test below will take on the order of 125272 microseconds.
      (= 62636 clock ticks)
   Increase the size of the arrays if this shows that
   you are not getting at least 20 clock ticks per test.
   -------------------------------------------------------------
   WARNING -- The above is only a rough guideline.
   For best results, please be sure you know the
   precision of your system timer.
   -------------------------------------------------------------
   Function    Best Rate MB/s  Avg time     Min time     Max time
   Copy:            2549.0     0.126023     0.125538     0.128636
   Scale:           3220.9     0.099850     0.099352     0.101575
   Add:             4206.3     0.117327     0.114115     0.120934
   Triad:           4233.4     0.114978     0.113385     0.118181
   -------------------------------------------------------------
   Solution Validates: avg error less than 1.000000e-13 on all three arrays
   -------------------------------------------------------------

    Performance counter stats for './stream':

          124,664,340      cache-misses                                                

          5.506577423 seconds time elapsed
