ARM 服务器更新固件
========================
更新固件可以解决lscpu显示不正确问题，如socket和cache大小。


## 更新之前
```shell-session
root@ubuntu:~# lscpu
Architecture:        aarch64
Byte Order:          Little Endian
CPU(s):              64
On-line CPU(s) list: 0-63
Thread(s) per core:  1
Core(s) per socket:  4
Socket(s):           16
NUMA node(s):        4
Vendor ID:           ARM
Model:               2
Model name:          Cortex-A72
Stepping:            r0p2
BogoMIPS:            100.00
NUMA node0 CPU(s):   0-15
NUMA node1 CPU(s):   16-31
NUMA node2 CPU(s):   32-47
NUMA node3 CPU(s):   48-63
Flags:               fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
root@ubuntu:~#
```
## 更新之后
```shell-session
root@ubuntu:~# lscpu
Architecture:        aarch64
Byte Order:          Little Endian
CPU(s):              64
On-line CPU(s) list: 0-63
Thread(s) per core:  1
Core(s) per socket:  32
Socket(s):           2
NUMA node(s):        4
Vendor ID:           ARM
Model:               2
Model name:          Cortex-A72
Stepping:            r0p2
BogoMIPS:            100.00
L1d cache:           32K
L1i cache:           48K
L2 cache:            1024K
L3 cache:            16384K
NUMA node0 CPU(s):   0-15
NUMA node1 CPU(s):   16-31
NUMA node2 CPU(s):   32-47
NUMA node3 CPU(s):   48-63
Flags:               fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
root@ubuntu:~#
```

## 更新办法
查看当前固件版本  
浏览器iBMC界面→系统管理→更新固件

```
Primary Partition Image Version :   2.45
Backup  Partition Image Version :   2.40
BIOS Version                    :   1.34
CPLD Version                    :   1.05
```

到服务器官网下载新版本固件，例如：
[网址](https://support.huawei.com/enterprise/zh/servers/taishan-2280-pid-21941616/software/23276347?idAbsPath=fixnode01%7C7919749%7C9856522%7C9856629%7C21941616)  
需要下载iBMC，BIOS，CDLP三个压缩包。
解压后在浏览器界面  
浏览器iBMC界面→系统管理→更新固件  
依次上传，并点击升级，每个固件升级需要几分钟，升级成功会有提示。

升级成功后
```
Primary Partition Image Version :   3.22
Backup  Partition Image Version :   2.45
BIOS Version                    :   1.58
CPLD Version                    :   1.05
```
CPLD升级不成功，是因为服务器版本太低。


