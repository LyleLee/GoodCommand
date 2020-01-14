#include "public_code.h"

int test_data_type(void)
{
        int integerType;
        float floatType;
        double doubleType=1101.333;
        char charType='a';
        long longType=800;
        unsigned long unsignedLongType=2343;
        short shortType=1;
        unsigned short unsignedShortType=2;
        // Sizeof operator is used to evaluate the size of a variable
        printk("Size of int: %ld bytes\n",sizeof(integerType));
        printk("Size of float: %ld bytes\n",sizeof(floatType));
        printk("Size of double: %ld bytes\n",sizeof(doubleType));
        printk("Size of char: %ld byte\n",sizeof(charType));
        printk("Size of long: %ld bytes\n",sizeof(longType));
        printk("Size of unsigned long: %ld bytes\n",sizeof(unsignedLongType));
        printk("Size of short: %ld bytes\n",sizeof(shortType));
        printk("Size of unsigned short: %ld bytes\n",sizeof(unsignedShortType));
        return 0;
}


