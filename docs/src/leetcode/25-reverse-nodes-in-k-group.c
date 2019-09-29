#include <stdio.h>
#include <stdlib.h>

struct ListNode {
	int val;
	struct ListNode *next;
};


void insert(struct ListNode *pre, struct ListNode *middle)
{
	middle->next = pre->next;
	pre->next = middle;
}

void removenode(struct ListNode *pre, struct ListNode* middle)
{
	if(pre->next == middle)
	{
		pre->next = middle->next;
		middle->next = NULL;
	}
}

int get_size(struct ListNode* head)
{
	int s=0;
	struct ListNode* p = head;
	while(p)
	{
		s++;
		p=p->next;
	}
	return s;
}

void do_revert(struct ListNode* head, struct ListNode *tail)
{
	struct ListNode *pre	= head->next;
	struct ListNode *p  	= pre->next;
	struct ListNode *after	= NULL;
	while(p != tail)
	{
		after= p->next;
		removenode(pre, p);
		//printf("walk after remove: %p, %d\n",p,p->val);
		insert(head, p);
		//printf("walk after insert %p, %d\n",p,p->val);
		p=after;	
	}
}

struct ListNode* get_node_by_index(struct ListNode * prefix_head, int index)
{
	int i=0;
	struct ListNode* p = prefix_head;
	for(i=0; i<index; i++) p = p->next;
	
	return p;
}
struct ListNode* reverseKGroup(struct ListNode* head, int k){
	
	int s=0;
	int i=0;

	struct ListNode *p1=NULL;
	struct ListNode *p2=NULL;

	struct ListNode *prefix_head = (struct ListNode*)malloc(sizeof(struct ListNode));
	prefix_head->val = 0;
	prefix_head->next = head;

	s = get_size(head);
	
	for(i=0; i<s/k; i++)
	{
		p1 = get_node_by_index(prefix_head,i*k);
		p2 = get_node_by_index(prefix_head,(i+1)*k);
		//printf("p1:%p, p2-next %p\n", p1, p2->next);
		do_revert(p1, p2->next);
	}

	return	prefix_head->next;
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
	printf("test case1:\n");
	struct ListNode *new_head = create_list(5);
	walk_a_list(new_head);
	struct ListNode *re = reverseKGroup(new_head->next,2);
	walk_a_list(re);
	
	printf("test case2:\n");
	new_head = create_list(6);
	walk_a_list(new_head);
	re = reverseKGroup(new_head->next,3);
	walk_a_list(re);

}
