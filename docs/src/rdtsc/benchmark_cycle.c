/*
 * 这个代码来自
 * https://github.com/google/benchmark/blob/master/src/cycleclock.h
 * */
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

//#include "config.h"

inline int64_t Now() {
#if __i386__
	int64_t ret;
	__asm__ volatile("rdtsc" : "=A"(ret));
	return ret;
#elif __x86_64__
	uint64_t low, high;
	__asm__ volatile("rdtsc" : "=a"(low), "=d"(high));
	return (high << 32) | low;

#elif __aarch64__
	// System timer of ARMv8 runs at a different frequency than the CPU's.
	// The frequency is fixed, typically in the range 1-50MHz.  It can be
	// read at CNTFRQ special register.  We assume the OS has set up
	// the virtual timer properly.
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
	
	printf("t1:%lld, t2:%lld, t2-t1:%lld\n",t1,t2,(t2-t1)/1000000);
}
