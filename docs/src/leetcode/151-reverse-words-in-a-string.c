#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void px(char *s, int len)
{
	printf("memmory:");
	int i =0;
	for(i=0;i<len;i++)printf("%d:%c ",i,s[i]);
	printf("\n");
}

char * reverseWords(char * s){
	int len = strlen(s);
	char * r = (char *) malloc(len+1);
	if(len==0)return r;
	int i=len-1;
	int j=0;
	int word_begin = len-1;
	int word_end = len-1;
	while(i>0)
	{
		while(i != -1 && s[i] == ' ')i--;
		word_end = i;
		while(i!=-1 && s[i] != ' ')i--;
		word_begin = i+1;
		//printf("begin:%d, end:%d,j:%d\n",word_begin,word_end,j);
		//px(s,len);
		strncpy((r+j), s+word_begin, word_end-word_begin+1);
		j = j+word_end-word_begin+1;
		r[j++]=' ';
		//px(r, len);
	}
	r[j-1]=0;
	for(;j<=len;j++)r[j]='\0';

	return r;
}

int main()
{
	char *s1 = "the sky is blue";
	char *s2 = "  hello world!  ";
	char *s3 = "";
	char *r= NULL;
	r=reverseWords(s1); px(r,strlen(s1));free(r);
	r=reverseWords(s2); px(r,strlen(s2));free(r);
	r=reverseWords(s3); px(r,strlen(s3));free(r);
	return 0;
}
