**************************
在x86上运行arm64程序
**************************

在arm64平台上编译出目标程序，在x86平台上运行

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

编译后拷贝到其他设备X86上运行, 注意编译要带 `-static`,要不然回因为x86主机上没有ARM上的ld解释器，c库导致报错

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
