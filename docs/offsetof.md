offsetof
===================
由结构体类型， 结构体成员，获取成员的偏移量。

实现方式[【https://en.wikipedia.org/wiki/Offsetof#Implementation】](https://en.wikipedia.org/wiki/Offsetof#Implementation)

## kernel中的实现

```c
#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
```
解析如下：

```c
            (TYPE *)0           #将0转化为结构体类型的指针。
           ((Type *)0)->MEMBER  #用这个结构体指针引用成员
          &((Type *)0)->MEMBER  #获取成员变量的地址。由于起始地址是0，所以成员变量的地址也就是成员的偏移量
(size_t)  &((Type *)0)->MEMBER  #把地址转换成size_t类型
```


## C库中使用

引用头文件
```c
#include <stddef.h>
```
参考代码：
```c
#include <stddef.h>
#include <stdio.h>

struct address {
   char name[50];
   char street[50];
   int phone;
};
   
int main () {
   printf("name offset = %d byte in address structure.\n",
   offsetof(struct address, name));

   printf("street offset = %d byte in address structure.\n",
   offsetof(struct address, street));

   printf("phone offset = %d byte in address structure.\n",
   offsetof(struct address, phone));

   return(0);
}
```
代码来自：[https://www.tutorialspoint.com/c_standard_library/c_macro_offsetof.htm](https://www.tutorialspoint.com/c_standard_library/c_macro_offsetof.htm)