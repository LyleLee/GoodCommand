#include <stddef.h>
#include <stdio.h>

struct address {
   char name[50];
   char street[50];
   int phone;
};
   
int main()
{
   printf("address 结构中的 name 偏移 = %d 字节。\n",
   offsetof(struct address, name));
   
   printf("address 结构中的 street 偏移 = %d 字节。\n",
   offsetof(struct address, street));
   
   printf("address 结构中的 phone 偏移 = %d 字节。\n",
   offsetof(struct address, phone));

   return(0);
} 
