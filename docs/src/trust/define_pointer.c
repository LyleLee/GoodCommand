#include <stdio.h>

#define VOS int *;

VOS p1, p2;

int main()
{
	printf("%p: %p\n",p1, p2);
	
}
