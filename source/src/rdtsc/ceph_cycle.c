/*
 *这个代码来自
 *https://github.com/ceph/ceph/blob/41d3fdc554ce920a631c7c6699a383134173fcff/src/common/Cycles.h
 * 
 */
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>

static __inline __attribute__((always_inline)) uint64_t rdtsc() {
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
# warning No High-precision
    return 0;
#endif
   }
int main()
{
	int64_t t1 = rdtsc();
	sleep(1);
	int64_t t2 = rdtsc();
	printf("t1:%ld, t2:%ld, every second has t2-t1:%ld Mhz ticks \n",t1,t2,(t2-t1)/1000000);

	return 0;
}

/*__aarch64__是arm gcc预定义宏
 *http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0774a/chr1383660321827.html
 *
 *
*/
