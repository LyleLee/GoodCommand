## vdbench使用方法
Oracle维护的一个磁盘IO性能工具，用于产生磁盘IO 负载测试磁盘性能和数据完整性。

### 使用前准备
下载解压即可使用。一般不需要编译，如果运行环境存在，可以直接运行。当在ARM服务器上执行时会遇到一些问题，这里介绍如何解决。 

测试运行环境：
```shell-session
#给脚本赋予运行权限
chmod +x vdbench
#执行测试
./vdbench -t
```
```shell-session
me@ubuntu:~/vdbench50407$ ./vdbench -t
-bash: ./vdbench: /bin/csh: bad interpreter: No such file or directory
```
出现csh找不到的问题，原因是：
+ vdbench 5.04.05的vdbench脚本是c shell script文件。
解决办法是：

方法1： 安装csh
```shell-session
sudo apt install csh
```
方法2： 使用最新版本 5.04.07 【建议】  
可以看到最新的5.04.07使用的是bash script。
```shell-session
me@ubuntu:~/vdbench50407$ file vdbench
vdbench: Bourne-Again shell script, ASCII text executable
```

### 使用vdbench 5.04.05
出现java版本检测不合法的问题。
```shell-session
me@ubuntu:~/vdbench504$ ./vdbench -t


Vdbench distribution: vdbench504
For documentation, see 'vdbench.pdf'.

*
*
*
* Minimum required Java version for Vdbench is 1.5.0;
* You are currently running 10.0.2
* Vdbench terminated.
*
*
*

CTRL-C requested. vdbench terminating
```

### 使用vdbench 5.04.07
在vdbench 5.04.07上没有出现java版本报错的问题。查看源码，已经移除java版本检测`checkJavaVersion();`。移除原因作者未说明，详细请参考版本发布说明。
```java

    // Removed as per 50407 because of java 1.10.x
    //checkJavaVersion();

    //....
    
     private static void checkJavaVersion()
  {
    if (common.get_debug(common.USE_ANY_JAVA))
      return;
    if (!JVMCheck.isJREValid(System.getProperty("java.version"), 1, 7, 0))
    {
      System.out.print("*\n*\n*\n");
      System.out.println("* Minimum required Java version for Vdbench is 1.7.0; \n" +
                         "* You are currently running " + System.getProperty("java.version") +
                         "\n* Vdbench terminated.");
      System.out.println("*\n*\n*\n");

      System.exit(-99);
    }
  } 
    
```
版本发布说明[oracle vdbench 50407rc29](https://community.oracle.com/docs/DOC-1024870)
```
50407rc29

The check to make sure you are running java 1.7 or higher has been removed.
```
### vdbench在ARM服务器上出现共享库aarch64.so问题
在ARM服务器上，会出现共享库不匹配的问题。
```shell-session
me@ubuntu:~$ ./vdbench -t


Copyright (c) 2000, 2018, Oracle and/or its affiliates. All rights reserved.
Vdbench distribution: vdbench50407 Tue June 05  9:49:29 MDT 2018
For documentation, see 'vdbench.pdf'.

15:11:24.571 Created output directory '/home/me/output'
15:11:24.720 input argument scanned: '-f/tmp/parmfile'
15:11:24.870 Starting slave: /home/me/vdbench SlaveJvm -m localhost -n localhost-10-190124-15.11.24.528 -l localhost-0 -p 5570
15:11:24.892
15:11:24.893 File /home/me/linux/aarch64.so does not exist.
15:11:24.893 This may be an OS that a shared library currently
15:11:24.893 is not available for. You may have to do your own compile.
15:11:24.893 t: java.lang.UnsatisfiedLinkError: Can't load library: /home/me/linux/aarch64.so
15:11:24.893
15:11:24.894 Loading of shared library /home/me/linux/aarch64.so failed.
15:11:24.894 There may be issues related to a cpu type not being
15:11:24.894 acceptable to Vdbench, e.g. MAC PPC vs. X86
15:11:24.894 Contact me at the Oracle Vdbench Forum for support.
15:11:24.894
15:11:25.397
15:11:25.397 Failure loading shared library
15:11:25.398
java.lang.RuntimeException: Failure loading shared library
        at Vdb.common.failure(common.java:350)
        at Vdb.common.get_shared_lib(common.java:1103)
        at Vdb.Native.<clinit>(Native.java:31)
        at Vdb.common.signal_caller(common.java:737)
        at Vdb.ConnectSlaves.connectToSlaves(ConnectSlaves.java:98)
        at Vdb.Vdbmain.masterRun(Vdbmain.java:814)
        at Vdb.Vdbmain.main(Vdbmain.java:628)

```
原因是vdbench根目录下`/linux/linux64.so`是为x86编译的,需要重新编译linux64.so
```shell-session
me@ubuntu:~$ file linux/linux64.so
linux/linux64.so: ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), dynamically linked, BuildID[sha1]=34a31f32956f21153c372a95e73c02e84ddd29f8, not stripped
```
### ARM版本的aarch64.so编译
下载，解压源码包：
[下载地址](https://www.oracle.com/technetwork/server-storage/vdbench-source-download-2104625.html) 需要同意license
```
unzip vdbench50407.src.zip
```
进入src创建linux目录
```
cd src/
mkdir linux
```
进入Jni修改make.linux。主要修改:
+ 修改vdb为源码包src的路径
+ 修改java为jdk路径。一般在`/usr/lib/jvm/`下
+ 去除`-m32`和`m64`选项
```
cd Jni/
vim make.linux
```
修改前：
```
vdb=$mine/vdbench504
java=/net/sbm-240a.us.oracle.com/export/swat/swat_java/linux/jdk1.5.0_22/
jni=$vdb/Jni

INCLUDES32="-w -m32 -DLINUX -I$java/include -I/$java/include/linux -I/usr/include/ -fPIC"
INCLUDES64="-w -m64 -DLINUX -I$java/include -I/$java/include/linux -I/usr/include/ -fPIC"

gcc  -o   $vdb/linux/linux32.so vdbjni.o vdblinux.o vdb_dv.o vdb.o chmod.o -lm -shared  -m32 -lrt

gcc  -o   $vdb/linux/linux64.so vdbjni.o vdblinux.o vdb_dv.o vdb.o chmod.o -lm -shared -m64 -lrt
```
修改后：
```

vdb=/home/me/vdbench50407src/src/
java=/usr/lib/jvm/java-11-openjdk-arm64/
jni=$vdb/Jni

INCLUDES32="-w -DLINUX -I$java/include -I/$java/include/linux -I/usr/include/ -fPIC"
INCLUDES64="-w -DLINUX -I$java/include -I/$java/include/linux -I/usr/include/ -fPIC"


gcc  -o   $vdb/linux/linux32.so vdbjni.o vdblinux.o vdb_dv.o vdb.o chmod.o -lm -shared -lrt

gcc  -o   $vdb/linux/linux64.so vdbjni.o vdblinux.o vdb_dv.o vdb.o chmod.o -lm -shared -lrt
```
执行make.linux，会在src/linux/下生成linux32.so和linux64.so文件，这里我们只需要使用到64位的文件。重命名linux64.so并复制到二进制包（注意不是源码包）的linux/目录下即可。
```shell
me@ubuntu:~/vdbench50407src/src/Jni$ ./make.linux
target directory: /home/me/vdbench50407src/src/
Compiling 32 bit
Linking 32 bit

Compiling 64 bit
Linking 64 bit

mv linux64.so aarch64.so
cp linux64.so ~/vdbench50407/linux/
```

### 执行测试
```shell
me@ubuntufio:~/vdbench50407$ ./vdbench -t


Copyright (c) 2000, 2018, Oracle and/or its affiliates. All rights reserved.
Vdbench distribution: vdbench50407 Tue June 05  9:49:29 MDT 2018
For documentation, see 'vdbench.pdf'.

16:46:11.641 input argument scanned: '-f/tmp/parmfile'
16:46:11.922 Starting slave: /home/me/vdbench50407/vdbench SlaveJvm -m localhost -n localhost-10-190218-16.46.11.421 -l localhost-0 -p 5570
16:46:12.662 All slaves are now connected
16:46:14.003 Starting RD=rd1; I/O rate: 100; elapsed=5; For loops: None

Feb 18, 2019    interval        i/o   MB/sec   bytes   read     resp     read    write     read    write     resp  queue  cpu%  cpu%
                               rate  1024**2     i/o    pct     time     resp     resp      max      max   stddev  depth sys+u   sys
16:46:15.102           1       76.0     0.07    1024  52.63    0.011    0.008    0.014     0.02     0.04    0.006    0.0  23.4   5.6
16:46:16.021           2      109.0     0.11    1024  53.21    0.011    0.010    0.013     0.07     0.03    0.007    0.0  10.2   2.0
16:46:17.012           3      112.0     0.11    1024  50.00    0.036    0.010    0.063     0.02     2.57    0.242    0.0   6.5   1.0
16:46:18.013           4      105.0     0.10    1024  50.48    0.012    0.009    0.015     0.02     0.04    0.006    0.0   4.0   1.0
16:46:19.027           5      126.0     0.12    1024  50.00    0.013    0.010    0.016     0.03     0.04    0.006    0.0   5.0   0.0
16:46:19.060     avg_2-5      113.0     0.11    1024  50.88    0.018    0.010    0.027     0.07     2.57    0.120    0.0   6.4   1.0
16:46:20.050 Vdbench execution completed successfully. Output directory: /home/me/vdbench50407/output
```

## 详细测试
配置的文件中的

+ General
+ Host Deinition(HD)
+ Replay Group(RG)
+ Storage Definition(SD)
+ Workload Definition(WD)
+ Run Definition(RD)

必须顺序出现。一个run指的是，RD执行的WD

Master和Slave， Vdbench以一个或者多个JVM运行。由用户运行的JVM是master，负责解析参数和报告。Slave可以运行在本机，也可以在远程主机执行。

### 裸机单盘性能
