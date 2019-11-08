移植rdtsc
*********************************

rdtsc是x86的时时间戳计数器，在ARM上是没有这个寄存器的，所以需要把它替换为相应的实现。

在C/C++源文件当中，嵌入了汇编代码，使用rdtsc(X86特有的汇编指令)获取时间戳计数器的值。

::

   #include "util/tc_monitor.h"
   #include "util/tc_thread.h"
   #include "util/tc_autoptr.h"

   #define rdtsc(low,high) \
        __asm__ __volatile__("rdtsc" : "=a" (low), "=d" (high))

   #define TNOW     tars::TC_TimeProvider::getInstance()->getNow()
   #define TNOWMS   tars::TC_TimeProvider::getInstance()->getNowMs()

我们把它替换掉，使用内联函数即可：

::

   #include "util/tc_monitor.h"
   #include "util/tc_thread.h"
   #include "util/tc_autoptr.h"

   __inline __attribute__((always_inline)) uint64_t rdtsc() {
   #if defined(__i386__)
       int64_t ret;
       __asm__ volatile ("rdtsc" : "=A" (ret) );
       return ret;
   #elif defined(__x86_64__) || defined(__amd64__)
       uint32_t lo, hi;
       __asm__ __volatile__("rdtsc" : "=a" (lo), "=d" (hi));
       return (((uint64_t)hi << 32) | lo);
   #elif defined(__aarch64__)
   uint64_t cntvct;
       asm volatile ("isb; mrs %0, cntvct_el0; isb; " : "=r" (cntvct) :: "memory");
       return cntvct;
   #else
   #warning No high-precision counter available for your OS/arch
       return 0;
   #endif
   }

   #define TNOW     tars::TC_TimeProvider::getInstance()->getNow()
   #define TNOWMS   tars::TC_TimeProvider::getInstance()->getNowMs()

原调用方法

::

   void TC_TimeProvider::setTsc(timeval& tt)
   {
       uint32_t low    = 0;
       uint32_t high   = 0;
       rdtsc(low,high);
       uint64_t current_tsc    = ((uint64_t)high << 32) | low;

       uint64_t& last_tsc      = _tsc[!_buf_idx];
       timeval& last_tt        = _t[_buf_idx];
       //.....
   }

修改为新调用方法：

::

   void TC_TimeProvider::setTsc(timeval& tt)
   {
       uint64_t current_tsc    = rdtsc();

       uint64_t& last_tsc      = _tsc[!_buf_idx];
       timeval& last_tt        = _t[_buf_idx];
       //....
   }

linux 获取时间的办法：
======================

::

   man 3 clock_gettime

   int clock_gettime(clockid_t clk_id, struct timespec *tp);

clk_id可以是以下的值

-  CLOCK_REALTIME 系统实时时间,随系统实时时间改变而改变
-  CLOCK_REALTIME_COARSE 低精度，更快的CLOCK_REALTIME版本
-  CLOCK_MONOTONIC
   系统启动到现在的技术，不受系统用户时间跳跃的影响，但是受adjtime()和ntp影响
-  CLOCK_MONOTONIC_COARSE 低精度，更快的CLOCK_MONOTONIC版本
-  CLOCK_MONOTONIC_RAW
   和CLOCK_MONOTONIC类似，但是提供基于硬件的时间，不受ntp影响
-  CLOCK_BOOTTIME 和CLOCK_MONOTONIC一样，除了记录系统休眠时间。
-  CLOCK_PROCESS_CPUTIME_ID,本进程到当前代码系统CPU花费的时间
-  CLOCK_THREAD_CPUTIME_ID,本线程到当前代码系统CPU花费的时间

示例程序：

::

   #include <stdio.h>
   #include <stdlib.h>
   #include <unistd.h>
   #include <time.h>

   int main()
   {
           int i;
           struct timespec t1 = {0, 0};
           struct timespec t2 = {0, 0};

           for(i=0; i<5; i++)
           {
                   if ( clock_gettime(CLOCK_REALTIME, &t1) == -1)
                   {
                           perror("clock gettime");
                           exit(EXIT_FAILURE);
                   }

                   sleep(1);

                   if ( clock_gettime(CLOCK_REALTIME, &t2) == -1)
                   {
                           perror("clock gettime");
                           exit(EXIT_FAILURE);
                   }
                   printf("time pass:%ld ms\n", (t2.tv_sec-t1.tv_sec)*1000+
                                   (t2.tv_nsec-t1.tv_nsec)/1000000);
                   //t2.tv_nsec-t1.nsec是有可能是负数的
           }
   }

确认机器支持哪些时钟寄存器
==========================

::

   cat /proc/cpuinfo | grep -i tsc
   flags : ... tsc  rdtscp constant_tsc nonstop_tsc ...

+-----------+---------------------------------------------+------------+
| Flag      | Meaning                                     | 含义       |
+===========+=============================================+============+
| tsc       | The system has a TSC clock.                 | 系统有TSC时钟 |
+-----------+---------------------------------------------+------------+
| rdtscp    | The RDTSCP instruction is available.        | 支持RDTSCP指令 |
+-----------+---------------------------------------------+------------+
| constant_ | The TSC is synchronized across all          | TSC是同步的 |
| tsc       | sockets/cores.                              |            |
+-----------+---------------------------------------------+------------+
| nonstop_t | The TSC is not affected by power management | TSC是不受电源管理 |
| sc        | code.                                       | 代码影响   |
+-----------+---------------------------------------------+------------+

RDTSC没有保序的功能，所以会导致想测的指令在RDTSC区间之外进行。这样为避免CPU乱序，需要用cpuid保序，之后的CPU都有RDTSCP
，这是已经保序的指令，所以只要有这个指令应该使用这个，而不是老版的 #
获取时间戳本延时测试

在我的x86服务器上：

.. code::

   ClockBench.cpp
                      Method       samples     min     max     avg  median   stdev
              CLOCK_REALTIME       1023      21.00   25.00   22.37   23.00    0.88
       CLOCK_REALTIME_COARSE       1023       0.00    0.00    0.00    0.00    0.00
             CLOCK_MONOTONIC       1023      21.00 2173.00   24.37 1097.00   67.33
         CLOCK_MONOTONIC_RAW       1023     385.00  415.00  388.77  400.00    5.80
      CLOCK_MONOTONIC_COARSE       1023       0.00    0.00    0.00    0.00    0.00
                 cpuid+rdtsc       1023     112.00  136.00  113.02  124.00    1.88
                      rdtscp       1023      32.00   32.00   32.00   32.00    0.00
                       rdtsc       1023      24.00   28.00   24.50   26.00    1.32
   Using CPU frequency = 1.000000

参考资料：
==========

介绍时间
https://handystats.readthedocs.io/en/latest/time-measurement.html

获取时间的benchmark
http://btorpey.github.io/blog/2014/02/18/clock-sources-in-linux/
