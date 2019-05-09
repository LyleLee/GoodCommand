评估CPU性能
==========
使用工具：speccpu2006.tar.gz  
大小：1.6G  
md5：b8e9b60e983fcde668c80e50fe01868c    

## 步骤

```shell
#安装,不安装也可以执行，需要引用bin目录的路径
./install.sh
#设置环境
su root
. ./shrc
#执行
./runspec -c ../config/lemon-2cpu.cfg 450 --rate 1 -noreportable  
./runspec -c ../config/lemon-2cpu.cfg 450 --rate 1 -noreportable  
./runspec -c ../config/lemon-2cpu.cfg 400 --rate 1 -noreportable  
```

在ARM服务器上安装会遇到
```CS
We do not appear to have working vendor-supplied binaries for your
architecture.  You will have to compile the tool binaries by
yourself.  Please read the file

    /home/me/syncfile/cputool/speccpu2006/Docs/tools-build.html

for instructions on how you might be able to build them.

Please only attempt this as a last resort.
```
也就是没有预编译好的二进制文件可以安装，需要我们自行编译
同时在"tools/bin/"也可以看到哪些体系结果有编译好的二进制用于安装。
```
me@ubuntu:~/syncfile/cputool/speccpu2006$ ls tools/bin/
aix5L-ppc    hpux11iv31-parisc  irix6.5-mips        linux-redhat72-ia32  linux-sles9-ia64    linux-suse10-ia32   macosx      solaris10-sparc  solaris-sparc  tru64-alpha
aix5L-ppc64  hpux11iv3-ipf      linux-debian31-ppc  linux-rhas4r4-ia64   linux-suse10-amd64  linux-suse10-ppc64  macosx-ppc  solaris10-x86    solaris-x86    windows-i386
```

执行编译
```
cd tools/src/
/buildtools
```
如果编译失败，考虑安装依赖或者解决报错
```shell
install_depency_ubuntu() {
	apt install build-essential
	apt install m4
}

install_depency_centos() {
	yum install -y gcc gcc-c++ gcc-gfortran numactl
}
```
编译成功后，切换回根目录source shrc ，这个和 `. ./shrc`等效
```shell
source shrc
./bin/runspec -c d05-2cpu.cfg 400 --rate 1 --noreport
```
单个测试需要使用--noreport参数，否则会出现报错：
```
Individual benchmark selection is not allowed for a reportable run
```


2019年1月31日11:27:26有一个用例失败，后面继续


CXXPORTABILITY = -std=c++03


##编译报错：__alloca问题
```
glob.c:(.text+0x520): undefined reference to `__alloca'
```
详细错误信息请查看；[[spec cpu 2006编译报错]](resources/spec_cpu_compile_error.md)
解决办法
修改 ./cpu2006/tools/src/make-3.82/glob/glob.c
```c
#if !defined __alloca && !defined __GNU_LIBRARY__
//变为
#if !defined __alloca && defined __GNU_LIBRARY__
```
编译指导
http://3ms.huawei.com/hi/group/3554771/thread_7121335.html?mapId=8867515&for_statistic_from=my_Replies_group_forum

##执行报错：Individual benchmark selection is not allowed for a reportable run
```
```
