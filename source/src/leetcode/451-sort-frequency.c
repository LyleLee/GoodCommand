#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <limits.h>

struct elemnt{
    char e;
    int frequency;
};

int compare(const void * a, const void * b){
    struct elemnt * first = (struct elemnt *)a;
    struct elemnt * second = (struct elemnt *)b;
    return second->frequency - first->frequency ;
}

char * frequencySort(char * s){
    int i = 0;
    char *ret = NULL;
    struct elemnt *pool = (struct elemnt*)malloc(sizeof(struct elemnt) * CHAR_MAX);
    memset(pool, 0, sizeof(struct elemnt) * CHAR_MAX);
    while(s[i]){
        pool[s[i]].e = s[i];
        pool[s[i]].frequency +=1;
        i++;
    }
    int strlen = i;
    // for(int i = 0; i < CHAR_MAX; i++){
    //     printf("%c %d ", pool[i].e, pool[i].frequency);
    //     if(i%21 == 0) printf("\n");
    // }
    qsort(pool, CHAR_MAX, sizeof(struct elemnt), compare);

    // for(int i = 0; i < CHAR_MAX; i++){
    //     printf("%c %d ", pool[i].e, pool[i].frequency);
    //     if(i%21 == 0) printf("\n");
    // }

    ret = (char *)malloc(sizeof(char) * (strlen+1));
    memset(ret, 0, sizeof(char) * (strlen+1));

    int count = 0;
 
    for(int i = 0; i < CHAR_MAX && pool[i].e > 0; i++)
    {
        printf("i:%d line %d\n",i, __LINE__);
        int fre = pool[i].frequency;
        while(fre)
        {
           ret[count++] = pool[i].e;
           fre--;
           printf("%s\n",ret);
        }
        printf("i:%d line %d\n",i, __LINE__);
    }
    free(pool);
    return ret;
}

int main()
{
    char *s1 = "tree";
    char *r = frequencySort(s1);
    printf("%s\n", r);
    free(r);
}
