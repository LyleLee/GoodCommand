#include <stdio.h>

#define container_of(ptr, type, member) ({			\
	const typeof( ((type *)0)->member ) *__mptr = (ptr);	\
	(type *)( (char *)__mptr - offsetof(type,member) );})


#define list_entry(ptr, type, member) \
        container_of(ptr, type, member)


struct list_head
{
	struct list_head *next, *prev;
}


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


