#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>

/*
 * 时间结构的定义
 **/
//struct timespec {
//	time_t   tv_sec;        /* seconds */
//	long     tv_nsec;       /* nanoseconds */
//};


int main()
{
	int i;
	struct timespec t1 = {0, 0};
	struct timespec t2 = {0, 0};

	for(i=0; i<5; i++)
	{
		if ( clock_gettime(CLOCK_REALTIME, &t1) == -1)
		{
			perror("clock gettime");
			exit(EXIT_FAILURE);
		}

		sleep(1);

		if ( clock_gettime(CLOCK_REALTIME, &t2) == -1)
		{
			perror("clock gettime");
			exit(EXIT_FAILURE);
		}
		printf("time pass:%ld ms\n", (t2.tv_sec-t1.tv_sec)*1000+ 
				(t2.tv_nsec-t1.tv_nsec)/1000000);
		//t2.tv_nsec-t1.nsec是有可能是负数的
	}

	return 0;
}
