#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>


#define container_of(ptr, type, member) ({			\
		const typeof( ((type *)0)->member ) *__mptr = (ptr);	\
		(type *)( (char *)__mptr - offsetof(type,member) );})


#define list_entry(ptr, type, member) \
	container_of(ptr, type, member)


struct list_head
{
	struct list_head *next, *prev;
};

struct node
{
	int value;
	struct list_head list;
};


void INIT_LIST_HEAD(struct list_head *list)
{
	list->next = list;
	list->prev = list;
}

void __list_add(struct list_head *new,
		struct list_head *prev, 
		struct list_head *next)
{
	next->prev = new;
	new->next = next;
	new->prev = prev;
	prev->next= new;

}

void list_add(struct list_head *new,
		struct list_head *head)
{
	__list_add(new, head, head->next);
}

void walk_list(struct list_head *head)
{
	struct list_head *ptr = head->next;
	while(ptr != head)
	{
		struct node * anode = container_of(ptr, struct node, list);
		printf("node address: %p, value: %d\n", anode, anode->value);
		ptr = ptr->next;
	}
	printf("\n");
}

void walk_list_list_entry(struct list_head *head)
{
	struct list_head *ptr = head->next;
	while(ptr != head)
	{
		struct node * anode = list_entry(ptr, struct node, list);
		printf("node address: %p, value: %d\n", anode, anode->value);
		ptr = ptr->next;
	}
	printf("\n");
}

int main(void)
{
	int i;
	struct node *ahead = (struct node *)malloc(sizeof(struct node));
	ahead->value = 99999;
	INIT_LIST_HEAD(&ahead->list);

	for(i=0; i <10 ;i++)
	{
		struct node * temp = (struct node *) malloc(sizeof(struct node));
		temp->value = rand()%100;
		printf("node address: %p, allocate a value: %d\n", 
			temp, temp->value);
		list_add(&temp->list, &ahead->list);
	}
	walk_list(&ahead->list);
	walk_list_list_entry(&ahead->list);
	return 0;
}
