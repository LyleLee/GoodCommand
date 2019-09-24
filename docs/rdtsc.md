移植rdtsc
===================
rdtsc是x86的时时间戳计数器，在ARM上是没有这个寄存器的，所以需要把它替换为相应的实现。




在C/C++源文件当中，嵌入了汇编代码，使用rdtsc(X86特有的汇编指令)获取时间戳计数器的值。
```
#include "util/tc_monitor.h"
#include "util/tc_thread.h"
#include "util/tc_autoptr.h"

#define rdtsc(low,high) \
     __asm__ __volatile__("rdtsc" : "=a" (low), "=d" (high))

#define TNOW     tars::TC_TimeProvider::getInstance()->getNow()
#define TNOWMS   tars::TC_TimeProvider::getInstance()->getNowMs()
```
我们把它替换掉，使用内联函数即可：
```
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

```

原调用方法
```
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
```
修改为新调用方法：
```
void TC_TimeProvider::setTsc(timeval& tt)
{
    uint64_t current_tsc    = rdtsc();

    uint64_t& last_tsc      = _tsc[!_buf_idx];
    timeval& last_tt        = _t[_buf_idx];
    //....
}
```


参考资料：

[https://handystats.readthedocs.io/en/latest/time-measurement.html](https://handystats.readthedocs.io/en/latest/time-measurement.html)