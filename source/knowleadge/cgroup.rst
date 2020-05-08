*******************
cgroup
*******************

cgroup (control group [#cgroup_kernel]_ 提供一种限制应用程序占用资源的机制。


使用cgroup限制进程使用cpu
=============================

这里使用 :download:`cgroup_test.sh <../script/cgroup_test.sh>` 做测试。

在没有做任何事情之前， 程序的运行情况如下。第一列是PID， 第二列是CPU序号（从1开始）。
可以看到脚本的主进程64793在24号CPU上运行，脚本中的sleep函数会派生一个进程，在62号CPU上运行。
观察可以发现会在CPU之间进行迁移。 sleep每执行一次，就会生成一个进程，可以很频繁的看到进程在
不同的CPU之前进行迁移

.. code-block:: console

    64793  24 user1      20   0  110M  1404  1184 S  0.0  0.0  0:00.30 │  │        └─ bash GoodCommand/source/script/cgroup_test.sh
    69648  62 user1      20   0  105M   352   280 S  0.0  0.0  0:00.00 │  │           └─ sleep 1

执行操作步骤，注意这里的CPU需要是0开始 ::

    cd /sys/fs/cgroup/cpuset
    mkdir Charlie && cd Charlie
    echo 2-3 > cpuset.cpus
    echo 1 > cpuset.mems
    echo $$ > tasks       #把当前shell的进程加入到Charlie当中
    cat tasks
    bash /home/user1/GoodCommand/source/script/cgroup_test.sh

观察到程序会被固定在cpu3-4上， 也就是前面固定的2-3 ::

    72077   4 root       20   0  114M  4120  1804 S  0.0  0.0  0:00.31 │              └─ bash
    73899   3 root       20   0  110M  1380  1184 S  0.0  0.0  0:00.03 │                 └─ bash /home/user1/GoodCommand/source/script/cgroup_test.sh
    74364   3 root       20   0  105M   356   280 S  0.0  0.0  0:00.00 │                    └─ sleep 1


使用cgroup限制程序使用内存大小
=====================================

这里使用测试程序 ::download:`Mem-limits.c <../src/cgroup_memory/mem-limit.c>`

.. literalinclude:: ../src/cgroup_memory/mem-limit.c
    :language: c


未作限制之前， 占用了50MB的内存 ::

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
    9455 user1     20   0   55616  51824    392 S   0.0  0.0   0:00.04 mem-limit.out

创建cgroup test2，并且限制资源的使用为5MB ::

    mkdir /sys/fs/cgroup/memory/test2
    lscgroup | grep test2
    echo 5242880 > /sys/fs/cgroup/memory/test2/memory.limit_in_bytes
    echo 5242880 > /sys/fs/cgroup/memory/test2/memory.memsw.limit_in_bytes


程序因为受到内存限制， 申请不到内存而被kill掉 ::

    [root@intel6248 src]# cgexec -g memory:/test2 ./mem-limit.out
    Starting ...
    Allocated 0 to 1 MB
    Allocated 1 to 2 MB
    Allocated 2 to 3 MB
    Allocated 3 to 4 MB
    Killed


.. caution:: memory.memsw.limit_in_bytes 是设置swap空间， 如果不设置， 程序在达到内存限制之后就会开始使用swap


使用cgroup限制程序io速率
==============================

这里使用的例子来自 sysadmincasts [#cgroup_io]_

准备测试文件，在当前目录下会生成一个1M * 3000 = 3G大小的文件 ::

    dd if=/dev/zero of=file-abc bs=1M count=3000

不做限制，测试速度 ::

    echo 3 > /proc/sys/vm/drop_caches   #测试之前清除内存中的缓存
    dd if=file-abc of=/dev/null

读完3G的文件速度是105MB/s ::

    [root@intel6248 user1]# dd if=file-abc of=/dev/null
    6144000+0 records in
    6144000+0 records out
    3145728000 bytes (3.1 GB) copied, 29.891 s, 105 MB/s


.. doctest::

    print 5*1024*1024


创建cgroup并且限制速度未5MiB/s = 5* 1024 * 1024 = 5242880 B/s ::

    mkdir /sys/fs/cgroup/blkio/test1
    lscgroup | grep test1               # 查询创建cgroup是否成功
    lsblk                               # 查询当前硬盘的主设备号和次设备号得到是 8：0
    echo "8:0 5242880" > /sys/fs/cgroup/blkio/test1/blkio.throttle.read_bps_device

读完3G的文件速度是5MB/s左右， 花了大概10分钟 ::

    [root@intel6248 user1]# cgexec -g blkio:/test1 dd if=file-abc of=/dev/null
    6144000+0 records in
    6144000+0 records out
    3145728000 bytes (3.1 GB) copied, 600.566 s, 5.2 MB/s

iostop确认过程中读速度确实是5M左右 ::

    Total DISK READ :       5.20 M/s | Total DISK WRITE :      79.79 K/s
    Actual DISK READ:       5.20 M/s | Actual DISK WRITE:      81.52 K/s
    TID  PRIO  USER     DISK READ  DISK WRITE  SWAPIN     IO>    COMMAND
    4961 be/4 root        5.20 M/s    0.00 B/s  0.00 % 99.99 % dd if=file-abc of=/dev/null



docker中的cgroup
==================


docker也使用cgroup限制容器。

创建容器的时候传入cpu和memory的参数，例如限制只能使用4和5号cpu（这里是从0开始），同时限制只能使用10M内存。 ::

    docker run -itd --name docker_cgroup_restrict --rm --cpuset-cpus 4,5 -m 10m ubuntu

查询容器对应的cgroup信息， 可以看到 cpuset.cpus: 4-5 和 memory.limit_in_bytes: 10485760 ::

    lscgroup | grep docker | grep 5a1e18586f7e

    [user1@intel6248 ~]$ cgget -r cpuset.cpus -r  memory.limit_in_bytes  /docker/5a1e18586f7e995c3c02d644eda75e7682118bf16339e0405ba4451fc02d8691
    /docker/5a1e18586f7e995c3c02d644eda75e7682118bf16339e0405ba4451fc02d8691:
    cpuset.cpus: 4-5
    memory.limit_in_bytes: 10485760

或者显示全部变量的信息。 ::

    cgget -g cpuset:/docker/5a1e18586f7e995c3c02d644eda75e7682118bf16339e0405ba4451fc02d8691
    cgget -g memory:/docker/5a1e18586f7e995c3c02d644eda75e7682118bf16339e0405ba4451fc02d8691

如果在容器中运行一个进程，这个进程会在指定核上运行。 ::

    22702  23 root       20   0  105M  9188  2772 S  0.0  0.0  0:02.17 │  ├─ containerd-shim -namespace moby -workdir /var/lib/containerd/io.containerd.runtime.v1.linux/moby/5a1e18586f7e995c3c02d644eda75e7682118
    25094   5 root       20   0 18496  1428  1200 S  0.0  0.0  0:00.07 │  │  ├─ /bin/bash
    25967   5 root       20   0 18364  1604  1320 S  0.0  0.0  0:01.48 │  │  │  └+ bash nothing.sh

申请内存不能申请到超过10M的内存。 ::

    root@5a1e18586f7e:~/user1# ./mem-limit.out
    Starting ...
    Allocated 0 to 1 MB
    Allocated 1 to 2 MB
    Allocated 2 to 3 MB
    Allocated 3 to 4 MB
    Allocated 4 to 5 MB
    Allocated 5 to 6 MB
    Allocated 6 to 7 MB
    Allocated 7 to 8 MB
    Allocated 8 to 9 MB
    Allocated 9 to 10 MB
    Allocated 10 to 11 MB
    Allocated 11 to 12 MB
    Allocated 12 to 13 MB
    Killed


常用命令
===================

.. [#cgroup_kernel] https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v1/
.. [#cgroup_io] https://sysadmincasts.com/episodes/14-introduction-to-linux-control-groups-cgroups