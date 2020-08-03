#include <stdio.h>
#include <string.h>
#include "openssl/sha.h"

int main()
{
	unsigned char *str = "string";
	static unsigned char buffer[65];

	SHA256(str, strlen(str), buffer);

	int i;
    for (i = 0; i < 32; i++) {
        printf("%02x", buffer[i]);
    }
    printf("\n");

}

