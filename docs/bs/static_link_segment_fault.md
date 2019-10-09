编译选项static导致程序崩溃
============================

可以轻易使用tar2node复现：
```
git clone https://github.com/LyleLee/tars2node.git
git checkout static_segmentation_fault
cd tars2node/build
cmake ..
make
[user@centos build]$ ./tars2node
Segmentation fault (core dumped)
```

# 定位过程
```diff
 # flag
-set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -g -O2 -Wall -Wno-sign-compare -Wno-unused-result -static")
-set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -O2 -Wall -static")
+set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -g -O2 -Wall -Wno-sign-compare -Wno-unused-result -static -Wl,--whole-archive")
+set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -O2 -Wall -static -Wl,--whole-archive")
```
添加
```
-Wl,--whole-archive
```
可以看到具体错误：
```
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
```



# 解决办法：

### 一、使用动态链接库，去掉-static选项
编辑../CMakeList.txt取消-static
```
 # flag
-set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -g -O2 -Wall -Wno-sign-compare -Wno-unused-result -static")
-set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -O2 -Wall -static")
```

### 二、使用gcc/g++ 8.0及以上

参考[【devtoolset】](../devtoolset.md)


相关资料

[描述最清楚的解释](https://gcc.gnu.org/bugzilla/show_bug.cgi?id=52590)
[【有一个项目再github中讨论的静态链接的情况】](https://github.com/oatpp/oatpp/issues/32)
[【静态链接pthread库的时候会出现】](https://stackoverflow.com/questions/7090623/c0x-thread-static-linking-problem/31271886#31271886)
[【有可能是编译器静态链接时弱符号的原因】](https://akkadia.org/drepper/no_static_linking.html)

