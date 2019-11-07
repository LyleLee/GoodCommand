#include <stdio.h>

void lowcase(char a)
{
	printf("this is program in share library\n");
	printf("turning %c into low case %c\n", a, (a<91)?(a+32):(a));
}
