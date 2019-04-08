评估CPU性能
==========
使用工具：speccpu2006.tar.gz  
大小：1.6G  
md5：b8e9b60e983fcde668c80e50fe01868c    

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

## 执行

```shell
su root
. ./shrc

```

./runspec -c ../config/lemon-2cpu.cfg 450 --rate 1 -noreportable  
./runspec -c ../config/lemon-2cpu.cfg 450 --rate 1 -noreportable  
./runspec -c ../config/lemon-2cpu.cfg 400 --rate 1 -noreportable  

2019年1月31日11:27:26有一个用例失败，后面继续
speccpu2006
me@ubuntu:~/kylin_test/speccpu2006/benchspec/CPU2006/416.gamess/run/run_base_test_gcc43-64bit.0000$ vim exam29.out.mis


CXXPORTABILITY = -std=c++03