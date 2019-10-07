#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main()
{
	int a = 98;
	char b[100]= {0};
	int c = 0;
	sprintf(b, "%d%n", a, &c);
	printf("%s\n%d\n",b,c);
}
