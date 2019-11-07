ARM的字节对齐问题
=================

代码：

::

   #include<stdio.h>
   #include<stdlib.h>
   #include<string.h>

   typedef struct 
   {
       char lib_build_time[4];
   }driver_version;

   typedef struct 
   {
       char a;
       driver_version version;
   }card_shm;

   int main()
   {
       card_shm shm;
       card_shm* card_shm_ptr = &shm;
       card_shm_ptr->version.lib_build_time[0] = 'a';
       card_shm_ptr->version.lib_build_time[1] = 'b';
       card_shm_ptr->version.lib_build_time[2] = 'c';  
       card_shm_ptr->version.lib_build_time[3] = 0;
       
       printf("build_time: len %d %s\n",(int)strlen("abc"),card_shm_ptr->version.lib_build_time);
   }

在X86服务器上执行：

::

   [root@x86ambari src]# gcc data_align.c -o x86_data_align.o
   [root@x86ambari src]#
   [root@x86ambari src]#
   [root@x86ambari src]# ./x86_data_align.o
   build_time: len 3 abc

在ARM服务器上执行：

::

   me@ubuntu ~/s/G/d/src> gcc data_align.c -o arm_data_align
   me@ubuntu ~/s/G/d/src>
   me@ubuntu ~/s/G/d/src>
   me@ubuntu ~/s/G/d/src> ./arm_data_align
   build_time: len 3 abc

现在没有什么问题：

改一下代码：

.. code:: c

   int main()
   {
       card_shm shm;
       card_shm* card_shm_ptr = &shm;

       card_shm_ptr->version.lib_build_time[0] = 'a';
       card_shm_ptr->version.lib_build_time[1] = 'b';
       card_shm_ptr->version.lib_build_time[2] = 'c';  
       card_shm_ptr->version.lib_build_time[3] = 0;
       
       printf("build_time: len %d %s\n",(int)strlen("abc"),card_shm_ptr->version.lib_build_time);

       memset( (char*)(card_shm_ptr+1), 0 , 4);

       printf("build_time: len %d %s\n",(int)strlen("abc"),card_shm_ptr->version.lib_build_time);
   }

在X86服务器上执行，结果和预期的一样。lib_build_time被清零了。

::

   [root@x86ambari src]# ./x86_data_align.o
   build_time: len 3 abc
   build_time: len 3

在ARM服务器上执行：结果有点出乎意料。memset没有效果。

::

   me@ubuntu ~/s/G/d/src> gcc data_align.c -o arm_data_align.o
   me@ubuntu ~/s/G/d/src> ./arm_data_align.o
   build_time: len 3 abc
   build_time: len 3 abc
