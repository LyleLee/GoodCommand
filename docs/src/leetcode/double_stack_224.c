#include <stdio.h>
#include <stdlib.h>
#include <string.h>



typedef struct {
	int it;
	int *data;
	int max_size;
} Stack;

void stack_init(Stack *stack, int size)
{
	stack->it = -1;
	stack->max_size = size;
	if(size > 0)
	{
		stack->data = (int *) malloc(sizeof(int)*size);
		if(stack->data)
		{
			memset(stack->data, 0, sizeof(int)*size);
		}
	}
}

int stack_is_empty(Stack *stack)
{
	return stack->it == -1;
}

int stack_is_full(Stack * stack)
{
	return stack->it == stack->max_size-1;
}

int stack_top(Stack * stack)
{
	if(!stack_is_empty(stack))
		return stack->data[stack->it];
	else return 0;
}

void stack_push(Stack *stack,int e)
{
	if(!stack_is_full(stack))
	{
		stack->data[++stack->it] = e;
	}
	else
	{
		printf("stack is full!\n");
	}
}

int stack_pop(Stack *stack)
{
	if(!stack_is_empty(stack))
	{
		int e = stack->data[stack->it];
		stack->data[stack->it] = 0;
		stack->it--;
		return e;
	}
	else return 0;
}

void stack_print(Stack *stack)
{
	int i;
	printf("stack %p: it:%d: data: ",stack,stack->it);
	for(i = 0; i< stack->max_size; i++ )
	{
		printf("%d ", stack->data[i]);
	}
	printf("\n");
}

void stack_free(Stack *stack)
{
	free(stack->data);
}

int is_legal_op(char c)
{
	if( c == '+' || c == '-' || c == '*' || c== '/' || c== '(' ||c == ')' )
	{
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

int do_one_cal(int op, int a1, int a2)
{
	int result = 0;
	switch(op)
	{
		case '+': result = a1+a2;break;
		case '-': result = a2-a1;break;
		case '*': result = a1*a2;break;
		case '/': result = a2/a1;break;	
		default:
			  {
				  printf("uknown op!\n");
				  result =0;
			  }
	}
	return result;

}

int pop_and_cal(Stack *opst, Stack *npst)
{
	int this_op = stack_pop(opst);
	int a1 = stack_pop(npst);
	int a2 = stack_pop(npst);
	int this_result = do_one_cal(this_op,a1,a2);

	stack_push(npst,this_result);
	
	printf("%d %c %d = %d\n", a1, this_op, a2, this_result);	

	return this_result; 
}

int calculate(char * s){

	int num_flags = 0, op_flags =0, num_read_count = 0, op_read_count = 0, cu_num;
	char cu_op;
	int scand_index = 0;

	int str_len = strlen(s);

	Stack num_stack; Stack * npst = &num_stack;
	Stack op_stack;  Stack * opst = &op_stack;

	stack_init(npst, str_len);
	stack_init(opst, str_len);

	while(scand_index < str_len)
	{
		num_flags = sscanf(s+scand_index, "%d%n", &cu_num, &num_read_count);
		op_flags  = sscanf(s+scand_index, "%c%n", &cu_op, &op_read_count);

		if(op_flags == 1 && is_legal_op(cu_op))
		{
			if(stack_is_empty(opst))
			{
				stack_push(opst, (int)cu_op);
			}

			else if(cu_op == '(')
			{
				stack_push(opst, (int)cu_op);
			}
			else if(cu_op == ')')
			{
				while(stack_top(opst) != (int)'(')
				{
					pop_and_cal(opst, npst);
				}
				stack_pop(opst);//pop '('
			}
			else
			{
				while(prio(cu_op) <= prio(stack_top(opst)))
				{
					pop_and_cal(opst, npst);
					if(stack_is_empty(opst))
						break;
				}
				stack_push(opst, cu_op);
			}
			scand_index+=op_read_count;
			continue;
		}
		if(cu_op == ' ')
		{
			scand_index+=op_read_count;
			continue;
		}
		if(num_flags == 1)
		{
			stack_push(npst, cu_num);
			scand_index+=num_read_count;
		}

	}
	while(!stack_is_empty(opst))
	{
		pop_and_cal(opst, npst);	
	}
	
	int final_result = stack_pop(npst);
	printf("final result: %d\n\n", final_result);
	
	stack_free(opst);
	stack_free(npst);

	return final_result;
}

int main()
{

        char *s5 = "  30";
	calculate(s5);

        char *s2 = "1+2*3+(4*5+6)*7";
	calculate(s2);

        char *s3 = "(1+(4+5+2)-3)+(6+8)";
	calculate(s3);

        char *s4 = " 2-1 + 2 ";
	calculate(s4);

	char *s6 = "0";
	calculate(s6);

	return 0;
}
