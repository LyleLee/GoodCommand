#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int sort_function_str(const void *a, const void *b)
{
	return (-strcmp(a,b));
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
	return 0;
}

