ARM 和 x86中的编码区别
======================

1. char在X86上默认是有符号数，在ARM上默认是无符号数


char变量在x86架构下为signed char，在ARM64平台为unsignedchar。
x86代码移植到ARM时，时需要指定char为signed
char。使用编译选项“-fsigned-char”

在ARM上的运行结果是,输出吧-10当成了一个无符号数

::

   [me@centos86 ~]$ gcc defaut_char_type.c
   [me@centos transplant]$ ./a.out
   246:f6

在X86上的运行结果是，输出把-10当成了有符号数

::

   [me@centos86 ~]$ ./a.out
   -10:fffffff6

在ARM上使用-fsigned-char把char当成有符号数处理，两者结果一致。

::

   [me@centos transplant]$ gcc default_char_type.c -fsigned-char
   [me@centos transplant]$ ./a.out
   -10:fffffff6

-10的原码是： 1000 1010

-10的反码是： 1111 0101 求负数的反码，符号位不变，其他位取反

-10的补码是： 1111 0110 (f6) 补码等于反码加1
