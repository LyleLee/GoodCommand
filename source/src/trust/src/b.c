#include  "a.h"

void IncrCount(void)
{
    g_count+=1;
}

void Test(void)
{
    printf("Count init=%d,", g_count);
    IncrCount();
    printf("incr= %d,", g_count);
    AddCount(3);
    printf("Added = =%d\n", g_count);
}

int main()
{
    Test();
}