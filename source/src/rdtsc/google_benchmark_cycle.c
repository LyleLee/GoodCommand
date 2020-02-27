/*
 * code frame from:
 * https://github.com/google/benchmark/blob/master/src/cycleclock.h
 * */
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>

__inline__ __attribute__((always_inline)) int64_t Now() {
#if __i386__
	int64_t ret;
	__asm__ volatile("rdtsc" : "=A"(ret));
	return ret;
#elif __x86_64__
	uint64_t low, high;
	__asm__ volatile("rdtsc" : "=a"(low), "=d"(high));
	return (high << 32) | low;

#elif __aarch64__
	int64_t virtual_timer_value;
	asm volatile("mrs %0, cntvct_el0" : "=r"(virtual_timer_value));
	return virtual_timer_value;
#else
#endif
}

int main()
{
	int64_t t1 = Now();
	sleep(1);
	int64_t t2 = Now();
	
	printf("t1:%ld, t2:%ld, every second has t2-t1:%ld Mhz ticks \n",t1,t2,(t2-t1)/1000000);
	
	return 0;
}
