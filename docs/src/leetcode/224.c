#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define NUM_MAX_LEN 20
#define SPACE_LEN 1000
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
	int i = it;
	it--;
	return i;
}

void stack_print()
{
	int i;
	printf("stack: it:%d :",it);
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

	int str_len = strlen(s);
	int bstr_len  = (str_len+1)*2;
	int bi = 0;

	char * bstr = (char *)malloc(bstr_len);
	char num_op[NUM_MAX_LEN]= {0};

	memset(bstr, 0, bstr_len);

	stack_init(str_len);

	if(str_len == 0) return bstr;

	while(scand_index < str_len )
	{
		one_num = sscanf(s+scand_index, "%d%n", &cu_num, &read_num);
		one_op  = sscanf(s+scand_index, "%c%n", &cu_op, &read_op);

		if(one_op == 1 && is_legal_op(cu_op))//读到操作符
		{
			//printf("input:%c: ", cu_op);
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
				int top = stack_top();
				while(stack[top].num_op[0] != '(')
				{
					int t = stack_pop();
					strcpy(bstr+bi, stack[t].num_op);
					bi++;
					bstr[bi++] = ' ';
					top = stack_top();
				}
				stack_pop();
			}
			else
			{
				int top = stack_top();
				while(prio(cu_op) <= prio(stack[top].num_op[0]))
				{
					int t = stack_pop();
					strcpy(bstr+bi, stack[t].num_op);
					bi++;
					bstr[bi++]= ' ';
					top = stack_top();
					if(is_empty()) break;
				}
				sprintf(num_op, "%c", cu_op);
				stack_push(0, num_op);
			}

			//printf("in op bstr:%s\n",bstr);
			//stack_print();
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
			//printf("int num bstr:%s\n",bstr);
			//stack_print();
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
	int one_num =0, one_op =0, read_num=0, read_op=0, cu_num;
	char cu_op;
	char num_op[NUM_MAX_LEN] = {0};
	int scand_index = 0;

	int str_len = strlen(s);
	stack_init(str_len);

	if(str_len <= 0) return 0;
	while(scand_index < str_len)
	{
		one_num = sscanf(s+scand_index, "%d%n", &cu_num, &read_num);
		one_op	= sscanf(s+scand_index, "%c%n", &cu_op,	 &read_op);

		if(one_op == 1 && is_legal_op(cu_op))//读到操作符
		{
			//printf("input:%c: ", cu_op);
			scand_index+=read_op;

			int t1 = stack_pop();
			int t2 = stack_pop();

			int a1,a2,result=0;

			sscanf(stack[t1].num_op,"%d", &a1);
			sscanf(stack[t2].num_op,"%d", &a2);

			switch(cu_op)
			{
				case '+': result = a1+a2;break;
				case '-': result = a2-a1;break;
				case '*': result = a1*a2;break;
				case '/': result = a2/a1;break;
				default:
					  {
						  result = 0;
						  printf("unknown operator");
					  }
			}
			//printf("result:%d",result);
			sprintf(num_op, "%d", result);
			stack_push(1,num_op);
			continue;

		}
		if(cu_op == ' ')
		{
			scand_index+=read_op;
			continue;
		}
		if(one_num == 1)
		{
			sprintf(num_op, "%d", cu_num);
			stack_push(1, num_op);
			scand_index+=read_num;
		}
	}
	int r = stack_pop();
	int r_num;
	sscanf(stack[r].num_op, "%d", &r_num);

	free(stack);
	return r_num;
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
	char *s5 = "  30";
	char *sb5 = mtob(s5);
	printf("sb2:%s\n",sb5);
	printf("cal:%d\n",cal_bstr(sb5));
	free(sb5);

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

	char *s6 = "(9-(10-(10-0-(3+(8+(0+(8-(10-8-(7-(2+(5+(6+(10+(3+(8+(3-(9+(1+(10+(1-(1+(6-2+0+(10-(9-(3-(3-9-(1-(7+(4-(2+(2-(10+(3+(7-(1-(4+(1+(1-(10-(5-(9+(9-4-(5-(1+8-(2-(1+(1-10-(4-(1+(4-(7)-(3-(8)+(5+5-(5-(9-(8+(8-4-1+(0-(1+(1+(10-(7+(2-(5-(4-(6+(2+(1-(2-(9+8+(2+(9-(9-(7+(10+1+(5)))-(2-(8+3+(5-(7-(3+(9)+(10+(0+(8-(1-(9)-(0+10-(3+(9-(0-(5-(7-(4-4+1+(7)-(10+(5+(9-(3+(5+(6-(0-(7-(1-(4+(6+(4-2-(4+(9-(6+9-8+1+(5+(7-9+3)+(10-(10+(2+(0-(5-(2+(10-(4-5-(7-(4-(7+(4)+6+10+(2-(7+(2))+(1)+(5-(7)-(10-(5+(7-(6-(2+(1-4)+(10-(5)+(4+(10+(4+(0+(10+(8-(8+(6+5-(1-(6-(1-(2+(4+(9-(3+(1+(10+(4)+(0+(3-(2-(9-(2-(3-(4-(2+(7-(6-(5+(7+(5+(5-(4+(0-(7+(2-(7+(9)-(6-(10)+(7+(2-(9-(9)+(4+(1-(8+(2-0-(2+(2+10)-(7-9-(9+(8-(5-8-(5)+(6+(10-(3-(2-(2+(7-2+(9+(3+(9+(2-(8+(5-(4+(4-(1-(9+(0+(6-(4-(3+(5-(2-(4-(6+(0+(4+3)-(8-(6+(9+(1+(2)-(8-(1+1+(5+(4-(3-(1-(7-4+(6+(9+(1+(4)+(6+(4+(2+(7-(1+(4-(8+(6+(8-(9-(2)-3-(0-(0)+(5+(7-(8)+(8-(2+(1)+1+(3+(6-(10-(2-4-(2-(2)+(8)+(3-(1-(1)+(6+(1+(9+(9+(5)-(4+(9+(10)+(0-(3+(3+0)+(6)-(6+(6)+(4-(8-1-5-(6)-(0))-(3)+(3-(3-(8-(10-(0-(4+(7)+(6-4))+1-(2-(1-(0-(0+(1-(0)-0+(5+(10-(2-(9-(9-10)+(3+(5-(6-(6-9-(5+5))+(7+(0)-(2-(7+2+(7-(2+(7+(4-(10+(4+(10-(3-(0-2+(9+(4-4-(3-(2)+(8+(5)+(1+1-(7+(3+(10+5-(0+(10-(9+(8-(0-(0+(8-(1+(0)+(6+(5+(5+(9)))+(4-(1-(3+(7+(9+(8-(1-8-(8+(0+(1+(1-(1)+(7+(6-(7-(8+(10)+1+(0-(10)+(8+(7+(10+(6+(10+(6)-(2+(2+(10-(8)-(5)))+(9-(1)+(4)+(5)-(6-(9)-(1+(6-(9+(10)+2-(4+(9-(4+1)-(0-(9)-(3)+(0)+(10)))+9)+(6+4+(6))+(5-(9))-(9-(2-(6+(7))-(6-(3+(5+(5-(0)-(5+(6-(5+(9-(2+(9+(1+(0+2+(7)-(3-(5+(2)+(4)+(6+(7-(3-(4)+(10+(4))+(3))-(3-(2)-(2+(2+(10+(3)+(3+(5)-(3-(0+(1)+(6+(4-(4)-(7-(9-(9)+(1)+(4)+(7))-(9))))-(3-(1+5-7-(7))-(4+(3+(7-(9+(8)-(9+(8-(3)+(10-(1)+(5)-(2-(4)+(0-(10-(7-(10+(1)+(1)-(4)-(10)))+(7)+(4-4)+0+9-(6))-(6+(5)))))-(8-(6)-(10+(5-(8)-(10+(3+(0+(6-(9)-(1)))-(0)-(9+(0+(1+(8+2-(4-(9-(4+(3+4)-(10+(1-(5)+(10-(4-(6-(4-(2+(4)-(9)-(4))))-3))))+(9)+(9+(0-(1+(5-(5+(7)-6-(8-(3-(3+(1)-(9-(7-(6)))-(2+(1))-(1+(2+(10))))+(6)+(0+(9-(1)-(10)))+(10-(1-(1)))-(0+(0-(2-(4-(6+(1))+(0)+(5)-(5+(5)-(4+(6)-(5)+(1-(7))))+(8)-(7))-3))-(7+(7+(9+(0+(10)-(7-(0-(2)-(6))-(2+(10)))+(7)+(3))+(8-(8+(10)-(8)+(0+(6-(2)-(1))+(3+(10+(10-(4+(7-(2)-(9-(2+(8))))+(7)-(7+10+(9-(2)+(0))-(6+(1)))+(10)+(2)-(7)-(4)-(10+(3-(6))))+(8-(1))-(10)))+(5+(3-(0-(1-(2+(3-(6-(4)-(1)+(4+(7+(3)-(7)+(4-(9))+(0-(4)+(9+(3-(9)+(4-(10+(6+(4)))+(4))+(10+(0-3-(8+(0-(6))-(5))-(9))-(6))))+2))+6+(6)+(1-(6))-(7-(1))-(8)+(9-(8))+(4)))-(0+7-(1)))-(2))+(0)))+(4-(7))-(5)-(8)-4+(1-(3-(8+(2+0)+(7)))))))-(4-(2))+(9))))+(7)-(2-(10+(4)-(8+(7)+(5-(4)-(6+6))-(2+(6)-(2+(4-(2-(8-(4)-(7+(5)-(10-(7)))))-(10+(9+(8)-(10)+(3-(7+(4+(2+(5)-(10+7+(2-(10)-(10+(3))+(0-(10+(8+(4+(7-(2)+(3+9))))+(7-(6+(2)-(2)+7+(5+(7+(10+(5-(4)-2+(5)+(1))+(0))))-(9))-5-(8)-(9-(4)-(10))-(8-(5)-(10)-7)+(5))-(4)))))+6+3+(3+(6+(9)))-10+(6)+(0)))))+(7)))+(1-(5)+(3-(3+6))+(5)+(7)-(9-(1))+(4+(1))+(2)))-(3))-(10)+(1)))))))))+(3)+2+(8-(4)))-(1))+(6-(8-(0)-(8-(0))-(2-(4+2)))-(9+1)))-(8-(8+(1-8-(7))))+7-(5+(5+(6+(10)+(8)))))))-(4))))-(4)-(6)+(10)-(5)))+(0+(2+(4))-(4-(2)+(0-(10-(4))))))+3-(10)))-(9+(9-(8-(7)-4))))+(6))-(4-(9))))-(1))+(10))))-(0+(9+7-(1)))))-(7)-(4)))-(9))))-7))))+(9))+(10))-(8-(9)))+(8))-(6)-(4)-(8)))))))))))))-(7)))))+(2-(6)-(0))))-(0)-(5+(9)+(9))+(3-(9))))+(8))))))))-(0-(0))+(7-(2))))))))-(6))-(8+(9))-(9+(2))-(2)+(9))-(4))+(7)-(1)-(6))-(2-0)))))))-(0)))))-(8+(0-(5))))+(9)-(1-(0)-(3)))-(3)-(0)))+(4)+(6))))-(5)+(1-(5)))))+(10))))-(5)+(0))))))-(6)))))))+(1))))))))-(5)))))))))+(8))))))))))))))))))-(7)+(10)))))))))))))-(4))))))-(10)-(4))+(1)+(3))-(1))))+(9))))))))+(2-(7-(4-(3+(0))))-(10)))))+0))))+(10)))))+(4)))))))))))+(3)))))))-(5)))))+(3)))))))))))))-(7)-(5-(2+(9))-(0))+(4)))+(10)))))-(1)))-(0))+(1))-(8+(10))))))-(10)-(10+(9)+(2))))-(1)))-(2))))+(4+(5))))))+(8))))))))))))))))))))))-(7)))-(3)))))))+(1))))-(7)-(3)+(4))))))-(6)))))))-(9-(3)))))))))))+(8))))))))))+(6))))))))))))))))))))))))))))))))))+(5))+(7))))))))))))))))))))))))-(10))))))+9)))))))";
	char *sb6 = mtob(s6);
	printf("sb6:%s\n",sb6);
	printf("cal:%d\n",cal_bstr(sb6));
	free(sb6);

	char *s7 = "0";
	char *sb7 = mtob(s7);
	printf("sb4:%s\n",sb7);
	printf("cal:%d\n",cal_bstr(sb7));
	free(sb7);
	return 0;

}
