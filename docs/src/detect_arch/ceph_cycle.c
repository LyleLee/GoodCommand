#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
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
    //
    // arch/arm64/include/asm/arch_timer.h
    //
    // static inline u64 arch_counter_get_cntvct(void)
    // {
    //         u64 cval;
    // 
    //         isb();
    //         asm volatile("mrs %0, cntvct_el0" : "=r" (cval));
    // 
    //         return cval;
    // }
    //
    // https://github.com/cloudius-systems/osv/blob/master/arch/aarch64/arm-clock.cc
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
	
	printf("t1:%lld, t2:%lld, t2-t1:%lld\n",t1,t2,(t2-t1)/1000000);
}
