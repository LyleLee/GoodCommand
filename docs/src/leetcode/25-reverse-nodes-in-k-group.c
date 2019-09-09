#include <stdio.h>
#include <stdlib.h>

struct ListNode {
	int val;
	struct ListNode *next;
};

void revert(struct ListNode *a[], int start , int end)
{
	//printf("start:%d, end:%d\n",start,end);
	struct ListNode *p=NULL;
	while(start < end)
	{
		//printf("reverting:%p,value:%d; %p,value:%d\n",a[start],a[start]->val,a[end],a[end]->val);
		p=a[start];
		a[start]=a[end];
		a[end]=p;
		start++;
		end--;
	}
}


struct ListNode* reverseKGroup(struct ListNode* head, int k){
	int s=0;
	int i=0;
	int j=0;

	struct ListNode *p=head;
	struct ListNode **a= (struct ListNode **)malloc(sizeof(struct ListNode *)*k);
	while(p)
	{
		a[s++] = p;
		p=p->next;
	}
	
	for(i=0;i<s;i++)
	{	
		//printf("address: %p; value:%d\n",a[i], a[i]->val);
	}
	for(j=0; j<s/k; j++)
	{
		revert(a, j*k, (j+1)*k-1);
	}
		
	for(i=0; i<s-1; i++)
	{
		a[i]->next = a[i+1];
		//printf("address: %p; value:%d\n",a[i], a[i]->val);
	}
	a[i]->next=NULL;
	return a[0];
}


void walk_a_list(struct ListNode * head)

{
	struct ListNode *p1 = head;
	while(p1)
	{
		printf("address: %p; value:%d\n",p1,p1->val);
		p1=p1->next;
	}
	printf("\n");
}


struct ListNode * create_list(int k)
{
	int i;
	struct ListNode *new_head = (struct ListNode *) malloc(sizeof(struct ListNode));
	new_head->val = 0;
	new_head->next = NULL;
	for(i=1;i<=k;i++)
	{
		struct ListNode *p = (struct ListNode *) malloc(sizeof(struct ListNode));
		p->val =i;
		p->next = NULL;

		struct ListNode *p1 = new_head;
		while(p1->next)
		{
			p1=p1->next;
		}
		p1->next = p;
	}
	return new_head;
}

int main()
{
	struct ListNode *new_head = create_list(5);
	walk_a_list(new_head);
	struct ListNode *re = reverseKGroup(new_head->next,2);
	walk_a_list(re);

	new_head = create_list(5);
	walk_a_list(new_head);
	re = reverseKGroup(new_head->next,3);
	walk_a_list(re);

	new_head = create_list(6);
	walk_a_list(new_head);
	re = reverseKGroup(new_head->next,2);
	walk_a_list(re);
}
