#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main()
{
	char s1[10]	= "This";
	char *s2	= "This";
	char s3[]	= {'T','h','i','s','\0'};
	char s4[5]	={0}; s4[0] = 'T'; s4[1]='h'; s4[2]='i'; s4[3]='s';
			s4[4]='\0';

	printf("s1 vs s2: %d\n",strcmp(s1,s2));
	printf("s1 vs s3: %d\n",strcmp(s1,s3));
	printf("s2 vs s3: %d\n",strcmp(s2,s3));
	printf("s1 vs s4: %d\n",strcmp(s1,s4));

	for(int i=0; i<10; i++){ printf("%d:%c:%x ",i,s1[i],s1[i]); }printf("\n");
	for(int i=0; i<8; i++) { printf("%d:%c:%x ",i,s2[i],s2[i]); }printf("\n");
	for(int i=0; i<5; i++) { printf("%d:%c:%x ",i,s3[i],s3[i]); }printf("\n");
	for(int i=0; i<5; i++) { printf("%d:%c:%x ",i,s4[i],s4[i]); }printf("\n");
	
	printf("\n");

	printf("s1 len:%zd\n",strlen(s1));
	printf("s2 len:%zd\n",strlen(s2));
	printf("s3 len:%zd\n",strlen(s3));
	printf("s4 len:%zd\n",strlen(s4));

	return 0;
}
