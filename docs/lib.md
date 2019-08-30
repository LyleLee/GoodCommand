静态库和动态库
================


# 编译静态库

下载以下文件到任意目录

[Makefile](src/static_lib/Makefile   )  
[driver.c](src/static_lib/driver.c   )  
[lib_mylib.c](src/static_lib/lib_mylib.c)  
[lib_mylib.h](src/static_lib/lib_mylib.h)  

```
make
```
生成的lib_mylib.a是静态链接库，生成的driver是静态链接的目标文件。 

使用静态库的方法：
把lib_mylib.a和lib_mylib.h拷贝到任意主机，在源文件中include lib_mylib.h即可使用fun函数 如driver.c:
```c
#include "lib_mylib.h"

void main()
{
        fun();
}
```
编译命令
```
gcc -o driver driver.c -L. -l_mylib
```
-L. 代表lib_mylib.a在当前路径，-l_mylib达标在-L指定的目录下查找lib_mylib.a


# 编译动态库

下载以下文件到任意目录

[makefile](src/share_lib/Makefile     )  
[application](src/share_lib/application.c)  
[lowcase](src/share_lib/lowcase.c    )

```
make
export LD_LIBRARY_PATH=$(pwd):$LD_LIBRARY_PATH
./app
```

生成的liblowcase.so是动态链接库。 生成的app是动态链接文件。使用ldd可以看到app有应用当前的路径。

```
[me@centos share_lib]$ ldd app
        linux-vdso.so.1 =>  (0x0000ffff8ef60000)
        liblowcase.so => /home/me/gsrc/share_lib/liblowcase.so (0x0000ffff8ef20000)
        libc.so.6 => /lib64/libc.so.6 (0x0000ffff8ed70000)
        /lib/ld-linux-aarch64.so.1 (0x0000ffff8ef70000)
```
使用动态链接库的方法，把liblowcase.so放到目录之后。编译指定路径和库。
设置环境变量，默认情况下，ld程序不回去搜索../code/路径，所以需要手动指定
```
gcc call_dynamic.c -L ../code/ -llowcase -o call
export LD_LIBRARY_PATH=../code/
./call
```

# 参考资料

[【静态库参考】https://www.geeksforgeeks.org/static-vs-dynamic-libraries/](https://www.geeksforgeeks.org/static-vs-dynamic-libraries/)

[【动态库参考】https://www.geeksforgeeks.org/working-with-shared-libraries-set-2/](https://www.geeksforgeeks.org/working-with-shared-libraries-set-2/)

