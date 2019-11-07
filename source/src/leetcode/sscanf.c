#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int is_legal_op(char c)
{
//	printf("input char : %c\n",c);
	if( c == '+' || c == '-' || c == '*' || c== '/' || c== '(' ||c == ')' )
	{

//		printf("legal cu_op:%c\n",c);
		return 1;
	}
	return 0;
}

int main()
{

	char *s2 = "13-1  +2*30 +(4* 5 - 6 )*7";
	int one_num = 0;
	int one_op  = 0;
	int scand_index =0;
	int len = strlen(s2);

	int read_num=0;
	int read_op =0;

	int cu_num;
	char cu_op;

	while(scand_index < len)
	{
		one_num = sscanf(s2+scand_index, "%d%n", &cu_num, &read_num);
		one_op  = sscanf(s2+scand_index, "%c%n", &cu_op, &read_op);

		//printf("scand_index:%d cu_num:%d read_num:%d one_op:%d read_op:%d\n", 
		//	scand_index, cu_num, read_num, cu_op, read_op);
		if(one_op == 1 && is_legal_op(cu_op))
		{
			printf("%c\n", cu_op);
			scand_index+=read_op;
			continue;
		}
		if(cu_op == ' ')
		{		
			scand_index+=read_op;
			continue;
		}

		if(one_num == 1)
		{
			printf("%d\n", cu_num);
			scand_index+=read_num;
			continue;
		}
		if(one_num ==0 && one_op ==0) 
		{
			printf("error\n");
			return 0;
		}
	}
	printf("\n");

	return 0;
}
