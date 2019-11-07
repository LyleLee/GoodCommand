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
	memset(r, 0, (len+1));
	if(len==0)return r;
	int i=len-1;
	int j=0;
	int word_begin = len-1;
	int word_end = len-1;
	while(i>=0)
	{
		while(i != -1 && s[i] == ' ')i--;
		if(i == -1) return r;
		word_end = i;
		while(i>=0 && s[i] != ' ')i--;
		if(i==-1)word_begin = 0;
		else if(s[i]==' ')word_begin=i+1;
		else printf("error...");
		//px(s,len);
		//printf("begin:%d, end:%d,j:%d\n",word_begin,word_end,j);
		if( j!= 0)r[j++]=' ';
		strncpy((r+j), s+word_begin, word_end-word_begin+1);
		i--;
		j = j+word_end-word_begin+1;
		//px(r, len);
	}

	return r;
}

int main()
{
	char * ca[] = {" a", "a", "the sky is blue", "  hello world!  ", "", " "};
	int i =0;
	char *r = NULL;
	for(i=0; i < 5;i ++)
	{
		printf("case:%d input:%s\n",i,ca[i]);
		r=reverseWords(ca[i]); px(r,strlen(ca[i]));free(r);
		printf("\n");
	}

	//char *s6 = " a";
	//char *s5 = "a";
	//char *s1 = "the sky is blue";
	//char *s2 = "  hello world!  ";
	//char *s3 = "";
	//char *s4 = " "; 
	//char *r= NULL;
	return 0;
}
