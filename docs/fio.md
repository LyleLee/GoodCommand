fio 测试硬盘性能
========================
fio是多线程IO负载生成测试工具，是测试服务器硬盘性能的优秀工具。

## 对比测试参数
X86  
```
fio --ramp_time=5 --runtime=60 --size=10g --ioengine=libaio --filename=/dev/sda --name=4k_read --numjobs=1 --iodepth=64 --rw=read --bs=4k --direct=1
```

ARM
```
fio --ramp_time=5 --runtime=60 --size=10g --ioengine=libaio --filename=/dev/sdc --name=4k_read --numjobs=1 --iodepth=64 --rw=read --bs=4k --direct=1
```


## 一些基础知识

以下内容摘自 [系统技术非业余研究](http://blog.yufeng.info/archives/2104)

随着块设备的发展，特别是SSD盘的出现，设备的并行度越来越高。利用好这些设备，有个诀窍就是提高设备的iodepth, 一把喂给设备更多的IO请求，让电梯算法和设备有机会来安排合并以及内部并行处理，提高总体效率。  

应用使用IO通常有二种方式：同步和异步。 同步的IO一次只能发出一个IO请求，等待内核完成才返回，这样对于单个线程iodepth总是小于1，但是可以透过多个线程并发执行来解决，通常我们会用16-32根线程同时工作把iodepth塞满。 异步的话就是用类似libaio这样的linux native aio一次提交一批，然后等待一批的完成，减少交互的次数，会更有效率。


## 参数配置要求

```
bs          #块大小必须是扇区（512字节）
ramp_time   #作用是减少日志对高速IO的影响
direct      #使用direct，fsync就不会发生
```

## 查看硬盘支持的最大队列深度

lsscsi在redhat，centOS，ubuntu都支持 ，每个操作系统的设置都不一样

X86
```
[root@localhost queue]# lsscsi -l
[0:0:0:0]    enclosu 12G SAS  Expander         RevB  -
  state=running queue_depth=256 scsi_level=7 type=13 device_blocked=0 timeout=90
[0:0:13:0]   disk    HUAWEI   HWE32SS3008M001N 2774  /dev/sda
  state=running queue_depth=64 scsi_level=7 type=0 device_blocked=0 timeout=90
[0:2:0:0]    disk    AVAGO    AVAGO            4.65  /dev/sdb
  state=running queue_depth=256 scsi_level=6 type=0 device_blocked=0 timeout=90
```
ARM-ubuntu
```
root@ubuntu:~/app/fio-fio-3.13# lsscsi -l
[0:0:0:0]    disk    ATA      HUS726040ALA610  T7R4  /dev/sda
  state=running queue_depth=31 scsi_level=6 type=0 device_blocked=0 timeout=30
[0:0:1:0]    disk    ATA      HUS726040ALA610  T7R4  /dev/sdb
  state=running queue_depth=31 scsi_level=6 type=0 device_blocked=0 timeout=30
[0:0:2:0]    disk    HUAWEI   HWE32SS3008M001N 2774  /dev/sdc
  state=running queue_depth=64 scsi_level=7 type=0 device_blocked=0 timeout=30
[0:0:3:0]    enclosu 12G SAS  Expander         RevB  -
  state=running queue_depth=64 scsi_level=7 type=13 device_blocked=0 timeout=0

```

redhat支持， centOS不支持
```
cat /sys/block/sdb/device/queue_depth
32
```


## fio编译

./configure 提示一些fio特性会依赖zlib
```
yum install zlib-devel.aarch64
```

编译安装好之后，version还是不对，需要重新登录系统才会生效。
```
[root@localhost fio-fio-3.13]# fio -v
fio-3.7
[root@localhost ~]# which fio
/usr/local/bin/fio
[root@localhost ~]# /usr/local/bin/fio -v
fio-3.13
[root@localhost ~]# 
```
root@ubuntu:~/app/fio-fio-3.13# fio -v
fio-3.1
root@ubuntu:~/app/fio-fio-3.13#





```
[root@localhost fio-fio-3.13]# make install
install -m 755 -d /usr/local/bin
install fio t/fio-genzipf t/fio-btrace2fio t/fio-dedupe t/fio-verify-state ./tools/fio_generate_plots ./tools/plot/fio2gnuplot ./tools/genfio ./tools/fiologparser.py ./tools/hist/fiologparser_hist.py ./tools/fio_jsonplus_clat2csv /usr/local/bin
install -m 755 -d /usr/local/man/man1
install -m 644 ./fio.1 /usr/local/man/man1
install -m 644 ./tools/fio_generate_plots.1 /usr/local/man/man1
install -m 644 ./tools/plot/fio2gnuplot.1 /usr/local/man/man1
install -m 644 ./tools/hist/fiologparser_hist.py.1 /usr/local/man/man1
install -m 755 -d /usr/local/share/fio
install -m 644 ./tools/plot/*gpm /usr/local/share/fio/
```

编译安装后发现libaio无法加载
```
[root@localhost fio_scripts]# perf record -ag -o fio_symbol.data fio --ramp_time=5 --runtime=60 --size=10g --ioengine=libaio --filename=/dev/sdb --name=4k_read --numjobs=1 --rw=read --bs=4k --direct=1
fio: engine libaio not loadable
fio: engine libaio not loadable
fio: failed to load engine
```

查看当前系统支持的io引擎
```
fio -enghelp
```

fio --ramp_time=10 --runtime=60 --size=10g --ioengine=libaio --filename=/mnt/testfile.doc --name=4k_read --rw=read --bs=4k

问题：
+ ubuntu下缺少libaio库
```console
4k_read: No I/O performed by libaio, perhaps try --debug=io option for details?
```
解决办法
```console
sudo apt-get install libaio-dev
```
+ 限制带宽和IOPS
```console
--rate 400k,300k
```
把读速率设置为400kB/s， 把写速率设置为300kB/s