#include <stdio.h>

int lengthOfLongestSubstring(char * s){
	
	int start =0;
	int end = 0;
	int maxlength =0;
	int map[256] ={0};
	
	while( 0 != s[end] )
	{
		//printf("proceding:%c",s[end]);

		int c = s[end];
		
		if( map[c] == 1)
		{
			//在start到end之间判断当前字符串是否存在
			int i=start;
			for(;i<end && s[i]!=s[end];i++);
			if(i != end)
				start = i+1;
		}
		else if (map[c] == 0 )
		{
			map[c] = 1;
		}
		else
		{
			printf("error");
		}
		
		end++;
		maxlength = maxlength > (end-start)?maxlength:(end-start);
		//printf(" maxlength:%d\n",maxlength);
	}
	return maxlength;
}

int main()
{
	char *s5 = "tmmzuxt";
	char *s4 = "dvdf";
	char *s1 = "abcabcbb";
	char *s2 = "bbbbb";
	char *s3 = "pwwkew";
	
	lengthOfLongestSubstring(s5);
	lengthOfLongestSubstring(s4);
	lengthOfLongestSubstring(s1);
	lengthOfLongestSubstring(s2);
	lengthOfLongestSubstring(s3);
}
