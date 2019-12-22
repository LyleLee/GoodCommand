**********************
blkdiscard
**********************

blkdiscard可以清除块设备上的分区，对SSD非常有用

.. code-block:: shell

    blkdiscard /dev/sdv
    blkdiscard /dev/sdw
    blkdiscard /dev/sdx
    blkdiscard /dev/sdy

查询硬盘是否支持trim，``DISC-GRAN`` 和 ``DISC-MAX`` 非零表示支持trim

    [root@ceph1 ~]# lsblk --discard
    NAME   DISC-ALN DISC-GRAN DISC-MAX DISC-ZERO
    sda           0        0B       0B         0
    sdb           0        0B       0B         0
    sdc           0        0B       0B         0
    sdd           0        0B       0B         0
    sde           0        0B       0B         0
    sdf           0        0B       0B         0
    sdg           0        0B       0B         0
    sdh           0        0B       0B         0
    sdi           0        0B       0B         0
    sdj           0        0B       0B         0
    sdk           0        0B       0B         0
    sdl           0        0B       0B         0
    sdm           0        0B       0B         0
    sdn           0        0B       0B         0
    sdo           0        0B       0B         0
    sdp           0        0B       0B         0
    sdq           0        0B       0B         0
    sdr           0        0B       0B         0
    sds           0        0B       0B         0
    sdt           0        0B       0B         0
    sdu           0        0B       0B         0
    ├─sdu1        0        0B       0B         0
    ├─sdu2        0        0B       0B         0
    ├─sdu3        0        0B       0B         0
    ├─sdu4        0        0B       0B         0
    └─sdu5        0        0B       0B         0
    sdv           0        4K       2G         0
    sdw           0        4K       2G         0
    sdx           0        4K       2G         0
    sdy           0        4K       2G         0
