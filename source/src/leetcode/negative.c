#include <stdio.h>

int main(){
    int a = -1;
    int b = 1;
    int c = 0;

    printf("!negative is positive: %d\n", !a);
    printf("should not print. : %d \n", !b);
    printf("should be positive: %d\n", !c);
}