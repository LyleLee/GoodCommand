***************
静态库和动态库
***************

编译静态库
==========

下载以下文件到任意目录

| `Makefile <src/static_lib/Makefile>`__
| `driver.c <src/static_lib/driver.c>`__
| `lib_mylib.c <src/static_lib/lib_mylib.c>`__
| `lib_mylib.h <src/static_lib/lib_mylib.h>`__

::

   make

生成的lib_mylib.a是静态链接库，生成的driver是静态链接的目标文件。

使用静态库的方法：
把lib_mylib.a和lib_mylib.h拷贝到任意主机，在源文件中include
lib_mylib.h即可使用fun函数 如driver.c:

.. code:: c

   #include "lib_mylib.h"

   void main()
   {
           fun();
   }

编译命令

::

   gcc -o driver driver.c -L. -l_mylib

-L.
代表lib_mylib.a在当前路径，-l_mylib达标在-L指定的目录下查找lib_mylib.a

编译动态库
==========

下载以下文件到任意目录

| `makefile <src/share_lib/Makefile>`__
| `application <src/share_lib/application.c>`__
| `lowcase <src/share_lib/lowcase.c>`__

::

   make
   export LD_LIBRARY_PATH=$(pwd):$LD_LIBRARY_PATH
   ./app

生成的liblowcase.so是动态链接库。
生成的app是动态链接文件。使用ldd可以看到app有应用当前的路径。

::

   [me@centos share_lib]$ ldd app
           linux-vdso.so.1 =>  (0x0000ffff8ef60000)
           liblowcase.so => /home/me/gsrc/share_lib/liblowcase.so (0x0000ffff8ef20000)
           libc.so.6 => /lib64/libc.so.6 (0x0000ffff8ed70000)
           /lib/ld-linux-aarch64.so.1 (0x0000ffff8ef70000)

使用动态链接库的方法，把liblowcase.so放到目录之后。编译指定路径和库。
设置环境变量，默认情况下，ld程序不回去搜索../code/路径，所以需要手动指定

::

   gcc call_dynamic.c -L ../code/ -llowcase -o call
   export LD_LIBRARY_PATH=../code/
   ./call

gcc 指定库文件和头文件
======================

“-I”（大写i），“-L”（大写l），“-l”（小写l）的区别
我们用gcc编译程序时，可能会用到“-I”（大写i），“-L”（大写l），“-l”（小写l）等参数，下面做个记录：

例：

::

   gcc -o hello hello.c -I /home/hello/include -L /home/hello/lib -lworld

上面这句表示在编译hello.c时：

-I
/home/hello/include表示将/home/hello/include目录作为第一个寻找头文件的目录，寻找的顺序是：/home/hello/include–>/usr/include–>/usr/local/includ

-L
/home/hello/lib表示将/home/hello/lib目录作为第一个寻找库文件的目录，寻找的顺序是：/home/hello/lib–>/lib–>/usr/lib–>/usr/local/lib

-lworld表示在上面的lib的路径中寻找libworld.so动态库文件（如果gcc编译选项中加入了“-static”表示寻找libworld.a静态库文件）

gcc -l参数和-L参数

-l参数就是用来指定程序要链接的库，-l参数紧接着就是库名，那么库名跟真正的库文件名有什么关系呢？就拿数学库来说，他的库名是m，他的库文件名是libm.so，很容易看出，把库文件名的头lib和尾.so去掉就是库名了。

如何让gcc在生成动态链接库的时候静态链接glibc
============================================

::

   $ gcc -fPIC -shared reload.c -o reload.so -nostdlib
   $ ldd reload.so
   statically linked

参考资料： https://www.bytelang.com/article/content/d3t3i7VmN2g=

参考资料
========

`【静态库参考】https://www.geeksforgeeks.org/static-vs-dynamic-libraries/ <https://www.geeksforgeeks.org/static-vs-dynamic-libraries/>`__

`【动态库参考】https://www.geeksforgeeks.org/working-with-shared-libraries-set-2/ <https://www.geeksforgeeks.org/working-with-shared-libraries-set-2/>`__
