containerof
====================
由结构体成员获取机构体指针

定义在include/linux/kernel.h
```c
#define container_of(ptr, type, member) ({			\
	const typeof( ((type *)0)->member ) *__mptr = (ptr);	\
	(type *)( (char *)__mptr - offsetof(type,member) );})
```

解析如下

```c
offsetof(type,member)                       #member在结构体成员中的偏移量
typeof( ((type *)0)->member )               #获得member的类型，用于定义一个const变量
(char *)__mptr                              #member的指针， 其实就是 ptr，但是是临时定义的const指针。
(char *)__mptr - offsetof(type,member) );}  #结构体的首地址

```

offsetof的解析请参考[offsetof.md](offsetof.md)


示例代码如下：可以通过过mem2成员获得sample的首地址
```c
#include  <stdio.h>
 
#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
 
#define container_of(ptr, type, member) ({         \
    const typeof( ((type *)0)->member ) *__mptr = (ptr); \
    (type *)( (char *)__mptr - offsetof(type,member) );})
 
int main(void)
{
    struct sample {
        int mem1;
        char mem2;
    };
    
    struct sample sample1;
    
    printf("Address of Structure sample1 (Normal Method) = %p\n", &sample1);
    
    printf("Address of Structure sample1 (container_of Method) = %p\n", 
                            container_of(&sample1.mem2, struct sample, mem2));
    
    return 0;
}
```

为什么要定义一个临时变量，换成下面这种写法，结果是一样的。现在还不知道区别在哪里
```c
#include  <stdio.h>

#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)

#define container_of(ptr, type, member) ({      \
        (type *)( (char *)ptr - offsetof(type, member) ); \
})

int main(void)
{
    struct sample {
        int mem1;
        char mem2;
    };

    struct sample sample1;

    printf("Address of Structure sample1 (Normal Method) = %p\n", &sample1);

    printf("Address of Structure sample1 (container_of Method) = %p\n",
                            container_of(&sample1.mem2, struct sample, mem2));

    return 0;
}
```



## 参考资料
一个讲得比较清楚的资料是
[https://embetronicx.com/tutorials/linux/c-programming/understanding-of-container_of-macro-in-linux-kernel/](https://embetronicx.com/tutorials/linux/c-programming/understanding-of-container_of-macro-in-linux-kernel/)