## 查询设备信息
+ 查看服务器型号，bios， 主板，槽位，cpu，内存等
```shell-session
sudo dmidecode -t  bios         #含厂商、版本等
sudo dmidecode -t  system       #含服务器型号、厂商，发布日期等
sudo dmidecode -t  baseboard    #含厂商，序列号等
sudo dmidecode -t  chassis      #含槽位，最大支持PCI槽位，并不是实际服务器的槽位
sudo dmidecode -t  processor    #含CPU个数，类型：x86/ARM，时钟频率，L1，L2，L3缓存等
sudo dmidecode -t  memory       #含所有内存插槽，每个内存条大小，位宽，类型：DDR4等
sudo dmidecode -t  cache        #含所有L1、L2、L3缓存信息
sudo dmidecode -t  connector    #未调查
sudo dmidecode -t  slot         #含槽位信息
```
## 查询CPU信息
```
总核数     = 物理CPU个数 × 每颗物理CPU的核数  
总逻辑CPU数= 物理CPU个数 × 每颗物理CPU的核数 X 超线程数
```
+ 查看物理CPU个数
```shell-session
cat /proc/cpuinfo| grep "physical id"| sort| uniq| wc -l
```
+ 查看每个物理CPU中core的个数(即核数)
```shell-session
cat /proc/cpuinfo| grep "cpu cores"| uniq
```
+ 查看逻辑CPU的个数
```
cat /proc/cpuinfo| grep "processor"| wc -l
```

## 查询内存信息
+ 查看内存使用情况
```shell-session
me@ubuntu:~$ free -mh
              total        used        free      shared  buff/cache   available
Mem:           125G         20G        1.2G        3.1M        103G        103G
Swap:          2.0G         20M        2.0G
me@ubuntu:~$
```
## 查询硬盘信息
### 1.lsblk
可以看到物理盘和逻辑盘以及挂载情况
```shell-session
me@ubuntu:~$ lsblk
NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda      8:0    0  3.7T  0 disk
├─sda1   8:1    0  512M  0 part /boot/efi
└─sda2   8:2    0  3.7T  0 part /
sdb      8:16   0  3.7T  0 disk
└─sdb1   8:17   0  3.7T  0 part /home/data
```
### 2.fdisk
系统自带的硬盘工具,可以进行格式化硬盘等操作
```shell-session
fdisk -l
#列出所有物理硬盘，做了硬raid只能看到一个硬盘
```
###额外安装
#### 3. smartctl
可以看到硬盘本身的信息：设备型号、序列号，厂家、转速，大小等  
`smartctl -a /dev/sdb`
```shell-session
me@ubuntu:~$ sudo smartctl -a /dev/sdb
smartctl 6.6 2016-05-31 r4324 [aarch64-linux-4.15.0-20-generic] (local build)
Copyright (C) 2002-16, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Device Model:     HUS726040ALA610
Serial Number:    K4JGB1DB
LU WWN Device Id: 5 000cca 25de2b5aa
Firmware Version: T7R4
User Capacity:    4,000,787,030,016 bytes [4.00 TB]
Sector Size:      512 bytes logical/physical
Rotation Rate:    7200 rpm
Form Factor:      3.5 inches
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   ACS-2, ATA8-ACS T13/1699-D revision 4
SATA Version is:  SATA 3.1, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Fri Jan 18 17:26:44 2019 CST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled
...........
```
#### 4. hdparm也是一个实用工具
```
hdparm -I /dev/sdb
```
```shell-session
me@ubuntu:~$ sudo hdparm -I /dev/sdb

/dev/sdb:

ATA device, with non-removable media
        Model Number:       HUS726040ALA610
        Serial Number:      K4JGB1DB
        Firmware Revision:  T7R4
        Transport:          Serial, ATA8-AST, SATA 1.0a, SATA II Extensions, SATA Rev 2.5, SATA Rev 2.6, SATA Rev 3.0; Revision: ATA8-AST T13 Project D1697 Revision 0b
Standards:
        Used: unknown (minor revision code 0x0029)
        Supported: 9 8 7 6 5
        Likely used: 9
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:    16514064
        LBA    user addressable sectors:   268435455
        LBA48  user addressable sectors:  7814037168
        Logical  Sector size:                   512 bytes
        Physical Sector size:                   512 bytes
        device size with M = 1024*1024:     3815447 MBytes
        device size with M = 1000*1000:     4000787 MBytes (4000 GB)
        cache/buffer size  = unknown
        Form Factor: 3.5 inch
        Nominal Media Rotation Rate: 7200
Capabilities:

```
## 网络操作
+ 重启网络  

在ubuntu18.04上是
```
sudo systemctl restart systemd-networkd.service
```
其他系统上各有不同，即使是ubuntu，也因为版本命令不一样，所以其他发行版请自行搜索。

+ 抓包

在eth0上抓ping包，看是否有ping包到达
```
tcpdump -v icmp -i eth0
```
## 文件操作
+ 修改文件所有者和文件所在组
```
chgrp   用户名 文件名  -R  
chown   用户名 文件名  -R
```
+ 递归搜索当前目录下所有.h 文件中包含 linux_binfmt字符串的文件
```
grep "linux_binfmt" -Ril --include=\*.h
```
+ 查找ELF64_Sym在所有.h文件中的原型  
```
grep Elf64_Sym /usr/include/*.h | grep typedef
find /etc/httpd/ -name httpd.conf
```
+ 在linux目录中查找所有的`*.h`，并在这些文件中查找SYSCALL_VECTOR 
```
find linux -name *.h | xargs grep "SYSCALL_VECTOR"
```
+ 从根目录开始查找所有扩展名为.log的文本文件，并找出包含”ERROR”的行 
```
find / -type f -name “*.log” | xargs grep “ERROR”
```
+ 从当前目录开始查找所有扩展名为.in的文本文件，并找出包含”thermcontact”的行 
```
find . -name “*.in” | xargs grep “thermcontact”
```
+ 查找系统库中包含 “getopt_long”函数的头文件
```
find /usr/lib/ -name *.h | xargs grep "getopt_long"
```
+ 查找指定目录
```
find . -type d -name debug*
```
+ 查找当前目录下所有文件中包含ibv_open_device的文件和行
```
grep ibv_open_device -rn .
```
+ 查找时忽略文件`.java`文件和`.js`文件
```
grep -E "http"  . -R --exclude=*.{java,js}
```
+ 查找时忽略目录`.git`,`res`,`bin`
```
grep -E "http"  . -R --exclude-dir={.git,res,bin}
grep ibv_context -rn --exclude={GPATH,GRTAGS,GTAGS,tags}
export GREP_OPTIONS="--exclude-dir=\.svn --exclude-dir=\.git --exclude=tags --exclude=cscope\.out"
```
+ 查找文件并且ls
```
find . -name verbs.h | xargs -n 1 ls -l
```
+ grep 显示匹配行的后面几行 -A选项
```
dmidecode|grep "System Information" -A9
```
## 软件安装
1. 查找软件包
```yum search ~  ```

2. 列出所有可安装的软件包  
>yum list  
  
3. 列出所有可更新的软件包
>yumlist updates  
  
4. 列出所有已安装的软件包
>yum list installed
  
5. 列出所有已安装但不在Yum Repository內的软件包
>yum list extras

6. 列出所指定软件包
>yum list~

7. 使用YUM获取软件包信息
>yum info~

8. 列出所有软件包的信息
>yum info

9. 列出所有可更新的软件包信息
>yum info updates

10. 列出所有已安裝的软件包信息
>yum info installed

11. 列出所有已安裝但不在Yum Repository內的软件包信息
>yum info extras

12. 列出软件包提供哪些文件
>yum provides~

fdisk -l可以看到多个物理硬盘，做了硬raid只能看到一个硬盘  
`cat /proc/cpuinfo查看cpu具体的信息`
13. 查找不常见软件包
>rmadision -S
## 安装linux源码
```
sudo apt-get install linux-4.4-source-4.4  
xz -d linux-4.4-source-4.4.tar.xz   
sudo xz -d linux-4.4-source-4.4.tar.xz   
tar -xvf linux-4.4-source-4.4.tar   
sudo tar -xvf linux-4.4-source-4.4.tar
```
## 修改键盘布局
有时候键盘布局可能不一样，导致按键错误，可以使用命令进行配置.一般选择1-4键盘
```shell-session
sudo dpkg-reconfigure keyboard-configuration
```
```shell-session
me@ubuntufio:~$ sudo dpkg-reconfigure keyboard-configuration
Package configuration

         ┌──────────┤ Configuring keyboard-configuration ├───────────┐
         │ Please select the model of the keyboard of this machine.  │
         │                                                           │
         │ Keyboard model:                                           │
         │                                                           │
         │     DTK2000                                            ↑  │
         │     eMachines m6800 laptop                             ▒  │
         │     Ennyah DKB-1008                                    ▒  │
         │     Everex STEPnote                                    ▮  │
         │     FL90                                               ▒  │
         │     Fujitsu-Siemens Amilo laptop                       ▒  │
         │     Generic 101-key PC                                 ▒  │
         │     Generic 101-key PC (intl.)                         ▒  │
         │     Generic 104-key PC                                 ▒  │
         │     Generic 105-key PC (intl.)                         ↓  │
         │                                                           │
         │                                                           │
         │              <Ok>                  <Cancel>               │
         │                                                           │
         └───────────────────────────────────────────────────────────┘
```
