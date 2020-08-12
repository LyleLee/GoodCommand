#include <stdio.h>
#include <stdlib.h>

#define MAXN 200001

int Compare(const void *a, const void *b){
    return *(int *)a - *(int *)b ;
}

int main()
{
    int n, k;
    unsigned long long int count = 0;
    int a[MAXN] = {0};

    scanf("%d %d", &n, &k);
    for(int i = 0; i < n; i++){
        scanf("%d", &a[i]);
    }

    qsort(a, n, sizeof(int), Compare);

     for(int i = 0, j = n-1; i < j;){
        if( a[i] + a[j] > k){
            j--;
        }
        else{
            count = count + (j - i);//找到能结合最小的数a[0]的数a[j]。 他们中间所有的数都可以和a[0结合]。下一个循环找a[1]结合的数
            i++;
        }
        if

    }
    printf("%d", count);

    return 0;
}