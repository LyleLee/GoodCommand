gmake
===============
编译安装gmake

```
wget http://ftp.gnu.org/gnu/make/make-4.2.tar.gz
tar -zxf make-4.2.tar.gz
cd make-4.2
mkdir build
cd build
../configure --prefix=/home/sjtu_chifei/lxf/toolcollect/
make -j64
make install
```