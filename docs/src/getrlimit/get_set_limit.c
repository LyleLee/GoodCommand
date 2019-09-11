#include <stdio.h>
#include <string.h>
#include <sys/time.h>
#include <sys/resource.h>

int main()
{
	struct rlimit lim;
	int i;
	
	for (i=0; i<10;i++)
	{
		memset(&lim,0,sizeof(struct rlimit));
		
		printf("RLMIT_FSIZE:%lld\n",(long long)RLIMIT_FSIZE);
		getrlimit(RLIMIT_FSIZE, &lim);
	
		printf("Previous limits: soft:%lld; hard=%lld\n",
			(long long)lim.rlim_cur,
			(long long)lim.rlim_max);
	}
	
}
