glibc
==============
编译安装glibc

```
tar -zxf glibc-2.30.tar.gz


cd glibc-2.30/build/
scl enable devtoolset-8 bash
../configure --prefix=/home/user1/install-dir
make -j96
make install

```
有时候需要安装比较高版本的make 和python

