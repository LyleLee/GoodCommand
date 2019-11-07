C skill
=======

在leetcode上提交代码经常会出现一下错误

-  Heap-buffer-overflow 访问堆内存超出范围
-  Heap-use-after-free 使用已经释放的堆内存
-  Stack-buffer-overflow 非法访问栈空间，通常是数据越界
-  Global-buffer-overflow 非常访问全局空间，通常是全局变量数组访问越界

复现方式1：

::

   gcc -O -g -fsanitize=address  test.c
   ./a.out

复现方式2：

在CMakeLists.txt添加

::

   set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -Wall -fsanitize=address")

字符串数组
==========

.. code:: c

   #include <stdio.h>
   #include <stdlib.h>
   #include <string.h>

   int main()
   {
           char s1[10]     = "This";
           char *s2        = "This";
           char s3[]       = {'T','h','i','s','\0'};
           char s4[5]      ={0}; s4[0] = 'T'; s4[1]='h'; s4[2]='i'; s4[3]='s';
                           s4[4]='\0';s4[5]='f';s4[6]='g';

           printf("s1 vs s2: %d\n",strcmp(s1,s2));
           printf("s1 vs s3: %d\n",strcmp(s1,s3));
           printf("s2 vs s3: %d\n",strcmp(s2,s3));
           printf("s1 vs s4: %d\n",strcmp(s1,s4));

           for(int i=0; i<6; i++)printf("%d:%c:%x ",i,s1[i],s1[i]);printf("\n");
           for(int i=0; i<6; i++)printf("%d:%c:%x ",i,s2[i],s2[i]);printf("\n");
           for(int i=0; i<6; i++)printf("%d:%c:%x ",i,s3[i],s3[i]);printf("\n");
           for(int i=0; i<6; i++)printf("%d:%c:%x ",i,s4[i],s4[i]);printf("\n");
           printf("\n");

           return 0;
   }

::

      0   1    2    3    4    5   6
   +---------------------------------
   |'T' |'h' |'i' |'s' |'\0'|   |   |
   +---------------------------------

这5个字符串定义等价，一共占用5个存储单元， strlen() = 4, strlen
车辆的数组长度不包含最后一个字符’\0’。

在没有地址检查的时候，访问数组是可以随意越界的，
除非越界到系统的阻拦，否则是可以随意越界的。 在编译时使用编译选项

::

   set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -Wall -fsanitize=address")

::

   #include <stdio.h>
   #include <stdlib.h>
   #include <string.h>

   int main()
   {
           char s1[10]     = "This";
           char *s2        = "This";       //允许越界， 是否允许越界，和后续的变量定义有关系
           char s3[]       = {'T','h','i','s','\0'};
           char s4[5]      ={0}; s4[0] = 'T'; s4[1]='h'; s4[2]='i'; s4[3]='s';
                           s4[4]='\0';

           printf("s1 vs s2: %d\n",strcmp(s1,s2));
           printf("s1 vs s3: %d\n",strcmp(s1,s3));
           printf("s2 vs s3: %d\n",strcmp(s2,s3));
           printf("s1 vs s4: %d\n",strcmp(s1,s4));

           for(int i=0; i<10; i++)printf("%d:%c:%x ",i,s1[i],s1[i]);printf("\n");
           for(int
           
           
         
   }

   https://beginnersbook.com/2014/01/c-strings-string-functions/

todo:
=====

eval 函数库

后缀表达式 https://juejin.im/post/5d3e55ade51d457761476238
