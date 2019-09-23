#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main()
{
	char *s1="babad";
	char *s2="cbbd";
	char *a = (char *)malloc(100*sizeof(char));
	char b[10]= {0};
	printf("sizeof(a):%d\n",sizeof(a));
	printf("sizeof(b):%d\n",sizeof(b));
	printf("sizeof(char):%d\n",sizeof(char));
	memset(a, 0, 100);
	snprintf(a,3,s1+2);
	printf("%s\n",a);

	memset(a, 0, 100);
	snprintf(a, 2, s2+1);
	printf("%s\n",a);

	return 0;
}

