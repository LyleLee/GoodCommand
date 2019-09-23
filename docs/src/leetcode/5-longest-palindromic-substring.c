#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * longestPalindrome(char * s){
	int index=0;
	int odd_step=0;//偶数串tep
	int even_step=0;
	int odd_index=0;
	int even_index=0;
	int i=0;
	int len = strlen(s);
	while( len>i )
	{
		int step = 0;
		//偶数子串，无中心数
		while(0 <= i-step && i+step+1 < len)
		{
			if(s[i-step] == s[i+step+1] )
			{	
				step++;
				if(odd_step <= step)
				{
					odd_step = step;
					odd_index = i;
				}
			}
			else
			{
				break;
			}

		}
		//奇数子串，有中心数
		step=0;
		while( 0<= i-step && i+step < len )
		{
			if( s[i-step] == s[i+step])
			{
				step++;
				if(even_step <= step)
				{
					even_step = step;
					even_index=i;
				}
			}
			else
			{
				break;
			}
		}

		i++;
	}	

	char *r= (char *)malloc(1001);
	memset(r,0,1001);
	if(!len)return r;

	if(odd_step >= even_step)
	{
		snprintf(r, odd_step*2+1,s+odd_index-odd_step+1);
		printf("%s, odd, index:%d, odd_length:%d\n",s,index,odd_step);
	}
	else
	{
		snprintf(r, even_step*2,s+even_index-even_step+1);
		printf("%s, even, index:%d, even_length:%d\n",s,index,even_step);
	}
	printf("%s\n",r);
	return r;
}

int main()
{
	char *s4="";
	char *s1="babad";
	char *s2="cbbd";
	char *s3="a";
	char *r = longestPalindrome(s1);
	free(r);
	r=longestPalindrome(s2);
	free(r);
	r=longestPalindrome(s3);
	free(r);
	r=longestPalindrome(s4);
	free(r);
	
}
