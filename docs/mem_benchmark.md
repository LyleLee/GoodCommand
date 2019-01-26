评估内存性能
======
使用工具： [stream](https://www.cs.virginia.edu/stream/)  
官方指导：  [教程](https://www.cs.virginia.edu/stream/ref.html)  
stream是内存性能评估的工业标准之一，工具现由弗吉尼亚计算机系维护。
## 下载源码
这里以C源码为例。
```
wget https://www.cs.virginia.edu/stream/FTP/Code/stream.c
```
完整的项目代码，请访问 [链接](https://www.cs.virginia.edu/stream/FTP/Code/)
## 编译
```
gcc -O stream.c -o stream
```
## 执行
```
./stream
```
## 执行结果
```
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

## 内存大小

获取设备内存硬件信息：最大支持**512**GB，最大支持16个内存
```
me@ubuntu:~/stream$ sudo dmidecode -t memory
[sudo] password for me:
# dmidecode 3.1
Getting SMBIOS data from sysfs.
SMBIOS 3.0.0 present.

Handle 0x0007, DMI type 16, 23 bytes
Physical Memory Array
        Location: System Board Or Motherboard
        Use: System Memory
        Error Correction Type: None
        Maximum Capacity: 512 GB
        Error Information Handle: Not Provided
        Number Of Devices: 16
```
1 内存条 0x0009
```
Handle 0x0009, DMI type 17, 40 bytes
Memory Device
        Array Handle: 0x0007
        Error Information Handle: Not Provided
        Total Width: 72 bits
        Data Width: 64 bits
        Size: 32 GB
        Form Factor: DIMM
        Set: None
        Locator: DIMM000 J11
        Bank Locator: SOCKET 0 CHANNEL 0 DIMM 0
        Type: DDR4
        Type Detail: Synchronous Registered (Buffered)
        Speed: 2400 MT/s
        Manufacturer: Samsung
        Serial Number: 0x351254BC
        Asset Tag: 1709
        Part Number: M393A4K40BB1-CRC
        Rank: 2
        Configured Clock Speed: 2400 MT/s
        Minimum Voltage: 1.2 V
        Maximum Voltage: 2.0 V
        Configured Voltage: 1.2 V
```
2 内存条 0x000D
```
Handle 0x000D, DMI type 17, 40 bytes
Memory Device
        Array Handle: 0x0007
        Error Information Handle: Not Provided
        Total Width: 72 bits
        Data Width: 64 bits
        Size: 32 GB
        Form Factor: DIMM
        Set: None
        Locator: DIMM020 J5
        Bank Locator: SOCKET 0 CHANNEL 2 DIMM 0
        Type: DDR4
        Type Detail: Synchronous Registered (Buffered)
        Speed: 2400 MT/s
        Manufacturer: Samsung
        Serial Number: 0x35125985
        Asset Tag: 1709
        Part Number: M393A4K40BB1-CRC
        Rank: 2
        Configured Clock Speed: 2400 MT/s
        Minimum Voltage: 1.2 V
        Maximum Voltage: 2.0 V
        Configured Voltage: 1.2 V
```
3 内存条 0x0011
```
Handle 0x0011, DMI type 17, 40 bytes
Memory Device
        Array Handle: 0x0007
        Error Information Handle: Not Provided
        Total Width: 72 bits
        Data Width: 64 bits
        Size: 32 GB
        Form Factor: DIMM
        Set: None
        Locator: DIMM100 J23
        Bank Locator: SOCKET 1 CHANNEL 0 DIMM 0
        Type: DDR4
        Type Detail: Synchronous Registered (Buffered)
        Speed: 2400 MT/s
        Manufacturer: Samsung
        Serial Number: 0x351258E0
        Asset Tag: 1709
        Part Number: M393A4K40BB1-CRC
        Rank: 2
        Configured Clock Speed: 2400 MT/s
        Minimum Voltage: 1.2 V
        Maximum Voltage: 2.0 V
        Configured Voltage: 1.2 V
```
4 内存条 0x0015
```
Handle 0x0015, DMI type 17, 40 bytes
Memory Device
        Array Handle: 0x0007
        Error Information Handle: Not Provided
        Total Width: 72 bits
        Data Width: 64 bits
        Size: 32 GB
        Form Factor: DIMM
        Set: None
        Locator: DIMM120 J17
        Bank Locator: SOCKET 1 CHANNEL 2 DIMM 0
        Type: DDR4
        Type Detail: Synchronous Registered (Buffered)
        Speed: 2400 MT/s
        Manufacturer: Samsung
        Serial Number: 0x35125924
        Asset Tag: 1709
        Part Number: M393A4K40BB1-CRC
        Rank: 2
        Configured Clock Speed: 2400 MT/s
        Minimum Voltage: 1.2 V
        Maximum Voltage: 2.0 V
        Configured Voltage: 1.2 V
```
一共4个内存条， 每一个都是32GB，2400MT/s, DDR4。所以可用内存是4*32=128GB,用命令看到的结果是128655MB。
```
me@ubuntu:~/stream$ free -m
              total        used        free      shared  buff/cache   available
Mem:         128665       31887        2905           3       93873       95806
Swap:          2047          91        1956
me@ubuntu:~/stream$ free -mh
              total        used        free      shared  buff/cache   available
Mem:           125G         31G        2.8G        3.1M         91G         93G
Swap:          2.0G         91M        1.9G
me@ubuntu:~/syslog$ free -b
              total        used        free      shared  buff/cache   available
Mem:    134915833856 33471602688   617598976     3317760 100826632192 100424712192
Swap:    2147479552    96468992  2051010560

```
物理内存
```
128G =128*2^30 B = 137438953472  
```
free 命令可以看到的，应用程序可使用内存为
```
125G = 134915833856 B, 
```
两者相差
```
137438953472 - 134915833856 = 2523119616 B = 2.34 GB
```
相差内存查阅资料提示：bios会占用一部分， 内核会预留一部分，需要进一步分析

## 内存速率

4个内存条，都标识`2400MT/s`。 `MT/s`指的是`MegaTransfers per second` ，每秒万兆次传输。和时钟频率单位是两码事， 因为一个时钟周期内可能发生两次传输。
内存条的数据位宽是64bit，所以每个内存条的理论带宽是： 
```
2400M * 64bit = 153600 Mbit/s = 19200 MB/s = 18.75 GB/s
```
stream测出的内存带宽是`11416.0 MB/s`，是应用程序获得的可持续带宽, 和单条内存的理论贷款还是有差距，并且内存条可以组成多通道，应该可获得的带宽要大于单条内存的带宽
