#include <stdio.h> 

#define OFFSETOF(TYPE, ELEMENT) ((size_t)&(((TYPE *)0)->ELEMENT)) 

typedef struct PodTag 
{ 
	int   i; 
	double d; 
	char  c; 
} PodType; 

int main() 
{ 
	printf("i:%d\n", OFFSETOF(PodType, i)); 
	printf("d:%d\n", OFFSETOF(PodType, d));
	printf("c:%d\n", OFFSETOF(PodType, c));
	getchar(); 
	return 0; 
} 

