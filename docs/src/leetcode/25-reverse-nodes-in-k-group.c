#include <stdio.h>
#include <stdlib.h>

struct ListNode {
	int val;
	struct ListNode *next;
};

struct ListNode* reverseKGroup(struct ListNode* head, int k){
	struct ListNode *new_head = (struct ListNode*)malloc(sizeof(struct ListNode));
	new_head->val = 0;
	new_head->next = NULL;
	struct ListNode *p1 = new_head;
	struct ListNode *p2 = NULL;
	p1->next = p2;
	struct ListNode *p3 = head;	
	struct ListNode *p4 = NULL;
	while(p3->val != k)
	{
		p4 = p3->next;
		p3->next = p2;
		p1->next = p3;
		
		p2 = p3;
		p3 = p4;
	}
	struct ListNode *p5=p1;
	while(p5->next)p5=p5->next;
	p5->next= p3->next;
	p3->next = p1->next;
	return p3;
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
	struct ListNode *re = reverseKGroup(new_head->next,5);
	walk_a_list(re);
	
	new_head = create_list(5);
	walk_a_list(new_head);
	re = reverseKGroup(new_head->next,2);
	walk_a_list(re);
	
	new_head = create_list(5);
        walk_a_list(new_head);
        re = reverseKGroup(new_head->next,1);
        walk_a_list(re);

}
