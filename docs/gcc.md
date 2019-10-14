编译安装GCC
=========================================
在[http://mirrors.ustc.edu.cn/gnu/gcc/](http://mirrors.ustc.edu.cn/gnu/gcc/) 找到对应版本源码  
安装步骤为：
```shell
wget http://mirrors.ustc.edu.cn/gnu/gcc/gcc-8.3.0/gcc-8.3.0.tar.gz
tar -zxf gcc-8.3.0.tar.gz
cd gcc-8.3.0/
.configure
make
make install
```
.configure 出现问题：
```shell-session
checking for gnatbind... no
checking for gnatmake... no
checking whether compiler driver understands Ada... no
checking how to compare bootstrapped objects... cmp --ignore-initial=16 $$f1 $$f2
checking for objdir... .libs
checking for the correct version of gmp.h... yes
checking for the correct version of mpfr.h... no
configure: error: Building GCC requires GMP 4.2+, MPFR 2.4.0+ and MPC 0.8.0+.
Try the --with-gmp, --with-mpfr and/or --with-mpc options to specify
their locations.  Source code for these libraries can be found at
their respective hosting sites as well as at
ftp://gcc.gnu.org/pub/gcc/infrastructure/.  See also
http://gcc.gnu.org/install/prerequisites.html for additional info.  If
you obtained GMP, MPFR and/or MPC from a vendor distribution package,
make sure that you have installed both the libraries and the header
files.  They may be located in separate packages.
```
原因是缺少依赖库。有一个安装脚本可以解决以来执行
```shell-session
root@ubuntu:~/1620-mount-point/gcc/gcc-8.3.0# ./contrib/download_prerequisites
2019-02-25 20:33:24 URL: ftp://gcc.gnu.org/pub/gcc/infrastructure/gmp-6.1.0.tar.bz2 [2383840] -> "./gmp-6.1.0.tar.bz2" [2]
2019-02-25 20:34:13 URL: ftp://gcc.gnu.org/pub/gcc/infrastructure/mpfr-3.1.4.tar.bz2 [1279284] -> "./mpfr-3.1.4.tar.bz2" [1]
2019-02-25 20:34:32 URL: ftp://gcc.gnu.org/pub/gcc/infrastructure/mpc-1.0.3.tar.gz [669925] -> "./mpc-1.0.3.tar.gz" [1]
2019-02-25 20:35:56 URL: ftp://gcc.gnu.org/pub/gcc/infrastructure/isl-0.18.tar.bz2 [1658291] -> "./isl-0.18.tar.bz2" [1]
gmp-6.1.0.tar.bz2: OK
mpfr-3.1.4.tar.bz2: OK
mpc-1.0.3.tar.gz: OK
isl-0.18.tar.bz2: OK
All prerequisites downloaded successfully.
```
重新执行./configure即可

# 查看GCC编译选项：
```
gcc -Q --help=target    #查询和target相关的编译选项
gcc -Q -v alpha.c       #查看编译某个文件的具体选项
```
# GCC 编译选项
```
-static                 #静态链接程序
-Wl,option              #把静态链接选项传递给连接器
```
# 参考资料
[redhat GCC command option](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/4/html/Using_the_GNU_Compiler_Collection/invoking-gcc.html)

https://cloud.tencent.com/developer/article/1433457
