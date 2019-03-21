使用fio测试硬盘的IO性能
===============
常用测试硬盘性能的工具有fio和vdbench。  
fio的介绍安装请查看[fio](fio.md)  
vdbench的介绍和安装请查看[vdbench](vdbench.md)

通常，我们认为普通机械硬盘的吞吐量是100MB/s [[参考]](https://hdd.userbenchmark.com/#)，固态硬盘的吞吐量是200MB/s
## x86服务器

### cpu
```
ubuntu@ubuntu:~$ lscpu
Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
CPU(s):              64
On-line CPU(s) list: 0-63
Thread(s) per core:  2
Core(s) per socket:  16
Socket(s):           2
NUMA node(s):        2
Vendor ID:           GenuineIntel
CPU family:          6
Model:               79
Model name:          Intel(R) Xeon(R) CPU E5-2697A v4 @ 2.60GHz
Stepping:            1
CPU MHz:             2598.100
CPU max MHz:         2600.0000
CPU min MHz:         1200.0000
BogoMIPS:            5188.28
Virtualization:      VT-x
L1d cache:           32K
L1i cache:           32K
L2 cache:            256K
L3 cache:            40960K
NUMA node0 CPU(s):   0-15,32-47
NUMA node1 CPU(s):   16-31,48-63
```

### 硬盘
```
=== START OF INFORMATION SECTION ===
Vendor:               HUAWEI
Product:              HWE32SS3008M001N
Revision:             2774
Compliance:           SPC-4
User Capacity:        800,166,076,416 bytes [800 GB]
Logical block size:   512 bytes
Physical block size:  4096 bytes
LU is resource provisioned, LBPRZ=1
Rotation Rate:        Solid State Device
Form Factor:          2.5 inches
Logical Unit id:      0x5d0efc1ec8047002
Serial number:        2102311TNB10J8000371
Device type:          disk
Transport protocol:   SAS (SPL-3)
Local Time is:        Fri Mar 15 18:00:41 2019 CST
SMART support is:     Available - device has SMART capability.
SMART support is:     Enabled
Temperature Warning:  Enabled
```

###
不确定raid卡是否对测试有影响：
```
SAS3108
SAS 12G
支持条带大小范围是 64 KB ~ 1 MB
```
两个硬盘，都是raid0，分别添加到两个逻辑盘当中

### 软件

OS:     18.04.2 LTS (Bionic Beaver)  
内核:   Linux ubuntu 4.15.0-46-generic  
fio:    fio-3.13


### 测试结果
使用如下命令，仅改变filename、numbjobs、iodepth、rw、bs
```shell
fio --ramp_time=5 --runtime=15 --size=20g --ioengine=libaio --filename=/dev/sdb --name=4k-read-64-64 --numjobs=64 --iodepth=64 --rw=read --bs=4k --direct=1 --group_report 
```
测试脚本如下：

[/src/io_all.sh](resources/io_all.sh)

测试log如下：  
[x86](resources/x86_fio_simple.txt)  
[ARM](resources/arm_fio_simple.txt)

这个测试还有影响测试的因素，一个前后两个测试之间还有影响， 导致手动执行时结果更好。
测试时间较短，可靠行不足。
可以考虑绑核以提升性能

指定`--size 20g` 或者10g，测试结果偏好，应该只指定runtime更接近真实情况。

### 绑核的影响

绑核性能可以提升一倍。
测试命令
```shell
numactl -C 0-7 -m 0 fio -name=iops -rw=read -bs=4k -runtime=1000 -iodepth=64 -numjobs=8 -filename=/dev/sdc -ioengine=libaio -direct=1 -group_reporting
fio -name=iops -rw=read -bs=4k -runtime=1000 -iodepth=64 -numjobs=8 -filename=/dev/sdc -ioengine=libaio -direct=1 -group_reporting
```


### numa的影响
使用如下命令观察numactl设置对测试结果的影响
```shell
numactl -C 0-7 -m 0 fio --name=iops --rw=read --bs=4k --runtime=60 --iodepth=64 --numjobs=8 --filename=/dev/sdc --ioengine=libaio --direct=1 --group_reporting
numactl -C 48-56 -m 1 fio --name=iops --rw=read --bs=4k --runtime=60 --iodepth=64 --numjobs=8 --filename=/dev/sdc --ioengine=libaio --direct=1 --group_reporting
```
测试结果，前面的CPU测试结果偏好，内存区域0测试结果较好
```
32-40 -m 0 674
32-40 -m 1 665
32-40 -m 2 655
32-40 -m 3 630

48-56 -m 0 515
48-56 -m 1 543
48-56 -m 2 495
48-56 -m 3 540
```

### 选项`--size`的影响
不建议设置size，因为fio会尝试对指定size的文件或者硬盘进行这个区域内的循环读写。裸盘测试不建议设置size。

### hdparm -t可以简单对硬盘进行测试，测试结果待分析
```
sudo hdparm -t /dev/sdc

/dev/sdc:
 Timing buffered disk reads: 782 MB in  3.01 seconds = 260.07 MB/sec
```

