*********************
c skill
*********************

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
   }

   https://beginnersbook.com/2014/01/c-strings-string-functions/

C 变量类型和最大限制
======================

在 :ref:`glibc` 的limit.h [#limits.h]_ 中定义有C语言类型的各种最大限制。

.. literalinclude:: ../src/no_catalog/char_limits.c
   :language: c

.. code-block:: console

    minmun char:0 maximun char:255

todo:
=====

eval 函数库

后缀表达式 https://juejin.im/post/5d3e55ade51d457761476238

问题记录
============

.. code-block:: console

    [  7%] Building C object CMakeFiles/151.out.dir/151-reverse-words-in-a-string.c.o
    /opt/rh/devtoolset-8/root/usr/bin/cc   -g -Wall -fsanitize=address   -o CMakeFiles/151.out.dir/151-reverse-words-in-a-string.c.o   -c /home/user1/GoodCommand/source/src/leetcode/151-reverse-words-in-a-string.c
    Linking C executable 151.out
    /usr/bin/cmake -E cmake_link_script CMakeFiles/151.out.dir/link.txt --verbose=1
    /opt/rh/devtoolset-8/root/usr/bin/cc   -g -Wall -fsanitize=address    CMakeFiles/151.out.dir/151-reverse-words-in-a-string.c.o  -o 151.out  -L/opt/rh/devtoolset-7/root/usr/lib/gcc/aarch64-redhat-linux/7 -rdynamic
    /opt/rh/devtoolset-8/root/usr/libexec/gcc/aarch64-redhat-linux/8/ld: cannot find libasan_preinit.o: No such file or directory
    /opt/rh/devtoolset-8/root/usr/libexec/gcc/aarch64-redhat-linux/8/ld: cannot find -lasan
    collect2: error: ld returned 1 exit status
    make[2]: *** [CMakeFiles/151.out.dir/build.make:92: 151.out] Error 1
    make[2]: Leaving directory '/home/user1/GoodCommand/source/src/leetcode/build'
    make[1]: *** [CMakeFiles/Makefile2:67: CMakeFiles/151.out.dir/all] Error 2
    make[1]: Leaving directory '/home/user1/GoodCommand/source/src/leetcode/build'
    make: *** [Makefile:79: all] Error 2
    [user1@centos build]$


.. [#limits.h] limits.h https://sourceware.org/git/?p=glibc.git;a=blob;f=include/limits.h;h=8195da78a4a6074d737ec45ba27b8fec6005543e;hb=HEAD
