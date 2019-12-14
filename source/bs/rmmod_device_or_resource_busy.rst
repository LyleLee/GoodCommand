******************************************
rmmod: ERROR: Device or resource busy
******************************************

问题现象是：在CentOS 7.7 上，编译module， insmod之后无法rmmod

.. code-block:: console

    [user1@centos fishing]$ sudo insmod fishing.ko
    [user1@centos fishing]$
    [user1@centos fishing]$ su root
    Password:
    [root@centos fishing]# lsmod | grep fishing.g
    [root@centos fishing]# lsmod | grep fishing
    fishing               262144  0
    [root@centos fishing]#
    [root@centos fishing]# rmmod fishing
    rmmod: ERROR: could not remove 'fishing': Device or resource busy
    rmmod: ERROR: could not remove module fishing: Device or resource busy
    [root@centos fishing]#

同样的代码在： ubuntu 18.04上是ok的

.. code-block:: console

    me@ubuntu:~/fishing$ sudo insmod fishing.ko
    me@ubuntu:~/fishing$ sudo rmmod fishing

同样的代码在： centos 7.6上也是OK的。


最终定位是， 编译kernel的gcc版本和编译module的gcc版本不一致导致的。 编译kernel的gcc版本是 8.3， 本地的gcc版本是4.85

.. code-block:: console

    [user1@centos ~]$ dmesg | grep gcc
    [    0.000000] Linux version 4.18.0-80.7.2.el7.aarch64 (mockbuild@aarch64-01.bsys.centos.org) (gcc version 8.3.1 20190311 (Red Hat 8.3.1-3) (GCC)) #1 SMP Thu Sep 12 16:13:20 UTC 2019
    [user1@centos ~]$ gcc -v
    Using built-in specs.
    COLLECT_GCC=gcc
    COLLECT_LTO_WRAPPER=/usr/libexec/gcc/aarch64-redhat-linux/4.8.5/lto-wrapper
    Target: aarch64-redhat-linux
    Configured with: ../configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --with-bugurl=http://bugzilla.redhat.com/bugzilla --enable-bootstrap --enable-shared --enable-threads=posix --enable-checking=release --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-gnu-unique-object --enable-linker-build-id --with-linker-hash-style=gnu --enable-languages=c,c++,objc,obj-c++,java,fortran,ada,lto --enable-plugin --enable-initfini-array --disable-libgcj --with-isl=/builddir/build/BUILD/gcc-4.8.5-20150702/obj-aarch64-redhat-linux/isl-install --with-cloog=/builddir/build/BUILD/gcc-4.8.5-20150702/obj-aarch64-redhat-linux/cloog-install --enable-gnu-indirect-function --build=aarch64-redhat-linux
    Thread model: posix
    gcc version 4.8.5 20150623 (Red Hat 4.8.5-39) (GCC)
    [user1@centos ~]$

如果反过来，编译kernel的gcc版本是4.85， 编译模块的版本是8.3，那么会出现模块也无法rmmod， 而且引用次数异常的情况

.. code-block:: console

    [root@localhost fishing]# gcc -v
    Using built-in specs.
    COLLECT_GCC=gcc
    COLLECT_LTO_WRAPPER=/usr/local/gcc-7.3.0/libexec/gcc/aarch64-linux/7.3.0/lto-wrapper
    Target: aarch64-linux
    Configured with: ./configure --prefix=/usr/local/gcc-7.3.0 --enable-languages=c,c++,fortran --enable-shared --enable-linker-build-id --without-included-gettext --enable-threads=posix --disable-multilib --disable-nls --disable-libsanitizer --disable-browser-plugin --enable-checking=release --build=aarch64-linux --with-gmp=/usr/local/gmp-6.1.2 --with-mpfr=/usr/local/mpfr-3.1.5 --with-mpc=/usr/local/mpc-1.0.3 --with-isl=/usr/local/isl-0.18
    Thread model: posix
    gcc version 7.3.0 (GCC)
    [root@localhost fishing]# date
    2019年 12月 13日 星期五 21:52:47 EST
    [root@localhost fishing]# dmesg |grep gcc
    [    0.000000] Linux version 4.14.0-115.el7a.0.1.aarch64 (mockbuild@aarch64-01.bsys.centos.org) (gcc version 4.8.5 20150623 (Red Hat 4.8.5-36) (GCC)) #1 SMP Sun Nov 25 20:54:21 UTC 2018

.. code-block:: console

    [root@localhost fishing]#
    [root@localhost fishing]# lsmod | grep fishing
    fishing               262144  19660798
    [root@localhost fishing]#



解决办法：

.. code-block:: console

    [root@centos fishing]# dmesg | grep gcc
    [    0.000000] Linux version 4.18.0-80.7.2.el7.aarch64 (mockbuild@aarch64-01.bsys.centos.org) (gcc version 8.3.1 20190311 (Red Hat 8.3.1-3) (GCC)) #1 SMP Thu Sep 12 16:13:20 UTC 2019
    [root@centos fishing]# gcc -v
    Using built-in specs.
    COLLECT_GCC=gcc
    COLLECT_LTO_WRAPPER=/opt/rh/devtoolset-8/root/usr/libexec/gcc/aarch64-redhat-linux/8/lto-wrapper
    Target: aarch64-redhat-linux
    Configured with: ../configure --enable-bootstrap --enable-languages=c,c++,fortran,lto --prefix=/opt/rh/devtoolset-8/root/usr --mandir=/opt/rh/devtoolset-8/root/usr/share/man --infodir=/opt/rh/devtoolset-8/root/usr/share/info --with-bugurl=http://bugzilla.redhat.com/bugzilla --enable-shared --enable-threads=posix --enable-checking=release --enable-multilib --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-gnu-unique-object --enable-linker-build-id --with-gcc-major-version-only --with-linker-hash-style=gnu --with-default-libstdcxx-abi=gcc4-compatible --enable-plugin --enable-initfini-array --with-isl=/builddir/build/BUILD/gcc-8.3.1-20190311/obj-aarch64-redhat-linux/isl-install --disable-libmpx --enable-gnu-indirect-function --build=aarch64-redhat-linux
    Thread model: posix
    gcc version 8.3.1 20190311 (Red Hat 8.3.1-3) (GCC)
    [root@centos fishing]#
