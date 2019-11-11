#include <stdio.h>
#include "arm_neon.h"

void pr(uint8_t *p, int n)
{
    int i;
    printf("data: ");
    for(i = 0; i < n; i++)
    {
        printf("%02d ", p[i]);
    }
    printf("\n");
}

int main()
{
    uint8_t origin[16] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16};
    uint8x16_t three = vmovq_n_u8(3);
    
    uint8x16_t data = vldrq_u8(origin);
    uint8x16_t result = vaddq_u8(data, three);
    
    printf("%x", result);
    
}