.. _glibc:

*******************
glibc
*******************

编译安装glibc [#glibc_source_code]_

::

   tar -zxf glibc-2.30.tar.gz


   cd glibc-2.30/build/
   scl enable devtoolset-8 bash
   ../configure --prefix=/home/user1/install-dir
   make -j96
   make install

有时候需要安装比较高版本的make 和python



替换glibc之后出现补救办法

.. code-block:: shell

    LD_PRELOAD=/lib64/libc-2.5.so  ln -s /lib64/libc-2.5.so /lib64/libc.so.6

.. [#glibc_source_code] Glibc源码仓库 https://sourceware.org/git/?p=glibc.git;a=tree
