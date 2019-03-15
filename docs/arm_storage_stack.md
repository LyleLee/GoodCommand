ARM生态，存储相关软件
===========================

|编号       |软件     |状态              |版本     |获取方式   |
|:--------  |:--------|:---------        |:--------|:-----------------------------------------------|
|1          |Ceph     |已使能            |12.2.8   |[[github]](https://github.com/ceph/ceph/releases)  [[发行版软件源]](https://mirrors.huaweicloud.com/ubuntu-ports/pool/main/c/ceph) |
|2          |NFS      |已使能            |1.3.4    |[[发行版软件源]](https://mirrors.huaweicloud.com/ubuntu-ports/pool/main/n/nfs-utils)|
|3          |HDFS     |已使能            |java     |[[官网]](https://hadoop.apache.org/releases.html)|
|4          |fio      |已使能            |3.11     |[[发行版软件源]](https://mirrors.huaweicloud.com/ubuntu-ports/pool/universe/f/fio/)|
|5          |vdbench  |已使能            |5.04.07  |[[官网]](https://www.oracle.com/technetwork/server-storage/vdbench-source-download-2104625.html)|
|6          |GridFS   |已使能            |MongoDB  |[[官网]](https://docs.mongodb.com/manual/core/gridfs/)
|7          |MooseFS  |未使能            |3.0.103  |[[github]](https://github.com/moosefs/moosefs) [[官方软件源]](http://ppa.moosefs.com/moosefs-3/apt/ubuntu/bionic)
|8          |LizardFS |未使能            |3.13.0   |[[官网]](https://lizardfs.com/)  [[github]](https://github.com/lizardfs/lizardfs) [[官方软件源]](http://packages.lizardfs.com/)
|9          |fastDFS  |已使能            |5.11     |[[github]](https://github.com/happyfish100/fastdfs)|
|10         |lustre   |未使能            |2.12.0   |[[官网]](http://lustre.org/download/)|
|11         |TFS      |未使能            |2.2.13   |[[官网]](http://tfs.taobao.org/) [[github]](https://github.com/alibaba/tfs)|
|12         |MogileFS |未使能            |2.73     |[[github]](https://github.com/mogilefs)|
|13         |GFS      |未使能闭源        |-        |  |

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

## MooseFS
moosefs 代码托管在   [https://github.com/moosefs/moosefs](https://github.com/moosefs/moosefs)  
官方运行付费版本的pro版本   [https://moosefs.com/](https://moosefs.com/)  
mossefs官方软件源提供x86版本下载    [http://ppa.moosefs.com/moosefs-3/apt/ubuntu/bionic/dists/bionic/main/](http://ppa.moosefs.com/moosefs-3/apt/ubuntu/bionic/dists/bionic/main/)  

未见提供ARM版本。
```
[ICO]	Name	Last modified	Size	Description
[DIR]	Parent Directory	 	-	 
[DIR]	binary-amd64/	24-Nov-2018 03:41	-	 
[DIR]	binary-i386/	24-Nov-2018 03:41	-	 
```

## LizardFS
LizardFS作为MoseFS的分支发布。
LizardFS官方支持CentOS，Debian，ubuntu，[官网](https://lizardfs.com/)提供x86版本rpm包、deb包下载，有官方软件源[http://packages.lizardfs.com/yum/el7/](http://packages.lizardfs.com/yum/el7/)。 

## fastDFS
可以编译通过

## GridFS
基于MongoDB，使用方法是部署mongoDB，安装mongoDB driver后调用api进行存储。

## MogileFS
基于perl
github上基本停止更新

## TFS
github库已经archive，停止更新。
只有x86安装指导教程

## 其他信息
```
GridFS 用于存储和恢复那些超过16M（BSON文件限制）的文件(如：图片、音频、视频等)。
MogileFS	适用于处理海量小文件
Ceph	是一个 Linux PB级别的分布式文件系统
MooseFS	通用简便，适用于研发能力不强的公司
Taobao Filesystem	适用于处理海量小文件
ClusterFS	适用于处理单个大文件
Google Filesystem	GFS+MapReduce擅长处理单个大文件
Hadoop Distributed Filesystem	GFS的山寨版+MapReduce，擅长处理单个大文件
```