#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define NUM_MAX_LEN 10
#define SPACE_LEN 100
struct node_num_op{
	int is_num;
	char num_op[NUM_MAX_LEN];
};

struct node_num_op *stack = NULL;
int it = -1;
int stack_len = 0;

struct node_num_op* stack_init(int len){
	stack = (struct node_num_op *)malloc(sizeof(struct node_num_op)*(len+1));
	stack_len = len;
	memset(stack, 0, sizeof(struct node_num_op)*(len+1));
	return stack;
}

int stack_top()
{
	if(it != -1)
		return it;
	return -1;
}

int stack_push(int is_num, char *num_op)
{
	if(it<=stack_len)
	{
		++it;
		stack[it].is_num = is_num;
		strcpy(stack[it].num_op, num_op);

		return it;
	}
	else
	{
		perror("stck overflow");
		return it;
	}
}
int stack_pop()
{
	if(it>=0)
	{ 
		int i = it;
		it--;
		return i;
	}
	else return -1;
}

void stack_print()
{
	int i;
	printf("stack:");
	for(i=0;i<stack_len;i++)
	{
		printf("%s ",stack[i].num_op);
	}
	printf("\n");
}

int is_empty()
{
	if(it == -1)return 1;
	return 0;
}

int is_legal_op(char c)
{
	//      printf("input char : %c\n",c);
	if( c == '+' || c == '-' || c == '*' || c== '/' || c== '(' ||c == ')' )
	{

		//              printf("legal cu_op:%c\n",c);
		return 1;
	}
	return 0;
}

int prio(char op) {      
	int priority;
	if (op == '*' || op == '/')
		priority = 2;
	if (op == '+' || op == '-')
		priority = 1;
	if (op == '(')
		priority = 0;
	return priority;
}

char* mtob(char *s)
{
	int one_num = 0, one_op = 0, read_num =0, read_op =0, cu_num;
	char cu_op;
	int scand_index =0;

	int len  = strlen(s)+SPACE_LEN;
	int bi = 0;

	char * bstr = (char *)malloc(len+1);
	char num_op[10]= {0};

	memset(bstr, 0, len+1);

	stack_init(len);

	if(len == 0) return bstr;

	while(scand_index < len)
	{
		one_num = sscanf(s+scand_index, "%d%n", &cu_num, &read_num);
		one_op  = sscanf(s+scand_index, "%c%n", &cu_op, &read_op);

		//printf("scand_index:%d cu_num:%d read_num:%d one_op:%d read_op:%d\n",
		//      scand_index, cu_num, read_num, cu_op, read_op);
		if(one_op == 1 && is_legal_op(cu_op))//读到操作符
		{
			//printf("%c\n", cu_op);
			scand_index+=read_op;

			if(is_empty())
			{
				sprintf(num_op, "%c", cu_op);
				stack_push(0, num_op);
			}

			else if( cu_op == '(')
			{
				sprintf(num_op, "%c", cu_op);
				stack_push(0, num_op);
			}
			else if( cu_op == ')')
			{
				int t = stack_top();
				while(!strcmp(stack[t].num_op,"("))
				{
					strcpy(bstr+bi, stack[t].num_op);
					bi++;
					bstr[bi++] = ' ';
					t = stack_pop();
				}
				t = stack_top();
			}
                        else
                        {
				int t = stack_pop();
                                while(prio(cu_op) <= prio(stack[t].num_op[0]))
                                {
					strcpy(bstr+bi, stack[t].num_op);
					bi++;
					bstr[bi++]= ' ';
                                        t = stack_pop();
                                        if(is_empty()) break;
                                }
				sprintf(num_op, "%c", cu_op);
                                stack_push(0, num_op);
                        }

			printf("in op bstr:%s\n",bstr);
			stack_print();
			continue;
		}
		if(cu_op == ' ')
		{
			scand_index+=read_op;
			continue;
		}

		if(one_num == 1)
		{
			int num_len = 0;
			sprintf(bstr+bi, "%d %n", cu_num, &num_len);
			bi+=num_len;
			scand_index+=read_num;
			printf("int num bstr:%s\n",bstr);
			stack_print();
			continue;
		}
		if(one_num ==0 && one_op ==0)
		{
			printf("error\n");
			return 0;
		}

	}
	 while(!is_empty())
        {
		int t = stack_pop();
		strcpy(bstr+bi, stack[t].num_op);
		bi+=strlen(stack[t].num_op);
		bstr[bi++]=' ';
        }
	printf("\n");

	free(stack);
	return bstr;

}



int cal_bstr(char *s)
{
/*
	int i = 0;
	int len = strlen(s);
	stack_init(len);
	if(s[0] == 0) return 0;
	while(s[i] != '\0')
	{
		if( '0'<=s[i] && s[i]<='9' )
		{
			stack_push(s[i]);
		}
		else
		{
			int a1 = stack_pop()-'0';
			int a2 = stack_pop()-'0';
			int result = 0;
			switch(s[i])
			{
				case '+' : result = a1+a2; break;
				case '-' : result = a2-a1; break;
				case '*' : result = a1*a2; break;
				case '/' : result = a2/a1; break;
				default:
					   { result =0;
						   printf("unkonw operator");
					   };
			}
			printf("result:%d ",result);
			stack_push((char)(result+'0'));
		}
		printf("char:%c\n",s[i]);
		stack_print();
		i++;
	}

	int r = stack_pop()-'0';

	free(stack);
	return r;
*/
return 0;
}

int calculate(char * s){

	char * sb = mtob(s);

	return cal_bstr(sb);
}



int main()
{
	/*
	   char *s1 = "a+b*c+(d*e+f)*g";
	   char *sb1 = mtob(s1);
	   printf("sb1:%s\n",sb1);
	   free(sb1);
	 */
	//char *s5 = "  30";

	char *s2 = "1+2*3+(4*5+6)*7";
	char *sb2 = mtob(s2);
	printf("sb2:%s\n",sb2);
	printf("cal:%d\n",cal_bstr(sb2));
	free(sb2);

	char *s3 = "(1+(4+5+2)-3)+(6+8)";
	char *sb3 = mtob(s3);
	printf("sb3:%s\n",sb3);
	printf("cal:%d\n",cal_bstr(sb3));
	free(sb3);


	char *s4 = " 2-1 + 2 ";
	char *sb4 = mtob(s4);
	printf("sb4:%s\n",sb4);
	printf("cal:%d\n",cal_bstr(sb4));
	free(sb4);

	return 0;
}
