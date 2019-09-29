#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int sort_function_str(const void *a, const void *b)
{
	return (-strcmp(a,b));
}

int sort_function_int(const void *a, const void *b)
{
	return *((int *)a) - *((int *)b);
}
int main()
{
	char list[5][4] = { "cat", "car", "cab", "cap", "can"};
	int x;

	qsort((void *)list, 5, sizeof(list[0]), sort_function_str);

	for(x=0; x < 5; x++)
	{
		printf("%s\n",list[x]);
	}


	int ar[10]={2, 8, 50, 32, 90, 4, 66, 22, 88, 98};
	
	for(x=0; x<10; x++)
	{
		printf("%2d ",ar[x]);
	}
	printf("\n");

	qsort((void*)ar, 10, sizeof(ar[0]), sort_function_int);

	for(x=0; x<10; x++)
	{
		printf("%2d ",ar[x]);
	}
	printf("\n");

}

