#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *stack = NULL;
int it = -1;
int stack_len = 0;

char * stack_init(int len){
	stack = (char *)malloc(len+1);
	stack_len = len;
	memset(stack, 0, len+1);
	return stack;
}

char stack_top()
{
	if(it != -1)
		return stack[it];
	return 0;
}

int stack_push(char c)
{
	if(it<=stack_len)
	{
		stack[++it] = c;
		return it;
	}
	else
	{
		perror("stck overflow");
		return it;
	}
}
char stack_pop()
{
	char c;
	if(it>=0)
	{ 
		c = stack[it];
		stack[it] = 0;
		it--;
		return c;
	}
	else return -1;
}

void stack_print()
{
	int i;
	printf("stack:");
	for(i=0;i<stack_len;i++)
	{
		printf("%c",stack[i]);
	}
	printf("\n");
}

int is_empty()
{
	if(it == -1)return 1;
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
	int i=0;
	int len  = strlen(s);
	int bi = 0;
	char * bstr = (char *)malloc(len+1);
	memset(bstr, 0, len+1);

	stack_init(len);

	if(len == 0) return bstr;

	while(s[i] != 0)
	{
		//number
		if(s[i]==' ') 
		{
			i++ ;
		 	continue;
		}

		if('0'<=s[i] && s[i]<= 'z')
		{
			bstr[bi++] = s[i]; 
		}
		else
		{
			if(is_empty())
				stack_push(s[i]);
			else if(s[i] == '(')
				stack_push(s[i]);
			else if(s[i] == ')')
			{
				while(stack_top() != '(')
				{
					bstr[bi++] = stack_pop();
				}
				stack_pop();
			}
			else
			{
				while(prio(s[i]) <= prio(stack_top()))
				{
					bstr[bi++] = stack_pop();
					if(is_empty()) break;
				}
				stack_push(s[i]);
			}
		}
		//printf("char:%c\n",s[i]);
		//stack_print();
		//printf("bstr:%s\n\n",bstr);
		i++;
	}
	while(!is_empty())
	{
		bstr[bi++]=stack_pop();
	}
	
	free(stack);
	return bstr;

}



int cal_bstr(char *s)
{
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
	s5 = "  30";

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
