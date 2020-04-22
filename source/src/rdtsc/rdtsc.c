/**
 * * readTSC.c -- read the time stamp counter using the rdtsc instruction *
 * * falcon <zhangjinw@gmail.com> * 2008-04-07 *
 * * ref: 1. [url]http://z.cs.utexas.edu/users/habals/blog/index.php/linux/70[/url]
 * * 2. [url]http://www.e7188.com/Article/safe/300/878/2007/2007022852353.html[/url] *
 * */
#include <stdio.h> /* printf */
#include <unistd.h> /* alarm, pause */
#include <sys/types.h>
#include <signal.h> /* signal,kill */

typedef unsigned long long cycles_t;

inline cycles_t currentcycles()
{
	cycles_t result;
	__asm__ __volatile__ ("rdtsc" : "=A" (result));

	return result;
}

cycles_t t1, t2;

void handler(int signo)
{
	t2 = currentcycles();
	printf("cpu MHz : %lld/n", (t2-t1)/1000000);
	kill(getpid(), SIGINT);
}

int main(void)
{
	signal(SIGALRM, handler); //注册一个函数
	t1 = currentcycles(); //获取当前时间
	alarm(1);
	while(1)
		pause();

	return 0;
}



