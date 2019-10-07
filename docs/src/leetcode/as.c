#include <stdio.h>
char s[]="123 ab 4";
char *p;
int v,n,k;
void main() {
    p=s;
    while (1) {
        k=sscanf(p,"%d%n",&v,&n);
        printf("k,v,n=%d,%d,%d\n",k,v,n);
        if (1==k) {
            p+=n;
        } else if (0==k) {
            printf("skip char[%c]\n",p[0]);
            p++;
        } else {//EOF==k
            break;
        }
    }
    printf("End.\n");
}
//k,v,n=1,123,3
//k,v,n=0,123,3
//skip char[ ]
//k,v,n=0,123,3
//skip char[a]
//k,v,n=0,123,3
//skip char[b]
//k,v,n=1,4,2
//k,v,n=-1,4,2
//End.

