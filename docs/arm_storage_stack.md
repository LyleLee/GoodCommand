arm生态，存储相关软件
===========================

|编号     |软件     |状态      |版本     |获取方式   |
|:--------|:--------|:---------|:--------|:-----------------------------------------------|
|1        |Ceph     |已使能    |12.2.8   |[github](https://github.com/ceph/ceph/releases) 或者 [软件源](https://mirrors.huaweicloud.com/ubuntu-ports/pool/main/c/ceph) |
|2        |lustre   |未使能    |2.12.0   |[官网](http://lustre.org/download/)|
|3        |NFS      |已使能    |1.3.4    |[软件源](https://mirrors.huaweicloud.com/ubuntu-ports/pool/main/n/nfs-utils)|
|4        |HDFS     |已使能    |java     |[官网](https://hadoop.apache.org/releases.html)|
|5        |fio      |已使能    |fio-3.11 |[软件源](https://mirrors.huaweicloud.com/ubuntu-ports/pool/universe/f/fio/)|
|6        |vdbench  |已使能    |5.04.07  |[官网](https://www.oracle.com/technetwork/server-storage/vdbench-source-download-2104625.html)|

待核实

1. TFS
2. lizardfs [官网](https://lizardfs.com/)
3. mossefs
4. GFS
5. GridFS
6. mogileFS
7. FastDFS


## ubuntu官方不支持ceph-fuse
```shell-session
me@ubuntufio:~$ rmadison -S ceph-fuse
 ceph-fuse | 0.79-0ubuntu1                 | trusty                  | amd64
 ceph-fuse | 0.80.11-0ubuntu1.14.04.3      | trusty-security         | amd64
 ceph-fuse | 0.80.11-0ubuntu1.14.04.4      | trusty-updates          | amd64
 ceph-fuse | 10.1.2-0ubuntu1               | xenial                  | amd64
 ceph-fuse | 10.2.11-0ubuntu0.16.04.1      | xenial-updates          | amd64
 ceph-fuse | 12.2.4-0ubuntu1               | bionic/universe         | amd64
 ceph-fuse | 12.2.4-0ubuntu1.1build1       | cosmic/universe         | amd64
 ceph-fuse | 12.2.8-0ubuntu0.18.04.1       | bionic-updates/universe | amd64
 ceph-fuse | 13.2.1+dfsg1-0ubuntu2.18.10.1 | cosmic-updates/universe | amd64
 ceph-fuse | 13.2.4+dfsg1-0ubuntu1         | disco/universe          | amd64
me@ubuntufio:~$
```
ceph的其他组件ubuntu官方支持，源上有。  
ceph-fuse需要到download.ceph.com去下载

## vebench 官方版本java jni缺少aarch64版本，需要手动编译。
[vdbench使用方法](vdbench.md)
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