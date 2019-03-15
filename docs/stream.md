stream 评估内存性能
=========================
stream是内存性能评估的工业标准之一，工具现由弗吉尼亚计算机系维护。

官方指导：  [教程](https://www.cs.virginia.edu/stream/ref.html)  

## 下载源码
这里以C源码为例。
```
wget https://www.cs.virginia.edu/stream/FTP/Code/stream.c
```
完整的项目代码，请访问 [链接](https://www.cs.virginia.edu/stream/FTP/Code/)
## 编译
```shell-session
gcc -O stream.c -o stream
```
## 执行
```
./stream
```
## ARM服务器执行结果
```shell-session
me@ubuntu:~/stream$ ./stream
-------------------------------------------------------------
STREAM version $Revision: 5.10 $
-------------------------------------------------------------
This system uses 8 bytes per array element.
-------------------------------------------------------------
Array size = 10000000 (elements), Offset = 0 (elements)
Memory per array = 76.3 MiB (= 0.1 GiB).
Total memory required = 228.9 MiB (= 0.2 GiB).
Each kernel will be executed 10 times.
 The *best* time for each kernel (excluding the first iteration)
 will be used to compute the reported bandwidth.
-------------------------------------------------------------
Your clock granularity/precision appears to be 1 microseconds.
Each test below will take on the order of 17729 microseconds.
   (= 17729 clock ticks)
Increase the size of the arrays if this shows that
you are not getting at least 20 clock ticks per test.
-------------------------------------------------------------
WARNING -- The above is only a rough guideline.
For best results, please be sure you know the
precision of your system timer.
-------------------------------------------------------------
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:           10266.2     0.015629     0.015585     0.015700
Scale:          10588.2     0.015190     0.015111     0.015333
Add:            11421.5     0.021111     0.021013     0.021220
Triad:          11416.0     0.021077     0.021023     0.021138
-------------------------------------------------------------
Solution Validates: avg error less than 1.000000e-13 on all three arrays
-------------------------------------------------------------
me@ubuntu:~/stream$
```

## ARM服务器执行结果分析

根据[设备内存信息](meminfo.md)  
内存频率是Speed: 2400 MT/s  
数据位宽是64bit  
每个内存条的理论带宽是：`2400M * 64bit = 153600 Mbit/s = 19200 MB/s = 18.75 GB/s`
stream测出的系统可用带宽是：11416.0，与理论带宽存在较大差距。仍需要分析差距原因。

## ARM树莓派执行结果
树莓派总内存大小为1GB，内存频率没有标明
```shell-session
pi@raspberrypi:~/app/stream $ ./stream
-------------------------------------------------------------
STREAM version $Revision: 5.10 $
-------------------------------------------------------------
This system uses 8 bytes per array element.
-------------------------------------------------------------
Array size = 10000000 (elements), Offset = 0 (elements)
Memory per array = 76.3 MiB (= 0.1 GiB).
Total memory required = 228.9 MiB (= 0.2 GiB).
Each kernel will be executed 10 times.
 The *best* time for each kernel (excluding the first iteration)
 will be used to compute the reported bandwidth.
-------------------------------------------------------------
Your clock granularity/precision appears to be 1 microseconds.
Each test below will take on the order of 114310 microseconds.
   (= 114310 clock ticks)
Increase the size of the arrays if this shows that
you are not getting at least 20 clock ticks per test.
-------------------------------------------------------------
WARNING -- The above is only a rough guideline.
For best results, please be sure you know the
precision of your system timer.
-------------------------------------------------------------
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:            2030.0     0.079971     0.078817     0.083276
Scale:           2030.5     0.080576     0.078797     0.084133
Add:             1912.1     0.126776     0.125519     0.129104
Triad:           1652.5     0.145481     0.145232     0.145794
-------------------------------------------------------------
Solution Validates: avg error less than 1.000000e-13 on all three arrays
-------------------------------------------------------------
```
## x86 PC执行结果
```
root@SZX:~/working/stream# ./stream
-------------------------------------------------------------
STREAM version $Revision: 5.10 $
-------------------------------------------------------------
This system uses 8 bytes per array element.
-------------------------------------------------------------
Array size = 10000000 (elements), Offset = 0 (elements)
Memory per array = 76.3 MiB (= 0.1 GiB).
Total memory required = 228.9 MiB (= 0.2 GiB).
Each kernel will be executed 10 times.
 The *best* time for each kernel (excluding the first iteration)
 will be used to compute the reported bandwidth.
-------------------------------------------------------------
Your clock granularity/precision appears to be 1 microseconds.
Each test below will take on the order of 14092 microseconds.
   (= 14092 clock ticks)
Increase the size of the arrays if this shows that
you are not getting at least 20 clock ticks per test.
-------------------------------------------------------------
WARNING -- The above is only a rough guideline.
For best results, please be sure you know the
precision of your system timer.
-------------------------------------------------------------
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:            7528.7     0.024472     0.021252     0.027480
Scale:           7773.3     0.024656     0.020583     0.028275
Add:             7866.3     0.034299     0.030510     0.036829
Triad:           8017.6     0.035185     0.029934     0.038185
-------------------------------------------------------------
Solution Validates: avg error less than 1.000000e-13 on all three arrays
-------------------------------------------------------------
root@SZX:~/working/stream# 
```
## x86 服务器执行结果
```
me@Board:~/stream$ ./stream
-------------------------------------------------------------
STREAM version $Revision: 5.10 $
-------------------------------------------------------------
This system uses 8 bytes per array element.
-------------------------------------------------------------
Array size = 10000000 (elements), Offset = 0 (elements)
Memory per array = 76.3 MiB (= 0.1 GiB).
Total memory required = 228.9 MiB (= 0.2 GiB).
Each kernel will be executed 10 times.
 The *best* time for each kernel (excluding the first iteration)
 will be used to compute the reported bandwidth.
-------------------------------------------------------------
Your clock granularity/precision appears to be 1 microseconds.
Each test below will take on the order of 26998 microseconds.
   (= 26998 clock ticks)
Increase the size of the arrays if this shows that
you are not getting at least 20 clock ticks per test.
-------------------------------------------------------------
WARNING -- The above is only a rough guideline.
For best results, please be sure you know the
precision of your system timer.
-------------------------------------------------------------
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:            8830.0     0.018140     0.018120     0.018157
Scale:           8800.5     0.018211     0.018181     0.018317
Add:             9812.8     0.024520     0.024458     0.024679
Triad:           9722.5     0.024715     0.024685     0.024746
-------------------------------------------------------------
Solution Validates: avg error less than 1.000000e-13 on all three arrays
-------------------------------------------------------------
me@Board:~/stream$ lscpu
```

## 静态数组内存大小限制
当设置的数组大小比较大时，编译器会给出报警。
```
[root@localhost stream]# gcc -DSTREAM_ARRAY_SIZE=100000000  stream.c -o option_no_100M_stream
/tmp/ccTzV1dQ.o: In function `main':
stream.c:(.text+0x546): relocation truncated to fit: R_X86_64_32S against `.bss'
stream.c:(.text+0x57a): relocation truncated to fit: R_X86_64_32S against `.bss'
stream.c:(.text+0x5f9): relocation truncated to fit: R_X86_64_32S against `.bss'
stream.c:(.text+0x62e): relocation truncated to fit: R_X86_64_32S against `.bss'
stream.c:(.text+0x65e): relocation truncated to fit: R_X86_64_32S against `.bss'
stream.c:(.text+0x6a0): relocation truncated to fit: R_X86_64_32S against `.bss'
stream.c:(.text+0x6b9): relocation truncated to fit: R_X86_64_32S against `.bss'
stream.c:(.text+0x6c5): relocation truncated to fit: R_X86_64_32S against `.bss'
stream.c:(.text+0x6dd): relocation truncated to fit: R_X86_64_32S against `.bss'
collect2: error: ld returned 1 exit status
[root@localhost stream]#
```
解决办法是添加编译选项
```
-mcmodel=medium
```
