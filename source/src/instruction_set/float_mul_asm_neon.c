#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>

#include <arm_neon.h>

int mul_int(int a, int b)
{
	int c = a * b;
	printf("%d\n",c);
}

int mul_long(long a, long b)
{
	long c = a * b;
	printf("%ld\n",c);
}

int mul_double(double a, double b)
{
	double c = a * b;
	printf("%lf\n",c);
}

int mul_long_double(long double a , long double b)
{
	long double c = a * b;
	printf("%ld\n",c);
}

int mul_uint32(uint32_t a, uint32_t b)
{
	uint32_t c = a * b;
	printf("%" PRIu32 "\n",c);
	
}

int mul_uint64(uint64_t a, uint64_t b)
{
	uint64_t c = a * b;
	printf("%" PRIu64 " \n",c);
}

int mul_float16(float16_t a, float16_t b)
{
	float16_t c = a*b;
	long d = (long)c;
	printf("%d\n",d);
	asm(
		"fmul  v0.8h,  v0.8h, v1.8h"
	);
}

int main()
{
	mul_int(3 , 4);
	mul_long(2222, 3333);
	mul_double(222.222 , 333.333);
	mul_long_double(222.222 , 333.333);
	mul_uint32(222 , 333);
	mul_uint64(222 , 333);
}
