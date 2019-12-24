**********************
bcache
**********************

bcache的回写模式：

writethrough
    既写SSD也写HDD， 读如果命中，就可以直接从SSD中读，适用于读多写少的场景

writearound
    绕过SSD直接写HDD。

writeback
    全部写SSD，后台刷脏数据。



划分bcache分区
===================

.. code-block:: shell

    for ssdname in sdv sdw sdx sdy; do
        parted -a optimal /dev/$ssdname  mkpart primary 2048s 30GiB
        parted -a optimal /dev/$ssdname  mkpart primary 30GiB 60GiB
        parted -a optimal /dev/$ssdname  mkpart primary 60GiB 90GiB
        parted -a optimal /dev/$ssdname  mkpart primary 90GiB 120GiB
        parted -a optimal /dev/$ssdname  mkpart primary 120GiB 150GiB
        parted -a optimal /dev/$ssdname  mkpart primary 150GiB 165GiB
        parted -a optimal /dev/$ssdname  mkpart primary 165GiB 180GiB
        parted -a optimal /dev/$ssdname  mkpart primary 180GiB 195GiB
        parted -a optimal /dev/$ssdname  mkpart primary 195GiB 210GiB
        parted -a optimal /dev/$ssdname  mkpart primary 210GiB 225GiB
        parted -a optimal /dev/$ssdname  mkpart primary 225GiB 358GiB
        parted -a optimal /dev/$ssdname  mkpart primary 358GiB 491GiB
        parted -a optimal /dev/$ssdname  mkpart primary 491GiB 624GiB
        parted -a optimal /dev/$ssdname  mkpart primary 624GiB 757GiB
        parted -a optimal /dev/$ssdname  mkpart primary 757GiB 890GiB
    done

创建bcache
==================

.. code-block:: shell

    make-bcache -C --wipe-bcache /dev/sdv11 -B /dev/sda
    make-bcache -C --wipe-bcache /dev/sdv12 -B /dev/sdb
    make-bcache -C --wipe-bcache /dev/sdv13 -B /dev/sdc
    make-bcache -C --wipe-bcache /dev/sdv14 -B /dev/sdd
    make-bcache -C --wipe-bcache /dev/sdv15 -B /dev/sde

    make-bcache -C --wipe-bcache /dev/sdw11 -B /dev/sdf
    make-bcache -C --wipe-bcache /dev/sdw12 -B /dev/sdg
    make-bcache -C --wipe-bcache /dev/sdw13 -B /dev/sdh
    make-bcache -C --wipe-bcache /dev/sdw14 -B /dev/sdi
    make-bcache -C --wipe-bcache /dev/sdw15 -B /dev/sdj

    make-bcache -C --wipe-bcache /dev/sdx11 -B /dev/sdk
    make-bcache -C --wipe-bcache /dev/sdx12 -B /dev/sdl
    make-bcache -C --wipe-bcache /dev/sdx13 -B /dev/sdm
    make-bcache -C --wipe-bcache /dev/sdx14 -B /dev/sdn
    make-bcache -C --wipe-bcache /dev/sdx15 -B /dev/sdo

    make-bcache -C --wipe-bcache /dev/sdy11 -B /dev/sdp
    make-bcache -C --wipe-bcache /dev/sdy12 -B /dev/sdq
    make-bcache -C --wipe-bcache /dev/sdy13 -B /dev/sdr
    make-bcache -C --wipe-bcache /dev/sdy14 -B /dev/sds
    make-bcache -C --wipe-bcache /dev/sdy15 -B /dev/sdt

删除bcache
====================

.. code-block:: console

    echo 1 > /sys/fs/bcache/04f7ecc3-b55b-4f3d-b843-621acc41c3f7/unregister
    echo 1 > /sys/fs/bcache/05121aa6-45c3-4613-8a5b-f04370f31c21/unregister
    echo 1 > /sys/fs/bcache/0b99a0ac-6dde-49f5-b729-20bc1a815e14/unregister
    echo 1 > /sys/fs/bcache/21777519-de77-4c25-b5e5-da9da3f5ca6f/unregister
    echo 1 > /sys/fs/bcache/2404ebe1-40b9-49dc-b24c-73d9dcc80235/unregister
    echo 1 > /sys/fs/bcache/2535a73f-5538-47d8-b213-903f427134bf/unregister
    echo 1 > /sys/fs/bcache/33028cb9-fc8b-4d61-b9d7-e7728bb25503/unregister
    echo 1 > /sys/fs/bcache/36671630-3c78-443a-8344-6e73fc0a627a/unregister
    echo 1 > /sys/fs/bcache/44193335-016a-4bef-92fa-97d2d87dbb42/unregister
    echo 1 > /sys/fs/bcache/45fd1bde-fae6-4da8-8f61-2f67731a6970/unregister
    echo 1 > /sys/fs/bcache/483ddcc5-1f17-40d4-bc95-bdfd37b3b04c/unregister
    echo 1 > /sys/fs/bcache/53c3b6e8-463c-4cf4-9943-2f9c80a20729/unregister
    echo 1 > /sys/fs/bcache/53ce3bef-23ce-4533-8bbf-1a1d4bd8562d/unregister
    echo 1 > /sys/fs/bcache/5653aaad-ccae-4195-a6e4-cc22a4fe0567/unregister
    echo 1 > /sys/fs/bcache/7826e7fe-dc4d-4b15-a194-f095839ca2f5/unregister
    echo 1 > /sys/fs/bcache/8a015751-3163-4715-9320-0d633fc46e6e/unregister
    echo 1 > /sys/fs/bcache/a333a60f-ae3b-4e8e-8bc0-61707005e7a2/unregister
    echo 1 > /sys/fs/bcache/ac9a2a04-0e12-4bdf-a76b-382e9f1e4e42/unregister
    echo 1 > /sys/fs/bcache/cb5c9671-26a0-4d7a-a765-bcb82960257e/unregister
    echo 1 > /sys/fs/bcache/dcf44cab-5545-4dc6-ad9f-c7ad5d3441ed/unregister



删除bcache之后重新写一遍硬盘dd_wipe_disk.sh

.. code-block:: shell

    #!/bin/bash

    for i in {a..t};
    do
            echo sd$i
            dd if=/dev/zero of=/dev/sd$i bs=1M count=1
    done

    for ssd in v w x y;
    do
            for i in {11..15};
            do
                    echo sd$ssd$i
                    dd if=/dev/zero of=/dev/sd"$ssd""$i" bs=1M count=1
            done
    done




问题记录
===========================

1. 编译bcache工具报错

.. code-block:: console

    make-bcache.c:11:10: fatal error: blkid.h: No such file or directory
    #include <blkid.h>
              ^~~~~~~~~
    compilation terminated.
    make: *** [<builtin>: make-bcache] Error 1

解决办法：

.. code-block:: shell

    yum install libblkid-devel

2. 编译bcache，undefined reference to `crc64'

.. code-block:: console

    [root@localhost bcache-tools-1.0.8]# make
    cc -O2 -Wall -g `pkg-config --cflags uuid blkid`    make-bcache.c bcache.o  `pkg-config --libs uuid blkid` -o make-bcache
    /usr/bin/ld: /tmp/ccMKyCXr.o: in function `write_sb':
    /root/tools/bcache-tools-1.0.8/make-bcache.c:277: undefined reference to `crc64'
    collect2: error: ld returned 1 exit status
    make: *** [<builtin>: make-bcache] Error 1


[#bcache_blog]_ [#kernel_bcache]_

.. [#bcache_blog] https://ypdai.github.io/2018/07/13/bcache%E9%85%8D%E7%BD%AE%E4%BD%BF%E7%94%A8/
.. [#kernel_bcache] https://www.kernel.org/doc/Documentation/bcache.txt


