编译选项static导致程序Sgmentation fault
****************************************

可以轻易使用tar2node复现：

::

   git clone https://github.com/LyleLee/tars2node.git
   git checkout static_segmentation_fault
   cd tars2node/build
   cmake ..
   make
   [user@centos build]$ ./tars2node
   Segmentation fault (core dumped)

定位过程
========

查阅资料发现pthread静态链接时会有问题，原因是pthread.a没有整个包含到目标程序当中。网上提示使用-Wl,–whole-archive。
但是仍然会有错误

.. code:: diff

    # flag
   -set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -g -O2 -Wall -Wno-sign-compare -Wno-unused-result -static")
   -set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -O2 -Wall -static")
   +set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -g -O2 -Wall -Wno-sign-compare -Wno-unused-result -static -Wl,--whole-archive")
   +set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -O2 -Wall -static -Wl,--whole-archive")

添加

::

   -Wl,--whole-archive

可以看到具体错误：

::

   /usr/lib/gcc/aarch64-redhat-linux/4.8.5/../../../../lib64/libc.a(s_signbitl.o): In function `__signbitl':
   (.text+0x0): multiple definition of `__signbitl'
   /usr/lib/gcc/aarch64-redhat-linux/4.8.5/../../../../lib64/libm.a(m_signbitl.o):(.text+0x0): first defined here
   /usr/lib/gcc/aarch64-redhat-linux/4.8.5/../../../../lib64/libc.a(mp_clz_tab.o):(.rodata+0x0): multiple definition of `__clz_tab'
   /usr/lib/gcc/aarch64-redhat-linux/4.8.5/libgcc.a(_clz.o):(.rodata+0x0): first defined here
   /usr/lib/gcc/aarch64-redhat-linux/4.8.5/../../../../lib64/libc.a(rcmd.o): In function `__validuser2_sa':
   (.text+0x54c): warning: Using 'getaddrinfo' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
   /usr/lib/gcc/aarch64-redhat-linux/4.8.5/../../../../lib64/libc.a(dl-conflict.o): In function `_dl_resolve_conflicts':
   (.text+0x28): undefined reference to `_dl_num_cache_relocations'
   /usr/lib/gcc/aarch64-redhat-linux/4.8.5/../../../../lib64/libc.a(dl-conflict.o): In function `_dl_resolve_conflicts':
   (.text+0x34): undefined reference to `_dl_num_cache_relocations'
   /usr/lib/gcc/aarch64-redhat-linux/4.8.5/../../../../lib64/libc.a(dl-conflict.o): In function `_dl_resolve_conflicts':
   (.text+0x48): undefined reference to `_dl_num_cache_relocations'
   collect2: error: ld returned 1 exit status
   make[2]: *** [tars2node] Error 1
   make[1]: *** [CMakeFiles/tars2node.dir/all] Error 2
   make: *** [all] Error 2
   [me@centos build]$
   [me@centos build]$

上面的报错，提示libm和libc中有重复定义的函数，
这个是让人很疑惑的，上网搜索，没有相关资料描述。
同时查询了_dl_num_cache_relocations，仍然没有线索，后来怀疑弱符号等原因，查阅了很多资料。
没有什么思路。

换个思维方式，只是想静态链接程序，什么错误先不管，如何才能正确地静态链接呢。最终找到了要想静态链接，不同编译器地选项是不一样的。

解决问题：

::

   [100%] Linking CXX executable tars2node
   /usr/bin/ld: cannot find -lgcc_s
   /usr/bin/ld: cannot find -lgcc_s
   collect2: error: ld returned 1 exit status
   make[2]: *** [tars2node] Error 1
   make[1]: *** [CMakeFiles/tars2node.dir/all] Error 2
   make: *** [all] Error 2

使用-static-libgcc -static-libstdc++编译选项可以消除这个报错

解决办法：
==========

一、使用动态链接库，去掉-static选项
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

编辑../CMakeList.txt取消-static

::

    # flag
   set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -g -O2 -Wall -Wno-sign-compare -Wno-unused-result -static")
   set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -O2 -Wall -static")

二、使用gcc/g++ 8.0及以上
~~~~~~~~~~~~~~~~~~~~~~~~~

升级办法参考\ `【devtoolset】 <../devtoolset.md>`__

三、使用低版本gcc如4.8.5
~~~~~~~~~~~~~~~~~~~~~~~~

::

   yum install glibc-static

使用-Wl,-Bdynamic编译选项

.. code:: diff

   # flag
   -set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -g -O2 -Wall -Wno-sign-compare -Wno-unused-result -static")
   -set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -O2 -Wall -static")
   +set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -g -O2 -Wall -Wno-sign-compare -Wno-unused-result -Wl,-Bdynamic")
   +set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -O2 -Wall -Wl,-Bdynamic")

相关资料
========

`【有一个项目再github中讨论的静态链接的情况】 <https://github.com/oatpp/oatpp/issues/32>`__
`【静态链接pthread库出现错误1】 <https://stackoverflow.com/questions/7090623/c0x-thread-static-linking-problem/31271886#31271886>`__
`【静态链接pthread库出现错误2】 <https://sourceware.org/bugzilla/show_bug.cgi?id=10652>`__
`【静态链接pthread库出现错误3】 <https://gcc.gnu.org/bugzilla/show_bug.cgi?id=52590>`__
`【有可能是编译器静态链接时弱符号的原因】 <https://akkadia.org/drepper/no_static_linking.html>`__
`【glibc静态链接和动态链接】 <https://blog.csdn.net/lianshaohua/article/details/82143337>`__
