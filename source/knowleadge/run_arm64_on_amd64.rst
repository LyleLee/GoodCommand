************************************
在x86上编译和运行arm64程序
************************************

在x86上交叉编译出arm64程序
------------------------------------

有时候我们只有x86环境， 想要编译出arm64的目标二进制。这个时候需要交叉编译工具， 交叉编译工具的安装有很多种。这里选择

::

    docker run --rm  dockcross/linux-arm64 > ./dockcross-linux-arm64
    dockcross-linux-arm64 bash -c '$CC hello_world_c.c -o hello_arm64 -static'

查看编译结果

::

    user1@intel6248:~/hello_world_c$ file hello_arm64
    hello_arm64: ELF 64-bit LSB executable, ARM aarch64, version 1 (GNU/Linux), statically linked, for GNU/Linux 4.10.8, with debug_info, not stripped


一般情况下执行会出错。 因为平台是x86的， 但是目标文件是arm64的。

::

    ./hello_arm64
    -bash: ./hello_arm64: cannot execute binary file: Exec format error


arm64目标程序在x86平台上运行
------------------------------------

::

    docker run --rm --privileged multiarch/qemu-user-static --reset -p yes


一段C程序
----------------

.. code-block:: c

    #include <stdio.h>

    int main()
    {
            printf("hello world c\n");
    }

编译后拷贝到其他设备X86上运行，也可以用前面编译出来的hello_world, 注意编译要带 `-static`,要不然会因为x86主机上没有ARM上的ld解释器，c库导致报错

::

    gcc -o hello_world_c -static hello_world_c.c

.. code-block:: console

    user1@intel:~$ uname -m
    x86_64
    user1@intel:~$ file hello_world_c
    hello_world_c: ELF 64-bit LSB executable, ARM aarch64, version 1 (GNU/Linux), statically linked, for GNU/Linux 3.7.0, BuildID[sha1]=58b303f958cea549f2333edbc6e5e6ea56aa476f, not stripped
    user1@intel:~$ ./hello_world_c
    hello world c


一段Go程序
--------------

.. code-block:: go

    package main

    import "fmt"

    func main(){
            fmt.Println("hello world go")
    }


编译后拷贝到其他设备X86上运行,

::

    go build -o hello_world_go .

.. code-block:: console

    user1@intel6248:~$ uname -m
    x86_64
    user1@intel6248:~$ file hello_world_go
    hello_world_go: ELF 64-bit LSB executable, ARM aarch64, version 1 (SYSV), statically linked, not stripped
    user1@intel6248:~$
    user1@intel6248:~$ ./hello_world_go
    hello world go


.. [#qemu_static] https://github.com/multiarch/qemu-user-static
