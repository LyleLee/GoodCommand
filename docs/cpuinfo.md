解读cpu信息
===========
详细了解某一台设备的cpu信息。可以使用查询文件`/proc/cpuinfo`,使用工具lscpu或者demidecode。同时选取了多种设备进行对比。
```
总核数（总逻辑核数）= 物理CPU个数 × 每颗物理CPU的核数 × 超线程数
```
# 一台普通PC

## lscpu
```shell-session
root@ubuntu:~# lscpu
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                4
On-line CPU(s) list:   0-3
Thread(s) per core:    1
Core(s) per socket:    4
Socket(s):             1
NUMA node(s):          1
Vendor ID:             GenuineIntel
CPU family:            6
Model:                 62
Model name:            Intel(R) Xeon(R) CPU E5-2690 v2 @ 3.00GHz
Stepping:              4
CPU MHz:               3000.112
BogoMIPS:              6000.22
Hypervisor vendor:     Xen
Virtualization type:   full
L1d cache:             32K
L1i cache:             32K
L2 cache:              256K
L3 cache:              25600K
NUMA node0 CPU(s):     0-3
Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx rdtscp lm constant_tsc rep_good n
opl eagerfpu pni pclmulqdq ssse3 cx16 pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm fsgsbase smep erms xsaveopt
```
```console
CPU(s):                4 总核数4 或者 逻辑核数4  对应cpuinfo中的processor编号
Socket(s):             1 物理核一共有1个         对应cpuinfo中的physical id
Core(s) per socket:    4 每个物理核封装4个核心   对应cpuinfo中的cpu cores
Thread(s) per core:    1 每个核心开启1个线程，没有超线程 对应cpuinfo中的siblings = cpu cores × 超线程数 
```
总核数（逻辑核数）4 = 物理核数1 × 每个物理封装核心4 × 1超线程 

## /proc/cpuinfo
查看物理CPU个数`1`
```shell-session
root@ubuntu:~# cat /proc/cpuinfo | grep "physical id" | sort | uniq | wc -l
1

```
查看每个物理CPU中core的个数(即核数)`4`
```shell-session
root@ubuntu:~# cat /proc/cpuinfo | grep "cpu cores"|uniq
cpu cores: 4
```

查看逻辑CPU的个数`4`
```shell-session
root@ubuntu:~# cat /proc/cpuinfo | grep "processor" | wc -l
4
```
`cat /proc/cpuinfo`其中一段输出
```shell-session
processor       : 2 #编号是2的逻辑cpu
vendor_id       : GenuineIntel
cpu family      : 6
model           : 62
model name      : Intel(R) Xeon(R) CPU E5-2690 v2 @ 3.00GHz
stepping        : 4
microcode       : 0x428
cpu MHz         : 3000.112
cache size      : 25600 KB
physical id     : 0 #物理核编号，只有一个核，4个逻辑CPU的字段都是0
siblings        : 4 #每个物理核中封装的逻辑cpu数量。如果siblins大于cpu cores，则认为开启了超线程。
core id         : 2 #在物理核中的核心编号，编号不一定连续，编号的数量等于cpu cores。查询办法 cat /proc/cpuinfo | grep "core id" |sort|uniq|wc -l 
cpu cores       : 4 #每个物理CPU有4个核心
apicid          : 4
initial apicid  : 4
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx rdtscp lm constant_tsc rep_good nopl e
agerfpu pni pclmulqdq ssse3 cx16 pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm fsgsbase smep erms xsaveopt
bugs            :
bogomips        : 6000.22
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:
```

## dmidecode
```shell-session
root@ubuntu:~# dmidecode -t processor
# dmidecode 3.0
Scanning /dev/mem for entry point.
SMBIOS 2.4 present.

Handle 0x0401, DMI type 4, 26 bytes
Processor Information
Socket Designation: CPU 1
Type              : Central Processor
Family            : Other
Manufacturer      : Intel
ID                : E4 06 03 00 FF FB 8B 17
Version           : Not Specified
Voltage           : Unknown
External Clock    : Unknown
Max Speed         : 3000 MHz
Current Speed     : 3000 MHz
Status            : Populated, Enabled
Upgrade           : Other

Handle 0x0402, DMI type 4, 26 bytes
Processor Information
Socket Designation: CPU 2
Type              : Central Processor
Family            : Other
Manufacturer      : Intel
ID                : E4 06 03 00 FF FB 8B 17
Version           : Not Specified
Voltage           : Unknown
External Clock    : Unknown
Max Speed         : 3000 MHz
Current Speed     : 3000 MHz
Status            : Populated, Enabled
Upgrade           : Other

Handle 0x0403, DMI type 4, 26 bytes
Processor Information
Socket Designation: CPU 3
Type              : Central Processor
Family            : Other
Manufacturer      : Intel
ID                : E4 06 03 00 FF FB 8B 17
Version           : Not Specified
Voltage           : Unknown
External Clock    : Unknown
Max Speed         : 3000 MHz
Current Speed     : 3000 MHz
Status            : Populated, Enabled
Upgrade           : Other

Handle 0x0404, DMI type 4, 26 bytes
Processor Information
Socket Designation: CPU 4
Type              : Central Processor
Family            : Other
Manufacturer      : Intel
ID                : E4 06 03 00 FF FB 8B 17
Version           : Not Specified
Voltage           : Unknown
External Clock    : Unknown
Max Speed         : 3000 MHz
Current Speed     : 3000 MHz
Status            : Populated, Enabled
Upgrade           : Other
```

# 一台x86服务器
## lscpu
```
[root@localhost ~]# lscpu
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                48
On-line CPU(s) list:   0-47
Thread(s) per core:    2
Core(s) per socket:    12
Socket(s):             2
NUMA node(s):          2
Vendor ID:             GenuineIntel
CPU family:            6
Model:                 85
Model name:            Intel(R) Xeon(R) Gold 6126T CPU @ 2.60GHz
Stepping:              4
CPU MHz:               2601.000
CPU max MHz:           2601.0000
CPU min MHz:           1000.0000
BogoMIPS:              5200.00
Virtualization:        VT-x
L1d cache:             32K
L1i cache:             32K
L2 cache:              1024K
L3 cache:              19712K
NUMA node0 CPU(s):     0-11,24-35
NUMA node1 CPU(s):     12-23,36-47
Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 intel_pt tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts
```
```shell-session
CPU(s):                48   总核数48 或者 逻辑核数48   
Socket(s):             2    物理核一共有2个  
Core(s) per socket:    12   每个物理核封装12个核心  
Thread(s) per core:    2    每个核心开启2个超线程
```
总核数（逻辑核数）48 = 物理核数2 × 每个物理封装核心12 × 2超线程

## cat /proc/cpuinfo
查看物理CPU个数`2`
```shell-session
[root@localhost ~]# cat /proc/cpuinfo | grep "physical id" | sort | uniq | wc -l
2
```
查看每个物理CPU中core的个数(即核数)`12`
```shell-session
[root@localhost ~]# cat /proc/cpuinfo | grep "cpu core" | sort | uniq
cpu cores       : 12

```
查看逻辑CPU的个数`48`
```
[root@localhost ~]# cat /proc/cpuinfo | grep "processor" | wc -l
48
```
`cat /proc/cpuinfo`其中一段输出
```
processor       : 41 #编号为41的逻辑CPU
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Xeon(R) Gold 6126T CPU @ 2.60GHz
stepping        : 4
microcode       : 0x2000043
cpu MHz         : 2601.000
cache size      : 19712 KB
physical id     : 1  #编号为41的逻辑CPU所在的物理CPU编号，这里在第2个物理CPU上
siblings        : 24 #每个物理核CPU的线程数量是24个，结合cpu cores可以知道超线程倍数是2
core id         : 8  #在物理核中的核心编号，编号不一定连续，编号的数量等于cpu cores。查询办法 cat /proc/cpuinfo | grep "core id" |sort|uniq|wc -l
cpu cores       : 12 #每个物理CPU的核心是12个
apicid          : 49
initial apicid  : 49
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 intel_pt tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts
bogomips        : 5205.75
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:
```

## dmidecode
使用dmidecode查看CPU数量
```shell-session
[root@localhost ~]# dmidecode -t processor | grep -E "Socket Designation:|(Core|Thread) Count"
        Socket Designation: CPU01
        Core Count: 12
        Thread Count: 24
        Socket Designation: CPU02
        Core Count: 12
        Thread Count: 24
```
这里CPU个数是2，分别是CPU01和CPU02，每个物理CPU核心是12个，但是都运行了24个线程，所以超线程倍数是2，总逻辑CPU数量是48。


# 一台ARM服务器

## lscpu
```shell-session
[root@CN-1 ~]# lscpu
Architecture:          aarch64
Byte Order:            Little Endian
CPU(s):                64
On-line CPU(s) list:   0-63
Thread(s) per core:    1
Core(s) per socket:    16
Socket(s):             4
NUMA node(s):          4
Model:                 2
BogoMIPS:              100.00
L1d cache:             unknown size
L1i cache:             unknown size
L2 cache:              unknown size
NUMA node0 CPU(s):     0-15
NUMA node1 CPU(s):     16-31
NUMA node2 CPU(s):     32-47
NUMA node3 CPU(s):     48-63
Flags:                 fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
```
```shell-session
CPU(s):                64  总核数64 或者 逻辑核数64
Socket(s):             4   物理核4
Core(s) per socket:    16  每个物理核封装4个核心  
Thread(s) per core:    1   每个核心开启1个超线程
```
总核数（逻辑核数）64 = 物理核数16 × 每个物理封装核心4 × 2超线程  
实际上这台ARM服务器是2个物理核，即2个chip，每个chip含2个socket，每个socket含16个核心。
## /proc/cpuinfo
ARM服务器的cpuinfo没有相应的 physical id，cpu core，processor字段。所以不能按照intel系统上的查询方式查询信息。

cpuinfo的一段输出
```shell-session
processor       : 62
BogoMIPS        : 100.00
Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x0
CPU part        : 0xd08
CPU revision    : 2
```
## dmidecode
使用dmidecode查看CPU数量
```shell-session
[root@CN-1 ~]# dmidecode -t processor | grep -E "Socket Designation:|(Core|Thread) Count"
        Socket Designation: CPU01
        Core Count: 32
        Thread Count: 32
        Socket Designation: CPU02
        Core Count: 32
        Thread Count: 32
[root@CN-1 ~]#
```
这里CPU个数是2，分别是CPU01和CPU02，每个物理CPU核心是32个，每个物理CPU核心线程数量也是32，也就是没有启用超线程。总逻辑CPU数量是64。

# 树莓派 3B
官方参数[官网](https://www.raspberrypi.org/magpi/raspberry-pi-3-specs-benchmarks/)
```
Raspberry Pi 3 Specifications
SoC: Broadcom BCM2837
CPU: 4× ARM Cortex-A53, 1.2GHz
GPU: Broadcom VideoCore IV
RAM: 1GB LPDDR2 (900 MHz)
Networking: 10/100 Ethernet, 2.4GHz 802.11n wireless
Bluetooth: Bluetooth 4.1 Classic, Bluetooth Low Energy
Storage: microSD
GPIO: 40-pin header, populated
Ports: HDMI, 3.5mm analogue audio-video jack, 4× USB 2.0, Ethernet, Camera Serial Interface (CSI), Display Serial Interface (DSI)
```

## lscpu
```shell-session
pi@raspberrypi:~ $ lscpu
Architecture:          armv7l
Byte Order:            Little Endian
CPU(s):                4            #官方 CPU: 4× ARM Cortex-A53, 1.2GHz
On-line CPU(s) list:   0-3
Thread(s) per core:    1            #没有超线程
Core(s) per socket:    4
Socket(s):             1
Model:                 4
Model name:            ARMv7 Processor rev 4 (v7l)
CPU max MHz:           1200.0000    #和官方的1.2GHZ标称一样，没有买到假货
CPU min MHz:           600.0000     #和官方一致
BogoMIPS:              38.40
Flags:                 half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm crc32
```

## /proc/cpuinfo
```shell-session
pi@raspberrypi:~ $ cat /proc/cpuinfo
processor       : 0
model name      : ARMv7 Processor rev 4 (v7l)
BogoMIPS        : 38.40
Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm crc32
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x0
CPU part        : 0xd03
CPU revision    : 4

processor       : 1
model name      : ARMv7 Processor rev 4 (v7l)
BogoMIPS        : 38.40
Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm crc32
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x0
CPU part        : 0xd03
CPU revision    : 4

processor       : 2
model name      : ARMv7 Processor rev 4 (v7l)
BogoMIPS        : 38.40
Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm crc32
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x0
CPU part        : 0xd03
CPU revision    : 4

processor       : 3
model name      : ARMv7 Processor rev 4 (v7l)
BogoMIPS        : 38.40
Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm crc32
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x0
CPU part        : 0xd03
CPU revision    : 4

Hardware        : BCM2835 #这里和官方BCM2837不一样，感觉还是有点坑。
Revision        : a32082
Serial          : 0000000076e8446e
```
## dmidecode
```shell-session
pi@raspberrypi:~ $ sudo dmidecode
# dmidecode 3.0
Scanning /dev/mem for entry point.
# No SMBIOS nor DMI entry point found, sorry.
```
不支持demidecode，网上介绍原因是BIOS没有设置DMI data。

**如有问题，欢迎在github上给我留言**